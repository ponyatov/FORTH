#include "src/linux.h"

void os_fini() {}
void os_init() {} // atexit(os_fini); }

int getch()
{
    struct termios oldattr, newattr;
    int ch;
    tcgetattr( STDIN_FILENO, &oldattr );
    newattr = oldattr;
    newattr.c_lflag &= ~( ICANON | ECHO );
    tcsetattr( STDIN_FILENO, TCSANOW, &newattr );
    ch = getchar();
    tcsetattr( STDIN_FILENO, TCSANOW, &oldattr );
    return ch;
}

void key()  {
    fprintf(stderr,"\tkey\t\t");
        D[Dp++] = getch(); assert(Dp<Dsz);
    fprintf(stderr,"%X",D[Dp-1]);
}

void emit() {
    fprintf(stderr,"emit ");
        assert(Dp>0); putchar(D[--Dp]);
    fprintf(stderr,"%X",D[Dp+1]);
}
