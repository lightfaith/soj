#include<stdio.h>
#include<stdlib.h>

int nasob(int a, int b);
long nasobl(long a, long b);
int soucet(int* pole, int len);
long soucetl(int* pole, int len);
long soucetll(long* pole, int len);
char* atob(long cislo, char* str);




//void substring(char* dest, char* src, int start, int width);
char* starstar(char* haystack, char* needle);
void minmax(int* array, int len, int* min, int* max);
int atoy(char* numstr);



int main()
{
	printf("\n\n\n");
	printf("5*6=%d\n", nasob(5, 6));	
	printf("million millions=%ld\n", nasobl(1000000, 1000000));

	//int pole[] = {1, 2, 3, 4, -1};
	int pole[] = {1000000000, 2000000000, 3, 4, -1};
	long polel[] = {1000000000000, 2000000000000, 3, 4, -1};
	printf("soucet=%d\n", soucet(pole, sizeof(pole)/sizeof(*pole)));
	printf("soucetl=%ld\n", soucetl(pole, sizeof(pole)/sizeof(*pole)));
	printf("soucetll=%ld\n", soucetll(polel, sizeof(polel)/sizeof(*polel)));

	char numstr[100];
	printf("atob=%s\n", atob(0xF5F5F5F5F5, numstr));


	char *haystack = "Illuminati! You've come to take control. You can take my heartbeat but you can't break my soul. We all shall be free!";
	char *needle = "nat";

	int min;
	int max;
	int numbers[] = {1, 2,  3, -4, 0};
	
	char numstr2[] = "12";
	//char numstr2[] = "-6";

		
	char tmp[5];
	for(int i=0; i<5; i++)
		tmp[i]=0;
	
	/*printf("\n\n");
	substring(tmp, haystack, 2, 3);
	printf("-- %s\n", tmp);
	*/

	char* found = starstar(haystack, needle);
	//char* found = strstr(haystack, needle);
	printf("++++++++++FOUND: %p\n", found);
	printf("'%s' found - ", needle);
	if(found!=0)
		printf("TRUE (position %x)\n", found-haystack);
	else
		printf("FALSE\n");


	minmax(numbers, sizeof(numbers)/sizeof(*numbers), &min, &max);
	printf("Found min=%d, max=%d\n", min, max);

	int atoyresult=atoy(numstr2);
	printf("Decoded number: %d (0x%08x)\n", atoyresult, atoyresult);
	return 0;

}

