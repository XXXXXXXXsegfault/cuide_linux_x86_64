void do_remove(int dirfd,char *name)
{
	struct stat st;
	int fd;
	struct DIR db;
	struct dirent *dir;
	if(fstatatl(dirfd,name,&st,AT_SYMLINK_NOFOLLOW))
	{
		exit(1);
	}
	if((st.mode&0170000)==STAT_DIR)
	{
		fd=openatl(dirfd,name,0,0);
		if(fd<0)
		{
			exit(1);
		}
		dir_init(fd,&db);
		while(dir=readdir(&db))
		{
			if(strcmp(dir->name,".")&&strcmp(dir->name,".."))
			{
				do_remove(fd,dir->name);
			}
		}
		close(fd);
		unlinkatl(dirfd,name,AT_REMOVEDIR);
	}
	else
	{
		unlinkatl(dirfd,name,0);
	}
}
void remove_file(char *name)
{
	while(*name=='/')
	{
		++name;
	}
	if(issubdir(name,"."))
	{
		return;
	}
	do_remove(AT_FDCWD,name);
}
