/*
SCRIPT LÉXICO
*/
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "derivada.tab.h"
%}

NUMERO [0-9]+("."[0-9]+)?
OPERADOR ("+"|"-")

%%
{NUMERO}		{
				yylval.caracteres=strdup(yytext);
				return(NUMERO);
				}
{OPERADOR}		{yylval.caracteres=strdup(yytext);
				return(OPERADOR);}
"x"				{return(VARIABLE);}
";"				{return(PUNTO_COMA);}
.				{printf("Error léxico");}
%%
