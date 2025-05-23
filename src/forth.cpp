#include "forth.hpp"

int main(int argc, char* argv[]) {  //
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {  //
        yyfile = argv[i];
        arg(i, yyfile);
        assert(yyin = fopen(yyfile, "r"));
        fclose(yyin);
        yyfile = nullptr;
    }
}

void arg(int argc, char* argv) {  //
    fprintf(stderr, "arg[%i] = <%s>\n", argc, argv);
}

void yyerror(char* msg) {  //
    fprintf(stderr, "\n\n%s:%n %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
