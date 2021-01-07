#ifndef _H_ASM
#define _H_ASM

#include "vm.h"
#include <string>

extern int  yylex();                    // lexer interface
extern char *yytext;                    // lexeme string
extern int  yylineno;                   // current line

extern int yyparse();                   // parser interface
extern void yyerror(const char *msg);   // error callback
#include "tmp/parser.hpp"

extern void CB(BYTE  b);                // Compile Byte
extern void CC(CELL  c);                // Compile Cell
extern void CL(std::string* l, CELL a); // Compile Label
extern void LL(std::string* l, CELL a); // Add/Resolve Label

#endif // _H_ASM
