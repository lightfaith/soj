#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int mystrlen(char* str);
int mystrcmp(char* dest, char* src);
void upper(char* str);

void meemcpy(void* dest, void* src, int l);
void unchar(char* str, char forbidden);


int main()
{
	printf("\n");
	char str[] = "Illuminati! You've come to take control. You can take my heartbeat but you can't break my soul. We all shall be free!";
	//char str[] = "Uii";
	char str2[] = "Uyy";
	
	printf("Len: %d\n", mystrlen(str));
	printf("Compare: %d\n", mystrcmp(str, str));
	printf("Compare: %d\n", mystrcmp(str, str2));
	printf("Compare: %d\n", mystrcmp(str2, str));
	upper(str);
	printf("%s\n", str);

	printf("\n");

	// TASK
	unchar(str, 'A');
	printf("%s\n", str);
	strcpy(str, "Hello World!\0");
	char* str3 = str+6;
	printf("'%s', '%s'\n", str, str3);
	meemcpy(str3, str, 5);
	printf("'%s', '%s'\n", str, str3);

}
