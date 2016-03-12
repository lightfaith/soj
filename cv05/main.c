#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void substring(char* dest, char* src, int start, int width);
char* starstar(char* haystack, char* needle);
void minmax(int* array, int len, int* min, int* max);
int atoy(char* numstr);

int main(int argc, char** argv)
{
	char *haystack = "Illuminati! You've come to take control. You can take my heartbeat but you can't break my soul. We all shall be free!";
	char *needle = "nat";

	//char *haystack = "abc";
	//char *needle = "";
	//char *needle = argv[1];

	int min;
	int max;
	int numbers[] = {1, 2, 3, -4, 0};
	
	//char numstr[] = "12";
	char numstr[] = "-6";

		
	char tmp[5];
	for(int i=0; i<5; i++)
		tmp[i]=0;
	
	printf("\n\n");
	substring(tmp, haystack, 2, 3);
	printf("-- %s\n", tmp);
	
	char* found = starstar(haystack, needle);
	//char* found = strstr(haystack, needle);
	printf("'%s' found - ", needle);
	if(found!=0)
		printf("TRUE (position %x)\n", found-haystack);
	else
		printf("FALSE\n");

	minmax(numbers, sizeof(numbers)/sizeof(*numbers), &min, &max);
	printf("Found min=%d, max=%d\n", min, max);

	int atoyresult=atoy(numstr);
	printf("Decoded number: %d (0x%08x)\n", atoyresult, atoyresult);
	return 0;
}
