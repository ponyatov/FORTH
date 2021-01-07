#ifndef _H_VM
#define _H_VM

#include "config.h"

#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

                                // VM machine word: cell
#define  BYTE uint8_t
#define  CELL  int16_t
#define UCELL uint16_t

// #define CELLsz (sizeof(CELL))


extern void args(int argc, char *argv[]);

extern BYTE  M[Msz];    // main Memory
extern UCELL Cp;        // Compilation Pointer

                        // opcodes
#define NOP  (0x00)
#define BYE  (0xFF)
#define JMP  (0x01)
#define qJMP (0x02)
#define CALL (0x03)
#define RET  (0x04)
#define LIT  (0x05)

#endif // _H_VM
