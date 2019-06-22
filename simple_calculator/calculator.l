/* calculator */

/* C Declarations */

%{
	#include "calculator.tab.h"
	#include <stdlib.h>
	void yyerror(char *);
%}

/* RE and Actions */

%%

"if" {return IF;}

[a-z]	{
	yylval = *yytext - 'a';
	return VARIABLE;
	}

[0-9]+	{
	yylval = atoi(yytext);
	return INTEGER;
	}

[-+()/=*\n]	{ return *yytext; }


[ \t]* 	; 	/* skip whitespace */

.	{ printf("unknown character"); }

%%

/* user subroutines */

int yywrap(void) 
{
	return 1;
}