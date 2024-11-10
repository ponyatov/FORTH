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

/// @defgroup main main
/// @{

/// @brief embedded entry point
void main(void);

/// @}

/// @defgroup io io
/// @{

/// @brief put single char to @ref SWO
/// @param[in] c char
extern void emit(char c);

/// @}
