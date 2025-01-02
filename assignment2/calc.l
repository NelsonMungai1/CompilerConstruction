%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *s);
%}

%%
"print"                 {return print;}
"exit"                  {return exit_command;}
[a-zA-Z]                {yylval.id=yytext[0]; return identifier;}
[0-9]+                  {yylval.num=atoi(yytext); return number;}
[ \t\n]                 ;
[-+=]                   {return yytext[0];}
";"                     {return ';';}
.                       {ECHO; yyerror ("Unexpected Character");}
%%

int yywrap(void) {
    return 1;
}