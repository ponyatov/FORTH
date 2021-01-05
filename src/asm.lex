%{
    #include "asm.hpp"
%}

%option noyywrap yylineno

%%

\\[^\n]*        {}  /* comment */

[ \t\r\n]+      {}  /* drop spaces */

0x[0-9a-fA-F]+  { yylval.num = strtol(&yytext[2],NULL,0x10); return num; }
[0-9]+          { yylval.num = strtol(&yytext[0],NULL,0x0A); return num; }

"nop"           { yylval.op0 = NOP; return op0; }
"jmp"           { yylval.op1 = JMP; return op1; }

.               { yyerror("lexer"); }
