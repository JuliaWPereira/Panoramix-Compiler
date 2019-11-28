/**********************************************
 *
 *	 Panoramix Compiler - Scanner
 *   
 *   @version 1.0
 *   @edited November 27, 2019
 *   @author Júlia Wotzasek Pereira
 *
**********************************************/

/* Options used:
 * 	- yywrap: Do not continue to the next file
 *	- nodefault: Not to add a default rule and
 *			rather to report an error if the
 *			input rules don't cover all possible
 *			input.
 *	- yylineno: Define a integer variable called
 *			yylineno and maintain the current 
 *			number of it. Every time the Scanner
 *			reads a newline character, it increments
 *			yylineno, and if the scanner backs up
 *			over a newline, it decrements it.
 *			WARNING: you should initialize yyline to
 *			1 at the beginning of each file
 *	- batch: Forces the scanner to look ahead
 *			always. It is a good ideia because it is 
 *			intend to always read from a file.
*/

%option noyywrap nodefault yylineno batch

/* Start states:
 *	- COMMENT: Used to skip comments
*/

%x COMMENT

%{
	#include "globals.h"
%}

%%
\n 	/* ignore newline */
[ \t] /* ignore whitespaces */

 /* Comments: With the state comment created,
  * I can open and close comments easily,
  * just using a machine state. Notice that
  * all contents of the comment is skipped.
  * If the comment has not been closed, it 
  * sends a warning.
*/

"/*" {BEGIN(COMMENT);}
<COMMENT>"*/" {BEGIN(INITIAL);}
<COMMENT>([^*]|\n)+|.
<COMMENT><<EOF>> { printf("%d: Unterminated comment\n", yylineno); return 0; }

 /* keywords */
else {return ELSE;}
if {return IF;}
int {return INT;}
return {return RETURN;}
void {return VOID;}
while {return WHILE;}

 /* special symbols */
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return TIMES;}
"\/" {return OVER;}
"<" {return LT;}
"<=" {return LEQ;}
">" {return GT;}
">=" {return GEQ;}
"=" {return ASSIGN;}
"==" {return EQ;}
"!=" {return NEQ;}
";" {return SEMI;}
"," {return COLON;}
"\(" {return LPAREN;}
"\)" {return RPAREN;}
"\[" {return LBRACKET;}
"\]" {return RBRACKET;}
"\{" {return LBRACE;}
"\}" {return RBRACE;}

 /* identifier and Numbers:
  * To guarantee that we do not have identifiers
  * followed without a whitespace by a number and
  * that we do not have numbers followed by 
  * identifiers without a whitespace, we use
  * 'trailing context' ('/'). It means that the
  * scanner matches the pattern if, and only if,
  * it is followed by the pattern after the '/'
  * symbol. The trailing context do not pop the
  * symbol from the buffer.
 */
[a-zA-Z]+/([^0-9]) {printf("ID\n");return ID;}
[0-9]+/([^a-zA-Z]) {printf("NUM\n");return NUM;}

.* {printf("Lexical error: '%s' at line %d\n", yytext, yylineno);}

%%

int main(int argc, char **argv)
{
	yylineno = 1;
	yylex();
}
