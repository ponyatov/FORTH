#ifndef _H_ALL
#define _H_ALL

#include "config.h"

#define CELLsz (sizeof(CELL))

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

extern void args(int argc, char *argv[]);

extern BYTE  M[Msz];    // main Memory
extern UCELL Cp;        // Compilation Pointer

                        // opcodes
#define NOP (0x00)
#define BYE (0xFF)

#endif // _H_ALL
