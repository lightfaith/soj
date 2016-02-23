#include<stdio.h>
#include<stdlib.h>

static int pole[10]; // reference unknown outside this file
//int pole[10];
int delka = 10;

void nuluj(int*, int); // no need for externi

void init_pole()
{
	nuluj(pole, delka);
}

do_pole(int inx, int v)
{
	pole[inx] = v;
	return v;
}

int *get_pole()
{
	return pole; // returns address (works even for static)
}
