#include "vm.h"

 BYTE M[Msz];               // main Memory
UCELL Cp=0;                 // Compilation Pointer
#ifdef VM
UCELL Ip=0;                 // Instruction Pointer
UCELL R[Rsz]; UCELL Rp=0;   // Return stack
 CELL D[Dsz]; BYTE  Dp=0;   // Data stack
#endif // VM

void args(int argc, char *argv[]) {
    for (int i=0;i<argc;i++) printf("argv[%i] = [%s]\n",i,argv[i]);
    printf("\n");
}

#ifdef VM
int main(int argc, char *argv[]) {
    // args
    assert(argc>=2);
    args(argc,argv);
    // load byte-code
    FILE *img = fopen(argv[1],"rb"); assert(img);
    assert(fread(M,1,Msz,img)); fclose(img);
    // run interpreter
    return 0;
}
#endif // VM
