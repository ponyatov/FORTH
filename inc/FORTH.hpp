#pragma once

extern int yylex();
extern int yylineno;
extern int yyparse();
extern void yyerror(const char *msg);
#include "FORTH.yacc.hpp"
