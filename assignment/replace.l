%{
#include "token.h"
#include <string.h>
%}

%%
abc {printf("ABC");}
. {printf(yytext);}
%%

int main(int argc,char **argv)
{
	if(argc!=2){
		printf("Usage: ./replace file_name \n");
		printf("Example: ./replace sample.txt");
		return 1;
	}
	char *filename=argv[1];
	yyin=fopen(filename,"r");
	
	if(!yyin){
		printf("Could not open file: %s !\n",filename);
		return 1;
	}
	
	yylex();
	fclose(yyin);
	
	return 0;
}

int yywrap() {return 1;}
