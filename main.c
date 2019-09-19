#include <stdio.h>
#include <stdlib.h>

enum state {s0,s1,s2,s3,ERROR};

int next_state(char c, enum state current_state){
    switch(current_state){
    case s0:
        return (c == '/')? s1 : s0;
    case s1:
        return (c == '*')? s2 : s0;
    case s2:
        return (c == '*')? s3 : s2;
    case s3:
        return (c == '/')? s0 : (c == '*')? s3 : s2;
    default:
        return ERROR;
    }
}

int main()
{
    FILE *file_in,*file_out;
    file_in = fopen("sort.txt","r");
    file_out = fopen("post-processed-file.txt","w");

    char c;
    enum state current_state = s0;
    while((c = fgetc(file_in)) != EOF){
        current_state = next_state(c,current_state);
        if(current_state == s0){
            if(c != '/'){
                fprintf(file_out , "%c",c);
            }
        }else if((current_state == s1) && ((current_state = next_state((c = fgetc(file_in)),current_state)) == s0)){
            fprintf(file_out , "/%c",c);
        }
    }
    return 0;
}
