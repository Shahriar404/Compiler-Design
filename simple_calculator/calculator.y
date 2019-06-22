/* C declarations */

%{
	#include <stdio.h>
	void yyerror(char *);
	int yylex(void);
	int sym[26];
%}

/* Bison declarations */

%token  VARIABLE INTEGER IF

%left '+' '-'
%left '*' '/'

/* Simple grammar rules */

%%

program: program statement '\n'

	| /* NULL */
 	;

statement: expression { printf("\nValue of the expression: %d\t\n",$1); }

	| VARIABLE '=' expression { sym[$1] = $3;
				    $$= $3; 
				    printf("\nValue of the statement: %d\t\n",$3);
				    //printf("Value of the variable: %d\n",sym[$1]);
				  }
	| IF '(' expression ')' statement {
					   if($3)
						printf("\nValue of the if statement: %d\t\n",$5);
					 }
 	;

expression: INTEGER { $$ = $1;}

 	| VARIABLE { $$ = sym[$1]; }

 	| '-' expression { $$ = -$2; }

 	| expression '+' expression { $$ = $1 + $3; }

 	| expression '-' expression { $$ = $1 - $3; }

 	| expression '*' expression { $$ = $1 * $3; }

	| expression '/' expression { 	if($3) 
				  	{
				     		$$ = $1 / $3;
				  	}
				  	else
				  	{
						$$ = 0;
						printf("\ndivision by zero\t");
				  	} 	
				    }

 	| '(' expression ')' { $$ = $2; }
 	;
%%

void yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);
}

int main(void)
{
	yyparse();
}