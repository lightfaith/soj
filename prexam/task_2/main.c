#include<stdio.h>
#include<stdlib.h>

long long ror64(long long cislo, int N);
long long llmax(long long a, long long b);
long long polemax(long long *p, int N);
int satur_plus(int a, int b);
int pocet_dig(char *s);
char *strkate(char *s1, char *s2);

int main()
{
	printf("Behold!\n\n");
	printf("Ror64: 0x%Lx\n", ror64(0x9876543210ABCDEF, 4));
	long long arr[] = {0xffffffff, 0x1, 0xdeadbeef00c0ffee, 0x000000faceb00c00};
	printf("LLMax: 0x%Lx\n", llmax(arr[0], arr[1]));
	printf("Polemax: %Lx\n", polemax(arr, sizeof(arr)/sizeof(*arr)));
	printf("Satur_plus: %d\n", satur_plus(2000000000, 2000000000));
	printf("Satur_plus: %d\n", satur_plus(-2000000000, -2000000000));
	printf("Satur_plus: %d\n", satur_plus(2, 2));
	printf("Pocet_dig: %d\n", pocet_dig("1 little, 2 little, 3 little endianness..."));
	char str1[12] = "Rosen";
	char str2[] = "kreutz";
	printf("Trim_space: '%s'\n", strkate(str1, str2));


}
