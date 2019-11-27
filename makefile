PROJ_NAME = ex5

all: $(PROJ_NAME)

$(PROJ_NAME): $(PROJ_NAME).tab.c lex.yy.o
	gcc -o $(PROJ_NAME) lex.yy.o $(PROJ_NAME).tab.c -ly -lfl

$(PROJ_NAME).tab.c: $(PROJ_NAME).y
	bison -d $(PROJ_NAME).y

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: $(PROJ_NAME).l
	flex ex5.l

clean:
	rm -rf *.o*~ $(PROJ_NAME) *~