#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<strings.h>
#include<math.h>

int div_iN_i32(int *n, int delitel, int N);
// n = n/delitel, return remainder
int add_iN_i32(int *n, int scitanec, int N);

void mul_iN_i32(int *n, int cinitel, int N);
// n = n*cinitel

int add_iN_iN(int *n1, int *n2, int N);
// arguments must have same size, returns CF
int sub_iN_iN(int *n1, int *n2, int N);

int shr_iN(int *n, int N);
// n = n >> 1, returns CF
int shrd_iN_i32(int *n, int okolik, int N);
// n = n >> okolik (0-31), returns CF
int shl_iN(int *n, int N);
// n = n << 1, returns CF

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
	char tmps[10005];
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



int cmp_iN_iN(int *a, int *b, int N)
{
	int i;
	for(i=N-1; i>=0; i--)
	{
		if(a[i]==b[i]) continue;
		if((unsigned int)a[i]>(unsigned int) b[i]) return 1;
		return -1;
	}
	return 0;
}

void printbig(char* title, int* bignumber, int len, int remainder)
{
	printf("\n[+] %s:\n    0x ", title);
	for(int i=len-1; i>=0; i--)
		printf("%08x ", bignumber[i]);
	printf(", remainder %d\n", remainder);
}


long long mul_i32_i32(int c1, int c2)
{
	// principle
	long long vysledek = 0;
	long long llc1 = c1;     // will be shifted

	while (c2)
	//for(int i=0; i<32; i++)
	{
		if(c2&1) // is odd
			vysledek+=llc1;
		llc1<<=1;
		c2>>=1;
	}
	return vysledek;
}

void mul_iN_iN(int* n1, int* n2, int N)
{
	// backup n2
	int oldn2[N];
	memcpy(oldn2, n2, N*sizeof(int));
	int result[N];
	for(int i=0; i<N; i++)
		result[i]=0;
	
	while(!iszero(n2, N))
	{
		if(n2[0]&1)
		//if(n2[N-1]&1)
 			add_iN_iN(result, n1, N);
		shl_iN(n1, N);
		shr_iN(n2, N);
	}
	memcpy(n1, result, N*sizeof(int));
	memcpy(n2, oldn2, N*sizeof(int));
}


int div_i32_i32(int delenec, int delitel)
{
	int vysledek = 0;
	long long divadlo = delenec;
	int* scena = (int*) &divadlo;
	scena++;
	*scena = 0;
	for(int i=0; i<32; i++)
	{
		divadlo = divadlo << 1;
		vysledek = vysledek << 1;
		if (*scena>=delitel)
		{
			*scena-=delitel;
			vysledek|=1;
		}
	}
	return vysledek;
}

void div_iN_iN(int* n1, int* n2, int N)
{
	int result[N];
	memset(result, 0, N*sizeof(int));
	int divadlo[2*N];
	memset(divadlo, 0, 2*N*sizeof(int));
	memcpy(divadlo, n1, N*sizeof(int));
	int* scena = &divadlo[N];
	//printbig("divadlo", divadlo, 2*N, 0);

	for(int i=0; i<N*sizeof(int)*8; i++)
	{
		//printbig("scena", scena, N, 0);
		shl_iN(divadlo,2*N);
		shl_iN(result, N);
		if(cmp_iN_iN(scena, n2, N)>=0)
		{
			sub_iN_iN(scena, n2, N);
			result[0]|=1;
		}
	}
	memcpy(n1, result, N*sizeof(int));
}

// -------------------------------------------------------
// ---- CV10 ---------------------------------------------
// -------------------------------------------------------

int odm(int x)
{
	long long divadlo = x;
	int* scena = (int*)&divadlo;
	scena++;
	int result = 0;
	for(int i=0; i<32/2; i++)
	{
		divadlo <<=2;
		result <<=1;
		int tmp = (result << 1) | 1; // 2AB + B^2, B=1
		if(*scena>=tmp)
		{
			*scena-=tmp;
			result |= 1;
		}
	}
	return result;
	// remainder is in scena
}

void sqrt_iN(int *n, int N)
{
	int divadlo[2*N];
	bzero(divadlo, sizeof(divadlo));
	memcpy(divadlo, n, N*sizeof(int));
	int* scena = (int*)&divadlo[N];
	//scena++;
	int result[N];
	bzero(result, N*sizeof(int));

	for(int i=0; i<32*N/2; i++)
	{
		shl_iN(divadlo, 2*N);
		shl_iN(divadlo, 2*N);
		shl_iN(result, N);

		int tmp[N];
		memcpy(tmp, result, N*sizeof(int));
		shl_iN(tmp, N);
		tmp[0] |= 1;
		//int tmp = (result << 1) | 1; // 2AB + B^2, B=1
		if(cmp_iN_iN(scena, tmp, N)>=0)
		{
			sub_iN_iN(scena, tmp, N);
			result[0] |= 1;
		}
	}
	memcpy(n, result, N*sizeof(int));
	// remainder is in scena*/
}


#define LEN 270 // for 1000!
void fac(int n)
{
	printf("FAC!\n");
	int result[LEN];
	char s[2570]; // calculated using sum log 10
	bzero(result, sizeof(result));
	result[0]=1;
	for(int i=1; i<=n; i++)
		mul_iN_i32(result, i, LEN);
	iN_to_str(result, LEN, s);
	printf("fac '%s'\n", s); 
}
// euler for 10k digits
void euler()
{
	printf("EULER!\n");
	const int iLEN = 1040;
	const int sLEN = 10000+2;
	char sK[sLEN], se[sLEN];
	int iK[iLEN], e[iLEN], itmp[iLEN], ifak[iLEN];
	memset(sK, '0', 10001); sK[10001]='\0'; sK[0] = '1'; // 1*10^10000
	str_to_iN(sK, iK, iLEN);
	
	memcpy(e, iK, iLEN * sizeof(int));
	mul_iN_i32(e, 2, iLEN);
	bzero(ifak, sizeof(ifak));
	
	ifak[0] = 1;
	for(int i=2; i<10; i++)
	{
		memcpy(itmp, iK, sizeof(iK)); // itmp = iK
		mul_iN_i32(ifak, i, iLEN);
		int tmpfak[iLEN];
		memcpy(tmpfak, ifak, sizeof(ifak));
		div_iN_iN(itmp, tmpfak, iLEN);
		add_iN_iN(e, itmp, iLEN);
	}
	iN_to_str(e, iLEN, se);
	//printf("e='%s'\n", se);
}


void ludolf()
{
	printf("LUDOLF!\n");
	const int iLEN = 1040;
	const int sLEN = 10000+2;
	char sK[sLEN], spi[sLEN];
	int iK[iLEN], i2K[iLEN], i4K[iLEN], pi[iLEN], itmp[iLEN], itotaltmp[iLEN];

	memset(sK, '0', 10001); sK[10001]='\0'; sK[0]='1';
	str_to_iN(sK, iK, iLEN);
	memcpy(i2K, iK, sizeof(iK));
	memcpy(i4K, iK, sizeof(iK));
	mul_iN_i32(i2K, 2, iLEN);
	mul_iN_i32(i4K, 4, iLEN);
	//printbig("\n\nK", iK, iLEN, 0);
	//printbig("\n\n2K", i2K, iLEN, 0);
	//printbig("\n\n4K", i4K, iLEN, 0);
	
	bzero(pi, sizeof(pi));
	for(int i=0; i<100; i++)
	{
		bzero(itotaltmp, iLEN*sizeof(int));
		memcpy(itmp, i4K, sizeof(itmp));
		//printbig("\n\ntmp", itmp, iLEN, 0);
		div_iN_i32(itmp, 8*i+1, iLEN);
		add_iN_iN(itotaltmp, itmp, iLEN);
		
		memcpy(itmp, i2K, sizeof(itmp));
		div_iN_i32(itmp, 8*i+4, iLEN);
		sub_iN_iN(itotaltmp, itmp, iLEN);

		memcpy(itmp, iK, sizeof(itmp));
		div_iN_i32(itmp, 8*i+5, iLEN);
		sub_iN_iN(itotaltmp, itmp, iLEN);

		memcpy(itmp, iK, sizeof(itmp));
		div_iN_i32(itmp, 8*i+6, iLEN);
		sub_iN_iN(itotaltmp, itmp, iLEN);

		for(int j=0; j<i*4; j++)
			shr_iN(itotaltmp, iLEN);
			
		//printbig("\n\nTOTALTMP", itotaltmp, iLEN, 0);
		add_iN_iN(pi, itotaltmp, iLEN);
	//iN_to_str(pi, iLEN, spi);
	//printf("PI: %s\n", spi);
	}
	iN_to_str(pi, iLEN, spi);
	printf("PI: %s\n", spi);
}
// *******************************************************


int main()
{
	printf("\n");
	printf("  ---------------\n");
	printf("  | 32b version |\n");
	printf("  ---------------\n");
	//int bignumber[] = {0xdeadbeef, 0x11111111, 0x40c0ffee, 0x11111111, 0xabba1773};
	int bignumber[] = {0x44444444, 0x44444444, 0x44444444, 0x44444444};
	int bignumber2[] = {0x44444444, 0x44444444, 0x44444444, 0x44444444};
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

	printf("\n============= CV09 =============\n\n");
	char s1[128] = "999999999999999999999999999999999999999999999999999";
	char s2[128] = "111111111111111111111111111111111111111111111111111";
	char s3[128];
	N = 8;
	int n1[N], n2[N];
	str_to_iN(s1, n1, N);
	str_to_iN(s2, n2, N);
	
	add_iN_iN(n1, n2, N);
	iN_to_str(n1, N, s3);
	
	printf("added '%s'\n", s3);
	sub_iN_iN(n1, n2, N);
	iN_to_str(n1, N, s3);
	printf("subbed '%s'\n", s3);
	
	memcpy(n2, n1, sizeof(n1));
	str_to_iN(s1,n1, N);
	shr_iN(n1, N);
	iN_to_str(n1, N, s3);
	printf("shr    '%s'\n", s3);
	
	memcpy(n2, n1, sizeof(n1));
	str_to_iN(s1, n1, N);
	shl_iN(n1, N);
	iN_to_str(n1, N, s3);
	printf("shl    '%s'\n", s3);


	strcpy(s1, "5000000000");
	str_to_iN(s1, n1, N);
	shrd_iN_i32(n1, 2, N);
	iN_to_str(n1, N, s3);
	printf("shrd    '%s'\n", s3);

	printf("mul_i32_i32: %Ld\n", mul_i32_i32(13, 379));
	printf("mul_i32_i32: %Ld\n", mul_i32_i32(1000000, 1000000));
	printf("div_i32_i32: %d\n", div_i32_i32(4927, 379));

	//  = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
	int a[] = {0x44444444, 0x44444444, 0x44444444, 0x44444444};
	//int b[] = {0x22222222, 0x22222222, 0x22222222, 0x22222222};
	//int a[] = {0x00000000, 0x00000000, x00000000, `0x44444444};
	int b[] = {0x0000002, 0x00000000, 0x00000000, 0x00000000};
	N = sizeof(a)/sizeof(*a);
	mul_iN_iN(a, b, N);
	printbig("mul_iN_iN", a, N, 0);
	div_iN_iN(a, b, N);
	printbig("div_iN_iN", a, N, 0);
	div_iN_iN(a, b, N);
	printbig("div_iN_iN", a, N, 0);
	
	printf("\n============= CV10 =============\n\n");
	int num = 901;
	printf("Sqrt(%d) = %d\n", num, odm(num));

	// number of digits of a number
	double sum2 = 0, sum10 = 0;
	for(int i=1; i<=1000; i++)
	{
		sum2 += log2(i);
		sum10 += log10(i);
		// log2 <-> log10 constants
	}
	printf("log2(10) = %f, log10(2) = %f\n", log2(10), log10(2));
	printf("sum2 = %f, sum10 = %f, number of ints: %f\n", sum2, sum10, sum2/32);
	//fac(1000);
	//euler();
	ludolf();
	//char snumtosqrt[] = "10000000000";
	char snumtosqrt[] = "100000000";
	int numtosqrt[8];
	str_to_iN(snumtosqrt, numtosqrt, 8);
	sqrt_iN(numtosqrt, 8);
	iN_to_str(numtosqrt, 8, snumtosqrt);
	printf("Sqrted: %s\n", snumtosqrt);
}
