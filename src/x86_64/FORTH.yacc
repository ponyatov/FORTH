%{
    #include "FORTH.h"
%}

%defines %union { int n; char *s; }

%token<n> INT
%token<s> SYM
%token<s> STR

%%

FORTH : | FORTH item

item : INT      { fprintf(stderr,"int:%i\n",$1); }
     | SYM      { fprintf(stderr,"sym:%s\n",$1); }
     | STR      { fprintf(stderr,"str:%s\n",$1); }
