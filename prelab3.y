%{
	#include <stdio.h>
	#include <iostream>
	#include <string>
	#include <map>
	using namespace std;
	#include "y.tab.h"
	extern FILE *yyin;
	extern int yylex();
	void yyerror(string s);
	extern int linenum;// use variable linenum from the lex file
	map<string,int> types;
%}

%union
{
	int number;
	char * str;
}

%token INTEGER IFRKW  SEMICOLON OP CP OCB CCB COMP  EQ  STRING INTRSW STRINGRSW
%token<str> IDENTIFIER

%%

statements:
	statement
	|
	statement statements
	;

statement:
	decleration
	|
	if_statement
	;

decleration:

	INTRSW IDENTIFIER SEMICOLON 
	{ 
		types[string($2)] = 0; //I used 0 for keeping integers
		cout << "integer variable " << $2 << " is created in line " << linenum << endl;
		

	} 

	|

	STRINGRSW IDENTIFIER SEMICOLON 
	{ 
		types[string($2)] = 1; //I used 1 for keeping strings
		cout << "string variable " << $2 << " is created in line " << linenum << endl;

	} 
	;


if_statement:
	IFRKW OP compr CP OCB body CCB
	;


compr:
	IDENTIFIER COMP INTEGER 
	{	
		if (types[string($1)] == 0){

			cout << "There is a comparison in line " << linenum << endl;
		}

		else { 

			cout << "Type mismatch in line " << linenum << endl;
		}

	}
	|
	IDENTIFIER COMP IDENTIFIER 
	{
		if (types[string($1)] == types[string($3)]){

			cout << "There is a comparison in line " << linenum << endl;
		}
		else{ 
			cout << "Type mismatch in line " << linenum << endl;
		}
		
	
	}
	|
	INTEGER COMP IDENTIFIER 
	{
		if (types[string($3)] == 0){

			cout << "There is a comparison in line " << linenum << endl;
		}
		else{
			cout << "Type mismatch in line " << linenum << endl;
		}
	}
	|
	IDENTIFIER COMP STRING
	{	
		if (types[string($1)] == 1){

			cout << "There is a comparison in line " << linenum << endl;
		}
		else{ 
			cout << "Type mismatch in line " << linenum << endl;
		}

	}
	|
	STRING COMP IDENTIFIER
	{
		if (types[string($3)] == 1){

			cout << "There is a comparison in line " << linenum << endl;
		}
		else{
			cout << "Type mismatch in line " << linenum << endl;
		}
	}
	;
body:
	if_statement
	|
	decleration
	|
	if_statement body 
	|
	decleration body
	|
	;


%%
void yyerror(string s){
	cerr<<"Error at line: "<<linenum<<endl;
}
int yywrap(){
	return 1;
}
int main(int argc, char *argv[])
{
    /* Call the lexer, then quit. */
    yyin=fopen(argv[1],"r");
    yyparse();
    fclose(yyin);
    return 0;
}
