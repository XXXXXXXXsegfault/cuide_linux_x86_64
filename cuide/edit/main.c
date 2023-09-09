char *file_name;
int current_x;
#include "file.c"

int mode; // 0 -- normal, 1 -- insert, 2 -- select, 3 -- command
int prev_mode;
char *clipboard;
unsigned long int clipboard_size;
char cmd_buf[64];
int cmd_size;

#include "cmd.c"
#include "undo.c"
int if_selected(struct file_pos *end,struct file_pos *pos)
{
	if(mode!=2)
	{
		return 0;
	}
	if(end->off<select_pos.off)
	{
		if(pos->off>=end->off&&pos->off<=select_pos.off)
		{
			return 1;
		}
	}
	else
	{
		if(pos->off<=end->off&&pos->off>=select_pos.off)
		{
			return 1;
		}
	}
	return 0;
}
void copy_selected_str(void)
{
	unsigned long int end_off;
	struct file_pos pos;
	int c;
	if(select_pos.off<current_pos.off)
	{
		end_off=current_pos.off;
		memcpy(&pos,&select_pos,sizeof(pos));
	}
	else
	{
		end_off=select_pos.off;
		memcpy(&pos,&current_pos,sizeof(pos));
	}
	free(clipboard);
	clipboard_size=0;
	clipboard=malloc(end_off-pos.off);
	if(clipboard==NULL)
	{
		return;
	}
	while(pos.off<=end_off)
	{
		c=file_getc(&pos);
		if(c==-1)
		{
			break;
		}
		clipboard[clipboard_size]=c;
		++clipboard_size;
		if(!file_pos_move_right(&pos))
		{
			break;
		}
	}
}
void del_selected_str(void)
{
	unsigned long int size,x;
	struct file_pos pos;
	int c1;
	if(select_pos.off<current_pos.off)
	{
		size=current_pos.off-select_pos.off+1;
		cursor_right();
		current_x_refine();
	}
	else
	{
		size=select_pos.off-current_pos.off+1;
		x=size;
		while(x)
		{
			cursor_right();
			current_x_refine();
			--x;
		}
	}
	while(size)
	{
		memcpy(&pos,&current_pos,sizeof(pos));
		if(file_pos_move_left(&pos))
		{
			c1=file_getc(&pos);
			op_push(c1|0x100,pos.off);
		}
		delc();
		current_x_refine();
		--size;
	}
}

void display_file(void)
{
	struct file_pos pos;
	int x,y;
	int cx,cy;
	int c;
	memset(pbuf,0,2*(int)winsz.col*(int)winsz.row);
	if(winsize_change)
	{
		int off;
		off=current_pos.off;
		winsize_change=0;
		view_pos.block=file_head;
		view_pos.off=0;
		view_pos.pos=0;
		current_pos.block=file_head;
		current_pos.off=0;
		current_pos.pos=0;
		current_x=0;
		current_pos_end=0;
		while(off)
		{
			cursor_right();
			current_x_refine();
			--off;
		}
	}
	memcpy(&pos,&view_pos,sizeof(pos));
	y=0;
	cx=-1;
	cy=0;
retry:
	while(y<winsz.row-1)
	{
		x=current_x;
		while(x)
		{
			c=file_getc(&pos);
			if(c=='\n')
			{
				++y;
				if(!file_pos_move_right(&pos))
				{
					goto End;
				}
				goto retry;
			}
			if(!file_pos_move_right(&pos))
			{
				goto End;
			}
			--x;
		}
		while(x<winsz.col)
		{
			c=file_getc(&pos);
			if(c=='\n')
			{
				if(pos.off==current_pos.off)
				{
					page_putc(c,4,x,y);
					cx=x;
					cy=y;
				}
				x=0;
				++y;
				if(!file_pos_move_right(&pos))
				{
					goto End;
				}
				goto retry;
			}
			if(c>=32&&c<=126)
			{
				if(pos.off==current_pos.off)
				{
					page_putc(c,4,x,y);
					cx=x;
					cy=y;
				}
				else if(if_selected(&current_pos,&pos))
				{
					page_putc(c,5,x,y);
				}
				else
				{
					page_putc(c,0,x,y);
				}
			}
			else if(c=='\t')
			{
				if(pos.off==current_pos.off)
				{
					page_putc(32,4,x,y);
					cx=x;
					cy=y;
				}
				else
				{
					page_putc(32,2,x,y);
				}
			}
			else
			{
				if(pos.off==current_pos.off)
				{
					page_putc(32,4,x,y);
					cx=x;
					cy=y;
				}
				else
				{
					page_putc(32,3,x,y);
				}
			}
			if(!file_pos_move_right(&pos))
			{
				goto End;
			}
			++x;
		}
		while(c!='\n')
		{
			c=file_getc(&pos);
			if(!file_pos_move_right(&pos))
			{
				goto End;
			}
		}
		++y;
	}
End:
	if(cx==-1&&current_pos_end)
	{
		cursor_x=x;
		cursor_y=y;
		page_putc(32,4,x,y);
	}
	y=winsz.row-1;
	if(mode==1)
	{
		page_puts("Insert",6,1,0,winsz.row-1);
	}
	else if(mode==2)
	{
		page_puts("Select",6,1,0,winsz.row-1);
	}
	else if(mode==3)
	{
		page_putc('>',1,0,winsz.row-1);
		page_puts(cmd_buf,cmd_size,1,1,winsz.row-1);
	}
	if(cx!=-1)
	{
		cursor_x=cx;
		cursor_y=cy;
		nocursor=0;
	}
	else
	{
		nocursor=1;
	}
}
void keypress_handler(int c)
{
	if(c==27)
	{
		if(mode==1||mode==2)
		{
			mode=0;
		}
		return;
	}
	if(c==4283163)
	{
		cursor_up();
		current_x_refine();
		return;
	}
	if(c==4348699)
	{
		cursor_down();
		current_x_refine();
		return;
	}
	if(c==4479771)
	{
		cursor_left();
		current_x_refine();
		return;
	}
	if(c==4414235)
	{
		cursor_right();
		current_x_refine();
		return;
	}
	if(mode==0||mode==2)
	{
		if(c=='W'&&mode==0)
		{
			save_file();
		}
		else if(c=='I'&&mode==0)
		{
			mode=1;
		}
		else if(c=='S'&&mode==0)
		{
			mode=2;
			memcpy(&select_pos,&current_pos,sizeof(current_pos));
		}
		else if(c=='P'&&mode==0)
		{
			int x;
			x=0;
			while(x<clipboard_size)
			{
				if(current_pos_end)
				{
					op_push(clipboard[x],current_pos.off+1);
					addc_end(clipboard[x]);
					current_pos_end=0;
					cursor_right();
					current_pos_end=1;
				}
				else
				{
					op_push(clipboard[x],current_pos.off);
					addc(clipboard[x]);
				}
				current_x_refine();
				++x;
			}
		}
		else if(c=='>')
		{
			prev_mode=mode;
			mode=3;
			cmd_size=0;
		}
		else if(c=='U'&&mode==0)
		{
			undo();
		}
		else if(c=='R'&&mode==0)
		{
			redo();
		}
		else if(c=='F')
		{
			if(search_buf[0])
			{
				search_backward(search_buf);
			}
		}
		else if(c=='f')
		{
			if(search_buf[0])
			{
				search_forward(search_buf);
			}
		}
		else if(c=='T')
		{
			while(file_getc(&current_pos)!='\n'&&cursor_right())
			{
				current_x_refine();
			}
		}
		else if(c=='C'&&mode==2)
		{
			copy_selected_str();
			mode=0;
		}
		else if(c=='D'&&mode==2)
		{
			copy_selected_str();
			del_selected_str();
			mode=0;
		}
	}
	else if(mode==1)
	{
		if(c=='\n'||c=='\t'||c>=32&&c<127)
		{
			if(current_pos_end)
			{
				op_push(c,current_pos.off+1);
				addc_end(c);
				current_pos_end=0;
				cursor_right();
				current_pos_end=1;
			}
			else
			{
				op_push(c,current_pos.off);
				addc(c);
			}
			current_x_refine();
		}
		else if(c==127)
		{
			int c1;
			struct file_pos pos;
			if(current_pos_end)
			{
				current_pos_end=0;
				c1=file_getc(&current_pos);
				if(c1!=-1)
				{
					op_push(c1|0x100,current_pos.off);
				}
				if(!cursor_left())
				{
					current_pos.block=NULL;
					current_pos.pos=0;
					current_pos.off=0;
				}
				delc_end();
				current_pos_end=1;
			}
			else
			{
				memcpy(&pos,&current_pos,sizeof(pos));
				if(file_pos_move_left(&pos))
				{
					c1=file_getc(&pos);
					op_push(c1|0x100,pos.off);
				}
				delc();
			}
			current_x_refine();
		}
	}
	else if(mode==3)
	{
		if(c>=32&&c<127)
		{
			if(cmd_size!=64)
			{
				cmd_buf[cmd_size]=c;
				++cmd_size;
			}
		}
		else if(c==127)
		{
			if(cmd_size)
			{
				--cmd_size;
			}
		}
		else if(c=='\n')
		{
			issue_cmd();
			mode=prev_mode;
		}
	}
}
long file_mtime;

struct edit_context
{
	struct edit_context *next;
	long mtime;
	char *file_name;
	struct file *file_head;
	struct file *file_end;
	struct file_pos current_pos;
	struct file_pos view_pos;
	long op_fifo_size;
	int op_fifo_start;
	int op_fifo_x;
	unsigned short op_c_fifo[MAX_UNDOS];
	unsigned long op_off_fifo[MAX_UNDOS];
} *edit_context;
void edit_context_save(char *name)
{
	struct edit_context *p;
	char *new_name;
	p=edit_context;
	while(p)
	{
		if(!strcmp(p->file_name,name))
		{
			p->mtime=file_mtime;
			p->file_head=file_head;
			p->file_end=file_end;
			memcpy(&p->current_pos,&current_pos,sizeof(current_pos));
			memcpy(&p->view_pos,&view_pos,sizeof(view_pos));
			p->op_fifo_size=op_fifo_size;
			p->op_fifo_start=op_fifo_start;
			p->op_fifo_x=op_fifo_x;
			memcpy(p->op_c_fifo,op_c_fifo,sizeof(op_c_fifo));
			memcpy(p->op_off_fifo,op_off_fifo,sizeof(op_off_fifo));
			return;
		}
		p=p->next;
	}
	p=malloc(sizeof(*p));
	if(p==NULL)
	{
		return;
	}
	new_name=malloc(strlen(name)+1);
	if(new_name==NULL)
	{
		free(p);
		return;
	}
	strcpy(new_name,name);
	p->mtime=file_mtime;
	p->file_name=new_name;
	p->file_head=file_head;
	p->file_end=file_end;
	memcpy(&p->current_pos,&current_pos,sizeof(current_pos));
	memcpy(&p->view_pos,&view_pos,sizeof(view_pos));
	p->op_fifo_size=op_fifo_size;
	p->op_fifo_start=op_fifo_start;
	p->op_fifo_x=op_fifo_x;
	memcpy(p->op_c_fifo,op_c_fifo,sizeof(op_c_fifo));
	memcpy(p->op_off_fifo,op_off_fifo,sizeof(op_off_fifo));
	p->next=edit_context;
	edit_context=p;
}
int edit_context_load(char *name)
{
	struct edit_context *p,*pp;
	p=edit_context;
	pp=NULL;
	while(p)
	{
		if(!strcmp(p->file_name,name))
		{
			if(p->mtime!=file_mtime)
			{
				if(pp)
				{
					pp->next=p->next;
				}
				else
				{
					edit_context=p->next;
				}
				struct file *node;
				while(node=p->file_head)
				{
					p->file_head=node->next;
					free(node);
				}
				free(p->file_name);
				free(p);
				return 0;
			}
			file_name=name;
			file_head=p->file_head;
			file_end=p->file_end;
			memcpy(&current_pos,&p->current_pos,sizeof(current_pos));
			memcpy(&view_pos,&p->view_pos,sizeof(view_pos));
			op_fifo_size=p->op_fifo_size;
			op_fifo_start=p->op_fifo_start;
			op_fifo_x=p->op_fifo_x;
			memcpy(op_c_fifo,p->op_c_fifo,sizeof(op_c_fifo));
			memcpy(op_off_fifo,p->op_off_fifo,sizeof(op_off_fifo));
			return 1;
		}
		pp=p;
		p=p->next;
	}
	return 0;
}

long edit_file(char *file,int pos)
{
	struct stat st;
	int c;
	int ret;
	if(fstatat(project_dir_fd,file,&st,AT_SYMLINK_NOFOLLOW))
	{
		return -1;
	}
	file_mtime=st.mtime;
	if(edit_context_load(file))
	{
		goto loaded_file;
	}
	if((st.mode&0170000)!=STAT_REG)
	{
		return -1;
	}
	file_name=file;
	if(file_load())
	{
		return -1;
	}
	while(pos)
	{
		cursor_right();
		current_x_refine();
		--pos;
	}
loaded_file:
	while(1)
	{
		do
		{
			display_file();
			unblock_sigwinch();
			block_sigwinch();
		}
		while(winsize_change);
		display_pbuf();
		c=getc();
		if(mode==0&&c=='Q')
		{
			break;
		}
		keypress_handler(c);
		if(cursor_left())
		{
			current_x_refine();
			cursor_right();
			current_x_refine();
		}
	}
	ret=current_pos.off;
	if(!fstatat(project_dir_fd,file,&st,AT_SYMLINK_NOFOLLOW))
	{
		file_mtime=st.mtime;
	}
	edit_context_save(file);
	file_end=NULL;
	file_head=NULL;
	memset(&current_pos,0,sizeof(current_pos));
	memset(&view_pos,0,sizeof(view_pos));
	memset(&select_pos,0,sizeof(select_pos));
	cmd_size=0;
	mode=0;
	memset(op_c_fifo,0,sizeof(op_c_fifo));
	memset(op_off_fifo,0,sizeof(op_off_fifo));
	op_fifo_size=0;
	op_fifo_start=0;
	op_fifo_x=0;
	return ret;
}
