#include <cstdlib>
#include <iostream>
#include <fstream>
#include <string>

int main(int argc, char **argv) {
    std::string filename = "i686-ext-test.i686";

    // Accept optional positional filename and simple flags
    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "-v" || arg == "--version") {
            std::cout << "i686runner version 1.0.0\n";
            return 0;
        }
        if (arg == "-h" || arg == "--help") {
            std::cout << "Usage: i686runner [-v] [file]\n";
            return 0;
        }
        // first non-flag argument is treated as filename
        if (!arg.empty() && arg[0] != '-') {
            filename = arg;
        }
    }

    std::ifstream f(filename);
    if (!f.is_open()) {
        std::cerr << "I686 file not found: " << filename << std::endl;
        return 1;
    }
    f.close();

    int rc = 0;
    #ifdef _WIN32
        // On Windows just execute the file (quote the path)
        std::string execCmd = "\"" + filename + "\"";
        rc = std::system(execCmd.c_str());
    #else
        // On POSIX ensure executable bit and run via ./filename
        std::string chmodCmd = "chmod +x \"" + filename + "\"";
        rc = std::system(chmodCmd.c_str());
        if (rc == 0) {
            std::string execCmd = "./\"" + filename + "\"";
            // Some shells don't like ./\"file\" — use safer concatenation
            execCmd = "chmod +x \"" + filename + "\" && ./\"" + filename + "\"";
            rc = std::system(execCmd.c_str());
        }
    #endif

    if (rc != 0) {
        std::cerr << "Execution failed (code " << rc << ")\n";
        return rc;
    }

    return 0;
}