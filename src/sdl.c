// libSDL extension
// https://lazyfoo.net/tutorials/SDL/01_hello_SDL/index2.php

#include "src/sdl.h"

#define SCREEN_WIDTH  320
#define SCREEN_HEIGHT 240

// https://www.badprog.com/c-sdl-simple-directmedia-layer-hello-world

void sdl_init() {
    fprintf(stderr,"\tsdl/init");
    assert(SDL_Init(SDL_INIT_VIDEO)>=0);
    // SDL_Window* wnMain = SDL_CreateWindow(argv[0], SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN );
    // assert(wnMain>0);
    SDL_WM_SetCaption(argsv[0], NULL);
    SDL_SetVideoMode(SCREEN_WIDTH, SCREEN_HEIGHT, 24, SDL_HWSURFACE);
}

void sdl_fini() {
    fprintf(stderr,"\tsdl/fini");
    SDL_Quit();
}

void ext_sdl() {
    Op=M[Ip++];
    fprintf(stderr,"%.2X ",Op);
    switch (Op) {
        case SDL_INIT: sdl_init(); break;
        case SDL_FINI: sdl_fini(); break;
        default: unk();
    }
}
