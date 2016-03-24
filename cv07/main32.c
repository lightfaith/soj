#include<stdio.h>
#include<stdlib.h>

long long soucetll(long long a, long long b);
long long negatell(long long a);
long long nasob(int a, int b);
long long nasobl(long long a, int b); // unsigned only
long long nasobll(long long a, long long b); // unsigned only
long long delenil(long long a, int b, int* zbitek); // unsigned only

int main()
{
	long long a = 5000000000LL;
	long long ax = 0xffffffff;
	printf("\n\n");
	printf("%Ld + %Ld = %Ld\n", a, a, soucetll(a, a));
	printf("0x%Lx + %Ld = 0x%Lx\n", ax, 1LL, soucetll(ax, 1)); //no long long causes errors (stack variable sizes confusion)!
	printf("%Ld negated: %Ld\n", a, negatell(a));
	printf("much wow: %Ld\n", nasob(1000000000, 1000000000));

	printf("nasobl: %Ld\n", nasobl(1234567900, 36));
	printf("nasobll: %Ld\n", nasobll(36, 1234567900));
	printf("nasobll: %Ld\n\n", nasobll(13, 379));

	int zbitek;
	printf("delenil: %Ld\n", delenil(46LL, 3, &zbitek));
	printf("a zbitek %d\n", zbitek);

}
