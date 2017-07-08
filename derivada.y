/*
SCRIPT SINTÁCTICO
	LALR(1)
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
  void obtenerOperador(char *s);
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
%token <caracteres> NUMERO
%token <caracteres> OPERADOR
%token IGUAL
%token <caracteres>SUMA
%token MULTIPLICACION
%token DIVISION
%token <caracteres> VARIABLE
%token PUNTO_COMA
%token RESTA
%type<caracteres> termino


%%




termino:NUMERO {
			//2x3+2+4x2;
			//tx3+2+4x2;
			//t+2+4x2;
			//t+4x2;
					$$=$1;
		 }		 
		 |termino VARIABLE NUMERO {
		 			$$=$3;		 
		 			derivarPotencia(atof($1),atof($3));
		 			
		  }
		 
		 |termino OPERADOR NUMERO {
		 			$$=$3;
					obtenerOperador($2);
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
	int tam=strlen(resultado);
	char signos[]={'+','-'};

	for(int i=1;i<tam;i++)
		for(int ii=0;ii<2;ii++)
		for(int iii=0;iii<2;iii++)
	 		if(resultado[i-1]==signos[ii] && resultado[i]==signos[iii]) resultado[i-1]=' ';

	
	//if(resultado[tam-1]=='+' || strcmp(resultado,"")==0)
	if(strcmp(resultado,"")==0 || strcmp(resultado,"+")==0 || strcmp(resultado,"-")==0)
		strcpy(resultado,"0");

	printf("\nresultado-> f(x)'= %s",resultado);
}


void obtenerOperador(char *s){
	strcat(resultado,s);
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