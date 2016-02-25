#include<stdio.h>
#include<stdlib.h>

int testret(int x);
int soucet(int a, int b);
int sumarray(int *arr, int N);
int spacenum(char* str);
int lowercount(char* str);
int posnegcount(int *arr, int N, int* pos, int* neg);
// TASK
void lower(char* str);
void replace(char* str, char c);
int oddcount(int* arr, int N);
void avgs(int *arr, int N, int* avgpos, int* avgneg);

int main()
{
	int arr[10] = {-1, -2, -3, -10, 1, 2, 3, 4, 5, 3};
	printf("Testret: %d\n", testret(42));
	printf("%d + %d = %d\n", 2, 3, soucet(2, 3));
	printf("sumarray = %d\n", sumarray(arr, sizeof(arr)/sizeof(*arr)));
	char str[] = "Illuminati! You've come to take control.";
	printf("'%s' - %d spaces, %d lowercase\n", str, spacenum(str), lowercount(str));
	
	int pos = 0;
	int neg = 0;
	posnegcount(arr, sizeof(arr)/sizeof(*arr), &pos, &neg);
	printf("\npos: %d, neg: %d\n", pos, neg);

	// TASK
	lower(str);
	printf("\n\nTolower:\n  %s\n", str);
	char math[] = "Magicke cislo 7";
	replace(math, 'n');
	printf("Math:  %s\n", math);
	printf("Oddcount = %d\n", oddcount(arr, sizeof(arr)/sizeof(*arr)));
	int avgpos = 0;
	int avgneg = 0;
	avgs(arr, sizeof(arr)/sizeof(*arr), &avgpos, &avgneg);
	printf("avgpos = %d, avgneg = %d\n", avgpos, avgneg);

}
