// Transpiled from CStar
#include "ext/stdcstar.h"

#include <csignal>

int newf(int a, int b) {
    return a + b;
}
void signaldetect(int signum) {
    Console.WriteLine("Interrupt signal detected");
    if (signum == SIGSEGV) {
        Console.WriteLine("Segmentation fault (invalid memory reference)");
    } else if (signum == SIGFPE) {
        Console.WriteLine("Floating point exception");
    } else if (signum == SIGINT) {
        Console.WriteLine("Interrupt from keyboard");
    } else if (signum == SIGABRT) {
        Console.WriteLine("Abort signal from abort()");
    } else {
        Console.WriteLine("Unknown signal");
    }
    exit(signum);
}

usingfunc::integerfunc mainfunc() {
    
    
    
        int b;
        int a = newf(5, 10);
        Console.WriteLine(a);
        Console.ReadLine(b);
        callsignal(SIGSEGV);
        signal(SIGSEGV, signaldetect);
        return 0;
}

int main() {
    return mainfunc();
}
