#include "FORTH.h"

void main() {
    for (char c = 32; c < 127; c++) { emit(c); }
    for (;;)
        ;
}

void emit(char c) {}
