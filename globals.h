typedef enum{
    /* book-keeping tokens */
    END,ERROR,
    /* reserved words */
    ELSE,IF,INT,RETURN,VOID,WHILE,
    /* multicharacter tokens */
    ID,NUM,
    /* special symbols */
    PLUS,MINUS,TIMES,OVER,LT,LEQ,GT,GEQ,EQ,NEQ,
    ASSIGN,SEMI,COLON,LPAREN,RPAREN,LBRACKET,
    RBRACKET,LBRACE,RBRACE
} TokenType;