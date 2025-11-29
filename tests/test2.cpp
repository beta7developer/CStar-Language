// Transpiled from CStar
#include "ext/stdcstar.h"

#include <cstar.h>
#include <cmath>


usingfunc::integerfunc mainfunc() {
    
    using namespace std;
    
    char options;
    LLI num1, num2, result;
    
    {
        cstar25::pinput(options, "Enter in an option: ");
        cstar25::pinput(num1, "Enter in the first number: ");
        cstar25::pinput(num2, "Enter in the second number: ");
        switch (options) {
            case '+':
                result = num1 + num2;
                System::out.println("The result is: " + to_string(result));
                break;
            case '-':
                result = num1 - num2;
                System::out.println("The result is: " + to_string(result));
                break;
            case '*':
                result = num1 * num2;
                System::out.println("The result is: " + to_string(result));
                break;
            case '/':
                if (num2 == 0) {
                    System::out.println("Error: Division by zero is not allowed.");
                } else {
                    result = num1 / num2;
                    System::out.println("The result is: " + to_string(result));
                }
                break;
            default:
                System::out.println("Invalid option. Please use +, -, *, or /.");
                break;
        }
        return 0;
}

int main() {
    return mainfunc();
}
