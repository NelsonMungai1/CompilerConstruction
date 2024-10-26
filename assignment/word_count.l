%{
#include "token.h"
#include <stdio.h>
#include <string.h>
%}
LETTER([a-zA-Z])

%%
({LETTER}+|({LETTER}+\-{LETTER}+)+) {return TOKEN_WORD;}

%%

/*main c program to count the words*/

int main(int argc, char **argv)
{
	if(argc != 2){
	printf("Usage: ./word_count file_name\n");
	printf("Example: ./word_count sample.txt\n");
	return 1;
	}

	char *filename=argv[1];
/*open file and read next token with yylex()*/
	yyin=fopen(filename,"r");
	if(!yyin)
	{
		printf("Could not open file: %s!\n",filename);
		return 1;
	}
	
	int word_count=0;
	int total_word_size=0;

	printf("%-30s \t Size(bytes) \t\n","Text");
	
	while(1)
	{
		token_t t=yylex();
		if(t== TOKEN_EOF)
			break;
		word_count++;

		//THE word size is calculated in bytes
		int word_size=sizeof(char)* strlen(yytext);
		printf("%-30s \t %-d\n",yytext,word_size);
		total_word_size+=word_size;
	}
	printf("\n Word count: %d \n",word_count);
	printf("Total word size: %d bytes \n",total_word_size);

	fclose(yyin);
	return 0;
}
int yywrap(){return 1;}


