int l_ungetc_buf;
int l_current_line;
int l_current_col;
int l_old_line;
int l_old_col;
char *current_file;
int l_readc(void)
{
	static unsigned char buf[65536];
	static int x,n;
	int n1,c;
	if(x==n)
	{
		n1=read(fdi,buf,65536);
		if(n1<=0)
		{
			return -1;
		}
		n=n1;
		x=0;
	}
	c=buf[x];
	++x;
	return c;
}
int l_getc(void)
{
	int c;
	c=0;
	if(l_ungetc_buf!=-1)
	{
		c=l_ungetc_buf;
		l_ungetc_buf=-1;
		return c;
	}
	if((c=l_readc())!=-1)
	{
		return c;
	}
	else
	{
		return -1;
	}
}
void l_ungetc(int c)
{
	l_ungetc_buf=c&0xff;
}
char *read_str(char c)
{
	char *s;
	char c1;
	int line,col,x;
	s=0;
	x=0;
	line=l_current_line;
	col=l_current_col;
	s=str_c_app(s,c);
	while((c1=l_getc())!=-1)
	{
		s=str_c_app2(s,x,c1);
		if(c1==c)
		{
			break;
		}
		if(c1=='\\')
		{
			c1=l_getc();
			if(c1==-1)
			{
				break;
			}
			s=str_c_app2(s,x,c1);
			++x;
		}
		else if(c1=='\n'||c1=='\r')
		{
			error(line,current_file,"string not complete.");
		}
		++x;
	}
	if(c1==-1)
	{
		error(line,current_file,"string not complete.");
	}
	return s;
}
char *l_read_word(void)
{
	char *s;
	int c,x;
	int line,col;
	char *msg;
	int s1;
	s=0;
	x=0;
	line=l_current_line;
	col=l_current_col;
	while((c=l_getc())!=-1)
	{
		if(c!=32&&c!='\n'&&c!='\t'&&c!='\v'&&c!='\r')
		{
			break;
		}
	}
	if(c==-1)
	{
		return 0;
	}
	if(c>='A'&&c<='Z'||c>='a'&&c<='z'||c>='0'&&c<='9'||c=='_')
	{
		s1=0;
		if(!(c>='0'&&c<='9'))
		{
			s1=2;
		}
		s=str_c_app2(s,x,c);
		c=l_getc();
		while(c>='A'&&c<='Z'||c>='a'&&c<='z'||c>='0'&&c<='9'||c=='_'||c=='.')
		{
			if(c=='.')
			{
				if(s1==0)
				{
					s=str_c_app2(s,x,c);
					++x;
					c=l_getc();
					s1=1;
				}
				else
				{
					break;
				}
			}
			s=str_c_app2(s,x,c);
			++x;
			c=l_getc();
		}
		if(c!=-1)
		{
			l_ungetc(c);
		}
		return s;
	}
	if(c=='\'')
	{
		return read_str('\'');
	}
	if(c=='\"')
	{
		return read_str('\"');
	}
	s=str_c_app(s,c);
	if(c=='-')
	{
		c=l_getc();
		if(c=='>'||c=='='||c=='-')
		{
			s=str_c_app(s,c);
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(c=='+')
	{
		c=l_getc();
		if(c=='+'||c=='=')
		{
			s=str_c_app(s,c);
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(c=='<')
	{
		c=l_getc();
		if(c=='=')
		{
			s=str_c_app(s,c);
		}
		else if(c=='<')
		{
			s=str_c_app(s,c);
			c=l_getc();
			if(c=='=')
			{
				s=str_c_app(s,c);
			}
			else if(c!=-1)
			{
				l_ungetc(c);
			}
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(c=='>')
	{
		c=l_getc();
		if(c=='=')
		{
			s=str_c_app(s,c);
		}
		else if(c=='>')
		{
			s=str_c_app(s,c);
			c=l_getc();
			if(c=='=')
			{
				s=str_c_app(s,c);
			}
			else if(c!=-1)
			{
				l_ungetc(c);
			}
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(c=='=')
	{
		c=l_getc();
		if(c=='=')
		{
			s=str_c_app(s,c);
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(c=='!')
	{
		c=l_getc();
		if(c=='=')
		{
			s=str_c_app(s,c);
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(c=='&')
	{
		c=l_getc();
		if(c=='&'||c=='=')
		{
			s=str_c_app(s,c);
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(c=='|')
	{
		c=l_getc();
		if(c=='|'||c=='=')
		{
			s=str_c_app(s,c);
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(c=='/'||c=='*'||c=='%'||c=='^')
	{
		c=l_getc();
		if(c=='=')
		{
			s=str_c_app(s,c);
		}
		else if(c!=-1)
		{
			l_ungetc(c);
		}
	}
	else if(!(c=='['||c==']'||c=='('||c==')'||c=='{'||c=='}'||c=='.'||c=='~'||c=='\?'||c==':'||c==','||c==';'))
	{
		msg=xstrdup("unrecognized character \'");
		msg=str_c_app(msg,c);
		msg=str_c_app(msg,'\'');
		error(line,current_file,msg);
	}
	return s;
}
struct l_word_list
{
	char *str;
	char *file;
	int line;
	int col;
	struct l_word_list *next;
} *l_words_head,*l_words_end;
void load_file(void)
{
	char *s,*s1,*p;
	struct l_word_list *node;
	long int line,col;
	int line_num_state;
	current_file=xstrdup("<UNKNOWN>");
	line=l_current_line;
	col=l_current_col;
	line_num_state=0;
	while(s=l_read_word())
	{
		if(!strcmp(s,"__line__"))
		{
			line_num_state=1;
			s1=0;
			free(s);
		}
		else if(line_num_state==1)
		{
			current_file=s;
			line_num_state=2;
		}
		else if(line_num_state==2)
		{
			sinputi(s,&line);
			l_current_line=line;
			line_num_state=0;
			free(s);
		}
		else
		{
			node=xmalloc(sizeof(*node));
			node->str=s;
			node->file=current_file;
			node->line=line;
			node->col=col;
			node->next=0;
			if(l_words_head)
			{
				l_words_end->next=node;
			}
			else
			{
				l_words_head=node;
			}
			l_words_end=node;
			line=l_current_line;
			col=l_current_col;
		}
	}
}
void l_global_init(void)
{
	l_ungetc_buf=-1;
	l_current_line=1;
	l_current_col=1;
	l_old_line=1;
	l_old_col=1;
}
