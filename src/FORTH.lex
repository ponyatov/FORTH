%{
    #include "FORTH.hpp"
%}

%option noyywrap yylineno

%%
%%

char *yyfile = nullptr; ///< current file name
