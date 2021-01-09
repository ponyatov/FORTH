// libSDL extension
// https://lazyfoo.net/tutorials/SDL/01_hello_SDL/index2.php

#ifndef _H_SDL
#define _H_SDL

#include "src/vm.h"

#include <SDL.h>

extern void ext_sdl();

#define SDL      (0x80)
#define SDL_INIT (0x00)
#define SDL_FINI (0xFF)

#endif // _H_SDL
