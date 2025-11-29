# stdcstio - reckbd() and retchkbd()

reckbd - A function that receives keyboard input from the user

Syntax:
```cpp
static int __cdecl reckbd(char c, bool cprint);
```

- Its purpose: Waits for keyboard input; if the pressed key matches the designated character (`c` parameter) or `c == '\0'` (accept any key), returns the character cast to an integer.
- If `cprint` is `true`, the pressed character is echoed to the console; if `false`, it is not echoed.

Example usage:
```cpp
#include <ext/stdcstar.h>
#include <stdcstio>
#include <iostream>

using int main() {
    char desch = 'A';
    std::cout << "Press 'A' to continue: ";
    while (true) {
        int c = kb.reckbd('\0', false); // blocking read (consumes key)
        if (c == desch) {
            std::cout << std::endl << "You pressed: " << static_cast<char>(c);
            break;
        }
    }
    return EXIT_S; // returns 0
}
```

retchkbd - A conditional function that checks for pending keyboard input without blocking.

Syntax:
```cpp
static bool __cdecl retchkbd();
```

- Its purpose: Poll whether a key is available to read without waiting. Returns `true` if a key is waiting; `false` otherwise.
- It does not consume the key; call `reckbd()` to read/consume the available key.

Example usage:
```cpp
#include <iostream>
#include <stdcstio>
#include <thread>
#include <chrono>

using int main() {
    std::cout << "Do stuff while waiting for 'q'...";
    while (true) {
        // Do non-blocking work
        std::cout << ".";
        std::fflush(stdout);

        // Check if a key was pressed (non-blocking)
        if (kb.retchkbd()) {
            // A key is ready — read and consume it
            int ch = kb.reckbd('\0', true);
            if (ch == 'q') break;
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
    return 0;
}
```

Notes:
- `retchkbd()` is analogous to `_kbhit()` on Windows and uses `ioctl(FIONREAD)`/`select()` on POSIX.
- `reckbd()` is blocking and consumes input; `retchkbd()` only checks availability.
- On POSIX implementations `reckbd()` temporarily disables canonical mode and restores terminal state after reading. Keep that in mind if mixing with other stdin reads.