#include "asm.hpp"

#ifdef ASM
int main(int argc, char *argv[]) {
    // check args: at least one source code file in .4th
    assert(argc>=2); args(argc,argv);
    // parse source code
    // FILE *src = fopen(argv[2],"r"); assert(src); yyinput(src); 
    yyparse();
    // always put final BYE
    CB(BYE);
    // write compiled
    FILE *img = fopen(argv[1],"wb"); assert(img);
    assert(fwrite(M,Cp,1,img)); fclose(img);
    // done
    return 0;
}
#endif // ASM

void yyerror(const char *msg) {
    fprintf(stdout,"\n\n%i: %s [%s]\n\n",yylineno,msg,yytext);
    fprintf(stderr,"\n\n%i: %s [%s]\n\n",yylineno,msg,yytext);
    exit(-1);
}

void CB(BYTE b) {                                   // Compile Byte
    M[Cp++] = b; assert(Cp<Msz);
}

void CC(CELL c) {                                   // Compile Cell
    *((CELL*)&M[Cp]) = c;       // only for little-endians
    Cp += 2; assert(Cp<Msz);
}
