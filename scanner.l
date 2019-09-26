%{
/* Flex program to do the lexical analysis of a text file. Its input should be a file as its output is.
	@version 0.2
	@author Júlia Wotzasek Pereira and Vinícius Juliasse Dantas
	@edited September 24, 2019
*/

/* Required packages */
#include <stdlib.h>
#include <stdio.h>

/* Token definitions */

/* key-words */
#define ELSE    300
#define IF      301
#define INT     302
#define RETURN  303
#define VOID    304
#define WHILE   305

/* special-symbols */
#define SUM     400
#define SUB     401
#define MULT    402
#define DIV     403
#define LT      404
#define LEQ     405
#define GT      406
#define GEQ     407
#define EQUAL   408
#define NEQ     409
#define ASSIG   410
#define SCOLON  411
#define COLON   412
#define OPEN_P  413
#define CLOSE_P 414
#define OPEN_B  415
#define CLOSE_B 416
#define OPEN_K  417
#define CLOSE_K 418

/* extra markers */
#define ID      500
#define NUM     501
#define END     502
#define ENTER   503
#define COMMENT 504
#define OTHER   505
#define SPACE   506

/* Errors */
#define ERROR   600

/* Line Counter */
int num_lines = 1;

%}

digit [0-9]
letter [a-zA-Z]
identifier {letter}({letter}|{digit})*
number {digit}+
start \/\*
end \*\

%%
\n num_lines++; return ENTER;
"/*" {
	char c;
	while(1)
	{
		c = input();
		if(c == EOF) break;
		if(c == '*')
		{
			c = input();
			if(c == '/') break;
		}
		if(c == '\n'){
			num_lines++;
		}
	}
}
else {return ELSE;}
if {return IF;}
int {return INT;}
return {return RETURN;}
void {return VOID;}
while {return WHILE;}

" " {return SPACE;}
\t {return SPACE;}
"+" {return SUM;}
"-" {return SUB;}
"*" {return MULT;}
"/" {return DIV;}
"<" {return LT;} 
"<=" {return LEQ;}
">" {return GT;}
">=" {return GEQ;}
"==" {return EQUAL;}
"!=" {return NEQ;}
= {return ASSIG;}
; {return SCOLON;}
"," {return COLON;}
"\(" {return OPEN_P;} 
"\)" {return CLOSE_P;}
"\[" {return OPEN_B;}
"\]" {return CLOSE_B;}
"\{" {return OPEN_K;}
"\}" {return CLOSE_K;}


{identifier} {return ID;}
{identifier}['!'|'@'|'#'|'$'|'%'|'&']+.* {return ERROR;}
{number}['!'|'@'|'#'|'$'|'%'|'&'|{letter}]+.* {return ERROR;}
{number} {return NUM;}
<<EOF>> {return END;}
. {return ERROR;}

%%

int main()
{
	int token;
	FILE *f_in, *f_out;

	f_in = fopen("teste.txt","r");
	f_out = fopen("saida.txt","w");
	yyin = f_in;

	while (((token = yylex()) != END) && (token != ERROR))
	{
		switch(token){
		case COMMENT:
			break;
		case SPACE:
			break;
		case ELSE:
			fprintf(f_out,"ELSE ");
			break;
		case IF:
			fprintf(f_out,"IF ");
			break;
		case INT:
			fprintf(f_out,"INT ");
			break;
		case RETURN:
			fprintf(f_out,"RETURN ");
			break;
		case VOID:
			fprintf(f_out,"VOID ");
			break;
		case WHILE:
			fprintf(f_out,"WHILE ");
			break;
		case SUM:
			fprintf(f_out,"SUM ");
			break;
		case SUB:
			fprintf(f_out,"SUB ");
			break;
		case MULT:
			fprintf(f_out,"MULT ");
			break;
		case DIV:
			fprintf(f_out,"DIV ");
			break;
		case LEQ:
			fprintf(f_out,"LEQ ");
			break;
		case LT:
			fprintf(f_out,"LT ");
			break;
		case GT:
			fprintf(f_out,"GT ");
			break;
		case GEQ:
			fprintf(f_out,"GEQ ");
			break;
		case EQUAL:
			fprintf(f_out,"EQUAL ");
			break;
		case NEQ:
			fprintf(f_out,"NEQ ");
			break;
		case ASSIG:
			fprintf(f_out,"ASSIG ");

		case COLON:
			fprintf(f_out,"COLON ");
			break;
		case OPEN_P:
			fprintf(f_out,"OPEN_P ");
			break;
		case CLOSE_P:
			fprintf(f_out,"CLOSE_P ");
			break;
		case OPEN_B:
			fprintf(f_out,"OPEN_B ");
			break;
		case CLOSE_B:
			fprintf(f_out,"CLOSE_B ");
			break;
		case OPEN_K:
			fprintf(f_out,"OPEN_K ");
			break;
		case CLOSE_K:
			fprintf(f_out,"CLOSE_K ");
			break;
		
		case NUM:
			fprintf(f_out,"NUM ");
			break;
		case ID:
			fprintf(f_out,"ID ");
			break;
		case ENTER:
			fprintf(f_out,"\n");
			break;
		case OTHER:
			fprintf(f_out,"SCOLON ");
			break;
		default:
			fprintf(f_out,"SCOLON ");
		}
	}
	if(token == ERROR)
	{
		printf("Lexical Error at line %d at word %s. \n",num_lines,yytext);
	}
	return(0);
}
