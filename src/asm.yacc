%{
    #include "asm.hpp"
%}

%defines %union { BYTE op0; }

%token <op0> op0

%%
REPL :
REPL : REPL cmd

cmd : op0       { CB($1); }
