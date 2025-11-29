#pragma once

#include <iostream>
#include <string>
#include <vector>
#include <thread>
#include <chrono>

// #define LLI long long int

// Forward declarations
class Out;

class System {
public:
    static Out out;
    static void println(const auto& message) {
        std::cout << message << std::endl;
    }
};

class Out {
public:
    static void println(const auto& message) {
        System::println(message);
    }
};

// Initialize static member (inline to avoid multiple definition errors)
inline Out System::out;

namespace usingfunc {
    using integerfunc = int;
}

namespace cstar25 {
    template<typename T>
    void pinput(T& input, const auto& prompt = "") {
        std::cout << prompt;
        std::cin >> input;
    }
}

namespace cpp20 {
    inline void println(const auto& msg) {
        std::cout << msg << std::endl;
    }
}

class Delay {
    public:
    static void ms(int milliseconds) {
        std::this_thread::sleep_for(std::chrono::milliseconds(milliseconds));
    }
};

inline Delay delay;

using integer = int;
using str = std::string;

// there's returnf keyword (defined in cstcompiler.cpp)
// example:
// returnf int my_function()
// it's just like using int somefunction()
// but is only used in local functions, not main()
#define rtrn return
// I need to figure out how to make returnf get syntax highlighted
// Oh TextMate, but that takes more lines of JSON than my compiler

// Optional helper to wrap argv
inline std::vector<std::string> getArgs(int argc, char* argv[]) {
    std::vector<std::string> args;
    for (int i = 0; i < argc; ++i) {
        args.push_back(argv[i]);
    }
    return args;
}