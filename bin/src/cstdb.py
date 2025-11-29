import sys
import os
import re
import time
import subprocess
import platform

# Import the custom keywords module as requested.
# This replaces the C++ `keywords.h` header.
import keywords

# --- Platform-specific key detection ---
# The original C++ code used `windows.h` for `GetAsyncKeyState`.
# For cross-platform key detection in Python, a library like 'keyboard' is commonly used.
# You might need to install it: pip install keyboard
try:
    import keyboard
    _HAS_KEYBOARD = True
except ImportError:
    _HAS_KEYBOARD = False
    print("Warning: 'keyboard' module not found. Interactive hotkey features will be disabled.")
    print("Install it with: pip install keyboard")

# --- Utility functions ---

def clear_console():
    """Clears the terminal screen."""
    os.system('cls' if os.name == 'nt' else 'clear')

def ends_with(s: str, suffix: str) -> bool:
    """Checks if a string ends with a given suffix."""
    return s.endswith(suffix)

# --- Main logic ---

def main():
    """Main function for the CStar transpiler/compiler."""
    filename = "testfile.cstar"
    compile_flag = False
    version_flag = False
    uses_args = False

    clear_console()

    # ANSI escape codes for colored output, mimicking C++ `cout`
    BLUE = "\033[1;34m"
    RED = "\033[1;31m"
    GREEN = "\033[1;32m"
    CYAN = "\033[1;36m"
    BOLD = "\033[1m"
    RESET = "\033[0m"

    print(f"{BLUE}{BOLD}CStar Debugger{RESET}")
    print(f"Licensed under the {RED}MIT License{RESET}")

    # Parse command-line arguments
    # sys.argv[0] is the script name itself, so we iterate from index 1.
    for arg in sys.argv[1:]:
        if arg == "-c":
            compile_flag = True
        elif arg == "--version" or arg == "-v":
            version_flag = True
        elif ends_with(arg, ".cstar"):
            filename = arg

    # Attempt to open the input CStar file
    try:
        f = open(filename, 'r')
    except FileNotFoundError:
        sys.stderr.write(f"in {CYAN}cstdb.py{RESET} at line ?: error: {RED}{BOLD}file not found{RESET} ({filename})\n")
        sys.exit(1)

    # Determine the output C++ filename (e.g., "testfile.cstar" -> "testfile.cpp")
    cpp_filename = os.path.splitext(filename)[0] + ".cpp"
    out = open(cpp_filename, 'w')

    # Write initial C++ boilerplate
    out.write("// Transpiled from CStar\n")
    out.write("#include \"ext/stdcstar.h\"\n\n")

    if version_flag:
        print("CStar Debugger version 1.4.3")
        exit(0)

    body = [] # Stores processed lines of the CStar file

    # The original C++ code had a `while(true)` loop polling for key presses.
    # The core logic (file processing, writing, compilation) was inside an
    # `if` block triggered by Ctrl+Shift+D. This implies an interactive debugger mode.
    # We will replicate this interactive behavior if the 'keyboard' module is available.

    print("\nWaiting for hotkey to start transpilation/compilation:")
    print(f"  Press {BOLD}Ctrl+Shift+D{RESET} to start debug session (transpile and compile).")
    print(f"  Press {BOLD}Esc{RESET} to exit the program.")

    transpilation_done = False # Flag to ensure transpilation runs only once per hotkey press

    while True:
        if _HAS_KEYBOARD:
            # Check for Ctrl+Shift+D to start the debug/transpilation session
            if keyboard.is_pressed('ctrl+shift+d'):
                if not transpilation_done:
                    print("\nStarting debug session (transpiling and compiling)...")
                    time.sleep(0.5) # Debounce: prevent multiple triggers from a single press

                    # Reset file pointer to the beginning for processing, in case it was read before
                    f.seek(0)
                    
                    for line in f:
                        line = line.rstrip('\n') # Remove trailing newline for processing

                        # Keyword detection
                        keyword_found = False
                        for keyword_item in keywords.keywords: # Access keywords from the imported module
                            if keyword_item in line:
                                print(f"Keyword found: {keyword_item} in line: {line}")
                                keyword_found = True
                                break # As in C++, break after the first keyword is found

                        # Detect argument usage (argc, argv, or args)
                        if "argc" in line or "argv" in line or "args" in line:
                            uses_args = True

                        # Skip duplicate includes of "ext/stdcstar.h"
                        if "#include" in line and "ext/stdcstar.h" in line:
                            continue

                        # Skip nested mainfunc definitions (if both "mainfunc" and "usingfunc::integerfunc" are on the same line)
                        if "mainfunc" in line and "usingfunc::integerfunc" in line:
                            continue

                        # Fix System.out.println -> System::out.println using regex
                        line = re.sub(r"System\.out\.println", "System::out.println", line)

                        # Fix string args declaration
                        # The original C++ regex `R"(string\s+args\n\s*\[ \d+ \]\n\s*=\s*\{)"`
                        # would never match a single line read by `std::getline` due to explicit `\n`.
                        # Assuming the intent was for a single-line declaration, we adjust the regex.
                        str_array_regex = r"string\s+args\s*\[ \d+ \]\s*=\s*\{"
                        line = re.sub(str_array_regex, "std::string args[] = {", line)

                        body.append(line)
                    
                    f.close() # Close input file after reading all lines

                    # Write mainfunc signature based on argument usage
                    if uses_args:
                        out.write("usingfunc::integerfunc mainfunc(int argc, char* argv[]) {\n")
                    else:
                        out.write("usingfunc::integerfunc mainfunc() {\n")

                    # Write the processed body lines
                    for b_line in body:
                        out.write(f"    {b_line}\n")

                    out.write("}\n\n")

                    # Write the standard C++ main wrapper
                    if uses_args:
                        out.write("int main(int argc, char* argv[]) {\n    return mainfunc(argc, argv);\n}\n")
                    else:
                        out.write("int main() {\n    return mainfunc();\n}\n")

                    out.close() # Close output C++ file

                    transpilation_done = True # Mark that transpilation has occurred

                    # Compile to .exe if the -c flag was present
                    if compile_flag:
                        exe_filename = os.path.splitext(filename)[0] + ".exe"
                        # Construct the g++ compile command
                        compile_command = f"g++ {cpp_filename} -o {exe_filename}"
                        print(f"{BLUE}Compiling...{RESET}")
                        
                        try:
                            # Use subprocess.run for robust command execution and error handling
                            result = subprocess.run(compile_command, shell=True, check=True, 
                                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
                            print(f"{GREEN}Compilation successful!{RESET} Output: {exe_filename}")
                            if result.stdout:
                                print(result.stdout) # Print compiler stdout
                            
                            # Execute the compiled program
                            print(f"Executing: {exe_filename}")
                            # Use "./" prefix for executables on non-Windows systems
                            execute_command = f"./{exe_filename}" if platform.system() != "Windows" else exe_filename
                            subprocess.run(execute_command, shell=True)

                        except subprocess.CalledProcessError as e:
                            sys.stderr.write(f"{RED}Compilation failed.{RESET}\n")
                            sys.stderr.write(e.stderr) # Print compiler stderr
                            sys.exit(1)
                        except FileNotFoundError:
                            sys.stderr.write(f"{RED}Error: g++ not found. Please ensure g++ is installed and in your PATH.{RESET}\n")
                            sys.exit(1)
                    else:
                        print(f"Transpilation complete. Output written to {cpp_filename}")
                else:
                    print("Transpilation already completed. Press Esc to exit.")
                
                # Debounce the hotkey press
                time.sleep(0.5)

            # Check for Esc key press to exit the program
            if keyboard.is_pressed('esc'):
                print("Escape pressed - Stopping program!")
                time.sleep(0.5)
                clear_console()
                break
        else:
            # If the 'keyboard' module is not available, run the transpilation directly
            # without waiting for hotkeys. This ensures functionality even without the dependency.
            print("Keyboard module not available. Running transpilation directly...")
            
            # Re-open the file if it was closed or not opened yet, and ensure we start from the beginning
            try:
                f = open(filename, 'r')
            except FileNotFoundError:
                sys.stderr.write(f"in {CYAN}cstcompiler.py{RESET} at line ?: error: {BOLD}file not found{RESET} ({filename})\n")
                sys.exit(1)
            
            f.seek(0) # Ensure we start from the beginning of the file
            
            for line in f:
                line = line.rstrip('\n')

                keyword_found = False
                for keyword_item in keywords.keywords:
                    if keyword_item in line:
                        print(f"Keyword found: {keyword_item} in line: {line}")
                        keyword_found = True
                        break

                if "argc" in line or "argv" in line or "args" in line:
                    uses_args = True

                if "#include" in line and "ext/stdcstar.h" in line:
                    continue

                if "mainfunc" in line and "usingfunc::integerfunc" in line:
                    continue

                line = re.sub(r"System\.out\.println", "System::out.println", line)
                str_array_regex = r"string\s+args\s*\[ \d+ \]\s*=\s*\{"
                line = re.sub(str_array_regex, "std::string args[] = {", line)

                body.append(line)
            
            f.close()
            
            if uses_args:
                out.write("usingfunc::integerfunc mainfunc(int argc, char* argv[]) {\n")
            else:
                out.write("usingfunc::integerfunc mainfunc() {\n")

            for b_line in body:
                out.write(f"    {b_line}\n")

            out.write("}\n\n")

            if uses_args:
                out.write("int main(int argc, char* argv[]) {\n    return mainfunc(argc, argv);\n}\n")
            else:
                out.write("int main() {\n    return mainfunc();\n}\n")

            out.close()

            if compile_flag:
                exe_filename = os.path.splitext(filename)[0] + ".exe"
                compile_command = f"g++ {cpp_filename} -o {exe_filename}"
                print(f"{BLUE}Compiling...{RESET}")
                
                try:
                    result = subprocess.run(compile_command, shell=True, check=True, 
                                            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
                    print(f"{GREEN}Compilation successful!{RESET} Output: {exe_filename}")
                    if result.stdout:
                        print(result.stdout)
                    
                    print(f"Executing: {exe_filename}")
                    execute_command = f"./{exe_filename}" if platform.system() != "Windows" else exe_filename
                    subprocess.run(execute_command, shell=True)

                except subprocess.CalledProcessError as e:
                    sys.stderr.write(f"{RED}Compilation failed.{RESET}\n")
                    sys.stderr.write(e.stderr)
                    sys.exit(1)
                except FileNotFoundError:
                    sys.stderr.write(f"{RED}Error: g++ not found. Please ensure g++ is installed and in your PATH.{RESET}\n")
                    sys.exit(1)
            else:
                print(f"Transpilation complete. Output written to {cpp_filename}")
            
            # Exit after direct execution if keyboard module is not present
            break

        time.sleep(0.1) # Small delay to prevent high CPU usage in the polling loop

    sys.exit(0) # Exit successfully

if __name__ == "__main__":
    main()
