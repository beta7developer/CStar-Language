/*
Variable keyword typenames.

Yeah.
*/

#ifndef USTDLIB_VAR_TYPES_H
#define USTDLIB_VAR_TYPES_H 1

#warning "Use it carefully."

#include <cstdint>

#define var auto
#define def auto

// byte. Most complex part for now.
#if !defined(VARTYPES_FORCE_BYTE)
    #if defined(__MINGW32__) || defined(__MINGW64__) || defined(__CYGWIN__)
        // frick it, namespace then, not going Arduino style
        namespace cstarv {
            using byte = std::uint8_t;
        }
    #else
        using byte = std::uint8_t;
        #define DEF_VARTYPES_BYTE
    #endif
#else
    using byte = std::uint8_t;
    #define DEF_VARTYPES_BYTE
#endif

#ifndef ULLI
using ULLI = std::uint64_t;
#define ULLI
#endif

#ifndef LLI
using LLI = std::int64_t;
#define LLI
#endif

// eightbyte
#ifndef DEF_EIGHTBYTE
using eightbyte = std::int64_t;
#define DEF_EIGHTBYTE
#endif

typedef char __stdchar_t;

#ifdef _WIN32
    namespace windows {
        #ifndef _WIN_NT
        #define _WIN_NT 1
            typedef int32_t __dword;
            typedef uint32_t __udword;
            typedef int64_t __qword;
            typedef uint64_t __uqword;
            typedef const char* __str;
        #endif
    }
#endif

#endif