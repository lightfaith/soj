#include<stdio.h>
#include<stdlib.h>

long long rol64(long long a, int N);
long long soucet(int *x, int N);
int satur_plus(int x, int y);
long long nasob(long long ll, int i);
char* trim_space(char* source);


int main()
{
	printf("Behold!\n\n");
	printf("Rol64: 0x%Lx\n", rol64(0x0123456789ABCDEF, 8));
	int arr[] = {0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff};
	printf("Soucet: 0x%Lx\n", soucet(arr, sizeof(arr)/sizeof(*arr)));
	printf("Satur_plus: %d\n", satur_plus(2000000000, 2000000000));
	printf("Satur_plus: %d\n", satur_plus(-2000000000, -2000000000));
	printf("Satur_plus: %d\n", satur_plus(2, 2));
	printf("Nasob: %Lx\n", nasob(0x1111111122222222, 2));
	char str[] = "  Quantum fire, humans, titans, novus motus, alien corpus!";
	printf("Trim_space: '%s'\n", trim_space(str));


}
