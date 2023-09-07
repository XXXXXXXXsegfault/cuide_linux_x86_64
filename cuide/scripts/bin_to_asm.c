#include "../include/syscall.c"
#include "../include/iformat.c"
int main(int argc,char **argv)
{
	unsigned char buf[32];
	int x,size;
	int fd,fdo;
	if(argc<4)
	{
		write(1,"Usage: bin_to_asm <FILE> <ASMFILE> <TAG>\n",41);
		return 1;
	}
	fd=open(argv[1],0,0);
	if(fd<0)
	{
		return 1;
	}
	fdo=open(argv[2],578,0644);
	if(fdo<0)
	{
		return 1;
	}
	write(fdo,"asm \"@",6);
	write(fdo,argv[3],strlen(argv[3]));
	write(fdo,"_start\"\n",8);
	while((size=read(fd,buf,32))>0)
	{
		write(fdo,"asm \".byte ",11);
		x=0;
		while(x<size)
		{
			char buf2[32];
			buf2[0]=0;
			sprinti(buf2,buf[x],1);
			write(fdo,buf2,strlen(buf2));
			++x;
			if(x!=size)
			{
				write(fdo,",",1);
			}
		}
		write(fdo,"\"\n",2);
	}
	write(fdo,"asm \"@",6);
	write(fdo,argv[3],strlen(argv[3]));
	write(fdo,"_end\"\n",6);
	write(fdo,"void ",5);
	write(fdo,argv[3],strlen(argv[3]));
	write(fdo,"_start(void);\n",14);
	write(fdo,"void ",5);
	write(fdo,argv[3],strlen(argv[3]));
	write(fdo,"_end(void);\n",12);
	return 0;
}
