int init_project(char *dir,char *new_project_type)
{
	int ret;
	int fd;
	struct stat st;
	struct project_file_list *node,*p,*pp;
	ret=stat(dir,&st);
	if(ret==-2)
	{
		if(new_project_type==NULL)
		{
			return 1;
		}
		mkdir(dir,0755);
		project_dir_fd=open(dir,0,0);
		if(project_dir_fd<0)
		{
			return 1;
		}
		fd=openat(project_dir_fd,"build-script",578,0644);
		if(fd<0)
		{
			return 1;
		}
		write(fd,"# Write your build commands here.\n",34);
		write(fd,"# Internal commands:\n",21);
		write(fd,"# scpp, scc, asm -- internal compilers (See manual pages for usage)\n",68);
		write(fd,"# catch -- run a program and catch exceptions like SIGSEGV (used with SCC)\n",75);
		write(fd,"# mkdir -- create directories\n",30);
		write(fd,"# remove -- remove files or directories\n",40);
		write(fd,"# rename -- rename file or directory\n",37);
		if(!strcmp(new_project_type,"scc"))
		{
			write(fd,"mkdir tmp\n",10);
			write(fd,"scpp main.c tmp/main.i\n",23);
			write(fd,"scc tmp/main.i tmp/main.asm\n",28);
			write(fd,"asm tmp/main.asm tmp/main.elf tmp/main.map\n",43);
			write(fd,"catch tmp/main.map tmp/main.dump tmp/main.elf\n",46);
		}
		close(fd);
		if(!strcmp(new_project_type,"scc"))
		{
			char *new_dir;
			fd=openat(project_dir_fd,"main.c",578,0644);
			if(fd<0)
			{
				return 1;
			}
			write(fd,"#include \"include/syscall.c\"\n",29);
			write(fd,"int main(void)\n",15);
			write(fd,"{\n",2);
			write(fd,"\twrite(1,\"Welcome to CUIDE\\n\",17);\n",35);
			write(fd,"\treturn 0;\n",11);
			write(fd,"}\n",2);
			close(fd);
			new_dir=malloc(strlen(dir)+30);
			if(new_dir==NULL)
			{
				return 1;
			}
			strcpy(new_dir,dir);
			strcat(new_dir,"/include");
			if(cpio_unpack_to_dir((char *)include_cpio_start,(long)include_cpio_end-(long)include_cpio_start,new_dir))
			{
				free(new_dir);
				return 1;
			}
			free(new_dir);
		}
	}
	else if(ret==0&&(st.mode&0170000)==STAT_DIR)
	{
		project_dir_fd=open(dir,0,0);
		if(project_dir_fd<0)
		{
			return 1;
		}
	}
	else
	{
		return 1;
	}
	if(faccessat(project_dir_fd,"build-script",6,0))
	{
		return 1;
	}
	strcpy(current_path,"./");
	return 0;
}

struct project_file
{
	char name[256];
	long is_dir;
	struct project_file *next;
} *project_files;
void project_files_load(void)
{
	struct project_file *node,*p,*pp;
	struct DIR db;
	struct dirent *dir;
	struct stat st;
	int fd;
	while(node=project_files)
	{
		project_files=node->next;
		free(node);
	}
	fd=openat(project_dir_fd,current_path,0,0);
	if(fd<0)
	{
		return;
	}
	dir_init(fd,&db);
	while(dir=readdir(&db))
	{
		if(strcmp(dir->name,".")&&strcmp(dir->name,".."))
		{
			if(!fstatat(fd,dir->name,&st,AT_SYMLINK_NOFOLLOW)&&((st.mode&0170000)==STAT_REG||(st.mode&0170000)==STAT_DIR))
			{
				node=malloc(sizeof(*node));
				if(node!=NULL)
				{
					strcpy(node->name,dir->name);
					if((st.mode&0170000)==STAT_DIR)
					{
						node->is_dir=1;
					}
					else
					{
						node->is_dir=0;
					}
					pp=NULL;
					p=project_files;
					while(p)
					{
						if(strcmp(p->name,node->name)>0)
						{
							break;
						}
						pp=p;
						p=p->next;
					}
					if(pp)
					{
						pp->next=node;
					}
					else
					{
						project_files=node;
					}
					node->next=p;
				}
			}
		}
	}
	close(fd);
}
void project_files_display(void)
{
	int i,j;
	struct project_file *node;
	cursor_x=0;
	cursor_y=0;
	page_puts("X -- quit; UP/DOWN -- scroll up/down; RIGHT -- open; D -- new directory;",-1,1,1,0);
	page_puts("LEFT -- go to parent directory; F -- new file; B -- run build script",-1,1,1,1);
	page_puts("^ -- remove file permanently",-1,1,1,2);
	page_puts("Please read manual pages before using this program.",-1,1,1,4);
	page_puts(current_path+1,-1,0,1,6);
	while(1)
	{
		i=0;
		node=project_files;
		while(node&&i<project_file_x)
		{
			++i;
			node=node->next;
		}
		if(node==NULL)
		{
			if(project_file_x==0)
			{
				return;
			}
			--project_file_x;
		}
		else
		{
			break;
		}
	}
	i=0;
	node=project_files;
	while(node&&i<project_file_x-(int)winsz.row/2-4)
	{
		++i;
		node=node->next;
	}
	j=7;
	while(node&&j<winsz.row)
	{
		if(node->is_dir)
		{
			page_puts("[DIR ]",-1,i==project_file_x,1,j);
		}
		else
		{
			page_puts("[FILE]",-1,i==project_file_x,1,j);
		}
		page_puts(node->name,-1,i==project_file_x,9,j);
		if(i==project_file_x)
		{
			cursor_y=j;
		}
		++j;
		++i;
		node=node->next;
	}
	cursor_x=2;
}


struct project_file *project_file_current(void)
{
	int i,j;
	struct project_file *node;
	while(1)
	{
		i=0;
		node=project_files;
		while(node&&i<project_file_x)
		{
			++i;
			node=node->next;
		}
		if(node==NULL)
		{
			if(project_file_x==0)
			{
				return NULL;
			}
			--project_file_x;
		}
		else
		{
			break;
		}
	}
	i=0;
	node=project_files;
	while(node&&i<project_file_x-(int)winsz.row/2-4)
	{
		++i;
		node=node->next;
	}
	j=5;
	while(node&&j<winsz.row)
	{
		if(i==project_file_x)
		{
			return node;
		}
		++i;
		++j;
		node=node->next;
	}
	return NULL;
}

char *project_open_file(void)
{
	int i;
	struct project_file *node;
	i=0;
	node=project_files;
	while(node&&i<project_file_x)
	{
		++i;
		node=node->next;
	}
	if(node==NULL)
	{
		return NULL;
	}
	if(strlen(current_path)+strlen(node->name)>4000)
	{
		return NULL;
	}
	if(node->is_dir)
	{
		strcat(current_path,node->name);
		strcat(current_path,"/");
		project_file_x=0;
		project_files_load();
		return NULL;
	}
	else
	{
		return node->name;
	}
}
void project_go_to_parent(void)
{
	int l;
	l=strlen(current_path);
	if(l==2)
	{
		return;
	}
	--l;
	while(current_path[l-1]!='/')
	{
		--l;
	}
	current_path[l]=0;
	project_file_x=0;
	project_files_load();
}
long get_edit_cursor_pos(long dev,long ino)
{
	long val[3];
	int fd;
	fd=openat(project_dir_fd,"_cursor_record",0,0);
	if(fd<0)
	{
		return 0;
	}
	while(read(fd,&val,sizeof(val))==sizeof(val))
	{
		if(val[0]==ino&&val[1]==dev)
		{
			close(fd);
			return val[2];
		}
	}
	close(fd);
	return 0;
}
void set_edit_cursor_pos(long dev,long ino,long pos)
{
	long val[3];
	int fd;
	if(pos<0)
	{
		return;
	}
	fd=openat(project_dir_fd,"_cursor_record",66,0644);
	if(fd<0)
	{
		return;
	}
	while(read(fd,val,sizeof(val))==sizeof(val))
	{
		if(val[0]==ino&&val[1]==dev)
		{
			lseek(fd,-sizeof(val),1);
			val[2]=pos;
			write(fd,val,sizeof(val));
			close(fd);
			return;
		}
	}
	val[0]=ino;
	val[1]=dev;
	val[2]=pos;
	write(fd,val,sizeof(val));
	close(fd);
}
