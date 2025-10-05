#pragma once

/// @defgroup forth forth

/// @defgroup libc libc
/// @{
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
/// @}

/// @defgroup main main
/// @ingroup libc
/// @{
extern int main(int argc, char* argv[]);
extern void arg(int argc, char* argv);
/// @}

/// @defgroup config config
/// @ingroup forth
/// @{

/// @ref M size, bytes (64M max for MCU-hosted VM)
#define Msz 0x10000
/// @ref R size, @ref addr s
#define Rsz 0x100
/// @ref D size, @ref cell s
#define Dsz 0x10
/// @}

/// @defgroup types types
/// @ingroup forth
/// @{
typedef uint8_t byte;   ///< raw byte
typedef uint16_t addr;  ///< @ref M address
typedef int32_t cell;   ///< limited to 32 bits for MCU emulation
/// @}

/// @defgroup memory memory
/// @ingroup forth
/// @{

extern byte M[Msz];  ///< main memory
extern addr Cp;      ///< @ref M compiler pointer
extern addr Ip;      ///< @ref M instruction pointer

extern addr R[Rsz];  ///< return stack
extern byte Rp;      ///< @ref R pointer (low-recursion limited)

extern cell D[Dsz];  ///< data stack
extern byte Dp;      ///< @ref D pointer
/// @}

/// @defgroup syntax syntax
/// @ingroup forth2
/// @{
extern int yylex();
extern int yylineno;
extern char* yytext;
extern char* yyfile;
extern FILE* yyin;
extern int yyparse();
extern void yyerror(const char* msg);
#include "FORTH.yacc.hpp"
/// @}
