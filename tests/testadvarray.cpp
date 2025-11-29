// Transpiled from CStar
#include "ext/stdcstar.h"

#include <iostream>
#include <random_header>
#include <string>
#include <ext/defined.h>


usingfunc::integerfunc mainfunc() {
    
    using namespace std;
    
        st::adv_array<string> arr;
        arr.push("Hello");
        arr.push("World");
    
        for (size_t i = 0; i < arr.length(); ++i) {
            cout << arr[i] << space;
        }
        rtrn 0;
}

int main() {
    return mainfunc();
}
