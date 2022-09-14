%option noyywrap
%{
	#include<stdlib.h>
	#include<stdio.h>
	#include <string.h>        
%}

/* Declare states */
%s A B DEAD  

/* If string starts with a digit, read all digits. Change state to A after. */
/* If string starts with a letter, read all letters. Change state to B after. */

/* If next character is not a whitespace we have an error. Switch to DEAD state. */
/* Use yymore to append current yytext the previous one */
/* If next character is a whitespace we have an integer. */

/* If next character is not a whitespace we have an error. Switch to DEAD state. */
/* If next character is a whitespace we have a string. */

/* Read until we get a whitespace Then print the output error*/
/* When we get a whitespace, switch state to INITIAL*/
%%

<INITIAL>[0-9]+ BEGIN A;  { yymore();}
<INITIAL>[a-zA-Z]+ BEGIN B; {yymore();}

<A>[^ \t\r] BEGIN DEAD; {yymore();}
<A>[ \t\r] BEGIN INITIAL; {printf("int - %s ", yytext); }

<B>[^ \t\r] BEGIN DEAD; {yymore(); printf("%s - error ", yytext);}
<B>[ \t\r] BEGIN INITIAL; {printf("string - %s ", yytext); }


<DEAD>[^ \t\r] BEGIN DEAD; {yymore(); printf("%s - error ", yytext);}
<DEAD>[ \t\r] BEGIN INITIAL; 

%%

int main(int argc,char **argv)
{
	if(argc>1){
		FILE *file, *file2;
		file = fopen(argv[1], "r");
		if(!file){
			printf("Could not open file\n");
			exit(1);
		}
		file2 = fopen("output.txt", "w");
		yyin = file;
		yylex();
	}
	return 0;
}