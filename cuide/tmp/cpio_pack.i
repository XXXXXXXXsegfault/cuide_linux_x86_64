 
 
 
asm ".entry"
asm "lea 8(%rsp),%rax"
asm "push %rax"
asm "pushq 8(%rsp)"
asm "call @main"
asm "mov %rax,%rdi"
asm "mov $231,%eax"
asm "syscall"
long __syscall(long num,long a1,long a2,long a3,long a4,long a5,long a6);
asm "@__syscall"
asm "push %rdi"
asm "push %rsi"
asm "push %rdx"
asm "push %r10"
asm "push %r11"
asm "push %r8"
asm "push %r9"
asm "mov 64(%rsp),%rax"
asm "mov 72(%rsp),%rdi"
asm "mov 80(%rsp),%rsi"
asm "mov 88(%rsp),%rdx"
asm "mov 96(%rsp),%r10"
asm "mov 104(%rsp),%r8"
asm "mov 112(%rsp),%r9"
asm "syscall"
asm "pop %r9"
asm "pop %r8"
asm "pop %r11"
asm "pop %r10"
asm "pop %rdx"
asm "pop %rsi"
asm "pop %rdi"
asm "ret"
long int vfork(void);
asm "@vfork"
asm "pop %rdx"
asm "mov $58,%eax"
asm "syscall"
asm "jmp *%rdx"
long int execv(char *path,char **argv)
{
 char *env[1];
 env[0]=0;
 return __syscall((long)(59),(long)(path),(long)(argv),(long)(env),(long)(0),(long)(0),(long)(0));
}
long int wait(int *status)
{
 return __syscall((long)(61),(long)(-1),(long)(status),(long)(0),(long)(0),(long)(0),(long)(0));
}
long int waitpid(int pid,int *status,int options)
{
 return __syscall((long)(61),(long)(pid),(long)(status),(long)(options),(long)(0),(long)(0),(long)(0));
}
struct timespec
{
 unsigned long sec;
 unsigned long nsec;
};
void sleep(unsigned int sec,unsigned int usec)
{
 struct timespec t;
 t.sec=sec;
 t.nsec=usec*1000;
 __syscall((long)(35),(long)(&t),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
}
 
struct dirent
{
 unsigned long int ino;
 unsigned long int off;
 unsigned short reclen;
 unsigned char type;
 char name[1];
};
struct DIR
{
 int fd;
 short off;
 short size;
 unsigned char buf[1016];
};
void dir_init(int fd,struct DIR *dp)
{
 dp->fd=fd;
 dp->off=0;
 dp->size=0;
}
struct dirent *readdir(struct DIR *dp)
{
 struct dirent *ret;
 if(dp->off==dp->size)
 {
 dp->off=0;
 dp->size=__syscall((long)(217),(long)(dp->fd),(long)(dp->buf),(long)(1016),(long)(0),(long)(0),(long)(0));
 if(dp->size<=0)
 {
 dp->size=0;
 return ((void *)0);
 }
 }
 ret=(void *)(dp->buf+dp->off);
 dp->off+=ret->reclen;
 return ret;
}
 
asm "@_memmove_start"
void *memcpy(void *dst,void *src,unsigned long int size)
{
 asm "push %rcx"
 asm "push %rdx"
 asm "push %rbx"
 asm "push %rsi"
 asm "push %rdi"
 asm "push %r8"
 asm "push %r9"
 asm "push %r10"
 asm "push %r11"
 asm "push %r12"
 asm "mov 16(%rbp),%rax"
 asm "mov 24(%rbp),%rdx"
 asm "mov 32(%rbp),%rcx"
 asm "cmp $8,%rcx"
 asm "jb @_memcpy_X33"
 asm "test $1,%dl"
 asm "je @_memcpy_X11"
 asm "mov (%rdx),%bl"
 asm "mov %bl,(%rax)"
 asm "inc %rax"
 asm "inc %rdx"
 asm "dec %rcx"
 asm "@_memcpy_X11"
 asm "test $2,%dl"
 asm "je @_memcpy_X12"
 asm "mov (%rdx),%bx"
 asm "mov %bx,(%rax)"
 asm "add $2,%rax"
 asm "add $2,%rdx"
 asm "sub $2,%rcx"
 asm "@_memcpy_X12"
 asm "test $4,%dl"
 asm "je @_memcpy_X13"
 asm "mov (%rdx),%ebx"
 asm "mov %ebx,(%rax)"
 asm "add $4,%rax"
 asm "add $4,%rdx"
 asm "sub $4,%rcx"
 asm "@_memcpy_X13"
 asm "sub $64,%rcx"
 asm "jb @_memcpy_X21"
 asm "@_memcpy_X22"
 asm "mov (%rdx),%rbx"
 asm "mov 8(%rdx),%rsi"
 asm "mov 16(%rdx),%rdi"
 asm "mov 24(%rdx),%r8"
 asm "mov 32(%rdx),%r9"
 asm "mov 40(%rdx),%r10"
 asm "mov 48(%rdx),%r11"
 asm "mov 56(%rdx),%r12"
 asm "mov %rbx,(%rax)"
 asm "mov %rsi,8(%rax)"
 asm "mov %rdi,16(%rax)"
 asm "mov %r8,24(%rax)"
 asm "mov %r9,32(%rax)"
 asm "mov %r10,40(%rax)"
 asm "mov %r11,48(%rax)"
 asm "mov %r12,56(%rax)"
 asm "add $64,%rax"
 asm "add $64,%rdx"
 asm "sub $64,%rcx"
 asm "jae @_memcpy_X22"
 asm "@_memcpy_X21"
 asm "test $32,%cl"
 asm "je @_memcpy_X31"
 asm "mov (%rdx),%rbx"
 asm "mov 8(%rdx),%rsi"
 asm "mov 16(%rdx),%rdi"
 asm "mov 24(%rdx),%r8"
 asm "mov %rbx,(%rax)"
 asm "mov %rsi,8(%rax)"
 asm "mov %rdi,16(%rax)"
 asm "mov %r8,24(%rax)"
 asm "add $32,%rax"
 asm "add $32,%rdx"
 asm "@_memcpy_X31"
 asm "test $16,%cl"
 asm "je @_memcpy_X32"
 asm "mov (%rdx),%rbx"
 asm "mov 8(%rdx),%rsi"
 asm "mov %rbx,(%rax)"
 asm "mov %rsi,8(%rax)"
 asm "add $16,%rax"
 asm "add $16,%rdx"
 asm "@_memcpy_X32"
 asm "test $8,%cl"
 asm "je @_memcpy_X33"
 asm "mov (%rdx),%rbx"
 asm "mov %rbx,(%rax)"
 asm "add $8,%rax"
 asm "add $8,%rdx"
 asm "@_memcpy_X33"
 asm "test $4,%cl"
 asm "je @_memcpy_X34"
 asm "mov (%rdx),%ebx"
 asm "mov %ebx,(%rax)"
 asm "add $4,%rax"
 asm "add $4,%rdx"
 asm "@_memcpy_X34"
 asm "test $2,%cl"
 asm "je @_memcpy_X35"
 asm "mov (%rdx),%bx"
 asm "mov %bx,(%rax)"
 asm "add $2,%rax"
 asm "add $2,%rdx"
 asm "@_memcpy_X35"
 asm "test $1,%cl"
 asm "je @_memcpy_X36"
 asm "mov (%rdx),%bl"
 asm "mov %bl,(%rax)"
 asm "@_memcpy_X36"
 asm "pop %r12"
 asm "pop %r11"
 asm "pop %r10"
 asm "pop %r9"
 asm "pop %r8"
 asm "pop %rdi"
 asm "pop %rsi"
 asm "pop %rbx"
 asm "pop %rdx"
 asm "pop %rcx"
 asm "mov 16(%rbp),%rax"
}
void *memcpy_r(void *dst,void *src,unsigned long int size)
{
 asm "push %rcx"
 asm "push %rdx"
 asm "push %rbx"
 asm "push %rsi"
 asm "push %rdi"
 asm "push %r8"
 asm "push %r9"
 asm "push %r10"
 asm "push %r11"
 asm "push %r12"
 asm "mov 16(%rbp),%rax"
 asm "mov 24(%rbp),%rdx"
 asm "mov 32(%rbp),%rcx"
 asm "cmp $8,%rcx"
 asm "jb @_memcpy_r_X33"
 asm "test $1,%dl"
 asm "je @_memcpy_r_X11"
 asm "dec %rax"
 asm "dec %rdx"
 asm "dec %rcx"
 asm "mov (%rdx),%bl"
 asm "mov %bl,(%rax)"
 asm "@_memcpy_r_X11"
 asm "test $2,%dl"
 asm "je @_memcpy_r_X12"
 asm "sub $2,%rax"
 asm "sub $2,%rdx"
 asm "sub $2,%rcx"
 asm "mov (%rdx),%bx"
 asm "mov %bx,(%rax)"
 asm "@_memcpy_r_X12"
 asm "test $4,%dl"
 asm "je @_memcpy_r_X13"
 asm "sub $4,%rax"
 asm "sub $4,%rdx"
 asm "sub $4,%rcx"
 asm "mov (%rdx),%ebx"
 asm "mov %ebx,(%rax)"
 asm "@_memcpy_r_X13"
 asm "sub $64,%rcx"
 asm "jb @_memcpy_r_X21"
 asm "@_memcpy_r_X22"
 asm "sub $64,%rax"
 asm "sub $64,%rdx"
 asm "mov (%rdx),%rbx"
 asm "mov 8(%rdx),%rsi"
 asm "mov 16(%rdx),%rdi"
 asm "mov 24(%rdx),%r8"
 asm "mov 32(%rdx),%r9"
 asm "mov 40(%rdx),%r10"
 asm "mov 48(%rdx),%r11"
 asm "mov 56(%rdx),%r12"
 asm "mov %rbx,(%rax)"
 asm "mov %rsi,8(%rax)"
 asm "mov %rdi,16(%rax)"
 asm "mov %r8,24(%rax)"
 asm "mov %r9,32(%rax)"
 asm "mov %r10,40(%rax)"
 asm "mov %r11,48(%rax)"
 asm "mov %r12,56(%rax)"
 asm "sub $64,%rcx"
 asm "jae @_memcpy_r_X22"
 asm "@_memcpy_r_X21"
 asm "test $32,%cl"
 asm "je @_memcpy_r_X31"
 asm "sub $32,%rax"
 asm "sub $32,%rdx"
 asm "mov (%rdx),%rbx"
 asm "mov 8(%rdx),%rsi"
 asm "mov 16(%rdx),%rdi"
 asm "mov 24(%rdx),%r8"
 asm "mov %rbx,(%rax)"
 asm "mov %rsi,8(%rax)"
 asm "mov %rdi,16(%rax)"
 asm "mov %r8,24(%rax)"
 asm "@_memcpy_r_X31"
 asm "test $16,%cl"
 asm "je @_memcpy_r_X32"
 asm "sub $16,%rax"
 asm "sub $16,%rdx"
 asm "mov (%rdx),%rbx"
 asm "mov 8(%rdx),%rsi"
 asm "mov %rbx,(%rax)"
 asm "mov %rsi,8(%rax)"
 asm "@_memcpy_r_X32"
 asm "test $8,%cl"
 asm "je @_memcpy_r_X33"
 asm "sub $8,%rax"
 asm "sub $8,%rdx"
 asm "mov (%rdx),%rbx"
 asm "mov %rbx,(%rax)"
 asm "@_memcpy_r_X33"
 asm "test $4,%cl"
 asm "je @_memcpy_r_X34"
 asm "sub $4,%rax"
 asm "sub $4,%rdx"
 asm "mov (%rdx),%ebx"
 asm "mov %ebx,(%rax)"
 asm "@_memcpy_r_X34"
 asm "test $2,%cl"
 asm "je @_memcpy_r_X35"
 asm "sub $2,%rax"
 asm "sub $2,%rdx"
 asm "mov (%rdx),%bx"
 asm "mov %bx,(%rax)"
 asm "@_memcpy_r_X35"
 asm "test $1,%cl"
 asm "je @_memcpy_r_X36"
 asm "mov -1(%rdx),%bl"
 asm "mov %bl,-1(%rax)"
 asm "@_memcpy_r_X36"
 asm "pop %r12"
 asm "pop %r11"
 asm "pop %r10"
 asm "pop %r9"
 asm "pop %r8"
 asm "pop %rdi"
 asm "pop %rsi"
 asm "pop %rbx"
 asm "pop %rdx"
 asm "pop %rcx"
 asm "mov 16(%rbp),%rax"
}
void *memmove(void *dst,void *src,unsigned long int size)
{
 if(dst<src||(char *)dst>=(char *)src+size)
 {
 return memcpy(dst,src,size);
 }
 else
 {
 memcpy_r((char *)dst+size,(char *)src+size,size);
 return dst;
 }
}
asm "@_memmove_end"
void *memset(void *mem,int val,unsigned long int size)
{
 asm "push %rcx"
 asm "push %rdx"
 asm "movzbl 24(%rbp),%edx"
 asm "mov $0x101010101010101,%rax"
 asm "mul %rdx"
 asm "mov %rax,%rdx"
 asm "mov 16(%rbp),%rax"
 asm "mov 32(%rbp),%rcx"
 asm "cmp $8,%rcx"
 asm "jb @_memset_X33"
 asm "test $1,%al"
 asm "je @_memset_X11"
 asm "mov %dl,(%rax)"
 asm "inc %rax"
 asm "dec %rcx"
 asm "@_memset_X11"
 asm "test $2,%al"
 asm "je @_memset_X12"
 asm "mov %dx,(%rax)"
 asm "add $2,%rax"
 asm "sub $2,%rcx"
 asm "@_memset_X12"
 asm "test $4,%al"
 asm "je @_memset_X13"
 asm "mov %edx,(%rax)"
 asm "add $4,%rax"
 asm "sub $4,%rcx"
 asm "@_memset_X13"
 asm "sub $64,%rcx"
 asm "jb @_memset_X21"
 asm "@_memset_X22"
 asm "mov %rdx,(%rax)"
 asm "mov %rdx,8(%rax)"
 asm "mov %rdx,16(%rax)"
 asm "mov %rdx,24(%rax)"
 asm "mov %rdx,32(%rax)"
 asm "mov %rdx,40(%rax)"
 asm "mov %rdx,48(%rax)"
 asm "mov %rdx,56(%rax)"
 asm "add $64,%rax"
 asm "sub $64,%rcx"
 asm "jae @_memset_X22"
 asm "@_memset_X21"
 asm "test $32,%cl"
 asm "je @_memset_X31"
 asm "mov %rdx,(%rax)"
 asm "mov %rdx,8(%rax)"
 asm "mov %rdx,16(%rax)"
 asm "mov %rdx,24(%rax)"
 asm "add $32,%rax"
 asm "@_memset_X31"
 asm "test $16,%cl"
 asm "je @_memset_X32"
 asm "mov %rdx,(%rax)"
 asm "mov %rdx,8(%rax)"
 asm "add $16,%rax"
 asm "@_memset_X32"
 asm "test $8,%cl"
 asm "je @_memset_X33"
 asm "mov %rdx,(%rax)"
 asm "add $8,%rax"
 asm "@_memset_X33"
 asm "test $4,%cl"
 asm "je @_memset_X34"
 asm "mov %edx,(%rax)"
 asm "add $4,%rax"
 asm "@_memset_X34"
 asm "test $2,%cl"
 asm "je @_memset_X35"
 asm "mov %dx,(%rax)"
 asm "add $2,%rax"
 asm "@_memset_X35"
 asm "test $1,%cl"
 asm "je @_memset_X36"
 asm "mov %dl,(%rax)"
 asm "@_memset_X36"
 asm "pop %rdx"
 asm "pop %rcx"
 asm "mov 16(%rbp),%rax"
}
int memcmp(void *mem1,void *mem2,unsigned long int size)
{
 asm "push %rsi"
 asm "push %rdi"
 asm "push %rcx"
 asm "mov 16(%rbp),%rsi"
 asm "mov 24(%rbp),%rdi"
 asm "mov 32(%rbp),%rcx"
 asm "sub $8,%rcx"
 asm "jb @_memcmp_X1"
 asm "@_memcmp_X2"
 asm "mov (%rsi),%rax"
 asm "sub (%rdi),%rax"
 asm "jne @_memcmp_E"
 asm "add $8,%rsi"
 asm "add $8,%rdi"
 asm "sub $8,%rcx"
 asm "jae @_memcmp_X2"
 asm "@_memcmp_X1"
 asm "test $4,%cl"
 asm "je @_memcmp_Y1"
 asm "mov (%rsi),%eax"
 asm "sub (%rdi),%eax"
 asm "jne @_memcmp_E"
 asm "add $4,%rsi"
 asm "add $4,%rdi"
 asm "@_memcmp_Y1"
 asm "test $2,%cl"
 asm "je @_memcmp_Y2"
 asm "mov (%rsi),%ax"
 asm "sub (%rdi),%ax"
 asm "jne @_memcmp_E"
 asm "add $2,%rsi"
 asm "add $2,%rdi"
 asm "@_memcmp_Y2"
 asm "test $1,%cl"
 asm "je @_memcmp_E2"
 asm "mov (%rsi),%al"
 asm "sub (%rdi),%al"
 asm "jne @_memcmp_E"
 asm "add $1,%rsi"
 asm "add $1,%rdi"
 asm "jmp @_memcmp_E2"
 asm "@_memcmp_E"
 asm "test %eax,%eax"
 asm "jne @_memcmp_E11"
 asm "shr $32,%rax"
 asm "@_memcmp_E11"
 asm "test %ax,%ax"
 asm "jne @_memcmp_E12"
 asm "shr $16,%rax"
 asm "@_memcmp_E12"
 asm "test %al,%al"
 asm "jne @_memcmp_E2"
 asm "mov %ah,%al"
 asm "@_memcmp_E2"
 asm "movsbq %al,%rax"
 asm "pop %rcx"
 asm "pop %rdi"
 asm "pop %rsi"
}
unsigned long int strlen(char *str)
{
 unsigned long int l;
 l=0;
 while(*str)
 {
 ++l;
 ++str;
 }
 return l;
}
unsigned long int strnlen(char *str,unsigned long int max)
{
 unsigned long int l;
 if(max==0)
 {
 return 0;
 }
 --max;
 l=0;
 while(*str&&l<max)
 {
 ++l;
 ++str;
 }
 return l;
}
int strcmp(char *str1,char *str2)
{
 unsigned long int l1,l2;
 l1=strlen(str1);
 l2=strlen(str2);
 if(l1>l2)
 {
 l1=l2;
 }
 return memcmp(str1,str2,l1+1);
}
int strncmp(char *str1,char *str2,unsigned long int max)
{
 unsigned long int l1,l2;
 l1=strnlen(str1,max);
 l2=strnlen(str2,max);
 if(l1>l2)
 {
 l1=l2;
 }
 return memcmp(str1,str2,l1+1);
}
char *strcpy(char *dst,char *src)
{
 unsigned long int l;
 l=strlen(src);
 memcpy(dst,src,l+1);
 return dst;
}
char *strcat(char *dst,char *src)
{
 unsigned long int l;
 l=strlen(dst);
 strcpy(dst+l,src);
 return dst;
}
struct 
stat{
 unsigned long int dev;
 unsigned long int ino;
 unsigned long int nlink;
 unsigned int mode;
 unsigned int uid;
 unsigned int gid;
 unsigned int pad1;
 unsigned long int rdev;
 unsigned long int size;
 unsigned long int blksize;
 unsigned long int blocks;
 unsigned long int atime;
 unsigned long int atime1;
 unsigned long int mtime;
 unsigned long int mtime1;
 unsigned long int ctime;
 unsigned long int ctime1;
 unsigned long int pad2[3];
};
int fissubdir(int dirfd,int fd)
{
 int fd1,fd2;
 int ret;
 struct stat st,dirst,dirst_old;
 if(ret=__syscall((long)(5),(long)(dirfd),(long)(&st),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 return ret;
 }
 fd1=__syscall((long)(32),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd1<0)
 {
 return fd1;
 }
 fd2=-1;
 while(1)
 {
 
 if(ret=__syscall((long)(5),(long)(fd1),(long)(&dirst),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(3),(long)(fd1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
 }
 if(dirst.ino==st.ino&&dirst.dev==st.dev)
 {
 __syscall((long)(3),(long)(fd1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 if(fd2!=-1&&dirst.ino==dirst_old.ino&&dirst.dev==dirst_old.dev)
 {
 __syscall((long)(3),(long)(fd1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 0;
 }
 memcpy(&dirst_old,&dirst,sizeof(dirst));
 fd2=__syscall((long)(257),(long)(fd1),(long)(".."),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fd1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd2<0)
 {
 return fd2;
 }
 fd1=fd2;
 }
}
int dirname_open(char *path,char **path_ret)
{
 int fd1,fd2;
 char buf[270];
 int x,c;
 char *path1;
 if(!strcmp(path,"/"))
 {
 if(path_ret)
 {
 *path_ret=path;
 }
 return __syscall((long)(2),(long)("/"),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 fd1=(-100);
 if(*path=='/')
 {
 fd1=__syscall((long)(2),(long)("/"),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd1<0)
 {
 return fd1;
 }
 ++path;
 }
 path1=path;
 x=0;
 while(c=*path)
 {
 if(c=='/')
 {
 buf[x]=0;
 do
 {
 ++path;
 }
 while(*path=='/');
 if(*path)
 {
 fd2=__syscall((long)(257),(long)(fd1),(long)(buf),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fd1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd2<0)
 {
 return fd2;
 }
 fd1=fd2;
 path1=path;
 }
 x=0;
 }
 else
 {
 if(x>=256)
 {
 return -36;
 }
 buf[x]=c;
 ++path;
 ++x;
 }
 }
 if(path_ret)
 {
 *path_ret=path1;
 }
 if(fd1==(-100))
 {
 fd1=__syscall((long)(2),(long)("."),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 return fd1;
}
int openl(char *path,int flags,int mode)
{
 int dir,fd;
 char *bname;
 dir=dirname_open(path,&bname);
 if(dir<0)
 {
 return dir;
 }
 fd=__syscall((long)(257),(long)(dir),(long)(bname),(long)(flags),(long)(mode),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return fd;
}
int statl(char *path,struct stat *st)
{
 int dir,ret;
 char *bname;
 dir=dirname_open(path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(262),(long)(dir),(long)(bname),(long)(st),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int lstatl(char *path,struct stat *st)
{
 int dir,ret;
 char *bname;
 dir=dirname_open(path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(262),(long)(dir),(long)(bname),(long)(st),(long)(0x100),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int mkdirl(char *path,int mode)
{
 int dir,ret;
 char *bname;
 dir=dirname_open(path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(258),(long)(dir),(long)(bname),(long)(mode),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int issubdir(char *dirpath,char *path)
{
 int dirfd,fd,ret;
 struct stat st;
 if(ret=lstatl(dirpath,&st))
 {
 return ret;
 }
 if((st.mode&0170000)!=040000)
 {
 return 0;
 }
 dirfd=openl(dirpath,0,0);
 if(dirfd<0)
 {
 return dirfd;
 }
 fd=dirname_open(path,((void *)0));
 if(fd<0)
 {
 __syscall((long)(3),(long)(dirfd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return fd;
 }
 ret=fissubdir(dirfd,fd);
 __syscall((long)(3),(long)(dirfd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int dirname_openat(int dirfd,char *path,char **path_ret)
{
 int fd1,fd2;
 char buf[270];
 int x,c;
 char *path1;
 if(!strcmp(path,"/"))
 {
 if(path_ret)
 {
 *path_ret=path;
 }
 return __syscall((long)(2),(long)("/"),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 if(dirfd==(-100))
 {
 fd1=__syscall((long)(2),(long)("."),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 fd1=__syscall((long)(32),(long)(dirfd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 if(*path=='/')
 {
 __syscall((long)(3),(long)(fd1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 fd1=__syscall((long)(2),(long)("/"),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd1<0)
 {
 return fd1;
 }
 ++path;
 }
 else if(fd1<0)
 {
 return fd1;
 }
 path1=path;
 x=0;
 while(c=*path)
 {
 if(c=='/')
 {
 buf[x]=0;
 do
 {
 ++path;
 }
 while(*path=='/');
 if(*path)
 {
 fd2=__syscall((long)(257),(long)(fd1),(long)(buf),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fd1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd2<0)
 {
 return fd2;
 }
 fd1=fd2;
 path1=path;
 }
 x=0;
 }
 else
 {
 if(x>=256)
 {
 return -36;
 }
 buf[x]=c;
 ++path;
 ++x;
 }
 }
 if(path_ret)
 {
 *path_ret=path1;
 }
 if(fd1==(-100))
 {
 fd1=__syscall((long)(2),(long)("."),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 return fd1;
}
int openatl(int dirfd,char *path,int flags,int mode)
{
 int dir,fd;
 char *bname;
 dir=dirname_openat(dirfd,path,&bname);
 if(dir<0)
 {
 return dir;
 }
 fd=__syscall((long)(257),(long)(dir),(long)(bname),(long)(flags),(long)(mode),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return fd;
}
int mkdiratl(int dirfd,char *path,int mode)
{
 int dir,ret;
 char *bname;
 dir=dirname_openat(dirfd,path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(258),(long)(dir),(long)(bname),(long)(mode),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int fchmodatl(int dirfd,char *path,int mode)
{
 int dir,ret;
 char *bname;
 dir=dirname_openat(dirfd,path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(268),(long)(dir),(long)(bname),(long)(mode),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int fstatatl(int dirfd,char *path,struct stat *st,int flags)
{
 int dir,ret;
 char *bname;
 dir=dirname_openat(dirfd,path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(262),(long)(dir),(long)(bname),(long)(st),(long)(flags),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int symlinkatl(char *target,int dirfd,char *path)
{
 int dir,ret;
 char *bname;
 dir=dirname_openat(dirfd,path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(266),(long)(target),(long)(dir),(long)(bname),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int readlinkatl(int dirfd,char *path,char *buf,int size)
{
 int dir,ret;
 char *bname;
 dir=dirname_openat(dirfd,path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(267),(long)(dir),(long)(bname),(long)(buf),(long)(size),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int unlinkatl(int dirfd,char *path,int flags)
{
 int dir,ret;
 char *bname;
 dir=dirname_openat(dirfd,path,&bname);
 if(dir<0)
 {
 return dir;
 }
 ret=__syscall((long)(263),(long)(dir),(long)(bname),(long)(flags),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
int renameatl(int dirfd,char *path,int newdirfd,char *newpath)
{
 int dir,newdir,ret;
 char *bname,*new_bname;
 dir=dirname_openat(dirfd,path,&bname);
 if(dir<0)
 {
 return dir;
 }
 newdir=dirname_openat(newdirfd,newpath,&new_bname);
 if(newdir<0)
 {
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return newdir;
 }
 ret=__syscall((long)(264),(long)(dir),(long)(bname),(long)(newdir),(long)(new_bname),(long)(0),(long)(0));
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(newdir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return ret;
}
 
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
 if((st->mode&0170000)==040000)
 {
 store_hex(header.nlink,st->nlink);
 }
 else
 {
 store_hex(header.nlink,1);
 store_hex(header.filesize,st->size);
 }
 store_hex(header.namesize,l1);
 __syscall((long)(1),(long)(fd),(long)(&header),(long)(sizeof(header)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fd),(long)(path),(long)(l),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fd),(long)("\0\0\0\0"),(long)(l1-l),(long)(0),(long)(0),(long)(0));
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
 if(__syscall((long)(5),(long)(dirfd),(long)(&st),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 cpio_entry_add(fd,&st,name);
 dir_init(dirfd,&db);
 while(dir=readdir(&db))
 {
 if(strcmp(dir->name,".")&&strcmp(dir->name,".."))
 {
 __syscall((long)(262),(long)(dirfd),(long)(dir->name),(long)(&st),(long)(0x100),(long)(0),(long)(0));
 type=st.mode&0170000;
 if(type==040000)
 {
 l=strlen(name)+4096+300;
 l-=l&0xfff;
 new_name=((void *)__syscall((long)(9),(long)(0),(long)(l),(long)(3),(long)(0x22),(long)(-1),(long)(0)));
 if(!((unsigned long)((long)(new_name))<=0xfffffffffffff000))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 strcpy(new_name,name);
 strcat(new_name,"/");
 strcat(new_name,dir->name);
 filefd=__syscall((long)(257),(long)(dirfd),(long)(dir->name),(long)(0),(long)(0),(long)(0),(long)(0));
 if(filefd<0)
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 do_cpio_pack(new_name,filefd,fd);
 __syscall((long)(3),(long)(filefd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(11),(long)(new_name),(long)(l),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else if(type==0100000)
 {
 l=strlen(name)+4096+300;
 l-=l&0xfff;
 new_name=((void *)__syscall((long)(9),(long)(0),(long)(l),(long)(3),(long)(0x22),(long)(-1),(long)(0)));
 if(!((unsigned long)((long)(new_name))<=0xfffffffffffff000))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 strcpy(new_name,name);
 strcat(new_name,"/");
 strcat(new_name,dir->name);
 cpio_entry_add(fd,&st,new_name);
 __syscall((long)(11),(long)(new_name),(long)(l),(long)(0),(long)(0),(long)(0),(long)(0));
 filefd=__syscall((long)(257),(long)(dirfd),(long)(dir->name),(long)(0),(long)(0),(long)(0),(long)(0));
 if(filefd<0)
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 while((l=__syscall((long)(0),(long)(filefd),(long)(fbuf),(long)(4096),(long)(0),(long)(0),(long)(0)))>0)
 {
 __syscall((long)(1),(long)(fd),(long)(fbuf),(long)(l),(long)(0),(long)(0),(long)(0));
 }
 __syscall((long)(3),(long)(filefd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 l=__syscall((long)(8),(long)(fd),(long)(0),(long)(1),(long)(0),(long)(0),(long)(0));
 if(!((unsigned long)((long)(l))<=0xfffffffffffff000))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 l&=3;
 if(l)
 {
 __syscall((long)(1),(long)(fd),(long)("\0\0\0\0"),(long)(4-l),(long)(0),(long)(0),(long)(0));
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
 if(lstatl(src,&st)||(st.mode&0170000)!=040000)
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
 l=__syscall((long)(8),(long)(fd),(long)(0),(long)(1),(long)(0),(long)(0),(long)(0));
 if(!((unsigned long)((long)(l))<=0xfffffffffffff000))
 {
 return 1;
 }
 l=l&511;
 if(l)
 {
 __syscall((long)(1),(long)(fd),(long)(buf),(long)(512-l),(long)(0),(long)(0),(long)(0));
 }
 return 0;
}
void help(void)
{
 __syscall((long)(1),(long)(1),(long)("Usage: cpio_pack <DIR> <CPIOFILE>\n"),(long)(34),(long)(0),(long)(0),(long)(0));
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
