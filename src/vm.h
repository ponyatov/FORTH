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

extern char **argsv;
extern void args(int argc, char *argv[]);
extern void os_init();
extern void os_fini();

extern BYTE  M[Msz];    // main Memory
extern UCELL Cp;        // Compilation Pointer
#ifdef VM
extern UCELL Ip;        // Instruction Pointer
extern  BYTE Op;        // Instruction OPcode
extern UCELL R[Rsz];    // \ Return stack
extern UCELL Rp;        // /
extern   int D[Dsz];    // \ Data stack (with native cell size)
extern BYTE  Dp;        // /
#endif // VM
                        // commands
extern void unk();

extern void nop();
extern void bye();
extern void jmp();
extern void qjmp();
extern void call();
extern void ret();
extern void lit();

extern void key();
extern void emit();
                        // opcodes
#define NOP  (0x00)
#define BYE  (0xFF)
#define JMP  (0x01)
#define qJMP (0x02)
#define CALL (0x03)
#define RET  (0x04)
#define LIT  (0x05)

#define KEY  (0x10)
#define EMIT (0x11)

#include "src/sdl.h"

#endif // _H_VM
