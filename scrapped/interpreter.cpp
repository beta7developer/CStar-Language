#include <iostream>
#include <cstdlib>
#include <string>
#include <fstream>

using namespace std;

int main()
{
    // Clear the file at the start of the session
    ofstream clearFile("interpreted.cstar", ios::out);
    clearFile.close();

    string input;
    while (true) {
        cout << ">>> ";
        getline(cin, input);

        if (input == "exit" || input == "quit") {
            break;
        } else if (input == "-c") {
            string command = "cstarc interpreted.cstar -c";
            system(command.c_str());
            // Clear the file after compilation
            ofstream clearFile("interpreted.cstar", ios::out);
        } else if (!input.empty()) {
            ofstream outFile("interpreted.cstar", ios::app);
            if (!outFile) {
                cerr << "Error: Cannot open interpreted.cstar for writing." << endl;
                break;
            }
            outFile << input << endl;
            outFile.close();
        }
    }
    return 0;
}