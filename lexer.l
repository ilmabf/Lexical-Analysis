%option noyywrap
%{
	#include<stdlib.h>
	#include<stdio.h>
	#include <string.h>        
%}

%s A B C DEAD  

string [a-zA-Z]+
integer [0-9]+
whitespace [ \n\r\t]

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