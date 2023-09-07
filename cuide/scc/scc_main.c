int fdi,fdo;
#include "include/lib.c"
#include "include/stream.c"
#define xmalloc scc__xmalloc
#define xstrdup scc__xstrdup
#define str_s_app scc__str_s_app
#define str_c_app scc__str_c_app
#define str_c_app2 scc__str_c_app2
#define str_i_app scc__str_i_app
#define fdi scc__fdi
#define fdo scc__fdo
#define stream_putc scc__stream_putc
#define stream_getc scc__stream_getc
namespace scc_front;
#include "scc/main.c"
namespace scc_back;
#include "bcode/main.c"
namespace scc;
int main(int argc,char **argv)
{
	if(argc<3)
	{
		write(1,"Usage: scc <input> <output>\n",28);
		return 1;
	}
	fdi=open(argv[1],0,0);
	if(fdi<0)
	{
		write(1,"Cannot open input file\n",23);
		return 1;
	}
	fdo=open(argv[2],578,0644);
	if(fdo<0)
	{
		write(1,"Cannot open output file\n",24);
		return 1;
	}
	scc_front__scc_run();
	scc_back__bcode_run();
	close(fdi);
	close(fdo);
	return 0;
}
#undef xmalloc
#undef xstrdup
#undef str_s_app
#undef str_c_app
#undef str_c_app2
#undef str_i_app
#undef fdi
#undef fdo
#undef stream_putc
#undef stream_getc
