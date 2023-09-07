int if_str_match(char *str)
{
	struct file_pos pos;
	int c;
	memcpy(&pos,&current_pos,sizeof(pos));
	while(*str)
	{
		c=file_getc(&pos);
		if(c==-1)
		{
			return 0;
		}
		if(c!=*(unsigned char *)str)
		{
			return 0;
		}
		if(!file_pos_move_right(&pos))
		{
			return 0;
		}
		++str;
	}
	return 1;
}
void search_forward(char *str)
{
	struct file_pos old_pos,old_view_pos;
	int old_end;
	if(*str==0)
	{
		return;
	}
	memcpy(&old_pos,&current_pos,sizeof(current_pos));
	memcpy(&old_view_pos,&view_pos,sizeof(view_pos));
	old_end=current_pos_end;
	while(cursor_right())
	{
		if(if_str_match(str))
		{
			return;
		}
	}
	memcpy(&current_pos,&old_pos,sizeof(current_pos));
	memcpy(&view_pos,&old_view_pos,sizeof(view_pos));
	current_pos_end=old_end;
}
void search_backward(char *str)
{
	struct file_pos old_pos,old_view_pos;
	int old_end;
	if(*str==0)
	{
		return;
	}
	memcpy(&old_pos,&current_pos,sizeof(current_pos));
	memcpy(&old_view_pos,&view_pos,sizeof(view_pos));
	old_end=current_pos_end;
	while(cursor_left())
	{
		if(if_str_match(str))
		{
			return;
		}
	}
	memcpy(&current_pos,&old_pos,sizeof(current_pos));
	memcpy(&view_pos,&old_view_pos,sizeof(view_pos));
	current_pos_end=old_end;
}
char search_buf[96];
void issue_cmd(void)
{
	long int line;
	line=0;
	cmd_buf[cmd_size]=0;
	if(cmd_buf[0]=='g')
	{
		if(cmd_buf[1]>='0'&&cmd_buf[1]<='9')
		{
			sinputi(cmd_buf+1,&line);
			view_pos.block=file_head;
			view_pos.off=0;
			view_pos.pos=0;
			current_pos.block=file_head;
			current_pos.off=0;
			current_pos.pos=0;
			current_x=0;
			current_pos_end=0;
			while(line>1)
			{
				cursor_down();
				--line;
			}
		}
		else if(cmd_buf[1]=='e')
		{
			current_x=0;
			current_pos_end=0;
			while(cursor_down());
		}
	}
	else if(cmd_buf[0]=='f')
	{
		if(cmd_buf[1])
		{
			strcpy(search_buf,cmd_buf+1);
			search_forward(search_buf);
		}
	}
	else if(cmd_buf[0]=='F')
	{
		if(cmd_buf[1])
		{
			strcpy(search_buf,cmd_buf+1);
			search_backward(search_buf);
		}
	}
	current_x_refine();
}
