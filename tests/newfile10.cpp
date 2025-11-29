// Transpiled from CStar
#include "ext/stdcstar.h"

#include <iostream>
#include <vector>
#include <string>
#include <stdio.h>
#include <random_header>
#include <cmath>
#include <ext/defined.h>

int add(int a, int b) {
	return a + b;
}
int sub(int a, int b) {
	return a - b;
}
void printmsg(string msg) {
	cout << msg;
}

usingfunc::integerfunc mainfunc() {
    
    using namespace std;
    using namespace cstar25;
    using namespace cpp20;
    
    
    
    
    char* message = "Hello";
    string messagestr = "Hello";
    
    	delay.ms(1000);
    	int x, y;
    	cout << "Input: ";
    	cin >> x >> y;
    	cout << el << add(x, y) << space << sub(x, y) << space;
    	printmsg(message);
    	cout << el;
    	printf("%s", message);
    	cout << el << messagestr << el;
    	printf("%.17f\n", sqrt(2));
    	rtrn 0;
}

int main() {
    return mainfunc();
}
