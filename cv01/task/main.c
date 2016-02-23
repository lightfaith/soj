#include<stdio.h>
#include<stdlib.h>

char retezec[] = "Hello World!";
int index=0;

int x1=1, x2=2, x3=3, soucet=0;

void bigger();
void smaller();
void sum();

int main()
{

	// 0x41   0100 0001
	// 0x61   0110 0001
	// mask   1101 1111
	printf("\nOriginal string:       '%s'\n", retezec);
	index = 1;
	printf("Making '%c' bigger...\n", retezec[index]);
	bigger();
	printf("Bigger:                '%s'\n", retezec);
	
	index = 6;
	printf("Making '%c' smaller...\n", retezec[index]);
	smaller();
	printf("Smaller:               '%s'\n", retezec);
	
	//sum
	sum();
	printf("\n%d + %d + %d = %d\n", x1, x2, x3, soucet);
}
