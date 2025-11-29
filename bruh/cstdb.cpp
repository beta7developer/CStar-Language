#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <regex>
#include "keywords.h"
#include <windows.h>

bool endsWith(const std::string& str, const std::string& suffix) {
    return str.size() >= suffix.size() &&
           str.compare(str.size() - suffix.size(), suffix.size(), suffix) == 0;
}

int main(int argc, char* argv[]) {
    std::string filename = "testfile.cstar";
    bool compileFlag = false;
    bool usesArgs = false;
    system("clear");

    cout << "\033[1;34mCStar Compiler\033[0m" << endl;
    cout << "Licensed under the \033[1;31mMIT License\033[0m" << endl;

    // Parse command-line arguments
    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "-c") {
            compileFlag = true;
        } else if (endsWith(arg, ".cstar")) {
            filename = arg;
        }
    }

    std::ifstream f(filename);
    if (!f.is_open()) {
        std::cerr << "in \033[1;36mcstcompiler.cpp\033[0m at line 7: error: \033[1mfile not found\033[0m (" << filename << ")" << std::endl;
        return 1;
    }

    std::string cppFilename = filename.substr(0, filename.find_last_of(".")) + ".cpp";
    std::ofstream out(cppFilename);
    out << "// Transpiled from CStar\n";
    out << "#include \"ext/stdcstar.h\"\n\n";

    std::vector<std::string> body;
    std::string line;
    
    while (true) {
        // Check for Ctrl+F5 (common debugger hotkey)
        if ((GetAsyncKeyState(VK_CONTROL) & 0x8000) && 
            (GetAsyncKeyState(VK_SHIFT) & 0x8000) && GetAsyncKeyState('D') & 0x8000) {
            
            std::cout << "Starting debug session..." << std::endl;
            // Your debugger logic here
            Sleep(500); // Prevent spam detection
        
            while (std::getline(f, line)) {
                bool keywordFound = false;

                for (const auto& keyword : keywords) {
                    if (line.find(keyword) != std::string::npos) {
                        std::cout << "Keyword found: " << keyword << " in line: " << line << std::endl;
                        keywordFound = true;
                        break;
                    }
                }

                // Detect argument usage
                if (line.find("argc") != std::string::npos || line.find("argv") != std::string::npos || line.find("args") != std::string::npos) {
                    usesArgs = true;
                }

                // Skip duplicate includes
                if (line.find("#include") != std::string::npos && line.find("ext/stdcstar.h") != std::string::npos) {
                    continue;
                }

                // Skip nested mainfunc definitions
                if (line.find("mainfunc") != std::string::npos && line.find("usingfunc::integerfunc") != std::string::npos) {
                    continue;
                }

                // Fix System.out.println → System::out.println
                std::regex sysRegex(R"(System\.out\.println)");
                line = std::regex_replace(line, sysRegex, "System::out.println");

                // Fix string args declaration
                std::regex strArrayRegex(R"(string\s+args

        \[\d+\]

        \s*=\s*\{)");
                line = std::regex_replace(line, strArrayRegex, "std::string args[] = {");

                body.push_back(line);
            }

            f.close();

            // Write mainfunc signature
            if (usesArgs) {
                out << "usingfunc::integerfunc mainfunc(int argc, char* argv[]) {\n";
            } else {
                out << "usingfunc::integerfunc mainfunc() {\n";
            }

            for (const auto& b : body) {
                out << "    " << b << "\n";
            }

            out << "}\n\n";

            // Write main wrapper
            if (usesArgs) {
                out << "int main(int argc, char* argv[]) {\n    return mainfunc(argc, argv);\n}\n";
            } else {
                out << "int main() {\n    return mainfunc();\n}\n";
            }

            out.close();

            // Compile to .exe if -c flag is present
            if (compileFlag) {
                std::string exeFilename = filename.substr(0, filename.find_last_of(".")) + ".exe";
                std::string compileCommand = "g++ " + cppFilename + " -o " + exeFilename;
                std::cout << "\033[1;34mCompiling...\033[0m\n";
                int result = system(compileCommand.c_str());
                std::string executecommand = exeFilename;

                if (result == 0) {
                    std::cout << "\033[1;32mCompilation successful!\033[0m Output: " << exeFilename << std::endl;
                    system(executecommand.c_str());
                } else {
                    std::cerr << "\033[1;31mCompilation failed.\033[0m\n";
                    return 1;
                }
            }
        }
        // Check for Esc (stop debugging)
        if (GetAsyncKeyState(VK_ESCAPE) & 0x8000) {
            std::cout << "Escape pressed - Stopping debugger!" << std::endl;
            break;
        }
    }
    Sleep(100);
    return 0;
}
