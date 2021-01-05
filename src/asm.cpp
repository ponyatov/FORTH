#include "asm.hpp"

void CB(BYTE b) {
    printf("%.4X: %.2X\n",Cp,b);
    M[Cp++] = b; assert(Cp<Msz);
}

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

void yyerror(const char *msg) {
    fprintf(stdout,"\n\n%i: %s [%s]\n\n",yylineno,msg,yytext);
    fprintf(stderr,"\n\n%i: %s [%s]\n\n",yylineno,msg,yytext);
    exit(-1);
}
