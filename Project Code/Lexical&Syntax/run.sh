#!/bin/bash

lex gram_new.l
yacc -d gram.y
gcc lex.yy.c y.tab.c -ll
./a.out < input.c
