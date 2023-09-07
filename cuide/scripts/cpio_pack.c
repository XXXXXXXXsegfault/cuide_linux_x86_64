/*
 * NOTE: This implementation has no support for special files other than regular files or directories.
 * */
#include "../include/dirent.c"
#include "../include/mem.c"
#include "../include/path.c"
void store_hex(char *buf,unsigned int val)
{
	char *str;
	str="0123456789ABCDEF";
	buf[7]=str[val&0xf];
	val>>=4;
	buf[6]=str[val&0xf];
	val>>=4;
	buf[5]=str[val&0xf];
	val>>=4;
	buf[4]=str[val&0xf];
	val>>=4;
	buf[3]=str[val&0xf];
	val>>=4;
	buf[2]=str[val&0xf];
	val>>=4;
	buf[1]=str[val&0xf];
	val>>=4;
	buf[0]=str[val&0xf];
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
unsigned int next_ino;
void cpio_entry_add(int fd,struct stat *st,char *path)
{
	unsigned int l,l1;
	struct cpio header;
	l=strlen(path)+1;
	l1=(l+1&0xfffffffc)+2;
	memset(&header,'0',sizeof(header));
	memcpy(header.magic,"070701",6);
	store_hex(header.ino,next_ino);
	++next_ino;
	store_hex(header.mode,st->mode);
	if((st->mode&0170000)==STAT_DIR)
	{
		store_hex(header.nlink,st->nlink);
	}
	else
	{
		store_hex(header.nlink,1);
		store_hex(header.filesize,st->size);
	}
	store_hex(header.namesize,l1);
	write(fd,&header,sizeof(header));
	write(fd,path,l);
	write(fd,"\0\0\0\0",l1-l);
}
void do_cpio_pack(char *name,int dirfd,int fd)
{
	int filefd,type;
	struct stat st;
	struct DIR db;
	struct dirent *dir;
	char *new_name;
	long int l;
	static char fbuf[4096];
	if(fstat(dirfd,&st))
	{
		exit(1);
	}
	cpio_entry_add(fd,&st,name);
	dir_init(dirfd,&db);
	while(dir=readdir(&db))
	{
		if(strcmp(dir->name,".")&&strcmp(dir->name,".."))
		{
			fstatat(dirfd,dir->name,&st,AT_SYMLINK_NOFOLLOW);
			type=st.mode&0170000;
			if(type==STAT_DIR)
			{
				l=strlen(name)+4096+300;
				l-=l&0xfff;
				new_name=mmap(0,l,3,0x22,-1,0);
				if(!valid(new_name))
				{
					exit(1);
				}
				strcpy(new_name,name);
				strcat(new_name,"/");
				strcat(new_name,dir->name);
				filefd=openat(dirfd,dir->name,0,0);
				if(filefd<0)
				{
					exit(1);
				}
				do_cpio_pack(new_name,filefd,fd);
				close(filefd);
				munmap(new_name,l);
			}
			else if(type==STAT_REG)
			{
				l=strlen(name)+4096+300;
				l-=l&0xfff;
				new_name=mmap(0,l,3,0x22,-1,0);
				if(!valid(new_name))
				{
					exit(1);
				}
				strcpy(new_name,name);
				strcat(new_name,"/");
				strcat(new_name,dir->name);
				cpio_entry_add(fd,&st,new_name);
				munmap(new_name,l);
				filefd=openat(dirfd,dir->name,0,0);
				if(filefd<0)
				{
					exit(1);
				}
				while((l=read(filefd,fbuf,4096))>0)
				{
					write(fd,fbuf,l);
				}
				close(filefd);
				l=lseek(fd,0,1);
				if(!valid(l))
				{
					exit(1);
				}
				l&=3;
				if(l)
				{
					write(fd,"\0\0\0\0",4-l);
				}
			}
		}
	}
}
int cpio_pack(char *src,char *dst)
{
	struct stat st;
	int dirfd,fd;
	unsigned int status;
	long int l;
	static char buf[512];
	if(lstatl(src,&st)||(st.mode&0170000)!=STAT_DIR)
	{
		return 1;
	}
	if(issubdir(src,dst)!=0)
	{
		return 1;
	}
	dirfd=openl(src,0,0);
	if(dirfd<0)
	{
		return 1;
	}
	fd=openl(dst,578,0644);
	if(fd<0)
	{
		return 1;
	}
	next_ino=2;
	do_cpio_pack(".",dirfd,fd);
	memset(&st,0,sizeof(st));
	cpio_entry_add(fd,&st,"TRAILER!!!");
	l=lseek(fd,0,1);
	if(!valid(l))
	{
		return 1;
	}
	l=l&511;
	if(l)
	{
		write(fd,buf,512-l);
	}
	return 0;
}
void help(void)
{
	write(1,"Usage: cpio_pack <DIR> <CPIOFILE>\n",34);
}
int main(int argc,char **argv)
{
	if(argc<3)
	{
		help();
		return 1;
	}
	return cpio_pack(argv[1],argv[2]);
}
