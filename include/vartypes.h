/*
Variable keyword typenames for CStar.
Carefully guarded to avoid platform conflicts.
*/

#ifndef USTDLIB_VAR_TYPES_H
#define USTDLIB_VAR_TYPES_H 1

#warning "vartypes.h: Use these aliases carefully."

#include <cstdint>

#define var auto
#define def auto

// byte: use namespace on MinGW to avoid platform conflicts
#if !defined(VARTYPES_FORCE_BYTE)
    #if defined(__MINGW32__) || defined(__MINGW64__) || defined(__CYGWIN__)
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

// 64-bit signed/unsigned
#ifndef ULLI
using ULLI = std::uint64_t;
#endif

#ifndef LLI
using LLI = std::int64_t;
#endif

// eightbyte: alias for int64_t
#ifndef DEF_EIGHTBYTE
using eightbyte = std::int64_t;
#define DEF_EIGHTBYTE
#endif

// Standard char type
using __stdchar_t = char;

// Windows-specific types (use unqualified so transpiler can emit them directly)
#ifdef _WIN32
    #ifndef __dword
    typedef std::int32_t __dword;
    #endif
    #ifndef __udword
    typedef std::uint32_t __udword;
    #endif
    #ifndef __qword
    typedef std::int64_t __qword;
    #endif
    #ifndef __uqword
    typedef std::uint64_t __uqword;
    #endif
    #ifndef __str
    typedef const char* __str;
    #endif
#else
    // On non-Windows, provide these anyway (as aliases) so code compiles
    #ifndef __dword
    typedef std::int32_t __dword;
    #endif
    #ifndef __udword
    typedef std::uint32_t __udword;
    #endif
    #ifndef __qword
    typedef std::int64_t __qword;
    #endif
    #ifndef __uqword
    typedef std::uint64_t __uqword;
    #endif
    #ifndef __str
    typedef const char* __str;
    #endif
#endif

#endif // USTDLIB_VAR_TYPES_H