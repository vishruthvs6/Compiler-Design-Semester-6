%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	int line = 0;
	#include "y.tab.h"
	extern void yyerror(const char *);  
	static void comment(void);
%}


D   		[0-9]
L   		[a-zA-Z_]
A   		[a-zA-Z_0-9]
WS  		[ \t\v\f]


%%

[\n]		{ fprintf(yyout, "%s", yytext); line++;	}
"/*"		{ comment(); }
"//"[^\n]*	{ /* Consume Comment */ line++;}


	/* Data Types */
int			{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");  return(INT); 	}
float		{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");  return(FLOAT); }
char		{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");  return(CHAR); }
void		{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");  return(VOID); }



	/* Headers */
"#"			{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return HASH; }
include		{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");  return INCLUDE; }

	/* C Libraries */
"math.h"	{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"HEADER FILE");  return MATH; }
"stdio.h"	{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"HEADER FILE");  return STDIO; }
"stdlib.h"	{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"HEADER FILE");  return STDLIB; }
"string.h"	{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"HEADER FILE");  return STRING; }
"time.h"	{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"HEADER FILE");  return TIME; }

	/* Control Structures */
for			{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");  return FOR; }
while		{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");  return WHILE; }
if			{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");  return IF; }


printf 		{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");	 return PRINT; }
return 		{ fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"KEYWORD");	 return RETURN; }



	/* User Defined Data Types, Identifiers */
{L}{A}*							{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"IDENTIFIER");  return IDENTIFIER;}
{D}+\.{D}+                      {fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"FLOAT NUMBER");  return FLOAT_LITERAL;}  		
{D}+							{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"INTEGER NUMBER");  return INTEGER_LITERAL;}	
"'"."'"							{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"CHARACTER");  return CHARACTER_LITERAL; }
\"{A}+(".h"|".c")\"				{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"HEADER");  return HEADER_LITERAL;}
\".*\"							{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"STRING");  return(STRING_LITERAL); }

	/* Assignment Operators */
"+="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(ADD_ASSIGN); }
"-="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(SUB_ASSIGN); }
"/="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(DIV_ASSIGN); }
"%="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(MOD_ASSIGN); }
"*="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(MUL_ASSIGN); }


	/* Relational Operators */
"++"		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(INC_OP); }
"--"		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(DEC_OP); }
"<="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(LE_OP); }
">="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(GE_OP); }
"=="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(EQ_OP); }
"!="		{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"OPERATOR");  return(NE_OP); }

	/* Basic Syntax */
";"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return(';'); }
"{"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('{'); }
"}"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('}'); }
","			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return(','); }
":"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return(':'); }
"="			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('='); }
"("			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('('); }
")"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return(')'); }
("["|"<:")	{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('['); }
("]"|":>")	{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return(']'); }
"."			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('.'); }
"&"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('&'); }
"!"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('!'); }
"~"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('~'); }
"-"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('-'); }
"+"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('+'); }
"*"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('*'); }
"/"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('/'); }
"%"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('%'); }
"<"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('<'); }
">"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('>'); }
"^"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('^'); }
"|"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('|'); }
"?"			{fprintf(yyout, "%s", yytext);printf("%s\t\t%s\n",yytext,"SPECIAL SYMBOL");  return('?'); }


{WS}+		{fprintf(yyout, "%s", yytext); /* whitespace separates tokens */}

.			{ printf("No Match, Invalid Expression %s\n", yytext);}

%%

int yywrap(void)
{
	return 1;
}


static void comment(void)
{
    int c;

    while ((c = input()) != 0){
        if (c == '*')
        {
            while ((c = input()) == '*');
            if (c == '/')
                return;

            if (c == 0)
                break;
        }
        }
    yyerror("Unterminated comment");
}
