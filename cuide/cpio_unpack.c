unsigned int read_hex(char *buf)
{
	unsigned int ret;
	int x;
	x=0;
	ret=0;
	while(x<8)
	{
		if(buf[x]>='0'&&buf[x]<='9')
		{
			ret=ret<<4|(buf[x]-'0');
		}
		else if(buf[x]>='A'&&buf[x]<='F')
		{
			ret=ret<<4|(buf[x]-'A'+10);
		}
		else if(buf[x]>='a'&&buf[x]<='f')
		{
			ret=ret<<4|(buf[x]-'a'+10);
		}
		else
		{
			return 0;
		}
		++x;
	}
	return ret;
}
struct cpio
{
	char magic[6];
	char ino[8];
	char mode[8];
	char uid[8];
	char gid[8];
	char nlink[8];
	char mtime[8];
	char filesize[8];
	char devmajor[8];
	char devminor[8];
	char rdevmajor[8];
	char rdevminor[8];
	char namesize[8];
	char check[8];
};
int cpio_unpack(char *data,long int data_size,char *dst)
{
	int dir,fdo;
	static char buf[4096];
	struct cpio header;
	unsigned int l,mode,l1,size;
	int n;
	char *namebuf,*name;
	mkdirl(dst,0755);
	dir=openl(dst,0,0);
	if(dir<0)
	{
		return 1;
	}
	while(data_size>sizeof(struct cpio))
	{
		memcpy(&header,data,sizeof(struct cpio));
		data+=sizeof(struct cpio);
		data_size-=sizeof(struct cpio);
		if(memcmp(header.magic,"070701",6))
		{
			close(dir);
			return 1;
		}
		mode=read_hex(header.mode);
		l=read_hex(header.namesize);
		l1=l+4096;
		l1-=l1&4095;
		namebuf=mmap(0,l1,3,0x22,-1,0);
		if(!valid(namebuf))
		{
			close(dir);
			return 1;
		}
		if(data_size<l)
		{
			close(dir);
			return 1;
		}
		memcpy(namebuf,data,l);
		data+=l;
		data_size-=l;
		if(!strcmp(namebuf,"TRAILER!!!"))
		{
			close(dir);
			return 0;
		}
		name=namebuf;
		while(*name=='/')
		{
			++name;
		}
		if((mode&0170000)==STAT_DIR)
		{
			mkdiratl(dir,name,mode&07777);
			fchmodatl(dir,name,mode&07777);
		}
		else if((mode&0170000)==STAT_REG)
		{
			size=read_hex(header.filesize);
			fdo=openatl(dir,name,578,mode&07777);
			if(fdo<0)
			{
				close(dir);
				return 1;
			}
			if(size>data_size)
			{
				close(dir);
				close(fdo);
				return 1;
			}
			while(1)
			{
				if(size>4096)
				{
					write(fdo,data,4096);
					size-=4096;
					data+=4096;
					data_size-=4096;
				}
				else
				{
					write(fdo,data,size);
					data+=size;
					data_size-=size;
					break;
				}
			}
			close(fdo);
			size&=3;
			if(size)
			{
				data+=4-size;
				data_size-=4-size;
			}
			fchmodatl(dir,name,mode&07777);
		}
		munmap(namebuf,l1);
	}
	close(dir);
	return 1;
}
int cpio_unpack_to_dir(char *cpio,long size,char *dir)
{
	mkdir(dir,0755);
	return cpio_unpack(cpio,size,dir);
}
