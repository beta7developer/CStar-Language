// Transpiled from CStar
#include "ext/stdcstar.h"

#include <random_header>
#include <cstdlib>


usingfunc::integerfunc mainfunc() {
    
    st::adv_array<int> myArray;
    
        myArray.push(1);
        myArray.push(2);
        std::cout << "Array contents: ";
        myArray.dump();
        sys.cexit(0);
}

int main() {
    return mainfunc();
}
