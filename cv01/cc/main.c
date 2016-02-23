#include<stdio.h>
#include<stdlib.h>

extern int delka; //extern needed
extern int pole[10];

int do_pole(int, int);
int *get_pole();
void init_pole();

int nuluj(int *ptr, int delka)
{
	int i=0;
	for (i=0; i<delka; i++)
		ptr[i]=0;
}

int main()
{
	int i=0;
	init_pole();
	for(i=0; i<delka; i++)
	{
		//printf("pole[%d] = %d\n", i, pole[i]);
		printf("pole[%d] = %d\n", i, get_pole()[i]);
	}
	
	for(i=0; i<delka; i++)
		do_pole(i, i);
	printf("-------------\n");	
	for(i=0; i<delka; i++)
		printf("pole[%d] = %d\n", i, get_pole()[i]);
}
