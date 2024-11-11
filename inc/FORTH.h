/// @file
/// @brief minimal FORTH/REPL system for STM32
#pragma once

/// @defgroup config config
/// @{

/// bytecode memory size
#define Msz 0x1000
/// return stack size
#define Rsz 0x100
/// data stack size
#define Dsz 0x10
/// @}

/// @defgroup libc libc
/// @{

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

/// @}

/// @defgroup main main
/// @{

#if HW == _
/// @brief POSIX entry point
extern int main(int argc, char *argv[]);
#else
/// @brief embedded entry point
void main(void);
#endif
void arg(int argc, char *argv);

/// @}

/// @defgroup parser parser
/// @{
extern int yylex();
extern int yylineno;
extern char *yytext;
extern char *yyfile;
extern char yynone[];
extern FILE *yyin;
extern int yyparse();
extern void yyerror(char *msg);
#include "FORTH.parser.h"
/// @}

/// @defgroup io io
/// @{

/// @brief put single char to @ref SWO
/// @param[in] c char
extern void emit(char c);

/// @}
