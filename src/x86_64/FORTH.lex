%{
    #include "FORTH.h"
    char yynone[] = "";
    char *yyfile = yynone;
    static char sx[0x100];
    static char sp=0;
%}

%option noyywrap yylineno

sign    [+\-]
dec     [0-9]
hex     [0-9a-fA-F]
oct     [0-7]
bin     [01]

%x str

%%

#[^\n]*         {}                  // drop line comment
[ \t\r\n]+      {}                  // drop spaces

"\""            { BEGIN(str);        sp  = 0; }
<str>.          { sx[sp++] = yytext[0]; assert(sp<sizeof(sx));}
<str>"\""       { BEGIN(INITIAL); sx[sp] = 0;
                  yylval.s = sx; return STR;  }

{sign}?{dec}+   { yylval.n = strtol( yytext   ,NULL,0x0A); return INT; }
"0x"{hex}+      { yylval.n = strtol(&yytext[2],NULL,0x10); return INT; }
"0o"{oct}+      { yylval.n = strtol(&yytext[2],NULL,0x08); return INT; }
"0b"{bin}+      { yylval.n = strtol(&yytext[2],NULL,0x02); return INT; }

[^ \t\r\n]+     { yylval.s = yytext; return SYM; }

.               {yyerror("");}      // any undetected char
