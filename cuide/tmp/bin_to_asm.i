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
void sprinti(char *str,unsigned long int a,int digits)
{
 unsigned long int n;
 int d,l,sl;
 char buf[20];
 n=10000000000000000000;
 d=20;
 while(n>a&&d>digits)
 {
 n/=10;
 --d;
 }
 l=0;
 while(n)
 {
 buf[l]=a/n+'0';
 a%=n;
 n/=10;
 ++l;
 }
 sl=strlen(str);
 memcpy(str+sl,buf,l);
 str[sl+l]=0;
}
char *sinputi(char *str,unsigned long int *result)
{
 unsigned long int ret;
 char c;
 ret=0;
 while((c=*str)>='0'&&c<='9')
 {
 ret=ret*10+(c-'0');
 ++str;
 }
 *result=ret;
 return str;
}
int main(int argc,char **argv)
{
 unsigned char buf[32];
 int x,size;
 int fd,fdo;
 if(argc<4)
 {
 __syscall((long)(1),(long)(1),(long)("Usage: bin_to_asm <FILE> <ASMFILE> <TAG>\n"),(long)(41),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 fd=__syscall((long)(2),(long)(argv[1]),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd<0)
 {
 return 1;
 }
 fdo=__syscall((long)(2),(long)(argv[2]),(long)(578),(long)(0644),(long)(0),(long)(0),(long)(0));
 if(fdo<0)
 {
 return 1;
 }
 __syscall((long)(1),(long)(fdo),(long)("asm \"@"),(long)(6),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)(argv[3]),(long)(strlen(argv[3])),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)("_start\"\n"),(long)(8),(long)(0),(long)(0),(long)(0));
 while((size=__syscall((long)(0),(long)(fd),(long)(buf),(long)(32),(long)(0),(long)(0),(long)(0)))>0)
 {
 __syscall((long)(1),(long)(fdo),(long)("asm \".byte "),(long)(11),(long)(0),(long)(0),(long)(0));
 x=0;
 while(x<size)
 {
 char buf2[32];
 buf2[0]=0;
 sprinti(buf2,buf[x],1);
 __syscall((long)(1),(long)(fdo),(long)(buf2),(long)(strlen(buf2)),(long)(0),(long)(0),(long)(0));
 ++x;
 if(x!=size)
 {
 __syscall((long)(1),(long)(fdo),(long)(","),(long)(1),(long)(0),(long)(0),(long)(0));
 }
 }
 __syscall((long)(1),(long)(fdo),(long)("\"\n"),(long)(2),(long)(0),(long)(0),(long)(0));
 }
 __syscall((long)(1),(long)(fdo),(long)("asm \"@"),(long)(6),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)(argv[3]),(long)(strlen(argv[3])),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)("_end\"\n"),(long)(6),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)("void "),(long)(5),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)(argv[3]),(long)(strlen(argv[3])),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)("_start(void);\n"),(long)(14),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)("void "),(long)(5),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)(argv[3]),(long)(strlen(argv[3])),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fdo),(long)("_end(void);\n"),(long)(12),(long)(0),(long)(0),(long)(0));
 return 0;
}
