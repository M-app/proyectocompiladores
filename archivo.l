%{
	#include "archivo.tab.h"
%}

%%

"+"	{return ADD;}
"-"	{return SUBS;}
"*"	{return MUL;}
"/"	{return DIV;}
"("	{return PI;}
")"	{return PF;}
"="	{return ASIG;}
"DEC"	{return RESDEC;}
","	{return SEP;}
"INPUT"	{return RESINPUT;}
"OUTPUT"	{return RESOUTPUT;}
"MAIN"	{return RESMAIN;}
"{"	{return LLAVEI;}
"}"	{return LLAVEF;}
";"	{strcpy(yylval.cadena,yytext); return EOL;}
[0-9]+	{strcpy(yylval.cadena,yytext); return NUM;}
[a-zA-Z][a-zA-Z0-9]*	{strcpy(yylval.cadena,yytext); return IDENT;}
[ \t\n]	{}
.	
%%
