#include "src/vm.h"

 BYTE M[Msz];               // main Memory
UCELL Cp=0;                 // Compilation Pointer
#ifdef VM
UCELL Ip=0;                 // Instruction Pointer
 BYTE Op=0;                 // Instruction OPcode
UCELL R[Rsz]; UCELL Rp=0;   // Return stack
  int D[Dsz]; BYTE  Dp=0;   // Data stack (with native cell size)
#endif // VM

char **argsv;
void args(int argc, char *argv[]) {
    argsv = argv;
    for (int i=0;i<argc;i++) printf("argv[%i] = [%s]\n",i,argv[i]);
}

#ifndef ASM

void unk()  { fprintf(stderr,"\tunknown command\n\n"); abort(); }
void nop()  { fprintf(stderr,"\tnop"); }
void bye()  { fprintf(stderr,"\tbye\n\n"); exit(0); }

void jmp()  { Ip = *((UCELL*)&M[Ip]); fprintf(stderr,"jmp %.4X",Ip); }

void interpreter() {
    for (uint tick=0;;tick++) {                 // VM commands counter
        assert(TICK_LIMIT);                     // per-command checks
        assert(Ip<Msz);
        Op = M[Ip++];                               // command fetch
        fprintf(stderr,"\n%.4X: %.2X ",Ip-1,Op);    // trace
                                                    // command decode
        switch (Op) {                               // command run
            case NOP:  nop();  break;
            case BYE:  bye();  break;
            case JMP:  jmp();  break;
            case KEY:  key();  break;
            case EMIT: emit(); break;

            case SDL:  ext_sdl();  break;

            default: unk();
        }
    }
}

int main(int argc, char *argv[]) {
    // args
    assert(argc>=2);
    args(argc,argv);
    // system-dependent init
    os_init();
    // load byte-code
    FILE *img = fopen(argv[1],"rb"); assert(img);
    assert(Cp=fread(M,1,Msz,img)); fclose(img);
    // run
    interpreter();
    return 0;
}

#endif // ASM
