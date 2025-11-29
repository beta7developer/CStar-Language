#include <iostream>
#include <string>
#include <fstream>
#include <filesystem>
#include <thread>
#include <chrono>

using namespace std;

string command;

string compilerinstallationcommand = "pacman -S cstarc.exe --windows";

int main()
{
    filesystem::path source = "D:\\CStar\\cstarc.exe";
    filesystem::path destination = "D:\\CStar\\packages\\cstarc.exe";

    string filename = "cstarc.exe";

    while (true) {
        cout << "Copyright (C) August 2025 Hoang Viet. All rights reserved." << endl;
        cout << endl << "CStar UCRT64" << endl;
        cout << endl << "D:/CStar/" << endl;
        cout << ">> ";
        getline(cin, command);
        if (command == compilerinstallationcommand)
        {
            try
            {
                cout << "Installing " << filename << "..." << endl;
                filesystem::copy_file(source, destination, filesystem::copy_options::overwrite_existing);
                this_thread::sleep_for(chrono::seconds(2));
                cout << "Installed package: " << filename << "." << endl;
            }
            catch (const filesystem::filesystem_error& e)
            {
                cerr << "bash: pacman_error: package not found" << endl;
            }
        }
    }
}