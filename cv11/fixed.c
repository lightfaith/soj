#include<stdio.h>
#include<math.h>

// FIXED DECIMAL STUFF
#define D 16
#define Z (1 << D) // 2^D

int fl2fix(float x)
{
	return (int)(x*Z);
}

float fix2fl(int fix)
{
	return ((float)fix)/Z;
}

int mulfix(int a, int b)
{
	long long tmp = a;
	tmp*=b;
	tmp>>=D; // divided by Z
	return tmp;
}

int divfix(int a, int b)
{
	long long tmp = a;
	tmp<<=D; // multiplied by Z
	tmp/=b;
	return tmp;
}

void fail()
{
	float x = 0;
	while(1)
	{
		x+=0.1;
		printf("%f\n", x);
	}
}

int main()
{
	printf("\n\n");
	// fail();
	
	// SPHERE VOLUME IN FLOAT AND DECIMAL
	float fl_R = 13;
	float fl_V = 4.0 * M_PI / 3 * fl_R * fl_R * fl_R;

	int fix_R = fl2fix(fl_R);
	int fix_4 = fl2fix(4);
	int fix_3 = fl2fix(3);
	int fix_pi = fl2fix(M_PI);
	int fix_V = fix_R;
	fix_V = mulfix(fix_V, fix_R);
	fix_V = mulfix(fix_V, fix_R);
	fix_V = mulfix(fix_V, fix_pi);
	fix_V = mulfix(fix_V, fix_4);
	fix_V = divfix(fix_V, fix_3);

	printf("fl_V = %f, fix_V = %f\n", fl_V, fix2fl(fix_V));


}
