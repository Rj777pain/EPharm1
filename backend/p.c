#include<stdio.h>
void main(){
    char str[50];
    int i,c=0;
    printf("Enter the sentance: ");
    fgets(str, 50, stdin);
    
    for(i=0;str[i]!='\0';i++){
        if(str[i] == ' '){
            c++;
        }
    }

   
    printf("\nSentence: %s",str);
    printf("Words:%d",c);
}