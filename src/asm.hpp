#ifndef _H_ASM
#define _H_ASM

#include "vm.h"

extern int  yylex();                    // lexer interface
extern char *yytext;                    // lexeme string
extern int  yylineno;                   // current line

extern int yyparse();                   // parser interface
extern void yyerror(const char *msg);   // error callback
#include "tmp/parser.hpp"

extern void CB(BYTE b);                 // Compile Byte

#endif // _H_ASM
