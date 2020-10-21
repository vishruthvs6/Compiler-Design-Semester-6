Section             : 6E


Project Title      : Mini C Compiler for ' If-While-For ' constructs


Team Members : Chetan B Chavhannavar(PES1201701375) 
	          V.S.Vishruth(PES1201701878) 
                          Vithal P Nakod(PES1201701746)


Project Guide    : Professor Suhas G K


Project Abstract: We have built a Mini C Compiler for the If-While-For constructs.
                          Given source program in C can be translated to a symbol table, 
                          abstract syntax tree, intermediate code, optimized intermediate code
                          and target assembly code.


Code Execution :
                           Lexical and Syntax Phase:
		lex gram_new.l
		yacc -d gram.y
		gcc lex.yy.c y.tab.c -ll
		./a.out < input.c

	           Semantic Phase:
		lex sym.l
		yacc -d sym.y
		gcc lex.yy.c y.tab.c -ll
		./a.out < input.c

                           Abstract Syntax Tree:
		lex ast.l
		yacc -d ast.y
		gcc lex.yy.c y.tab.c -ll
		./a.out < t1.c

                           Intermediate Code Generation:
		lex icg.l
		yacc -d icg.y
		gcc lex.yy.c y.tab.c -ll
		./a.out < t1.c

                           Optimisation of ICG:
		python3 optimiz.py testicg.txt

	           Target Assembly Code:
		python3 a.py