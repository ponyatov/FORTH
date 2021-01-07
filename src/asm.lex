%{
    #include "asm.hpp"
%}

%option noyywrap yylineno

%%

\\[^\n]*        {}  /* comment */

[ \t\r\n]+      {}  /* drop spaces */

0b[01]+         { yylval.c = strtol(&yytext[2],NULL,0x02); return num; }
0x[0-9a-fA-F]+  { yylval.c = strtol(&yytext[2],NULL,0x10); return num; }
[0-9]+          { yylval.c = strtol(&yytext[0],NULL,0x0A); return num; }

"nop"           { yylval.b = NOP ; return op0; }
"bye"           { yylval.b = BYE ; return op0; }
"jmp"           { yylval.b = JMP ; return op1; }
"\?jmp"         { yylval.b = qJMP; return op1; }
"call"          { yylval.b = CALL; return op1; }
"ret"           { yylval.b = RET ; return op0; }
"lit"           { yylval.b = LIT ; return op1; }

":"             { return colon;                                 }
[_a-zA-Z0-9]+   { yylval.s = new std::string(yytext); return sym;   }

.               { yyerror("lexer"); }
