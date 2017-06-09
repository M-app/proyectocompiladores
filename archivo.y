%{
	#include<stdio.h>
	#include<string.h>

	void nuevaTemp(char *s){
		static int actual=1;
		sprintf(s,"#t%d",actual++);
	}

%}

%union{
	char cadena[100];
}

%token<cadena> NUM
%token ADD SUBS MUL DIV
%token PI PF
%token ASIG
%token<cadena> EOL
%token<cadena> RESDEC
%token<cadena> IDENT
%token<cadena> SEP
%token<cadena> RESMAIN LLAVEI LLAVEF
%token<cadena> RESINPUT RESOUTPUT
%type<cadena> programa expresion termino factor variable numero asignacion declaracion sentencia otra_variable vacio otra_sentencia bloque
%type<cadena> lectura escritura
%%
programa:	/**/				{printf("Programa Vacio\n");}
		|RESMAIN LLAVEI bloque LLAVEF
		;
bloque:		sentencia otra_sentencia
		;
otra_sentencia:	EOL sentencia otra_sentencia
		| EOL vacio
		;
sentencia:	declaracion
		| asignacion			{strcpy($$,$1);}
		| lectura
		| escritura
		;
declaracion:	RESDEC variable otra_variable
		;	
otra_variable:	SEP variable otra_variable
		| vacio
		;
asignacion:	variable ASIG expresion		{strcpy($$,$3); printf("%s=%s;\n",$1,$3);}
		;
expresion:	expresion ADD termino		{nuevaTemp($$); printf("%s=%s+%s;\n",$$,$1,$3);}
		| expresion SUBS termino	{nuevaTemp($$); printf("%s=%s-%s;\n",$$,$1,$3);}
		| termino
		;
termino:	termino MUL factor		{nuevaTemp($$); printf("%s=%s*%s;\n",$$,$1,$3);}
		| termino DIV factor		{nuevaTemp($$); printf("%s=%s/%s;\n",$$,$1,$3);}
		| factor
		;
factor:		PI expresion PF			{strcpy($$,$2);}
		| variable			{strcpy($$,$1);}		
		| numero			{strcpy($$,$1);}
		;
lectura:	RESINPUT variable		{printf("call input;\npop %s;\n",$2);}
		;
escritura:	RESOUTPUT variable		{printf("push %s;\ncall output;\n",$2);}
		;
variable:	IDENT
		;
numero:		NUM
		;
vacio:		/**/
		;
%%

int main(){
	yyparse();
	return 0;
}

int yyerror(char *s){
	fprintf(stderr,"error:%s\n",s);
	return 0;
}
