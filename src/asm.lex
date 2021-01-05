%{
    #include "asm.hpp"
%}

%option noyywrap yylineno

%%

[ \t\r\n]+  {}

"nop"       { yylval.op0 = NOP; return op0; }

.           { yyerror("lexer"); }
