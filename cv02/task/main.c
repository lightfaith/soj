#include<stdio.h>
#include<stdlib.h>

int delka = 10;

//int pole32[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//int pole32[10] = {1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000};
//int pole32[10] = {-1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000, -1000};
int pole32[10] = {128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536};

//char pole8[10] = {1, 1, 1, 1, 1, 1, 2, 3, 4, 1};
//char pole8[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//char pole8[10] = {-100, -100, -100, -100, -100, -100, -100, -100, -100, -100};
char pole8[10] = {1, 2, 4, 8, 16, 32, 64, -128, -64, -32};

int soucet32;
int prumer32;
int nasob32 = 16;
char nasob8 = 2;
int okolik = 1;

void suma_pole32();
void avg_pole32();
void suma_pole8();
void avg_pole8();

void multiply32();
void multiply8();
void shift32();
void shift8();

int main()
{
	suma_pole32();
	printf("soucet je %d\n", soucet32);
	avg_pole32();
	printf("prumer je %d\n", prumer32);
	
	suma_pole8();
	printf("soucet je %d\n", soucet32);
	avg_pole8();
	printf("prumer je %d\n", prumer32);
	

	printf("Printing pole32:\n");
	for(int i=0; i<delka; i++)
		printf("%d  ", pole32[i]);
	printf("\n");

	printf("Printing pole8:\n");
	for(int i=0; i<delka; i++)
		printf("%d  ", pole8[i]);
	printf("\n\n");

	multiply32();
	multiply8();
	
	printf("Printing multiplied pole32:\n");
	for(int i=0; i<delka; i++)
		printf("%d  ", pole32[i]);
	printf("\n");

	printf("Printing multiplied pole8:\n");
	for(int i=0; i<delka; i++)
		printf("%d  ", pole8[i]);
	printf("\n\n");

	
	
	shift32();
	shift8();
	
	printf("Printing shifted pole32:\n");
	for(int i=0; i<delka; i++)
		printf("%d  ", pole32[i]);
	printf("\n");

	printf("Printing shifted pole8:\n");
	for(int i=0; i<delka; i++)
		printf("%d  ", pole8[i]);
	printf("\n");


}
