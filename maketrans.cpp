#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <algorithm>
#include <cctype>

static inline std::string trim(const std::string &s) {
    size_t a = 0;
    while (a < s.size() && std::isspace((unsigned char)s[a])) ++a;
    size_t b = s.size();
    while (b > a && std::isspace((unsigned char)s[b-1])) --b;
    return s.substr(a, b - a);
}

static inline std::string extractVarName(const std::string &left) {
    // left may be like "(STRING)TARGET" or " (STRING) TARGET "
    std::string t = left;
    // remove trailing/leading whitespace
    t = trim(t);
    // if contains ')', take substring after last ')'
    auto pos = t.find_last_of(')');
    if (pos != std::string::npos && pos + 1 < t.size()) {
        return trim(t.substr(pos + 1));
    }
    // otherwise, take last token
    size_t i = t.find_last_not_of(" \t");
    if (i == std::string::npos) return t;
    size_t j = t.find_last_of(" \t", i);
    if (j == std::string::npos) return t.substr(0, i+1);
    return trim(t.substr(j+1, i-j));
}

static inline std::string extractConsoleString(const std::string &line) {
    // find first quote "
    auto p = line.find('"');
    if (p == std::string::npos) return "";
    auto q = line.find('"', p + 1);
    if (q == std::string::npos) return "";
    return line.substr(p + 1, q - p - 1);
}

static inline std::string replaceVars(const std::string &cmd, const std::map<std::string,std::string> &vars) {
    std::string out;
    size_t i = 0;
    while (i < cmd.size()) {
        if (cmd[i] == '$' && i + 1 < cmd.size() && cmd[i+1] == '(') {
            size_t j = cmd.find(')', i+2);
            if (j != std::string::npos) {
                std::string key = cmd.substr(i+2, j - (i+2));
                auto it = vars.find(key);
                if (it != vars.end()) out += it->second;
                // else leave empty
                i = j + 1;
                continue;
            }
        }
        out += cmd[i++];
    }
    return out;
}

int main(int argc, char* argv[]) {
    // --version / -v support
    if (argc >= 2) {
        std::string firstArg = argv[1];
        if (firstArg == "--version" || firstArg == "-v") {
            std::cout << "maketrans 1.0.0\n";
            return 0;
        }
    }

    if (argc < 2) {
        std::cerr << "Usage: maketrans <CStarMake.cmp>\n";
        return 1;
    }

    std::string path = argv[1];
    std::ifstream in(path);
    if (!in.is_open()) {
        std::cerr << "Failed to open: " << path << "\n";
        return 1;
    }

    std::map<std::string,std::string> vars;
    std::vector<std::string> lines;
    std::string line;
    while (std::getline(in, line)) {
        lines.push_back(line);
        // simple var assignment detection: look for '=' on a line that contains no leading "def"
        auto eq = line.find('=');
        if (eq != std::string::npos) {
            std::string left = trim(line.substr(0, eq));
            std::string right = trim(line.substr(eq + 1));
            if (!left.empty() && !right.empty()) {
                std::string name = extractVarName(left);
                // strip surrounding quotes from right if present
                if (right.size() >= 2 && ((right.front() == '"' && right.back() == '"') || (right.front() == '\'' && right.back() == '\'')))
                    right = right.substr(1, right.size()-2);
                vars[name] = right;
            }
        }
    }
    in.close();

    // parse simple def blocks: compile and run
    std::vector<std::string> compileBlock;
    std::vector<std::string> runBlock;
    enum { NONE, COMPILE, RUN } state = NONE;
    for (size_t i = 0; i < lines.size(); ++i) {
        std::string l = trim(lines[i]);
        if (l.rfind("def compile:", 0) == 0) { state = COMPILE; continue; }
        if (l.rfind("def run:", 0) == 0) { state = RUN; continue; }
        if (l.rfind("__init__", 0) == 0) break;
        if (l.rfind("def ", 0) == 0) { state = NONE; continue; }
        if (state == COMPILE) {
            if (!l.empty()) compileBlock.push_back(l);
        } else if (state == RUN) {
            if (!l.empty()) runBlock.push_back(l);
        }
    }

    // extract console() commands from compile block (take first console() found)
    std::string compileCmd;
    for (auto &b : compileBlock) {
        if (b.find("console(") != std::string::npos) {
            compileCmd = extractConsoleString(b);
            break;
        }
    }

    // extract console() for run block, honoring #ifdef _WIN32 / else
    std::string runCmdWindows, runCmdElse, runCmdDefault;
    bool inIf = false;
    bool inElse = false;
    for (auto &b : runBlock) {
        std::string tb = trim(b);
        if (tb.rfind("#ifdef _WIN32", 0) == 0) { inIf = true; inElse = false; continue; }
        if (tb.rfind("#else", 0) == 0) { inElse = true; inIf = false; continue; }
        if (tb.rfind("#endif", 0) == 0) { inIf = inElse = false; continue; }
        if (tb.find("console(") != std::string::npos) {
            std::string s = extractConsoleString(tb);
            if (inIf) runCmdWindows = s;
            else if (inElse) runCmdElse = s;
            else runCmdDefault = s;
        }
    }

    // perform variable substitution
    if (!compileCmd.empty()) compileCmd = replaceVars(compileCmd, vars);
    if (!runCmdWindows.empty()) runCmdWindows = replaceVars(runCmdWindows, vars);
    if (!runCmdElse.empty()) runCmdElse = replaceVars(runCmdElse, vars);
    if (!runCmdDefault.empty()) runCmdDefault = replaceVars(runCmdDefault, vars);

    // Execute compile
    if (!compileCmd.empty()) {
        std::cout << "[maketrans] Running compile: " << compileCmd << "\n";
        int rc = system(compileCmd.c_str());
        if (rc != 0) {
            std::cerr << "[maketrans] Compile command failed with code " << rc << "\n";
            return rc;
        }
    } else {
        std::cerr << "[maketrans] No compile command found.\n";
    }

    // Execute run: choose appropriate command based on platform
    std::string runCmdToUse;
    #ifdef _WIN32
        if (!runCmdWindows.empty()) runCmdToUse = runCmdWindows;
        else if (!runCmdDefault.empty()) runCmdToUse = runCmdDefault;
        else if (!runCmdElse.empty()) runCmdToUse = runCmdElse;
    #else
        if (!runCmdElse.empty()) runCmdToUse = runCmdElse;
        else if (!runCmdDefault.empty()) runCmdToUse = runCmdDefault;
        else if (!runCmdWindows.empty()) runCmdToUse = runCmdWindows;
    #endif

    if (!runCmdToUse.empty()) {
        std::cout << "[maketrans] Running: " << runCmdToUse << "\n";
        int rc = system(runCmdToUse.c_str());
        if (rc != 0) {
            std::cerr << "[maketrans] Run command exited with code " << rc << "\n";
            return rc;
        }
    } else {
        std::cerr << "[maketrans] No run command found.\n";
    }

    return 0;
}