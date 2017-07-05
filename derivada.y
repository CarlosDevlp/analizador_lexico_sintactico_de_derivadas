/*
SCRIPT SINTÁCTICO
*/
%{
  #include <stdio.h>
  #include <stdlib.h>  
  #include <string.h>  
  #include <math.h>
  extern FILE *yyin;
  extern int linea;
  //todos los métodos que usa el léxico, los usaré yo :V
  extern int yylex(void);
  extern char *yytext;
  void yyerror(char *s);  
  float suma(float a,float b);
  float resta(float a, float b);

  //derivadas
  float derivarPotencia(float a, float b);
  float derivarConstante(char *signo);

  void imprimirResultado();

  char resultado[500];
  

  int global=0;
%}


%union{
	int entero;
	float decimal;
	char* caracteres;
}

%start termino


//lista de tokens a recibir (definiéndolos)
%token <caracteres> COEFICIENTE
%token IGUAL
%token SUMA
%token MULTIPLICACION
%token DIVISION
%token <caracteres> VARIABLE
%token PUNTO_COMA
%token RESTA
%type<caracteres> termino



%%

termino:COEFICIENTE {
					//printf("\n%s -",$1);
					$$=$1;
				}
		 |termino VARIABLE COEFICIENTE {
		 			$$=$3;
		 		    //printf("\n%s - %s",$1,$3);
		 		    //printf("\n%.2f - %.2f",atof($1),atof($3));
		 			derivarPotencia(atof($1),atof($3));
		 			//imprimirResultado();
		  }
		 |termino SUMA COEFICIENTE {
		 			$$=$1;

		 			strcat(resultado,"+");
		 		    //printf("\n%s",$3);
		 		    /*printf("\n%.2f - %.2f",atof($1),atof($3));
		 			derivarPotencia(atof($1),atof($3));
		 			imprimirResultado();*/
		  } 
		 |COEFICIENTE PUNTO_COMA {
		 		//sprintf("0");
		 		strcat(resultado,"0");
		 }
         |termino PUNTO_COMA {
     			imprimirResultado();
     		}
     	;
	


%%

//| error
//método para capturar errores
void yyerror(char *s){
	printf("\nError sintáctico. %s",s);
}

//imprimir el resultado con la equación derivada
void imprimirResultado(){
	if(resultado[strlen(resultado)-1]=='+')
		strcat(resultado,"0");
	printf("\nresultado-> f(x)'= %s",resultado);
}


//derivar 
float derivarPotencia(float coeficiente, float exponente){
	float res=coeficiente*exponente;
	float nuevoExponente=exponente-1;
	sprintf(resultado, strcat(resultado,(nuevoExponente!=0?"%.1fx%.0f":"%.1f")) , res,nuevoExponente);
	return res;
}




float derivarConstante(char *signo){
	//sprintf(resultado, resultado+"%.1fx%.0f", s);
	return 0;
}



//operaciones matemáticas elementales
//suma suma($1,$2);
float suma(float a, float b){
	float res=a+b;
	printf("\neste es resultado de suma: %.2f",res);
	return res;
}

//resta
float resta(float a, float b){
	float res=a-b;
	printf("\neste es resultado de resta: %.2f",res);	
	return res;
}





//main
int main(int argc,char **argv){
	 /*if (argc>1)
                yyin=fopen(argv[1],"rt");
  	else
                yyin=stdin;*/
	yyparse();
	return 0;
}