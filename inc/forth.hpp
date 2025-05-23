#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

extern int main(int argc, char* argv[]);
extern void arg(int argc, char* argv);

extern int yylex();
extern int yylineno;
extern char *yytext;
extern char *yyfile;
extern FILE* yyin;
extern int yyparse();
extern void yyerror(char *msg);
#include "forth.yacc.hpp"
