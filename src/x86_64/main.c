#include "FORTH.h"

int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {
        arg(i, argv[i]);
        yyfile = argv[i];
        assert(yyin = fopen(yyfile, "r"));
        yyparse();
        fclose(yyin);
        yyfile = yynone;
    }
}

void arg(int argc, char *argv) {  //
    fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
}

void yyerror(char *msg) {
    fprintf(stderr, "\n\n%s:%i %s [%s]\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
