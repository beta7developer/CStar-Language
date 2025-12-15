// Transpiled from CStar
#include "ext/stdcstar.h"

#include <vartypes.h>
#include <ext/sound.h>
#include <stdcstio>


usingfunc::integerfunc mainfunc() {
    
    	POSIXSTR m = "Quite a complex function.";
    	__stdchar_t ch = 'A';
    	__dword dw = 1;
    	__qword qw;
    	__qword qdw = 0x7FFFFFFF;
    	posix_util.posixprintf(true, "#d", qdw);
    	play_sound("D:/Downloads/windows-7-critical-stop.wav");
    	posix_util.posixscanf("#d", qw);
    	while (true) {
    		if (kb.retchkbd()) {
    			int c = kb.reckbd('\0', false);
    			if (c == ch || c == 'a') break;
    		}
    	}
    	posix_util.posixprintf(true, "#d", qw);
    	posix_util.posixprintf(false, "#d", dw);
    	posix_util.posixprintf(true, "#c", ch);
    	posix_util.posixprintf(false, "#s", m);
    	rtrn EXIT_S;
}

int main() {
    return mainfunc();
}
