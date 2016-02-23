#include<stdio.h>
#include<stdlib.h>

extern int delka; //extern needed
int index, value;
extern char pozdrav[];

int do_pole();
int *get_pole();

int nuluj(int *ptr, int delka)
{
	int i=0;
	for (i=0; i<delka; i++)
		ptr[i]=0;
}

int main()
{
	int i=0;

	nuluj(get_pole(), delka);
	for(i=0; i<delka; i++)
	{
		printf("pole[%d] = %d\n", i, get_pole()[i]);
	}
	
	for(i=0; i<delka; i++)
	{
		index = i;
		value = i*2;
		do_pole();
	}
	printf("-------------\n");	
	for(i=0; i<delka; i++)
		printf("pole[%d] = %d\n", i, get_pole()[i]);

	printf(pozdrav);
}

