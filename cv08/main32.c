#include<stdio.h>
#include<stdlib.h>
#include<strings.h>

int div_iN_i32(int *n, int delitel, int N);
// n = n/delitel, return remainder
int add_iN_i32(int *n, int scitanec, int N);

void mul_iN_i32(int *n, int cinitel, int N);
// n = n*cinitel

void printbig(char* title, int* bignumber, int len, int remainder)
{
	printf("\n[+] %s:\n    0x ", title);
	for(int i=len-1; i>=0; i--)
		printf("%08x ", bignumber[i]);
	printf(", remainder %d\n", remainder);
}

int iszero(int *n, int N)
{
	for(int i=0; i<N; i++)
		if(n[i]) return 0;
	return 1;
}

void iN_to_str(int *n, int N, char *s)
{
	printf("[.] Converting bigint to string...\n");
	// copy n to preserve it
	char tmps[128];
	int counter=0;
	int tmpn[N];
	for(int i=0; i<N; i++)
		tmpn[i] = n[i];
	do
	{
		*(tmps+counter) = div_iN_i32(tmpn, 10, N) + '0';
		counter++;
	}while(!iszero(tmpn, N));
	for(int i=0; i<counter; i++)
		s[i] = tmps[counter-i-1];
	*(s+counter) = '\0';
	
}

void str_to_iN(char *str, int *n, int N)
{
	printf("[.] Converting string to bigint...\n");
	bzero(n, N*sizeof(int)); // n = 0
	while(*str)
	{
		mul_iN_i32(n, 10, N);
		add_iN_i32(n, *str - '0', N);
		str++;
	}
}

int main()
{
	printf("\n");
	printf("  ---------------\n");
	printf("  | 32b version |\n");
	printf("  ---------------\n");
	//int bignumber[] = {0xdeadbeef, 0x11111111, 0x40c0ffee, 0x11111111, 0xabba1773};
	int bignumber[] = {0x44444444, 0x44444444, 0x44444444, 0x44444444};
	//int bignumber[] = {0, 0, 0, 0, 0, 0, 0, 0x80000000}; // 2^255
	//int bignumber[] = {0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0x7fffffff};

	int N = sizeof(bignumber)/sizeof(*bignumber);
	char str[128];
	int divisor = 16;
	int multiplier = 4;
	
	printbig("Big number", bignumber, N, 0);
	add_iN_i32(bignumber, 1, N);	
	printbig("Big number + 1", bignumber, N, 0);
	
	iN_to_str(bignumber, N, str);
	printf("bignumber as str: '%s'\n", str);
	
	int remainder = div_iN_i32(bignumber, divisor, N);
	printbig("Divided", bignumber, N, remainder);
	printf("    (by %d)\n", divisor);
	printf("%s zero\n", (iszero(bignumber, N))?"is":"is not");
	
	iN_to_str(bignumber, N, str);
	printf("divided str: '%s'\n", str);
	
	mul_iN_i32(bignumber, multiplier, N);
	printbig("Multiplied", bignumber, N, 0);
	printf("    (by %d)\n", multiplier);

	str_to_iN(str, bignumber, N);
	printbig("Str as int", bignumber, N, 0);
}
