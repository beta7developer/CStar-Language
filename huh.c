#include <stdio.h>

// Define a macro that takes one argument (the header name without .h)
#define INCLUDE_HEADER(header_name) <header_name.h>

// Now use another macro with the token pasting operator to make it work
#define MAKE_INCLUDE(header_name) #include INCLUDE_HEADER(header_name)

// Example usage:
MAKE_INCLUDE(stdlib); // Expands to #include <stdlib.h>
MAKE_INCLUDE(string); // Expands to #include <string.h>

int main() {
    // Example usage of a function from one of the included headers (stdlib.h)
    printf("Random number: %d\n", rand());
    return 0;
}