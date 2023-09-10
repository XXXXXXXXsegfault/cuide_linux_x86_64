
int addr_to_line(int mapfd,long addr,char **pos)
{
	char buf[43];
	char buf2[128];
	unsigned long val;
	int size,size2;
	char *fname,*p;
	fname=NULL;
	lseek(mapfd,0,0);
	while(read(mapfd,buf,42)==42)
	{
		buf[42]=0;
		sinputi(buf,&val);
		if(val>addr)
		{
			goto Found;
		}
		size=read(mapfd,buf2,6);
		if(size<0)
		{
			size=0;
		}
		if(size==6&&!memcmp(buf2,".line ",6))
		{
			sinputi(buf+21,&val);
			free(fname);
			fname=malloc(val+5);
			if(fname==NULL)
			{
				return 1;
			}
			size2=read(mapfd,fname,val-6);
			if(size2<0)
			{
				size2=0;
				free(fname);
				fname=NULL;
			}
			else
			{
				fname[size2]=0;
			}
			lseek(mapfd,-size2,1);
		}
		lseek(mapfd,-size,1);
		sinputi(buf+21,&val);
		lseek(mapfd,val+1,1);
	}
	return 1;
Found:
	if(fname==NULL)
	{
		return 1;
	}
	*pos=fname;
	return 0;
}
int dump_backtrace(char *map,char *out,int pid,int sig)
{
	int fdmap,fdo;
	int dumpsize;
	long fp,pc;
	char *pos;
	char msg[256];
	unsigned long regs[27];
	fdmap=openat(project_dir_fd,map,0,0);
	if(fdmap<0)
	{
		return 1;
	}
	fdo=openat(project_dir_fd,out,578,0644);
	if(fdo<0)
	{
		close(fdmap);
		return 1;
	}
	strcpy(msg,"Program terminated with signal ");
	sprinti(msg,sig,1);
	strcat(msg,"\nBacktrace:\n");
	write(fdo,msg,strlen(msg));
	dumpsize=1024;
	ptrace(PTRACE_GETREGS,pid,0,regs);
	pc=regs[16]; // rip
	fp=regs[4]; // rbp

	while(dumpsize>0)
	{
		if(addr_to_line(fdmap,pc,&pos))
		{
			break;
		}
		write(fdo,pos,strlen(pos));
		write(fdo,"\n",1);
		free(pos);
		if(ptrace(PTRACE_PEEKTEXT,pid,fp+8,&pc))
		{
			break;
		}
		if(ptrace(PTRACE_PEEKTEXT,pid,fp,&fp))
		{
			break;
		}
		--dumpsize;
	}
	close(fdmap);
	close(fdo);
	return 0;
}

int catch_run(int argc,char **argv)
{
	int pid,status;
	long val;
	char msg[256];
	if(argc<4)
	{
		write(1,"Usage: catch <MapFile> <BacktraceDump> <ExecFile> [Args]\n",57);
		return 1;
	}
	status=0;
	pid=fork();
	if(pid<0)
	{
		write(1,"Cannot create process\n",22);
		return 1;
	}
	if(pid>0)
	{
		signal(SIGINT,SIG_IGN);
		pid=waitpid(-1,&status,0x40000000);
		ptrace(PTRACE_SETOPTIONS,pid,0,PTRACE_O_EXITKILL|PTRACE_O_TRACEEXIT);
		ptrace(PTRACE_CONT,pid,0,0);
		strcpy(msg,"\nBacktrace will be dumped to ");
		strcat(msg,argv[2]);
		strcat(msg,"\n\n");
		write(1,msg,strlen(msg));
		do
		{
			if(status>>8==(SIGTRAP|PTRACE_EVENT_EXIT<<8))
			{
				ptrace(PTRACE_GETEVENTMSG,pid,0,&val);
				if(val&=0x7f)
				{
					dump_backtrace(argv[1],argv[2],pid,val);
				}
				return 0;
			}
			if((status&0x7f)==0x7f)
			{
				int sig;
				sig=status>>8&0xff;
				if(sig==SIGTRAP)
				{
					sig=0;
				}
				if(sig!=SIGSTOP&&sig!=SIGTSTP)
				{
					ptrace(PTRACE_CONT,pid,0,sig);
				}
			}
			else
			{
				ptrace(PTRACE_CONT,pid,0,0);
			}
		}
		while((pid=waitpid(-1,&status,0x40000000))>0);
		return 0;
	}
	else
	{
		ptrace(PTRACE_TRACEME,0,0,0);
		kill(getpid(),SIGSTOP);
		close_fds();
		execv(argv[3],argv+3);
		write(1,"Cannot execute file\n",20);
		exit(-1);
	}
}
