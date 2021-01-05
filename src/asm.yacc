%{
    #include "asm.hpp"
%}

%defines %union { BYTE op0; BYTE op1; CELL num; }

%token <op0> op0
%token <op1> op1
%token <num> num

%%
REPL :
REPL : REPL cmd

cmd : op0           { CB($1);         }
cmd : op1 num       { CB($1); CC($2); }
