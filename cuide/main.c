#include "include/malloc.c"
#include "include/mem.c"
#include "include/iformat.c"
#include "include/termios.c"
#include "include/signal.c"
#include "include/stat.c"
#include "include/dirent.c"
#include "include/pcontext.c"

struct winsize winsz;
struct termios term,old_term;
unsigned short *pbuf;
int cursor_x,cursor_y;

void page_putc(char c,int hl,int x,int y);
void page_puts(char *s,int len,int hl,int x,int y);
#include "project.c"

int term_init(void)
{
	if(ioctl(0,TCGETS,&term))
	{
		return 1;
	}
	memcpy(&old_term,&term,sizeof(term));
	term.lflag&=~0xa;
	if(ioctl(0,TCSETS,&term))
	{
		return 1;
	}
	return 0;
}
int getc(void)
{
	int c[1];
	int ret;
	c[0]=0;
	ret=read(0,c,2);
	if(ret<=0)
	{
		return 0;
	}
	if((c[0]&0xff)!=27)
	{
		return c[0]&0xff;
	}
	if((c[0]&0xffff)==27)
	{
		return 27;
	}
	ret=read(0,(char *)c+2,1);
	return c[0]&0xffffff;
}
void page_putc(char c,int hl,int x,int y)
{
	if(x<0||y<0||x>=winsz.col||y>=winsz.row)
	{
		return;
	}
	pbuf[y*(int)winsz.col+x]=(int)c|hl<<8;
}
void page_puts(char *s,int len,int hl,int x,int y)
{
	while(*s&&len)
	{
		page_putc(*s,hl,x,y);
		++x;
		++s;
		if(len>0)
		{
			--len;
		}
	}
}
void display_pbuf(void)
{
	int x,y;
	int c,hl,prev_hl;
	int cx,cy;
	unsigned short *page;
	char buf[4096];
	int bufl;

	page=pbuf;
	cx=cursor_x;
	cy=cursor_y;
	write(1,"\033[?25l\x0f\033[1;1H\033[0m",17);
	y=0;
	prev_hl=0;
	bufl=0;
	while(y<winsz.row)
	{
		x=0;
		while(x<winsz.col)
		{
			c=*page&0xff;
			hl=*page>>8&0xff;
			if(bufl>=4000)
			{
				write(1,buf,bufl);
				bufl=0;
			}
			if(hl!=prev_hl)
			{
				if(hl==0)
				{
					memcpy(buf+bufl,"\033[0m",4);
					bufl+=4;
				}
				else if(hl==1)
				{
					memcpy(buf+bufl,"\033[1m\033[37m\033[40m",14);
					bufl+=14;
				}
			}
			if(c<32||c>126)
			{
				c=32;
			}
			buf[bufl]=c;
			prev_hl=hl;
			++bufl;
			++page;
			++x;
		}
		++y;
	}
	write(1,buf,bufl);
	write(1,"\033[0m",4);
	strcpy(buf,"\033[");
	sprinti(buf,cy+1,1);
	strcat(buf,";");
	sprinti(buf,cx+1,1);
	strcat(buf,"H");
	write(1,buf,strlen(buf));
	write(1,"\033[?25h",6);
}

namespace edit;
#include "edit/main.c"
namespace scpp;
#include "scc/include/lib.c"
#include "scc/scpp/main.c"
namespace scc;
#include "scc/scc_main.c"
namespace assembler;
#include "scc/include/lib.c"
#include "scc/asm/main.c"
namespace;

int exec_cmd(char *s,int size)
{
	char *arg[1030];
	int x;
	if(s[0]=='#')
	{
		return 0;
	}
	write(1,s,strlen(s));
	write(1,"\n",1);
	x=0;
	while(*s)
	{
		while(*s==' '||*s=='\r'||*s=='\t'||*s=='\v')
		{
			++s;
			--size;
		}
		arg[x]=s;
		++x;
		while(*s&&!(*s==' '||*s=='\r'||*s=='\t'||*s=='\v'))
		{
			if(size>0&&*s=='\\'&&*(s+1))
			{
				memmove(s,s+1,size);
				--size;
			}
			++s;
			--size;
		}
		*s=0;
		++s;
	}
	if(!x)
	{
		return 0;
	}
	if(!strcmp(arg[0],"scpp"))
	{
		int pid;
		int ret;
		ioctl(0,TCSETS,&old_term);
		pid=fork();
		if(pid==0)
		{
			if(fchdir(project_dir_fd))
			{
				exit(1);
			}
			signal(SIGINT,SIG_DFL);
			signal(SIGQUIT,SIG_DFL);
			signal(SIGTSTP,SIG_DFL);
			exit(scpp__main(x,arg));
		}
		else if(pid>0)
		{
			waitpid(pid,&ret,0);
			ioctl(0,TCSETS,&term);
		}
		else
		{
			ioctl(0,TCSETS,&term);
			return 1;
		}
		return ret;
	}
	if(!strcmp(arg[0],"scc"))
	{
		int pid;
		int ret;
		ioctl(0,TCSETS,&old_term);
		pid=fork();
		if(pid==0)
		{
			if(fchdir(project_dir_fd))
			{
				exit(1);
			}
			signal(SIGINT,SIG_DFL);
			signal(SIGQUIT,SIG_DFL);
			signal(SIGTSTP,SIG_DFL);
			exit(scc__main(x,arg));
		}
		else if(pid>0)
		{
			waitpid(pid,&ret,0);
			ioctl(0,TCSETS,&term);
		}
		else
		{
			ioctl(0,TCSETS,&term);
			return 1;
		}
		return ret;
	}
	if(!strcmp(arg[0],"asm"))
	{
		int pid;
		int ret;
		ioctl(0,TCSETS,&old_term);
		pid=fork();
		if(pid==0)
		{
			if(fchdir(project_dir_fd))
			{
				exit(1);
			}
			signal(SIGINT,SIG_DFL);
			signal(SIGQUIT,SIG_DFL);
			signal(SIGTSTP,SIG_DFL);
			exit(assembler__main(x,arg));
		}
		else if(pid>0)
		{
			waitpid(pid,&ret,0);
			ioctl(0,TCSETS,&term);
		}
		else
		{
			ioctl(0,TCSETS,&term);
			return 1;
		}
		return ret;
	}
	if(!strcmp(arg[0],"mkdir"))
	{
		int pid;
		int ret;
		ioctl(0,TCSETS,&old_term);
		pid=fork();
		if(pid==0)
		{
			if(fchdir(project_dir_fd))
			{
				exit(1);
			}
			signal(SIGINT,SIG_DFL);
			signal(SIGQUIT,SIG_DFL);
			signal(SIGTSTP,SIG_DFL);

			int ret,x1;
			if(x<2)
			{
				exit(1);
			}
			x1=1;
			while(x1<x)
			{
				ret=mkdir(arg[x1],0755);
				if(ret==-17)
				{
					ret=0;
				}
				++x1;
				if(ret)
				{
					break;
				}
			}
			exit(ret);
		}
		else if(pid>0)
		{
			waitpid(pid,&ret,0);
			ioctl(0,TCSETS,&term);
		}
		else
		{
			ioctl(0,TCSETS,&term);
			return 1;
		}
		return ret;
	}
	arg[x]=NULL;
	int pid;
	int ret;
	ioctl(0,TCSETS,&old_term);
	pid=fork();
	if(pid==0)
	{
		if(fchdir(project_dir_fd))
		{
			exit(1);
		}
		signal(SIGINT,SIG_DFL);
		signal(SIGQUIT,SIG_DFL);
		signal(SIGTSTP,SIG_DFL);
		execv(arg[0],arg);
		exit(1);
	}
	else if(pid>0)
	{
		waitpid(pid,&ret,0);
		ioctl(0,TCSETS,&term);
	}
	else
	{
		ioctl(0,TCSETS,&term);
		return 1;
	}
	return ret;
}

int handle_key(int c)
{
	if(c=='X'||c=='x')
	{
		return 1;
	}
	if(c=='B'||c=='b')
	{
		char buf[1024];
		int buf_size,buf_x;
		char buf2[1200];
		int x;
		int fd;
		buf_size=0;
		buf_x=0;
		x=0;
		fd=openat(project_dir_fd,"build-script",0,0);
		if(fd>=0)
		{
			write(1,"\033[2J\033[1;1H",10);
			while(1)
			{
				if(buf_x==buf_size)
				{
					buf_x=0;
					buf_size=read(fd,buf,1024);
					if(buf_size<=0)
					{
						break;
					}
				}
				buf2[x]=buf[buf_x];
				++buf_x;
				if(buf2[x]=='\n')
				{
					buf2[x]=0;
					buf2[x+1]=0;
					if(exec_cmd(buf2,x+2))
					{
						close(fd);
						project_files_load();
						write(1,"\nPress any key to continue\n",27);
						getc();
						write(1,"\033[2J\033[1;1H",10);
						return 0;
					}
					x=-1;
				}
				if(x<1023)
				{
					++x;
				}
			}
			if(x>0)
			{
				buf2[x]=0;
				buf2[x+1]=0;
				if(exec_cmd(buf2,x+2))
				{
					close(fd);
					project_files_load();
					write(1,"\nPress any key to continue\n",27);
					getc();
					write(1,"\033[2J\033[1;1H",10);
					return 0;
				}
			}
			close(fd);
			project_files_load();
		}
		write(1,"\nPress any key to continue\n",27);
		getc();
		write(1,"\033[2J\033[1;1H",10);
		return 0;
	}
	if(c==4283163) // up
	{
		if(project_file_x)
		{
			--project_file_x;
		}
		return 0;
	}
	if(c==4348699) // down
	{
		++project_file_x;
		return 0;
	}
	if(c==4479771) // left
	{
		project_go_to_parent();
		return 0;
	}
	if(c==4414235) // right
	{
		char *name;
		name=project_open_file();
		if(name)
		{
			char *new_file_name;
			new_file_name=malloc(strlen(current_path)+strlen(name)+5);
			if(new_file_name)
			{
				strcpy(new_file_name,current_path);
				strcat(new_file_name,name);
				edit__edit_file(new_file_name);
				free(new_file_name);
			}
		}
		return 0;
	}
	if(c=='D'||c=='d')
	{
		ioctl(0,TCSETS,&old_term);
		write(1,"\033[2J\033[1;1H",10);
		write(1,"Directory Name: ",16);
		char dir_name[256];
		char c;
		int i;
		i=0;
		while(read(0,&c,1)==1&&c!='\n')
		{
			if(i<255&&c!='/')
			{
				dir_name[i]=c;
				i=i+1;
			}
		}
		dir_name[i]=0;
		char *new_dir_name;
		if(i)
		{
			new_dir_name=malloc(strlen(current_path)+i+5);
			if(new_dir_name)
			{
				strcpy(new_dir_name,current_path);
				strcat(new_dir_name,dir_name);
				mkdirat(project_dir_fd,new_dir_name,0755);
				project_files_load();
				project_file_x=0;
				free(new_dir_name);
			}
		}

		write(1,"\033[2J\033[1;1H",10);
		ioctl(0,TCSETS,&term);
		return 0;
	}
	if(c=='F'||c=='f')
	{
		ioctl(0,TCSETS,&old_term);
		write(1,"\033[2J\033[1;1H",10);
		write(1,"File Name: ",11);
		char file_name[256];
		char c;
		int i;
		i=0;
		while(read(0,&c,1)==1&&c!='\n')
		{
			if(i<255&&c!='/')
			{
				file_name[i]=c;
				i=i+1;
			}
		}
		file_name[i]=0;
		if(i)
		{
			char *new_file_name;
			new_file_name=malloc(strlen(current_path)+i+5);
			if(new_file_name)
			{
				strcpy(new_file_name,current_path);
				strcat(new_file_name,file_name);
				mknodat(project_dir_fd,new_file_name,0100644,0);
				project_files_load();
				project_file_x=0;
				free(new_file_name);
			}
		}
		write(1,"\033[2J\033[1;1H",10);
		ioctl(0,TCSETS,&term);
		return 0;
	}
	return 0;
}
void paint_all(void)
{
	project_files_display();
}
int main(int argc,char **argv)
{
	int c;
	if(argc<2)
	{
		write(1,"Usage: cuide <ProjectDirectory>\n",32);
		write(1,"If <ProjectDirectory> does not exist, a new project will be created.\n",69);
		return 1;
	}
	if(init_project(argv[1]))
	{
		write(1,"Failed to initialize project.\n",30);
		return 1;
	}
	project_files_load();
	signal(SIGINT,SIG_IGN);
	signal(SIGQUIT,SIG_IGN);
	signal(SIGTSTP,SIG_IGN);
	if(ioctl(0,TIOCGWINSZ,&winsz))
	{
		return 1;
	}
	pbuf=malloc(2*(int)winsz.col*(int)winsz.row);
	if(pbuf==NULL)
	{
		return 1;
	}
	if(term_init())
	{
		return 1;
	}
	write(1,"\033[2J\033[1;1H",10);
	memset(pbuf,0,2*(int)winsz.col*(int)winsz.row);
	paint_all();
	display_pbuf();
	while(1)
	{
		c=getc();
		if(handle_key(c))
		{
			break;
		}
		memset(pbuf,0,2*(int)winsz.col*(int)winsz.row);
		paint_all();
		display_pbuf();
	}
	ioctl(0,TCSETS,&old_term);
	write(1,"\033[2J\033[1;1H",10);
	return 0;
}
