#include "all.h"

void args(int argc, char *argv[]) {
    for (int i=0;i<argc;i++) printf("argv[%i] = [%s]\n",i,argv[i]);
    printf("\n");
}

BYTE  M[Msz];               // main Memory
UCELL Cp=0;                 // Compilation Pointer
