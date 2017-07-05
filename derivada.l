/*
SCRIPT LÉXICO
*/
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "derivada.tab.h"
	int linea; //contador de líneas para el error léxico
%}

COEFICIENTE [0-9]+("."[0-9]+)?


%%
{COEFICIENTE}	{
				yylval.caracteres=yytext;
				return(COEFICIENTE);
				}
"=" 			{return(IGUAL);}
"+"				{return(SUMA);}
"-"				{return(RESTA);}
"*"				{return(MULTIPLICACION);}
"/"				{return(DIVISION);}
"x"				{return(VARIABLE);}
";"				{return(PUNTO_COMA);}
.				{printf("Error léxico");}
%%
