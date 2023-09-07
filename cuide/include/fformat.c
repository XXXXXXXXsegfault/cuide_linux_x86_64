#ifndef _FFORMAT_C_
#define _FFORMAT_C_
#include "mem.c"
void sprintF(char *str,float a,int digits1,int digits2)
{
	int l;
	int d;
	float n;
	char c;
	l=strlen(str);
	if(a<0)
	{
		a=-a;
		str[l]='-';
		str[l+1]=0;
		++l;
	}
	n=1.0;
	d=0;
	while(d<digits1)
	{
		n*=10.0;
		++d;
	}
	while(n<=a)
	{
		n*=10.0;
	}
	n*=0.1;
	while(n>=0.5)
	{
		c='0';
		while(a>=n&&c<'9')
		{
			++c;
			a-=n;
		}
		str[l]=c;
		str[l+1]=0;
		++l;
		n*=0.1;
	}
	if(!digits2)
	{
		return 0;
	}
	str[l]='.';
	str[l+1]=0;
	++l;
	d=digits2;
	n=0.001;
	while(d)
	{
		n=n*0.1;
		--d;
	}
	while(digits2)
	{
		a=a*10.0;
		c='0';
		while(a>=1.0-n&&c<'9')
		{
			++c;
			a-=1.0-n;
		}
		str[l]=c;
		str[l+1]=0;
		++l;
		--digits2;
	}
}
char *sinputF(char *str,float *result)
{
	float ret,n;
	char c;
	int s;
	ret=0.0;
	s=0;
	n=0.1;
	while((c=*str)>='0'&&c<='9'||c=='.')
	{
		if(c=='.')
		{
			s=1;
		}
		else if(s)
		{
			ret+=n*(float)(c-'0');
		}
		else
		{
			ret=ret*10.0+(float)(c-'0');
		}
		++str;
	}
	*result=ret;
	return str;
}
#endif
