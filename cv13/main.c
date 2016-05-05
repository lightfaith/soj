#include<stdio.h>
#include<stdlib.h>
#include<math.h>

#ifdef __cplusplus
extern "C" { // will be compiled as C, not C++ (no overrides etc.)
			 // but cannot be in C sources => #ifdef
#endif
double pi = 3.14159265358979323846;
float retfl(float a);
double retdbl(double a);
double fl2dbl(float a);

double obvod(double r, double pi);
int fl2i(float a); // this is actually ROUND!

float prumer(float* p, int N);
float max(float* p, int N);
float arrsum(float* p, int N);
// - - - - - - - - - - - - - - - - - - 
double vsphere(double r, double pi);
float pytha(float a, float b);
void vecsum(double* a, double *b, int N);
double vecsize(double *v, int N);
#ifdef __cplusplus
}
#endif

// - - - - - - - - - - - - - - - - - - 

int main()
{
	printf("\n\n\nretfl: %f\n", retfl((float)pi));	
	printf("retdbl: %f\n", retdbl(pi));	
	printf("fl2dbl: %f\n", fl2dbl((float)pi));	

	printf("\nobvod: %f\n", obvod(5, M_PI));
	printf("fl2i: %d, %d, %d\n", fl2i(3.14), fl2i(3.5), fl2i(3.51));
	float floatnums[] = {1.1, 2.2, 3.9, -2, 1, 9, 10, 88, 9, 10, -6, 12};

	printf("\navg: %f\n", prumer(floatnums, sizeof(floatnums)/sizeof(*floatnums)));
	printf("\nmax: %f\n", max(floatnums, sizeof(floatnums)/sizeof(*floatnums)));
	printf("\narrsum: %f\n", arrsum(floatnums, sizeof(floatnums)/sizeof(*floatnums)));

	printf("\n--------------------------------\n");

	printf("\nvsphere: %f\n", vsphere(5, M_PI));
	printf("pytha(3, 4): %f\n", pytha(3.0, 4.0));
	double veca[] = {3.0, 1.0, 5.0};
	double vecb[] = {2.0, -2.0, 1.0};
	int veclen = 3;

	vecsum(veca, vecb, veclen);
	printf("vecsum:  ");
	for(int i=0; i<veclen; i++)
		printf("%f   ", veca[i]);
	printf("\nvecsize: %f\n", vecsize(veca, veclen));


}
