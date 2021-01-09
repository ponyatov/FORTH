%{
    #include "src/asm.hpp"
%}

%defines %union { BYTE b; CELL c; std::string* s; }

%token <b> op0
%token <b> op1
%token <c> num
%token colon
%token <s> sym
%token <b> sdl

%%
REPL :
REPL : REPL cmd

cmd : op0           { printf("\n%.4X: %.2X"     ,Cp,$1            ); CB($1);            }
cmd : op1 num       { printf("\n%.4X: %.2X %.4X",Cp,$1,$2         ); CB($1); CC($2);    }
cmd : op1 sym       { printf("\n%.4X: %.2X %s"  ,Cp,$1,$2->c_str()); CB($1); CL($2,Cp); }
cmd : sym colon     { printf("\n%.4X:\t%s:"     ,Cp,$1->c_str()   ); LL($1,Cp);         }
cmd : sdl           { printf("\n%.4X: %.2X %.2X",Cp,SDL,$1        ); CB(SDL); CB($1);   }
