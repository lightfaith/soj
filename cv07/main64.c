#include<stdio.h>
#include<stdlib.h>


__int128 deleni(__int128 delenec, long delitel, int* zbytek);

void int128_to_str(__int128 n, int base, char* output)
{
	char revbuf[255];
	int counter=0;
	int rem;

	while(n>0)
	{
		n = deleni(n, base, &rem);
		revbuf[counter++]=rem+'0';
	}
	revbuf[counter]=0;
	for(int i=0; i<counter; i++)
		output[counter-i-1] = revbuf[i];
	output[counter]=0;
}

int main()
{
	__int128 a = 1500000003;
	__int128 b = 5;
	int zbytek = 0xdeadbeef;
	printf("Address: %p\n", &zbytek);
	__int128 result = deleni(a, b, &zbytek);
	printf("Result: %ld, remainder: %d\n", (long)result, zbytek);

	
	
	int base = 8;
	printf("\n\n\nNow numbers to string (base %d):\n", base);
	__int128 numbers[] = {10, 32, 11, 186, 10000000001};
	
	char* buffer = (char*)malloc(256);
	for(int i=0; i<sizeof(numbers)/sizeof(*numbers); i++)
	{
		int128_to_str(numbers[i], base, buffer);
		printf("%ld as string: '%s'\n", (long)numbers[i], buffer);
	}

}
