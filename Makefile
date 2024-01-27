all: lex yacc 
	g++ lex.yy.c y.tab.c -ll -o prelab3

yacc: prelab3.y
	yacc -d -v prelab3.y

lex: prelab3.l
	lex prelab3.l

clean: lex.yy.c y.tab.c prelab3 y.tab.h
	rm lex.yy.c y.tab.c prelab3 y.tab.h