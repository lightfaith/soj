#include<stdio.h>
#include<math.h>

struct _kuchfl
{
	unsigned int m:23; // 23b
    unsigned int e:8;  // 8b
	unsigned int s:1;  // 1b
	// LIKE WHAT???????
};

struct _kuchint
{
	unsigned int m:23; // 23b
    unsigned int m1:9;  // 8b
	// LIKE WHAT???????
};

union kuchfl
{
	_kuchfl k;
	float f;
};

union kuchint
{
	_kuchint k;
	int i;
};

void printkuchhex(const char* prompt, kuchfl x)
{
	printf("%s %f <=> (s = %x, e = %x, m = %x)\n", prompt, x.f, x.k.s, x.k.e, x.k.m);
}

void printkuch(const char* prompt, kuchfl x)
{
	printf("%s %f <=> (s = %d, e = %d, m = %d)\n", prompt, x.f, x.k.s, x.k.e, x.k.m);
}

kuchfl getkuch(int s, int e, int m)
{
	kuchfl result;
	result.k.s = s;
	result.k.e = e;
	result.k.m = m;
	return result;
}

kuchfl getkuch(float f)
{
	kuchfl result;
	result.f = f;
	return result;
}

float mulfl(float a, float b)
{
	kuchfl ka = getkuch(a);
	kuchfl kb = getkuch(b);
	kuchfl kc;

	kc.k.s = (ka.k.s + kb.k.s)%2;
	kc.k.e = ka.k.e + kb.k.e - 127;
	
	kuchint ta, tb, tc;
	ta.k.m = ka.k.m;
	ta.k.m1 = 1;
	tb.k.m = kb.k.m;
	tb.k.m1 = 1;
	long long tmp = ta.i; // fix*fix
	tmp*=tb.i;
	tmp>>=23;             // see mulfix
	tc.i = tmp;
	if(tc.k.m1 >= 2)       // too big, normalize Dark Mantis, dark fate of Atlantis
	{
		tc.i >>= 1;	
		kc.k.e++;         // because shifted
	}
	kc.k.m = tc.k.m;
	return kc.f;
	
}

float divfl(float a, float b)
{
	kuchfl ka = getkuch(a);
	kuchfl kb = getkuch(b);
	kuchfl kc;

	kc.k.s = (ka.k.s + kb.k.s)%2;
	kc.k.e = ka.k.e - kb.k.e + 127;
	
	kuchint ta, tb, tc;
	ta.k.m = ka.k.m;
	ta.k.m1 = 1;
	tb.k.m = kb.k.m;
	tb.k.m1 = 1;
	long long tmp = ta.i; // fix/fix
	tmp<<=23;             
	tmp/=tb.i;
	tc.i = tmp;
	if(tc.k.m1 < 1)       // too small, normalize Dark Mantis, dark fate of Atlantis
	{
		tc.i <<= 1;	
		kc.k.e--;         // because shifted
	}
	kc.k.m = tc.k.m;
	return kc.f;	
}

float addfl(float a, float b)
{
	kuchfl ka = getkuch(a);
	kuchfl kb = getkuch(b);
	printf("\n");printkuch("[.]", ka);
	printkuch("[.]", kb);
	kuchfl result;
	int q = ka.k.e - kb.k.e;
	//bool swap = false;
	int sha=0;
	int shb=0;
	if(q<0)
	{
	//	swap = true;
		q*=-1;
		ka.k.e+=q;
		ka.k.m>>=q;
		ka.k.m|=(1<<(23-q));
		sha=q;
	}
	else if(q>0)
	{
		kb.k.e+=q;
		kb.k.m>>=q;
		kb.k.m|=(1<<(23-q));
		shb=q;
	}
	else
	{
		ka.k.e+=1;
		kb.k.e+=1;
	}
	
	if(ka.k.s + kb.k.s==0)
		result.k.s = 0;
	else if(ka.k.s+kb.k.s==2)
		result.k.s = 1;
	else
	{
		//TODO
	}

	result.k.e = ka.k.e;
	printf("After exponent normalization:\n");
	printkuch("[.]", ka);
	printkuch("[.]", kb);
	printf("sha = %d, shb = %d, q = %d\n", sha, shb, q);
	
	kuchint tmp;
	tmp.i = 0;
//	tmp.k.m1 = 1;
	/*for(int i=0; i<4; i++)
	{
		printf("%02x ", (tmp.i>>(i*8))&0xff);
	}
	printf("\n");
	*/tmp.i = ka.k.m;
	if(q==0)
		tmp.i += 1<<23;
	else
		tmp.i += 1<<23;
		
	printf("i = %08x, m1 = %d, m = %d\n", tmp.i, tmp.k.m1, tmp.k.m);	
	/*for(int i=0; i<4; i++)
	{
		printf("%02x ", (tmp.i>>(i*8))&0xff);
	}
	*/
	printf("Adding %d\n", kb.k.m);
	tmp.i += kb.k.m;
	/*printf("\n");
	for(int i=0; i<4; i++)
	{
		printf("%02x ", (tmp.i>>(i*8))&0xff);
	}
	printf("\n");
	printf("tmp.m1 = %d\n", tmp.k.m1);
	*/
	printf("i = %08x, m1 = %d, m = %d\n", tmp.i, tmp.k.m1, tmp.k.m);	
	printf("i = %08x, m1 = %d, m = %d\n", tmp.i, tmp.k.m1, tmp.k.m);	
	while(tmp.k.m1>1)
	{
		tmp.i>>=1;
		result.k.e++;
	}
	while(tmp.k.m1<1)
	{
		tmp.i<<=1;
		result.k.e--;
	}
	result.k.m = tmp.k.m;

	return result.f;
}


int main()
{
	printf("\n\n");
	printkuch("[+]", getkuch(1.0));
	printkuch("[+]", getkuch(0.1));
	printkuchhex("[+]", getkuch(0.1));
	printkuch("[+]", getkuch(0, 125, 0));
	printkuch("[+]", getkuch(0, 128, 1.14*(1<<22)));
	
	printf("\n\n.:MULFL!:.\n");
	printkuch("[+]", getkuch(mulfl(1.0, 2.0)));
	printkuch("[+]", getkuch(mulfl(13.0, 379.0)));
	printkuch("[+]", getkuch(mulfl(-12.0, 12.0)));
	printkuch("[+]", getkuch(mulfl(-1.2, 1.2)));

	printf("\n\n.:DIVFL!:.\n");
	printkuch("[+]", getkuch(divfl(2.0, 2.0)));
	printkuch("[+]", getkuch(divfl(3.0, 1.0)));
	printkuch("[+]", getkuch(divfl(3.0, 2.0)));
	printkuch("[+]", getkuch(divfl(33.3, 11.1)));
	printkuch("[+]", getkuch(divfl(16.0, 8.0)));
	printkuch("[+]", getkuch(divfl(4.0, 1.0)));
	printkuch("[+]", getkuch(divfl(4.0, 2.0)));
	printkuch("[+]", getkuch(divfl(492.70, 1.30)));
	printkuch("[+]", getkuch(divfl(-144.0, 1.2)));

	printf("\n\n.:ADDFL!:.\n");
	printkuch("[+]", getkuch(addfl(4.0, 4.0)));
	printkuch("[+]", getkuch(addfl(5.0, 7.0)));
	printkuch("[+]", getkuch(addfl(13.0, 287.0)));
	printkuch("[+]", getkuch(addfl(1.0, 2.0)));

	printf("\n");
}


