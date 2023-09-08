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
 
unsigned int lock_set32(unsigned int *ptr,unsigned int value)
{
 asm "mov 16(%rbp),%rcx"
 asm "mov 24(%rbp),%eax"
 asm "xchg %eax,(%rcx)"
}
void spin_lock(unsigned int *ptr)
{
 while(lock_set32(ptr,1))
 {
 while(*ptr)
 {
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 asm ".word 0x90f3"
 }
 }
}
void spin_unlock(unsigned int *ptr)
{
 *ptr=0;
}
unsigned int mutex_wait;
void mutex_lock(unsigned int *ptr)
{
 while(lock_set32(ptr,1))
 {
 __syscall((long)(202),(long)(ptr),(long)(0),(long)(1),(long)(0),(long)(0),(long)(0));
 }
}
void mutex_unlock(unsigned int *ptr)
{
 *ptr=0;
 __syscall((long)(202),(long)(ptr),(long)(1),(long)(1),(long)(0),(long)(0),(long)(0));
}
 
 
unsigned long int __malloc_count_del;
struct __malloc_zone
{
 unsigned int magic;
 unsigned char start_color;
 unsigned char end_color;
 unsigned char color;
 unsigned char used;
 unsigned long int *block_links;
 unsigned long int size;
 struct __malloc_zone *start_left;
 struct __malloc_zone *start_right;
 struct __malloc_zone *start_parent;
 struct __malloc_zone *end_left;
 struct __malloc_zone *end_right;
 struct __malloc_zone *end_parent;
 struct __malloc_zone *left;
 struct __malloc_zone *right;
 struct __malloc_zone *parent;
};
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
void __malloc_zone_size_add(struct __malloc_zone **root,struct __malloc_zone *node)
{
 struct __malloc_zone *p,*pp,*pa,*pr,*insert_pos;
 int if_left;
 if(*root==0)
 {
 *root=node;
 node->color=1;
 node->left=0;
 node->right=0;
 node->parent=0;
 return;
 }
 p=*root;
 do
 {
 insert_pos=p;
 if(((node)->size>(insert_pos)->size||(node)->size==(insert_pos)->size&&(unsigned long int)(node)>(unsigned long int)(insert_pos)))
 {
 p=insert_pos->right;
 if_left=0;
 }
 else
 {
 p=insert_pos->left;
 if_left=1;
 }
 }
 while(p);
 if(if_left)
 {
 insert_pos->left=node;
 }
 else
 {
 insert_pos->right=node;
 }
 node->color=0;
 node->left=0;
 node->right=0;
 node->parent=insert_pos;
 p=insert_pos;
 if(p==0||p->color==1)
 {
 return;
 }
 pp=insert_pos->parent;
 while(1)
 {
 if(pp->left==p)
 {
 pa=pp->right;
 if(pa&&pa->color==0)
 {
 pa->color=1;
 p->color=1;
 pp->color=0;
 node=pp;
 p=node->parent;
 if(p==0||p->color==1)
 {
 break;
 }
 pp=p->parent;
 }
 else
 {
 if(p->right==node)
 {
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=p->right;
 rotate_rl=rotate_r->left;
 if(pp)
 {
 if(pp->left==p)
 {
 pp->left=rotate_r;
 }
 else
 {
 pp->right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->parent=pp;
 rotate_r->left=p;
 p->parent=rotate_r;
 p->right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->parent=p;
 }
}
 p=node;
 node=p->left;
 }
 pp->color=0;
 p->color=1;
 pr=pp->parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=pp->left;
 rotate_lr=rotate_l->right;
 if(pr)
 {
 if(pr->left==pp)
 {
 pr->left=rotate_l;
 }
 else
 {
 pr->right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->parent=pr;
 rotate_l->right=pp;
 pp->parent=rotate_l;
 pp->left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->parent=pp;
 }
}
 break;
 }
 }
 else
 {
 pa=pp->left;
 if(pa&&pa->color==0)
 {
 pa->color=1;
 p->color=1;
 pp->color=0;
 node=pp;
 p=node->parent;
 if(p==0||p->color==1)
 {
 break;
 }
 pp=p->parent;
 }
 else
 {
 if(p->left==node)
 {
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=p->left;
 rotate_lr=rotate_l->right;
 if(pp)
 {
 if(pp->left==p)
 {
 pp->left=rotate_l;
 }
 else
 {
 pp->right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->parent=pp;
 rotate_l->right=p;
 p->parent=rotate_l;
 p->left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->parent=p;
 }
}
 p=node;
 node=p->right;
 }
 pp->color=0;
 p->color=1;
 pr=pp->parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=pp->right;
 rotate_rl=rotate_r->left;
 if(pr)
 {
 if(pr->left==pp)
 {
 pr->left=rotate_r;
 }
 else
 {
 pr->right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->parent=pr;
 rotate_r->left=pp;
 pp->parent=rotate_r;
 pp->right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->parent=pp;
 }
}
 break;
 }
 }
 }
 (*root)->color=1;
}
 
struct __malloc_zone *__malloc_zone_size_del(struct __malloc_zone **root,struct __malloc_zone *node)
{
 struct __malloc_zone *n,*p,*p1,*p2,*n1;
 int if_left,color;
 n=*root;
 while(1)
 {
 if(n==0)
 {
 return 0;
 }
 if(((node)->size>(n)->size||(node)->size==(n)->size&&(unsigned long int)(node)>(unsigned long int)(n)))
 {
 n=n->right;
 }
 else if(((n)->size>(node)->size||(n)->size==(node)->size&&(unsigned long int)(n)>(unsigned long int)(node)))
 {
 n=n->left;
 }
 else
 {
 break;
 }
 }
 n1=n;
 if(n->left==0)
 {
 if(n->right==0)
 {
 p=n->parent;
 if(p)
 {
 if(p->left==n)
 {
 p->left=0;
 if_left=1;
 }
 else
 {
 p->right=0;
 if_left=0;
 }
 }
 else
 {
 *root=0;
 return n1;
 }
 }
 else
 {
 p=n->parent;
 if(p)
 {
 if(p->left==n)
 {
 p->left=n->right;
 if_left=1;
 }
 else
 {
 p->right=n->right;
 if_left=0;
 }
 n->right->parent=p;
 }
 else
 {
 *root=n->right;
 n->right->parent=0;
 (*root)->color=1;
 return n1;
 }
 }
 color=n->color;
 }
 else if(n->right==0)
 {
 p=n->parent;
 if(p)
 {
 if(p->left==n)
 {
 p->left=n->left;
 if_left=1;
 }
 else
 {
 p->right=n->left;
 if_left=0;
 }
 n->left->parent=p;
 }
 else
 {
 *root=n->left;
 n->left->parent=0;
 (*root)->color=1;
 return n1;
 }
 color=n->color;
 }
 else
 {
 p1=n->right;
 while(p1->left)
 {
 p1=p1->left;
 }
 if(p1==n->right)
 {
 p=n->parent;
 if(p)
 {
 if(p->left==n)
 {
 p->left=p1;
 }
 else
 {
 p->right=p1;
 }
 }
 else
 {
 *root=p1;
 }
 p1->parent=p;
 p1->left=n->left;
 n->left->parent=p1;
 color=p1->color;
 p1->color=n->color;
 p=p1;
 if_left=0;
 }
 else
 {
 p=p1->parent;
 if(p->left==p1)
 {
 p->left=p1->right;
 }
 else
 {
 p->right=p1->right;
 }
 if(p1->right)
 {
 p1->right->parent=p;
 }
 p1->left=n->left;
 p1->right=n->right;
 p1->parent=n->parent;
 color=p1->color;
 p1->color=n->color;
 p2=n->parent;
 if(p2)
 {
 if(p2->left==n)
 {
 p2->left=p1;
 }
 else
 {
 p2->right=p1;
 }
 }
 else
 {
 *root=p1;
 }
 if(n->left)
 {
 n->left->parent=p1;
 }
 if(n->right)
 {
 n->right->parent=p1;
 }
 if_left=1;
 }
 }
 if(color==0)
 {
 return n1;
 }
 n=p;
 while(1)
 {
 if(if_left)
 {
 if(n->left&&n->left->color==0)
 {
 n->left->color=1;
 break;
 }
 p=n->right;
 }
 else
 {
 if(n->right&&n->right->color==0)
 {
 n->right->color=1;
 break;
 }
 p=n->left;
 }
 if(if_left)
 {
 if(p&&p->color==0)
 {
 p->color=1;
 n->color=0;
 p1=n->parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=n->right;
 rotate_rl=rotate_r->left;
 if(p1)
 {
 if(p1->left==n)
 {
 p1->left=rotate_r;
 }
 else
 {
 p1->right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->parent=p1;
 rotate_r->left=n;
 n->parent=rotate_r;
 n->right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->parent=n;
 }
}
 }
 else
 {
 if(p&&p->right&&p->right->color==0)
 {
 p->color=n->color;
 n->color=1;
 p->right->color=1;
 p1=n->parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=n->right;
 rotate_rl=rotate_r->left;
 if(p1)
 {
 if(p1->left==n)
 {
 p1->left=rotate_r;
 }
 else
 {
 p1->right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->parent=p1;
 rotate_r->left=n;
 n->parent=rotate_r;
 n->right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->parent=n;
 }
}
 break;
 }
 else if(p&&p->left&&p->left->color==0)
 {
 p->left->color=1;
 p->color=0;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=p->left;
 rotate_lr=rotate_l->right;
 if(n)
 {
 if(n->left==p)
 {
 n->left=rotate_l;
 }
 else
 {
 n->right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->parent=n;
 rotate_l->right=p;
 p->parent=rotate_l;
 p->left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->parent=p;
 }
}
 }
 else
 {
 p->color=0;
 p=n;
 n=n->parent;
 if(n==0)
 {
 break;
 }
 if(n->right==p)
 {
 if_left=0;
 }
 }
 }
 }
 else
 {
 if(p&&p->color==0)
 {
 p->color=1;
 n->color=0;
 p1=n->parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=n->left;
 rotate_lr=rotate_l->right;
 if(p1)
 {
 if(p1->left==n)
 {
 p1->left=rotate_l;
 }
 else
 {
 p1->right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->parent=p1;
 rotate_l->right=n;
 n->parent=rotate_l;
 n->left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->parent=n;
 }
}
 }
 else
 {
 if(p&&p->left&&p->left->color==0)
 {
 p->color=n->color;
 n->color=1;
 p->left->color=1;
 p1=n->parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=n->left;
 rotate_lr=rotate_l->right;
 if(p1)
 {
 if(p1->left==n)
 {
 p1->left=rotate_l;
 }
 else
 {
 p1->right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->parent=p1;
 rotate_l->right=n;
 n->parent=rotate_l;
 n->left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->parent=n;
 }
}
 break;
 }
 else if(p&&p->right&&p->right->color==0)
 {
 p->right->color=1;
 p->color=0;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=p->right;
 rotate_rl=rotate_r->left;
 if(n)
 {
 if(n->left==p)
 {
 n->left=rotate_r;
 }
 else
 {
 n->right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->parent=n;
 rotate_r->left=p;
 p->parent=rotate_r;
 p->right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->parent=p;
 }
}
 }
 else
 {
 p->color=0;
 p=n;
 n=n->parent;
 if(n==0)
 {
 break;
 }
 if(n->left==p)
 {
 if_left=1;
 }
 }
 }
 }
 }
 (*root)->color=1;
 return n1;
}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
void __malloc_zone_start_add(struct __malloc_zone **root,struct __malloc_zone *node)
{
 struct __malloc_zone *p,*pp,*pa,*pr,*insert_pos;
 int if_left;
 if(*root==0)
 {
 *root=node;
 node->start_color=1;
 node->start_left=0;
 node->start_right=0;
 node->start_parent=0;
 return;
 }
 p=*root;
 do
 {
 insert_pos=p;
 if(((unsigned long int)(node)>(unsigned long int)(insert_pos)))
 {
 p=insert_pos->start_right;
 if_left=0;
 }
 else
 {
 p=insert_pos->start_left;
 if_left=1;
 }
 }
 while(p);
 if(if_left)
 {
 insert_pos->start_left=node;
 }
 else
 {
 insert_pos->start_right=node;
 }
 node->start_color=0;
 node->start_left=0;
 node->start_right=0;
 node->start_parent=insert_pos;
 p=insert_pos;
 if(p==0||p->start_color==1)
 {
 return;
 }
 pp=insert_pos->start_parent;
 while(1)
 {
 if(pp->start_left==p)
 {
 pa=pp->start_right;
 if(pa&&pa->start_color==0)
 {
 pa->start_color=1;
 p->start_color=1;
 pp->start_color=0;
 node=pp;
 p=node->start_parent;
 if(p==0||p->start_color==1)
 {
 break;
 }
 pp=p->start_parent;
 }
 else
 {
 if(p->start_right==node)
 {
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=p->start_right;
 rotate_rl=rotate_r->start_left;
 if(pp)
 {
 if(pp->start_left==p)
 {
 pp->start_left=rotate_r;
 }
 else
 {
 pp->start_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->start_parent=pp;
 rotate_r->start_left=p;
 p->start_parent=rotate_r;
 p->start_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->start_parent=p;
 }
}
 p=node;
 node=p->start_left;
 }
 pp->start_color=0;
 p->start_color=1;
 pr=pp->start_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=pp->start_left;
 rotate_lr=rotate_l->start_right;
 if(pr)
 {
 if(pr->start_left==pp)
 {
 pr->start_left=rotate_l;
 }
 else
 {
 pr->start_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->start_parent=pr;
 rotate_l->start_right=pp;
 pp->start_parent=rotate_l;
 pp->start_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->start_parent=pp;
 }
}
 break;
 }
 }
 else
 {
 pa=pp->start_left;
 if(pa&&pa->start_color==0)
 {
 pa->start_color=1;
 p->start_color=1;
 pp->start_color=0;
 node=pp;
 p=node->start_parent;
 if(p==0||p->start_color==1)
 {
 break;
 }
 pp=p->start_parent;
 }
 else
 {
 if(p->start_left==node)
 {
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=p->start_left;
 rotate_lr=rotate_l->start_right;
 if(pp)
 {
 if(pp->start_left==p)
 {
 pp->start_left=rotate_l;
 }
 else
 {
 pp->start_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->start_parent=pp;
 rotate_l->start_right=p;
 p->start_parent=rotate_l;
 p->start_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->start_parent=p;
 }
}
 p=node;
 node=p->start_right;
 }
 pp->start_color=0;
 p->start_color=1;
 pr=pp->start_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=pp->start_right;
 rotate_rl=rotate_r->start_left;
 if(pr)
 {
 if(pr->start_left==pp)
 {
 pr->start_left=rotate_r;
 }
 else
 {
 pr->start_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->start_parent=pr;
 rotate_r->start_left=pp;
 pp->start_parent=rotate_r;
 pp->start_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->start_parent=pp;
 }
}
 break;
 }
 }
 }
 (*root)->start_color=1;
}
 
struct __malloc_zone *__malloc_zone_start_del(struct __malloc_zone **root,struct __malloc_zone *node)
{
 struct __malloc_zone *n,*p,*p1,*p2,*n1;
 int if_left,color;
 n=*root;
 while(1)
 {
 if(n==0)
 {
 return 0;
 }
 if(((unsigned long int)(node)>(unsigned long int)(n)))
 {
 n=n->start_right;
 }
 else if(((unsigned long int)(n)>(unsigned long int)(node)))
 {
 n=n->start_left;
 }
 else
 {
 break;
 }
 }
 n1=n;
 if(n->start_left==0)
 {
 if(n->start_right==0)
 {
 p=n->start_parent;
 if(p)
 {
 if(p->start_left==n)
 {
 p->start_left=0;
 if_left=1;
 }
 else
 {
 p->start_right=0;
 if_left=0;
 }
 }
 else
 {
 *root=0;
 return n1;
 }
 }
 else
 {
 p=n->start_parent;
 if(p)
 {
 if(p->start_left==n)
 {
 p->start_left=n->start_right;
 if_left=1;
 }
 else
 {
 p->start_right=n->start_right;
 if_left=0;
 }
 n->start_right->start_parent=p;
 }
 else
 {
 *root=n->start_right;
 n->start_right->start_parent=0;
 (*root)->start_color=1;
 return n1;
 }
 }
 color=n->start_color;
 }
 else if(n->start_right==0)
 {
 p=n->start_parent;
 if(p)
 {
 if(p->start_left==n)
 {
 p->start_left=n->start_left;
 if_left=1;
 }
 else
 {
 p->start_right=n->start_left;
 if_left=0;
 }
 n->start_left->start_parent=p;
 }
 else
 {
 *root=n->start_left;
 n->start_left->start_parent=0;
 (*root)->start_color=1;
 return n1;
 }
 color=n->start_color;
 }
 else
 {
 p1=n->start_right;
 while(p1->start_left)
 {
 p1=p1->start_left;
 }
 if(p1==n->start_right)
 {
 p=n->start_parent;
 if(p)
 {
 if(p->start_left==n)
 {
 p->start_left=p1;
 }
 else
 {
 p->start_right=p1;
 }
 }
 else
 {
 *root=p1;
 }
 p1->start_parent=p;
 p1->start_left=n->start_left;
 n->start_left->start_parent=p1;
 color=p1->start_color;
 p1->start_color=n->start_color;
 p=p1;
 if_left=0;
 }
 else
 {
 p=p1->start_parent;
 if(p->start_left==p1)
 {
 p->start_left=p1->start_right;
 }
 else
 {
 p->start_right=p1->start_right;
 }
 if(p1->start_right)
 {
 p1->start_right->start_parent=p;
 }
 p1->start_left=n->start_left;
 p1->start_right=n->start_right;
 p1->start_parent=n->start_parent;
 color=p1->start_color;
 p1->start_color=n->start_color;
 p2=n->start_parent;
 if(p2)
 {
 if(p2->start_left==n)
 {
 p2->start_left=p1;
 }
 else
 {
 p2->start_right=p1;
 }
 }
 else
 {
 *root=p1;
 }
 if(n->start_left)
 {
 n->start_left->start_parent=p1;
 }
 if(n->start_right)
 {
 n->start_right->start_parent=p1;
 }
 if_left=1;
 }
 }
 if(color==0)
 {
 return n1;
 }
 n=p;
 while(1)
 {
 if(if_left)
 {
 if(n->start_left&&n->start_left->start_color==0)
 {
 n->start_left->start_color=1;
 break;
 }
 p=n->start_right;
 }
 else
 {
 if(n->start_right&&n->start_right->start_color==0)
 {
 n->start_right->start_color=1;
 break;
 }
 p=n->start_left;
 }
 if(if_left)
 {
 if(p&&p->start_color==0)
 {
 p->start_color=1;
 n->start_color=0;
 p1=n->start_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=n->start_right;
 rotate_rl=rotate_r->start_left;
 if(p1)
 {
 if(p1->start_left==n)
 {
 p1->start_left=rotate_r;
 }
 else
 {
 p1->start_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->start_parent=p1;
 rotate_r->start_left=n;
 n->start_parent=rotate_r;
 n->start_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->start_parent=n;
 }
}
 }
 else
 {
 if(p&&p->start_right&&p->start_right->start_color==0)
 {
 p->start_color=n->start_color;
 n->start_color=1;
 p->start_right->start_color=1;
 p1=n->start_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=n->start_right;
 rotate_rl=rotate_r->start_left;
 if(p1)
 {
 if(p1->start_left==n)
 {
 p1->start_left=rotate_r;
 }
 else
 {
 p1->start_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->start_parent=p1;
 rotate_r->start_left=n;
 n->start_parent=rotate_r;
 n->start_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->start_parent=n;
 }
}
 break;
 }
 else if(p&&p->start_left&&p->start_left->start_color==0)
 {
 p->start_left->start_color=1;
 p->start_color=0;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=p->start_left;
 rotate_lr=rotate_l->start_right;
 if(n)
 {
 if(n->start_left==p)
 {
 n->start_left=rotate_l;
 }
 else
 {
 n->start_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->start_parent=n;
 rotate_l->start_right=p;
 p->start_parent=rotate_l;
 p->start_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->start_parent=p;
 }
}
 }
 else
 {
 p->start_color=0;
 p=n;
 n=n->start_parent;
 if(n==0)
 {
 break;
 }
 if(n->start_right==p)
 {
 if_left=0;
 }
 }
 }
 }
 else
 {
 if(p&&p->start_color==0)
 {
 p->start_color=1;
 n->start_color=0;
 p1=n->start_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=n->start_left;
 rotate_lr=rotate_l->start_right;
 if(p1)
 {
 if(p1->start_left==n)
 {
 p1->start_left=rotate_l;
 }
 else
 {
 p1->start_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->start_parent=p1;
 rotate_l->start_right=n;
 n->start_parent=rotate_l;
 n->start_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->start_parent=n;
 }
}
 }
 else
 {
 if(p&&p->start_left&&p->start_left->start_color==0)
 {
 p->start_color=n->start_color;
 n->start_color=1;
 p->start_left->start_color=1;
 p1=n->start_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=n->start_left;
 rotate_lr=rotate_l->start_right;
 if(p1)
 {
 if(p1->start_left==n)
 {
 p1->start_left=rotate_l;
 }
 else
 {
 p1->start_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->start_parent=p1;
 rotate_l->start_right=n;
 n->start_parent=rotate_l;
 n->start_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->start_parent=n;
 }
}
 break;
 }
 else if(p&&p->start_right&&p->start_right->start_color==0)
 {
 p->start_right->start_color=1;
 p->start_color=0;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=p->start_right;
 rotate_rl=rotate_r->start_left;
 if(n)
 {
 if(n->start_left==p)
 {
 n->start_left=rotate_r;
 }
 else
 {
 n->start_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->start_parent=n;
 rotate_r->start_left=p;
 p->start_parent=rotate_r;
 p->start_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->start_parent=p;
 }
}
 }
 else
 {
 p->start_color=0;
 p=n;
 n=n->start_parent;
 if(n==0)
 {
 break;
 }
 if(n->start_left==p)
 {
 if_left=1;
 }
 }
 }
 }
 }
 (*root)->start_color=1;
 return n1;
}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
void __malloc_zone_end_add(struct __malloc_zone **root,struct __malloc_zone *node)
{
 struct __malloc_zone *p,*pp,*pa,*pr,*insert_pos;
 int if_left;
 if(*root==0)
 {
 *root=node;
 node->end_color=1;
 node->end_left=0;
 node->end_right=0;
 node->end_parent=0;
 return;
 }
 p=*root;
 do
 {
 insert_pos=p;
 if(((unsigned long int)(node)+(node)->size>(unsigned long int)(insert_pos)+(insert_pos)->size))
 {
 p=insert_pos->end_right;
 if_left=0;
 }
 else
 {
 p=insert_pos->end_left;
 if_left=1;
 }
 }
 while(p);
 if(if_left)
 {
 insert_pos->end_left=node;
 }
 else
 {
 insert_pos->end_right=node;
 }
 node->end_color=0;
 node->end_left=0;
 node->end_right=0;
 node->end_parent=insert_pos;
 p=insert_pos;
 if(p==0||p->end_color==1)
 {
 return;
 }
 pp=insert_pos->end_parent;
 while(1)
 {
 if(pp->end_left==p)
 {
 pa=pp->end_right;
 if(pa&&pa->end_color==0)
 {
 pa->end_color=1;
 p->end_color=1;
 pp->end_color=0;
 node=pp;
 p=node->end_parent;
 if(p==0||p->end_color==1)
 {
 break;
 }
 pp=p->end_parent;
 }
 else
 {
 if(p->end_right==node)
 {
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=p->end_right;
 rotate_rl=rotate_r->end_left;
 if(pp)
 {
 if(pp->end_left==p)
 {
 pp->end_left=rotate_r;
 }
 else
 {
 pp->end_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->end_parent=pp;
 rotate_r->end_left=p;
 p->end_parent=rotate_r;
 p->end_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->end_parent=p;
 }
}
 p=node;
 node=p->end_left;
 }
 pp->end_color=0;
 p->end_color=1;
 pr=pp->end_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=pp->end_left;
 rotate_lr=rotate_l->end_right;
 if(pr)
 {
 if(pr->end_left==pp)
 {
 pr->end_left=rotate_l;
 }
 else
 {
 pr->end_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->end_parent=pr;
 rotate_l->end_right=pp;
 pp->end_parent=rotate_l;
 pp->end_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->end_parent=pp;
 }
}
 break;
 }
 }
 else
 {
 pa=pp->end_left;
 if(pa&&pa->end_color==0)
 {
 pa->end_color=1;
 p->end_color=1;
 pp->end_color=0;
 node=pp;
 p=node->end_parent;
 if(p==0||p->end_color==1)
 {
 break;
 }
 pp=p->end_parent;
 }
 else
 {
 if(p->end_left==node)
 {
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=p->end_left;
 rotate_lr=rotate_l->end_right;
 if(pp)
 {
 if(pp->end_left==p)
 {
 pp->end_left=rotate_l;
 }
 else
 {
 pp->end_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->end_parent=pp;
 rotate_l->end_right=p;
 p->end_parent=rotate_l;
 p->end_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->end_parent=p;
 }
}
 p=node;
 node=p->end_right;
 }
 pp->end_color=0;
 p->end_color=1;
 pr=pp->end_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=pp->end_right;
 rotate_rl=rotate_r->end_left;
 if(pr)
 {
 if(pr->end_left==pp)
 {
 pr->end_left=rotate_r;
 }
 else
 {
 pr->end_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->end_parent=pr;
 rotate_r->end_left=pp;
 pp->end_parent=rotate_r;
 pp->end_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->end_parent=pp;
 }
}
 break;
 }
 }
 }
 (*root)->end_color=1;
}
 
struct __malloc_zone *__malloc_zone_end_del(struct __malloc_zone **root,struct __malloc_zone *node)
{
 struct __malloc_zone *n,*p,*p1,*p2,*n1;
 int if_left,color;
 n=*root;
 while(1)
 {
 if(n==0)
 {
 return 0;
 }
 if(((unsigned long int)(node)+(node)->size>(unsigned long int)(n)+(n)->size))
 {
 n=n->end_right;
 }
 else if(((unsigned long int)(n)+(n)->size>(unsigned long int)(node)+(node)->size))
 {
 n=n->end_left;
 }
 else
 {
 break;
 }
 }
 n1=n;
 if(n->end_left==0)
 {
 if(n->end_right==0)
 {
 p=n->end_parent;
 if(p)
 {
 if(p->end_left==n)
 {
 p->end_left=0;
 if_left=1;
 }
 else
 {
 p->end_right=0;
 if_left=0;
 }
 }
 else
 {
 *root=0;
 return n1;
 }
 }
 else
 {
 p=n->end_parent;
 if(p)
 {
 if(p->end_left==n)
 {
 p->end_left=n->end_right;
 if_left=1;
 }
 else
 {
 p->end_right=n->end_right;
 if_left=0;
 }
 n->end_right->end_parent=p;
 }
 else
 {
 *root=n->end_right;
 n->end_right->end_parent=0;
 (*root)->end_color=1;
 return n1;
 }
 }
 color=n->end_color;
 }
 else if(n->end_right==0)
 {
 p=n->end_parent;
 if(p)
 {
 if(p->end_left==n)
 {
 p->end_left=n->end_left;
 if_left=1;
 }
 else
 {
 p->end_right=n->end_left;
 if_left=0;
 }
 n->end_left->end_parent=p;
 }
 else
 {
 *root=n->end_left;
 n->end_left->end_parent=0;
 (*root)->end_color=1;
 return n1;
 }
 color=n->end_color;
 }
 else
 {
 p1=n->end_right;
 while(p1->end_left)
 {
 p1=p1->end_left;
 }
 if(p1==n->end_right)
 {
 p=n->end_parent;
 if(p)
 {
 if(p->end_left==n)
 {
 p->end_left=p1;
 }
 else
 {
 p->end_right=p1;
 }
 }
 else
 {
 *root=p1;
 }
 p1->end_parent=p;
 p1->end_left=n->end_left;
 n->end_left->end_parent=p1;
 color=p1->end_color;
 p1->end_color=n->end_color;
 p=p1;
 if_left=0;
 }
 else
 {
 p=p1->end_parent;
 if(p->end_left==p1)
 {
 p->end_left=p1->end_right;
 }
 else
 {
 p->end_right=p1->end_right;
 }
 if(p1->end_right)
 {
 p1->end_right->end_parent=p;
 }
 p1->end_left=n->end_left;
 p1->end_right=n->end_right;
 p1->end_parent=n->end_parent;
 color=p1->end_color;
 p1->end_color=n->end_color;
 p2=n->end_parent;
 if(p2)
 {
 if(p2->end_left==n)
 {
 p2->end_left=p1;
 }
 else
 {
 p2->end_right=p1;
 }
 }
 else
 {
 *root=p1;
 }
 if(n->end_left)
 {
 n->end_left->end_parent=p1;
 }
 if(n->end_right)
 {
 n->end_right->end_parent=p1;
 }
 if_left=1;
 }
 }
 if(color==0)
 {
 return n1;
 }
 n=p;
 while(1)
 {
 if(if_left)
 {
 if(n->end_left&&n->end_left->end_color==0)
 {
 n->end_left->end_color=1;
 break;
 }
 p=n->end_right;
 }
 else
 {
 if(n->end_right&&n->end_right->end_color==0)
 {
 n->end_right->end_color=1;
 break;
 }
 p=n->end_left;
 }
 if(if_left)
 {
 if(p&&p->end_color==0)
 {
 p->end_color=1;
 n->end_color=0;
 p1=n->end_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=n->end_right;
 rotate_rl=rotate_r->end_left;
 if(p1)
 {
 if(p1->end_left==n)
 {
 p1->end_left=rotate_r;
 }
 else
 {
 p1->end_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->end_parent=p1;
 rotate_r->end_left=n;
 n->end_parent=rotate_r;
 n->end_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->end_parent=n;
 }
}
 }
 else
 {
 if(p&&p->end_right&&p->end_right->end_color==0)
 {
 p->end_color=n->end_color;
 n->end_color=1;
 p->end_right->end_color=1;
 p1=n->end_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=n->end_right;
 rotate_rl=rotate_r->end_left;
 if(p1)
 {
 if(p1->end_left==n)
 {
 p1->end_left=rotate_r;
 }
 else
 {
 p1->end_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->end_parent=p1;
 rotate_r->end_left=n;
 n->end_parent=rotate_r;
 n->end_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->end_parent=n;
 }
}
 break;
 }
 else if(p&&p->end_left&&p->end_left->end_color==0)
 {
 p->end_left->end_color=1;
 p->end_color=0;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=p->end_left;
 rotate_lr=rotate_l->end_right;
 if(n)
 {
 if(n->end_left==p)
 {
 n->end_left=rotate_l;
 }
 else
 {
 n->end_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->end_parent=n;
 rotate_l->end_right=p;
 p->end_parent=rotate_l;
 p->end_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->end_parent=p;
 }
}
 }
 else
 {
 p->end_color=0;
 p=n;
 n=n->end_parent;
 if(n==0)
 {
 break;
 }
 if(n->end_right==p)
 {
 if_left=0;
 }
 }
 }
 }
 else
 {
 if(p&&p->end_color==0)
 {
 p->end_color=1;
 n->end_color=0;
 p1=n->end_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=n->end_left;
 rotate_lr=rotate_l->end_right;
 if(p1)
 {
 if(p1->end_left==n)
 {
 p1->end_left=rotate_l;
 }
 else
 {
 p1->end_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->end_parent=p1;
 rotate_l->end_right=n;
 n->end_parent=rotate_l;
 n->end_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->end_parent=n;
 }
}
 }
 else
 {
 if(p&&p->end_left&&p->end_left->end_color==0)
 {
 p->end_color=n->end_color;
 n->end_color=1;
 p->end_left->end_color=1;
 p1=n->end_parent;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_l,*rotate_lr;
 rotate_l=n->end_left;
 rotate_lr=rotate_l->end_right;
 if(p1)
 {
 if(p1->end_left==n)
 {
 p1->end_left=rotate_l;
 }
 else
 {
 p1->end_right=rotate_l;
 }
 }
 else
 {
 *root=rotate_l;
 }
 rotate_l->end_parent=p1;
 rotate_l->end_right=n;
 n->end_parent=rotate_l;
 n->end_left=rotate_lr;
 if(rotate_lr)
 {
 rotate_lr->end_parent=n;
 }
}
 break;
 }
 else if(p&&p->end_right&&p->end_right->end_color==0)
 {
 p->end_right->end_color=1;
 p->end_color=0;
 
 
 
 
 
 
 
 
 
{
 struct __malloc_zone *rotate_r,*rotate_rl;
 rotate_r=p->end_right;
 rotate_rl=rotate_r->end_left;
 if(n)
 {
 if(n->end_left==p)
 {
 n->end_left=rotate_r;
 }
 else
 {
 n->end_right=rotate_r;
 }
 }
 else
 {
 *root=rotate_r;
 }
 rotate_r->end_parent=n;
 rotate_r->end_left=p;
 p->end_parent=rotate_r;
 p->end_right=rotate_rl;
 if(rotate_rl)
 {
 rotate_rl->end_parent=p;
 }
}
 }
 else
 {
 p->end_color=0;
 p=n;
 n=n->end_parent;
 if(n==0)
 {
 break;
 }
 if(n->end_left==p)
 {
 if_left=1;
 }
 }
 }
 }
 }
 (*root)->end_color=1;
 return n1;
}
 
 
 
 
char *__current_brk;
unsigned long int __heap_size;
void *__set_heap_size(unsigned long int size)
{
 char *new_brk,*old_brk;
 if(__current_brk==0)
 {
 __current_brk=((void *)__syscall((long)(12),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)));
 }
 old_brk=__current_brk+__heap_size;
 new_brk=((void *)__syscall((long)(12),(long)(__current_brk+size),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)));
 if(new_brk==old_brk&&size!=__heap_size)
 {
 return 0;
 }
 __heap_size=size;
 return old_brk;
}
 
struct __malloc_zone *__malloc_start_tab[65537],*__malloc_end_tab[65537],*__malloc_zone_root;
void __malloc_zone_start_tab_add(struct __malloc_zone *node)
{
 unsigned long long int addr;
 int hash;
 addr=(unsigned long long int)node;
 hash=(addr>>16|addr<<48)%65537;
 __malloc_zone_start_add(__malloc_start_tab+hash,node);
}
void __malloc_zone_end_tab_add(struct __malloc_zone *node)
{
 unsigned long long int addr;
 int hash;
 addr=(unsigned long long int)node+node->size;
 hash=(addr>>16|addr<<48)%65537;
 __malloc_zone_end_add(__malloc_end_tab+hash,node);
}
void __malloc_zone_start_tab_del(struct __malloc_zone *ptr)
{
 unsigned long long int addr;
 int hash;
 addr=(unsigned long long int)ptr;
 hash=(addr>>16|addr<<48)%65537;
 __malloc_zone_start_del(__malloc_start_tab+hash,ptr);
}
void __malloc_zone_end_tab_del(struct __malloc_zone *ptr)
{
 unsigned long long int addr;
 int hash;
 addr=(unsigned long long int)ptr+ptr->size;
 hash=(addr>>16|addr<<48)%65537;
 __malloc_zone_end_del(__malloc_end_tab+hash,ptr);
}
struct __malloc_zone *__malloc_zone_start_tab_find(void *ptr)
{
 unsigned long long int addr;
 int hash;
 struct __malloc_zone *node;
 addr=(unsigned long long int)ptr;
 hash=(addr>>16|addr<<48)%65537;
 node=__malloc_start_tab[hash];
 while(node&&(unsigned long long int)node!=addr)
 {
 if((unsigned long long int)node>addr)
 {
 node=node->start_left;
 }
 else
 {
 node=node->start_right;
 }
 }
 return node;
}
struct __malloc_zone *__malloc_zone_end_tab_find(void *ptr)
{
 unsigned long long int addr;
 int hash;
 struct __malloc_zone *node;
 addr=(unsigned long long int)ptr;
 hash=(addr>>16|addr<<48)%65537;
 node=__malloc_end_tab[hash];
 while(node&&(unsigned long long int)node+node->size!=addr)
 {
 if((unsigned long long int)node+node->size>addr)
 {
 node=node->end_left;
 }
 else
 {
 node=node->end_right;
 }
 }
 return node;
}
struct __malloc_zone *__malloc_zone_size_find(unsigned long long int size)
{
 struct __malloc_zone *node,*p;
 node=__malloc_zone_root;
 p=0;
 while(node)
 {
 if(node->size>=size)
 {
 p=node;
 node=node->left;
 }
 else
 {
 node=node->right;
 }
 }
 return p;
}
void __malloc_error(void)
{
 __syscall((long)(1),(long)(2),(long)("invalid pointer or corruption detected.\n"),(long)(40),(long)(0),(long)(0),(long)(0));
 while(1)
 {
 asm "int3"
 }
}
void __malloc_zone_add(struct __malloc_zone *node)
{
 if(node->magic!=0xacf31e53)
 {
 __malloc_error();
 }
 node->used=0;
 __malloc_zone_size_add(&__malloc_zone_root,node);
 __malloc_zone_start_tab_add(node);
 __malloc_zone_end_tab_add(node);
}
void __malloc_zone_del(struct __malloc_zone *node)
{
 if(node->magic!=0xacf31e53)
 {
 __malloc_error();
 }
 node->used=0;
 __malloc_zone_size_del(&__malloc_zone_root,node);
 __malloc_zone_start_tab_del(node);
 __malloc_zone_end_tab_del(node);
}
void *malloc_nolock(unsigned long long int size)
{
 unsigned long long int size1,size2;
 struct __malloc_zone *zone,*new_zone;
 int hash;
 void *ret;
 if(size==0)
 {
 return 0;
 }
 size1=((size-1>>4)+1<<4)+128;
 
 zone=__malloc_zone_size_find(size1);
 if(zone==0)
 {
 if(size1<0x8000)
 {
 size2=0x200000;
 }
 else if(size1<0x40000)
 {
 size2=0x1000000;
 }
 else
 {
 size2=size1*8;
 }
 size2=(size2-1>>12)+1<<12;
 if(!(zone=__set_heap_size(__heap_size+size2)))
 {
 size2=size1;
 size2=(size2-1>>12)+1<<12;
 if(!(zone=__set_heap_size(__heap_size+size2)))
 {
 return 0;
 }
 }
 zone->size=size2;
 zone->magic=0xacf31e53;
 }
 else
 {
 __malloc_zone_del(zone);
 }
 ret=(char *)zone+32;
 if(size1>zone->size)
 {
 __malloc_error();
 }
 if(size1+384<zone->size)
 {
 new_zone=(void *)((char *)zone+size1);
 new_zone->magic=0xacf31e53;
 new_zone->size=zone->size-size1;
 __malloc_zone_add(new_zone);
 zone->size=size1;
 }
 zone->used=1;
 return ret;
}
void _free(struct __malloc_zone *zone)
{
 struct __malloc_zone *start,*end;
 __malloc_zone_add(zone);
 if(start=__malloc_zone_end_tab_find(zone))
 {
 __malloc_zone_del(zone);
 __malloc_zone_del(start);
 start->size+=zone->size;
 __malloc_zone_add(start);
 zone=start;
 }
 if(end=__malloc_zone_start_tab_find((char *)zone+zone->size))
 {
 __malloc_zone_del(zone);
 __malloc_zone_del(end);
 zone->size+=end->size;
 __malloc_zone_add(zone);
 }
 if((char *)zone+zone->size==__current_brk+__heap_size&&zone->size>=16384)
 {
 __malloc_zone_del(zone);
 __set_heap_size(__heap_size-zone->size);
 }
}
void free_nolock(void *ptr)
{
 struct __malloc_zone *zone;
 if(!ptr)
 {
 return;
 }
 zone=(void *)((char *)ptr-32);
 if(zone->used!=1)
 {
 __malloc_error();
 }
 _free(zone);
}
unsigned int __malloc_mutex;
void *malloc(unsigned long int size)
{
 void *ptr;
 mutex_lock(&__malloc_mutex);
 ptr=malloc_nolock(size);
 mutex_unlock(&__malloc_mutex);
 return ptr;
}
void free(void *ptr)
{
 mutex_lock(&__malloc_mutex);
 free_nolock(ptr);
 mutex_unlock(&__malloc_mutex);
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
struct termios
{
 unsigned int iflag;
 unsigned int oflag;
 unsigned int cflag;
 unsigned int lflag;
 unsigned char line;
 unsigned char cc[32];
 unsigned int ispeed;
 unsigned int ospeed;
};
struct winsize
{
 unsigned short row;
 unsigned short col;
 unsigned int unused;
};
struct sigaction
{
 void (*handler)(int);
 int flags;
 int pad;
 void (*restorer)(void);
 unsigned long long int mask[16];
};
struct sigset
{
 unsigned long long int val[16];
};
void __def_sigreturn(void);
asm "@__def_sigreturn"
asm "mov $15,%eax"
asm "syscall"
asm "jmp @__def_sigreturn"
 

void (*signal(int sig,void (*handler)(int)))(int)
{
 struct sigaction act,old_act;
 memset(&act,0,sizeof(act));
 act.handler=handler;
 act.flags=0x4000000;
 act.restorer=__def_sigreturn;
 __syscall((long)(13),(long)(sig),(long)(&act),(long)(&old_act),(long)(8),(long)(0),(long)(0));
 return old_act.handler;
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
 
 
asm "@include_cpio_start"
asm ".byte 48,55,48,55,48,49,48,48,48,48,48,48,48,50,48,48,48,48,52,49,69,68,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,51,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,50,48,48,48,48,48,48,48,48,46,0,48,55,48,55,48,49,48,48,48,48,48,48,48,51,48,48"
asm ".byte 48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,50,57,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47"
asm ".byte 100,105,114,101,110,116,46,99,0,0,0,0,35,105,102,110,100,101,102,32,95,68,73,82,69,78,84,95,67,95,10,35"
asm ".byte 100,101,102,105,110,101,32,95,68,73,82,69,78,84,95,67,95,10,35,105,110,99,108,117,100,101,32,34,115,121,115,99"
asm ".byte 97,108,108,46,99,34,10,35,100,101,102,105,110,101,32,68,73,82,80,95,83,73,90,69,32,49,48,49,54,10,115,116"
asm ".byte 114,117,99,116,32,100,105,114,101,110,116,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116"
asm ".byte 32,105,110,111,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,111,102,102,59,10,9,117"
asm ".byte 110,115,105,103,110,101,100,32,115,104,111,114,116,32,114,101,99,108,101,110,59,10,9,117,110,115,105,103,110,101,100,32"
asm ".byte 99,104,97,114,32,116,121,112,101,59,10,9,99,104,97,114,32,110,97,109,101,91,49,93,59,10,125,59,10,115,116,114"
asm ".byte 117,99,116,32,68,73,82,10,123,10,9,105,110,116,32,102,100,59,10,9,115,104,111,114,116,32,111,102,102,59,10,9"
asm ".byte 115,104,111,114,116,32,115,105,122,101,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,98,117,102,91,68"
asm ".byte 73,82,80,95,83,73,90,69,93,59,10,125,59,10,118,111,105,100,32,100,105,114,95,105,110,105,116,40,105,110,116,32"
asm ".byte 102,100,44,115,116,114,117,99,116,32,68,73,82,32,42,100,112,41,10,123,10,9,100,112,45,62,102,100,61,102,100,59"
asm ".byte 10,9,100,112,45,62,111,102,102,61,48,59,10,9,100,112,45,62,115,105,122,101,61,48,59,10,125,10,115,116,114,117"
asm ".byte 99,116,32,100,105,114,101,110,116,32,42,114,101,97,100,100,105,114,40,115,116,114,117,99,116,32,68,73,82,32,42,100"
asm ".byte 112,41,10,123,10,9,115,116,114,117,99,116,32,100,105,114,101,110,116,32,42,114,101,116,59,10,9,105,102,40,100,112"
asm ".byte 45,62,111,102,102,61,61,100,112,45,62,115,105,122,101,41,10,9,123,10,9,9,100,112,45,62,111,102,102,61,48,59"
asm ".byte 10,9,9,100,112,45,62,115,105,122,101,61,103,101,116,100,101,110,116,115,54,52,40,100,112,45,62,102,100,44,100,112"
asm ".byte 45,62,98,117,102,44,68,73,82,80,95,83,73,90,69,41,59,10,9,9,105,102,40,100,112,45,62,115,105,122,101,60"
asm ".byte 61,48,41,10,9,9,123,10,9,9,9,100,112,45,62,115,105,122,101,61,48,59,10,9,9,9,114,101,116,117,114,110"
asm ".byte 32,78,85,76,76,59,10,9,9,125,10,9,125,10,9,114,101,116,61,40,118,111,105,100,32,42,41,40,100,112,45,62"
asm ".byte 98,117,102,43,100,112,45,62,111,102,102,41,59,10,9,100,112,45,62,111,102,102,43,61,114,101,116,45,62,114,101,99"
asm ".byte 108,101,110,59,10,9,114,101,116,117,114,110,32,114,101,116,59,10,125,10,10,35,101,110,100,105,102,10,48,55,48,55"
asm ".byte 48,49,48,48,48,48,48,48,48,52,48,48,48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,50,65,70,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,65,48,48,48,48,48,48,48,48,46,47,102,108,111,97,116,46,99,0,35,105,102,110,100,101,102,32,95,70,76,79"
asm ".byte 65,84,95,67,95,10,35,100,101,102,105,110,101,32,95,70,76,79,65,84,95,67,95,10,35,100,101,102,105,110,101,32"
asm ".byte 95,69,82,82,79,82,32,48,46,48,48,48,48,48,48,48,48,48,48,48,48,48,49,10,102,108,111,97,116,32,115,113"
asm ".byte 114,116,40,102,108,111,97,116,32,97,41,10,123,10,9,102,108,111,97,116,32,114,101,116,44,98,59,10,9,114,101,116"
asm ".byte 61,49,46,48,59,10,9,100,111,10,9,123,10,9,9,98,61,114,101,116,59,10,9,9,114,101,116,61,98,42,48,46"
asm ".byte 53,43,97,47,40,50,46,48,42,98,41,59,10,9,125,10,9,119,104,105,108,101,40,98,47,114,101,116,62,49,46,48"
asm ".byte 43,95,69,82,82,79,82,124,124,98,47,114,101,116,60,49,46,48,45,95,69,82,82,79,82,124,124,98,45,114,101,116"
asm ".byte 60,45,95,69,82,82,79,82,124,124,98,45,114,101,116,62,95,69,82,82,79,82,41,59,10,9,114,101,116,117,114,110"
asm ".byte 32,114,101,116,59,10,125,10,102,108,111,97,116,32,95,115,105,110,40,102,108,111,97,116,32,97,41,10,123,10,9,102"
asm ".byte 108,111,97,116,32,110,44,114,101,116,44,110,49,44,98,59,10,9,114,101,116,61,48,46,48,59,10,9,110,61,49,46"
asm ".byte 48,59,10,9,110,49,61,45,51,46,48,59,10,9,98,61,97,59,10,9,97,61,97,42,97,59,10,9,119,104,105,108"
asm ".byte 101,40,49,46,48,47,110,62,95,69,82,82,79,82,124,124,49,46,48,47,110,60,45,95,69,82,82,79,82,41,10,9"
asm ".byte 123,10,9,9,114,101,116,43,61,98,47,110,59,10,9,9,98,42,61,97,59,10,9,9,110,42,61,45,110,49,42,40"
asm ".byte 110,49,43,49,46,48,41,59,10,9,9,110,49,45,61,50,46,48,59,10,9,125,10,9,114,101,116,117,114,110,32,114"
asm ".byte 101,116,59,10,125,10,102,108,111,97,116,32,99,111,115,40,102,108,111,97,116,32,97,41,10,123,10,9,105,102,40,97"
asm ".byte 60,49,46,48,38,38,97,62,45,49,46,48,41,10,9,123,10,9,9,97,61,95,115,105,110,40,97,41,59,10,9,9"
asm ".byte 114,101,116,117,114,110,32,115,113,114,116,40,49,46,48,45,97,42,97,41,59,10,9,125,10,9,97,61,99,111,115,40"
asm ".byte 97,42,48,46,53,41,59,10,9,97,61,50,46,48,42,97,42,97,45,49,46,48,59,10,9,114,101,116,117,114,110,32"
asm ".byte 97,59,10,125,10,102,108,111,97,116,32,115,105,110,40,102,108,111,97,116,32,97,41,10,123,10,9,105,102,40,97,60"
asm ".byte 49,46,48,38,38,97,62,45,49,46,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,95,115,105,110,40,97,41"
asm ".byte 59,10,9,125,10,9,114,101,116,117,114,110,32,99,111,115,40,97,45,51,46,49,52,49,53,57,50,54,53,51,53,56"
asm ".byte 57,55,57,51,50,42,48,46,53,41,59,10,125,10,35,117,110,100,101,102,32,95,69,82,82,79,82,10,35,101,110,100"
asm ".byte 105,102,10,0,48,55,48,55,48,49,48,48,48,48,48,48,48,53,48,48,48,48,56,49,65,52,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 56,66,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,65,48,48,48,48,48,48,48,48,46,47,101,114,114,111,114,46,99,0,35,105,102,110"
asm ".byte 100,101,102,32,95,69,82,82,79,82,95,67,95,10,35,100,101,102,105,110,101,32,95,69,82,82,79,82,95,67,95,10"
asm ".byte 35,100,101,102,105,110,101,32,69,65,71,65,73,78,32,49,49,10,35,100,101,102,105,110,101,32,69,69,88,73,83,84"
asm ".byte 32,49,55,10,35,100,101,102,105,110,101,32,69,78,79,84,68,73,82,32,50,48,10,35,100,101,102,105,110,101,32,69"
asm ".byte 80,73,80,69,32,51,50,10,35,100,101,102,105,110,101,32,69,78,65,77,69,84,79,79,76,79,78,71,32,51,54,10"
asm ".byte 35,101,110,100,105,102,10,0,48,55,48,55,48,49,48,48,48,48,48,48,48,54,48,48,48,48,56,49,65,52,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,53,56,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,115,105,103,110,97,108,46,99"
asm ".byte 0,0,0,0,35,105,102,110,100,101,102,32,95,83,73,71,78,65,76,95,67,95,10,35,100,101,102,105,110,101,32,95"
asm ".byte 83,73,71,78,65,76,95,67,95,10,35,105,110,99,108,117,100,101,32,34,115,121,115,99,97,108,108,46,99,34,10,35"
asm ".byte 105,110,99,108,117,100,101,32,34,109,101,109,46,99,34,10,115,116,114,117,99,116,32,115,105,103,97,99,116,105,111,110"
asm ".byte 10,123,10,9,118,111,105,100,32,40,42,104,97,110,100,108,101,114,41,40,105,110,116,41,59,10,9,105,110,116,32,102"
asm ".byte 108,97,103,115,59,10,9,105,110,116,32,112,97,100,59,10,9,118,111,105,100,32,40,42,114,101,115,116,111,114,101,114"
asm ".byte 41,40,118,111,105,100,41,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116"
asm ".byte 32,109,97,115,107,91,49,54,93,59,10,125,59,10,115,116,114,117,99,116,32,115,105,103,115,101,116,10,123,10,9,117"
asm ".byte 110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,32,118,97,108,91,49,54,93,59,10,125"
asm ".byte 59,10,35,100,101,102,105,110,101,32,83,73,71,72,85,80,32,49,10,35,100,101,102,105,110,101,32,83,73,71,73,78"
asm ".byte 84,32,50,10,35,100,101,102,105,110,101,32,83,73,71,81,85,73,84,32,51,10,35,100,101,102,105,110,101,32,83,73"
asm ".byte 71,73,76,76,32,52,10,35,100,101,102,105,110,101,32,83,73,71,84,82,65,80,32,53,10,35,100,101,102,105,110,101"
asm ".byte 32,83,73,71,65,66,82,84,32,54,10,35,100,101,102,105,110,101,32,83,73,71,66,85,83,32,55,10,35,100,101,102"
asm ".byte 105,110,101,32,83,73,71,70,80,69,32,56,10,35,100,101,102,105,110,101,32,83,73,71,75,73,76,76,32,57,10,35"
asm ".byte 100,101,102,105,110,101,32,83,73,71,85,83,82,49,32,49,48,10,35,100,101,102,105,110,101,32,83,73,71,83,69,71"
asm ".byte 86,32,49,49,10,35,100,101,102,105,110,101,32,83,73,71,85,83,82,50,32,49,50,10,35,100,101,102,105,110,101,32"
asm ".byte 83,73,71,80,73,80,69,32,49,51,10,35,100,101,102,105,110,101,32,83,73,71,65,76,82,77,32,49,52,10,35,100"
asm ".byte 101,102,105,110,101,32,83,73,71,84,69,82,77,32,49,53,10,35,100,101,102,105,110,101,32,83,73,71,83,84,75,70"
asm ".byte 76,84,32,49,54,10,35,100,101,102,105,110,101,32,83,73,71,67,72,76,68,32,49,55,10,35,100,101,102,105,110,101"
asm ".byte 32,83,73,71,67,79,78,84,32,49,56,10,35,100,101,102,105,110,101,32,83,73,71,83,84,79,80,32,49,57,10,35"
asm ".byte 100,101,102,105,110,101,32,83,73,71,84,83,84,80,32,50,48,10,35,100,101,102,105,110,101,32,83,73,71,84,84,73"
asm ".byte 78,32,50,49,10,35,100,101,102,105,110,101,32,83,73,71,84,84,79,85,32,50,50,10,35,100,101,102,105,110,101,32"
asm ".byte 83,73,71,85,82,71,32,50,51,10,35,100,101,102,105,110,101,32,83,73,71,88,67,80,85,32,50,52,10,35,100,101"
asm ".byte 102,105,110,101,32,83,73,71,88,70,83,90,32,50,53,10,35,100,101,102,105,110,101,32,83,73,71,86,84,65,76,82"
asm ".byte 77,32,50,54,10,35,100,101,102,105,110,101,32,83,73,71,80,82,79,70,32,50,55,10,35,100,101,102,105,110,101,32"
asm ".byte 83,73,71,87,73,78,67,72,32,50,56,10,35,100,101,102,105,110,101,32,83,73,71,73,79,32,50,57,10,35,100,101"
asm ".byte 102,105,110,101,32,83,73,71,80,87,82,32,51,48,10,35,100,101,102,105,110,101,32,83,73,71,83,89,83,32,51,49"
asm ".byte 10,118,111,105,100,32,95,95,100,101,102,95,115,105,103,114,101,116,117,114,110,40,118,111,105,100,41,59,10,97,115,109"
asm ".byte 32,34,64,95,95,100,101,102,95,115,105,103,114,101,116,117,114,110,34,10,97,115,109,32,34,109,111,118,32,36,49,53"
asm ".byte 44,37,101,97,120,34,10,97,115,109,32,34,115,121,115,99,97,108,108,34,10,97,115,109,32,34,106,109,112,32,64,95"
asm ".byte 95,100,101,102,95,115,105,103,114,101,116,117,114,110,34,10,35,100,101,102,105,110,101,32,83,73,71,95,68,70,76,32"
asm ".byte 40,40,118,111,105,100,32,42,41,48,41,10,35,100,101,102,105,110,101,32,83,73,71,95,73,71,78,32,40,40,118,111"
asm ".byte 105,100,32,42,41,49,41,10,35,100,101,102,105,110,101,32,83,65,95,82,69,83,84,79,82,69,82,32,48,120,52,48"
asm ".byte 48,48,48,48,48,10,10,35,100,101,102,105,110,101,32,83,73,71,95,66,76,79,67,75,32,48,10,35,100,101,102,105"
asm ".byte 110,101,32,83,73,71,95,85,78,66,76,79,67,75,32,49,10,47,47,32,78,79,84,69,58,32,84,104,101,32,83,73"
asm ".byte 71,32,97,114,103,117,109,101,110,116,32,111,102,32,115,105,103,110,97,108,32,104,97,110,100,108,101,114,32,105,115,32"
asm ".byte 117,110,114,101,108,105,97,98,108,101,32,105,110,32,83,67,67,32,101,110,118,105,114,111,110,109,101,110,116,46,10,118"
asm ".byte 111,105,100,32,40,42,115,105,103,110,97,108,40,105,110,116,32,115,105,103,44,118,111,105,100,32,40,42,104,97,110,100"
asm ".byte 108,101,114,41,40,105,110,116,41,41,41,40,105,110,116,41,10,123,10,9,115,116,114,117,99,116,32,115,105,103,97,99"
asm ".byte 116,105,111,110,32,97,99,116,44,111,108,100,95,97,99,116,59,10,9,109,101,109,115,101,116,40,38,97,99,116,44,48"
asm ".byte 44,115,105,122,101,111,102,40,97,99,116,41,41,59,10,9,97,99,116,46,104,97,110,100,108,101,114,61,104,97,110,100"
asm ".byte 108,101,114,59,10,9,97,99,116,46,102,108,97,103,115,61,83,65,95,82,69,83,84,79,82,69,82,59,10,9,97,99"
asm ".byte 116,46,114,101,115,116,111,114,101,114,61,95,95,100,101,102,95,115,105,103,114,101,116,117,114,110,59,10,9,115,121,115"
asm ".byte 99,97,108,108,40,49,51,44,115,105,103,44,38,97,99,116,44,38,111,108,100,95,97,99,116,44,56,44,48,44,48,41"
asm ".byte 59,10,9,114,101,116,117,114,110,32,111,108,100,95,97,99,116,46,104,97,110,100,108,101,114,59,10,125,10,35,101,110"
asm ".byte 100,105,102,10,48,55,48,55,48,49,48,48,48,48,48,48,48,55,48,48,48,48,56,49,65,52,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,49"
asm ".byte 69,67,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,115,111,99,107,95,114,101,97,100,46,99,0"
asm ".byte 35,105,102,110,100,101,102,32,95,83,79,67,75,95,82,69,65,68,95,67,95,10,35,100,101,102,105,110,101,32,95,83"
asm ".byte 79,67,75,95,82,69,65,68,95,67,95,10,35,105,110,99,108,117,100,101,32,34,115,121,115,99,97,108,108,46,99,34"
asm ".byte 10,35,105,110,99,108,117,100,101,32,34,115,111,99,107,101,116,46,99,34,10,35,105,110,99,108,117,100,101,32,34,112"
asm ".byte 111,108,108,46,99,34,10,105,110,116,32,115,111,99,107,95,114,101,97,100,40,105,110,116,32,102,100,44,118,111,105,100"
asm ".byte 32,42,98,117,102,44,105,110,116,32,115,105,122,101,41,10,123,10,9,115,116,114,117,99,116,32,112,111,108,108,102,100"
asm ".byte 32,112,102,100,59,10,9,105,110,116,32,110,44,120,59,10,9,110,61,48,59,10,9,119,104,105,108,101,40,110,60,115"
asm ".byte 105,122,101,41,10,9,123,10,9,9,112,102,100,46,102,100,61,102,100,59,10,9,9,112,102,100,46,101,118,101,110,116"
asm ".byte 115,61,80,79,76,76,73,78,59,10,9,9,112,102,100,46,114,101,118,101,110,116,115,61,48,59,10,9,9,105,102,40"
asm ".byte 112,111,108,108,40,38,112,102,100,44,49,44,45,49,41,61,61,49,41,10,9,9,123,10,9,9,9,105,102,40,112,102"
asm ".byte 100,46,114,101,118,101,110,116,115,38,80,79,76,76,72,85,80,41,10,9,9,9,123,10,9,9,9,9,98,114,101,97"
asm ".byte 107,59,10,9,9,9,125,10,9,9,9,101,108,115,101,32,105,102,40,112,102,100,46,114,101,118,101,110,116,115,38,80"
asm ".byte 79,76,76,73,78,41,10,9,9,9,123,10,9,9,9,9,120,61,114,101,97,100,40,102,100,44,98,117,102,44,115,105"
asm ".byte 122,101,45,110,41,59,10,9,9,9,9,105,102,40,120,60,48,41,10,9,9,9,9,123,10,9,9,9,9,9,98,114"
asm ".byte 101,97,107,59,10,9,9,9,9,125,10,9,9,9,9,110,43,61,120,59,10,9,9,9,9,98,117,102,61,40,99,104"
asm ".byte 97,114,32,42,41,98,117,102,43,120,59,10,9,9,9,125,10,9,9,125,10,9,125,10,9,114,101,116,117,114,110,32"
asm ".byte 110,59,10,125,10,35,101,110,100,105,102,10,48,55,48,55,48,49,48,48,48,48,48,48,48,56,48,48,48,48,52,49"
asm ".byte 69,68,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,50,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,116,101,109,112"
asm ".byte 108,97,116,101,115,0,0,0,48,55,48,55,48,49,48,48,48,48,48,48,48,57,48,48,48,48,56,49,65,52,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,50,54,55,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,49,54,48,48,48,48,48,48,48,48,46,47,116,101,109,112,108,97,116,101"
asm ".byte 115,47,114,98,116,114,101,101,46,99,0,0,47,42,32,84,104,105,115,32,102,105,108,101,32,105,115,32,97,32,116,101"
asm ".byte 109,112,108,97,116,101,46,10,32,42,32,84,111,32,117,115,101,32,116,104,105,115,32,116,101,109,112,108,97,116,101,44"
asm ".byte 32,35,100,101,102,105,110,101,32,115,111,109,101,32,109,97,99,114,111,115,32,97,110,100,32,35,105,110,99,108,117,100"
asm ".byte 101,32,105,116,46,10,32,42,10,32,42,32,77,97,99,114,111,115,58,10,32,42,32,82,66,84,82,69,69,95,84,89"
asm ".byte 80,69,32,45,45,32,82,66,84,82,69,69,32,115,116,114,117,99,116,117,114,101,32,116,121,112,101,10,32,42,32,82"
asm ".byte 66,84,82,69,69,95,67,77,80,40,110,111,100,101,49,44,32,110,111,100,101,50,41,32,45,45,32,102,117,110,99,116"
asm ".byte 105,111,110,32,116,111,32,99,111,109,112,97,114,101,32,116,119,111,32,110,111,100,101,115,44,32,114,101,116,117,114,110"
asm ".byte 115,32,49,32,105,102,32,110,111,100,101,49,32,62,32,110,111,100,101,50,44,32,48,32,105,102,32,110,111,100,101,49"
asm ".byte 32,60,61,32,110,111,100,101,50,10,32,42,32,82,66,84,82,69,69,95,67,79,76,79,82,32,45,45,32,67,79,76"
asm ".byte 79,82,32,102,105,101,108,100,32,111,102,32,82,66,84,82,69,69,32,115,116,114,117,99,116,117,114,101,44,32,97,116"
asm ".byte 32,108,101,97,115,116,32,49,32,98,105,116,10,32,42,32,82,66,84,82,69,69,95,76,69,70,84,32,45,45,32,76"
asm ".byte 69,70,84,95,80,79,73,78,84,69,82,32,102,105,101,108,100,32,111,102,32,82,66,84,82,69,69,32,115,116,114,117"
asm ".byte 99,116,117,114,101,10,32,42,32,82,66,84,82,69,69,95,82,73,71,72,84,32,45,45,32,82,73,71,72,84,95,80"
asm ".byte 79,73,78,84,69,82,32,102,105,101,108,100,32,111,102,32,82,66,84,82,69,69,32,115,116,114,117,99,116,117,114,101"
asm ".byte 10,32,42,32,82,66,84,82,69,69,95,80,65,82,69,78,84,32,45,45,32,80,65,82,69,78,84,95,80,79,73,78"
asm ".byte 84,69,82,32,102,105,101,108,100,32,111,102,32,82,66,84,82,69,69,32,115,116,114,117,99,116,117,114,101,10,32,42"
asm ".byte 32,82,66,84,82,69,69,95,73,78,83,69,82,84,32,45,45,32,110,97,109,101,32,111,102,32,102,117,110,99,116,105"
asm ".byte 111,110,32,116,111,32,105,110,115,101,114,116,32,97,32,110,111,100,101,32,105,110,116,111,32,82,66,84,82,69,69,10"
asm ".byte 32,42,32,82,66,84,82,69,69,95,68,69,76,69,84,69,32,45,45,32,110,97,109,101,32,111,102,32,102,117,110,99"
asm ".byte 116,105,111,110,32,116,111,32,100,101,108,101,116,101,32,97,32,110,111,100,101,32,102,114,111,109,32,82,66,84,82,69"
asm ".byte 69,10,32,42,32,82,66,84,82,69,69,95,70,73,78,68,32,45,45,32,110,97,109,101,32,111,102,32,102,117,110,99"
asm ".byte 116,105,111,110,32,116,111,32,102,105,110,100,32,97,32,110,111,100,101,32,105,110,32,82,66,84,82,69,69,10,32,42"
asm ".byte 32,82,66,84,82,69,69,95,78,69,88,84,32,45,45,32,110,97,109,101,32,111,102,32,102,117,110,99,116,105,111,110"
asm ".byte 32,116,111,32,108,111,99,97,116,101,32,34,110,101,120,116,34,32,110,111,100,101,10,32,42,32,82,66,84,82,69,69"
asm ".byte 95,80,82,69,86,32,45,45,32,110,97,109,101,32,111,102,32,102,117,110,99,116,105,111,110,32,116,111,32,108,111,99"
asm ".byte 97,116,101,32,34,112,114,101,118,105,111,117,115,34,32,110,111,100,101,10,32,42,32,42,47,10,35,100,101,102,105,110"
asm ".byte 101,32,82,66,84,82,69,69,95,82,69,68,32,48,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,66,76"
asm ".byte 65,67,75,32,49,10,35,105,102,100,101,102,32,82,66,84,82,69,69,95,73,78,83,69,82,84,10,118,111,105,100,32"
asm ".byte 82,66,84,82,69,69,95,73,78,83,69,82,84,40,82,66,84,82,69,69,95,84,89,80,69,32,42,42,114,111,111,116"
asm ".byte 44,82,66,84,82,69,69,95,84,89,80,69,32,42,110,111,100,101,41,10,123,10,9,82,66,84,82,69,69,95,84,89"
asm ".byte 80,69,32,42,112,44,42,112,112,44,42,112,97,44,42,112,114,44,42,105,110,115,101,114,116,95,112,111,115,59,10,9"
asm ".byte 105,110,116,32,105,102,95,108,101,102,116,59,10,9,105,102,40,42,114,111,111,116,61,61,48,41,10,9,123,10,9,9"
asm ".byte 42,114,111,111,116,61,110,111,100,101,59,10,9,9,110,111,100,101,45,62,82,66,84,82,69,69,95,67,79,76,79,82"
asm ".byte 61,82,66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,110,111,100,101,45,62,82,66,84,82,69,69,95,76,69"
asm ".byte 70,84,61,48,59,10,9,9,110,111,100,101,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,48,59,10,9,9"
asm ".byte 110,111,100,101,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,48,59,10,9,9,114,101,116,117,114,110,59"
asm ".byte 10,9,125,10,9,112,61,42,114,111,111,116,59,10,9,100,111,10,9,123,10,9,9,105,110,115,101,114,116,95,112,111"
asm ".byte 115,61,112,59,10,9,9,105,102,40,82,66,84,82,69,69,95,67,77,80,40,110,111,100,101,44,105,110,115,101,114,116"
asm ".byte 95,112,111,115,41,41,10,9,9,123,10,9,9,9,112,61,105,110,115,101,114,116,95,112,111,115,45,62,82,66,84,82"
asm ".byte 69,69,95,82,73,71,72,84,59,10,9,9,9,105,102,95,108,101,102,116,61,48,59,10,9,9,125,10,9,9,101,108"
asm ".byte 115,101,10,9,9,123,10,9,9,9,112,61,105,110,115,101,114,116,95,112,111,115,45,62,82,66,84,82,69,69,95,76"
asm ".byte 69,70,84,59,10,9,9,9,105,102,95,108,101,102,116,61,49,59,10,9,9,125,10,9,125,10,9,119,104,105,108,101"
asm ".byte 40,112,41,59,10,9,105,102,40,105,102,95,108,101,102,116,41,10,9,123,10,9,9,105,110,115,101,114,116,95,112,111"
asm ".byte 115,45,62,82,66,84,82,69,69,95,76,69,70,84,61,110,111,100,101,59,10,9,125,10,9,101,108,115,101,10,9,123"
asm ".byte 10,9,9,105,110,115,101,114,116,95,112,111,115,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,110,111,100,101"
asm ".byte 59,10,9,125,10,9,110,111,100,101,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95"
asm ".byte 82,69,68,59,10,9,110,111,100,101,45,62,82,66,84,82,69,69,95,76,69,70,84,61,48,59,10,9,110,111,100,101"
asm ".byte 45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,48,59,10,9,110,111,100,101,45,62,82,66,84,82,69,69,95"
asm ".byte 80,65,82,69,78,84,61,105,110,115,101,114,116,95,112,111,115,59,10,9,112,61,105,110,115,101,114,116,95,112,111,115"
asm ".byte 59,10,9,105,102,40,112,61,61,48,124,124,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84"
asm ".byte 82,69,69,95,66,76,65,67,75,41,10,9,123,10,9,9,114,101,116,117,114,110,59,10,9,125,10,9,112,112,61,105"
asm ".byte 110,115,101,114,116,95,112,111,115,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,119,104,105,108,101"
asm ".byte 40,49,41,10,9,123,10,9,9,105,102,40,112,112,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61,112,41,10"
asm ".byte 9,9,123,10,9,9,9,112,97,61,112,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,9,9,105"
asm ".byte 102,40,112,97,38,38,112,97,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69,95,82"
asm ".byte 69,68,41,10,9,9,9,123,10,9,9,9,9,112,97,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66"
asm ".byte 84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61"
asm ".byte 82,66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,112,112,45,62,82,66,84,82,69,69,95,67,79,76"
asm ".byte 79,82,61,82,66,84,82,69,69,95,82,69,68,59,10,9,9,9,9,110,111,100,101,61,112,112,59,10,9,9,9,9"
asm ".byte 112,61,110,111,100,101,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,9,9,9,105,102,40,112,61"
asm ".byte 61,48,124,124,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69,95,66,76,65,67"
asm ".byte 75,41,10,9,9,9,9,123,10,9,9,9,9,9,98,114,101,97,107,59,10,9,9,9,9,125,10,9,9,9,9,112"
asm ".byte 112,61,112,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,9,9,125,10,9,9,9,101,108,115,101"
asm ".byte 10,9,9,9,123,10,9,9,9,9,105,102,40,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,61,110,111"
asm ".byte 100,101,41,10,9,9,9,9,123,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,82,79,84,65,84,69,95"
asm ".byte 76,69,70,84,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,32"
asm ".byte 112,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,32,112"
asm ".byte 112,10,35,105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116,97,116,101,46,99,34,10,9,9,9"
asm ".byte 9,9,112,61,110,111,100,101,59,10,9,9,9,9,9,110,111,100,101,61,112,45,62,82,66,84,82,69,69,95,76,69"
asm ".byte 70,84,59,10,9,9,9,9,125,10,9,9,9,9,112,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82"
asm ".byte 66,84,82,69,69,95,82,69,68,59,10,9,9,9,9,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82"
asm ".byte 66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,112,114,61,112,112,45,62,82,66,84,82,69,69,95,80"
asm ".byte 65,82,69,78,84,59,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84"
asm ".byte 69,32,112,112,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84"
asm ".byte 69,32,112,114,10,35,105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116,97,116,101,46,99,34,10"
asm ".byte 9,9,9,9,98,114,101,97,107,59,10,9,9,9,125,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9"
asm ".byte 9,9,112,97,61,112,112,45,62,82,66,84,82,69,69,95,76,69,70,84,59,10,9,9,9,105,102,40,112,97,38,38"
asm ".byte 112,97,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69,95,82,69,68,41,10,9,9"
asm ".byte 9,123,10,9,9,9,9,112,97,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66"
asm ".byte 76,65,67,75,59,10,9,9,9,9,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69"
asm ".byte 95,66,76,65,67,75,59,10,9,9,9,9,112,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84"
asm ".byte 82,69,69,95,82,69,68,59,10,9,9,9,9,110,111,100,101,61,112,112,59,10,9,9,9,9,112,61,110,111,100,101"
asm ".byte 45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,9,9,9,105,102,40,112,61,61,48,124,124,112,45"
asm ".byte 62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69,95,66,76,65,67,75,41,10,9,9,9"
asm ".byte 9,123,10,9,9,9,9,9,98,114,101,97,107,59,10,9,9,9,9,125,10,9,9,9,9,112,112,61,112,45,62,82"
asm ".byte 66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,9,9,125,10,9,9,9,101,108,115,101,10,9,9,9,123,10"
asm ".byte 9,9,9,9,105,102,40,112,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61,110,111,100,101,41,10,9,9,9"
asm ".byte 9,123,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,32,112,10"
asm ".byte 35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,32,112,112,10"
asm ".byte 35,105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116,97,116,101,46,99,34,10,9,9,9,9,9"
asm ".byte 112,61,110,111,100,101,59,10,9,9,9,9,9,110,111,100,101,61,112,45,62,82,66,84,82,69,69,95,82,73,71,72"
asm ".byte 84,59,10,9,9,9,9,125,10,9,9,9,9,112,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66"
asm ".byte 84,82,69,69,95,82,69,68,59,10,9,9,9,9,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66"
asm ".byte 84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,112,114,61,112,112,45,62,82,66,84,82,69,69,95,80,65"
asm ".byte 82,69,78,84,59,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,82,79,84,65,84,69,95,76,69,70,84"
asm ".byte 10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,32,112,112,10,35"
asm ".byte 100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,32,112,114,10,35"
asm ".byte 105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116,97,116,101,46,99,34,10,9,9,9,9,98,114"
asm ".byte 101,97,107,59,10,9,9,9,125,10,9,9,125,10,9,125,10,9,40,42,114,111,111,116,41,45,62,82,66,84,82,69"
asm ".byte 69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59,10,125,10,35,117,110,100,101,102,32,82"
asm ".byte 66,84,82,69,69,95,73,78,83,69,82,84,10,35,101,110,100,105,102,10,10,35,105,102,100,101,102,32,82,66,84,82"
asm ".byte 69,69,95,68,69,76,69,84,69,10,82,66,84,82,69,69,95,84,89,80,69,32,42,82,66,84,82,69,69,95,68,69"
asm ".byte 76,69,84,69,40,82,66,84,82,69,69,95,84,89,80,69,32,42,42,114,111,111,116,44,82,66,84,82,69,69,95,84"
asm ".byte 89,80,69,32,42,110,111,100,101,41,10,123,10,9,82,66,84,82,69,69,95,84,89,80,69,32,42,110,44,42,112,44"
asm ".byte 42,112,49,44,42,112,50,44,42,110,49,59,10,9,105,110,116,32,105,102,95,108,101,102,116,44,99,111,108,111,114,59"
asm ".byte 10,9,110,61,42,114,111,111,116,59,10,9,119,104,105,108,101,40,49,41,10,9,123,10,9,9,105,102,40,110,61,61"
asm ".byte 48,41,10,9,9,123,10,9,9,9,114,101,116,117,114,110,32,48,59,10,9,9,125,10,9,9,105,102,40,82,66,84"
asm ".byte 82,69,69,95,67,77,80,40,110,111,100,101,44,110,41,41,10,9,9,123,10,9,9,9,110,61,110,45,62,82,66,84"
asm ".byte 82,69,69,95,82,73,71,72,84,59,10,9,9,125,10,9,9,101,108,115,101,32,105,102,40,82,66,84,82,69,69,95"
asm ".byte 67,77,80,40,110,44,110,111,100,101,41,41,10,9,9,123,10,9,9,9,110,61,110,45,62,82,66,84,82,69,69,95"
asm ".byte 76,69,70,84,59,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9,9,9,98,114,101,97,107,59,10,9"
asm ".byte 9,125,10,9,125,10,9,110,49,61,110,59,10,9,105,102,40,110,45,62,82,66,84,82,69,69,95,76,69,70,84,61"
asm ".byte 61,48,41,10,9,123,10,9,9,105,102,40,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,61,48,41,10"
asm ".byte 9,9,123,10,9,9,9,112,61,110,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,9,9,105,102"
asm ".byte 40,112,41,10,9,9,9,123,10,9,9,9,9,105,102,40,112,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61"
asm ".byte 110,41,10,9,9,9,9,123,10,9,9,9,9,9,112,45,62,82,66,84,82,69,69,95,76,69,70,84,61,48,59,10"
asm ".byte 9,9,9,9,9,105,102,95,108,101,102,116,61,49,59,10,9,9,9,9,125,10,9,9,9,9,101,108,115,101,10,9"
asm ".byte 9,9,9,123,10,9,9,9,9,9,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,48,59,10,9,9,9"
asm ".byte 9,9,105,102,95,108,101,102,116,61,48,59,10,9,9,9,9,125,10,9,9,9,125,10,9,9,9,101,108,115,101,10"
asm ".byte 9,9,9,123,10,9,9,9,9,42,114,111,111,116,61,48,59,10,9,9,9,9,114,101,116,117,114,110,32,110,49,59"
asm ".byte 10,9,9,9,125,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9,9,9,112,61,110,45,62,82,66,84"
asm ".byte 82,69,69,95,80,65,82,69,78,84,59,10,9,9,9,105,102,40,112,41,10,9,9,9,123,10,9,9,9,9,105,102"
asm ".byte 40,112,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61,110,41,10,9,9,9,9,123,10,9,9,9,9,9,112"
asm ".byte 45,62,82,66,84,82,69,69,95,76,69,70,84,61,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9"
asm ".byte 9,9,9,9,105,102,95,108,101,102,116,61,49,59,10,9,9,9,9,125,10,9,9,9,9,101,108,115,101,10,9,9"
asm ".byte 9,9,123,10,9,9,9,9,9,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,110,45,62,82,66,84,82"
asm ".byte 69,69,95,82,73,71,72,84,59,10,9,9,9,9,9,105,102,95,108,101,102,116,61,48,59,10,9,9,9,9,125,10"
asm ".byte 9,9,9,9,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,45,62,82,66,84,82,69,69,95,80,65,82,69"
asm ".byte 78,84,61,112,59,10,9,9,9,125,10,9,9,9,101,108,115,101,10,9,9,9,123,10,9,9,9,9,42,114,111,111"
asm ".byte 116,61,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,9,9,9,110,45,62,82,66,84,82,69,69"
asm ".byte 95,82,73,71,72,84,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,48,59,10,9,9,9,9,40,42,114"
asm ".byte 111,111,116,41,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59"
asm ".byte 10,9,9,9,9,114,101,116,117,114,110,32,110,49,59,10,9,9,9,125,10,9,9,125,10,9,9,99,111,108,111,114"
asm ".byte 61,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,59,10,9,125,10,9,101,108,115,101,32,105,102,40,110,45"
asm ".byte 62,82,66,84,82,69,69,95,82,73,71,72,84,61,61,48,41,10,9,123,10,9,9,112,61,110,45,62,82,66,84,82"
asm ".byte 69,69,95,80,65,82,69,78,84,59,10,9,9,105,102,40,112,41,10,9,9,123,10,9,9,9,105,102,40,112,45,62"
asm ".byte 82,66,84,82,69,69,95,76,69,70,84,61,61,110,41,10,9,9,9,123,10,9,9,9,9,112,45,62,82,66,84,82"
asm ".byte 69,69,95,76,69,70,84,61,110,45,62,82,66,84,82,69,69,95,76,69,70,84,59,10,9,9,9,9,105,102,95,108"
asm ".byte 101,102,116,61,49,59,10,9,9,9,125,10,9,9,9,101,108,115,101,10,9,9,9,123,10,9,9,9,9,112,45,62"
asm ".byte 82,66,84,82,69,69,95,82,73,71,72,84,61,110,45,62,82,66,84,82,69,69,95,76,69,70,84,59,10,9,9,9"
asm ".byte 9,105,102,95,108,101,102,116,61,48,59,10,9,9,9,125,10,9,9,9,110,45,62,82,66,84,82,69,69,95,76,69"
asm ".byte 70,84,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,112,59,10,9,9,125,10,9,9,101,108,115,101,10"
asm ".byte 9,9,123,10,9,9,9,42,114,111,111,116,61,110,45,62,82,66,84,82,69,69,95,76,69,70,84,59,10,9,9,9"
asm ".byte 110,45,62,82,66,84,82,69,69,95,76,69,70,84,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,48,59"
asm ".byte 10,9,9,9,40,42,114,111,111,116,41,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69"
asm ".byte 95,66,76,65,67,75,59,10,9,9,9,114,101,116,117,114,110,32,110,49,59,10,9,9,125,10,9,9,99,111,108,111"
asm ".byte 114,61,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,59,10,9,125,10,9,101,108,115,101,10,9,123,10,9"
asm ".byte 9,112,49,61,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,9,119,104,105,108,101,40,112,49,45"
asm ".byte 62,82,66,84,82,69,69,95,76,69,70,84,41,10,9,9,123,10,9,9,9,112,49,61,112,49,45,62,82,66,84,82"
asm ".byte 69,69,95,76,69,70,84,59,10,9,9,125,10,9,9,105,102,40,112,49,61,61,110,45,62,82,66,84,82,69,69,95"
asm ".byte 82,73,71,72,84,41,10,9,9,123,10,9,9,9,112,61,110,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84"
asm ".byte 59,10,9,9,9,105,102,40,112,41,10,9,9,9,123,10,9,9,9,9,105,102,40,112,45,62,82,66,84,82,69,69"
asm ".byte 95,76,69,70,84,61,61,110,41,10,9,9,9,9,123,10,9,9,9,9,9,112,45,62,82,66,84,82,69,69,95,76"
asm ".byte 69,70,84,61,112,49,59,10,9,9,9,9,125,10,9,9,9,9,101,108,115,101,10,9,9,9,9,123,10,9,9,9"
asm ".byte 9,9,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,112,49,59,10,9,9,9,9,125,10,9,9,9,125"
asm ".byte 10,9,9,9,101,108,115,101,10,9,9,9,123,10,9,9,9,9,42,114,111,111,116,61,112,49,59,10,9,9,9,125"
asm ".byte 10,9,9,9,112,49,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,112,59,10,9,9,9,112,49,45,62"
asm ".byte 82,66,84,82,69,69,95,76,69,70,84,61,110,45,62,82,66,84,82,69,69,95,76,69,70,84,59,10,9,9,9,110"
asm ".byte 45,62,82,66,84,82,69,69,95,76,69,70,84,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,112,49,59"
asm ".byte 10,9,9,9,99,111,108,111,114,61,112,49,45,62,82,66,84,82,69,69,95,67,79,76,79,82,59,10,9,9,9,112"
asm ".byte 49,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,59"
asm ".byte 10,9,9,9,112,61,112,49,59,10,9,9,9,105,102,95,108,101,102,116,61,48,59,10,9,9,125,10,9,9,101,108"
asm ".byte 115,101,10,9,9,123,10,9,9,9,112,61,112,49,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9"
asm ".byte 9,9,105,102,40,112,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61,112,49,41,10,9,9,9,123,10,9,9"
asm ".byte 9,9,112,45,62,82,66,84,82,69,69,95,76,69,70,84,61,112,49,45,62,82,66,84,82,69,69,95,82,73,71,72"
asm ".byte 84,59,10,9,9,9,125,10,9,9,9,101,108,115,101,10,9,9,9,123,10,9,9,9,9,112,45,62,82,66,84,82"
asm ".byte 69,69,95,82,73,71,72,84,61,112,49,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,9,9,125,10"
asm ".byte 9,9,9,105,102,40,112,49,45,62,82,66,84,82,69,69,95,82,73,71,72,84,41,10,9,9,9,123,10,9,9,9"
asm ".byte 9,112,49,45,62,82,66,84,82,69,69,95,82,73,71,72,84,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84"
asm ".byte 61,112,59,10,9,9,9,125,10,9,9,9,112,49,45,62,82,66,84,82,69,69,95,76,69,70,84,61,110,45,62,82"
asm ".byte 66,84,82,69,69,95,76,69,70,84,59,10,9,9,9,112,49,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61"
asm ".byte 110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,9,9,112,49,45,62,82,66,84,82,69,69,95,80"
asm ".byte 65,82,69,78,84,61,110,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,9,9,99,111,108,111,114"
asm ".byte 61,112,49,45,62,82,66,84,82,69,69,95,67,79,76,79,82,59,10,9,9,9,112,49,45,62,82,66,84,82,69,69"
asm ".byte 95,67,79,76,79,82,61,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,59,10,9,9,9,112,50,61,110,45"
asm ".byte 62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,9,9,105,102,40,112,50,41,10,9,9,9,123,10,9"
asm ".byte 9,9,9,105,102,40,112,50,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61,110,41,10,9,9,9,9,123,10"
asm ".byte 9,9,9,9,9,112,50,45,62,82,66,84,82,69,69,95,76,69,70,84,61,112,49,59,10,9,9,9,9,125,10,9"
asm ".byte 9,9,9,101,108,115,101,10,9,9,9,9,123,10,9,9,9,9,9,112,50,45,62,82,66,84,82,69,69,95,82,73"
asm ".byte 71,72,84,61,112,49,59,10,9,9,9,9,125,10,9,9,9,125,10,9,9,9,101,108,115,101,10,9,9,9,123,10"
asm ".byte 9,9,9,9,42,114,111,111,116,61,112,49,59,10,9,9,9,125,10,9,9,9,105,102,40,110,45,62,82,66,84,82"
asm ".byte 69,69,95,76,69,70,84,41,10,9,9,9,123,10,9,9,9,9,110,45,62,82,66,84,82,69,69,95,76,69,70,84"
asm ".byte 45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,112,49,59,10,9,9,9,125,10,9,9,9,105,102,40,110"
asm ".byte 45,62,82,66,84,82,69,69,95,82,73,71,72,84,41,10,9,9,9,123,10,9,9,9,9,110,45,62,82,66,84,82"
asm ".byte 69,69,95,82,73,71,72,84,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,112,49,59,10,9,9,9,125"
asm ".byte 10,9,9,9,105,102,95,108,101,102,116,61,49,59,10,9,9,125,10,9,125,10,9,105,102,40,99,111,108,111,114,61"
asm ".byte 61,82,66,84,82,69,69,95,82,69,68,41,10,9,123,10,9,9,114,101,116,117,114,110,32,110,49,59,10,9,125,10"
asm ".byte 9,110,61,112,59,10,9,119,104,105,108,101,40,49,41,10,9,123,10,9,9,105,102,40,105,102,95,108,101,102,116,41"
asm ".byte 10,9,9,123,10,9,9,9,105,102,40,110,45,62,82,66,84,82,69,69,95,76,69,70,84,38,38,110,45,62,82,66"
asm ".byte 84,82,69,69,95,76,69,70,84,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69,95"
asm ".byte 82,69,68,41,10,9,9,9,123,10,9,9,9,9,110,45,62,82,66,84,82,69,69,95,76,69,70,84,45,62,82,66"
asm ".byte 84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,98,114,101"
asm ".byte 97,107,59,10,9,9,9,125,10,9,9,9,112,61,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9"
asm ".byte 9,125,10,9,9,101,108,115,101,10,9,9,123,10,9,9,9,105,102,40,110,45,62,82,66,84,82,69,69,95,82,73"
asm ".byte 71,72,84,38,38,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,45,62,82,66,84,82,69,69,95,67,79,76"
asm ".byte 79,82,61,61,82,66,84,82,69,69,95,82,69,68,41,10,9,9,9,123,10,9,9,9,9,110,45,62,82,66,84,82"
asm ".byte 69,69,95,82,73,71,72,84,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66,76"
asm ".byte 65,67,75,59,10,9,9,9,9,98,114,101,97,107,59,10,9,9,9,125,10,9,9,9,112,61,110,45,62,82,66,84"
asm ".byte 82,69,69,95,76,69,70,84,59,10,9,9,125,10,9,9,105,102,40,105,102,95,108,101,102,116,41,10,9,9,123,10"
asm ".byte 9,9,9,105,102,40,112,38,38,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69"
asm ".byte 95,82,69,68,41,10,9,9,9,123,10,9,9,9,9,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82"
asm ".byte 66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82"
asm ".byte 61,82,66,84,82,69,69,95,82,69,68,59,10,9,9,9,9,112,49,61,110,45,62,82,66,84,82,69,69,95,80,65"
asm ".byte 82,69,78,84,59,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,82,79,84,65,84,69,95,76,69,70,84"
asm ".byte 10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,32,110,10,35,100"
asm ".byte 101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,32,112,49,10,35,105"
asm ".byte 110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116,97,116,101,46,99,34,10,9,9,9,125,10,9,9"
asm ".byte 9,101,108,115,101,10,9,9,9,123,10,9,9,9,9,105,102,40,112,38,38,112,45,62,82,66,84,82,69,69,95,82"
asm ".byte 73,71,72,84,38,38,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,45,62,82,66,84,82,69,69,95,67,79"
asm ".byte 76,79,82,61,61,82,66,84,82,69,69,95,82,69,68,41,10,9,9,9,9,123,10,9,9,9,9,9,112,45,62,82"
asm ".byte 66,84,82,69,69,95,67,79,76,79,82,61,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,59,10,9,9,9"
asm ".byte 9,9,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59,10"
asm ".byte 9,9,9,9,9,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,45,62,82,66,84,82,69,69,95,67,79,76"
asm ".byte 79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,9,112,49,61,110,45,62,82,66,84,82"
asm ".byte 69,69,95,80,65,82,69,78,84,59,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,82,79,84,65,84,69"
asm ".byte 95,76,69,70,84,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69"
asm ".byte 32,110,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,32"
asm ".byte 112,49,10,35,105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116,97,116,101,46,99,34,10,9,9"
asm ".byte 9,9,9,98,114,101,97,107,59,10,9,9,9,9,125,10,9,9,9,9,101,108,115,101,32,105,102,40,112,38,38,112"
asm ".byte 45,62,82,66,84,82,69,69,95,76,69,70,84,38,38,112,45,62,82,66,84,82,69,69,95,76,69,70,84,45,62,82"
asm ".byte 66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69,95,82,69,68,41,10,9,9,9,9,123,10,9"
asm ".byte 9,9,9,9,112,45,62,82,66,84,82,69,69,95,76,69,70,84,45,62,82,66,84,82,69,69,95,67,79,76,79,82"
asm ".byte 61,82,66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,9,112,45,62,82,66,84,82,69,69,95,67,79"
asm ".byte 76,79,82,61,82,66,84,82,69,69,95,82,69,68,59,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78"
asm ".byte 79,68,69,95,82,79,84,65,84,69,32,112,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69"
asm ".byte 78,84,95,82,79,84,65,84,69,32,110,10,35,105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116"
asm ".byte 97,116,101,46,99,34,10,9,9,9,9,125,10,9,9,9,9,101,108,115,101,10,9,9,9,9,123,10,9,9,9,9"
asm ".byte 9,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,82,69,68,59,10,9,9,9"
asm ".byte 9,9,112,61,110,59,10,9,9,9,9,9,110,61,110,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10"
asm ".byte 9,9,9,9,9,105,102,40,110,61,61,48,41,10,9,9,9,9,9,123,10,9,9,9,9,9,9,98,114,101,97,107"
asm ".byte 59,10,9,9,9,9,9,125,10,9,9,9,9,9,105,102,40,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84"
asm ".byte 61,61,112,41,10,9,9,9,9,9,123,10,9,9,9,9,9,9,105,102,95,108,101,102,116,61,48,59,10,9,9,9"
asm ".byte 9,9,125,10,9,9,9,9,125,10,9,9,9,125,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9,9"
asm ".byte 9,105,102,40,112,38,38,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69,95,82"
asm ".byte 69,68,41,10,9,9,9,123,10,9,9,9,9,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84"
asm ".byte 82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82"
asm ".byte 66,84,82,69,69,95,82,69,68,59,10,9,9,9,9,112,49,61,110,45,62,82,66,84,82,69,69,95,80,65,82,69"
asm ".byte 78,84,59,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,32,110"
asm ".byte 10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,32,112,49"
asm ".byte 10,35,105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116,97,116,101,46,99,34,10,9,9,9,125"
asm ".byte 10,9,9,9,101,108,115,101,10,9,9,9,123,10,9,9,9,9,105,102,40,112,38,38,112,45,62,82,66,84,82,69"
asm ".byte 69,95,76,69,70,84,38,38,112,45,62,82,66,84,82,69,69,95,76,69,70,84,45,62,82,66,84,82,69,69,95,67"
asm ".byte 79,76,79,82,61,61,82,66,84,82,69,69,95,82,69,68,41,10,9,9,9,9,123,10,9,9,9,9,9,112,45,62"
asm ".byte 82,66,84,82,69,69,95,67,79,76,79,82,61,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,59,10,9,9"
asm ".byte 9,9,9,110,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59"
asm ".byte 10,9,9,9,9,9,112,45,62,82,66,84,82,69,69,95,76,69,70,84,45,62,82,66,84,82,69,69,95,67,79,76"
asm ".byte 79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,9,112,49,61,110,45,62,82,66,84,82"
asm ".byte 69,69,95,80,65,82,69,78,84,59,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,78,79,68,69,95,82"
asm ".byte 79,84,65,84,69,32,110,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79"
asm ".byte 84,65,84,69,32,112,49,10,35,105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95,114,111,116,97,116,101,46"
asm ".byte 99,34,10,9,9,9,9,9,98,114,101,97,107,59,10,9,9,9,9,125,10,9,9,9,9,101,108,115,101,32,105,102"
asm ".byte 40,112,38,38,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,38,38,112,45,62,82,66,84,82,69,69,95,82"
asm ".byte 73,71,72,84,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,61,82,66,84,82,69,69,95,82,69,68,41,10"
asm ".byte 9,9,9,9,123,10,9,9,9,9,9,112,45,62,82,66,84,82,69,69,95,82,73,71,72,84,45,62,82,66,84,82"
asm ".byte 69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59,10,9,9,9,9,9,112,45,62,82"
asm ".byte 66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,82,69,68,59,10,35,100,101,102,105,110,101,32"
asm ".byte 82,66,84,82,69,69,95,82,79,84,65,84,69,95,76,69,70,84,10,35,100,101,102,105,110,101,32,82,66,84,82,69"
asm ".byte 69,95,78,79,68,69,95,82,79,84,65,84,69,32,112,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80"
asm ".byte 65,82,69,78,84,95,82,79,84,65,84,69,32,110,10,35,105,110,99,108,117,100,101,32,34,114,98,116,114,101,101,95"
asm ".byte 114,111,116,97,116,101,46,99,34,10,9,9,9,9,125,10,9,9,9,9,101,108,115,101,10,9,9,9,9,123,10,9"
asm ".byte 9,9,9,9,112,45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,82,69,68,59,10"
asm ".byte 9,9,9,9,9,112,61,110,59,10,9,9,9,9,9,110,61,110,45,62,82,66,84,82,69,69,95,80,65,82,69,78"
asm ".byte 84,59,10,9,9,9,9,9,105,102,40,110,61,61,48,41,10,9,9,9,9,9,123,10,9,9,9,9,9,9,98,114"
asm ".byte 101,97,107,59,10,9,9,9,9,9,125,10,9,9,9,9,9,105,102,40,110,45,62,82,66,84,82,69,69,95,76,69"
asm ".byte 70,84,61,61,112,41,10,9,9,9,9,9,123,10,9,9,9,9,9,9,105,102,95,108,101,102,116,61,49,59,10,9"
asm ".byte 9,9,9,9,125,10,9,9,9,9,125,10,9,9,9,125,10,9,9,125,10,9,125,10,9,40,42,114,111,111,116,41"
asm ".byte 45,62,82,66,84,82,69,69,95,67,79,76,79,82,61,82,66,84,82,69,69,95,66,76,65,67,75,59,10,9,114,101"
asm ".byte 116,117,114,110,32,110,49,59,10,125,10,35,117,110,100,101,102,32,82,66,84,82,69,69,95,68,69,76,69,84,69,10"
asm ".byte 35,101,110,100,105,102,10,10,35,105,102,100,101,102,32,82,66,84,82,69,69,95,70,73,78,68,10,82,66,84,82,69"
asm ".byte 69,95,84,89,80,69,32,42,82,66,84,82,69,69,95,70,73,78,68,40,82,66,84,82,69,69,95,84,89,80,69,32"
asm ".byte 42,114,111,111,116,44,82,66,84,82,69,69,95,84,89,80,69,32,42,110,111,100,101,41,10,123,10,9,82,66,84,82"
asm ".byte 69,69,95,84,89,80,69,32,42,110,59,10,9,110,61,114,111,111,116,59,10,9,119,104,105,108,101,40,49,41,10,9"
asm ".byte 123,10,9,9,105,102,40,110,61,61,48,41,10,9,9,123,10,9,9,9,114,101,116,117,114,110,32,48,59,10,9,9"
asm ".byte 125,10,9,9,105,102,40,82,66,84,82,69,69,95,67,77,80,40,110,111,100,101,44,110,41,41,10,9,9,123,10,9"
asm ".byte 9,9,110,61,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,9,125,10,9,9,101,108,115,101,32"
asm ".byte 105,102,40,82,66,84,82,69,69,95,67,77,80,40,110,44,110,111,100,101,41,41,10,9,9,123,10,9,9,9,110,61"
asm ".byte 110,45,62,82,66,84,82,69,69,95,76,69,70,84,59,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9"
asm ".byte 9,9,114,101,116,117,114,110,32,110,59,10,9,9,125,10,9,125,10,125,10,35,117,110,100,101,102,32,82,66,84,82"
asm ".byte 69,69,95,70,73,78,68,10,35,101,110,100,105,102,10,10,35,105,102,100,101,102,32,82,66,84,82,69,69,95,78,69"
asm ".byte 88,84,10,82,66,84,82,69,69,95,84,89,80,69,32,42,82,66,84,82,69,69,95,78,69,88,84,40,82,66,84,82"
asm ".byte 69,69,95,84,89,80,69,32,42,110,111,100,101,41,10,123,10,9,82,66,84,82,69,69,95,84,89,80,69,32,42,110"
asm ".byte 59,10,9,105,102,40,110,111,100,101,45,62,82,66,84,82,69,69,95,82,73,71,72,84,41,10,9,123,10,9,9,110"
asm ".byte 61,110,111,100,101,45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,9,119,104,105,108,101,40,110,45,62"
asm ".byte 82,66,84,82,69,69,95,76,69,70,84,41,10,9,9,123,10,9,9,9,110,61,110,45,62,82,66,84,82,69,69,95"
asm ".byte 76,69,70,84,59,10,9,9,125,10,9,9,114,101,116,117,114,110,32,110,59,10,9,125,10,9,101,108,115,101,10,9"
asm ".byte 123,10,9,9,110,61,110,111,100,101,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,59,10,9,9,119,104,105"
asm ".byte 108,101,40,110,38,38,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,61,110,111,100,101,41,10,9,9,123"
asm ".byte 10,9,9,9,110,111,100,101,61,110,59,10,9,9,9,110,61,110,45,62,82,66,84,82,69,69,95,80,65,82,69,78"
asm ".byte 84,59,10,9,9,125,10,9,9,105,102,40,33,110,41,10,9,9,123,10,9,9,9,114,101,116,117,114,110,32,40,118"
asm ".byte 111,105,100,32,42,41,48,59,10,9,9,125,10,9,9,114,101,116,117,114,110,32,110,59,10,9,125,10,125,10,35,117"
asm ".byte 110,100,101,102,32,82,66,84,82,69,69,95,78,69,88,84,10,35,101,110,100,105,102,10,10,35,105,102,100,101,102,32"
asm ".byte 82,66,84,82,69,69,95,80,82,69,86,10,82,66,84,82,69,69,95,84,89,80,69,32,42,82,66,84,82,69,69,95"
asm ".byte 80,82,69,86,40,82,66,84,82,69,69,95,84,89,80,69,32,42,110,111,100,101,41,10,123,10,9,82,66,84,82,69"
asm ".byte 69,95,84,89,80,69,32,42,110,59,10,9,105,102,40,110,111,100,101,45,62,82,66,84,82,69,69,95,76,69,70,84"
asm ".byte 41,10,9,123,10,9,9,110,61,110,111,100,101,45,62,82,66,84,82,69,69,95,76,69,70,84,59,10,9,9,119,104"
asm ".byte 105,108,101,40,110,45,62,82,66,84,82,69,69,95,82,73,71,72,84,41,10,9,9,123,10,9,9,9,110,61,110,45"
asm ".byte 62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,9,125,10,9,9,114,101,116,117,114,110,32,110,59,10,9"
asm ".byte 125,10,9,101,108,115,101,10,9,123,10,9,9,110,61,110,111,100,101,45,62,82,66,84,82,69,69,95,80,65,82,69"
asm ".byte 78,84,59,10,9,9,119,104,105,108,101,40,110,38,38,110,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61,110"
asm ".byte 111,100,101,41,10,9,9,123,10,9,9,9,110,111,100,101,61,110,59,10,9,9,9,110,61,110,45,62,82,66,84,82"
asm ".byte 69,69,95,80,65,82,69,78,84,59,10,9,9,125,10,9,9,105,102,40,33,110,41,10,9,9,123,10,9,9,9,114"
asm ".byte 101,116,117,114,110,32,40,118,111,105,100,32,42,41,48,59,10,9,9,125,10,9,9,114,101,116,117,114,110,32,110,59"
asm ".byte 10,9,125,10,125,10,35,117,110,100,101,102,32,82,66,84,82,69,69,95,80,82,69,86,10,35,101,110,100,105,102,10"
asm ".byte 10,35,117,110,100,101,102,32,82,66,84,82,69,69,95,84,89,80,69,10,35,117,110,100,101,102,32,82,66,84,82,69"
asm ".byte 69,95,67,77,80,10,35,117,110,100,101,102,32,82,66,84,82,69,69,95,67,79,76,79,82,10,35,117,110,100,101,102"
asm ".byte 32,82,66,84,82,69,69,95,76,69,70,84,10,35,117,110,100,101,102,32,82,66,84,82,69,69,95,82,73,71,72,84"
asm ".byte 10,35,117,110,100,101,102,32,82,66,84,82,69,69,95,80,65,82,69,78,84,10,35,117,110,100,101,102,32,82,66,84"
asm ".byte 82,69,69,95,82,69,68,10,35,117,110,100,101,102,32,82,66,84,82,69,69,95,66,76,65,67,75,10,48,55,48,55"
asm ".byte 48,49,48,48,48,48,48,48,48,65,48,48,48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,54,54,65,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 49,69,48,48,48,48,48,48,48,48,46,47,116,101,109,112,108,97,116,101,115,47,114,98,116,114,101,101,95,114,111,116"
asm ".byte 97,116,101,46,99,0,0,0,47,42,32,68,79,32,78,79,84,32,73,78,67,76,85,68,69,32,84,72,73,83,32,70"
asm ".byte 73,76,69,32,68,73,82,69,67,84,76,89,10,32,42,32,84,104,105,115,32,102,105,108,101,32,105,115,32,97,32,116"
asm ".byte 101,109,112,108,97,116,101,46,10,32,42,32,84,111,32,117,115,101,32,116,104,105,115,32,116,101,109,112,108,97,116,101"
asm ".byte 44,32,35,100,101,102,105,110,101,32,115,111,109,101,32,109,97,99,114,111,115,32,97,110,100,32,35,105,110,99,108,117"
asm ".byte 100,101,32,105,116,46,10,32,42,10,32,42,32,77,97,99,114,111,115,58,10,32,42,32,82,66,84,82,69,69,32,82"
asm ".byte 79,84,65,84,69,95,76,69,70,84,58,32,114,111,116,97,116,101,32,108,101,102,116,32,105,102,32,100,101,102,105,110"
asm ".byte 101,100,10,32,42,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,58,32,110,111,100,101,32,116"
asm ".byte 111,32,114,111,116,97,116,101,10,32,42,32,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69"
asm ".byte 58,32,112,97,114,101,110,116,32,111,102,32,110,111,100,101,32,116,111,32,114,111,116,97,116,101,44,32,111,114,32,78"
asm ".byte 85,76,76,32,105,102,32,114,111,111,116,32,110,111,100,101,32,105,115,32,116,111,32,114,111,116,97,116,101,46,10,32"
asm ".byte 42,32,42,47,10,123,10,35,105,102,100,101,102,32,82,66,84,82,69,69,95,82,79,84,65,84,69,95,76,69,70,84"
asm ".byte 10,9,82,66,84,82,69,69,95,84,89,80,69,32,42,114,111,116,97,116,101,95,114,44,42,114,111,116,97,116,101,95"
asm ".byte 114,108,59,10,9,114,111,116,97,116,101,95,114,61,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69"
asm ".byte 45,62,82,66,84,82,69,69,95,82,73,71,72,84,59,10,9,114,111,116,97,116,101,95,114,108,61,114,111,116,97,116"
asm ".byte 101,95,114,45,62,82,66,84,82,69,69,95,76,69,70,84,59,10,9,105,102,40,82,66,84,82,69,69,95,80,65,82"
asm ".byte 69,78,84,95,82,79,84,65,84,69,41,10,9,123,10,9,9,105,102,40,82,66,84,82,69,69,95,80,65,82,69,78"
asm ".byte 84,95,82,79,84,65,84,69,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61,82,66,84,82,69,69,95,78,79"
asm ".byte 68,69,95,82,79,84,65,84,69,41,10,9,9,123,10,9,9,9,82,66,84,82,69,69,95,80,65,82,69,78,84,95"
asm ".byte 82,79,84,65,84,69,45,62,82,66,84,82,69,69,95,76,69,70,84,61,114,111,116,97,116,101,95,114,59,10,9,9"
asm ".byte 125,10,9,9,101,108,115,101,10,9,9,123,10,9,9,9,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79"
asm ".byte 84,65,84,69,45,62,82,66,84,82,69,69,95,82,73,71,72,84,61,114,111,116,97,116,101,95,114,59,10,9,9,125"
asm ".byte 10,9,125,10,9,101,108,115,101,10,9,123,10,9,9,42,114,111,111,116,61,114,111,116,97,116,101,95,114,59,10,9"
asm ".byte 125,10,9,114,111,116,97,116,101,95,114,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,82,66,84,82,69"
asm ".byte 69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,59,10,9,114,111,116,97,116,101,95,114,45,62,82,66,84,82"
asm ".byte 69,69,95,76,69,70,84,61,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,59,10,9,82,66,84"
asm ".byte 82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,114"
asm ".byte 111,116,97,116,101,95,114,59,10,9,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,45,62,82,66"
asm ".byte 84,82,69,69,95,82,73,71,72,84,61,114,111,116,97,116,101,95,114,108,59,10,9,105,102,40,114,111,116,97,116,101"
asm ".byte 95,114,108,41,10,9,123,10,9,9,114,111,116,97,116,101,95,114,108,45,62,82,66,84,82,69,69,95,80,65,82,69"
asm ".byte 78,84,61,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,59,10,9,125,10,35,117,110,100,101,102"
asm ".byte 32,82,66,84,82,69,69,95,82,79,84,65,84,69,95,76,69,70,84,10,35,101,108,115,101,10,9,82,66,84,82,69"
asm ".byte 69,95,84,89,80,69,32,42,114,111,116,97,116,101,95,108,44,42,114,111,116,97,116,101,95,108,114,59,10,9,114,111"
asm ".byte 116,97,116,101,95,108,61,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,45,62,82,66,84,82,69"
asm ".byte 69,95,76,69,70,84,59,10,9,114,111,116,97,116,101,95,108,114,61,114,111,116,97,116,101,95,108,45,62,82,66,84"
asm ".byte 82,69,69,95,82,73,71,72,84,59,10,9,105,102,40,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84"
asm ".byte 65,84,69,41,10,9,123,10,9,9,105,102,40,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84"
asm ".byte 69,45,62,82,66,84,82,69,69,95,76,69,70,84,61,61,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65"
asm ".byte 84,69,41,10,9,9,123,10,9,9,9,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,45"
asm ".byte 62,82,66,84,82,69,69,95,76,69,70,84,61,114,111,116,97,116,101,95,108,59,10,9,9,125,10,9,9,101,108,115"
asm ".byte 101,10,9,9,123,10,9,9,9,82,66,84,82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,45,62,82"
asm ".byte 66,84,82,69,69,95,82,73,71,72,84,61,114,111,116,97,116,101,95,108,59,10,9,9,125,10,9,125,10,9,101,108"
asm ".byte 115,101,10,9,123,10,9,9,42,114,111,111,116,61,114,111,116,97,116,101,95,108,59,10,9,125,10,9,114,111,116,97"
asm ".byte 116,101,95,108,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,82,66,84,82,69,69,95,80,65,82,69,78"
asm ".byte 84,95,82,79,84,65,84,69,59,10,9,114,111,116,97,116,101,95,108,45,62,82,66,84,82,69,69,95,82,73,71,72"
asm ".byte 84,61,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,59,10,9,82,66,84,82,69,69,95,78,79"
asm ".byte 68,69,95,82,79,84,65,84,69,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,114,111,116,97,116,101,95"
asm ".byte 108,59,10,9,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,45,62,82,66,84,82,69,69,95,76"
asm ".byte 69,70,84,61,114,111,116,97,116,101,95,108,114,59,10,9,105,102,40,114,111,116,97,116,101,95,108,114,41,10,9,123"
asm ".byte 10,9,9,114,111,116,97,116,101,95,108,114,45,62,82,66,84,82,69,69,95,80,65,82,69,78,84,61,82,66,84,82"
asm ".byte 69,69,95,78,79,68,69,95,82,79,84,65,84,69,59,10,9,125,10,35,101,110,100,105,102,10,125,10,35,117,110,100"
asm ".byte 101,102,32,82,66,84,82,69,69,95,78,79,68,69,95,82,79,84,65,84,69,10,35,117,110,100,101,102,32,82,66,84"
asm ".byte 82,69,69,95,80,65,82,69,78,84,95,82,79,84,65,84,69,10,0,0,48,55,48,55,48,49,48,48,48,48,48,48"
asm ".byte 48,66,48,48,48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,49,48,48,48,48,48,48,48,48,48,48,48,48,50,52,68,51,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,65,48,48,48,48,48,48"
asm ".byte 48,48,46,47,109,101,109,46,99,0,0,0,35,105,102,110,100,101,102,32,95,77,69,77,95,67,95,10,35,100,101,102"
asm ".byte 105,110,101,32,95,77,69,77,95,67,95,10,97,115,109,32,34,64,95,109,101,109,109,111,118,101,95,115,116,97,114,116"
asm ".byte 34,10,118,111,105,100,32,42,109,101,109,99,112,121,40,118,111,105,100,32,42,100,115,116,44,118,111,105,100,32,42,115"
asm ".byte 114,99,44,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,115,105,122,101,41,10,123,10,9,97,115"
asm ".byte 109,32,34,112,117,115,104,32,37,114,99,120,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,100,120,34,10,9"
asm ".byte 97,115,109,32,34,112,117,115,104,32,37,114,98,120,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,115,105,34"
asm ".byte 10,9,97,115,109,32,34,112,117,115,104,32,37,114,100,105,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,56"
asm ".byte 34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,57,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,49"
asm ".byte 48,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,49,49,34,10,9,97,115,109,32,34,112,117,115,104,32,37"
asm ".byte 114,49,50,34,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114,98,112,41,44,37,114,97,120,34,10,9,97"
asm ".byte 115,109,32,34,109,111,118,32,50,52,40,37,114,98,112,41,44,37,114,100,120,34,10,9,97,115,109,32,34,109,111,118"
asm ".byte 32,51,50,40,37,114,98,112,41,44,37,114,99,120,34,10,9,97,115,109,32,34,99,109,112,32,36,56,44,37,114,99"
asm ".byte 120,34,10,9,97,115,109,32,34,106,98,32,64,95,109,101,109,99,112,121,95,88,51,51,34,10,9,97,115,109,32,34"
asm ".byte 116,101,115,116,32,36,49,44,37,100,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,88"
asm ".byte 49,49,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,98,108,34,10,9,97,115,109,32,34"
asm ".byte 109,111,118,32,37,98,108,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,105,110,99,32,37,114,97,120,34,10"
asm ".byte 9,97,115,109,32,34,105,110,99,32,37,114,100,120,34,10,9,97,115,109,32,34,100,101,99,32,37,114,99,120,34,10"
asm ".byte 9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,88,49,49,34,10,9,97,115,109,32,34,116,101,115,116,32,36"
asm ".byte 50,44,37,100,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,88,49,50,34,10,9,97"
asm ".byte 115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,98,120,34,10,9,97,115,109,32,34,109,111,118,32,37,98"
asm ".byte 120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,50,44,37,114,97,120,34,10,9,97,115"
asm ".byte 109,32,34,97,100,100,32,36,50,44,37,114,100,120,34,10,9,97,115,109,32,34,115,117,98,32,36,50,44,37,114,99"
asm ".byte 120,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,88,49,50,34,10,9,97,115,109,32,34,116,101,115"
asm ".byte 116,32,36,52,44,37,100,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,88,49,51,34"
asm ".byte 10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,101,98,120,34,10,9,97,115,109,32,34,109,111"
asm ".byte 118,32,37,101,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,52,44,37,114,97,120"
asm ".byte 34,10,9,97,115,109,32,34,97,100,100,32,36,52,44,37,114,100,120,34,10,9,97,115,109,32,34,115,117,98,32,36"
asm ".byte 52,44,37,114,99,120,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,88,49,51,34,10,9,97,115,109"
asm ".byte 32,34,115,117,98,32,36,54,52,44,37,114,99,120,34,10,9,97,115,109,32,34,106,98,32,64,95,109,101,109,99,112"
asm ".byte 121,95,88,50,49,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,88,50,50,34,10,9,97,115,109,32"
asm ".byte 34,109,111,118,32,40,37,114,100,120,41,44,37,114,98,120,34,10,9,97,115,109,32,34,109,111,118,32,56,40,37,114"
asm ".byte 100,120,41,44,37,114,115,105,34,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114,100,120,41,44,37,114,100"
asm ".byte 105,34,10,9,97,115,109,32,34,109,111,118,32,50,52,40,37,114,100,120,41,44,37,114,56,34,10,9,97,115,109,32"
asm ".byte 34,109,111,118,32,51,50,40,37,114,100,120,41,44,37,114,57,34,10,9,97,115,109,32,34,109,111,118,32,52,48,40"
asm ".byte 37,114,100,120,41,44,37,114,49,48,34,10,9,97,115,109,32,34,109,111,118,32,52,56,40,37,114,100,120,41,44,37"
asm ".byte 114,49,49,34,10,9,97,115,109,32,34,109,111,118,32,53,54,40,37,114,100,120,41,44,37,114,49,50,34,10,9,97"
asm ".byte 115,109,32,34,109,111,118,32,37,114,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37"
asm ".byte 114,115,105,44,56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,105,44,49,54,40,37"
asm ".byte 114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,56,44,50,52,40,37,114,97,120,41,34,10,9,97"
asm ".byte 115,109,32,34,109,111,118,32,37,114,57,44,51,50,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32"
asm ".byte 37,114,49,48,44,52,48,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,49,49,44,52,56"
asm ".byte 40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,49,50,44,53,54,40,37,114,97,120,41,34"
asm ".byte 10,9,97,115,109,32,34,97,100,100,32,36,54,52,44,37,114,97,120,34,10,9,97,115,109,32,34,97,100,100,32,36"
asm ".byte 54,52,44,37,114,100,120,34,10,9,97,115,109,32,34,115,117,98,32,36,54,52,44,37,114,99,120,34,10,9,97,115"
asm ".byte 109,32,34,106,97,101,32,64,95,109,101,109,99,112,121,95,88,50,50,34,10,9,97,115,109,32,34,64,95,109,101,109"
asm ".byte 99,112,121,95,88,50,49,34,10,9,97,115,109,32,34,116,101,115,116,32,36,51,50,44,37,99,108,34,10,9,97,115"
asm ".byte 109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,88,51,49,34,10,9,97,115,109,32,34,109,111,118,32,40,37"
asm ".byte 114,100,120,41,44,37,114,98,120,34,10,9,97,115,109,32,34,109,111,118,32,56,40,37,114,100,120,41,44,37,114,115"
asm ".byte 105,34,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114,100,120,41,44,37,114,100,105,34,10,9,97,115,109"
asm ".byte 32,34,109,111,118,32,50,52,40,37,114,100,120,41,44,37,114,56,34,10,9,97,115,109,32,34,109,111,118,32,37,114"
asm ".byte 98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,115,105,44,56,40,37,114,97,120"
asm ".byte 41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,105,44,49,54,40,37,114,97,120,41,34,10,9,97,115,109"
asm ".byte 32,34,109,111,118,32,37,114,56,44,50,52,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,51"
asm ".byte 50,44,37,114,97,120,34,10,9,97,115,109,32,34,97,100,100,32,36,51,50,44,37,114,100,120,34,10,9,97,115,109"
asm ".byte 32,34,64,95,109,101,109,99,112,121,95,88,51,49,34,10,9,97,115,109,32,34,116,101,115,116,32,36,49,54,44,37"
asm ".byte 99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,88,51,50,34,10,9,97,115,109,32"
asm ".byte 34,109,111,118,32,40,37,114,100,120,41,44,37,114,98,120,34,10,9,97,115,109,32,34,109,111,118,32,56,40,37,114"
asm ".byte 100,120,41,44,37,114,115,105,34,10,9,97,115,109,32,34,109,111,118,32,37,114,98,120,44,40,37,114,97,120,41,34"
asm ".byte 10,9,97,115,109,32,34,109,111,118,32,37,114,115,105,44,56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97"
asm ".byte 100,100,32,36,49,54,44,37,114,97,120,34,10,9,97,115,109,32,34,97,100,100,32,36,49,54,44,37,114,100,120,34"
asm ".byte 10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,88,51,50,34,10,9,97,115,109,32,34,116,101,115,116,32"
asm ".byte 36,56,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,88,51,51,34,10,9"
asm ".byte 97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,114,98,120,34,10,9,97,115,109,32,34,109,111,118,32"
asm ".byte 37,114,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,56,44,37,114,97,120,34,10"
asm ".byte 9,97,115,109,32,34,97,100,100,32,36,56,44,37,114,100,120,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112"
asm ".byte 121,95,88,51,51,34,10,9,97,115,109,32,34,116,101,115,116,32,36,52,44,37,99,108,34,10,9,97,115,109,32,34"
asm ".byte 106,101,32,64,95,109,101,109,99,112,121,95,88,51,52,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120"
asm ".byte 41,44,37,101,98,120,34,10,9,97,115,109,32,34,109,111,118,32,37,101,98,120,44,40,37,114,97,120,41,34,10,9"
asm ".byte 97,115,109,32,34,97,100,100,32,36,52,44,37,114,97,120,34,10,9,97,115,109,32,34,97,100,100,32,36,52,44,37"
asm ".byte 114,100,120,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,88,51,52,34,10,9,97,115,109,32,34,116"
asm ".byte 101,115,116,32,36,50,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,88,51"
asm ".byte 53,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,98,120,34,10,9,97,115,109,32,34,109"
asm ".byte 111,118,32,37,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,50,44,37,114,97,120"
asm ".byte 34,10,9,97,115,109,32,34,97,100,100,32,36,50,44,37,114,100,120,34,10,9,97,115,109,32,34,64,95,109,101,109"
asm ".byte 99,112,121,95,88,51,53,34,10,9,97,115,109,32,34,116,101,115,116,32,36,49,44,37,99,108,34,10,9,97,115,109"
asm ".byte 32,34,106,101,32,64,95,109,101,109,99,112,121,95,88,51,54,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114"
asm ".byte 100,120,41,44,37,98,108,34,10,9,97,115,109,32,34,109,111,118,32,37,98,108,44,40,37,114,97,120,41,34,10,9"
asm ".byte 97,115,109,32,34,64,95,109,101,109,99,112,121,95,88,51,54,34,10,9,97,115,109,32,34,112,111,112,32,37,114,49"
asm ".byte 50,34,10,9,97,115,109,32,34,112,111,112,32,37,114,49,49,34,10,9,97,115,109,32,34,112,111,112,32,37,114,49"
asm ".byte 48,34,10,9,97,115,109,32,34,112,111,112,32,37,114,57,34,10,9,97,115,109,32,34,112,111,112,32,37,114,56,34"
asm ".byte 10,9,97,115,109,32,34,112,111,112,32,37,114,100,105,34,10,9,97,115,109,32,34,112,111,112,32,37,114,115,105,34"
asm ".byte 10,9,97,115,109,32,34,112,111,112,32,37,114,98,120,34,10,9,97,115,109,32,34,112,111,112,32,37,114,100,120,34"
asm ".byte 10,9,97,115,109,32,34,112,111,112,32,37,114,99,120,34,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114"
asm ".byte 98,112,41,44,37,114,97,120,34,10,125,10,118,111,105,100,32,42,109,101,109,99,112,121,95,114,40,118,111,105,100,32"
asm ".byte 42,100,115,116,44,118,111,105,100,32,42,115,114,99,44,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116"
asm ".byte 32,115,105,122,101,41,10,123,10,9,97,115,109,32,34,112,117,115,104,32,37,114,99,120,34,10,9,97,115,109,32,34"
asm ".byte 112,117,115,104,32,37,114,100,120,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,98,120,34,10,9,97,115,109"
asm ".byte 32,34,112,117,115,104,32,37,114,115,105,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,100,105,34,10,9,97"
asm ".byte 115,109,32,34,112,117,115,104,32,37,114,56,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,57,34,10,9,97"
asm ".byte 115,109,32,34,112,117,115,104,32,37,114,49,48,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,49,49,34,10"
asm ".byte 9,97,115,109,32,34,112,117,115,104,32,37,114,49,50,34,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114"
asm ".byte 98,112,41,44,37,114,97,120,34,10,9,97,115,109,32,34,109,111,118,32,50,52,40,37,114,98,112,41,44,37,114,100"
asm ".byte 120,34,10,9,97,115,109,32,34,109,111,118,32,51,50,40,37,114,98,112,41,44,37,114,99,120,34,10,9,97,115,109"
asm ".byte 32,34,99,109,112,32,36,56,44,37,114,99,120,34,10,9,97,115,109,32,34,106,98,32,64,95,109,101,109,99,112,121"
asm ".byte 95,114,95,88,51,51,34,10,9,97,115,109,32,34,116,101,115,116,32,36,49,44,37,100,108,34,10,9,97,115,109,32"
asm ".byte 34,106,101,32,64,95,109,101,109,99,112,121,95,114,95,88,49,49,34,10,9,97,115,109,32,34,100,101,99,32,37,114"
asm ".byte 97,120,34,10,9,97,115,109,32,34,100,101,99,32,37,114,100,120,34,10,9,97,115,109,32,34,100,101,99,32,37,114"
asm ".byte 99,120,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,98,108,34,10,9,97,115,109,32,34"
asm ".byte 109,111,118,32,37,98,108,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,114"
asm ".byte 95,88,49,49,34,10,9,97,115,109,32,34,116,101,115,116,32,36,50,44,37,100,108,34,10,9,97,115,109,32,34,106"
asm ".byte 101,32,64,95,109,101,109,99,112,121,95,114,95,88,49,50,34,10,9,97,115,109,32,34,115,117,98,32,36,50,44,37"
asm ".byte 114,97,120,34,10,9,97,115,109,32,34,115,117,98,32,36,50,44,37,114,100,120,34,10,9,97,115,109,32,34,115,117"
asm ".byte 98,32,36,50,44,37,114,99,120,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,98,120,34"
asm ".byte 10,9,97,115,109,32,34,109,111,118,32,37,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,64,95,109"
asm ".byte 101,109,99,112,121,95,114,95,88,49,50,34,10,9,97,115,109,32,34,116,101,115,116,32,36,52,44,37,100,108,34,10"
asm ".byte 9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,114,95,88,49,51,34,10,9,97,115,109,32,34,115"
asm ".byte 117,98,32,36,52,44,37,114,97,120,34,10,9,97,115,109,32,34,115,117,98,32,36,52,44,37,114,100,120,34,10,9"
asm ".byte 97,115,109,32,34,115,117,98,32,36,52,44,37,114,99,120,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100"
asm ".byte 120,41,44,37,101,98,120,34,10,9,97,115,109,32,34,109,111,118,32,37,101,98,120,44,40,37,114,97,120,41,34,10"
asm ".byte 9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,114,95,88,49,51,34,10,9,97,115,109,32,34,115,117,98,32"
asm ".byte 36,54,52,44,37,114,99,120,34,10,9,97,115,109,32,34,106,98,32,64,95,109,101,109,99,112,121,95,114,95,88,50"
asm ".byte 49,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,114,95,88,50,50,34,10,9,97,115,109,32,34,115"
asm ".byte 117,98,32,36,54,52,44,37,114,97,120,34,10,9,97,115,109,32,34,115,117,98,32,36,54,52,44,37,114,100,120,34"
asm ".byte 10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,114,98,120,34,10,9,97,115,109,32,34,109,111"
asm ".byte 118,32,56,40,37,114,100,120,41,44,37,114,115,105,34,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114,100"
asm ".byte 120,41,44,37,114,100,105,34,10,9,97,115,109,32,34,109,111,118,32,50,52,40,37,114,100,120,41,44,37,114,56,34"
asm ".byte 10,9,97,115,109,32,34,109,111,118,32,51,50,40,37,114,100,120,41,44,37,114,57,34,10,9,97,115,109,32,34,109"
asm ".byte 111,118,32,52,48,40,37,114,100,120,41,44,37,114,49,48,34,10,9,97,115,109,32,34,109,111,118,32,52,56,40,37"
asm ".byte 114,100,120,41,44,37,114,49,49,34,10,9,97,115,109,32,34,109,111,118,32,53,54,40,37,114,100,120,41,44,37,114"
asm ".byte 49,50,34,10,9,97,115,109,32,34,109,111,118,32,37,114,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32"
asm ".byte 34,109,111,118,32,37,114,115,105,44,56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100"
asm ".byte 105,44,49,54,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,56,44,50,52,40,37,114,97"
asm ".byte 120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,57,44,51,50,40,37,114,97,120,41,34,10,9,97,115,109"
asm ".byte 32,34,109,111,118,32,37,114,49,48,44,52,48,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37"
asm ".byte 114,49,49,44,52,56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,49,50,44,53,54,40"
asm ".byte 37,114,97,120,41,34,10,9,97,115,109,32,34,115,117,98,32,36,54,52,44,37,114,99,120,34,10,9,97,115,109,32"
asm ".byte 34,106,97,101,32,64,95,109,101,109,99,112,121,95,114,95,88,50,50,34,10,9,97,115,109,32,34,64,95,109,101,109"
asm ".byte 99,112,121,95,114,95,88,50,49,34,10,9,97,115,109,32,34,116,101,115,116,32,36,51,50,44,37,99,108,34,10,9"
asm ".byte 97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,114,95,88,51,49,34,10,9,97,115,109,32,34,115,117"
asm ".byte 98,32,36,51,50,44,37,114,97,120,34,10,9,97,115,109,32,34,115,117,98,32,36,51,50,44,37,114,100,120,34,10"
asm ".byte 9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,114,98,120,34,10,9,97,115,109,32,34,109,111,118"
asm ".byte 32,56,40,37,114,100,120,41,44,37,114,115,105,34,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114,100,120"
asm ".byte 41,44,37,114,100,105,34,10,9,97,115,109,32,34,109,111,118,32,50,52,40,37,114,100,120,41,44,37,114,56,34,10"
asm ".byte 9,97,115,109,32,34,109,111,118,32,37,114,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118"
asm ".byte 32,37,114,115,105,44,56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,105,44,49,54"
asm ".byte 40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,56,44,50,52,40,37,114,97,120,41,34,10"
asm ".byte 9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,114,95,88,51,49,34,10,9,97,115,109,32,34,116,101,115,116"
asm ".byte 32,36,49,54,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,114,95,88,51"
asm ".byte 50,34,10,9,97,115,109,32,34,115,117,98,32,36,49,54,44,37,114,97,120,34,10,9,97,115,109,32,34,115,117,98"
asm ".byte 32,36,49,54,44,37,114,100,120,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,114,98,120"
asm ".byte 34,10,9,97,115,109,32,34,109,111,118,32,56,40,37,114,100,120,41,44,37,114,115,105,34,10,9,97,115,109,32,34"
asm ".byte 109,111,118,32,37,114,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,115,105,44"
asm ".byte 56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,114,95,88,51,50,34,10,9"
asm ".byte 97,115,109,32,34,116,101,115,116,32,36,56,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109"
asm ".byte 99,112,121,95,114,95,88,51,51,34,10,9,97,115,109,32,34,115,117,98,32,36,56,44,37,114,97,120,34,10,9,97"
asm ".byte 115,109,32,34,115,117,98,32,36,56,44,37,114,100,120,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120"
asm ".byte 41,44,37,114,98,120,34,10,9,97,115,109,32,34,109,111,118,32,37,114,98,120,44,40,37,114,97,120,41,34,10,9"
asm ".byte 97,115,109,32,34,64,95,109,101,109,99,112,121,95,114,95,88,51,51,34,10,9,97,115,109,32,34,116,101,115,116,32"
asm ".byte 36,52,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,114,95,88,51,52,34"
asm ".byte 10,9,97,115,109,32,34,115,117,98,32,36,52,44,37,114,97,120,34,10,9,97,115,109,32,34,115,117,98,32,36,52"
asm ".byte 44,37,114,100,120,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,101,98,120,34,10,9,97"
asm ".byte 115,109,32,34,109,111,118,32,37,101,98,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,64,95,109,101,109"
asm ".byte 99,112,121,95,114,95,88,51,52,34,10,9,97,115,109,32,34,116,101,115,116,32,36,50,44,37,99,108,34,10,9,97"
asm ".byte 115,109,32,34,106,101,32,64,95,109,101,109,99,112,121,95,114,95,88,51,53,34,10,9,97,115,109,32,34,115,117,98"
asm ".byte 32,36,50,44,37,114,97,120,34,10,9,97,115,109,32,34,115,117,98,32,36,50,44,37,114,100,120,34,10,9,97,115"
asm ".byte 109,32,34,109,111,118,32,40,37,114,100,120,41,44,37,98,120,34,10,9,97,115,109,32,34,109,111,118,32,37,98,120"
asm ".byte 44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,64,95,109,101,109,99,112,121,95,114,95,88,51,53,34,10,9"
asm ".byte 97,115,109,32,34,116,101,115,116,32,36,49,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109"
asm ".byte 99,112,121,95,114,95,88,51,54,34,10,9,97,115,109,32,34,109,111,118,32,45,49,40,37,114,100,120,41,44,37,98"
asm ".byte 108,34,10,9,97,115,109,32,34,109,111,118,32,37,98,108,44,45,49,40,37,114,97,120,41,34,10,9,97,115,109,32"
asm ".byte 34,64,95,109,101,109,99,112,121,95,114,95,88,51,54,34,10,9,97,115,109,32,34,112,111,112,32,37,114,49,50,34"
asm ".byte 10,9,97,115,109,32,34,112,111,112,32,37,114,49,49,34,10,9,97,115,109,32,34,112,111,112,32,37,114,49,48,34"
asm ".byte 10,9,97,115,109,32,34,112,111,112,32,37,114,57,34,10,9,97,115,109,32,34,112,111,112,32,37,114,56,34,10,9"
asm ".byte 97,115,109,32,34,112,111,112,32,37,114,100,105,34,10,9,97,115,109,32,34,112,111,112,32,37,114,115,105,34,10,9"
asm ".byte 97,115,109,32,34,112,111,112,32,37,114,98,120,34,10,9,97,115,109,32,34,112,111,112,32,37,114,100,120,34,10,9"
asm ".byte 97,115,109,32,34,112,111,112,32,37,114,99,120,34,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114,98,112"
asm ".byte 41,44,37,114,97,120,34,10,125,10,118,111,105,100,32,42,109,101,109,109,111,118,101,40,118,111,105,100,32,42,100,115"
asm ".byte 116,44,118,111,105,100,32,42,115,114,99,44,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,115,105"
asm ".byte 122,101,41,10,123,10,9,105,102,40,100,115,116,60,115,114,99,124,124,40,99,104,97,114,32,42,41,100,115,116,62,61"
asm ".byte 40,99,104,97,114,32,42,41,115,114,99,43,115,105,122,101,41,10,9,123,10,9,9,114,101,116,117,114,110,32,109,101"
asm ".byte 109,99,112,121,40,100,115,116,44,115,114,99,44,115,105,122,101,41,59,10,9,125,10,9,101,108,115,101,10,9,123,10"
asm ".byte 9,9,109,101,109,99,112,121,95,114,40,40,99,104,97,114,32,42,41,100,115,116,43,115,105,122,101,44,40,99,104,97"
asm ".byte 114,32,42,41,115,114,99,43,115,105,122,101,44,115,105,122,101,41,59,10,9,9,114,101,116,117,114,110,32,100,115,116"
asm ".byte 59,10,9,125,10,125,10,97,115,109,32,34,64,95,109,101,109,109,111,118,101,95,101,110,100,34,10,118,111,105,100,32"
asm ".byte 42,109,101,109,115,101,116,40,118,111,105,100,32,42,109,101,109,44,105,110,116,32,118,97,108,44,117,110,115,105,103,110"
asm ".byte 101,100,32,108,111,110,103,32,105,110,116,32,115,105,122,101,41,10,123,10,9,97,115,109,32,34,112,117,115,104,32,37"
asm ".byte 114,99,120,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,100,120,34,10,9,97,115,109,32,34,109,111,118,122"
asm ".byte 98,108,32,50,52,40,37,114,98,112,41,44,37,101,100,120,34,10,9,97,115,109,32,34,109,111,118,32,36,48,120,49"
asm ".byte 48,49,48,49,48,49,48,49,48,49,48,49,48,49,44,37,114,97,120,34,10,9,97,115,109,32,34,109,117,108,32,37"
asm ".byte 114,100,120,34,10,9,97,115,109,32,34,109,111,118,32,37,114,97,120,44,37,114,100,120,34,10,9,97,115,109,32,34"
asm ".byte 109,111,118,32,49,54,40,37,114,98,112,41,44,37,114,97,120,34,10,9,97,115,109,32,34,109,111,118,32,51,50,40"
asm ".byte 37,114,98,112,41,44,37,114,99,120,34,10,9,97,115,109,32,34,99,109,112,32,36,56,44,37,114,99,120,34,10,9"
asm ".byte 97,115,109,32,34,106,98,32,64,95,109,101,109,115,101,116,95,88,51,51,34,10,9,97,115,109,32,34,116,101,115,116"
asm ".byte 32,36,49,44,37,97,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,115,101,116,95,88,49,49,34,10"
asm ".byte 9,97,115,109,32,34,109,111,118,32,37,100,108,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,105,110,99,32"
asm ".byte 37,114,97,120,34,10,9,97,115,109,32,34,100,101,99,32,37,114,99,120,34,10,9,97,115,109,32,34,64,95,109,101"
asm ".byte 109,115,101,116,95,88,49,49,34,10,9,97,115,109,32,34,116,101,115,116,32,36,50,44,37,97,108,34,10,9,97,115"
asm ".byte 109,32,34,106,101,32,64,95,109,101,109,115,101,116,95,88,49,50,34,10,9,97,115,109,32,34,109,111,118,32,37,100"
asm ".byte 120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,50,44,37,114,97,120,34,10,9,97,115"
asm ".byte 109,32,34,115,117,98,32,36,50,44,37,114,99,120,34,10,9,97,115,109,32,34,64,95,109,101,109,115,101,116,95,88"
asm ".byte 49,50,34,10,9,97,115,109,32,34,116,101,115,116,32,36,52,44,37,97,108,34,10,9,97,115,109,32,34,106,101,32"
asm ".byte 64,95,109,101,109,115,101,116,95,88,49,51,34,10,9,97,115,109,32,34,109,111,118,32,37,101,100,120,44,40,37,114"
asm ".byte 97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,52,44,37,114,97,120,34,10,9,97,115,109,32,34,115,117"
asm ".byte 98,32,36,52,44,37,114,99,120,34,10,9,97,115,109,32,34,64,95,109,101,109,115,101,116,95,88,49,51,34,10,9"
asm ".byte 97,115,109,32,34,115,117,98,32,36,54,52,44,37,114,99,120,34,10,9,97,115,109,32,34,106,98,32,64,95,109,101"
asm ".byte 109,115,101,116,95,88,50,49,34,10,9,97,115,109,32,34,64,95,109,101,109,115,101,116,95,88,50,50,34,10,9,97"
asm ".byte 115,109,32,34,109,111,118,32,37,114,100,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37"
asm ".byte 114,100,120,44,56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,120,44,49,54,40,37"
asm ".byte 114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,120,44,50,52,40,37,114,97,120,41,34,10,9"
asm ".byte 97,115,109,32,34,109,111,118,32,37,114,100,120,44,51,50,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111"
asm ".byte 118,32,37,114,100,120,44,52,48,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,120,44"
asm ".byte 52,56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,120,44,53,54,40,37,114,97,120"
asm ".byte 41,34,10,9,97,115,109,32,34,97,100,100,32,36,54,52,44,37,114,97,120,34,10,9,97,115,109,32,34,115,117,98"
asm ".byte 32,36,54,52,44,37,114,99,120,34,10,9,97,115,109,32,34,106,97,101,32,64,95,109,101,109,115,101,116,95,88,50"
asm ".byte 50,34,10,9,97,115,109,32,34,64,95,109,101,109,115,101,116,95,88,50,49,34,10,9,97,115,109,32,34,116,101,115"
asm ".byte 116,32,36,51,50,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,115,101,116,95,88,51,49"
asm ".byte 34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109"
asm ".byte 111,118,32,37,114,100,120,44,56,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,120,44"
asm ".byte 49,54,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,120,44,50,52,40,37,114,97,120"
asm ".byte 41,34,10,9,97,115,109,32,34,97,100,100,32,36,51,50,44,37,114,97,120,34,10,9,97,115,109,32,34,64,95,109"
asm ".byte 101,109,115,101,116,95,88,51,49,34,10,9,97,115,109,32,34,116,101,115,116,32,36,49,54,44,37,99,108,34,10,9"
asm ".byte 97,115,109,32,34,106,101,32,64,95,109,101,109,115,101,116,95,88,51,50,34,10,9,97,115,109,32,34,109,111,118,32"
asm ".byte 37,114,100,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,109,111,118,32,37,114,100,120,44,56,40,37,114"
asm ".byte 97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,49,54,44,37,114,97,120,34,10,9,97,115,109,32,34,64"
asm ".byte 95,109,101,109,115,101,116,95,88,51,50,34,10,9,97,115,109,32,34,116,101,115,116,32,36,56,44,37,99,108,34,10"
asm ".byte 9,97,115,109,32,34,106,101,32,64,95,109,101,109,115,101,116,95,88,51,51,34,10,9,97,115,109,32,34,109,111,118"
asm ".byte 32,37,114,100,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97,100,100,32,36,56,44,37,114,97,120,34"
asm ".byte 10,9,97,115,109,32,34,64,95,109,101,109,115,101,116,95,88,51,51,34,10,9,97,115,109,32,34,116,101,115,116,32"
asm ".byte 36,52,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,115,101,116,95,88,51,52,34,10,9"
asm ".byte 97,115,109,32,34,109,111,118,32,37,101,100,120,44,40,37,114,97,120,41,34,10,9,97,115,109,32,34,97,100,100,32"
asm ".byte 36,52,44,37,114,97,120,34,10,9,97,115,109,32,34,64,95,109,101,109,115,101,116,95,88,51,52,34,10,9,97,115"
asm ".byte 109,32,34,116,101,115,116,32,36,50,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,115,101"
asm ".byte 116,95,88,51,53,34,10,9,97,115,109,32,34,109,111,118,32,37,100,120,44,40,37,114,97,120,41,34,10,9,97,115"
asm ".byte 109,32,34,97,100,100,32,36,50,44,37,114,97,120,34,10,9,97,115,109,32,34,64,95,109,101,109,115,101,116,95,88"
asm ".byte 51,53,34,10,9,97,115,109,32,34,116,101,115,116,32,36,49,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32"
asm ".byte 64,95,109,101,109,115,101,116,95,88,51,54,34,10,9,97,115,109,32,34,109,111,118,32,37,100,108,44,40,37,114,97"
asm ".byte 120,41,34,10,9,97,115,109,32,34,64,95,109,101,109,115,101,116,95,88,51,54,34,10,9,97,115,109,32,34,112,111"
asm ".byte 112,32,37,114,100,120,34,10,9,97,115,109,32,34,112,111,112,32,37,114,99,120,34,10,9,97,115,109,32,34,109,111"
asm ".byte 118,32,49,54,40,37,114,98,112,41,44,37,114,97,120,34,10,125,10,105,110,116,32,109,101,109,99,109,112,40,118,111"
asm ".byte 105,100,32,42,109,101,109,49,44,118,111,105,100,32,42,109,101,109,50,44,117,110,115,105,103,110,101,100,32,108,111,110"
asm ".byte 103,32,105,110,116,32,115,105,122,101,41,10,123,10,9,97,115,109,32,34,112,117,115,104,32,37,114,115,105,34,10,9"
asm ".byte 97,115,109,32,34,112,117,115,104,32,37,114,100,105,34,10,9,97,115,109,32,34,112,117,115,104,32,37,114,99,120,34"
asm ".byte 10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114,98,112,41,44,37,114,115,105,34,10,9,97,115,109,32,34"
asm ".byte 109,111,118,32,50,52,40,37,114,98,112,41,44,37,114,100,105,34,10,9,97,115,109,32,34,109,111,118,32,51,50,40"
asm ".byte 37,114,98,112,41,44,37,114,99,120,34,10,9,97,115,109,32,34,115,117,98,32,36,56,44,37,114,99,120,34,10,9"
asm ".byte 97,115,109,32,34,106,98,32,64,95,109,101,109,99,109,112,95,88,49,34,10,9,97,115,109,32,34,64,95,109,101,109"
asm ".byte 99,109,112,95,88,50,34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,115,105,41,44,37,114,97,120,34,10,9"
asm ".byte 97,115,109,32,34,115,117,98,32,40,37,114,100,105,41,44,37,114,97,120,34,10,9,97,115,109,32,34,106,110,101,32"
asm ".byte 64,95,109,101,109,99,109,112,95,69,34,10,9,97,115,109,32,34,97,100,100,32,36,56,44,37,114,115,105,34,10,9"
asm ".byte 97,115,109,32,34,97,100,100,32,36,56,44,37,114,100,105,34,10,9,97,115,109,32,34,115,117,98,32,36,56,44,37"
asm ".byte 114,99,120,34,10,9,97,115,109,32,34,106,97,101,32,64,95,109,101,109,99,109,112,95,88,50,34,10,9,97,115,109"
asm ".byte 32,34,64,95,109,101,109,99,109,112,95,88,49,34,10,9,97,115,109,32,34,116,101,115,116,32,36,52,44,37,99,108"
asm ".byte 34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,109,112,95,89,49,34,10,9,97,115,109,32,34,109,111"
asm ".byte 118,32,40,37,114,115,105,41,44,37,101,97,120,34,10,9,97,115,109,32,34,115,117,98,32,40,37,114,100,105,41,44"
asm ".byte 37,101,97,120,34,10,9,97,115,109,32,34,106,110,101,32,64,95,109,101,109,99,109,112,95,69,34,10,9,97,115,109"
asm ".byte 32,34,97,100,100,32,36,52,44,37,114,115,105,34,10,9,97,115,109,32,34,97,100,100,32,36,52,44,37,114,100,105"
asm ".byte 34,10,9,97,115,109,32,34,64,95,109,101,109,99,109,112,95,89,49,34,10,9,97,115,109,32,34,116,101,115,116,32"
asm ".byte 36,50,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,109,112,95,89,50,34,10,9,97"
asm ".byte 115,109,32,34,109,111,118,32,40,37,114,115,105,41,44,37,97,120,34,10,9,97,115,109,32,34,115,117,98,32,40,37"
asm ".byte 114,100,105,41,44,37,97,120,34,10,9,97,115,109,32,34,106,110,101,32,64,95,109,101,109,99,109,112,95,69,34,10"
asm ".byte 9,97,115,109,32,34,97,100,100,32,36,50,44,37,114,115,105,34,10,9,97,115,109,32,34,97,100,100,32,36,50,44"
asm ".byte 37,114,100,105,34,10,9,97,115,109,32,34,64,95,109,101,109,99,109,112,95,89,50,34,10,9,97,115,109,32,34,116"
asm ".byte 101,115,116,32,36,49,44,37,99,108,34,10,9,97,115,109,32,34,106,101,32,64,95,109,101,109,99,109,112,95,69,50"
asm ".byte 34,10,9,97,115,109,32,34,109,111,118,32,40,37,114,115,105,41,44,37,97,108,34,10,9,97,115,109,32,34,115,117"
asm ".byte 98,32,40,37,114,100,105,41,44,37,97,108,34,10,9,97,115,109,32,34,106,110,101,32,64,95,109,101,109,99,109,112"
asm ".byte 95,69,34,10,9,97,115,109,32,34,97,100,100,32,36,49,44,37,114,115,105,34,10,9,97,115,109,32,34,97,100,100"
asm ".byte 32,36,49,44,37,114,100,105,34,10,9,97,115,109,32,34,106,109,112,32,64,95,109,101,109,99,109,112,95,69,50,34"
asm ".byte 10,9,97,115,109,32,34,64,95,109,101,109,99,109,112,95,69,34,10,9,97,115,109,32,34,116,101,115,116,32,37,101"
asm ".byte 97,120,44,37,101,97,120,34,10,9,97,115,109,32,34,106,110,101,32,64,95,109,101,109,99,109,112,95,69,49,49,34"
asm ".byte 10,9,97,115,109,32,34,115,104,114,32,36,51,50,44,37,114,97,120,34,10,9,97,115,109,32,34,64,95,109,101,109"
asm ".byte 99,109,112,95,69,49,49,34,10,9,97,115,109,32,34,116,101,115,116,32,37,97,120,44,37,97,120,34,10,9,97,115"
asm ".byte 109,32,34,106,110,101,32,64,95,109,101,109,99,109,112,95,69,49,50,34,10,9,97,115,109,32,34,115,104,114,32,36"
asm ".byte 49,54,44,37,114,97,120,34,10,9,97,115,109,32,34,64,95,109,101,109,99,109,112,95,69,49,50,34,10,9,97,115"
asm ".byte 109,32,34,116,101,115,116,32,37,97,108,44,37,97,108,34,10,9,97,115,109,32,34,106,110,101,32,64,95,109,101,109"
asm ".byte 99,109,112,95,69,50,34,10,9,97,115,109,32,34,109,111,118,32,37,97,104,44,37,97,108,34,10,9,97,115,109,32"
asm ".byte 34,64,95,109,101,109,99,109,112,95,69,50,34,10,9,97,115,109,32,34,109,111,118,115,98,113,32,37,97,108,44,37"
asm ".byte 114,97,120,34,10,9,97,115,109,32,34,112,111,112,32,37,114,99,120,34,10,9,97,115,109,32,34,112,111,112,32,37"
asm ".byte 114,100,105,34,10,9,97,115,109,32,34,112,111,112,32,37,114,115,105,34,10,125,10,117,110,115,105,103,110,101,100,32"
asm ".byte 108,111,110,103,32,105,110,116,32,115,116,114,108,101,110,40,99,104,97,114,32,42,115,116,114,41,10,123,10,9,117,110"
asm ".byte 115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,108,59,10,9,108,61,48,59,10,9,119,104,105,108,101,40"
asm ".byte 42,115,116,114,41,10,9,123,10,9,9,43,43,108,59,10,9,9,43,43,115,116,114,59,10,9,125,10,9,114,101,116"
asm ".byte 117,114,110,32,108,59,10,125,10,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,115,116,114,110,108"
asm ".byte 101,110,40,99,104,97,114,32,42,115,116,114,44,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,109"
asm ".byte 97,120,41,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,108,59,10,9,105,102,40"
asm ".byte 109,97,120,61,61,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,48,59,10,9,125,10,9,45,45,109,97,120"
asm ".byte 59,10,9,108,61,48,59,10,9,119,104,105,108,101,40,42,115,116,114,38,38,108,60,109,97,120,41,10,9,123,10,9"
asm ".byte 9,43,43,108,59,10,9,9,43,43,115,116,114,59,10,9,125,10,9,114,101,116,117,114,110,32,108,59,10,125,10,105"
asm ".byte 110,116,32,115,116,114,99,109,112,40,99,104,97,114,32,42,115,116,114,49,44,99,104,97,114,32,42,115,116,114,50,41"
asm ".byte 10,123,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,108,49,44,108,50,59,10,9,108,49"
asm ".byte 61,115,116,114,108,101,110,40,115,116,114,49,41,59,10,9,108,50,61,115,116,114,108,101,110,40,115,116,114,50,41,59"
asm ".byte 10,9,105,102,40,108,49,62,108,50,41,10,9,123,10,9,9,108,49,61,108,50,59,10,9,125,10,9,114,101,116,117"
asm ".byte 114,110,32,109,101,109,99,109,112,40,115,116,114,49,44,115,116,114,50,44,108,49,43,49,41,59,10,125,10,105,110,116"
asm ".byte 32,115,116,114,110,99,109,112,40,99,104,97,114,32,42,115,116,114,49,44,99,104,97,114,32,42,115,116,114,50,44,117"
asm ".byte 110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,109,97,120,41,10,123,10,9,117,110,115,105,103,110,101"
asm ".byte 100,32,108,111,110,103,32,105,110,116,32,108,49,44,108,50,59,10,9,108,49,61,115,116,114,110,108,101,110,40,115,116"
asm ".byte 114,49,44,109,97,120,41,59,10,9,108,50,61,115,116,114,110,108,101,110,40,115,116,114,50,44,109,97,120,41,59,10"
asm ".byte 9,105,102,40,108,49,62,108,50,41,10,9,123,10,9,9,108,49,61,108,50,59,10,9,125,10,9,114,101,116,117,114"
asm ".byte 110,32,109,101,109,99,109,112,40,115,116,114,49,44,115,116,114,50,44,108,49,43,49,41,59,10,125,10,99,104,97,114"
asm ".byte 32,42,115,116,114,99,112,121,40,99,104,97,114,32,42,100,115,116,44,99,104,97,114,32,42,115,114,99,41,10,123,10"
asm ".byte 9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,108,59,10,9,108,61,115,116,114,108,101,110,40"
asm ".byte 115,114,99,41,59,10,9,109,101,109,99,112,121,40,100,115,116,44,115,114,99,44,108,43,49,41,59,10,9,114,101,116"
asm ".byte 117,114,110,32,100,115,116,59,10,125,10,99,104,97,114,32,42,115,116,114,99,97,116,40,99,104,97,114,32,42,100,115"
asm ".byte 116,44,99,104,97,114,32,42,115,114,99,41,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110"
asm ".byte 116,32,108,59,10,9,108,61,115,116,114,108,101,110,40,100,115,116,41,59,10,9,115,116,114,99,112,121,40,100,115,116"
asm ".byte 43,108,44,115,114,99,41,59,10,9,114,101,116,117,114,110,32,100,115,116,59,10,125,10,35,101,110,100,105,102,10,0"
asm ".byte 48,55,48,55,48,49,48,48,48,48,48,48,48,67,48,48,48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,49,66,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,116,101,114,109,105,111,115,46,99,0,0,0,35,105,102,110"
asm ".byte 100,101,102,32,95,73,79,67,84,76,95,95,84,69,82,77,73,79,83,95,67,95,10,35,100,101,102,105,110,101,32,95"
asm ".byte 73,79,67,84,76,95,95,84,69,82,77,73,79,83,95,67,95,10,115,116,114,117,99,116,32,116,101,114,109,105,111,115"
asm ".byte 10,123,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,105,102,108,97,103,59,10,9,117,110,115,105,103,110,101"
asm ".byte 100,32,105,110,116,32,111,102,108,97,103,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,99,102,108,97,103"
asm ".byte 59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,108,102,108,97,103,59,10,9,117,110,115,105,103,110,101,100"
asm ".byte 32,99,104,97,114,32,108,105,110,101,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,99,99,91,51,50"
asm ".byte 93,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,105,115,112,101,101,100,59,10,9,117,110,115,105,103,110"
asm ".byte 101,100,32,105,110,116,32,111,115,112,101,101,100,59,10,125,59,10,115,116,114,117,99,116,32,119,105,110,115,105,122,101"
asm ".byte 10,123,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,114,111,119,59,10,9,117,110,115,105,103,110,101"
asm ".byte 100,32,115,104,111,114,116,32,99,111,108,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,117,110,117,115,101"
asm ".byte 100,59,10,125,59,10,35,100,101,102,105,110,101,32,84,67,71,69,84,83,32,48,120,53,52,48,49,10,35,100,101,102"
asm ".byte 105,110,101,32,84,67,83,69,84,83,32,48,120,53,52,48,50,10,35,100,101,102,105,110,101,32,84,73,79,67,83,67"
asm ".byte 84,84,89,32,48,120,53,52,48,101,10,35,100,101,102,105,110,101,32,84,73,79,67,71,87,73,78,83,90,32,48,120"
asm ".byte 53,52,49,51,10,35,101,110,100,105,102,10,48,55,48,55,48,49,48,48,48,48,48,48,48,68,48,48,48,48,56,49"
asm ".byte 65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,50,65,51,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,65,48,48,48,48,48,48,48,48,46,47,115,116,97,116"
asm ".byte 46,99,0,0,35,105,102,110,100,101,102,32,95,83,84,65,84,95,67,95,10,35,100,101,102,105,110,101,32,95,83,84"
asm ".byte 65,84,95,67,95,10,115,116,114,117,99,116,32,115,116,97,116,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111"
asm ".byte 110,103,32,105,110,116,32,100,101,118,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,105"
asm ".byte 110,111,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,110,108,105,110,107,59,10,9,117"
asm ".byte 110,115,105,103,110,101,100,32,105,110,116,32,109,111,100,101,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32"
asm ".byte 117,105,100,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,103,105,100,59,10,9,117,110,115,105,103,110,101"
asm ".byte 100,32,105,110,116,32,112,97,100,49,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,114"
asm ".byte 100,101,118,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,115,105,122,101,59,10,9,117"
asm ".byte 110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,98,108,107,115,105,122,101,59,10,9,117,110,115,105,103"
asm ".byte 110,101,100,32,108,111,110,103,32,105,110,116,32,98,108,111,99,107,115,59,10,9,117,110,115,105,103,110,101,100,32,108"
asm ".byte 111,110,103,32,105,110,116,32,97,116,105,109,101,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110"
asm ".byte 116,32,97,116,105,109,101,49,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,109,116,105"
asm ".byte 109,101,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,109,116,105,109,101,49,59,10,9"
asm ".byte 117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,99,116,105,109,101,59,10,9,117,110,115,105,103,110"
asm ".byte 101,100,32,108,111,110,103,32,105,110,116,32,99,116,105,109,101,49,59,10,9,117,110,115,105,103,110,101,100,32,108,111"
asm ".byte 110,103,32,105,110,116,32,112,97,100,50,91,51,93,59,10,125,59,10,35,100,101,102,105,110,101,32,83,84,65,84,95"
asm ".byte 68,73,82,32,48,52,48,48,48,48,10,35,100,101,102,105,110,101,32,83,84,65,84,95,82,69,71,32,48,49,48,48"
asm ".byte 48,48,48,10,35,100,101,102,105,110,101,32,83,84,65,84,95,70,73,70,79,32,48,49,48,48,48,48,10,35,100,101"
asm ".byte 102,105,110,101,32,83,84,65,84,95,83,79,67,75,32,48,49,52,48,48,48,48,10,35,100,101,102,105,110,101,32,83"
asm ".byte 84,65,84,95,76,78,75,32,48,49,50,48,48,48,48,10,35,100,101,102,105,110,101,32,83,84,65,84,95,67,72,82"
asm ".byte 32,48,50,48,48,48,48,10,35,100,101,102,105,110,101,32,83,84,65,84,95,66,76,75,32,48,54,48,48,48,48,10"
asm ".byte 35,101,110,100,105,102,10,0,48,55,48,55,48,49,48,48,48,48,48,48,48,69,48,48,48,48,56,49,65,52,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,52,52,69,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,112,99,111,110,116,101,120,116"
asm ".byte 46,99,0,0,35,105,102,110,100,101,102,32,95,80,67,79,78,84,69,88,84,95,67,95,10,35,100,101,102,105,110,101"
asm ".byte 32,95,80,67,79,78,84,69,88,84,95,67,95,10,115,116,114,117,99,116,32,112,99,111,110,116,101,120,116,10,123,10"
asm ".byte 9,108,111,110,103,32,114,105,112,59,10,9,108,111,110,103,32,103,112,114,101,103,91,49,51,93,59,10,125,59,10,105"
asm ".byte 110,116,32,112,99,111,110,116,101,120,116,95,115,97,118,101,40,115,116,114,117,99,116,32,112,99,111,110,116,101,120,116"
asm ".byte 32,42,112,99,111,110,116,101,120,116,41,59,10,97,115,109,32,34,64,112,99,111,110,116,101,120,116,95,115,97,118,101"
asm ".byte 34,10,97,115,109,32,34,109,111,118,32,56,40,37,114,115,112,41,44,37,114,99,120,34,10,97,115,109,32,34,108,101"
asm ".byte 97,32,64,112,99,111,110,116,101,120,116,95,115,97,118,101,95,114,105,112,45,64,112,99,111,110,116,101,120,116,95,108"
asm ".byte 40,37,114,105,112,41,44,37,114,97,120,34,10,97,115,109,32,34,64,112,99,111,110,116,101,120,116,95,108,34,10,97"
asm ".byte 115,109,32,34,109,111,118,32,37,114,97,120,44,40,37,114,99,120,41,34,10,97,115,109,32,34,109,111,118,32,37,114"
asm ".byte 98,120,44,56,40,37,114,99,120,41,34,10,97,115,109,32,34,109,111,118,32,37,114,115,112,44,49,54,40,37,114,99"
asm ".byte 120,41,34,10,97,115,109,32,34,109,111,118,32,37,114,98,112,44,50,52,40,37,114,99,120,41,34,10,97,115,109,32"
asm ".byte 34,109,111,118,32,37,114,115,105,44,51,50,40,37,114,99,120,41,34,10,97,115,109,32,34,109,111,118,32,37,114,100"
asm ".byte 105,44,52,48,40,37,114,99,120,41,34,10,97,115,109,32,34,109,111,118,32,37,114,56,44,52,56,40,37,114,99,120"
asm ".byte 41,34,10,97,115,109,32,34,109,111,118,32,37,114,57,44,53,54,40,37,114,99,120,41,34,10,97,115,109,32,34,109"
asm ".byte 111,118,32,37,114,49,48,44,54,52,40,37,114,99,120,41,34,10,97,115,109,32,34,109,111,118,32,37,114,49,49,44"
asm ".byte 55,50,40,37,114,99,120,41,34,10,97,115,109,32,34,109,111,118,32,37,114,49,50,44,56,48,40,37,114,99,120,41"
asm ".byte 34,10,97,115,109,32,34,109,111,118,32,37,114,49,51,44,56,56,40,37,114,99,120,41,34,10,97,115,109,32,34,109"
asm ".byte 111,118,32,37,114,49,52,44,57,54,40,37,114,99,120,41,34,10,97,115,109,32,34,109,111,118,32,37,114,49,53,44"
asm ".byte 49,48,52,40,37,114,99,120,41,34,10,97,115,109,32,34,120,111,114,32,37,101,97,120,44,37,101,97,120,34,10,97"
asm ".byte 115,109,32,34,64,112,99,111,110,116,101,120,116,95,115,97,118,101,95,114,105,112,34,10,97,115,109,32,34,114,101,116"
asm ".byte 34,10,118,111,105,100,32,112,99,111,110,116,101,120,116,95,114,101,115,116,111,114,101,40,115,116,114,117,99,116,32,112"
asm ".byte 99,111,110,116,101,120,116,32,42,112,99,111,110,116,101,120,116,44,105,110,116,32,114,101,116,41,59,10,97,115,109,32"
asm ".byte 34,64,112,99,111,110,116,101,120,116,95,114,101,115,116,111,114,101,34,10,97,115,109,32,34,109,111,118,32,49,54,40"
asm ".byte 37,114,115,112,41,44,37,101,97,120,34,10,97,115,109,32,34,109,111,118,32,56,40,37,114,115,112,41,44,37,114,99"
asm ".byte 120,34,10,97,115,109,32,34,109,111,118,32,56,40,37,114,99,120,41,44,37,114,98,120,34,10,97,115,109,32,34,109"
asm ".byte 111,118,32,49,54,40,37,114,99,120,41,44,37,114,115,112,34,10,97,115,109,32,34,109,111,118,32,50,52,40,37,114"
asm ".byte 99,120,41,44,37,114,98,112,34,10,97,115,109,32,34,109,111,118,32,51,50,40,37,114,99,120,41,44,37,114,115,105"
asm ".byte 34,10,97,115,109,32,34,109,111,118,32,52,48,40,37,114,99,120,41,44,37,114,100,105,34,10,97,115,109,32,34,109"
asm ".byte 111,118,32,52,56,40,37,114,99,120,41,44,37,114,56,34,10,97,115,109,32,34,109,111,118,32,53,54,40,37,114,99"
asm ".byte 120,41,44,37,114,57,34,10,97,115,109,32,34,109,111,118,32,54,52,40,37,114,99,120,41,44,37,114,49,48,34,10"
asm ".byte 97,115,109,32,34,109,111,118,32,55,50,40,37,114,99,120,41,44,37,114,49,49,34,10,97,115,109,32,34,109,111,118"
asm ".byte 32,56,48,40,37,114,99,120,41,44,37,114,49,50,34,10,97,115,109,32,34,109,111,118,32,56,56,40,37,114,99,120"
asm ".byte 41,44,37,114,49,51,34,10,97,115,109,32,34,109,111,118,32,57,54,40,37,114,99,120,41,44,37,114,49,52,34,10"
asm ".byte 97,115,109,32,34,109,111,118,32,49,48,52,40,37,114,99,120,41,44,37,114,49,53,34,10,97,115,109,32,34,106,109"
asm ".byte 112,32,42,40,37,114,99,120,41,34,10,35,101,110,100,105,102,10,0,0,48,55,48,55,48,49,48,48,48,48,48,48"
asm ".byte 48,70,48,48,48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,53,49,57,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,65,48,48,48,48,48,48"
asm ".byte 48,48,46,47,108,119,112,46,99,0,0,0,35,105,102,110,100,101,102,32,95,76,87,80,95,67,95,10,35,100,101,102"
asm ".byte 105,110,101,32,95,76,87,80,95,67,95,10,105,110,116,32,99,114,101,97,116,101,95,108,119,112,40,117,110,115,105,103"
asm ".byte 110,101,100,32,108,111,110,103,32,115,116,97,99,107,95,115,105,122,101,44,105,110,116,32,40,42,102,117,110,41,40,118"
asm ".byte 111,105,100,32,42,41,44,118,111,105,100,32,42,97,114,103,41,59,10,97,115,109,32,34,64,99,114,101,97,116,101,95"
asm ".byte 108,119,112,34,10,97,115,109,32,34,112,117,115,104,32,37,114,100,105,34,10,97,115,109,32,34,112,117,115,104,32,37"
asm ".byte 114,115,105,34,10,97,115,109,32,34,112,117,115,104,32,37,114,100,120,34,10,97,115,109,32,34,112,117,115,104,32,37"
asm ".byte 114,49,48,34,10,97,115,109,32,34,112,117,115,104,32,37,114,56,34,10,97,115,109,32,34,112,117,115,104,32,37,114"
asm ".byte 57,34,10,97,115,109,32,34,112,117,115,104,32,37,114,49,49,34,10,97,115,109,32,34,112,117,115,104,32,37,114,49"
asm ".byte 50,34,10,97,115,109,32,34,112,117,115,104,32,37,114,49,51,34,10,97,115,109,32,34,112,117,115,104,32,37,114,49"
asm ".byte 52,34,10,97,115,109,32,34,109,111,118,32,56,56,40,37,114,115,112,41,44,37,114,115,105,34,10,97,115,109,32,34"
asm ".byte 120,111,114,32,37,101,100,105,44,37,101,100,105,34,10,97,115,109,32,34,109,111,118,32,36,51,44,37,101,100,120,34"
asm ".byte 10,97,115,109,32,34,109,111,118,32,36,48,120,50,50,44,37,114,49,48,100,34,10,97,115,109,32,34,109,111,118,32"
asm ".byte 37,101,100,105,44,37,114,56,100,34,10,97,115,109,32,34,109,111,118,32,37,101,100,105,44,37,114,57,100,34,10,97"
asm ".byte 115,109,32,34,100,101,99,32,37,114,56,34,10,97,115,109,32,34,109,111,118,32,36,57,44,37,101,97,120,34,10,97"
asm ".byte 115,109,32,34,115,121,115,99,97,108,108,34,10,97,115,109,32,34,99,109,112,32,36,48,120,102,102,102,102,102,102,102"
asm ".byte 102,102,102,102,102,102,48,48,48,44,37,114,97,120,34,10,97,115,109,32,34,106,97,32,64,95,99,114,101,97,116,101"
asm ".byte 95,108,119,112,95,101,110,100,34,10,97,115,109,32,34,109,111,118,32,56,56,40,37,114,115,112,41,44,37,114,49,50"
asm ".byte 34,10,97,115,109,32,34,109,111,118,32,57,54,40,37,114,115,112,41,44,37,114,100,120,34,10,97,115,109,32,34,109"
asm ".byte 111,118,32,49,48,52,40,37,114,115,112,41,44,37,114,49,52,34,10,97,115,109,32,34,109,111,118,32,36,48,120,49"
asm ".byte 56,102,48,48,44,37,101,100,105,34,10,97,115,109,32,34,109,111,118,32,37,114,97,120,44,37,114,49,51,34,10,97"
asm ".byte 115,109,32,34,108,101,97,32,40,37,114,97,120,44,37,114,49,50,41,44,37,114,115,105,34,10,97,115,109,32,34,109"
asm ".byte 111,118,32,36,53,54,44,37,101,97,120,34,10,97,115,109,32,34,115,121,115,99,97,108,108,34,10,97,115,109,32,34"
asm ".byte 99,109,112,32,36,48,120,102,102,102,102,102,102,102,102,102,102,102,102,102,48,48,48,44,37,114,97,120,34,10,97,115"
asm ".byte 109,32,34,106,97,32,64,95,99,114,101,97,116,101,95,108,119,112,95,101,114,114,34,10,10,97,115,109,32,34,116,101"
asm ".byte 115,116,32,37,114,97,120,44,37,114,97,120,34,10,97,115,109,32,34,106,110,101,32,64,95,99,114,101,97,116,101,95"
asm ".byte 108,119,112,95,101,110,100,34,10,97,115,109,32,34,112,117,115,104,32,37,114,49,50,34,10,97,115,109,32,34,112,117"
asm ".byte 115,104,32,37,114,49,52,34,10,97,115,109,32,34,99,97,108,108,32,42,37,114,100,120,34,10,97,115,109,32,34,109"
asm ".byte 111,118,32,56,40,37,114,115,112,41,44,37,114,115,105,34,10,97,115,109,32,34,108,101,97,32,49,54,40,37,114,115"
asm ".byte 112,41,44,37,114,100,105,34,10,97,115,109,32,34,115,117,98,32,37,114,115,105,44,37,114,100,105,34,10,97,115,109"
asm ".byte 32,34,109,111,118,32,37,114,97,120,44,37,114,100,120,34,10,97,115,109,32,34,109,111,118,32,36,49,49,44,37,101"
asm ".byte 97,120,34,10,97,115,109,32,34,115,121,115,99,97,108,108,34,10,97,115,109,32,34,109,111,118,32,37,114,100,120,44"
asm ".byte 37,114,100,105,34,10,97,115,109,32,34,109,111,118,32,36,54,48,44,37,101,97,120,34,10,97,115,109,32,34,115,121"
asm ".byte 115,99,97,108,108,34,10,10,97,115,109,32,34,64,95,99,114,101,97,116,101,95,108,119,112,95,101,114,114,34,10,97"
asm ".byte 115,109,32,34,109,111,118,32,37,114,49,50,44,37,114,115,105,34,10,97,115,109,32,34,109,111,118,32,37,114,49,51"
asm ".byte 44,37,114,100,105,34,10,97,115,109,32,34,109,111,118,32,36,49,49,44,37,101,97,120,34,10,97,115,109,32,34,115"
asm ".byte 121,115,99,97,108,108,34,10,10,97,115,109,32,34,64,95,99,114,101,97,116,101,95,108,119,112,95,101,110,100,34,10"
asm ".byte 97,115,109,32,34,112,111,112,32,37,114,49,52,34,10,97,115,109,32,34,112,111,112,32,37,114,49,51,34,10,97,115"
asm ".byte 109,32,34,112,111,112,32,37,114,49,50,34,10,97,115,109,32,34,112,111,112,32,37,114,49,49,34,10,97,115,109,32"
asm ".byte 34,112,111,112,32,37,114,57,34,10,97,115,109,32,34,112,111,112,32,37,114,56,34,10,97,115,109,32,34,112,111,112"
asm ".byte 32,37,114,49,48,34,10,97,115,109,32,34,112,111,112,32,37,114,100,120,34,10,97,115,109,32,34,112,111,112,32,37"
asm ".byte 114,115,105,34,10,97,115,109,32,34,112,111,112,32,37,114,100,105,34,10,97,115,109,32,34,114,101,116,34,10,35,101"
asm ".byte 110,100,105,102,10,0,0,0,48,55,48,55,48,49,48,48,48,48,48,48,49,48,48,48,48,48,56,49,65,52,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,67,51,69,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,115,111,99,107,101,116,46,99"
asm ".byte 0,0,0,0,35,105,102,110,100,101,102,32,95,83,79,67,75,69,84,95,67,95,10,35,100,101,102,105,110,101,32,95"
asm ".byte 83,79,67,75,69,84,95,67,95,10,35,100,101,102,105,110,101,32,65,70,95,85,78,73,88,32,49,10,35,100,101,102"
asm ".byte 105,110,101,32,65,70,95,73,78,69,84,32,50,10,35,100,101,102,105,110,101,32,65,70,95,73,78,69,84,54,32,49"
asm ".byte 48,10,35,100,101,102,105,110,101,32,65,70,95,78,69,84,76,73,78,75,32,49,54,10,35,100,101,102,105,110,101,32"
asm ".byte 65,70,95,80,65,67,75,69,84,32,49,55,10,35,100,101,102,105,110,101,32,65,70,95,65,76,71,32,51,56,10,10"
asm ".byte 35,100,101,102,105,110,101,32,83,79,67,75,95,83,84,82,69,65,77,32,49,10,35,100,101,102,105,110,101,32,83,79"
asm ".byte 67,75,95,68,71,82,65,77,32,50,10,35,100,101,102,105,110,101,32,83,79,67,75,95,82,65,87,32,51,10,35,100"
asm ".byte 101,102,105,110,101,32,83,79,67,75,95,83,69,81,80,65,67,75,69,84,32,53,10,35,100,101,102,105,110,101,32,83"
asm ".byte 79,67,75,95,67,76,79,69,88,69,67,32,48,50,48,48,48,48,48,48,10,35,100,101,102,105,110,101,32,83,79,67"
asm ".byte 75,95,78,79,78,66,76,79,67,75,32,48,52,48,48,48,10,10,35,100,101,102,105,110,101,32,73,80,80,82,79,84"
asm ".byte 79,95,84,67,80,32,54,10,35,100,101,102,105,110,101,32,73,80,80,82,79,84,79,95,85,68,80,32,49,55,10,35"
asm ".byte 100,101,102,105,110,101,32,69,84,72,95,80,95,65,76,76,32,48,120,48,51,48,48,10,35,100,101,102,105,110,101,32"
asm ".byte 69,84,72,95,80,95,73,80,32,48,120,48,48,48,56,10,35,100,101,102,105,110,101,32,69,84,72,95,80,95,80,65"
asm ".byte 69,32,48,120,56,56,56,101,10,10,35,100,101,102,105,110,101,32,83,79,76,95,83,79,67,75,69,84,32,49,10,35"
asm ".byte 100,101,102,105,110,101,32,83,79,76,95,65,76,71,32,50,55,57,10,10,35,100,101,102,105,110,101,32,83,79,95,83"
asm ".byte 78,68,66,85,70,32,55,10,35,100,101,102,105,110,101,32,83,79,95,82,67,86,66,85,70,32,56,10,10,35,100,101"
asm ".byte 102,105,110,101,32,78,69,84,76,73,78,75,95,82,79,85,84,69,32,48,10,35,100,101,102,105,110,101,32,78,69,84"
asm ".byte 76,73,78,75,95,71,69,78,69,82,73,67,32,49,54,10,10,115,116,114,117,99,116,32,115,111,99,107,97,100,100,114"
asm ".byte 95,117,110,10,123,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,105,110,116,32,102,97,109,105,108,121"
asm ".byte 59,10,9,99,104,97,114,32,115,117,110,95,112,97,116,104,91,49,48,56,93,59,10,125,59,10,115,116,114,117,99,116"
asm ".byte 32,115,111,99,107,97,100,100,114,95,105,110,10,123,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,105"
asm ".byte 110,116,32,115,105,110,95,102,97,109,105,108,121,59,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,105"
asm ".byte 110,116,32,115,105,110,95,112,111,114,116,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,115,105,110,95,97"
asm ".byte 100,100,114,59,10,9,99,104,97,114,32,112,97,100,91,56,93,59,10,125,59,10,115,116,114,117,99,116,32,115,111,99"
asm ".byte 107,97,100,100,114,95,105,110,54,10,123,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,105,110,116,32"
asm ".byte 115,105,110,54,95,102,97,109,105,108,121,59,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,105,110,116"
asm ".byte 32,115,105,110,54,95,112,111,114,116,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,115,105,110,54,95,102"
asm ".byte 108,111,119,105,110,102,111,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,115,105,110,54,95,97,100,100"
asm ".byte 114,91,49,54,93,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,115,105,110,54,95,115,99,111,112,101,95"
asm ".byte 105,100,59,10,125,59,10,115,116,114,117,99,116,32,115,111,99,107,97,100,100,114,95,110,108,10,123,10,9,117,110,115"
asm ".byte 105,103,110,101,100,32,115,104,111,114,116,32,105,110,116,32,110,108,95,102,97,109,105,108,121,59,10,9,117,110,115,105"
asm ".byte 103,110,101,100,32,115,104,111,114,116,32,105,110,116,32,112,97,100,59,10,9,117,110,115,105,103,110,101,100,32,105,110"
asm ".byte 116,32,112,105,100,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,103,114,111,117,112,115,59,10,125,59,10"
asm ".byte 115,116,114,117,99,116,32,115,111,99,107,97,100,100,114,95,108,108,10,123,10,9,117,110,115,105,103,110,101,100,32,115"
asm ".byte 104,111,114,116,32,115,108,108,95,102,97,109,105,108,121,59,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116"
asm ".byte 32,115,108,108,95,112,114,111,116,111,99,111,108,59,10,9,105,110,116,32,115,108,108,95,105,102,105,110,100,101,120,59"
asm ".byte 10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,115,108,108,95,104,97,116,121,112,101,59,10,9,117,110"
asm ".byte 115,105,103,110,101,100,32,99,104,97,114,32,115,108,108,95,112,107,116,116,121,112,101,59,10,9,117,110,115,105,103,110"
asm ".byte 101,100,32,99,104,97,114,32,115,108,108,95,104,97,108,101,110,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97"
asm ".byte 114,32,115,108,108,95,97,100,100,114,91,56,93,59,10,125,59,10,115,116,114,117,99,116,32,115,111,99,107,97,100,100"
asm ".byte 114,95,97,108,103,10,123,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,115,97,108,103,95,102,97,109"
asm ".byte 105,108,121,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,115,97,108,103,95,116,121,112,101,91,49,52"
asm ".byte 93,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,115,97,108,103,95,102,101,97,116,59,10,9,117,110,115"
asm ".byte 105,103,110,101,100,32,105,110,116,32,115,97,108,103,95,109,97,115,107,59,10,9,117,110,115,105,103,110,101,100,32,99"
asm ".byte 104,97,114,32,115,97,108,103,95,110,97,109,101,91,54,52,93,59,10,125,59,10,10,35,100,101,102,105,110,101,32,83"
asm ".byte 73,79,67,65,68,68,82,84,32,48,120,56,57,48,98,10,35,100,101,102,105,110,101,32,83,73,79,67,71,73,70,67"
asm ".byte 79,78,70,32,48,120,56,57,49,50,10,35,100,101,102,105,110,101,32,83,73,79,67,71,73,70,70,76,65,71,83,32"
asm ".byte 48,120,56,57,49,51,10,35,100,101,102,105,110,101,32,83,73,79,67,83,73,70,70,76,65,71,83,32,48,120,56,57"
asm ".byte 49,52,10,35,100,101,102,105,110,101,32,83,73,79,67,71,73,70,65,68,68,82,32,48,120,56,57,49,53,10,35,100"
asm ".byte 101,102,105,110,101,32,83,73,79,67,83,73,70,65,68,68,82,32,48,120,56,57,49,54,10,35,100,101,102,105,110,101"
asm ".byte 32,83,73,79,67,83,73,70,78,69,84,77,65,83,75,32,48,120,56,57,49,99,10,35,100,101,102,105,110,101,32,83"
asm ".byte 73,79,67,71,73,70,72,87,65,68,68,82,32,48,120,56,57,50,55,10,35,100,101,102,105,110,101,32,83,73,79,67"
asm ".byte 71,73,70,73,78,68,69,88,32,48,120,56,57,51,51,10,10,115,116,114,117,99,116,32,105,110,54,95,105,102,114,101"
asm ".byte 113,10,123,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,105,102,114,54,95,97,100,100,114,91,49,54,93"
asm ".byte 59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,105,102,114,54,95,112,114,101,102,105,120,108,101,110,59,10"
asm ".byte 9,105,110,116,32,105,102,114,54,95,105,102,105,110,100,101,120,59,10,125,59,10,117,110,105,111,110,32,95,95,105,102"
asm ".byte 114,101,113,95,100,97,116,97,10,123,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,98,121,116,101,115,91"
asm ".byte 49,54,93,59,10,9,115,116,114,117,99,116,32,115,111,99,107,97,100,100,114,95,105,110,32,97,100,100,114,59,10,9"
asm ".byte 117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,102,108,97,103,115,59,10,9,117,110,115,105,103,110,101,100,32"
asm ".byte 105,110,116,32,105,102,105,110,100,101,120,59,10,125,59,10,115,116,114,117,99,116,32,105,102,114,101,113,10,123,10,9"
asm ".byte 99,104,97,114,32,110,97,109,101,91,49,54,93,59,10,9,117,110,105,111,110,32,95,95,105,102,114,101,113,95,100,97"
asm ".byte 116,97,32,100,97,116,97,59,10,9,99,104,97,114,32,112,97,100,91,56,93,59,10,125,59,10,115,116,114,117,99,116"
asm ".byte 32,105,102,99,111,110,102,10,123,10,9,105,110,116,32,105,102,99,95,108,101,110,59,10,9,118,111,105,100,32,42,105"
asm ".byte 102,99,117,95,114,101,113,59,10,125,59,10,115,116,114,117,99,116,32,114,116,101,110,116,114,121,10,123,10,9,117,110"
asm ".byte 115,105,103,110,101,100,32,108,111,110,103,32,112,97,100,49,59,10,9,115,116,114,117,99,116,32,115,111,99,107,97,100"
asm ".byte 100,114,95,105,110,32,100,115,116,59,10,9,115,116,114,117,99,116,32,115,111,99,107,97,100,100,114,95,105,110,32,103"
asm ".byte 97,116,101,119,97,121,59,10,9,115,116,114,117,99,116,32,115,111,99,107,97,100,100,114,95,105,110,32,103,101,110,109"
asm ".byte 97,115,107,59,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,102,108,97,103,115,59,10,9,115,104,111"
asm ".byte 114,116,32,112,97,100,50,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,95,112,97,100,59,10,9,117,110"
asm ".byte 115,105,103,110,101,100,32,108,111,110,103,32,112,97,100,51,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103"
asm ".byte 32,112,97,100,52,59,10,9,115,104,111,114,116,32,109,101,116,114,105,99,59,10,9,117,110,115,105,103,110,101,100,32"
asm ".byte 115,104,111,114,116,32,95,112,97,100,50,91,51,93,59,10,9,99,104,97,114,32,42,100,101,118,59,10,9,117,110,115"
asm ".byte 105,103,110,101,100,32,108,111,110,103,32,109,116,117,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,119"
asm ".byte 105,110,100,111,119,59,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,105,114,116,116,59,10,9,117,110"
asm ".byte 115,105,103,110,101,100,32,115,104,111,114,116,32,95,112,97,100,51,91,51,93,59,10,125,59,10,10,35,100,101,102,105"
asm ".byte 110,101,32,104,116,111,110,119,40,110,41,32,40,40,117,110,115,105,103,110,101,100,32,115,104,111,114,116,41,40,110,41"
asm ".byte 60,60,56,124,40,117,110,115,105,103,110,101,100,32,115,104,111,114,116,41,40,110,41,62,62,56,41,10,35,100,101,102"
asm ".byte 105,110,101,32,104,116,111,110,108,40,110,41,32,40,40,117,110,115,105,103,110,101,100,32,105,110,116,41,40,110,41,60"
asm ".byte 60,50,52,124,40,117,110,115,105,103,110,101,100,32,105,110,116,41,40,110,41,62,62,50,52,124,40,117,110,115,105,103"
asm ".byte 110,101,100,32,105,110,116,41,40,110,41,60,60,56,38,48,120,102,102,48,48,48,48,124,40,117,110,115,105,103,110,101"
asm ".byte 100,32,105,110,116,41,40,110,41,62,62,56,38,48,120,102,102,48,48,41,10,10,35,100,101,102,105,110,101,32,77,83"
asm ".byte 71,95,68,79,78,84,87,65,73,84,32,48,120,52,48,10,115,116,114,117,99,116,32,109,115,103,104,100,114,10,123,10"
asm ".byte 9,118,111,105,100,32,42,110,97,109,101,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,110,97,109,101"
asm ".byte 108,101,110,59,10,9,118,111,105,100,32,42,105,111,118,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32"
asm ".byte 105,111,118,108,101,110,59,10,9,118,111,105,100,32,42,99,111,110,116,114,111,108,59,10,9,117,110,115,105,103,110,101"
asm ".byte 100,32,108,111,110,103,32,99,111,110,116,114,111,108,108,101,110,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110"
asm ".byte 103,32,117,110,117,115,101,100,59,10,125,59,10,115,116,114,117,99,116,32,99,109,115,103,104,100,114,10,123,10,9,117"
asm ".byte 110,115,105,103,110,101,100,32,108,111,110,103,32,108,101,110,59,10,9,105,110,116,32,108,101,118,101,108,59,10,9,105"
asm ".byte 110,116,32,116,121,112,101,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,100,97,116,97,91,56,93,59"
asm ".byte 10,125,59,10,115,116,114,117,99,116,32,110,108,109,115,103,104,100,114,10,123,10,9,117,110,115,105,103,110,101,100,32"
asm ".byte 105,110,116,32,108,101,110,59,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,116,121,112,101,59,10,9"
asm ".byte 117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,102,108,97,103,115,59,10,9,117,110,115,105,103,110,101,100,32"
asm ".byte 105,110,116,32,115,101,113,59,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32,112,105,100,59,10,125,59,10,115"
asm ".byte 116,114,117,99,116,32,103,101,110,108,109,115,103,104,100,114,10,123,10,9,117,110,115,105,103,110,101,100,32,99,104,97"
asm ".byte 114,32,99,109,100,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,118,101,114,115,105,111,110,59,10,9"
asm ".byte 117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,114,101,115,101,114,118,101,100,59,10,125,59,10,115,116,114,117"
asm ".byte 99,116,32,110,108,97,116,116,114,10,123,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,108,101,110,59"
asm ".byte 10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,116,121,112,101,59,10,125,59,10,10,35,101,110,100,105"
asm ".byte 102,10,0,0,48,55,48,55,48,49,48,48,48,48,48,48,49,49,48,48,48,48,56,49,65,52,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,51"
asm ".byte 70,51,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,102,102,111,114,109,97,116,46,99,0,0,0"
asm ".byte 35,105,102,110,100,101,102,32,95,70,70,79,82,77,65,84,95,67,95,10,35,100,101,102,105,110,101,32,95,70,70,79"
asm ".byte 82,77,65,84,95,67,95,10,35,105,110,99,108,117,100,101,32,34,109,101,109,46,99,34,10,118,111,105,100,32,115,112"
asm ".byte 114,105,110,116,70,40,99,104,97,114,32,42,115,116,114,44,102,108,111,97,116,32,97,44,105,110,116,32,100,105,103,105"
asm ".byte 116,115,49,44,105,110,116,32,100,105,103,105,116,115,50,41,10,123,10,9,105,110,116,32,108,59,10,9,105,110,116,32"
asm ".byte 100,59,10,9,102,108,111,97,116,32,110,59,10,9,99,104,97,114,32,99,59,10,9,108,61,115,116,114,108,101,110,40"
asm ".byte 115,116,114,41,59,10,9,105,102,40,97,60,48,41,10,9,123,10,9,9,97,61,45,97,59,10,9,9,115,116,114,91"
asm ".byte 108,93,61,39,45,39,59,10,9,9,115,116,114,91,108,43,49,93,61,48,59,10,9,9,43,43,108,59,10,9,125,10"
asm ".byte 9,110,61,49,46,48,59,10,9,100,61,48,59,10,9,119,104,105,108,101,40,100,60,100,105,103,105,116,115,49,41,10"
asm ".byte 9,123,10,9,9,110,42,61,49,48,46,48,59,10,9,9,43,43,100,59,10,9,125,10,9,119,104,105,108,101,40,110"
asm ".byte 60,61,97,41,10,9,123,10,9,9,110,42,61,49,48,46,48,59,10,9,125,10,9,110,42,61,48,46,49,59,10,9"
asm ".byte 119,104,105,108,101,40,110,62,61,48,46,53,41,10,9,123,10,9,9,99,61,39,48,39,59,10,9,9,119,104,105,108"
asm ".byte 101,40,97,62,61,110,38,38,99,60,39,57,39,41,10,9,9,123,10,9,9,9,43,43,99,59,10,9,9,9,97,45"
asm ".byte 61,110,59,10,9,9,125,10,9,9,115,116,114,91,108,93,61,99,59,10,9,9,115,116,114,91,108,43,49,93,61,48"
asm ".byte 59,10,9,9,43,43,108,59,10,9,9,110,42,61,48,46,49,59,10,9,125,10,9,105,102,40,33,100,105,103,105,116"
asm ".byte 115,50,41,10,9,123,10,9,9,114,101,116,117,114,110,32,48,59,10,9,125,10,9,115,116,114,91,108,93,61,39,46"
asm ".byte 39,59,10,9,115,116,114,91,108,43,49,93,61,48,59,10,9,43,43,108,59,10,9,100,61,100,105,103,105,116,115,50"
asm ".byte 59,10,9,110,61,48,46,48,48,49,59,10,9,119,104,105,108,101,40,100,41,10,9,123,10,9,9,110,61,110,42,48"
asm ".byte 46,49,59,10,9,9,45,45,100,59,10,9,125,10,9,119,104,105,108,101,40,100,105,103,105,116,115,50,41,10,9,123"
asm ".byte 10,9,9,97,61,97,42,49,48,46,48,59,10,9,9,99,61,39,48,39,59,10,9,9,119,104,105,108,101,40,97,62"
asm ".byte 61,49,46,48,45,110,38,38,99,60,39,57,39,41,10,9,9,123,10,9,9,9,43,43,99,59,10,9,9,9,97,45"
asm ".byte 61,49,46,48,45,110,59,10,9,9,125,10,9,9,115,116,114,91,108,93,61,99,59,10,9,9,115,116,114,91,108,43"
asm ".byte 49,93,61,48,59,10,9,9,43,43,108,59,10,9,9,45,45,100,105,103,105,116,115,50,59,10,9,125,10,125,10,99"
asm ".byte 104,97,114,32,42,115,105,110,112,117,116,70,40,99,104,97,114,32,42,115,116,114,44,102,108,111,97,116,32,42,114,101"
asm ".byte 115,117,108,116,41,10,123,10,9,102,108,111,97,116,32,114,101,116,44,110,59,10,9,99,104,97,114,32,99,59,10,9"
asm ".byte 105,110,116,32,115,59,10,9,114,101,116,61,48,46,48,59,10,9,115,61,48,59,10,9,110,61,48,46,49,59,10,9"
asm ".byte 119,104,105,108,101,40,40,99,61,42,115,116,114,41,62,61,39,48,39,38,38,99,60,61,39,57,39,124,124,99,61,61"
asm ".byte 39,46,39,41,10,9,123,10,9,9,105,102,40,99,61,61,39,46,39,41,10,9,9,123,10,9,9,9,115,61,49,59"
asm ".byte 10,9,9,125,10,9,9,101,108,115,101,32,105,102,40,115,41,10,9,9,123,10,9,9,9,114,101,116,43,61,110,42"
asm ".byte 40,102,108,111,97,116,41,40,99,45,39,48,39,41,59,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9"
asm ".byte 9,9,114,101,116,61,114,101,116,42,49,48,46,48,43,40,102,108,111,97,116,41,40,99,45,39,48,39,41,59,10,9"
asm ".byte 9,125,10,9,9,43,43,115,116,114,59,10,9,125,10,9,42,114,101,115,117,108,116,61,114,101,116,59,10,9,114,101"
asm ".byte 116,117,114,110,32,115,116,114,59,10,125,10,35,101,110,100,105,102,10,0,48,55,48,55,48,49,48,48,48,48,48,48"
asm ".byte 49,50,48,48,48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,49,48,48,48,48,48,48,48,48,48,48,48,48,49,52,70,57,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,65,48,48,48,48,48,48"
asm ".byte 48,48,46,47,112,97,116,104,46,99,0,0,35,105,102,110,100,101,102,32,95,80,65,84,72,95,67,95,10,35,100,101"
asm ".byte 102,105,110,101,32,95,80,65,84,72,95,67,95,10,35,105,110,99,108,117,100,101,32,34,115,121,115,99,97,108,108,46"
asm ".byte 99,34,10,35,105,110,99,108,117,100,101,32,34,109,101,109,46,99,34,10,35,105,110,99,108,117,100,101,32,34,115,116"
asm ".byte 97,116,46,99,34,10,105,110,116,32,102,105,115,115,117,98,100,105,114,40,105,110,116,32,100,105,114,102,100,44,105,110"
asm ".byte 116,32,102,100,41,10,123,10,9,105,110,116,32,102,100,49,44,102,100,50,59,10,9,105,110,116,32,114,101,116,59,10"
asm ".byte 9,115,116,114,117,99,116,32,115,116,97,116,32,115,116,44,100,105,114,115,116,44,100,105,114,115,116,95,111,108,100,59"
asm ".byte 10,9,105,102,40,114,101,116,61,102,115,116,97,116,40,100,105,114,102,100,44,38,115,116,41,41,10,9,123,10,9,9"
asm ".byte 114,101,116,117,114,110,32,114,101,116,59,10,9,125,10,9,102,100,49,61,100,117,112,40,102,100,41,59,10,9,105,102"
asm ".byte 40,102,100,49,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,102,100,49,59,10,9,125,10,9,102,100,50"
asm ".byte 61,45,49,59,10,9,119,104,105,108,101,40,49,41,10,9,123,10,9,9,9,10,9,9,105,102,40,114,101,116,61,102"
asm ".byte 115,116,97,116,40,102,100,49,44,38,100,105,114,115,116,41,41,10,9,9,123,10,9,9,9,99,108,111,115,101,40,102"
asm ".byte 100,49,41,59,10,9,9,9,114,101,116,117,114,110,32,114,101,116,59,10,9,9,125,10,9,9,105,102,40,100,105,114"
asm ".byte 115,116,46,105,110,111,61,61,115,116,46,105,110,111,38,38,100,105,114,115,116,46,100,101,118,61,61,115,116,46,100,101"
asm ".byte 118,41,10,9,9,123,10,9,9,9,99,108,111,115,101,40,102,100,49,41,59,10,9,9,9,114,101,116,117,114,110,32"
asm ".byte 49,59,10,9,9,125,10,9,9,105,102,40,102,100,50,33,61,45,49,38,38,100,105,114,115,116,46,105,110,111,61,61"
asm ".byte 100,105,114,115,116,95,111,108,100,46,105,110,111,38,38,100,105,114,115,116,46,100,101,118,61,61,100,105,114,115,116,95"
asm ".byte 111,108,100,46,100,101,118,41,10,9,9,123,10,9,9,9,99,108,111,115,101,40,102,100,49,41,59,10,9,9,9,114"
asm ".byte 101,116,117,114,110,32,48,59,10,9,9,125,10,9,9,109,101,109,99,112,121,40,38,100,105,114,115,116,95,111,108,100"
asm ".byte 44,38,100,105,114,115,116,44,115,105,122,101,111,102,40,100,105,114,115,116,41,41,59,10,9,9,102,100,50,61,111,112"
asm ".byte 101,110,97,116,40,102,100,49,44,34,46,46,34,44,48,44,48,41,59,10,9,9,99,108,111,115,101,40,102,100,49,41"
asm ".byte 59,10,9,9,105,102,40,102,100,50,60,48,41,10,9,9,123,10,9,9,9,114,101,116,117,114,110,32,102,100,50,59"
asm ".byte 10,9,9,125,10,9,9,102,100,49,61,102,100,50,59,10,9,125,10,125,10,105,110,116,32,100,105,114,110,97,109,101"
asm ".byte 95,111,112,101,110,40,99,104,97,114,32,42,112,97,116,104,44,99,104,97,114,32,42,42,112,97,116,104,95,114,101,116"
asm ".byte 41,10,123,10,9,105,110,116,32,102,100,49,44,102,100,50,59,10,9,99,104,97,114,32,98,117,102,91,50,55,48,93"
asm ".byte 59,10,9,105,110,116,32,120,44,99,59,10,9,99,104,97,114,32,42,112,97,116,104,49,59,10,9,105,102,40,33,115"
asm ".byte 116,114,99,109,112,40,112,97,116,104,44,34,47,34,41,41,10,9,123,10,9,9,105,102,40,112,97,116,104,95,114,101"
asm ".byte 116,41,10,9,9,123,10,9,9,9,42,112,97,116,104,95,114,101,116,61,112,97,116,104,59,10,9,9,125,10,9,9"
asm ".byte 114,101,116,117,114,110,32,111,112,101,110,40,34,47,34,44,48,44,48,41,59,10,9,125,10,9,102,100,49,61,65,84"
asm ".byte 95,70,68,67,87,68,59,10,9,105,102,40,42,112,97,116,104,61,61,39,47,39,41,10,9,123,10,9,9,102,100,49"
asm ".byte 61,111,112,101,110,40,34,47,34,44,48,44,48,41,59,10,9,9,105,102,40,102,100,49,60,48,41,10,9,9,123,10"
asm ".byte 9,9,9,114,101,116,117,114,110,32,102,100,49,59,10,9,9,125,10,9,9,43,43,112,97,116,104,59,10,9,125,10"
asm ".byte 9,112,97,116,104,49,61,112,97,116,104,59,10,9,120,61,48,59,10,9,119,104,105,108,101,40,99,61,42,112,97,116"
asm ".byte 104,41,10,9,123,10,9,9,105,102,40,99,61,61,39,47,39,41,10,9,9,123,10,9,9,9,98,117,102,91,120,93"
asm ".byte 61,48,59,10,9,9,9,100,111,10,9,9,9,123,10,9,9,9,9,43,43,112,97,116,104,59,10,9,9,9,125,10"
asm ".byte 9,9,9,119,104,105,108,101,40,42,112,97,116,104,61,61,39,47,39,41,59,10,9,9,9,105,102,40,42,112,97,116"
asm ".byte 104,41,10,9,9,9,123,10,9,9,9,9,102,100,50,61,111,112,101,110,97,116,40,102,100,49,44,98,117,102,44,48"
asm ".byte 44,48,41,59,10,9,9,9,9,99,108,111,115,101,40,102,100,49,41,59,10,9,9,9,9,105,102,40,102,100,50,60"
asm ".byte 48,41,10,9,9,9,9,123,10,9,9,9,9,9,114,101,116,117,114,110,32,102,100,50,59,10,9,9,9,9,125,10"
asm ".byte 9,9,9,9,102,100,49,61,102,100,50,59,10,9,9,9,9,112,97,116,104,49,61,112,97,116,104,59,10,9,9,9"
asm ".byte 125,10,9,9,9,120,61,48,59,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9,9,9,105,102,40,120"
asm ".byte 62,61,50,53,54,41,10,9,9,9,123,10,9,9,9,9,114,101,116,117,114,110,32,45,69,78,65,77,69,84,79,79"
asm ".byte 76,79,78,71,59,10,9,9,9,125,10,9,9,9,98,117,102,91,120,93,61,99,59,10,9,9,9,43,43,112,97,116"
asm ".byte 104,59,10,9,9,9,43,43,120,59,10,9,9,125,10,9,125,10,9,105,102,40,112,97,116,104,95,114,101,116,41,10"
asm ".byte 9,123,10,9,9,42,112,97,116,104,95,114,101,116,61,112,97,116,104,49,59,10,9,125,10,9,105,102,40,102,100,49"
asm ".byte 61,61,65,84,95,70,68,67,87,68,41,10,9,123,10,9,9,102,100,49,61,111,112,101,110,40,34,46,34,44,48,44"
asm ".byte 48,41,59,10,9,125,10,9,114,101,116,117,114,110,32,102,100,49,59,10,125,10,105,110,116,32,111,112,101,110,108,40"
asm ".byte 99,104,97,114,32,42,112,97,116,104,44,105,110,116,32,102,108,97,103,115,44,105,110,116,32,109,111,100,101,41,10,123"
asm ".byte 10,9,105,110,116,32,100,105,114,44,102,100,59,10,9,99,104,97,114,32,42,98,110,97,109,101,59,10,9,100,105,114"
asm ".byte 61,100,105,114,110,97,109,101,95,111,112,101,110,40,112,97,116,104,44,38,98,110,97,109,101,41,59,10,9,105,102,40"
asm ".byte 100,105,114,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100,105,114,59,10,9,125,10,9,102,100,61,111"
asm ".byte 112,101,110,97,116,40,100,105,114,44,98,110,97,109,101,44,102,108,97,103,115,44,109,111,100,101,41,59,10,9,99,108"
asm ".byte 111,115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110,32,102,100,59,10,125,10,105,110,116,32,115,116,97,116"
asm ".byte 108,40,99,104,97,114,32,42,112,97,116,104,44,115,116,114,117,99,116,32,115,116,97,116,32,42,115,116,41,10,123,10"
asm ".byte 9,105,110,116,32,100,105,114,44,114,101,116,59,10,9,99,104,97,114,32,42,98,110,97,109,101,59,10,9,100,105,114"
asm ".byte 61,100,105,114,110,97,109,101,95,111,112,101,110,40,112,97,116,104,44,38,98,110,97,109,101,41,59,10,9,105,102,40"
asm ".byte 100,105,114,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100,105,114,59,10,9,125,10,9,114,101,116,61"
asm ".byte 102,115,116,97,116,97,116,40,100,105,114,44,98,110,97,109,101,44,115,116,44,48,41,59,10,9,99,108,111,115,101,40"
asm ".byte 100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101,116,59,10,125,10,105,110,116,32,108,115,116,97,116,108,40"
asm ".byte 99,104,97,114,32,42,112,97,116,104,44,115,116,114,117,99,116,32,115,116,97,116,32,42,115,116,41,10,123,10,9,105"
asm ".byte 110,116,32,100,105,114,44,114,101,116,59,10,9,99,104,97,114,32,42,98,110,97,109,101,59,10,9,100,105,114,61,100"
asm ".byte 105,114,110,97,109,101,95,111,112,101,110,40,112,97,116,104,44,38,98,110,97,109,101,41,59,10,9,105,102,40,100,105"
asm ".byte 114,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100,105,114,59,10,9,125,10,9,114,101,116,61,102,115"
asm ".byte 116,97,116,97,116,40,100,105,114,44,98,110,97,109,101,44,115,116,44,65,84,95,83,89,77,76,73,78,75,95,78,79"
asm ".byte 70,79,76,76,79,87,41,59,10,9,99,108,111,115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101"
asm ".byte 116,59,10,125,10,105,110,116,32,109,107,100,105,114,108,40,99,104,97,114,32,42,112,97,116,104,44,105,110,116,32,109"
asm ".byte 111,100,101,41,10,123,10,9,105,110,116,32,100,105,114,44,114,101,116,59,10,9,99,104,97,114,32,42,98,110,97,109"
asm ".byte 101,59,10,9,100,105,114,61,100,105,114,110,97,109,101,95,111,112,101,110,40,112,97,116,104,44,38,98,110,97,109,101"
asm ".byte 41,59,10,9,105,102,40,100,105,114,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100,105,114,59,10,9"
asm ".byte 125,10,9,114,101,116,61,109,107,100,105,114,97,116,40,100,105,114,44,98,110,97,109,101,44,109,111,100,101,41,59,10"
asm ".byte 9,99,108,111,115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101,116,59,10,125,10,105,110,116,32"
asm ".byte 105,115,115,117,98,100,105,114,40,99,104,97,114,32,42,100,105,114,112,97,116,104,44,99,104,97,114,32,42,112,97,116"
asm ".byte 104,41,10,123,10,9,105,110,116,32,100,105,114,102,100,44,102,100,44,114,101,116,59,10,9,115,116,114,117,99,116,32"
asm ".byte 115,116,97,116,32,115,116,59,10,9,105,102,40,114,101,116,61,108,115,116,97,116,108,40,100,105,114,112,97,116,104,44"
asm ".byte 38,115,116,41,41,10,9,123,10,9,9,114,101,116,117,114,110,32,114,101,116,59,10,9,125,10,9,105,102,40,40,115"
asm ".byte 116,46,109,111,100,101,38,48,49,55,48,48,48,48,41,33,61,83,84,65,84,95,68,73,82,41,10,9,123,10,9,9"
asm ".byte 114,101,116,117,114,110,32,48,59,10,9,125,10,9,100,105,114,102,100,61,111,112,101,110,108,40,100,105,114,112,97,116"
asm ".byte 104,44,48,44,48,41,59,10,9,105,102,40,100,105,114,102,100,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110"
asm ".byte 32,100,105,114,102,100,59,10,9,125,10,9,102,100,61,100,105,114,110,97,109,101,95,111,112,101,110,40,112,97,116,104"
asm ".byte 44,78,85,76,76,41,59,10,9,105,102,40,102,100,60,48,41,10,9,123,10,9,9,99,108,111,115,101,40,100,105,114"
asm ".byte 102,100,41,59,10,9,9,114,101,116,117,114,110,32,102,100,59,10,9,125,10,9,114,101,116,61,102,105,115,115,117,98"
asm ".byte 100,105,114,40,100,105,114,102,100,44,102,100,41,59,10,9,99,108,111,115,101,40,100,105,114,102,100,41,59,10,9,99"
asm ".byte 108,111,115,101,40,102,100,41,59,10,9,114,101,116,117,114,110,32,114,101,116,59,10,125,10,105,110,116,32,100,105,114"
asm ".byte 110,97,109,101,95,111,112,101,110,97,116,40,105,110,116,32,100,105,114,102,100,44,99,104,97,114,32,42,112,97,116,104"
asm ".byte 44,99,104,97,114,32,42,42,112,97,116,104,95,114,101,116,41,10,123,10,9,105,110,116,32,102,100,49,44,102,100,50"
asm ".byte 59,10,9,99,104,97,114,32,98,117,102,91,50,55,48,93,59,10,9,105,110,116,32,120,44,99,59,10,9,99,104,97"
asm ".byte 114,32,42,112,97,116,104,49,59,10,9,105,102,40,33,115,116,114,99,109,112,40,112,97,116,104,44,34,47,34,41,41"
asm ".byte 10,9,123,10,9,9,105,102,40,112,97,116,104,95,114,101,116,41,10,9,9,123,10,9,9,9,42,112,97,116,104,95"
asm ".byte 114,101,116,61,112,97,116,104,59,10,9,9,125,10,9,9,114,101,116,117,114,110,32,111,112,101,110,40,34,47,34,44"
asm ".byte 48,44,48,41,59,10,9,125,10,9,105,102,40,100,105,114,102,100,61,61,65,84,95,70,68,67,87,68,41,10,9,123"
asm ".byte 10,9,9,102,100,49,61,111,112,101,110,40,34,46,34,44,48,44,48,41,59,10,9,125,10,9,101,108,115,101,10,9"
asm ".byte 123,10,9,9,102,100,49,61,100,117,112,40,100,105,114,102,100,41,59,10,9,125,10,9,105,102,40,42,112,97,116,104"
asm ".byte 61,61,39,47,39,41,10,9,123,10,9,9,99,108,111,115,101,40,102,100,49,41,59,10,9,9,102,100,49,61,111,112"
asm ".byte 101,110,40,34,47,34,44,48,44,48,41,59,10,9,9,105,102,40,102,100,49,60,48,41,10,9,9,123,10,9,9,9"
asm ".byte 114,101,116,117,114,110,32,102,100,49,59,10,9,9,125,10,9,9,43,43,112,97,116,104,59,10,9,125,10,9,101,108"
asm ".byte 115,101,32,105,102,40,102,100,49,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,102,100,49,59,10,9,125"
asm ".byte 10,9,112,97,116,104,49,61,112,97,116,104,59,10,9,120,61,48,59,10,9,119,104,105,108,101,40,99,61,42,112,97"
asm ".byte 116,104,41,10,9,123,10,9,9,105,102,40,99,61,61,39,47,39,41,10,9,9,123,10,9,9,9,98,117,102,91,120"
asm ".byte 93,61,48,59,10,9,9,9,100,111,10,9,9,9,123,10,9,9,9,9,43,43,112,97,116,104,59,10,9,9,9,125"
asm ".byte 10,9,9,9,119,104,105,108,101,40,42,112,97,116,104,61,61,39,47,39,41,59,10,9,9,9,105,102,40,42,112,97"
asm ".byte 116,104,41,10,9,9,9,123,10,9,9,9,9,102,100,50,61,111,112,101,110,97,116,40,102,100,49,44,98,117,102,44"
asm ".byte 48,44,48,41,59,10,9,9,9,9,99,108,111,115,101,40,102,100,49,41,59,10,9,9,9,9,105,102,40,102,100,50"
asm ".byte 60,48,41,10,9,9,9,9,123,10,9,9,9,9,9,114,101,116,117,114,110,32,102,100,50,59,10,9,9,9,9,125"
asm ".byte 10,9,9,9,9,102,100,49,61,102,100,50,59,10,9,9,9,9,112,97,116,104,49,61,112,97,116,104,59,10,9,9"
asm ".byte 9,125,10,9,9,9,120,61,48,59,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9,9,9,105,102,40"
asm ".byte 120,62,61,50,53,54,41,10,9,9,9,123,10,9,9,9,9,114,101,116,117,114,110,32,45,69,78,65,77,69,84,79"
asm ".byte 79,76,79,78,71,59,10,9,9,9,125,10,9,9,9,98,117,102,91,120,93,61,99,59,10,9,9,9,43,43,112,97"
asm ".byte 116,104,59,10,9,9,9,43,43,120,59,10,9,9,125,10,9,125,10,9,105,102,40,112,97,116,104,95,114,101,116,41"
asm ".byte 10,9,123,10,9,9,42,112,97,116,104,95,114,101,116,61,112,97,116,104,49,59,10,9,125,10,9,105,102,40,102,100"
asm ".byte 49,61,61,65,84,95,70,68,67,87,68,41,10,9,123,10,9,9,102,100,49,61,111,112,101,110,40,34,46,34,44,48"
asm ".byte 44,48,41,59,10,9,125,10,9,114,101,116,117,114,110,32,102,100,49,59,10,125,10,105,110,116,32,111,112,101,110,97"
asm ".byte 116,108,40,105,110,116,32,100,105,114,102,100,44,99,104,97,114,32,42,112,97,116,104,44,105,110,116,32,102,108,97,103"
asm ".byte 115,44,105,110,116,32,109,111,100,101,41,10,123,10,9,105,110,116,32,100,105,114,44,102,100,59,10,9,99,104,97,114"
asm ".byte 32,42,98,110,97,109,101,59,10,9,100,105,114,61,100,105,114,110,97,109,101,95,111,112,101,110,97,116,40,100,105,114"
asm ".byte 102,100,44,112,97,116,104,44,38,98,110,97,109,101,41,59,10,9,105,102,40,100,105,114,60,48,41,10,9,123,10,9"
asm ".byte 9,114,101,116,117,114,110,32,100,105,114,59,10,9,125,10,9,102,100,61,111,112,101,110,97,116,40,100,105,114,44,98"
asm ".byte 110,97,109,101,44,102,108,97,103,115,44,109,111,100,101,41,59,10,9,99,108,111,115,101,40,100,105,114,41,59,10,9"
asm ".byte 114,101,116,117,114,110,32,102,100,59,10,125,10,105,110,116,32,109,107,100,105,114,97,116,108,40,105,110,116,32,100,105"
asm ".byte 114,102,100,44,99,104,97,114,32,42,112,97,116,104,44,105,110,116,32,109,111,100,101,41,10,123,10,9,105,110,116,32"
asm ".byte 100,105,114,44,114,101,116,59,10,9,99,104,97,114,32,42,98,110,97,109,101,59,10,9,100,105,114,61,100,105,114,110"
asm ".byte 97,109,101,95,111,112,101,110,97,116,40,100,105,114,102,100,44,112,97,116,104,44,38,98,110,97,109,101,41,59,10,9"
asm ".byte 105,102,40,100,105,114,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100,105,114,59,10,9,125,10,9,114"
asm ".byte 101,116,61,109,107,100,105,114,97,116,40,100,105,114,44,98,110,97,109,101,44,109,111,100,101,41,59,10,9,99,108,111"
asm ".byte 115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101,116,59,10,125,10,105,110,116,32,102,99,104,109"
asm ".byte 111,100,97,116,108,40,105,110,116,32,100,105,114,102,100,44,99,104,97,114,32,42,112,97,116,104,44,105,110,116,32,109"
asm ".byte 111,100,101,41,10,123,10,9,105,110,116,32,100,105,114,44,114,101,116,59,10,9,99,104,97,114,32,42,98,110,97,109"
asm ".byte 101,59,10,9,100,105,114,61,100,105,114,110,97,109,101,95,111,112,101,110,97,116,40,100,105,114,102,100,44,112,97,116"
asm ".byte 104,44,38,98,110,97,109,101,41,59,10,9,105,102,40,100,105,114,60,48,41,10,9,123,10,9,9,114,101,116,117,114"
asm ".byte 110,32,100,105,114,59,10,9,125,10,9,114,101,116,61,102,99,104,109,111,100,97,116,40,100,105,114,44,98,110,97,109"
asm ".byte 101,44,109,111,100,101,41,59,10,9,99,108,111,115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101"
asm ".byte 116,59,10,125,10,105,110,116,32,102,115,116,97,116,97,116,108,40,105,110,116,32,100,105,114,102,100,44,99,104,97,114"
asm ".byte 32,42,112,97,116,104,44,115,116,114,117,99,116,32,115,116,97,116,32,42,115,116,44,105,110,116,32,102,108,97,103,115"
asm ".byte 41,10,123,10,9,105,110,116,32,100,105,114,44,114,101,116,59,10,9,99,104,97,114,32,42,98,110,97,109,101,59,10"
asm ".byte 9,100,105,114,61,100,105,114,110,97,109,101,95,111,112,101,110,97,116,40,100,105,114,102,100,44,112,97,116,104,44,38"
asm ".byte 98,110,97,109,101,41,59,10,9,105,102,40,100,105,114,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100"
asm ".byte 105,114,59,10,9,125,10,9,114,101,116,61,102,115,116,97,116,97,116,40,100,105,114,44,98,110,97,109,101,44,115,116"
asm ".byte 44,102,108,97,103,115,41,59,10,9,99,108,111,115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101"
asm ".byte 116,59,10,125,10,105,110,116,32,115,121,109,108,105,110,107,97,116,108,40,99,104,97,114,32,42,116,97,114,103,101,116"
asm ".byte 44,105,110,116,32,100,105,114,102,100,44,99,104,97,114,32,42,112,97,116,104,41,10,123,10,9,105,110,116,32,100,105"
asm ".byte 114,44,114,101,116,59,10,9,99,104,97,114,32,42,98,110,97,109,101,59,10,9,100,105,114,61,100,105,114,110,97,109"
asm ".byte 101,95,111,112,101,110,97,116,40,100,105,114,102,100,44,112,97,116,104,44,38,98,110,97,109,101,41,59,10,9,105,102"
asm ".byte 40,100,105,114,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100,105,114,59,10,9,125,10,9,114,101,116"
asm ".byte 61,115,121,109,108,105,110,107,97,116,40,116,97,114,103,101,116,44,100,105,114,44,98,110,97,109,101,41,59,10,9,99"
asm ".byte 108,111,115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101,116,59,10,125,10,105,110,116,32,114,101"
asm ".byte 97,100,108,105,110,107,97,116,108,40,105,110,116,32,100,105,114,102,100,44,99,104,97,114,32,42,112,97,116,104,44,99"
asm ".byte 104,97,114,32,42,98,117,102,44,105,110,116,32,115,105,122,101,41,10,123,10,9,105,110,116,32,100,105,114,44,114,101"
asm ".byte 116,59,10,9,99,104,97,114,32,42,98,110,97,109,101,59,10,9,100,105,114,61,100,105,114,110,97,109,101,95,111,112"
asm ".byte 101,110,97,116,40,100,105,114,102,100,44,112,97,116,104,44,38,98,110,97,109,101,41,59,10,9,105,102,40,100,105,114"
asm ".byte 60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100,105,114,59,10,9,125,10,9,114,101,116,61,114,101,97"
asm ".byte 100,108,105,110,107,97,116,40,100,105,114,44,98,110,97,109,101,44,98,117,102,44,115,105,122,101,41,59,10,9,99,108"
asm ".byte 111,115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101,116,59,10,125,10,105,110,116,32,117,110,108"
asm ".byte 105,110,107,97,116,108,40,105,110,116,32,100,105,114,102,100,44,99,104,97,114,32,42,112,97,116,104,44,105,110,116,32"
asm ".byte 102,108,97,103,115,41,10,123,10,9,105,110,116,32,100,105,114,44,114,101,116,59,10,9,99,104,97,114,32,42,98,110"
asm ".byte 97,109,101,59,10,9,100,105,114,61,100,105,114,110,97,109,101,95,111,112,101,110,97,116,40,100,105,114,102,100,44,112"
asm ".byte 97,116,104,44,38,98,110,97,109,101,41,59,10,9,105,102,40,100,105,114,60,48,41,10,9,123,10,9,9,114,101,116"
asm ".byte 117,114,110,32,100,105,114,59,10,9,125,10,9,114,101,116,61,117,110,108,105,110,107,97,116,40,100,105,114,44,98,110"
asm ".byte 97,109,101,44,102,108,97,103,115,41,59,10,9,99,108,111,115,101,40,100,105,114,41,59,10,9,114,101,116,117,114,110"
asm ".byte 32,114,101,116,59,10,125,10,105,110,116,32,114,101,110,97,109,101,97,116,108,40,105,110,116,32,100,105,114,102,100,44"
asm ".byte 99,104,97,114,32,42,112,97,116,104,44,105,110,116,32,110,101,119,100,105,114,102,100,44,99,104,97,114,32,42,110,101"
asm ".byte 119,112,97,116,104,41,10,123,10,9,105,110,116,32,100,105,114,44,110,101,119,100,105,114,44,114,101,116,59,10,9,99"
asm ".byte 104,97,114,32,42,98,110,97,109,101,44,42,110,101,119,95,98,110,97,109,101,59,10,9,100,105,114,61,100,105,114,110"
asm ".byte 97,109,101,95,111,112,101,110,97,116,40,100,105,114,102,100,44,112,97,116,104,44,38,98,110,97,109,101,41,59,10,9"
asm ".byte 105,102,40,100,105,114,60,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,100,105,114,59,10,9,125,10,9,110"
asm ".byte 101,119,100,105,114,61,100,105,114,110,97,109,101,95,111,112,101,110,97,116,40,110,101,119,100,105,114,102,100,44,110,101"
asm ".byte 119,112,97,116,104,44,38,110,101,119,95,98,110,97,109,101,41,59,10,9,105,102,40,110,101,119,100,105,114,60,48,41"
asm ".byte 10,9,123,10,9,9,99,108,111,115,101,40,100,105,114,41,59,10,9,9,114,101,116,117,114,110,32,110,101,119,100,105"
asm ".byte 114,59,10,9,125,10,9,114,101,116,61,114,101,110,97,109,101,97,116,40,100,105,114,44,98,110,97,109,101,44,110,101"
asm ".byte 119,100,105,114,44,110,101,119,95,98,110,97,109,101,41,59,10,9,99,108,111,115,101,40,100,105,114,41,59,10,9,99"
asm ".byte 108,111,115,101,40,110,101,119,100,105,114,41,59,10,9,114,101,116,117,114,110,32,114,101,116,59,10,125,10,10,35,101"
asm ".byte 110,100,105,102,10,0,0,0,48,55,48,55,48,49,48,48,48,48,48,48,49,51,48,48,48,48,56,49,65,52,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,49,65,55,67,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,115,121,115,99,97,108,108,46"
asm ".byte 99,0,0,0,35,105,102,110,100,101,102,32,95,83,89,83,67,65,76,76,95,67,95,10,35,100,101,102,105,110,101,32"
asm ".byte 95,83,89,83,67,65,76,76,95,67,95,10,35,105,110,99,108,117,100,101,32,34,101,114,114,111,114,46,99,34,10,35"
asm ".byte 100,101,102,105,110,101,32,78,85,76,76,32,40,40,118,111,105,100,32,42,41,48,41,10,35,100,101,102,105,110,101,32"
asm ".byte 65,84,95,70,68,67,87,68,32,40,45,49,48,48,41,10,35,100,101,102,105,110,101,32,65,84,95,83,89,77,76,73"
asm ".byte 78,75,95,78,79,70,79,76,76,79,87,32,48,120,49,48,48,10,35,100,101,102,105,110,101,32,65,84,95,82,69,77"
asm ".byte 79,86,69,68,73,82,32,48,120,50,48,48,10,35,100,101,102,105,110,101,32,70,95,71,69,84,70,68,32,49,10,35"
asm ".byte 100,101,102,105,110,101,32,70,95,83,69,84,70,68,32,50,10,35,100,101,102,105,110,101,32,70,95,71,69,84,70,76"
asm ".byte 32,51,10,35,100,101,102,105,110,101,32,70,95,83,69,84,70,76,32,52,10,97,115,109,32,34,46,101,110,116,114,121"
asm ".byte 34,10,97,115,109,32,34,108,101,97,32,56,40,37,114,115,112,41,44,37,114,97,120,34,10,97,115,109,32,34,112,117"
asm ".byte 115,104,32,37,114,97,120,34,10,97,115,109,32,34,112,117,115,104,113,32,56,40,37,114,115,112,41,34,10,97,115,109"
asm ".byte 32,34,99,97,108,108,32,64,109,97,105,110,34,10,97,115,109,32,34,109,111,118,32,37,114,97,120,44,37,114,100,105"
asm ".byte 34,10,97,115,109,32,34,109,111,118,32,36,50,51,49,44,37,101,97,120,34,10,97,115,109,32,34,115,121,115,99,97"
asm ".byte 108,108,34,10,108,111,110,103,32,95,95,115,121,115,99,97,108,108,40,108,111,110,103,32,110,117,109,44,108,111,110,103"
asm ".byte 32,97,49,44,108,111,110,103,32,97,50,44,108,111,110,103,32,97,51,44,108,111,110,103,32,97,52,44,108,111,110,103"
asm ".byte 32,97,53,44,108,111,110,103,32,97,54,41,59,10,97,115,109,32,34,64,95,95,115,121,115,99,97,108,108,34,10,97"
asm ".byte 115,109,32,34,112,117,115,104,32,37,114,100,105,34,10,97,115,109,32,34,112,117,115,104,32,37,114,115,105,34,10,97"
asm ".byte 115,109,32,34,112,117,115,104,32,37,114,100,120,34,10,97,115,109,32,34,112,117,115,104,32,37,114,49,48,34,10,97"
asm ".byte 115,109,32,34,112,117,115,104,32,37,114,49,49,34,10,97,115,109,32,34,112,117,115,104,32,37,114,56,34,10,97,115"
asm ".byte 109,32,34,112,117,115,104,32,37,114,57,34,10,97,115,109,32,34,109,111,118,32,54,52,40,37,114,115,112,41,44,37"
asm ".byte 114,97,120,34,10,97,115,109,32,34,109,111,118,32,55,50,40,37,114,115,112,41,44,37,114,100,105,34,10,97,115,109"
asm ".byte 32,34,109,111,118,32,56,48,40,37,114,115,112,41,44,37,114,115,105,34,10,97,115,109,32,34,109,111,118,32,56,56"
asm ".byte 40,37,114,115,112,41,44,37,114,100,120,34,10,97,115,109,32,34,109,111,118,32,57,54,40,37,114,115,112,41,44,37"
asm ".byte 114,49,48,34,10,97,115,109,32,34,109,111,118,32,49,48,52,40,37,114,115,112,41,44,37,114,56,34,10,97,115,109"
asm ".byte 32,34,109,111,118,32,49,49,50,40,37,114,115,112,41,44,37,114,57,34,10,97,115,109,32,34,115,121,115,99,97,108"
asm ".byte 108,34,10,97,115,109,32,34,112,111,112,32,37,114,57,34,10,97,115,109,32,34,112,111,112,32,37,114,56,34,10,97"
asm ".byte 115,109,32,34,112,111,112,32,37,114,49,49,34,10,97,115,109,32,34,112,111,112,32,37,114,49,48,34,10,97,115,109"
asm ".byte 32,34,112,111,112,32,37,114,100,120,34,10,97,115,109,32,34,112,111,112,32,37,114,115,105,34,10,97,115,109,32,34"
asm ".byte 112,111,112,32,37,114,100,105,34,10,97,115,109,32,34,114,101,116,34,10,35,100,101,102,105,110,101,32,115,121,115,99"
asm ".byte 97,108,108,40,110,117,109,44,97,49,44,97,50,44,97,51,44,97,52,44,97,53,44,97,54,41,32,95,95,115,121,115"
asm ".byte 99,97,108,108,40,40,108,111,110,103,41,40,110,117,109,41,44,40,108,111,110,103,41,40,97,49,41,44,40,108,111,110"
asm ".byte 103,41,40,97,50,41,44,40,108,111,110,103,41,40,97,51,41,44,40,108,111,110,103,41,40,97,52,41,44,40,108,111"
asm ".byte 110,103,41,40,97,53,41,44,40,108,111,110,103,41,40,97,54,41,41,10,35,100,101,102,105,110,101,32,118,97,108,105"
asm ".byte 100,40,115,41,32,40,40,117,110,115,105,103,110,101,100,32,108,111,110,103,41,40,40,108,111,110,103,41,40,115,41,41"
asm ".byte 60,61,48,120,102,102,102,102,102,102,102,102,102,102,102,102,102,48,48,48,41,10,35,100,101,102,105,110,101,32,114,101"
asm ".byte 97,100,40,102,100,44,98,117,102,44,115,105,122,101,41,32,115,121,115,99,97,108,108,40,48,44,102,100,44,98,117,102"
asm ".byte 44,115,105,122,101,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,119,114,105,116,101,40,102,100,44,98,117"
asm ".byte 102,44,115,105,122,101,41,32,115,121,115,99,97,108,108,40,49,44,102,100,44,98,117,102,44,115,105,122,101,44,48,44"
asm ".byte 48,44,48,41,10,35,100,101,102,105,110,101,32,111,112,101,110,40,110,97,109,101,44,102,108,97,103,115,44,109,111,100"
asm ".byte 101,41,32,115,121,115,99,97,108,108,40,50,44,110,97,109,101,44,102,108,97,103,115,44,109,111,100,101,44,48,44,48"
asm ".byte 44,48,41,10,35,100,101,102,105,110,101,32,99,108,111,115,101,40,102,100,41,32,115,121,115,99,97,108,108,40,51,44"
asm ".byte 102,100,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,116,97,116,40,112,97,116,104,44"
asm ".byte 115,116,41,32,115,121,115,99,97,108,108,40,52,44,112,97,116,104,44,115,116,44,48,44,48,44,48,44,48,41,10,35"
asm ".byte 100,101,102,105,110,101,32,102,115,116,97,116,40,102,100,44,115,116,41,32,115,121,115,99,97,108,108,40,53,44,102,100"
asm ".byte 44,115,116,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,108,115,116,97,116,40,112,97,116,104,44"
asm ".byte 115,116,41,32,115,121,115,99,97,108,108,40,54,44,112,97,116,104,44,115,116,44,48,44,48,44,48,44,48,41,10,35"
asm ".byte 100,101,102,105,110,101,32,112,111,108,108,40,112,102,100,44,110,102,100,115,44,116,105,109,101,111,117,116,41,32,115,121"
asm ".byte 115,99,97,108,108,40,55,44,112,102,100,44,110,102,100,115,44,116,105,109,101,111,117,116,44,48,44,48,44,48,41,10"
asm ".byte 35,100,101,102,105,110,101,32,108,115,101,101,107,40,102,100,44,111,102,102,44,119,104,101,110,99,101,41,32,115,121,115"
asm ".byte 99,97,108,108,40,56,44,102,100,44,111,102,102,44,119,104,101,110,99,101,44,48,44,48,44,48,41,10,35,100,101,102"
asm ".byte 105,110,101,32,109,109,97,112,40,97,100,100,114,44,115,105,122,101,44,112,114,111,116,44,102,108,97,103,115,44,102,100"
asm ".byte 44,111,102,102,41,32,40,40,118,111,105,100,32,42,41,115,121,115,99,97,108,108,40,57,44,97,100,100,114,44,115,105"
asm ".byte 122,101,44,112,114,111,116,44,102,108,97,103,115,44,102,100,44,111,102,102,41,41,10,35,100,101,102,105,110,101,32,109"
asm ".byte 117,110,109,97,112,40,97,100,100,114,44,115,105,122,101,41,32,115,121,115,99,97,108,108,40,49,49,44,97,100,100,114"
asm ".byte 44,115,105,122,101,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,98,114,107,40,97,100,100,114,41"
asm ".byte 32,40,40,118,111,105,100,32,42,41,115,121,115,99,97,108,108,40,49,50,44,97,100,100,114,44,48,44,48,44,48,44"
asm ".byte 48,44,48,41,41,10,35,100,101,102,105,110,101,32,115,105,103,112,114,111,99,109,97,115,107,40,104,111,119,44,115,101"
asm ".byte 116,44,111,108,100,115,101,116,41,32,115,121,115,99,97,108,108,40,49,52,44,104,111,119,44,115,101,116,44,111,108,100"
asm ".byte 115,101,116,44,56,44,48,44,48,41,10,35,100,101,102,105,110,101,32,105,111,99,116,108,40,102,100,44,99,109,100,44"
asm ".byte 97,114,103,41,32,115,121,115,99,97,108,108,40,49,54,44,102,100,44,99,109,100,44,97,114,103,44,48,44,48,44,48"
asm ".byte 41,10,35,100,101,102,105,110,101,32,97,99,99,101,115,115,40,112,97,116,104,44,109,111,100,101,41,32,115,121,115,99"
asm ".byte 97,108,108,40,50,49,44,112,97,116,104,44,109,111,100,101,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110"
asm ".byte 101,32,112,105,112,101,40,102,100,115,41,32,115,121,115,99,97,108,108,40,50,50,44,102,100,115,44,48,44,48,44,48"
asm ".byte 44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,104,109,103,101,116,40,107,101,121,44,115,105,122,101,44,102,108"
asm ".byte 97,103,41,32,115,121,115,99,97,108,108,40,50,57,44,107,101,121,44,115,105,122,101,44,102,108,97,103,44,48,44,48"
asm ".byte 44,48,41,10,35,100,101,102,105,110,101,32,115,104,109,97,116,40,105,100,44,97,100,100,114,44,102,108,97,103,41,32"
asm ".byte 40,118,111,105,100,32,42,41,115,121,115,99,97,108,108,40,51,48,44,105,100,44,97,100,100,114,44,102,108,97,103,44"
asm ".byte 48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,104,109,99,116,108,40,105,100,44,99,109,100,44,98,117,102"
asm ".byte 41,32,115,121,115,99,97,108,108,40,51,49,44,105,100,44,99,109,100,44,98,117,102,44,48,44,48,44,48,41,10,35"
asm ".byte 100,101,102,105,110,101,32,100,117,112,40,102,100,41,32,115,121,115,99,97,108,108,40,51,50,44,102,100,44,48,44,48"
asm ".byte 44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,100,117,112,50,40,102,100,44,110,101,119,102,100,41,32,115"
asm ".byte 121,115,99,97,108,108,40,51,51,44,102,100,44,110,101,119,102,100,44,48,44,48,44,48,44,48,41,10,35,100,101,102"
asm ".byte 105,110,101,32,112,97,117,115,101,40,41,32,115,121,115,99,97,108,108,40,51,52,44,48,44,48,44,48,44,48,44,48"
asm ".byte 44,48,41,10,35,100,101,102,105,110,101,32,110,97,110,111,115,108,101,101,112,40,114,101,113,44,114,101,109,41,32,115"
asm ".byte 121,115,99,97,108,108,40,51,53,44,114,101,113,44,114,101,109,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105"
asm ".byte 110,101,32,97,108,97,114,109,40,115,101,99,41,32,115,121,115,99,97,108,108,40,51,55,44,115,101,99,44,48,44,48"
asm ".byte 44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,103,101,116,112,105,100,40,41,32,115,121,115,99,97,108,108"
asm ".byte 40,51,57,44,48,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,111,99,107,101,116,40"
asm ".byte 102,97,109,105,108,121,44,116,121,112,101,44,112,114,111,116,41,32,115,121,115,99,97,108,108,40,52,49,44,102,97,109"
asm ".byte 105,108,121,44,116,121,112,101,44,112,114,111,116,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,99,111,110"
asm ".byte 110,101,99,116,40,102,100,44,97,100,100,114,44,115,105,122,101,41,32,115,121,115,99,97,108,108,40,52,50,44,102,100"
asm ".byte 44,97,100,100,114,44,115,105,122,101,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,97,99,99,101,112,116"
asm ".byte 40,102,100,44,97,100,100,114,44,115,105,122,101,41,32,115,121,115,99,97,108,108,40,52,51,44,102,100,44,97,100,100"
asm ".byte 114,44,115,105,122,101,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,101,110,100,116,111,40,102,100,44"
asm ".byte 98,117,102,44,108,101,110,44,102,108,97,103,115,44,97,100,100,114,44,115,105,122,101,41,32,115,121,115,99,97,108,108"
asm ".byte 40,52,52,44,102,100,44,98,117,102,44,108,101,110,44,102,108,97,103,115,44,97,100,100,114,44,115,105,122,101,41,10"
asm ".byte 35,100,101,102,105,110,101,32,114,101,99,118,102,114,111,109,40,102,100,44,98,117,102,44,108,101,110,44,102,108,97,103"
asm ".byte 115,44,97,100,100,114,44,115,105,122,101,41,32,115,121,115,99,97,108,108,40,52,53,44,102,100,44,98,117,102,44,108"
asm ".byte 101,110,44,102,108,97,103,115,44,97,100,100,114,44,115,105,122,101,41,10,35,100,101,102,105,110,101,32,115,101,110,100"
asm ".byte 109,115,103,40,102,100,44,109,115,103,44,102,108,97,103,115,41,32,115,121,115,99,97,108,108,40,52,54,44,102,100,44"
asm ".byte 109,115,103,44,102,108,97,103,115,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,114,101,99,118,109,115,103"
asm ".byte 40,102,100,44,109,115,103,44,102,108,97,103,115,41,32,115,121,115,99,97,108,108,40,52,55,44,102,100,44,109,115,103"
asm ".byte 44,102,108,97,103,115,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,98,105,110,100,40,102,100,44,97,100"
asm ".byte 100,114,44,115,105,122,101,41,32,115,121,115,99,97,108,108,40,52,57,44,102,100,44,97,100,100,114,44,115,105,122,101"
asm ".byte 44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,108,105,115,116,101,110,40,102,100,44,99,111,110,110,41,32"
asm ".byte 115,121,115,99,97,108,108,40,53,48,44,102,100,44,99,111,110,110,44,48,44,48,44,48,44,48,41,10,35,100,101,102"
asm ".byte 105,110,101,32,115,111,99,107,101,116,112,97,105,114,40,102,97,109,105,108,121,44,116,121,112,101,44,112,114,111,116,44"
asm ".byte 102,100,115,41,32,115,121,115,99,97,108,108,40,53,51,44,102,97,109,105,108,121,44,116,121,112,101,44,112,114,111,116"
asm ".byte 44,102,100,115,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,101,116,115,111,99,107,111,112,116,40,102,100,44"
asm ".byte 108,101,118,101,108,44,110,97,109,101,44,118,97,108,44,115,105,122,101,41,32,115,121,115,99,97,108,108,40,53,52,44"
asm ".byte 102,100,44,108,101,118,101,108,44,110,97,109,101,44,118,97,108,44,115,105,122,101,44,48,41,10,35,100,101,102,105,110"
asm ".byte 101,32,102,111,114,107,40,41,32,115,121,115,99,97,108,108,40,53,55,44,48,44,48,44,48,44,48,44,48,44,48,41"
asm ".byte 10,35,100,101,102,105,110,101,32,107,105,108,108,40,112,105,100,44,115,105,103,41,32,115,121,115,99,97,108,108,40,54"
asm ".byte 50,44,112,105,100,44,115,105,103,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,102,99,110,116,108"
asm ".byte 40,102,100,44,111,112,44,97,114,103,41,32,115,121,115,99,97,108,108,40,55,50,44,102,100,44,111,112,44,97,114,103"
asm ".byte 44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,102,108,111,99,107,40,102,100,44,111,112,41,32,115,121,115"
asm ".byte 99,97,108,108,40,55,51,44,102,100,44,111,112,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,102"
asm ".byte 115,121,110,99,40,102,100,41,32,115,121,115,99,97,108,108,40,55,52,44,102,100,44,48,44,48,44,48,44,48,44,48"
asm ".byte 41,10,35,100,101,102,105,110,101,32,116,114,117,110,99,97,116,101,40,112,97,116,104,44,108,101,110,41,32,115,121,115"
asm ".byte 99,97,108,108,40,55,54,44,112,97,116,104,44,108,101,110,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110"
asm ".byte 101,32,99,104,100,105,114,40,100,105,114,41,32,115,121,115,99,97,108,108,40,56,48,44,100,105,114,44,48,44,48,44"
asm ".byte 48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,102,99,104,100,105,114,40,102,100,41,32,115,121,115,99,97,108"
asm ".byte 108,40,56,49,44,102,100,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,114,101,110,97,109"
asm ".byte 101,40,110,97,109,101,44,110,101,119,110,97,109,101,41,32,115,121,115,99,97,108,108,40,56,50,44,110,97,109,101,44"
asm ".byte 110,101,119,110,97,109,101,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,109,107,100,105,114,40,112"
asm ".byte 97,116,104,44,109,111,100,101,41,32,115,121,115,99,97,108,108,40,56,51,44,112,97,116,104,44,109,111,100,101,44,48"
asm ".byte 44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,114,109,100,105,114,40,112,97,116,104,41,32,115,121,115,99"
asm ".byte 97,108,108,40,56,52,44,112,97,116,104,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,108"
asm ".byte 105,110,107,40,110,97,109,101,44,110,101,119,110,97,109,101,41,32,115,121,115,99,97,108,108,40,56,54,44,110,97,109"
asm ".byte 101,44,110,101,119,110,97,109,101,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,121,109,108,105"
asm ".byte 110,107,40,116,97,114,103,101,116,44,112,97,116,104,41,32,115,121,115,99,97,108,108,40,56,56,44,116,97,114,103,101"
asm ".byte 116,44,112,97,116,104,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,99,104,111,119,110,40,110,97"
asm ".byte 109,101,44,117,105,100,44,103,105,100,41,32,115,121,115,99,97,108,108,40,57,50,44,110,97,109,101,44,117,105,100,44"
asm ".byte 103,105,100,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,103,101,116,116,105,109,101,111,102,100,97,121,40"
asm ".byte 116,118,44,116,122,41,32,115,121,115,99,97,108,108,40,57,54,44,116,118,44,116,122,44,48,44,48,44,48,44,48,41"
asm ".byte 10,35,100,101,102,105,110,101,32,103,101,116,117,105,100,40,41,32,115,121,115,99,97,108,108,40,49,48,50,44,48,44"
asm ".byte 48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,101,116,117,105,100,40,117,105,100,41,32,115"
asm ".byte 121,115,99,97,108,108,40,49,48,53,44,117,105,100,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110"
asm ".byte 101,32,115,101,116,103,105,100,40,103,105,100,41,32,115,121,115,99,97,108,108,40,49,48,54,44,103,105,100,44,48,44"
asm ".byte 48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,101,116,112,103,105,100,40,112,105,100,44,112,103,105"
asm ".byte 100,41,32,115,121,115,99,97,108,108,40,49,48,57,44,112,105,100,44,112,103,105,100,44,48,44,48,44,48,44,48,41"
asm ".byte 10,35,100,101,102,105,110,101,32,103,101,116,112,112,105,100,40,41,32,115,121,115,99,97,108,108,40,49,49,48,44,48"
asm ".byte 44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,101,116,115,105,100,40,41,32,115,121,115"
asm ".byte 99,97,108,108,40,49,49,50,44,48,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,109,107"
asm ".byte 110,111,100,40,110,97,109,101,44,109,111,100,101,44,100,101,118,41,32,115,121,115,99,97,108,108,40,49,51,51,44,110"
asm ".byte 97,109,101,44,109,111,100,101,44,100,101,118,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,101,116,112"
asm ".byte 114,105,111,114,105,116,121,40,119,104,105,99,104,44,119,104,111,44,112,114,105,111,41,32,115,121,115,99,97,108,108,40"
asm ".byte 49,52,49,44,119,104,105,99,104,44,119,104,111,44,112,114,105,111,44,48,44,48,44,48,41,10,35,100,101,102,105,110"
asm ".byte 101,32,115,99,104,101,100,95,115,101,116,115,99,104,101,100,117,108,101,114,40,112,105,100,44,112,111,108,105,99,121,44"
asm ".byte 112,97,114,97,109,41,32,115,121,115,99,97,108,108,40,49,52,52,44,112,105,100,44,112,111,108,105,99,121,44,112,97"
asm ".byte 114,97,109,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,101,116,114,108,105,109,105,116,40,114,101,115"
asm ".byte 44,108,105,109,41,32,115,121,115,99,97,108,108,40,49,54,48,44,114,101,115,44,108,105,109,44,48,44,48,44,48,44"
asm ".byte 48,41,10,35,100,101,102,105,110,101,32,99,104,114,111,111,116,40,100,105,114,41,32,115,121,115,99,97,108,108,40,49"
asm ".byte 54,49,44,100,105,114,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,121,110,99,40,41"
asm ".byte 32,115,121,115,99,97,108,108,40,49,54,50,44,48,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110"
asm ".byte 101,32,109,111,117,110,116,40,100,101,118,44,109,112,44,116,121,112,101,44,102,108,97,103,115,44,111,112,116,41,32,115"
asm ".byte 121,115,99,97,108,108,40,49,54,53,44,100,101,118,44,109,112,44,116,121,112,101,44,102,108,97,103,115,44,111,112,116"
asm ".byte 44,48,41,10,35,100,101,102,105,110,101,32,117,109,111,117,110,116,50,40,109,112,44,102,108,97,103,115,41,32,115,121"
asm ".byte 115,99,97,108,108,40,49,54,54,44,109,112,44,102,108,97,103,115,44,48,44,48,44,48,44,48,41,10,35,100,101,102"
asm ".byte 105,110,101,32,114,101,98,111,111,116,40,109,44,109,50,44,99,109,100,44,97,114,103,41,32,115,121,115,99,97,108,108"
asm ".byte 40,49,54,57,44,109,44,109,50,44,99,109,100,44,97,114,103,44,48,44,48,41,10,35,100,101,102,105,110,101,32,100"
asm ".byte 101,108,101,116,101,95,109,111,100,117,108,101,40,110,97,109,101,44,102,108,97,103,115,41,32,115,121,115,99,97,108,108"
asm ".byte 40,49,55,54,44,110,97,109,101,44,102,108,97,103,115,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101"
asm ".byte 32,103,101,116,116,105,100,40,41,32,115,121,115,99,97,108,108,40,49,56,54,44,48,44,48,44,48,44,48,44,48,44"
asm ".byte 48,41,10,35,100,101,102,105,110,101,32,103,101,116,100,101,110,116,115,54,52,40,102,100,44,98,117,102,44,115,105,122"
asm ".byte 101,41,32,115,121,115,99,97,108,108,40,50,49,55,44,102,100,44,98,117,102,44,115,105,122,101,44,48,44,48,44,48"
asm ".byte 41,10,35,100,101,102,105,110,101,32,101,120,105,116,40,99,111,100,101,41,32,115,121,115,99,97,108,108,40,50,51,49"
asm ".byte 44,99,111,100,101,44,48,44,48,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,116,103,107,105,108,108,40"
asm ".byte 112,105,100,44,116,105,100,44,115,105,103,41,32,115,121,115,99,97,108,108,40,50,51,52,44,112,105,100,44,116,105,100"
asm ".byte 44,115,105,103,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,111,112,101,110,97,116,40,100,105,114,102,100"
asm ".byte 44,112,97,116,104,44,102,108,97,103,115,44,109,111,100,101,41,32,115,121,115,99,97,108,108,40,50,53,55,44,100,105"
asm ".byte 114,102,100,44,112,97,116,104,44,102,108,97,103,115,44,109,111,100,101,44,48,44,48,41,10,35,100,101,102,105,110,101"
asm ".byte 32,109,107,100,105,114,97,116,40,100,105,114,102,100,44,112,97,116,104,44,109,111,100,101,41,32,115,121,115,99,97,108"
asm ".byte 108,40,50,53,56,44,100,105,114,102,100,44,112,97,116,104,44,109,111,100,101,44,48,44,48,44,48,41,10,35,100,101"
asm ".byte 102,105,110,101,32,109,107,110,111,100,97,116,40,100,105,114,102,100,44,112,97,116,104,44,109,111,100,101,44,100,101,118"
asm ".byte 41,32,115,121,115,99,97,108,108,40,50,53,57,44,100,105,114,102,100,44,112,97,116,104,44,109,111,100,101,44,100,101"
asm ".byte 118,44,48,44,48,41,10,35,100,101,102,105,110,101,32,102,115,116,97,116,97,116,40,100,105,114,102,100,44,112,97,116"
asm ".byte 104,44,115,116,44,102,108,97,103,115,41,32,115,121,115,99,97,108,108,40,50,54,50,44,100,105,114,102,100,44,112,97"
asm ".byte 116,104,44,115,116,44,102,108,97,103,115,44,48,44,48,41,10,35,100,101,102,105,110,101,32,117,110,108,105,110,107,97"
asm ".byte 116,40,100,105,114,102,100,44,112,97,116,104,44,102,108,97,103,115,41,32,115,121,115,99,97,108,108,40,50,54,51,44"
asm ".byte 100,105,114,102,100,44,112,97,116,104,44,102,108,97,103,115,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32"
asm ".byte 114,101,110,97,109,101,97,116,40,100,105,114,102,100,44,112,97,116,104,44,110,101,119,100,105,114,102,100,44,110,101,119"
asm ".byte 112,97,116,104,41,32,115,121,115,99,97,108,108,40,50,54,52,44,100,105,114,102,100,44,112,97,116,104,44,110,101,119"
asm ".byte 100,105,114,102,100,44,110,101,119,112,97,116,104,44,48,44,48,41,10,35,100,101,102,105,110,101,32,115,121,109,108,105"
asm ".byte 110,107,97,116,40,116,97,114,103,101,116,44,100,105,114,102,100,44,112,97,116,104,41,32,115,121,115,99,97,108,108,40"
asm ".byte 50,54,54,44,116,97,114,103,101,116,44,100,105,114,102,100,44,112,97,116,104,44,48,44,48,44,48,41,10,35,100,101"
asm ".byte 102,105,110,101,32,114,101,97,100,108,105,110,107,97,116,40,100,105,114,102,100,44,112,97,116,104,44,98,117,102,44,115"
asm ".byte 105,122,101,41,32,115,121,115,99,97,108,108,40,50,54,55,44,100,105,114,102,100,44,112,97,116,104,44,98,117,102,44"
asm ".byte 115,105,122,101,44,48,44,48,41,10,35,100,101,102,105,110,101,32,102,99,104,109,111,100,97,116,40,100,105,114,102,100"
asm ".byte 44,112,97,116,104,44,109,111,100,101,41,32,115,121,115,99,97,108,108,40,50,54,56,44,100,105,114,102,100,44,112,97"
asm ".byte 116,104,44,109,111,100,101,44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,102,97,99,99,101,115,115,97,116"
asm ".byte 40,100,105,114,102,100,44,112,97,116,104,44,109,111,100,101,44,102,108,97,103,115,41,32,115,121,115,99,97,108,108,40"
asm ".byte 50,54,57,44,100,105,114,102,100,44,112,97,116,104,44,109,111,100,101,44,102,108,97,103,115,44,48,44,48,41,10,35"
asm ".byte 100,101,102,105,110,101,32,102,105,110,105,116,95,109,111,100,117,108,101,40,102,100,44,112,97,114,97,109,115,44,102,108"
asm ".byte 97,103,115,41,32,115,121,115,99,97,108,108,40,51,49,51,44,102,100,44,112,97,114,97,109,115,44,102,108,97,103,115"
asm ".byte 44,48,44,48,44,48,41,10,35,100,101,102,105,110,101,32,103,101,116,114,97,110,100,111,109,40,98,117,102,44,115,105"
asm ".byte 122,101,44,102,108,97,103,115,41,32,115,121,115,99,97,108,108,40,51,49,56,44,98,117,102,44,115,105,122,101,44,102"
asm ".byte 108,97,103,115,44,48,44,48,44,48,41,10,108,111,110,103,32,105,110,116,32,118,102,111,114,107,40,118,111,105,100,41"
asm ".byte 59,10,97,115,109,32,34,64,118,102,111,114,107,34,10,97,115,109,32,34,112,111,112,32,37,114,100,120,34,10,97,115"
asm ".byte 109,32,34,109,111,118,32,36,53,56,44,37,101,97,120,34,10,97,115,109,32,34,115,121,115,99,97,108,108,34,10,97"
asm ".byte 115,109,32,34,106,109,112,32,42,37,114,100,120,34,10,108,111,110,103,32,105,110,116,32,101,120,101,99,118,40,99,104"
asm ".byte 97,114,32,42,112,97,116,104,44,99,104,97,114,32,42,42,97,114,103,118,41,10,123,10,9,99,104,97,114,32,42,101"
asm ".byte 110,118,91,49,93,59,10,9,101,110,118,91,48,93,61,48,59,10,9,114,101,116,117,114,110,32,115,121,115,99,97,108"
asm ".byte 108,40,53,57,44,112,97,116,104,44,97,114,103,118,44,101,110,118,44,48,44,48,44,48,41,59,10,125,10,108,111,110"
asm ".byte 103,32,105,110,116,32,119,97,105,116,40,105,110,116,32,42,115,116,97,116,117,115,41,10,123,10,9,114,101,116,117,114"
asm ".byte 110,32,115,121,115,99,97,108,108,40,54,49,44,45,49,44,115,116,97,116,117,115,44,48,44,48,44,48,44,48,41,59"
asm ".byte 10,125,10,108,111,110,103,32,105,110,116,32,119,97,105,116,112,105,100,40,105,110,116,32,112,105,100,44,105,110,116,32"
asm ".byte 42,115,116,97,116,117,115,44,105,110,116,32,111,112,116,105,111,110,115,41,10,123,10,9,114,101,116,117,114,110,32,115"
asm ".byte 121,115,99,97,108,108,40,54,49,44,112,105,100,44,115,116,97,116,117,115,44,111,112,116,105,111,110,115,44,48,44,48"
asm ".byte 44,48,41,59,10,125,10,35,100,101,102,105,110,101,32,117,109,111,117,110,116,40,109,112,116,41,32,117,109,111,117,110"
asm ".byte 116,50,40,109,112,116,44,48,41,10,35,100,101,102,105,110,101,32,114,101,97,100,108,105,110,107,40,110,97,109,101,44"
asm ".byte 98,117,102,44,115,105,122,101,41,32,114,101,97,100,108,105,110,107,97,116,40,65,84,95,70,68,67,87,68,44,110,97"
asm ".byte 109,101,44,98,117,102,44,115,105,122,101,41,10,35,100,101,102,105,110,101,32,99,104,109,111,100,40,110,97,109,101,44"
asm ".byte 109,111,100,101,41,32,102,99,104,109,111,100,97,116,40,65,84,95,70,68,67,87,68,44,110,97,109,101,44,109,111,100"
asm ".byte 101,41,10,35,100,101,102,105,110,101,32,117,110,108,105,110,107,40,110,97,109,101,41,32,117,110,108,105,110,107,97,116"
asm ".byte 40,65,84,95,70,68,67,87,68,44,110,97,109,101,44,48,41,10,35,100,101,102,105,110,101,32,110,105,99,101,40,112"
asm ".byte 114,105,111,41,32,115,101,116,112,114,105,111,114,105,116,121,40,48,44,103,101,116,116,105,100,40,41,44,112,114,105,111"
asm ".byte 41,10,115,116,114,117,99,116,32,116,105,109,101,115,112,101,99,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111"
asm ".byte 110,103,32,115,101,99,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,110,115,101,99,59,10,125,59,10"
asm ".byte 118,111,105,100,32,115,108,101,101,112,40,117,110,115,105,103,110,101,100,32,105,110,116,32,115,101,99,44,117,110,115,105"
asm ".byte 103,110,101,100,32,105,110,116,32,117,115,101,99,41,10,123,10,9,115,116,114,117,99,116,32,116,105,109,101,115,112,101"
asm ".byte 99,32,116,59,10,9,116,46,115,101,99,61,115,101,99,59,10,9,116,46,110,115,101,99,61,117,115,101,99,42,49,48"
asm ".byte 48,48,59,10,9,110,97,110,111,115,108,101,101,112,40,38,116,44,48,41,59,10,125,10,10,35,101,110,100,105,102,10"
asm ".byte 48,55,48,55,48,49,48,48,48,48,48,48,49,52,48,48,48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,52,51,54,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,65,48,48,48,48,48,48,48,48,46,47,108,111,99,107,46,99,0,0,35,105,102,110,100,101,102,32"
asm ".byte 95,76,79,67,75,95,67,95,10,35,100,101,102,105,110,101,32,95,76,79,67,75,95,67,95,10,35,105,110,99,108,117"
asm ".byte 100,101,32,34,115,121,115,99,97,108,108,46,99,34,10,117,110,115,105,103,110,101,100,32,105,110,116,32,108,111,99,107"
asm ".byte 95,115,101,116,51,50,40,117,110,115,105,103,110,101,100,32,105,110,116,32,42,112,116,114,44,117,110,115,105,103,110,101"
asm ".byte 100,32,105,110,116,32,118,97,108,117,101,41,10,123,10,9,97,115,109,32,34,109,111,118,32,49,54,40,37,114,98,112"
asm ".byte 41,44,37,114,99,120,34,10,9,97,115,109,32,34,109,111,118,32,50,52,40,37,114,98,112,41,44,37,101,97,120,34"
asm ".byte 10,9,97,115,109,32,34,120,99,104,103,32,37,101,97,120,44,40,37,114,99,120,41,34,10,125,10,118,111,105,100,32"
asm ".byte 115,112,105,110,95,108,111,99,107,40,117,110,115,105,103,110,101,100,32,105,110,116,32,42,112,116,114,41,10,123,10,9"
asm ".byte 119,104,105,108,101,40,108,111,99,107,95,115,101,116,51,50,40,112,116,114,44,49,41,41,10,9,123,10,9,9,119,104"
asm ".byte 105,108,101,40,42,112,116,114,41,10,9,9,123,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48"
asm ".byte 102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109"
asm ".byte 32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120"
asm ".byte 57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97"
asm ".byte 115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32"
asm ".byte 48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9"
asm ".byte 9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114"
asm ".byte 100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10"
asm ".byte 9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119"
asm ".byte 111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51"
asm ".byte 34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34"
asm ".byte 46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48"
asm ".byte 102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109"
asm ".byte 32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120"
asm ".byte 57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97"
asm ".byte 115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32"
asm ".byte 48,120,57,48,102,51,34,10,9,9,9,97,115,109,32,34,46,119,111,114,100,32,48,120,57,48,102,51,34,10,9,9"
asm ".byte 125,10,9,125,10,125,10,118,111,105,100,32,115,112,105,110,95,117,110,108,111,99,107,40,117,110,115,105,103,110,101,100"
asm ".byte 32,105,110,116,32,42,112,116,114,41,10,123,10,9,42,112,116,114,61,48,59,10,125,10,117,110,115,105,103,110,101,100"
asm ".byte 32,105,110,116,32,109,117,116,101,120,95,119,97,105,116,59,10,118,111,105,100,32,109,117,116,101,120,95,108,111,99,107"
asm ".byte 40,117,110,115,105,103,110,101,100,32,105,110,116,32,42,112,116,114,41,10,123,10,9,119,104,105,108,101,40,108,111,99"
asm ".byte 107,95,115,101,116,51,50,40,112,116,114,44,49,41,41,10,9,123,10,9,9,115,121,115,99,97,108,108,40,50,48,50"
asm ".byte 44,112,116,114,44,48,44,49,44,48,44,48,44,48,41,59,10,9,125,10,125,10,118,111,105,100,32,109,117,116,101,120"
asm ".byte 95,117,110,108,111,99,107,40,117,110,115,105,103,110,101,100,32,105,110,116,32,42,112,116,114,41,10,123,10,9,42,112"
asm ".byte 116,114,61,48,59,10,9,115,121,115,99,97,108,108,40,50,48,50,44,112,116,114,44,49,44,49,44,48,44,48,44,48"
asm ".byte 41,59,10,125,10,10,10,35,101,110,100,105,102,10,0,0,48,55,48,55,48,49,48,48,48,48,48,48,49,53,48,48"
asm ".byte 48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,49,66,66,55,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47"
asm ".byte 109,97,108,108,111,99,46,99,0,0,0,0,35,105,102,110,100,101,102,32,95,77,65,76,76,79,67,95,67,95,10,35"
asm ".byte 100,101,102,105,110,101,32,95,77,65,76,76,79,67,95,67,95,10,35,105,110,99,108,117,100,101,32,34,115,121,115,99"
asm ".byte 97,108,108,46,99,34,10,35,105,110,99,108,117,100,101,32,34,108,111,99,107,46,99,34,10,35,100,101,102,105,110,101"
asm ".byte 32,77,65,76,76,79,67,95,77,65,71,73,67,32,48,120,97,99,102,51,49,101,53,51,10,35,100,101,102,105,110,101"
asm ".byte 32,77,65,76,76,79,67,95,84,65,66,76,69,78,32,54,53,53,51,55,10,117,110,115,105,103,110,101,100,32,108,111"
asm ".byte 110,103,32,105,110,116,32,95,95,109,97,108,108,111,99,95,99,111,117,110,116,95,100,101,108,59,10,115,116,114,117,99"
asm ".byte 116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,10,123,10,9,117,110,115,105,103,110,101,100,32,105,110,116,32"
asm ".byte 109,97,103,105,99,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,115,116,97,114,116,95,99,111,108,111"
asm ".byte 114,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97,114,32,101,110,100,95,99,111,108,111,114,59,10,9,117,110"
asm ".byte 115,105,103,110,101,100,32,99,104,97,114,32,99,111,108,111,114,59,10,9,117,110,115,105,103,110,101,100,32,99,104,97"
asm ".byte 114,32,117,115,101,100,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,42,98,108,111,99"
asm ".byte 107,95,108,105,110,107,115,59,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,115,105,122,101"
asm ".byte 59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,115,116,97,114,116,95,108"
asm ".byte 101,102,116,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,115,116,97,114"
asm ".byte 116,95,114,105,103,104,116,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42"
asm ".byte 115,116,97,114,116,95,112,97,114,101,110,116,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122"
asm ".byte 111,110,101,32,42,101,110,100,95,108,101,102,116,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95"
asm ".byte 122,111,110,101,32,42,101,110,100,95,114,105,103,104,116,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111"
asm ".byte 99,95,122,111,110,101,32,42,101,110,100,95,112,97,114,101,110,116,59,10,9,115,116,114,117,99,116,32,95,95,109,97"
asm ".byte 108,108,111,99,95,122,111,110,101,32,42,108,101,102,116,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111"
asm ".byte 99,95,122,111,110,101,32,42,114,105,103,104,116,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95"
asm ".byte 122,111,110,101,32,42,112,97,114,101,110,116,59,10,125,59,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95"
asm ".byte 84,89,80,69,32,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,10,35,100,101,102,105,110"
asm ".byte 101,32,82,66,84,82,69,69,95,67,77,80,40,110,49,44,110,50,41,32,40,40,110,49,41,45,62,115,105,122,101,62"
asm ".byte 40,110,50,41,45,62,115,105,122,101,124,124,40,110,49,41,45,62,115,105,122,101,61,61,40,110,50,41,45,62,115,105"
asm ".byte 122,101,38,38,40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,41,40,110,49,41,62,40,117,110,115"
asm ".byte 105,103,110,101,100,32,108,111,110,103,32,105,110,116,41,40,110,50,41,41,10,35,100,101,102,105,110,101,32,82,66,84"
asm ".byte 82,69,69,95,76,69,70,84,32,108,101,102,116,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,82,73,71"
asm ".byte 72,84,32,114,105,103,104,116,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82,69,78,84,32,112"
asm ".byte 97,114,101,110,116,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,67,79,76,79,82,32,99,111,108,111,114"
asm ".byte 10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,73,78,83,69,82,84,32,95,95,109,97,108,108,111,99,95"
asm ".byte 122,111,110,101,95,115,105,122,101,95,97,100,100,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,68,69,76"
asm ".byte 69,84,69,32,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,105,122,101,95,100,101,108,10,35,105,110,99,108"
asm ".byte 117,100,101,32,34,116,101,109,112,108,97,116,101,115,47,114,98,116,114,101,101,46,99,34,10,35,100,101,102,105,110,101"
asm ".byte 32,82,66,84,82,69,69,95,84,89,80,69,32,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110"
asm ".byte 101,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,67,77,80,40,110,49,44,110,50,41,32,40,40,117,110"
asm ".byte 115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,41,40,110,49,41,62,40,117,110,115,105,103,110,101,100,32,108"
asm ".byte 111,110,103,32,105,110,116,41,40,110,50,41,41,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,76,69,70"
asm ".byte 84,32,115,116,97,114,116,95,108,101,102,116,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,82,73,71,72"
asm ".byte 84,32,115,116,97,114,116,95,114,105,103,104,116,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,80,65,82"
asm ".byte 69,78,84,32,115,116,97,114,116,95,112,97,114,101,110,116,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95"
asm ".byte 67,79,76,79,82,32,115,116,97,114,116,95,99,111,108,111,114,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69"
asm ".byte 95,73,78,83,69,82,84,32,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,116,97,114,116,95,97,100,100,10"
asm ".byte 35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,68,69,76,69,84,69,32,95,95,109,97,108,108,111,99,95,122"
asm ".byte 111,110,101,95,115,116,97,114,116,95,100,101,108,10,35,105,110,99,108,117,100,101,32,34,116,101,109,112,108,97,116,101"
asm ".byte 115,47,114,98,116,114,101,101,46,99,34,10,35,100,101,102,105,110,101,32,82,66,84,82,69,69,95,84,89,80,69,32"
asm ".byte 115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,10,35,100,101,102,105,110,101,32,82,66,84"
asm ".byte 82,69,69,95,67,77,80,40,110,49,44,110,50,41,32,40,40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105"
asm ".byte 110,116,41,40,110,49,41,43,40,110,49,41,45,62,115,105,122,101,62,40,117,110,115,105,103,110,101,100,32,108,111,110"
asm ".byte 103,32,105,110,116,41,40,110,50,41,43,40,110,50,41,45,62,115,105,122,101,41,10,35,100,101,102,105,110,101,32,82"
asm ".byte 66,84,82,69,69,95,76,69,70,84,32,101,110,100,95,108,101,102,116,10,35,100,101,102,105,110,101,32,82,66,84,82"
asm ".byte 69,69,95,82,73,71,72,84,32,101,110,100,95,114,105,103,104,116,10,35,100,101,102,105,110,101,32,82,66,84,82,69"
asm ".byte 69,95,80,65,82,69,78,84,32,101,110,100,95,112,97,114,101,110,116,10,35,100,101,102,105,110,101,32,82,66,84,82"
asm ".byte 69,69,95,67,79,76,79,82,32,101,110,100,95,99,111,108,111,114,10,35,100,101,102,105,110,101,32,82,66,84,82,69"
asm ".byte 69,95,73,78,83,69,82,84,32,95,95,109,97,108,108,111,99,95,122,111,110,101,95,101,110,100,95,97,100,100,10,35"
asm ".byte 100,101,102,105,110,101,32,82,66,84,82,69,69,95,68,69,76,69,84,69,32,95,95,109,97,108,108,111,99,95,122,111"
asm ".byte 110,101,95,101,110,100,95,100,101,108,10,35,105,110,99,108,117,100,101,32,34,116,101,109,112,108,97,116,101,115,47,114"
asm ".byte 98,116,114,101,101,46,99,34,10,99,104,97,114,32,42,95,95,99,117,114,114,101,110,116,95,98,114,107,59,10,117,110"
asm ".byte 115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,95,95,104,101,97,112,95,115,105,122,101,59,10,118,111,105"
asm ".byte 100,32,42,95,95,115,101,116,95,104,101,97,112,95,115,105,122,101,40,117,110,115,105,103,110,101,100,32,108,111,110,103"
asm ".byte 32,105,110,116,32,115,105,122,101,41,10,123,10,9,99,104,97,114,32,42,110,101,119,95,98,114,107,44,42,111,108,100"
asm ".byte 95,98,114,107,59,10,9,105,102,40,95,95,99,117,114,114,101,110,116,95,98,114,107,61,61,48,41,10,9,123,10,9"
asm ".byte 9,95,95,99,117,114,114,101,110,116,95,98,114,107,61,98,114,107,40,48,41,59,10,9,125,10,9,111,108,100,95,98"
asm ".byte 114,107,61,95,95,99,117,114,114,101,110,116,95,98,114,107,43,95,95,104,101,97,112,95,115,105,122,101,59,10,9,110"
asm ".byte 101,119,95,98,114,107,61,98,114,107,40,95,95,99,117,114,114,101,110,116,95,98,114,107,43,115,105,122,101,41,59,10"
asm ".byte 9,105,102,40,110,101,119,95,98,114,107,61,61,111,108,100,95,98,114,107,38,38,115,105,122,101,33,61,95,95,104,101"
asm ".byte 97,112,95,115,105,122,101,41,10,9,123,10,9,9,114,101,116,117,114,110,32,48,59,10,9,125,10,9,95,95,104,101"
asm ".byte 97,112,95,115,105,122,101,61,115,105,122,101,59,10,9,114,101,116,117,114,110,32,111,108,100,95,98,114,107,59,10,125"
asm ".byte 10,10,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,95,95,109,97,108,108,111,99"
asm ".byte 95,115,116,97,114,116,95,116,97,98,91,77,65,76,76,79,67,95,84,65,66,76,69,78,93,44,42,95,95,109,97,108"
asm ".byte 108,111,99,95,101,110,100,95,116,97,98,91,77,65,76,76,79,67,95,84,65,66,76,69,78,93,44,42,95,95,109,97"
asm ".byte 108,108,111,99,95,122,111,110,101,95,114,111,111,116,59,10,118,111,105,100,32,95,95,109,97,108,108,111,99,95,122,111"
asm ".byte 110,101,95,115,116,97,114,116,95,116,97,98,95,97,100,100,40,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99"
asm ".byte 95,122,111,110,101,32,42,110,111,100,101,41,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111"
asm ".byte 110,103,32,105,110,116,32,97,100,100,114,59,10,9,105,110,116,32,104,97,115,104,59,10,9,97,100,100,114,61,40,117"
asm ".byte 110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,41,110,111,100,101,59,10,9,104,97,115"
asm ".byte 104,61,40,97,100,100,114,62,62,49,54,124,97,100,100,114,60,60,52,56,41,37,77,65,76,76,79,67,95,84,65,66"
asm ".byte 76,69,78,59,10,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,116,97,114,116,95,97,100,100,40,95,95"
asm ".byte 109,97,108,108,111,99,95,115,116,97,114,116,95,116,97,98,43,104,97,115,104,44,110,111,100,101,41,59,10,125,10,118"
asm ".byte 111,105,100,32,95,95,109,97,108,108,111,99,95,122,111,110,101,95,101,110,100,95,116,97,98,95,97,100,100,40,115,116"
asm ".byte 114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,110,111,100,101,41,10,123,10,9,117,110,115"
asm ".byte 105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,32,97,100,100,114,59,10,9,105,110,116,32,104"
asm ".byte 97,115,104,59,10,9,97,100,100,114,61,40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105"
asm ".byte 110,116,41,110,111,100,101,43,110,111,100,101,45,62,115,105,122,101,59,10,9,104,97,115,104,61,40,97,100,100,114,62"
asm ".byte 62,49,54,124,97,100,100,114,60,60,52,56,41,37,77,65,76,76,79,67,95,84,65,66,76,69,78,59,10,9,95,95"
asm ".byte 109,97,108,108,111,99,95,122,111,110,101,95,101,110,100,95,97,100,100,40,95,95,109,97,108,108,111,99,95,101,110,100"
asm ".byte 95,116,97,98,43,104,97,115,104,44,110,111,100,101,41,59,10,125,10,118,111,105,100,32,95,95,109,97,108,108,111,99"
asm ".byte 95,122,111,110,101,95,115,116,97,114,116,95,116,97,98,95,100,101,108,40,115,116,114,117,99,116,32,95,95,109,97,108"
asm ".byte 108,111,99,95,122,111,110,101,32,42,112,116,114,41,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32"
asm ".byte 108,111,110,103,32,105,110,116,32,97,100,100,114,59,10,9,105,110,116,32,104,97,115,104,59,10,9,97,100,100,114,61"
asm ".byte 40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,41,112,116,114,59,10,9,104,97"
asm ".byte 115,104,61,40,97,100,100,114,62,62,49,54,124,97,100,100,114,60,60,52,56,41,37,77,65,76,76,79,67,95,84,65"
asm ".byte 66,76,69,78,59,10,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,116,97,114,116,95,100,101,108,40,95"
asm ".byte 95,109,97,108,108,111,99,95,115,116,97,114,116,95,116,97,98,43,104,97,115,104,44,112,116,114,41,59,10,125,10,118"
asm ".byte 111,105,100,32,95,95,109,97,108,108,111,99,95,122,111,110,101,95,101,110,100,95,116,97,98,95,100,101,108,40,115,116"
asm ".byte 114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,112,116,114,41,10,123,10,9,117,110,115,105"
asm ".byte 103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,32,97,100,100,114,59,10,9,105,110,116,32,104,97"
asm ".byte 115,104,59,10,9,97,100,100,114,61,40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110"
asm ".byte 116,41,112,116,114,43,112,116,114,45,62,115,105,122,101,59,10,9,104,97,115,104,61,40,97,100,100,114,62,62,49,54"
asm ".byte 124,97,100,100,114,60,60,52,56,41,37,77,65,76,76,79,67,95,84,65,66,76,69,78,59,10,9,95,95,109,97,108"
asm ".byte 108,111,99,95,122,111,110,101,95,101,110,100,95,100,101,108,40,95,95,109,97,108,108,111,99,95,101,110,100,95,116,97"
asm ".byte 98,43,104,97,115,104,44,112,116,114,41,59,10,125,10,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122"
asm ".byte 111,110,101,32,42,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,116,97,114,116,95,116,97,98,95,102,105,110"
asm ".byte 100,40,118,111,105,100,32,42,112,116,114,41,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111"
asm ".byte 110,103,32,105,110,116,32,97,100,100,114,59,10,9,105,110,116,32,104,97,115,104,59,10,9,115,116,114,117,99,116,32"
asm ".byte 95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,110,111,100,101,59,10,9,97,100,100,114,61,40,117,110,115,105"
asm ".byte 103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,41,112,116,114,59,10,9,104,97,115,104,61,40,97"
asm ".byte 100,100,114,62,62,49,54,124,97,100,100,114,60,60,52,56,41,37,77,65,76,76,79,67,95,84,65,66,76,69,78,59"
asm ".byte 10,9,110,111,100,101,61,95,95,109,97,108,108,111,99,95,115,116,97,114,116,95,116,97,98,91,104,97,115,104,93,59"
asm ".byte 10,9,119,104,105,108,101,40,110,111,100,101,38,38,40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110"
asm ".byte 103,32,105,110,116,41,110,111,100,101,33,61,97,100,100,114,41,10,9,123,10,9,9,105,102,40,40,117,110,115,105,103"
asm ".byte 110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,41,110,111,100,101,62,97,100,100,114,41,10,9,9,123"
asm ".byte 10,9,9,9,110,111,100,101,61,110,111,100,101,45,62,115,116,97,114,116,95,108,101,102,116,59,10,9,9,125,10,9"
asm ".byte 9,101,108,115,101,10,9,9,123,10,9,9,9,110,111,100,101,61,110,111,100,101,45,62,115,116,97,114,116,95,114,105"
asm ".byte 103,104,116,59,10,9,9,125,10,9,125,10,9,114,101,116,117,114,110,32,110,111,100,101,59,10,125,10,115,116,114,117"
asm ".byte 99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,95,95,109,97,108,108,111,99,95,122,111,110,101,95"
asm ".byte 101,110,100,95,116,97,98,95,102,105,110,100,40,118,111,105,100,32,42,112,116,114,41,10,123,10,9,117,110,115,105,103"
asm ".byte 110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,32,97,100,100,114,59,10,9,105,110,116,32,104,97,115"
asm ".byte 104,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,110,111,100,101,59,10"
asm ".byte 9,97,100,100,114,61,40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,41,112,116"
asm ".byte 114,59,10,9,104,97,115,104,61,40,97,100,100,114,62,62,49,54,124,97,100,100,114,60,60,52,56,41,37,77,65,76"
asm ".byte 76,79,67,95,84,65,66,76,69,78,59,10,9,110,111,100,101,61,95,95,109,97,108,108,111,99,95,101,110,100,95,116"
asm ".byte 97,98,91,104,97,115,104,93,59,10,9,119,104,105,108,101,40,110,111,100,101,38,38,40,117,110,115,105,103,110,101,100"
asm ".byte 32,108,111,110,103,32,108,111,110,103,32,105,110,116,41,110,111,100,101,43,110,111,100,101,45,62,115,105,122,101,33,61"
asm ".byte 97,100,100,114,41,10,9,123,10,9,9,105,102,40,40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110"
asm ".byte 103,32,105,110,116,41,110,111,100,101,43,110,111,100,101,45,62,115,105,122,101,62,97,100,100,114,41,10,9,9,123,10"
asm ".byte 9,9,9,110,111,100,101,61,110,111,100,101,45,62,101,110,100,95,108,101,102,116,59,10,9,9,125,10,9,9,101,108"
asm ".byte 115,101,10,9,9,123,10,9,9,9,110,111,100,101,61,110,111,100,101,45,62,101,110,100,95,114,105,103,104,116,59,10"
asm ".byte 9,9,125,10,9,125,10,9,114,101,116,117,114,110,32,110,111,100,101,59,10,125,10,115,116,114,117,99,116,32,95,95"
asm ".byte 109,97,108,108,111,99,95,122,111,110,101,32,42,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,105,122,101,95"
asm ".byte 102,105,110,100,40,117,110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,32,115,105,122,101"
asm ".byte 41,10,123,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,110,111,100,101,44"
asm ".byte 42,112,59,10,9,110,111,100,101,61,95,95,109,97,108,108,111,99,95,122,111,110,101,95,114,111,111,116,59,10,9,112"
asm ".byte 61,48,59,10,9,119,104,105,108,101,40,110,111,100,101,41,10,9,123,10,9,9,105,102,40,110,111,100,101,45,62,115"
asm ".byte 105,122,101,62,61,115,105,122,101,41,10,9,9,123,10,9,9,9,112,61,110,111,100,101,59,10,9,9,9,110,111,100"
asm ".byte 101,61,110,111,100,101,45,62,108,101,102,116,59,10,9,9,125,10,9,9,101,108,115,101,10,9,9,123,10,9,9,9"
asm ".byte 110,111,100,101,61,110,111,100,101,45,62,114,105,103,104,116,59,10,9,9,125,10,9,125,10,9,114,101,116,117,114,110"
asm ".byte 32,112,59,10,125,10,118,111,105,100,32,95,95,109,97,108,108,111,99,95,101,114,114,111,114,40,118,111,105,100,41,10"
asm ".byte 123,10,9,119,114,105,116,101,40,50,44,34,105,110,118,97,108,105,100,32,112,111,105,110,116,101,114,32,111,114,32,99"
asm ".byte 111,114,114,117,112,116,105,111,110,32,100,101,116,101,99,116,101,100,46,92,110,34,44,52,48,41,59,10,9,119,104,105"
asm ".byte 108,101,40,49,41,10,9,123,10,9,9,97,115,109,32,34,105,110,116,51,34,10,9,125,10,125,10,118,111,105,100,32"
asm ".byte 95,95,109,97,108,108,111,99,95,122,111,110,101,95,97,100,100,40,115,116,114,117,99,116,32,95,95,109,97,108,108,111"
asm ".byte 99,95,122,111,110,101,32,42,110,111,100,101,41,10,123,10,9,105,102,40,110,111,100,101,45,62,109,97,103,105,99,33"
asm ".byte 61,77,65,76,76,79,67,95,77,65,71,73,67,41,10,9,123,10,9,9,95,95,109,97,108,108,111,99,95,101,114,114"
asm ".byte 111,114,40,41,59,10,9,125,10,9,110,111,100,101,45,62,117,115,101,100,61,48,59,10,9,95,95,109,97,108,108,111"
asm ".byte 99,95,122,111,110,101,95,115,105,122,101,95,97,100,100,40,38,95,95,109,97,108,108,111,99,95,122,111,110,101,95,114"
asm ".byte 111,111,116,44,110,111,100,101,41,59,10,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,116,97,114,116,95"
asm ".byte 116,97,98,95,97,100,100,40,110,111,100,101,41,59,10,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,101,110"
asm ".byte 100,95,116,97,98,95,97,100,100,40,110,111,100,101,41,59,10,125,10,118,111,105,100,32,95,95,109,97,108,108,111,99"
asm ".byte 95,122,111,110,101,95,100,101,108,40,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42"
asm ".byte 110,111,100,101,41,10,123,10,9,105,102,40,110,111,100,101,45,62,109,97,103,105,99,33,61,77,65,76,76,79,67,95"
asm ".byte 77,65,71,73,67,41,10,9,123,10,9,9,95,95,109,97,108,108,111,99,95,101,114,114,111,114,40,41,59,10,9,125"
asm ".byte 10,9,110,111,100,101,45,62,117,115,101,100,61,48,59,10,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115"
asm ".byte 105,122,101,95,100,101,108,40,38,95,95,109,97,108,108,111,99,95,122,111,110,101,95,114,111,111,116,44,110,111,100,101"
asm ".byte 41,59,10,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,116,97,114,116,95,116,97,98,95,100,101,108,40"
asm ".byte 110,111,100,101,41,59,10,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,101,110,100,95,116,97,98,95,100,101"
asm ".byte 108,40,110,111,100,101,41,59,10,125,10,118,111,105,100,32,42,109,97,108,108,111,99,95,110,111,108,111,99,107,40,117"
asm ".byte 110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,32,115,105,122,101,41,10,123,10,9,117"
asm ".byte 110,115,105,103,110,101,100,32,108,111,110,103,32,108,111,110,103,32,105,110,116,32,115,105,122,101,49,44,115,105,122,101"
asm ".byte 50,59,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,122,111,110,101,44,42"
asm ".byte 110,101,119,95,122,111,110,101,59,10,9,105,110,116,32,104,97,115,104,59,10,9,118,111,105,100,32,42,114,101,116,59"
asm ".byte 10,9,105,102,40,115,105,122,101,61,61,48,41,10,9,123,10,9,9,114,101,116,117,114,110,32,48,59,10,9,125,10"
asm ".byte 9,115,105,122,101,49,61,40,40,115,105,122,101,45,49,62,62,52,41,43,49,60,60,52,41,43,49,50,56,59,10,10"
asm ".byte 9,122,111,110,101,61,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,105,122,101,95,102,105,110,100,40,115,105"
asm ".byte 122,101,49,41,59,10,9,105,102,40,122,111,110,101,61,61,48,41,10,9,123,10,9,9,105,102,40,115,105,122,101,49"
asm ".byte 60,48,120,56,48,48,48,41,10,9,9,123,10,9,9,9,115,105,122,101,50,61,48,120,50,48,48,48,48,48,59,10"
asm ".byte 9,9,125,10,9,9,101,108,115,101,32,105,102,40,115,105,122,101,49,60,48,120,52,48,48,48,48,41,10,9,9,123"
asm ".byte 10,9,9,9,115,105,122,101,50,61,48,120,49,48,48,48,48,48,48,59,10,9,9,125,10,9,9,101,108,115,101,10"
asm ".byte 9,9,123,10,9,9,9,115,105,122,101,50,61,115,105,122,101,49,42,56,59,10,9,9,125,10,9,9,115,105,122,101"
asm ".byte 50,61,40,115,105,122,101,50,45,49,62,62,49,50,41,43,49,60,60,49,50,59,10,9,9,105,102,40,33,40,122,111"
asm ".byte 110,101,61,95,95,115,101,116,95,104,101,97,112,95,115,105,122,101,40,95,95,104,101,97,112,95,115,105,122,101,43,115"
asm ".byte 105,122,101,50,41,41,41,10,9,9,123,10,9,9,9,115,105,122,101,50,61,115,105,122,101,49,59,10,9,9,9,115"
asm ".byte 105,122,101,50,61,40,115,105,122,101,50,45,49,62,62,49,50,41,43,49,60,60,49,50,59,10,9,9,9,105,102,40"
asm ".byte 33,40,122,111,110,101,61,95,95,115,101,116,95,104,101,97,112,95,115,105,122,101,40,95,95,104,101,97,112,95,115,105"
asm ".byte 122,101,43,115,105,122,101,50,41,41,41,10,9,9,9,123,10,9,9,9,9,114,101,116,117,114,110,32,48,59,10,9"
asm ".byte 9,9,125,10,9,9,125,10,9,9,122,111,110,101,45,62,115,105,122,101,61,115,105,122,101,50,59,10,9,9,122,111"
asm ".byte 110,101,45,62,109,97,103,105,99,61,77,65,76,76,79,67,95,77,65,71,73,67,59,10,9,125,10,9,101,108,115,101"
asm ".byte 10,9,123,10,9,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,100,101,108,40,122,111,110,101,41,59,10,9"
asm ".byte 125,10,9,114,101,116,61,40,99,104,97,114,32,42,41,122,111,110,101,43,51,50,59,10,9,105,102,40,115,105,122,101"
asm ".byte 49,62,122,111,110,101,45,62,115,105,122,101,41,10,9,123,10,9,9,95,95,109,97,108,108,111,99,95,101,114,114,111"
asm ".byte 114,40,41,59,10,9,125,10,9,105,102,40,115,105,122,101,49,43,51,56,52,60,122,111,110,101,45,62,115,105,122,101"
asm ".byte 41,10,9,123,10,9,9,110,101,119,95,122,111,110,101,61,40,118,111,105,100,32,42,41,40,40,99,104,97,114,32,42"
asm ".byte 41,122,111,110,101,43,115,105,122,101,49,41,59,10,9,9,110,101,119,95,122,111,110,101,45,62,109,97,103,105,99,61"
asm ".byte 77,65,76,76,79,67,95,77,65,71,73,67,59,10,9,9,110,101,119,95,122,111,110,101,45,62,115,105,122,101,61,122"
asm ".byte 111,110,101,45,62,115,105,122,101,45,115,105,122,101,49,59,10,9,9,95,95,109,97,108,108,111,99,95,122,111,110,101"
asm ".byte 95,97,100,100,40,110,101,119,95,122,111,110,101,41,59,10,9,9,122,111,110,101,45,62,115,105,122,101,61,115,105,122"
asm ".byte 101,49,59,10,9,125,10,9,122,111,110,101,45,62,117,115,101,100,61,49,59,10,9,114,101,116,117,114,110,32,114,101"
asm ".byte 116,59,10,125,10,118,111,105,100,32,95,102,114,101,101,40,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95"
asm ".byte 122,111,110,101,32,42,122,111,110,101,41,10,123,10,9,115,116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122"
asm ".byte 111,110,101,32,42,115,116,97,114,116,44,42,101,110,100,59,10,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95"
asm ".byte 97,100,100,40,122,111,110,101,41,59,10,9,105,102,40,115,116,97,114,116,61,95,95,109,97,108,108,111,99,95,122,111"
asm ".byte 110,101,95,101,110,100,95,116,97,98,95,102,105,110,100,40,122,111,110,101,41,41,10,9,123,10,9,9,95,95,109,97"
asm ".byte 108,108,111,99,95,122,111,110,101,95,100,101,108,40,122,111,110,101,41,59,10,9,9,95,95,109,97,108,108,111,99,95"
asm ".byte 122,111,110,101,95,100,101,108,40,115,116,97,114,116,41,59,10,9,9,115,116,97,114,116,45,62,115,105,122,101,43,61"
asm ".byte 122,111,110,101,45,62,115,105,122,101,59,10,9,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,97,100,100,40"
asm ".byte 115,116,97,114,116,41,59,10,9,9,122,111,110,101,61,115,116,97,114,116,59,10,9,125,10,9,105,102,40,101,110,100"
asm ".byte 61,95,95,109,97,108,108,111,99,95,122,111,110,101,95,115,116,97,114,116,95,116,97,98,95,102,105,110,100,40,40,99"
asm ".byte 104,97,114,32,42,41,122,111,110,101,43,122,111,110,101,45,62,115,105,122,101,41,41,10,9,123,10,9,9,95,95,109"
asm ".byte 97,108,108,111,99,95,122,111,110,101,95,100,101,108,40,122,111,110,101,41,59,10,9,9,95,95,109,97,108,108,111,99"
asm ".byte 95,122,111,110,101,95,100,101,108,40,101,110,100,41,59,10,9,9,122,111,110,101,45,62,115,105,122,101,43,61,101,110"
asm ".byte 100,45,62,115,105,122,101,59,10,9,9,95,95,109,97,108,108,111,99,95,122,111,110,101,95,97,100,100,40,122,111,110"
asm ".byte 101,41,59,10,9,125,10,9,105,102,40,40,99,104,97,114,32,42,41,122,111,110,101,43,122,111,110,101,45,62,115,105"
asm ".byte 122,101,61,61,95,95,99,117,114,114,101,110,116,95,98,114,107,43,95,95,104,101,97,112,95,115,105,122,101,38,38,122"
asm ".byte 111,110,101,45,62,115,105,122,101,62,61,49,54,51,56,52,41,10,9,123,10,9,9,95,95,109,97,108,108,111,99,95"
asm ".byte 122,111,110,101,95,100,101,108,40,122,111,110,101,41,59,10,9,9,95,95,115,101,116,95,104,101,97,112,95,115,105,122"
asm ".byte 101,40,95,95,104,101,97,112,95,115,105,122,101,45,122,111,110,101,45,62,115,105,122,101,41,59,10,9,125,10,125,10"
asm ".byte 118,111,105,100,32,102,114,101,101,95,110,111,108,111,99,107,40,118,111,105,100,32,42,112,116,114,41,10,123,10,9,115"
asm ".byte 116,114,117,99,116,32,95,95,109,97,108,108,111,99,95,122,111,110,101,32,42,122,111,110,101,59,10,9,105,102,40,33"
asm ".byte 112,116,114,41,10,9,123,10,9,9,114,101,116,117,114,110,59,10,9,125,10,9,122,111,110,101,61,40,118,111,105,100"
asm ".byte 32,42,41,40,40,99,104,97,114,32,42,41,112,116,114,45,51,50,41,59,10,9,105,102,40,122,111,110,101,45,62,117"
asm ".byte 115,101,100,33,61,49,41,10,9,123,10,9,9,95,95,109,97,108,108,111,99,95,101,114,114,111,114,40,41,59,10,9"
asm ".byte 125,10,9,95,102,114,101,101,40,122,111,110,101,41,59,10,125,10,117,110,115,105,103,110,101,100,32,105,110,116,32,95"
asm ".byte 95,109,97,108,108,111,99,95,109,117,116,101,120,59,10,118,111,105,100,32,42,109,97,108,108,111,99,40,117,110,115,105"
asm ".byte 103,110,101,100,32,108,111,110,103,32,105,110,116,32,115,105,122,101,41,10,123,10,9,118,111,105,100,32,42,112,116,114"
asm ".byte 59,10,9,109,117,116,101,120,95,108,111,99,107,40,38,95,95,109,97,108,108,111,99,95,109,117,116,101,120,41,59,10"
asm ".byte 9,112,116,114,61,109,97,108,108,111,99,95,110,111,108,111,99,107,40,115,105,122,101,41,59,10,9,109,117,116,101,120"
asm ".byte 95,117,110,108,111,99,107,40,38,95,95,109,97,108,108,111,99,95,109,117,116,101,120,41,59,10,9,114,101,116,117,114"
asm ".byte 110,32,112,116,114,59,10,125,10,118,111,105,100,32,102,114,101,101,40,118,111,105,100,32,42,112,116,114,41,10,123,10"
asm ".byte 9,109,117,116,101,120,95,108,111,99,107,40,38,95,95,109,97,108,108,111,99,95,109,117,116,101,120,41,59,10,9,102"
asm ".byte 114,101,101,95,110,111,108,111,99,107,40,112,116,114,41,59,10,9,109,117,116,101,120,95,117,110,108,111,99,107,40,38"
asm ".byte 95,95,109,97,108,108,111,99,95,109,117,116,101,120,41,59,10,125,10,35,117,110,100,101,102,32,77,65,76,76,79,67"
asm ".byte 95,84,65,66,76,69,78,10,35,117,110,100,101,102,32,77,65,76,76,79,67,95,77,65,71,73,67,10,35,101,110,100"
asm ".byte 105,102,10,0,48,55,48,55,48,49,48,48,48,48,48,48,49,54,48,48,48,48,56,49,65,52,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,50"
asm ".byte 50,68,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,46,47,105,102,111,114,109,97,116,46,99,0,0,0"
asm ".byte 35,105,102,110,100,101,102,32,95,73,70,79,82,77,65,84,95,67,95,10,35,100,101,102,105,110,101,32,95,73,70,79"
asm ".byte 82,77,65,84,95,67,95,10,35,105,110,99,108,117,100,101,32,34,109,101,109,46,99,34,10,118,111,105,100,32,115,112"
asm ".byte 114,105,110,116,105,40,99,104,97,114,32,42,115,116,114,44,117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110"
asm ".byte 116,32,97,44,105,110,116,32,100,105,103,105,116,115,41,10,123,10,9,117,110,115,105,103,110,101,100,32,108,111,110,103"
asm ".byte 32,105,110,116,32,110,59,10,9,105,110,116,32,100,44,108,44,115,108,59,10,9,99,104,97,114,32,98,117,102,91,50"
asm ".byte 48,93,59,10,9,110,61,49,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,59,10,9,100,61"
asm ".byte 50,48,59,10,9,119,104,105,108,101,40,110,62,97,38,38,100,62,100,105,103,105,116,115,41,10,9,123,10,9,9,110"
asm ".byte 47,61,49,48,59,10,9,9,45,45,100,59,10,9,125,10,9,108,61,48,59,10,9,119,104,105,108,101,40,110,41,10"
asm ".byte 9,123,10,9,9,98,117,102,91,108,93,61,97,47,110,43,39,48,39,59,10,9,9,97,37,61,110,59,10,9,9,110"
asm ".byte 47,61,49,48,59,10,9,9,43,43,108,59,10,9,125,10,9,115,108,61,115,116,114,108,101,110,40,115,116,114,41,59"
asm ".byte 10,9,109,101,109,99,112,121,40,115,116,114,43,115,108,44,98,117,102,44,108,41,59,10,9,115,116,114,91,115,108,43"
asm ".byte 108,93,61,48,59,10,125,10,99,104,97,114,32,42,115,105,110,112,117,116,105,40,99,104,97,114,32,42,115,116,114,44"
asm ".byte 117,110,115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,42,114,101,115,117,108,116,41,10,123,10,9,117,110"
asm ".byte 115,105,103,110,101,100,32,108,111,110,103,32,105,110,116,32,114,101,116,59,10,9,99,104,97,114,32,99,59,10,9,114"
asm ".byte 101,116,61,48,59,10,9,119,104,105,108,101,40,40,99,61,42,115,116,114,41,62,61,39,48,39,38,38,99,60,61,39"
asm ".byte 57,39,41,10,9,123,10,9,9,114,101,116,61,114,101,116,42,49,48,43,40,99,45,39,48,39,41,59,10,9,9,43"
asm ".byte 43,115,116,114,59,10,9,125,10,9,42,114,101,115,117,108,116,61,114,101,116,59,10,9,114,101,116,117,114,110,32,115"
asm ".byte 116,114,59,10,125,10,35,101,110,100,105,102,10,0,0,0,48,55,48,55,48,49,48,48,48,48,48,48,49,55,48,48"
asm ".byte 48,48,56,49,65,52,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,49,66,65,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,65,48,48,48,48,48,48,48,48,46,47"
asm ".byte 112,111,108,108,46,99,0,0,35,105,102,110,100,101,102,32,95,80,79,76,76,95,67,95,10,35,100,101,102,105,110,101"
asm ".byte 32,95,80,79,76,76,95,67,95,10,115,116,114,117,99,116,32,112,111,108,108,102,100,10,123,10,9,105,110,116,32,102"
asm ".byte 100,59,10,9,117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,105,110,116,32,101,118,101,110,116,115,59,10,9"
asm ".byte 117,110,115,105,103,110,101,100,32,115,104,111,114,116,32,105,110,116,32,114,101,118,101,110,116,115,59,10,125,59,10,35"
asm ".byte 100,101,102,105,110,101,32,80,79,76,76,73,78,32,48,120,48,48,48,49,10,35,100,101,102,105,110,101,32,80,79,76"
asm ".byte 76,80,82,73,32,48,120,48,48,48,50,10,35,100,101,102,105,110,101,32,80,79,76,76,79,85,84,32,48,120,48,48"
asm ".byte 48,52,10,35,100,101,102,105,110,101,32,80,79,76,76,69,82,82,32,48,120,48,48,48,56,10,35,100,101,102,105,110"
asm ".byte 101,32,80,79,76,76,72,85,80,32,48,120,48,48,49,48,10,35,100,101,102,105,110,101,32,80,79,76,76,78,86,65"
asm ".byte 76,32,48,120,48,48,50,48,10,35,100,101,102,105,110,101,32,80,79,76,76,82,68,78,79,82,77,32,48,120,48,48"
asm ".byte 52,48,10,35,100,101,102,105,110,101,32,80,79,76,76,82,68,66,65,78,68,32,48,120,48,48,56,48,10,35,100,101"
asm ".byte 102,105,110,101,32,80,79,76,76,87,82,78,79,82,77,32,48,120,48,49,48,48,10,35,100,101,102,105,110,101,32,80"
asm ".byte 79,76,76,87,82,66,65,78,68,32,48,120,48,50,48,48,10,35,100,101,102,105,110,101,32,80,79,76,76,77,83,71"
asm ".byte 32,48,120,48,52,48,48,10,35,100,101,102,105,110,101,32,80,79,76,76,82,69,77,79,86,69,32,48,120,49,48,48"
asm ".byte 48,10,35,100,101,102,105,110,101,32,80,79,76,76,82,68,72,85,80,32,48,120,50,48,48,48,10,35,101,110,100,105"
asm ".byte 102,10,0,0,48,55,48,55,48,49,48,48,48,48,48,48,49,56,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,49,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48"
asm ".byte 48,48,48,48,48,48,48,48,48,69,48,48,48,48,48,48,48,48,84,82,65,73,76,69,82,33,33,33,0,0,0,0"
asm ".byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
asm ".byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
asm ".byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
asm ".byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
asm ".byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
asm ".byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
asm "@include_cpio_end"
void include_cpio_start(void);
void include_cpio_end(void);
 
unsigned int read_hex(char *buf)
{
 unsigned int ret;
 int x;
 x=0;
 ret=0;
 while(x<8)
 {
 if(buf[x]>='0'&&buf[x]<='9')
 {
 ret=ret<<4|(buf[x]-'0');
 }
 else if(buf[x]>='A'&&buf[x]<='F')
 {
 ret=ret<<4|(buf[x]-'A'+10);
 }
 else if(buf[x]>='a'&&buf[x]<='f')
 {
 ret=ret<<4|(buf[x]-'a'+10);
 }
 else
 {
 return 0;
 }
 ++x;
 }
 return ret;
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
int cpio_unpack(char *data,long int data_size,char *dst)
{
 int dir,fdo;
 static char buf[4096];
 struct cpio header;
 unsigned int l,mode,l1,size;
 int n;
 char *namebuf,*name;
 mkdirl(dst,0755);
 dir=openl(dst,0,0);
 if(dir<0)
 {
 return 1;
 }
 while(data_size>sizeof(struct cpio))
 {
 memcpy(&header,data,sizeof(struct cpio));
 data+=sizeof(struct cpio);
 data_size-=sizeof(struct cpio);
 if(memcmp(header.magic,"070701",6))
 {
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 mode=read_hex(header.mode);
 l=read_hex(header.namesize);
 l1=l+4096;
 l1-=l1&4095;
 namebuf=((void *)__syscall((long)(9),(long)(0),(long)(l1),(long)(3),(long)(0x22),(long)(-1),(long)(0)));
 if(!((unsigned long)((long)(namebuf))<=0xfffffffffffff000))
 {
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 if(data_size<l)
 {
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 memcpy(namebuf,data,l);
 data+=l;
 data_size-=l;
 if(!strcmp(namebuf,"TRAILER!!!"))
 {
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 0;
 }
 name=namebuf;
 while(*name=='/')
 {
 ++name;
 }
 if((mode&0170000)==040000)
 {
 mkdiratl(dir,name,mode&07777);
 fchmodatl(dir,name,mode&07777);
 }
 else if((mode&0170000)==0100000)
 {
 size=read_hex(header.filesize);
 fdo=openatl(dir,name,578,mode&07777);
 if(fdo<0)
 {
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 if(size>data_size)
 {
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fdo),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 while(1)
 {
 if(size>4096)
 {
 __syscall((long)(1),(long)(fdo),(long)(data),(long)(4096),(long)(0),(long)(0),(long)(0));
 size-=4096;
 data+=4096;
 data_size-=4096;
 }
 else
 {
 __syscall((long)(1),(long)(fdo),(long)(data),(long)(size),(long)(0),(long)(0),(long)(0));
 data+=size;
 data_size-=size;
 break;
 }
 }
 __syscall((long)(3),(long)(fdo),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 size&=3;
 if(size)
 {
 data+=4-size;
 data_size-=4-size;
 }
 fchmodatl(dir,name,mode&07777);
 }
 __syscall((long)(11),(long)(namebuf),(long)(l1),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 __syscall((long)(3),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 1;
}
int cpio_unpack_to_dir(char *cpio,long size,char *dir)
{
 __syscall((long)(83),(long)(dir),(long)(0755),(long)(0),(long)(0),(long)(0),(long)(0));
 return cpio_unpack(cpio,size,dir);
}
struct winsize winsz;
struct termios term,old_term;
unsigned short *pbuf;
int cursor_x,cursor_y;
int winsize_change;
 
void page_putc(char c,int hl,int x,int y);
void page_puts(char *s,int len,int hl,int x,int y);
int project_dir_fd;
char current_path[4100];
 
int project_file_x;
int init_project(char *dir)
{
 int ret;
 int fd;
 struct stat st;
 struct project_file_list *node,*p,*pp;
 ret=__syscall((long)(4),(long)(dir),(long)(&st),(long)(0),(long)(0),(long)(0),(long)(0));
 if(ret==-2)
 {
 __syscall((long)(83),(long)(dir),(long)(0755),(long)(0),(long)(0),(long)(0),(long)(0));
 project_dir_fd=__syscall((long)(2),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(project_dir_fd<0)
 {
 return 1;
 }
 fd=__syscall((long)(257),(long)(project_dir_fd),(long)("build-script"),(long)(578),(long)(0644),(long)(0),(long)(0));
 if(fd<0)
 {
 return 1;
 }
 __syscall((long)(1),(long)(fd),(long)("# Write your build commands here.\n"),(long)(34),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fd),(long)("# Internal commands:\n"),(long)(21),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fd),(long)("# scpp, scc, asm -- internal compilers (See manual pages for usage)\n"),(long)(68),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fd),(long)("# mkdir -- create directories\n"),(long)(30),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fd),(long)("# remove -- remove files or directories\n"),(long)(40),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fd),(long)("# rename -- rename file or directory\n"),(long)(37),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 char *new_dir;
 new_dir=malloc(strlen(dir)+30);
 if(new_dir==((void *)0))
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
 else if(ret==0&&(st.mode&0170000)==040000)
 {
 project_dir_fd=__syscall((long)(2),(long)(dir),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(project_dir_fd<0)
 {
 return 1;
 }
 }
 else
 {
 return 1;
 }
 if(__syscall((long)(269),(long)(project_dir_fd),(long)("build-script"),(long)(6),(long)(0),(long)(0),(long)(0)))
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
 fd=__syscall((long)(257),(long)(project_dir_fd),(long)(current_path),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd<0)
 {
 return;
 }
 dir_init(fd,&db);
 while(dir=readdir(&db))
 {
 if(strcmp(dir->name,".")&&strcmp(dir->name,".."))
 {
 if(!__syscall((long)(262),(long)(fd),(long)(dir->name),(long)(&st),(long)(0x100),(long)(0),(long)(0))&&((st.mode&0170000)==0100000||(st.mode&0170000)==040000))
 {
 node=malloc(sizeof(*node));
 if(node!=((void *)0))
 {
 strcpy(node->name,dir->name);
 if((st.mode&0170000)==040000)
 {
 node->is_dir=1;
 }
 else
 {
 node->is_dir=0;
 }
 pp=((void *)0);
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
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
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
 if(node==((void *)0))
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
 if(node==((void *)0))
 {
 if(project_file_x==0)
 {
 return ((void *)0);
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
 return ((void *)0);
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
 if(node==((void *)0))
 {
 return ((void *)0);
 }
 if(strlen(current_path)+strlen(node->name)>4000)
 {
 return ((void *)0);
 }
 if(node->is_dir)
 {
 strcat(current_path,node->name);
 strcat(current_path,"/");
 project_file_x=0;
 project_files_load();
 return ((void *)0);
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
 fd=__syscall((long)(257),(long)(project_dir_fd),(long)("_cursor_record"),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd<0)
 {
 return 0;
 }
 while(__syscall((long)(0),(long)(fd),(long)(&val),(long)(sizeof(val)),(long)(0),(long)(0),(long)(0))==sizeof(val))
 {
 if(val[0]==ino&&val[1]==dev)
 {
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return val[2];
 }
 }
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
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
 fd=__syscall((long)(257),(long)(project_dir_fd),(long)("_cursor_record"),(long)(66),(long)(0644),(long)(0),(long)(0));
 if(fd<0)
 {
 return;
 }
 while(__syscall((long)(0),(long)(fd),(long)(val),(long)(sizeof(val)),(long)(0),(long)(0),(long)(0))==sizeof(val))
 {
 if(val[0]==ino&&val[1]==dev)
 {
 __syscall((long)(8),(long)(fd),(long)(-sizeof(val)),(long)(1),(long)(0),(long)(0),(long)(0));
 val[2]=pos;
 __syscall((long)(1),(long)(fd),(long)(val),(long)(sizeof(val)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return;
 }
 }
 val[0]=ino;
 val[1]=dev;
 val[2]=pos;
 __syscall((long)(1),(long)(fd),(long)(val),(long)(sizeof(val)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
}
void do_remove(int dirfd,char *name)
{
 struct stat st;
 int fd;
 struct DIR db;
 struct dirent *dir;
 if(fstatatl(dirfd,name,&st,0x100))
 {
 return;
 }
 if((st.mode&0170000)==040000)
 {
 fd=openatl(dirfd,name,0,0);
 if(fd>=0)
 {
 dir_init(fd,&db);
 while(dir=readdir(&db))
 {
 if(strcmp(dir->name,".")&&strcmp(dir->name,".."))
 {
 do_remove(fd,dir->name);
 }
 }
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 unlinkatl(dirfd,name,0x200);
 }
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
 do_remove((-100),name);
}
void remove_project_file(char *name)
{
 while(*name=='/')
 {
 ++name;
 }
 do_remove(project_dir_fd,name);
}
 
int term_init(void)
{
 if(__syscall((long)(16),(long)(0),(long)(0x5401),(long)(&term),(long)(0),(long)(0),(long)(0)))
 {
 return 1;
 }
 memcpy(&old_term,&term,sizeof(term));
 term.lflag&=~0xa;
 if(__syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0)))
 {
 return 1;
 }
 return 0;
}
void block_sigwinch(void)
{
 unsigned long long set[16];
 memset(set,0,sizeof(set));
 set[0]=1<<28-1;
 __syscall((long)(14),(long)(0),(long)(set),(long)(((void *)0)),(long)(8),(long)(0),(long)(0));
}
void unblock_sigwinch(void)
{
 unsigned long long set[16];
 memset(set,0,sizeof(set));
 set[0]=1<<28-1;
 __syscall((long)(14),(long)(1),(long)(set),(long)(((void *)0)),(long)(8),(long)(0),(long)(0));
}
void SH_winch(int sig)
{
 __syscall((long)(16),(long)(0),(long)(0x5413),(long)(&winsz),(long)(0),(long)(0),(long)(0));
 if(winsz.col<80)
 {
 winsz.col=80;
 }
 if(winsz.row<25)
 {
 winsz.row=25;
 }
 if(winsz.col>2000)
 {
 winsz.col=2000;
 }
 if(winsz.row>2000)
 {
 winsz.row=2000;
 }
 winsize_change=1;
}
int getc(void)
{
 int c[1];
 int ret;
 c[0]=0;
 unblock_sigwinch();
 ret=__syscall((long)(0),(long)(0),(long)(c),(long)(2),(long)(0),(long)(0),(long)(0));
 block_sigwinch();
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
 ret=__syscall((long)(0),(long)(0),(long)((char *)c+2),(long)(1),(long)(0),(long)(0),(long)(0));
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
 __syscall((long)(1),(long)(1),(long)("\033[?25l\x0f\033[1;1H\033[0m"),(long)(17),(long)(0),(long)(0),(long)(0));
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
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufl),(long)(0),(long)(0),(long)(0));
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
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufl),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[0m"),(long)(4),(long)(0),(long)(0),(long)(0));
 strcpy(buf,"\033[");
 sprinti(buf,cy+1,1);
 strcat(buf,";");
 sprinti(buf,cx+1,1);
 strcat(buf,"H");
 __syscall((long)(1),(long)(1),(long)(buf),(long)(strlen(buf)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[?25h"),(long)(6),(long)(0),(long)(0),(long)(0));
}
 
namespace edit;
char *file_name;
int current_x;
struct file
{
 struct file *next;
 struct file *prev;
 unsigned char *buf;
 unsigned long long int buflen;
} *file_head,*file_end;
struct file_pos
{
 struct file *block;
 unsigned long long int pos;
 unsigned long long int off;
} current_pos,view_pos,select_pos;
int current_pos_end;
void file_block_insert(struct file *prev,struct file *node)
{
 node->prev=prev;
 if(prev)
 {
 node->next=prev->next;
 if(prev->next)
 {
 prev->next->prev=node;
 }
 prev->next=node;
 }
 else
 {
 node->next=file_head;
 if(file_head)
 {
 file_head->prev=node;
 }
 file_head=node;
 }
 if(prev==file_end)
 {
 file_end=node;
 }
}
void file_block_delete(struct file *node)
{
 if(node->prev)
 {
 node->prev->next=node->next;
 }
 else
 {
 file_head=node->next;
 }
 if(node->next)
 {
 node->next->prev=node->prev;
 }
 else
 {
 file_end=node->prev;
 }
 free(node->buf);
 free(node);
}
int file_load(void)
{
 int fd;
 unsigned char buf[1024];
 int n;
 struct file *node;
 fd=__syscall((long)(257),(long)(project_dir_fd),(long)(file_name),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd<0)
 {
 return 1;
 }
 while(n=__syscall((long)(0),(long)(fd),(long)(buf),(long)(1024),(long)(0),(long)(0),(long)(0)))
 {
 node=malloc(sizeof(*node));
 if(node==((void *)0))
 {
 return 1;
 }
 node->buf=malloc(n);
 if(node->buf==((void *)0))
 {
 return 1;
 }
 memcpy(node->buf,buf,n);
 node->buflen=n;
 file_block_insert(file_end,node);
 }
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 current_pos.block=file_head;
 view_pos.block=file_head;
 if(file_head==((void *)0))
 {
 current_pos_end=1;
 }
 return 0;
}
int file_pos_move_left(struct file_pos *pos)
{
 if(!pos->block)
 {
 return 0;
 }
 if(pos->pos)
 {
 --pos->pos;
 --pos->off;
 return 1;
 }
 else if(pos->block->prev)
 {
 pos->block=pos->block->prev;
 pos->pos=pos->block->buflen-1;
 --pos->off;
 return 1;
 }
 return 0;
}
int file_pos_move_right(struct file_pos *pos)
{
 if(!pos->block)
 {
 return 0;
 }
 ++pos->pos;
 if(pos->pos==pos->block->buflen)
 {
 if(pos->block->next)
 {
 pos->block=pos->block->next;
 pos->pos=0;
 ++pos->off;
 return 1;
 }
 else
 {
 --pos->pos;
 return 0;
 }
 }
 ++pos->off;
 return 1;
}
int file_getc(struct file_pos *pos)
{
 unsigned int c;
 if(!pos->block)
 {
 return -1;
 }
 c=pos->block->buf[pos->pos];
 return c;
}
int move_next_line(struct file_pos *pos)
{
 int c;
 struct file_pos pos1;
 if(!pos->block)
 {
 return 0;
 }
 memcpy(&pos1,pos,sizeof(pos1));
 while((c=file_getc(pos))!='\n')
 {
 if(!file_pos_move_right(pos))
 {
 c=-1;
 break;
 }
 }
 if(c==-1)
 {
 memcpy(pos,&pos1,sizeof(pos1));
 return 0;
 }
 if(!file_pos_move_right(pos))
 {
 memcpy(pos,&pos1,sizeof(pos1));
 return 0;
 }
 return 1;
}
int move_prev_line(struct file_pos *pos)
{
 int c;
 struct file_pos pos1;
 if(!pos->block)
 {
 return 0;
 }
 memcpy(&pos1,pos,sizeof(pos1));
 if(!file_pos_move_left(pos))
 {
 memcpy(pos,&pos1,sizeof(pos1));
 return 0;
 }
 do
 {
 if(!file_pos_move_left(pos))
 {
 c=-1;
 break;
 }
 }
 while((c=file_getc(pos))!='\n');
 if(c==-1)
 {
 return 1;
 }
 if(!file_pos_move_right(pos))
 {
 memcpy(pos,&pos1,sizeof(pos1));
 return 0;
 }
 return 1;
}
long long int lines_rel(void)
{
 long long int lines;
 struct file_pos pos;
 lines=0;
 memcpy(&pos,&current_pos,sizeof(pos));
 while(pos.off>=view_pos.off)
 {
 if(file_getc(&pos)=='\n')
 {
 ++lines;
 }
 if(!file_pos_move_left(&pos))
 {
 break;
 }
 }
 return lines;
}
int lines_remain(int max)
{
 struct file_pos pos;
 int lines;
 int c;
 lines=1;
 memcpy(&pos,&view_pos,sizeof(pos));
 if(!pos.block)
 {
 return 0;
 }
 while(lines<max)
 {
 c=file_getc(&pos);
 if(c=='\n')
 {
 ++lines;
 }
 if(!file_pos_move_right(&pos))
 {
 break;
 }
 }
 return lines;
}
int lines_off(int max)
{
 struct file_pos pos;
 int lines;
 int c;
 lines=1;
 memcpy(&pos,&view_pos,sizeof(pos));
 if(!pos.block)
 {
 return 0;
 }
 while(lines<max)
 {
 c=file_getc(&pos);
 if(c=='\n')
 {
 ++lines;
 }
 if(!file_pos_move_left(&pos))
 {
 break;
 }
 }
 return lines;
}
int cursor_right(void)
{
 int c;
 c=file_getc(&current_pos);
 if(current_pos_end==1)
 {
 return 0;
 }
 if(c==-1)
 {
 return 0;
 }
 if(!file_pos_move_right(&current_pos))
 {
 current_pos_end=1;
 return 1;
 }
 if(c=='\n')
 {
 if(lines_rel()>winsz.row/2&&lines_remain(winsz.row)==winsz.row)
 {
 move_next_line(&view_pos);
 }
 }
 return 1;
}
int cursor_left(void)
{
 int c;
 c=file_getc(&current_pos);
 if(current_pos_end==1)
 {
 if(c==-1)
 {
 return 0;
 }
 current_pos_end=0;
 return 1;
 }
 if(!file_pos_move_left(&current_pos))
 {
 return 0;
 }
 if(file_getc(&current_pos)=='\n')
 {
 if(lines_rel()<winsz.row/2&&lines_off(1)==1)
 {
 move_prev_line(&view_pos);
 }
 }
 return 1;
}
long long int line_off(struct file_pos *pos)
{
 long long int off;
 struct file_pos pos1;
 int c;
 off=1;
 memcpy(&pos1,pos,sizeof(pos1));
 if(!file_pos_move_left(&pos1))
 {
 return 0;
 }
 while((c=file_getc(&pos1))!='\n')
 {
 ++off;
 if(!file_pos_move_left(&pos1))
 {
 break;
 }
 }
 --off;
 return off;
}
long long int line_len(struct file_pos *pos)
{
 struct file_pos pos1;
 int c;
 memcpy(&pos1,pos,sizeof(pos1));
 while((c=file_getc(&pos1))!='\n')
 {
 if(!file_pos_move_right(&pos1))
 {
 break;
 }
 }
 return line_off(&pos1)+1;
}
void current_x_refine(void)
{
 long long int off;
 off=line_off(&current_pos);
 if(off<current_x)
 {
 current_x=off;
 }
 if(off-current_x>winsz.col-8)
 {
 current_x=off-winsz.col+8;
 }
}
int cursor_down(void)
{
 long long int len;
 int c,n;
 struct file_pos pos;
 int old_end;
 len=line_len(&current_pos);
 old_end=current_pos_end;
 n=0;
 memcpy(&pos,&current_pos,sizeof(pos));
 while(len&&(c=file_getc(&current_pos))!=-1)
 {
 if(c=='\n')
 {
 ++n;
 if(n==2)
 {
 break;
 }
 }
 if(!cursor_right())
 {
 current_pos_end=old_end;
 memcpy(&current_pos,&pos,sizeof(pos));
 return 0;
 }
 --len;
 }
 return 1;
}
int cursor_up(void)
{
 long long int off;
 long long int off1;
 long long int len;
 struct file_pos pos;
 int old_end;
 off=line_off(&current_pos)+1;
 off1=off;
 old_end=current_pos_end;
 memcpy(&pos,&current_pos,sizeof(pos));
 if(current_pos.block==0)
 {
 return 0;
 }
 while(off)
 {
 if(!cursor_left())
 {
 current_pos_end=old_end;
 memcpy(&current_pos,&pos,sizeof(pos));
 return 0;
 }
 --off;
 }
 len=line_off(&current_pos);
 len-=off1-1;
 if(len<=0)
 {
 return 1;
 }
 while(len)
 {
 cursor_left();
 --len;
 }
 return 1;
}
void addc_end(int c)
{
 struct file *node;
 unsigned char *ptr;
 if(!file_end||file_end->buflen==1024)
 {
 if(node=malloc(sizeof(*node)))
 {
 if(node->buf=malloc(1))
 {
 node->buf[0]=c;
 node->buflen=1;
 file_block_insert(file_end,node);
 }
 else
 {
 free(node);
 }
 }
 }
 else
 {
 ptr=malloc(file_end->buflen+1);
 if(ptr)
 {
 memcpy(ptr,file_end->buf,file_end->buflen);
 free(file_end->buf);
 file_end->buf=ptr;
 ptr[file_end->buflen]=c;
 ++file_end->buflen;
 }
 }
 if(view_pos.block==0)
 {
 view_pos.block=file_head;
 view_pos.off=0;
 view_pos.pos=0;
 current_pos.block=file_head;
 current_pos.off=0;
 current_pos.pos=0;
 }
}
void delc_end(void)
{
 if(!file_end)
 {
 return;
 }
 if(file_end->buflen==1)
 {
 file_block_delete(file_end);
 }
 else
 {
 --file_end->buflen;
 }
 if(file_head==0)
 {
 view_pos.block=0;
 view_pos.pos=0;
 view_pos.off=0;
 }
}
struct file *split_block(struct file *node,long long int off)
{
 struct file *new_node;
 unsigned char *ptr;
 if((new_node=malloc(sizeof(*node)))==0)
 {
 return (void *)0;
 }
 if((ptr=malloc(node->buflen-off))==0)
 {
 free(new_node);
 return (void *)0;
 }
 memcpy(ptr,node->buf+off,node->buflen-off);
 new_node->buf=ptr;
 new_node->buflen=node->buflen-off;
 node->buflen=off;
 file_block_insert(node,new_node);
 return node;
}
void addc(int c)
{
 struct file *node,*prev;
 unsigned char *ptr;
 if(!current_pos.block)
 {
 return;
 }
 if(current_pos.block->buflen!=1024)
 {
 prev=current_pos.block;
 ptr=malloc(prev->buflen+1);
 if(ptr)
 {
 memcpy(ptr,prev->buf,prev->buflen);
 free(prev->buf);
 prev->buf=ptr;
 memmove(prev->buf+current_pos.pos+1,prev->buf+current_pos.pos,prev->buflen-current_pos.pos);
 ptr[current_pos.pos]=c;
 ++prev->buflen;
 ++current_pos.pos;
 ++current_pos.off;
 }
 else
 {
 return;
 }
 }
 else if(current_pos.pos==0)
 {
 if((prev=current_pos.block->prev)&&prev->buflen!=1024)
 {
 ptr=malloc(prev->buflen+1);
 if(ptr)
 {
 memcpy(ptr,prev->buf,prev->buflen);
 free(prev->buf);
 prev->buf=ptr;
 ptr[prev->buflen]=c;
 ++prev->buflen;
 ++current_pos.off;
 }
 else
 {
 return;
 }
 }
 else if(node=malloc(sizeof(*node)))
 {
 if(ptr=malloc(1))
 {
 ptr[0]=c;
 node->buf=ptr;
 node->buflen=1;
 file_block_insert(prev,node);
 if(view_pos.block==current_pos.block)
 {
 view_pos.block=node;
 view_pos.pos=0;
 }
 ++current_pos.off;
 }
 else
 {
 free(node);
 return;
 }
 }
 else
 {
 return;
 }
 
 }
 else
 {
 prev=split_block(current_pos.block,current_pos.pos);
 prev=prev->next;
 ptr=malloc(prev->buflen+1);
 if(ptr)
 {
 memcpy(ptr,prev->buf,prev->buflen);
 free(prev->buf);
 prev->buf=ptr;
 memmove(prev->buf+1,prev->buf,prev->buflen);
 ptr[0]=c;
 ++prev->buflen;
 current_pos.block=prev;
 current_pos.pos=1;
 ++current_pos.off;
 }
 else
 {
 return;
 }
 }
 if(c=='\n')
 {
 if(lines_rel()>winsz.row/2&&lines_remain(winsz.row)==winsz.row)
 {
 move_next_line(&view_pos);
 }
 }
}
void delc(void)
{
 int c;
 struct file *node,*node1;
 c=file_getc(&current_pos);
 if(c==-1)
 {
 return;
 }
 node=current_pos.block;
 if(node->prev==0&&current_pos.pos==0)
 {
 return;
 }
 if(current_pos.pos!=0)
 {
 node1=split_block(node,current_pos.pos);
 node=node1->next;
 }
 else
 {
 node1=node->prev;
 }
 --node1->buflen;
 current_pos.block=node;
 current_pos.pos=0;
 --current_pos.off;
 if(node1->buflen==0)
 {
 if(view_pos.block==node1)
 {
 view_pos.block=node;
 view_pos.pos=0;
 }
 file_block_delete(node1);
 }
 if(c=='\n')
 {
 if(lines_rel()<winsz.row/2&&lines_off(1)==1)
 {
 move_prev_line(&view_pos);
 }
 }
}
void save_file(void)
{
 struct file *node;
 int fd;
 node=file_head;
 if((fd=__syscall((long)(257),(long)(project_dir_fd),(long)(file_name),(long)(01002),(long)(0),(long)(0),(long)(0)))<0)
 {
 return;
 }
 while(node)
 {
 __syscall((long)(1),(long)(fd),(long)(node->buf),(long)(node->buflen),(long)(0),(long)(0),(long)(0));
 node=node->next;
 }
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
}
void release_file(void)
{
 struct file *node,*p;
 node=file_head;
 while(node)
 {
 p=node;
 node=node->next;
 free(p);
 }
 file_end=((void *)0);
 file_head=((void *)0);
 memset(&current_pos,0,sizeof(current_pos));
 memset(&view_pos,0,sizeof(view_pos));
 memset(&select_pos,0,sizeof(select_pos));
}
 
int mode; 
char *clipboard;
unsigned long int clipboard_size;
char cmd_buf[64];
int cmd_size;
 
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
short int op_c_fifo[1048576];
long int op_off_fifo[1048576];
int op_fifo_size,op_fifo_start,op_fifo_x;
 
void op_push(short int c,long int off)
{
 int x;
 op_fifo_size=op_fifo_x;
 x=op_fifo_start+op_fifo_size;
 if(x>=1048576)
 {
 x-=1048576;
 }
 op_c_fifo[x]=c;
 op_off_fifo[x]=off;
 if(op_fifo_size<1048576)
 {
 ++op_fifo_size;
 ++op_fifo_x;
 }
 else
 {
 ++op_fifo_start;
 }
}
void gotooff(long int off)
{
 long int diff;
 diff=off-current_pos.off;
 if(current_pos_end)
 {
 --diff;
 }
 if(diff<0)
 {
 while(diff)
 {
 cursor_left();
 current_x_refine();
 ++diff;
 }
 }
 else
 {
 while(diff)
 {
 cursor_right();
 current_x_refine();
 --diff;
 }
 }
}
void addc_off(long int off,char c)
{
 gotooff(off);
 if(current_pos_end)
 {
 addc_end(c);
 current_pos_end=0;
 cursor_right();
 current_pos_end=1;
 }
 else
 {
 addc(c);
 }
 current_x_refine();
}
void delc_off(long int off)
{
 gotooff(off+1);
 if(current_pos_end)
 {
 current_pos_end=0;
 if(!cursor_left())
 {
 current_pos.block=((void *)0);
 current_pos.pos=0;
 current_pos.off=0;
 }
 delc_end();
 current_pos_end=1;
 }
 else
 {
 delc();
 }
 current_x_refine();
}
void undo(void)
{
 long int off;
 short int c;
 int x;
 if(op_fifo_x==0)
 {
 return;
 }
 x=op_fifo_start+op_fifo_x-1;
 if(x>=1048576)
 {
 x-=1048576;
 }
 c=op_c_fifo[x];
 off=op_off_fifo[x];
 if(c>>8)
 {
 addc_off(off,c);
 }
 else
 {
 delc_off(off);
 }
 --op_fifo_x;
}
void redo(void)
{
 long int off;
 short int c;
 int x;
 if(op_fifo_x==op_fifo_size)
 {
 return;
 }
 x=op_fifo_start+op_fifo_x;
 if(x>=1048576)
 {
 x-=1048576;
 }
 c=op_c_fifo[x];
 off=op_off_fifo[x];
 if(c>>8)
 {
 delc_off(off);
 }
 else
 {
 addc_off(off,c);
 }
 ++op_fifo_x;
}
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
 if(clipboard==((void *)0))
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
 int c,s,s1;
 int bufsize;
 char buf[4096];
 int cursor_char;
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
 y=0;
 cx=-1;
 cy=0;
 s=0;
 bufsize=0;
 memcpy(&pos,&view_pos,sizeof(pos));
 __syscall((long)(1),(long)(1),(long)("\033[?25l\x0f\033[1;1H\033[0m"),(long)(17),(long)(0),(long)(0),(long)(0));
 cursor_char=32;
 while(y<winsz.row-1)
 {
 x=current_x;
 s1=0;
 while(x)
 {
 c=file_getc(&pos);
 if(c==-1||c=='\n')
 {
 s1=1;
 break;
 }
 if(!file_pos_move_right(&pos))
 {
 s1=1;
 break;
 }
 --x;
 }
 if(!s1)
 {
 while(x<winsz.col)
 {
 c=file_getc(&pos);
 if(pos.off==current_pos.off)
 {
 cx=x;
 cy=y;
 if(c>32&&c<=126)
 {
 cursor_char=c;
 }
 }
 if(c=='\n')
 {
 break;
 }
 if(c>=32&&c<127)
 {
 if(if_selected(&current_pos,&pos))
 {
 if(bufsize>4000)
 {
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufsize),(long)(0),(long)(0),(long)(0));
 bufsize=0;
 }
 memcpy(buf+bufsize,"\033[47m\033[30m",10);
 bufsize+=10;
 }
 if(bufsize==4095)
 {
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufsize),(long)(0),(long)(0),(long)(0));
 bufsize=0;
 }
 buf[bufsize]=c;
 ++bufsize;
 if(if_selected(&current_pos,&pos))
 {
 if(bufsize>4000)
 {
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufsize),(long)(0),(long)(0),(long)(0));
 bufsize=0;
 }
 memcpy(buf+bufsize,"\033[0m",4);
 bufsize+=4;
 }
 }
 else if(c==-1)
 {
 break;
 }
 else if(c=='\t')
 {
 if(bufsize>4000)
 {
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufsize),(long)(0),(long)(0),(long)(0));
 bufsize=0;
 }
 if(if_selected(&current_pos,&pos))
 {
 memcpy(buf+bufsize,"\033[47m \033[0m",10);
 }
 else
 {
 memcpy(buf+bufsize,"\033[42m \033[0m",10);
 }
 bufsize+=10;
 }
 else
 {
 if(bufsize>4000)
 {
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufsize),(long)(0),(long)(0),(long)(0));
 bufsize=0;
 }
 if(if_selected(&current_pos,&pos))
 {
 memcpy(buf+bufsize,"\033[47m \033[0m",10);
 }
 else
 {
 memcpy(buf+bufsize,"\033[44m \033[0m",10);
 }
 bufsize+=10;
 }
 if(!file_pos_move_right(&pos))
 {
 s=1;
 break;
 }
 ++x;
 }
 }
 else
 {
 x=0;
 }
 if(!move_next_line(&pos))
 {
 s=1;
 }
 if(s)
 {
 if(cx==-1||current_pos_end)
 {
 cx=x;
 cy=y;
 }
 }
 while(x<winsz.col)
 {
 if(bufsize==4095)
 {
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufsize),(long)(0),(long)(0),(long)(0));
 bufsize=0;
 }
 buf[bufsize]=' ';
 ++bufsize;
 ++x;
 }
 ++y;
 if(s)
 {
 break;
 }
 }
 while(y<winsz.row-1)
 {
 x=0;
 while(x<winsz.col)
 {
 if(bufsize==4095)
 {
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufsize),(long)(0),(long)(0),(long)(0));
 bufsize=0;
 }
 buf[bufsize]=' ';
 ++bufsize;
 ++x;
 }
 ++y;
 }
 __syscall((long)(1),(long)(1),(long)(buf),(long)(bufsize),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("                    \r"),(long)(21),(long)(0),(long)(0),(long)(0));
 if(mode==1)
 {
 __syscall((long)(1),(long)(1),(long)("Insert"),(long)(6),(long)(0),(long)(0),(long)(0));
 }
 else if(mode==2)
 {
 __syscall((long)(1),(long)(1),(long)("Select"),(long)(6),(long)(0),(long)(0),(long)(0));
 }
 else if(mode==3)
 {
 __syscall((long)(1),(long)(1),(long)(">"),(long)(1),(long)(0),(long)(0),(long)(0));
 x=0;
 while(x<cmd_size)
 {
 __syscall((long)(1),(long)(1),(long)(cmd_buf+x),(long)(1),(long)(0),(long)(0),(long)(0));
 ++x;
 }
 while(x<64)
 {
 __syscall((long)(1),(long)(1),(long)(" "),(long)(1),(long)(0),(long)(0),(long)(0));
 ++x;
 }
 }
 strcpy(buf,"\033[");
 sprinti(buf,cy+1,1);
 strcat(buf,";");
 sprinti(buf,cx+1,1);
 strcat(buf,"H");
 __syscall((long)(1),(long)(1),(long)(buf),(long)(strlen(buf)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[37m\033[43m"),(long)(10),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)(&cursor_char),(long)(1),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[0m"),(long)(4),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)(buf),(long)(strlen(buf)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[?25h"),(long)(6),(long)(0),(long)(0),(long)(0));
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
 if(mode==0)
 {
 if(c=='I')
 {
 mode=1;
 }
 else if(c=='W')
 {
 save_file();
 }
 else if(c=='S')
 {
 mode=2;
 memcpy(&select_pos,&current_pos,sizeof(current_pos));
 }
 else if(c=='P')
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
 mode=3;
 cmd_size=0;
 }
 else if(c=='U')
 {
 undo();
 }
 else if(c=='R')
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
 current_pos.block=((void *)0);
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
 else if(mode==2)
 {
 if(c=='C')
 {
 copy_selected_str();
 mode=0;
 }
 else if(c=='D')
 {
 copy_selected_str();
 del_selected_str();
 mode=0;
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
 mode=0;
 }
 }
}
 
long edit_file(char *file,int pos)
{
 struct stat st;
 int c;
 int ret;
 if(__syscall((long)(262),(long)(project_dir_fd),(long)(file),(long)(&st),(long)(0x100),(long)(0),(long)(0)))
 {
 return -1;
 }
 if((st.mode&0170000)!=0100000)
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
 while(1)
 {
 do
 {
 display_file();
 unblock_sigwinch();
 block_sigwinch();
 }
 while(winsize_change);
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
 release_file();
 cmd_size=0;
 mode=0;
 op_fifo_size=0;
 op_fifo_x=0;
 op_fifo_start=0;
 memset(op_c_fifo,0,sizeof(op_c_fifo));
 memset(op_off_fifo,0,sizeof(op_off_fifo));
 return ret;
}
namespace scpp;
void *xmalloc(long int size)
{
 void *ptr;
 ptr=malloc(size+16);
 if(ptr==0)
 {
 __syscall((long)(1),(long)(2),(long)("FATAL: cannot allocate memory.\n"),(long)(31),(long)(0),(long)(0),(long)(0));
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 return ptr;
}
long int __str_size(long int size)
{
 long int val;
 val=128;
 while(val<size)
 {
 val=val*3>>1;
 }
 return val;
}
char *xstrdup(char *str)
{
 long int l;
 char *new_str;
 l=strlen(str);
 new_str=xmalloc(__str_size(l+1));
 memcpy(new_str,str,l);
 new_str[l]=0;
 return new_str;
}
 
char *str_c_app(char *s,int c)
{
 char *new_str;
 long int l,l1,l2;
 if(s==0)
 {
 new_str=xmalloc(128);
 new_str[0]=c;
 new_str[1]=0;
 }
 else
 {
 l=strlen(s);
 l1=__str_size(l+1);
 l2=__str_size(l+2);
 if(l1==l2)
 {
 new_str=s;
 new_str[l]=c;
 new_str[l+1]=0;
 }
 else
 {
 new_str=xmalloc(l2);
 memcpy(new_str,s,l);
 new_str[l]=c;
 new_str[l+1]=0;
 free(s);
 }
 }
 return new_str;
}
char *str_c_app2(char *s,long off,int c)
{
 char *new_str;
 long int l,l1,l2;
 if(s==0)
 {
 new_str=xmalloc(128);
 new_str[0]=c;
 new_str[1]=0;
 }
 else
 {
 l=strlen(s+off)+off;
 l1=__str_size(l+1);
 l2=__str_size(l+2);
 if(l1==l2)
 {
 new_str=s;
 new_str[l]=c;
 new_str[l+1]=0;
 }
 else
 {
 new_str=xmalloc(l2);
 memcpy(new_str,s,l);
 new_str[l]=c;
 new_str[l+1]=0;
 free(s);
 }
 }
 return new_str;
}
char *str_s_app(char *s,char *s2)
{
 while(*s2)
 {
 s=str_c_app(s,*s2);
 s2=s2+1;
 }
 return s;
}
char *str_i_app(char *s,unsigned long int n)
{
 unsigned long int a;
 a=10000000000000000000;
 int c;
 if(n==0)
 {
 return str_c_app(s,'0');
 }
 while(a>n)
 {
 a/=10;
 }
 while(a)
 {
 c=n/a;
 n%=a;
 a/=10;
 s=str_c_app(s,c+'0');
 }
 return s;
}
long int current_line;
int fdi,fdo;
int include_level;
int is_comment;
char *current_file;
long int macro_state;
struct lines_list
{
 char *str;
 long int line;
 long int fline;
 char *fname;
 struct lines_list *next;
} *lines_head,*lines_end;
 
void error(char *file,int line,char *msg)
{
 char *str;
 str=xstrdup("file \"");
 str=str_s_app(str,file);
 str=str_s_app(str,"\" line ");
 str=str_i_app(str,line);
 str=str_s_app(str,": error: ");
 str=str_s_app(str,msg);
 str=str_c_app(str,'\n');
 __syscall((long)(1),(long)(2),(long)(str),(long)(strlen(str)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(231),(long)(2),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
}
int name_hash(char *str)
{
 unsigned int hash;
 hash=0;
 while(*str)
 {
 hash=(hash<<11|hash>>21)+*str;
 ++str;
 }
 return hash%1021;
}
char outc_buf[65536];
int outc_x;
void outc(char c)
{
 if(outc_x==65536)
 {
 __syscall((long)(1),(long)(fdo),(long)(outc_buf),(long)(outc_x),(long)(0),(long)(0),(long)(0));
 outc_x=0;
 }
 outc_buf[outc_x]=c;
 ++outc_x;
}
void out_flush(void)
{
 if(outc_x)
 {
 __syscall((long)(1),(long)(fdo),(long)(outc_buf),(long)(outc_x),(long)(0),(long)(0),(long)(0));
 }
}
void c_write(char *buf,int size)
{
 while(size)
 {
 outc(*buf);
 ++buf;
 --size;
 }
}
char *read_line(int fd)
{
 char *str;
 char c;
 long int x;
 str=0;
 while(__syscall((long)(0),(long)(fd),(long)(&c),(long)(1),(long)(0),(long)(0),(long)(0))==1)
 {
 if(c=='\\')
 {
 if(__syscall((long)(0),(long)(fd),(long)(&c),(long)(1),(long)(0),(long)(0),(long)(0))==1)
 {
 if(c=='\r')
 {
 __syscall((long)(0),(long)(fd),(long)(&c),(long)(1),(long)(0),(long)(0),(long)(0));
 ++current_line;
 }
 else if(c=='\n')
 {
 ++current_line;
 }
 else
 {
 str=str_c_app(str,'\\');
 str=str_c_app(str,c);
 }
 }
 else
 {
 break;
 }
 }
 else if(c=='\n')
 {
 if(str==0)
 {
 str=xstrdup(" ");
 }
 break;
 }
 else
 {
 str=str_c_app(str,c);
 }
 }
 if(str==0)
 {
 return 0;
 }
 x=0;
 while(c=str[x])
 {
 if(is_comment)
 {
 str[x]=32;
 if(c=='*'&&str[x+1]=='/')
 {
 str[x+1]=32;
 is_comment=0;
 ++x;
 }
 }
 else if(c=='/')
 {
 if(str[x+1]=='/')
 {
 str[x]=0;
 break;
 }
 else if(str[x+1]=='*')
 {
 str[x]=32;
 str[x+1]=32;
 ++x;
 is_comment=1;
 }
 }
 else if(c=='\'')
 {
 do
 {
 ++x;
 c=str[x];
 if(c==0)
 {
 break;
 }
 else if(c=='\\')
 {
 ++x;
 if(str[x]==0)
 {
 break;
 }
 }
 }
 while(c!='\'');
 }
 else if(c=='\"')
 {
 do
 {
 ++x;
 c=str[x];
 if(c==0)
 {
 break;
 }
 else if(c=='\\')
 {
 ++x;
 if(str[x]==0)
 {
 break;
 }
 }
 }
 while(c!='\"');
 }
 ++x;
 }
 ++current_line;
 return str;
}
char *read_str(char **str,char c)
{
 char *s;
 char c1;
 s=0;
 s=str_c_app(s,c);
 ++*str;
 while(c1=**str)
 {
 s=str_c_app(s,c1);
 if(c1==c)
 {
 break;
 }
 if(c1=='\\')
 {
 ++*str;
 c1=**str;
 if(c1==0)
 {
 break;
 }
 s=str_c_app(s,c1);
 }
 ++*str;
 }
 if(c1)
 {
 ++*str;
 }
 return s;
}
char *skip_spaces(char *str)
{
 while(*str==32||*str=='\r'||*str=='\t'||*str=='\v')
 {
 ++str;
 }
 return str;
}
int is_id(char c)
{
 if(c>='0'&&c<='9'||c>='A'&&c<='Z'||c>='a'&&c<='z'||c=='_')
 {
 return 1;
 }
 return 0;
}
char *read_word(char **str)
{
 char *str1,*ret;
 str1=skip_spaces(*str);
 if(str1!=*str)
 {
 *str=str1;
 return xstrdup(" ");
 }
 if(*str1==0)
 {
 return 0;
 }
 ret=0;
 if(is_id(*str1))
 {
 while(is_id(*str1))
 {
 ret=str_c_app(ret,*str1);
 ++str1;
 }
 *str=str1;
 return ret;
 }
 else if(*str1=='\'')
 {
 *str=str1;
 return read_str(str,'\'');
 }
 else if(*str1=='\"')
 {
 *str=str1;
 return read_str(str,'\"');
 }
 ret=str_c_app(ret,*str1);
 ++*str;
 return ret;
}
long int condc,condc_levels,old_condc_levels,condc_else;
struct macro_tab2
{
 char *name;
 struct macro_tab2 *next;
} *macro_tab2[1021];
void macro_tab2_add(char *name)
{
 int hash;
 struct macro_tab2 *node;
 hash=name_hash(name);
 node=xmalloc(sizeof(*node));
 node->name=xstrdup(name);
 node->next=macro_tab2[hash];
 macro_tab2[hash]=node;
}
void macro_tab2_del(char *name)
{
 int hash;
 struct macro_tab2 *node,*p;
 hash=name_hash(name);
 node=macro_tab2[hash];
 p=0;
 while(node&&strcmp(name,node->name))
 {
 p=node;
 node=node->next;
 }
 if(p)
 {
 p->next=node->next;
 }
 else
 {
 macro_tab2[hash]=node->next;
 }
 free(node->name);
 free(node);
}
struct macro_tab2 *macro_tab2_find(char *name)
{
 int hash;
 struct macro_tab2 *node;
 hash=name_hash(name);
 node=macro_tab2[hash];
 while(node&&strcmp(name,node->name))
 {
 node=node->next;
 }
 return node;
}
char *get_ppcmd(char *str)
{
 skip_spaces(str);
 if(*str!='#')
 {
 return 0;
 }
 ++str;
 skip_spaces(str);
 return str;
}
char *sgetc(char *str,char *ret)
{
 int x;
 if(str[0]=='\\')
 {
 if(str[1]=='\\')
 {
 *ret='\\';
 return str+2;
 }
 else if(str[1]=='n')
 {
 *ret='\n';
 return str+2;
 }
 else if(str[1]=='t')
 {
 *ret='\t';
 return str+2;
 }
 else if(str[1]=='v')
 {
 *ret='\v';
 return str+2;
 }
 else if(str[1]=='r')
 {
 *ret='\r';
 return str+2;
 }
 else if(str[1]=='\'')
 {
 *ret='\'';
 return str+2;
 }
 else if(str[1]=='\"')
 {
 *ret='\"';
 return str+2;
 }
 else if(str[1]=='\?')
 {
 *ret='\?';
 return str+2;
 }
 else if(str[1]>='0'&&str[1]<='7')
 {
 x=1;
 *ret=0;
 while(str[x]>='0'&&str[x]<='7')
 {
 *ret=(*ret<<3)+(str[x]-'0');
 ++x;
 }
 return str+x;
 }
 else if(str[1]=='x')
 {
 x=2;
 *ret=0;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 *ret=*ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 *ret=*ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 *ret=*ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 return str+x;
 }
 else
 {
 *ret='\\';
 return str+1;
 }
 }
 else
 {
 *ret=str[0];
 return str+1;
 }
}
char *dir_name(char *str)
{
 long int x,x1;
 char *ret;
 x=strlen(str);
 if(x==0)
 {
 return xstrdup(".");
 }
 ret=xstrdup(str);
 while(x&&ret[x-1]=='/')
 {
 ret[x-1]=0;
 --x;
 }
 x=0;
 if(ret[0]=='/')
 {
 x=1;
 }
 x1=x;
 while(ret[x])
 {
 if(ret[x]=='/')
 {
 x1=x;
 while(ret[x]=='/')
 {
 ++x;
 }
 }
 else
 {
 ++x;
 }
 }
 ret[x1]=0;
 if(ret[0]==0)
 {
 ret[0]='.';
 ret[1]=0;
 }
 return ret;
}
void load_file(char *current_dir,char *name,int fd,int check);
 
void do_include(char *current_dir,char *name,long int line,char *str)
{
 char c;
 char *fname,*dname,*new_dir;
 int new_fd;
 fname=0;
 str=skip_spaces(str);
 if(*str=='\"')
 {
 if(include_level==128)
 {
 error(name,line,"too many levels of #include.");
 }
 ++include_level;
 ++str;
 while(*str&&*str!='\"')
 {
 str=sgetc(str,&c);
 fname=str_c_app(fname,c);
 }
 dname=dir_name(name);
 new_dir=xstrdup(current_dir);
 new_dir=str_c_app(new_dir,'/');
 new_dir=str_s_app(new_dir,dname);
 free(dname);
 dname=xstrdup(new_dir);
 dname=str_c_app(dname,'/');
 dname=str_s_app(dname,fname);
 new_fd=__syscall((long)(2),(long)(dname),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(new_fd<0)
 {
 error(name,line,"cannot open file.");
 }
 load_file(new_dir,fname,new_fd,0);
 __syscall((long)(3),(long)(new_fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 free(new_dir);
 free(fname);
 free(dname);
 --include_level;
 }
 else
 {
 error(name,line,"expected file name in #include.");
 }
}
void load_file(char *current_dir,char *name,int fd,int check)
{
 long int flines;
 long int old_current_line;
 char *str,*str1;
 struct lines_list *node;
 long int len;
 char *word;
 flines=current_line;
 while(str=read_line(fd))
 {
 if((str1=get_ppcmd(str)))
 {
 if(!strncmp(str1,"include",7))
 {
 if(!condc)
 {
 old_current_line=current_line;
 do_include(current_dir,name,current_line-flines,str1+7);
 flines+=current_line-old_current_line;
 }
 }
 else if(!strncmp(str1,"error",5))
 {
 if(!condc)
 {
 error(name,current_line-flines,str1+6);
 }
 }
 else if(!strncmp(str1,"define",6))
 {
 if(!condc)
 {
 str1=skip_spaces(str1+7);
 word=read_word(&str1);
 if(macro_tab2_find(word))
 {
 error(name,current_line-flines,"macro redefined.");
 }
 macro_tab2_add(word);
 free(word);
 }
 }
 else if(!strncmp(str1,"undef",5))
 {
 if(!condc)
 {
 str1=skip_spaces(str1+6);
 word=read_word(&str1);
 if(!macro_tab2_find(word))
 {
 error(name,current_line-flines,"macro not defined.");
 }
 macro_tab2_del(word);
 free(word);
 }
 }
 else if(!strncmp(str1,"ifdef",5))
 {
 str1=skip_spaces(str1+6);
 word=read_word(&str1);
 ++condc_levels;
 if(!condc&&!macro_tab2_find(word))
 {
 condc=1;
 old_condc_levels=condc_levels;
 }
 free(word);
 }
 else if(!strncmp(str1,"ifndef",6))
 {
 str1=skip_spaces(str1+7);
 word=read_word(&str1);
 ++condc_levels;
 if(!condc&&macro_tab2_find(word))
 {
 condc=1;
 old_condc_levels=condc_levels;
 }
 free(word);
 }
 else if(!strncmp(str1,"endif",5))
 {
 if(!condc_levels)
 {
 error(name,current_line-flines,"#endif without #ifdef or #ifndef.");
 }
 if(old_condc_levels==condc_levels)
 {
 old_condc_levels=0;
 condc=0;
 condc_else=0;
 }
 --condc_levels;
 }
 else if(!strncmp(str1,"else",4))
 {
 if(!condc_levels||condc_else)
 {
 error(name,current_line-flines,"#else without #ifdef or #ifndef.");
 }
 if(condc==1&&old_condc_levels==condc_levels)
 {
 condc=0;
 }
 else if(condc==0)
 {
 old_condc_levels=condc_levels;
 condc=1;
 condc_else=1;
 }
 }
 else if(!condc)
 {
 error(name,current_line-flines,"unknown preprocessor command.");
 }
 }
 if(!condc)
 {
 node=xmalloc(sizeof(*node));
 node->line=current_line;
 node->fline=current_line-flines;
 node->fname=xstrdup(name);
 node->str=str;
 node->next=0;
 if(lines_head)
 {
 lines_end->next=node;
 }
 else
 {
 lines_head=node;
 }
 lines_end=node;
 }
 }
 if(check&&condc_levels)
 {
 error(name,current_line-flines,"#endif not found at end of file.");
 }
}
struct macro_tab
{
 char *name;
 char *args;
 char *def;
 long int argc;
 long int n;
 struct macro_tab *next;
} *macro_tab[1021];
void macro_tab_add(char *name,char *args,char *def,int argc)
{
 int hash;
 struct macro_tab *node;
 hash=name_hash(name);
 node=xmalloc(sizeof(*node));
 node->name=xstrdup(name);
 node->args=args;
 node->def=xstrdup(def);
 node->argc=argc;
 node->n=0;
 node->next=macro_tab[hash];
 macro_tab[hash]=node;
}
void macro_tab_del(char *name) 
{
 int hash;
 struct macro_tab *node,*p;
 hash=name_hash(name);
 node=macro_tab[hash];
 p=0;
 while(node&&strcmp(name,node->name))
 {
 p=node;
 node=node->next;
 }
 if(p)
 {
 p->next=node->next;
 }
 else
 {
 macro_tab[hash]=node->next;
 }
 free(node->name);
 free(node->args);
 free(node->def);
 free(node);
}
struct macro_tab *macro_tab_find(char *name)
{
 int hash;
 struct macro_tab *node;
 hash=name_hash(name);
 node=macro_tab[hash];
 while(node&&strcmp(name,node->name))
 {
 node=node->next;
 }
 return node;
}
char *parse_arglist1(char **str,int *argc)
{
 int n,s;
 char *ret,*word;
 n=0;
 s=0;
 if(**str!='(')
 {
 *argc=0;
 return 0;
 }
 ret=xstrdup("(");
 *str=skip_spaces(*str+1);
 while(word=read_word(str))
 {
 if(!s)
 {
 if(!is_id(word[0]))
 {
 if(n==0&&word[0]==')')
 {
 break;
 }
 else
 {
 error(current_file,current_line,"#define format error.");
 }
 }
 ++n;
 }
 else
 {
 if(word[0]==')')
 {
 break;
 }
 else if(word[0]!=',')
 {
 error(current_file,current_line,"#define format error.");
 }
 }
 ret=str_s_app(ret,word);
 free(word);
 s^=1;
 *str=skip_spaces(*str);
 }
 if(word==0)
 {
 error(current_file,current_line,"#define format error.");
 }
 ret=str_s_app(ret,word);
 free(word);
 *argc=n;
 return ret;
}
char **parse_arglist2(char **str,int *argc)
{
 int n,brackets,s;
 char *word;
 char **argv,**t,*arg;
 n=0;
 s=0;
 brackets=1;
 arg=0;
 argv=0;
 ++*str;
 while(word=read_word(str))
 {
 if(word[0]==',')
 {
 if(brackets==1)
 {
 t=xmalloc((n+1)*sizeof(void *));
 memcpy(t,argv,n*sizeof(void *));
 t[n]=arg;
 free(argv);
 argv=t;
 arg=0;
 ++n;
 }
 else
 {
 arg=str_s_app(arg,word);
 }
 }
 else if(word[0]=='(')
 {
 ++brackets;
 arg=str_s_app(arg,word);
 }
 else if(word[0]==')')
 {
 --brackets;
 if(brackets==0)
 {
 t=xmalloc((n+1)*sizeof(void *));
 memcpy(t,argv,n*sizeof(void *));
 t[n]=arg;
 free(argv);
 argv=t;
 if(s)
 {
 ++n;
 }
 free(word);
 break;
 }
 else
 {
 arg=str_s_app(arg,word);
 }
 }
 else
 {
 if(is_id(word[0])||word[0]=='\"')
 {
 s=1;
 }
 arg=str_s_app(arg,word);
 }
 free(word);
 }
 *argc=n;
 return argv;
}
int arglist_find(char *arglist,char *str)
{
 int n;
 char *word;
 n=0;
 ++arglist;
 arglist=skip_spaces(arglist);
 if(*arglist==')')
 {
 return -1;
 }
 while(word=read_word(&arglist))
 {
 if(!strcmp(word,str))
 {
 free(word);
 return n;
 }
 arglist=skip_spaces(arglist);
 if(*arglist==')')
 {
 free(word);
 break;
 }
 arglist=skip_spaces(arglist+1);
 ++n;
 free(word);
 }
 return -1;
}
void add_macro(char *name,char *str)
{
 int argc;
 char *args;
 str=skip_spaces(str)+strlen(name);
 args=parse_arglist1(&str,&argc);
 str=skip_spaces(str);
 macro_tab_add(name,args,str,argc);
}
struct word_list
{
 char *str;
 struct word_list *next;
} *word_head,*word_end;
 
void word_list_push(char *str)
{
 struct word_list *node;
 node=xmalloc(sizeof(*node));
 node->str=xstrdup(str);
 node->next=0;
 if(word_head)
 {
 word_end->next=node;
 }
 else
 {
 word_head=node;
 }
 word_end=node;
}
char *word_list_release(void)
{
 struct word_list *node;
 char *str;
 str=0;
 while(node=word_head)
 {
 word_head=node->next;
 str=str_s_app(str,node->str);
 free(node->str);
 free(node);
 }
 word_end=0;
 return str;
}
char *do_macro_replace(char *base,char **str)
{
 char *ret;
 struct macro_tab *mtab;
 char *word,*newstr,*ptr;
 char **argv;
 int argc,n;
 ret=0;
 newstr=0;
 if(base)
 {
 ret=xstrdup(base);
 }
 word=read_word(str);
 mtab=macro_tab_find(word);
 if(!mtab||mtab->n)
 {
 ret=str_s_app(ret,word);
 free(word);
 free(base);
 return ret;
 }
 else
 {
 mtab->n=1;
 if(mtab->args)
 {
 *str=skip_spaces(*str);
 if(**str!='(')
 {
 newstr=str_s_app(newstr,word);
 free(word);
 }
 else
 {
 argc=0;
 argv=parse_arglist2(str,&argc);
 if(argc!=mtab->argc)
 {
 error(current_file,current_line,"numbers of arguments did not match.");
 }
 free(word);
 ptr=mtab->def;
 while(word=read_word(&ptr))
 {
 n=arglist_find(mtab->args,word);
 if(n!=-1)
 {
 newstr=str_s_app(newstr,argv[n]);
 }
 else
 {
 newstr=str_s_app(newstr,word);
 }
 free(word);
 }
 n=0;
 while(n<argc)
 {
 free(argv[n]);
 ++n;
 }
 free(argv);
 }
 }
 else
 {
 newstr=xstrdup(mtab->def);
 free(word);
 }
 if(ptr=newstr)
 {
 while(*ptr)
 {
 ret=do_macro_replace(ret,&ptr);
 }
 }
 free(base);
 mtab->n=0;
 return ret;
 }
}
void macro_replace(void)
{
 char *str,*ret,*ptr;
 int status,n;
 str=word_list_release();
 n=0;
 do
 {
 ptr=str;
 ret=0;
 while(*ptr)
 {
 ret=do_macro_replace(ret,&ptr);
 }
 if(ret)
 {
 ++n;
 if(n>64||strlen(ret)>2048)
 {
 error(current_file,current_line,"#define is too long.");
 }
 status=strcmp(ret,str);
 }
 else
 {
 status=0;
 }
 free(str);
 str=ret;
 }
 while(status);
 if(ret)
 {
 c_write(ret,strlen(ret));
 free(ret);
 }
}
int main(int argc,char **argv)
{
 struct lines_list *l;
 char *ptr,*word,*cmd,*t;
 struct macro_tab *mtab;
 if(argc<3)
 {
 __syscall((long)(1),(long)(1),(long)("Usage: scpp <input> <output>\n"),(long)(29),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 fdi=__syscall((long)(2),(long)(argv[1]),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fdi<0)
 {
 __syscall((long)(1),(long)(1),(long)("Cannot open input file\n"),(long)(23),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 fdo=__syscall((long)(2),(long)(argv[2]),(long)(578),(long)(0644),(long)(0),(long)(0),(long)(0));
 if(fdo<0)
 {
 __syscall((long)(1),(long)(1),(long)("Cannot open output file\n"),(long)(24),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 load_file(".",argv[1],fdi,1);
 l=lines_head;
 while(l)
 {
 ptr=l->str;
 current_line=l->fline;
 current_file=l->fname;
 if(cmd=get_ppcmd(ptr))
 {
 if(!strncmp(cmd,"define",6))
 {
 t=skip_spaces(cmd+7);
 word=read_word(&t);
 if(!word||!is_id(word[0]))
 {
 error(l->fname,l->fline,"expected macro name after #define.");
 }
 add_macro(word,cmd+7);
 free(word);
 }
 else if(!strncmp(cmd,"undef",5))
 {
 t=skip_spaces(cmd+6);
 word=read_word(&t);
 if(!word||!is_id(word[0]))
 {
 error(l->fname,l->fline,"expected macro name after #undef.");
 }
 macro_tab_del(word);
 free(word);
 }
 }
 else
 {
 while(word=read_word(&ptr))
 {
 if(macro_state)
 {
 if(macro_state==1)
 {
 if(word[0]=='(')
 {
 word_list_push(word);
 macro_state=2;
 }
 else
 {
 t=word_list_release();
 c_write(t,strlen(t));
 c_write(word,strlen(word));
 free(t);
 macro_state=0;
 }
 }
 else
 {
 word_list_push(word);
 if(word[0]=='(')
 {
 ++macro_state;
 }
 else if(word[0]==')')
 {
 --macro_state;
 if(macro_state==1)
 {
 macro_state=0;
 macro_replace();
 }
 }
 }
 }
 else if(mtab=macro_tab_find(word))
 {
 word_list_push(word);
 if(mtab->args)
 {
 macro_state=1;
 }
 else
 {
 macro_replace();
 }
 }
 else
 {
 c_write(word,strlen(word));
 }
 free(word);
 }
 c_write("\n",1);
 }
 l=l->next;
 }
 out_flush();
 __syscall((long)(3),(long)(fdi),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fdo),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 0;
}
namespace scc;
int fdi,fdo;
void *xmalloc(long int size)
{
 void *ptr;
 ptr=malloc(size+16);
 if(ptr==0)
 {
 __syscall((long)(1),(long)(2),(long)("FATAL: cannot allocate memory.\n"),(long)(31),(long)(0),(long)(0),(long)(0));
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 return ptr;
}
long int __str_size(long int size)
{
 long int val;
 val=128;
 while(val<size)
 {
 val=val*3>>1;
 }
 return val;
}
char *xstrdup(char *str)
{
 long int l;
 char *new_str;
 l=strlen(str);
 new_str=xmalloc(__str_size(l+1));
 memcpy(new_str,str,l);
 new_str[l]=0;
 return new_str;
}
 
char *str_c_app(char *s,int c)
{
 char *new_str;
 long int l,l1,l2;
 if(s==0)
 {
 new_str=xmalloc(128);
 new_str[0]=c;
 new_str[1]=0;
 }
 else
 {
 l=strlen(s);
 l1=__str_size(l+1);
 l2=__str_size(l+2);
 if(l1==l2)
 {
 new_str=s;
 new_str[l]=c;
 new_str[l+1]=0;
 }
 else
 {
 new_str=xmalloc(l2);
 memcpy(new_str,s,l);
 new_str[l]=c;
 new_str[l+1]=0;
 free(s);
 }
 }
 return new_str;
}
char *str_c_app2(char *s,long off,int c)
{
 char *new_str;
 long int l,l1,l2;
 if(s==0)
 {
 new_str=xmalloc(128);
 new_str[0]=c;
 new_str[1]=0;
 }
 else
 {
 l=strlen(s+off)+off;
 l1=__str_size(l+1);
 l2=__str_size(l+2);
 if(l1==l2)
 {
 new_str=s;
 new_str[l]=c;
 new_str[l+1]=0;
 }
 else
 {
 new_str=xmalloc(l2);
 memcpy(new_str,s,l);
 new_str[l]=c;
 new_str[l+1]=0;
 free(s);
 }
 }
 return new_str;
}
char *str_s_app(char *s,char *s2)
{
 while(*s2)
 {
 s=str_c_app(s,*s2);
 s2=s2+1;
 }
 return s;
}
char *str_i_app(char *s,unsigned long int n)
{
 unsigned long int a;
 a=10000000000000000000;
 int c;
 if(n==0)
 {
 return str_c_app(s,'0');
 }
 while(a>n)
 {
 a/=10;
 }
 while(a)
 {
 c=n/a;
 n%=a;
 a/=10;
 s=str_c_app(s,c+'0');
 }
 return s;
}
struct stream
{
 unsigned char data[4084];
 int size;
 struct stream *next;
} *stream_start,*stream_end;
int stream_in_pos;
void stream_putc(int c)
{
 struct stream *node;
 if(stream_end&&stream_end->size<4084)
 {
 stream_end->data[stream_end->size]=c;
 ++stream_end->size;
 return;
 }
 node=xmalloc(sizeof(*node));
 node->data[0]=c;
 node->size=1;
 node->next=0;
 if(stream_end)
 {
 stream_end->next=node;
 }
 else
 {
 stream_start=node;
 }
 stream_end=node;
}
int stream_getc(void)
{
 int c;
 struct stream *node;
 if(stream_start==0)
 {
 return -1;
 }
 c=(unsigned int)stream_start->data[stream_in_pos];
 ++stream_in_pos;
 if(stream_in_pos>=stream_start->size)
 {
 stream_in_pos=0;
 node=stream_start;
 stream_start=stream_start->next;
 free(node);
 }
 return c;
}
namespace scc_front;
 
void error(int line,int col,char *msg)
{
 char *str;
 str=scc__xstrdup("line ");
 str=scc__str_i_app(str,line);
 str=scc__str_s_app(str," column ");
 str=scc__str_i_app(str,col);
 str=scc__str_s_app(str,": error: ");
 str=scc__str_s_app(str,msg);
 str=scc__str_c_app(str,'\n');
 __syscall((long)(1),(long)(2),(long)(str),(long)(strlen(str)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(231),(long)(2),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
}
int name_hash(char *str)
{
 unsigned int hash;
 hash=0;
 while(*str)
 {
 hash=(hash<<11|hash>>21)+*str;
 ++str;
 }
 return hash%1021;
}
int l_ungetc_buf;
int l_current_line;
int l_current_col;
int l_old_line;
int l_old_col;
int l_readc(void)
{
 static unsigned char buf[65536];
 static int x,n;
 int n1,c;
 if(x==n)
 {
 n1=__syscall((long)(0),(long)(scc__fdi),(long)(buf),(long)(65536),(long)(0),(long)(0),(long)(0));
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
 l_old_line=l_current_line;
 l_old_col=l_current_col;
 if(c=='\n')
 {
 ++l_current_line;
 l_current_col=1;
 }
 else
 {
 ++l_current_col;
 }
 return c;
 }
 if((c=l_readc())!=-1)
 {
 l_old_line=l_current_line;
 l_old_col=l_current_col;
 if(c=='\n')
 {
 ++l_current_line;
 l_current_col=1;
 }
 else
 {
 ++l_current_col;
 }
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
 l_current_line=l_old_line;
 l_current_col=l_old_col;
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
 s=scc__str_c_app(s,c);
 while((c1=l_getc())!=-1)
 {
 s=scc__str_c_app2(s,x,c1);
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
 s=scc__str_c_app2(s,x,c1);
 ++x;
 }
 else if(c1=='\n'||c1=='\r')
 {
 error(line,col,"string not complete.");
 }
 ++x;
 }
 if(c1==-1)
 {
 error(line,col,"string not complete.");
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
 s=scc__str_c_app2(s,x,c);
 c=l_getc();
 while(c>='A'&&c<='Z'||c>='a'&&c<='z'||c>='0'&&c<='9'||c=='_'||c=='.')
 {
 if(c=='.')
 {
 if(s1==0)
 {
 s=scc__str_c_app2(s,x,c);
 ++x;
 c=l_getc();
 s1=1;
 }
 else
 {
 break;
 }
 }
 s=scc__str_c_app2(s,x,c);
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
 s=scc__str_c_app(s,c);
 if(c=='-')
 {
 c=l_getc();
 if(c=='>'||c=='='||c=='-')
 {
 s=scc__str_c_app(s,c);
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
 s=scc__str_c_app(s,c);
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
 s=scc__str_c_app(s,c);
 }
 else if(c=='<')
 {
 s=scc__str_c_app(s,c);
 c=l_getc();
 if(c=='=')
 {
 s=scc__str_c_app(s,c);
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
 s=scc__str_c_app(s,c);
 }
 else if(c=='>')
 {
 s=scc__str_c_app(s,c);
 c=l_getc();
 if(c=='=')
 {
 s=scc__str_c_app(s,c);
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
 s=scc__str_c_app(s,c);
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
 s=scc__str_c_app(s,c);
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
 s=scc__str_c_app(s,c);
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
 s=scc__str_c_app(s,c);
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
 s=scc__str_c_app(s,c);
 }
 else if(c!=-1)
 {
 l_ungetc(c);
 }
 }
 else if(!(c=='['||c==']'||c=='('||c==')'||c=='{'||c=='}'||c=='.'||c=='~'||c=='\?'||c==':'||c==','||c==';'))
 {
 msg=scc__xstrdup("unrecognized character \'");
 msg=scc__str_c_app(msg,c);
 msg=scc__str_c_app(msg,'\'');
 error(line,col,msg);
 }
 return s;
}
struct l_word_list
{
 char *str;
 int line;
 int col;
 struct l_word_list *next;
} *l_words_head,*l_words_end;
void load_file(void)
{
 char *s;
 struct l_word_list *node;
 int line,col;
 line=l_current_line;
 col=l_current_col;
 while(s=l_read_word())
 {
 node=scc__xmalloc(sizeof(*node));
 node->str=s;
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
void l_global_init(void)
{
 l_ungetc_buf=-1;
 l_current_line=1;
 l_current_col=1;
 l_old_line=1;
 l_old_col=1;
}
struct syntax_tree
{
 char *name;
 char *value;
 long int line;
 long int col;
 long int count_subtrees;
 struct syntax_tree **subtrees;
};
struct syntax_tree *mkst(char *name,char *value,long int line,long int col)
{
 struct syntax_tree *node;
 node=scc__xmalloc(sizeof(*node));
 if(value)
 {
 node->value=scc__xstrdup(value);
 }
 else
 {
 node->value=0;
 }
 node->name=name;
 node->count_subtrees=0;
 node->subtrees=0;
 node->line=line;
 node->col=col;
 return node;
}
void st_add_subtree(struct syntax_tree *st,struct syntax_tree *subtree)
{
 struct syntax_tree **subtrees;
 subtrees=scc__xmalloc((st->count_subtrees+1)*sizeof(void *));
 memcpy(subtrees,st->subtrees,st->count_subtrees*sizeof(void*));
 subtrees[st->count_subtrees]=subtree;
 ++st->count_subtrees;
 free(st->subtrees);
 st->subtrees=subtrees;
}
void syntax_tree_release(struct syntax_tree *root)
{
 int x;
 x=0;
 if(root==0)
 {
 return;
 }
 while(x<root->count_subtrees)
 {
 syntax_tree_release(root->subtrees[x]);
 ++x;
 }
 free(root->value);
 free(root->subtrees);
 free(root);
}
struct l_word_list *p_current_word;
long int p_current_line;
long int p_current_col;
void parse_next(void)
{
 if(p_current_word==0)
 {
 return;
 }
 p_current_word=p_current_word->next;
 if(p_current_word==0)
 {
 return;
 }
 p_current_line=p_current_word->line;
 p_current_col=p_current_word->col;
}
char *keyw_list[27];
int iskeyw(char *str)
{
 int x;
 x=0;
 while(keyw_list[x])
 {
 if(!strcmp(keyw_list[x],str))
 {
 return 1;
 }
 ++x;
 }
 return 0;
}
char *str_list_match(char **str_list,char *str)
{
 int x;
 x=0;
 while(str_list[x])
 {
 if(!strcmp(str_list[x],str))
 {
 return str_list[x];
 }
 ++x;
 }
 return 0;
}
int str_list_match2(char **str_list,char *str)
{
 int x;
 x=0;
 while(str_list[x])
 {
 if(!strcmp(str_list[x],str))
 {
 return x;
 }
 ++x;
 }
 return -1;
}
char *parse_cstr(void)
{
 if(!p_current_word)
 {
 return "\0";
 }
 return p_current_word->str;
}
 
struct syntax_tree *parse_id(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret;
 oldword=p_current_word;
 ret=0;
 if(p_current_word==0)
 {
 return 0;
 }
 if(parse_cstr()[0]>='A'&&parse_cstr()[0]<='Z'||parse_cstr()[0]>='a'&&parse_cstr()[0]<='z'||parse_cstr()[0]=='_')
 {
 if(!iskeyw(parse_cstr()))
 {
 ret=mkst("Identifier",parse_cstr(),p_current_line,p_current_col);
 parse_next();
 }
 }
 if(ret==0)
 {
 p_current_word=oldword;
 return 0;
 }
 return ret;
}
struct syntax_tree *parse_num_id(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret;
 int x,s;
 oldword=p_current_word;
 ret=0;
 if(p_current_word==0)
 {
 return 0;
 }
 if(parse_cstr()[0]>='0'&&parse_cstr()[0]<='9'||parse_cstr()[0]=='\''||parse_cstr()[0]=='\"')
 {
 x=0;
 s=0;
 while(parse_cstr()[x])
 {
 if(parse_cstr()[x]=='.')
 {
 s=1;
 break;
 }
 ++x;
 }
 if(parse_cstr()[0]=='\''||parse_cstr()[0]=='\"')
 {
 s=0;
 }
 if(s)
 {
 ret=mkst("FConstant",parse_cstr(),p_current_line,p_current_col);
 }
 else
 {
 ret=mkst("Constant",parse_cstr(),p_current_line,p_current_col);
 }
 parse_next();
 }
 else if(parse_cstr()[0]>='A'&&parse_cstr()[0]<='Z'||parse_cstr()[0]>='a'&&parse_cstr()[0]<='z'||parse_cstr()[0]=='_')
 {
 if(!iskeyw(parse_cstr()))
 {
 ret=mkst("Identifier",parse_cstr(),p_current_line,p_current_col);
 parse_next();
 }
 }
 if(ret==0)
 {
 p_current_word=oldword;
 return 0;
 }
 return ret;
}
struct syntax_tree *parse_type(void);
struct syntax_tree *parse_decl(void);
struct syntax_tree *parse_expr_14(void);
struct syntax_tree *parse_expr_13(void);
struct syntax_tree *parse_expr_12(void);
struct syntax_tree *parse_expr_11(void);
struct syntax_tree *parse_expr_10(void);
struct syntax_tree *parse_expr_9(void);
struct syntax_tree *parse_expr_8(void);
struct syntax_tree *parse_expr_7(void);
struct syntax_tree *parse_expr_6(void);
struct syntax_tree *parse_expr_5(void);
struct syntax_tree *parse_expr_4(void);
struct syntax_tree *parse_expr_3(void);
struct syntax_tree *parse_expr_2(void);
struct syntax_tree *parse_expr_1(void);
struct syntax_tree *parse_expr_15(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 oldword=p_current_word;
 ret=parse_expr_14();
 
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(!strcmp(parse_cstr(),","))
 {
 node2=mkst(",",0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_14();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \',\'.");
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
char *expr_14_ops[12];
struct syntax_tree *parse_expr_14(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,**end,*node,*node2;
 char *op,*msg;
 oldword=p_current_word;
 ret=parse_expr_13();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 end=&ret;
 while(op=str_list_match(expr_14_ops,parse_cstr()))
 {
 node2=mkst(op,0,p_current_line,p_current_col);
 parse_next();
 st_add_subtree(node2,*end);
 node=parse_expr_13();
 if(node==0)
 {
 msg=scc__xstrdup("expected expression after \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(p_current_line,p_current_col,msg);
 }
 st_add_subtree(node2,node);
 *end=node2;
 end=node2->subtrees+1;
 }
 return ret;
}
struct syntax_tree *parse_expr_13(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,**end,*node,*node2;
 oldword=p_current_word;
 ret=parse_expr_12();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 end=&ret;
 while(!strcmp(parse_cstr(),"\?"))
 {
 node2=mkst("?:",0,p_current_line,p_current_col);
 parse_next();
 st_add_subtree(node2,*end);
 node=parse_expr_15();
 if(node==0)
 {
 error(p_current_line,p_current_col,"expected expression after \'\?\'.");
 }
 st_add_subtree(node2,node);
 if(strcmp(parse_cstr(),":"))
 {
 error(p_current_line,p_current_col,"expected \':\' after \'\?\'.");
 }
 parse_next();
 node=parse_expr_12();
 if(node==0)
 {
 error(p_current_line,p_current_col,"expected expression after \':\'.");
 }
 st_add_subtree(node2,node);
 *end=node2;
 end=node2->subtrees+2;
 }
 return ret;
}
struct syntax_tree *parse_expr_12(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 oldword=p_current_word;
 ret=parse_expr_11();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(!strcmp(parse_cstr(),"||"))
 {
 node2=mkst("||",0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_11();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \'||\'.");
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
struct syntax_tree *parse_expr_11(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 oldword=p_current_word;
 ret=parse_expr_10();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(!strcmp(parse_cstr(),"&&"))
 {
 node2=mkst("&&",0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_10();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \'&&\'.");
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
struct syntax_tree *parse_expr_10(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 oldword=p_current_word;
 ret=parse_expr_9();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(!strcmp(parse_cstr(),"|"))
 {
 node2=mkst("|",0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_9();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \'|\'.");
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
struct syntax_tree *parse_expr_9(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 oldword=p_current_word;
 ret=parse_expr_8();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(!strcmp(parse_cstr(),"^"))
 {
 node2=mkst("^",0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_8();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \'^\'.");
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
struct syntax_tree *parse_expr_8(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 oldword=p_current_word;
 ret=parse_expr_7();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(!strcmp(parse_cstr(),"&"))
 {
 node2=mkst("&",0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_7();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \'&\'.");
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
char *expr_7_ops[3];
struct syntax_tree *parse_expr_7(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 char *op,*msg;
 oldword=p_current_word;
 ret=parse_expr_6();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(op=str_list_match(expr_7_ops,parse_cstr()))
 {
 node2=mkst(op,0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_6();
 if(!node)
 {
 msg=scc__xstrdup("expected expression after \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(p_current_line,p_current_col,msg);
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
char *expr_6_ops[5];
struct syntax_tree *parse_expr_6(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 char *op,*msg;
 oldword=p_current_word;
 ret=parse_expr_5();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(op=str_list_match(expr_6_ops,parse_cstr()))
 {
 node2=mkst(op,0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_5();
 if(!node)
 {
 msg=scc__xstrdup("expected expression after \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(p_current_line,p_current_col,msg);
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
char *expr_5_ops[3];
struct syntax_tree *parse_expr_5(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 char *op,*msg;
 oldword=p_current_word;
 ret=parse_expr_4();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(op=str_list_match(expr_5_ops,parse_cstr()))
 {
 node2=mkst(op,0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_4();
 if(!node)
 {
 msg=scc__xstrdup("expected expression after \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(p_current_line,p_current_col,msg);
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
char *expr_4_ops[3];
struct syntax_tree *parse_expr_4(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 char *op,*msg;
 oldword=p_current_word;
 ret=parse_expr_3();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(op=str_list_match(expr_4_ops,parse_cstr()))
 {
 node2=mkst(op,0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_3();
 if(!node)
 {
 msg=scc__xstrdup("expected expression after \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(p_current_line,p_current_col,msg);
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
char *expr_3_ops[4];
struct syntax_tree *parse_expr_3(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node,*node2;
 char *op,*msg;
 oldword=p_current_word;
 ret=parse_expr_2();
 if(!ret)
 {
 p_current_word=oldword;
 return 0;
 }
 while(op=str_list_match(expr_3_ops,parse_cstr()))
 {
 node2=mkst(op,0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_2();
 if(!node)
 {
 msg=scc__xstrdup("expected expression after \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(p_current_line,p_current_col,msg);
 }
 st_add_subtree(node2,ret);
 st_add_subtree(node2,node);
 ret=node2;
 }
 return ret;
}
struct syntax_tree *parse_sizeof_type(void)
{
 struct l_word_list *oldword;
 long int l,c;
 struct syntax_tree *node,*ret;
 oldword=p_current_word;
 l=p_current_line;
 c=p_current_col;
 if(strcmp(parse_cstr(),"sizeof"))
 {
 return 0;
 }
 parse_next();
 if(strcmp(parse_cstr(),"("))
 {
 p_current_word=oldword;
 return 0;
 }
 parse_next();
 node=parse_type();
 if(node==0)
 {
 p_current_word=oldword;
 return 0;
 }
 ret=mkst("sizeof_type",0,l,c);
 st_add_subtree(ret,node);
 node=parse_decl();
 if(node==0)
 {
 error(p_current_line,p_current_col,"invalid declaration.");
 }
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after declaration.");
 }
 parse_next();
 st_add_subtree(ret,node);
 return ret;
}
struct syntax_tree *parse_cast(void)
{
 struct l_word_list *oldword;
 long int l,c;
 struct syntax_tree *node,*ret;
 oldword=p_current_word;
 l=p_current_line;
 c=p_current_col;
 if(strcmp(parse_cstr(),"("))
 {
 p_current_word=oldword;
 return 0;
 }
 parse_next();
 node=parse_type();
 if(node==0)
 {
 p_current_word=oldword;
 return 0;
 }
 ret=mkst("cast",0,l,c);
 st_add_subtree(ret,node);
 node=parse_decl();
 if(node==0)
 {
 error(p_current_line,p_current_col,"invalid declaration.");
 }
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after declaration.");
 }
 parse_next();
 st_add_subtree(ret,node);
 return ret;
}
char *expr_2_ops[9];
struct syntax_tree *parse_expr_2(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node;
 char *op,*msg;
 oldword=p_current_word;
 if(ret=parse_sizeof_type())
 {
 return ret;
 }
 if(op=str_list_match(expr_2_ops,parse_cstr()))
 {
 if(!strcmp(op,"-"))
 {
 op="neg";
 }
 else if(!strcmp(op,"*"))
 {
 op="deref";
 }
 else if(!strcmp(op,"&"))
 {
 op="addr";
 }
 ret=mkst(op,0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_2();
 if(!node)
 {
 msg=scc__xstrdup("expected expression after \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(p_current_line,p_current_col,msg);
 }
 st_add_subtree(ret,node);
 }
 else if(ret=parse_cast())
 {
 node=parse_expr_2();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \')\'.");
 }
 st_add_subtree(ret,node);
 }
 else
 {
 ret=parse_expr_1();
 if(ret==0)
 {
 p_current_word=oldword;
 return 0;
 }
 }
 return ret;
}
struct syntax_tree *parse_call(void)
{
 struct syntax_tree *ret,*node;
 ret=0;
 if(!strcmp(parse_cstr(),"("))
 {
 parse_next();
 node=parse_expr_14();
 if(node==0)
 {
 ret=mkst("call_noarg",0,p_current_line,p_current_col);
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after \'(\'.");
 }
 parse_next();
 st_add_subtree(ret,0);
 }
 else
 {
 ret=mkst("call",0,p_current_line,p_current_col);
 st_add_subtree(ret,0);
 st_add_subtree(ret,node);
 while(!strcmp(parse_cstr(),","))
 {
 parse_next();
 node=parse_expr_14();
 if(node==0)
 {
 error(p_current_line,p_current_col,"expected expression after \',\'.");
 }
 st_add_subtree(ret,node);
 }
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after \'(\'.");
 }
 parse_next();
 }
 }
 return ret;
}
struct syntax_tree *parse_expr_1_suffix(void)
{
 struct syntax_tree *ret,*node;
 ret=0;
 if(!strcmp(parse_cstr(),"["))
 {
 ret=mkst("[]",0,p_current_line,p_current_col);
 parse_next();
 node=parse_expr_15();
 if(node==0)
 {
 error(p_current_line,p_current_col,"expected expression after \'(\'.");
 }
 if(strcmp(parse_cstr(),"]"))
 {
 error(p_current_line,p_current_col,"expected \']\' after \'[\'.");
 }
 parse_next();
 st_add_subtree(ret,0);
 st_add_subtree(ret,node);
 }
 else if(ret=parse_call())
 {
 return ret;
 }
 else if(!strcmp(parse_cstr(),"."))
 {
 ret=mkst(".",0,p_current_line,p_current_col);
 parse_next();
 node=parse_id();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected member name after \'.\'.");
 }
 st_add_subtree(ret,0);
 st_add_subtree(ret,node);
 }
 else if(!strcmp(parse_cstr(),"->"))
 {
 ret=mkst("->",0,p_current_line,p_current_col);
 parse_next();
 node=parse_id();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected member name after \'->\'.");
 }
 st_add_subtree(ret,0);
 st_add_subtree(ret,node);
 }
 return ret;
}
struct syntax_tree *parse_expr_1(void)
{
 struct syntax_tree *ret,*node;
 if(!strcmp(parse_cstr(),"("))
 {
 parse_next();
 ret=parse_expr_15();
 if(ret==0)
 {
 error(p_current_line,p_current_col,"expected expression after \'(\'.");
 }
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after \'(\'.");
 }
 parse_next();
 }
 else
 {
 ret=parse_num_id();
 }
 while(node=parse_expr_1_suffix())
 {
 node->subtrees[0]=ret;
 ret=node;
 }
 return ret;
}
struct syntax_tree *parse_expr(void)
{
 struct syntax_tree *ret,*node;
 if(node=parse_expr_15())
 {
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after expression.");
 }
 ret=mkst("expr",0,p_current_line,p_current_col);
 parse_next();
 st_add_subtree(ret,node);
 return ret;
 }
 return 0;
}
void expr_global_init(void)
{
 expr_14_ops[0]="=";
 expr_14_ops[1]="+=";
 expr_14_ops[2]="-=";
 expr_14_ops[3]="*=";
 expr_14_ops[4]="/=";
 expr_14_ops[5]="%=";
 expr_14_ops[6]="&=";
 expr_14_ops[7]="|=";
 expr_14_ops[8]="^=";
 expr_14_ops[9]="<<=";
 expr_14_ops[10]=">>=";
 expr_7_ops[0]="==";
 expr_7_ops[1]="!=";
 expr_6_ops[0]=">";
 expr_6_ops[1]=">=";
 expr_6_ops[2]="<";
 expr_6_ops[3]="<=";
 expr_5_ops[0]="<<";
 expr_5_ops[1]=">>";
 expr_4_ops[0]="+";
 expr_4_ops[1]="-";
 expr_3_ops[0]="/";
 expr_3_ops[1]="*";
 expr_3_ops[2]="%";
 expr_2_ops[0]="-";
 expr_2_ops[1]="++";
 expr_2_ops[2]="--";
 expr_2_ops[3]="*";
 expr_2_ops[4]="&";
 expr_2_ops[5]="!";
 expr_2_ops[6]="~";
 expr_2_ops[7]="sizeof";
}
char *basic_type_str[9];
struct syntax_tree *parse_decl(void);
struct syntax_tree *parse_type(void);
struct syntax_tree *parse_id_null(void)
{
 struct syntax_tree *ret;
 if(ret=parse_id())
 {
 return ret;
 }
 return mkst("Identifier","<NULL>",p_current_line,p_current_col);
}
struct syntax_tree *parse_basic_type(void)
{
 int t[8];
 int x;
 long int l,c;
 l=p_current_line;
 c=p_current_col;
 t[0]=0;
 t[1]=0;
 t[2]=0;
 t[3]=0;
 t[4]=0;
 t[5]=0;
 t[6]=0;
 t[7]=0;
 if(!strcmp(parse_cstr(),"void"))
 {
 parse_next();
 return mkst("void",0,l,c);
 }
 while((x=str_list_match2(basic_type_str,parse_cstr()))!=-1)
 {
 ++t[x];
 parse_next();
 }
 if(t[0]>1||t[1]>1||t[2]>1||t[3]>2||t[4]>1||t[5]>1)
 {
 error(p_current_line,p_current_col,"invalid type.");
 }
 if(t[0]+t[1]>1||t[4]+t[5]>1||t[2]&&t[3])
 {
 error(p_current_line,p_current_col,"invalid type.");
 }
 if(t[6]||t[7])
 {
 if(t[6]+t[7]>1||t[0]||t[1]||t[2]||t[3]||t[4]||t[5])
 {
 error(p_current_line,p_current_col,"invalid type.");
 }
 if(t[6])
 {
 return mkst("hfloat",0,l,c);
 }
 return mkst("float",0,l,c);
 }
 if(t[0])
 {
 if(t[4])
 {
 return mkst("u8",0,l,c);
 }
 else
 {
 return mkst("s8",0,l,c);
 }
 }
 else if(t[0]+t[1]+t[2]+t[3]+t[4]+t[5])
 {
 if(t[2])
 {
 if(t[4])
 {
 return mkst("u16",0,l,c);
 }
 else
 {
 return mkst("s16",0,l,c);
 }
 }
 else if(t[3])
 {
 if(t[4])
 {
 return mkst("u64",0,l,c);
 }
 else
 {
 return mkst("s64",0,l,c);
 }
 }
 else
 {
 if(t[4])
 {
 return mkst("u32",0,l,c);
 }
 else
 {
 return mkst("s32",0,l,c);
 }
 }
 }
 else
 {
 return 0;
 }
}
struct syntax_tree *parse_struct_union_type(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node;
 oldword=p_current_word;
 if(!strcmp(parse_cstr(),"struct"))
 {
 ret=mkst("struct",0,p_current_line,p_current_col);
 parse_next();
 }
 else if(!strcmp(parse_cstr(),"union"))
 {
 ret=mkst("union",0,p_current_line,p_current_col);
 parse_next();
 }
 else
 {
 return 0;
 }
 node=parse_id_null();
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),"{"))
 {
 return ret;
 }
 parse_next();
 while(node=parse_type())
 {
 st_add_subtree(ret,node);
 node=parse_decl();
 if(node==0)
 {
 error(p_current_line,p_current_col,"invalid declaration.\n");
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after declaration.\n");
 }
 parse_next();
 }
 if(strcmp(parse_cstr(),"}"))
 {
 error(p_current_line,p_current_col,"expected \'}\' after member list.\n");
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_type(void)
{
 struct syntax_tree *ret;
 if(ret=parse_struct_union_type())
 {
 return ret;
 }
 return parse_basic_type();
}
struct syntax_tree *parse_decl(void);
struct syntax_tree *parse_decl_array(void)
{
 struct syntax_tree *ret,*node;
 long int l,c;
 l=p_current_line;
 c=p_current_col;
 if(strcmp(parse_cstr(),"["))
 {
 return 0;
 }
 parse_next();
 if(!strcmp(parse_cstr(),"]"))
 {
 parse_next();
 ret=mkst("array_nosize",0,l,c);
 st_add_subtree(ret,0);
 return ret;
 }
 if((node=parse_expr_15())==0)
 {
 error(p_current_line,p_current_col,"expected \']\' or expression after \'[\'.");
 }
 if(strcmp(parse_cstr(),"]"))
 {
 error(p_current_line,p_current_col,"expected \']\' after expression.");
 }
 parse_next();
 ret=mkst("array",0,l,c);
 st_add_subtree(ret,0);
 st_add_subtree(ret,node);
 return ret;
}
struct syntax_tree *parse_decl_arglist(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node;
 oldword=p_current_word;
 ret=mkst("function",0,p_current_line,p_current_col);
 st_add_subtree(ret,0);
 if(!strcmp(parse_cstr(),")"))
 {
 return ret;
 }
 else if(!strcmp(parse_cstr(),"void"))
 {
 parse_next();
 if(!strcmp(parse_cstr(),")"))
 {
 return ret;
 }
 p_current_word=oldword;
 }
 while(1)
 {
 node=parse_type();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid declaration type.");
 }
 st_add_subtree(ret,node);
 node=parse_decl();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid declaration.");
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),","))
 {
 break;
 }
 parse_next();
 }
 return ret;
}
struct syntax_tree *parse_decl_function(void)
{
 struct syntax_tree *ret;
 if(strcmp(parse_cstr(),"("))
 {
 return 0;
 }
 parse_next();
 ret=parse_decl_arglist();
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after argument list.");
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_decl_pointer(void)
{
 struct l_word_list *oldword;
 struct syntax_tree *ret,*node;
 oldword=p_current_word;
 if(strcmp(parse_cstr(),"*"))
 {
 return 0;
 }
 parse_next();
 node=parse_decl();
 if(node==0)
 {
 p_current_word=oldword;
 return 0;
 }
 ret=mkst("pointer",0,p_current_line,p_current_col);
 st_add_subtree(ret,node);
 return ret;
}
struct syntax_tree *parse_decl(void)
{
 struct syntax_tree *ret,*node;
 struct l_word_list *oldword;
 oldword=p_current_word;
 if(ret=parse_decl_pointer())
 {
 return ret;
 }
 if(!strcmp(parse_cstr(),"("))
 {
 parse_next();
 ret=parse_decl();
 if(ret==0)
 {
 p_current_word=oldword;
 return 0;
 }
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after \'(\'.");
 }
 parse_next();
 }
 else
 {
 ret=parse_id_null();
 if(ret==0)
 {
 p_current_word=oldword;
 return 0;
 }
 }
 while(1)
 {
 if(node=parse_decl_array())
 {
 node->subtrees[0]=ret;
 ret=node;
 }
 else if(node=parse_decl_function())
 {
 node->subtrees[0]=ret;
 ret=node;
 }
 else
 {
 break;
 }
 }
 return ret;
}
void type_global_init(void)
{
 basic_type_str[0]="char";
 basic_type_str[1]="int";
 basic_type_str[2]="short";
 basic_type_str[3]="long";
 basic_type_str[4]="unsigned";
 basic_type_str[5]="signed";
 basic_type_str[6]="float";
 basic_type_str[7]="double";
}
struct syntax_tree *parse_stmt(void);
struct syntax_tree *parse_asm(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"asm"))
 {
 return 0;
 }
 ret=mkst("asm",0,p_current_line,p_current_col);
 parse_next();
 if(parse_cstr()[0]!='\"')
 {
 error(p_current_line,p_current_col,"expected string after \'asm\'.");
 }
 node=mkst("asm_str",parse_cstr(),p_current_line,p_current_col);
 parse_next();
 st_add_subtree(ret,node);
 return ret;
}
struct syntax_tree *parse_init(void)
{
 struct syntax_tree *ret,*node;
 if(!strcmp(parse_cstr(),"{"))
 {
 ret=mkst("init",0,p_current_line,p_current_col);
 parse_next();
 while(1)
 {
 node=parse_init();
 if(node==0)
 {
 error(p_current_line,p_current_col,"invalid expression in initializer.");
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),","))
 {
 break;
 }
 parse_next();
 }
 if(strcmp(parse_cstr(),"}"))
 {
 error(p_current_line,p_current_col,"expected \'}\' after expression.");
 }
 parse_next();
 return ret;
 }
 return parse_expr_14();
}
struct syntax_tree *parse_decl_stmt(void)
{
 struct syntax_tree *ret,*node,*t;
 if(node=parse_type())
 {
 ret=mkst("decl",0,p_current_line,p_current_col);
 st_add_subtree(ret,node);
 while(1)
 {
 node=parse_decl();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid declaration.");
 }
 st_add_subtree(ret,node);
 if(!strcmp(parse_cstr(),"="))
 {
 parse_next();
 node=parse_init();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid initializer.");
 }
 t=mkst("Init",0,p_current_line,p_current_col);
 st_add_subtree(t,node);
 st_add_subtree(ret,t);
 }
 if(strcmp(parse_cstr(),","))
 {
 break;
 }
 parse_next();
 }
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after declarations.");
 }
 parse_next();
 return ret;
 }
 return 0;
}
struct syntax_tree *parse_extern_decl_stmt(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"extern"))
 {
 return 0;
 }
 parse_next();
 if(node=parse_type())
 {
 ret=mkst("extern_decl",0,p_current_line,p_current_col);
 st_add_subtree(ret,node);
 while(1)
 {
 node=parse_decl();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid declaration.");
 }
 st_add_subtree(ret,node);
 if(!strcmp(parse_cstr(),"="))
 {
 parse_next();
 node=parse_init();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid initializer.");
 }
 st_add_subtree(ret,node);
 }
 if(strcmp(parse_cstr(),","))
 {
 break;
 }
 parse_next();
 }
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after declarations.");
 }
 parse_next();
 return ret;
 }
 return 0;
}
struct syntax_tree *parse_static_decl_stmt(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"static"))
 {
 return 0;
 }
 parse_next();
 if(node=parse_type())
 {
 ret=mkst("static_decl",0,p_current_line,p_current_col);
 st_add_subtree(ret,node);
 while(1)
 {
 node=parse_decl();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid declaration.");
 }
 st_add_subtree(ret,node);
 if(!strcmp(parse_cstr(),"="))
 {
 parse_next();
 node=parse_init();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid initializer.");
 }
 st_add_subtree(ret,node);
 }
 if(strcmp(parse_cstr(),","))
 {
 break;
 }
 parse_next();
 }
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after declarations.");
 }
 parse_next();
 return ret;
 }
 return 0;
}
struct syntax_tree *parse_stmt_block(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"{"))
 {
 return 0;
 }
 ret=mkst("block",0,p_current_line,p_current_col);
 parse_next();
 while(node=parse_stmt())
 {
 st_add_subtree(ret,node);
 }
 if(strcmp(parse_cstr(),"}"))
 {
 error(p_current_line,p_current_col,"expected \'}\' after statement.");
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_if_stmt(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"if"))
 {
 return 0;
 }
 ret=mkst("if",0,p_current_line,p_current_col);
 parse_next();
 if(strcmp(parse_cstr(),"("))
 {
 error(p_current_line,p_current_col,"expected \'(\' after \'if\'.");
 }
 parse_next();
 node=parse_expr_15();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \'(\'.");
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after expression.");
 }
 parse_next();
 node=parse_stmt();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid statement.");
 }
 st_add_subtree(ret,node);
 if(!strcmp(parse_cstr(),"else"))
 {
 parse_next();
 node=parse_stmt();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid statement.");
 }
 st_add_subtree(ret,node);
 ret->name="ifelse";
 }
 return ret;
}
struct syntax_tree *parse_while_stmt(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"while"))
 {
 return 0;
 }
 ret=mkst("while",0,p_current_line,p_current_col);
 parse_next();
 if(strcmp(parse_cstr(),"("))
 {
 error(p_current_line,p_current_col,"expected \'(\' after \'while\'.");
 }
 parse_next();
 node=parse_expr_15();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \'(\'.");
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after expression.");
 }
 parse_next();
 node=parse_stmt();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid statement.");
 }
 st_add_subtree(ret,node);
 return ret;
}
struct syntax_tree *parse_dowhile_stmt(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"do"))
 {
 return 0;
 }
 ret=mkst("dowhile",0,p_current_line,p_current_col);
 parse_next();
 node=parse_stmt();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid statement.");
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),"while"))
 {
 error(p_current_line,p_current_col,"expected \'while\' after \'do\'.");
 }
 parse_next();
 if(strcmp(parse_cstr(),"("))
 {
 error(p_current_line,p_current_col,"expected \'(\' after \'while\'.");
 }
 parse_next();
 node=parse_expr_15();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected expression after \'(\'.");
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),")"))
 {
 error(p_current_line,p_current_col,"expected \')\' after expression.");
 }
 parse_next();
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after \')\'.");
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_return_stmt(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"return"))
 {
 return 0;
 }
 ret=mkst("return",0,p_current_line,p_current_col);
 parse_next();
 if(node=parse_expr_15())
 {
 st_add_subtree(ret,node);
 }
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after expression.");
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_break_stmt(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"break"))
 {
 return 0;
 }
 ret=mkst("break",0,p_current_line,p_current_col);
 parse_next();
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after expression.");
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_goto_stmt(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"goto"))
 {
 return 0;
 }
 ret=mkst("goto",0,p_current_line,p_current_col);
 parse_next();
 node=parse_id();
 if(!node)
 {
 error(p_current_line,p_current_col,"expected label name after \'goto\'.");
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after expression.");
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_label_stmt(void)
{
 struct syntax_tree *ret,*node;
 struct l_word_list *oldword;
 oldword=p_current_word;
 ret=mkst("Label",0,p_current_line,p_current_col);
 node=parse_id();
 if(!node)
 {
 syntax_tree_release(ret);
 p_current_word=oldword;
 return 0;
 }
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),":"))
 {
 syntax_tree_release(ret);
 p_current_word=oldword;
 return 0;
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_namespace(void)
{
 struct syntax_tree *ret,*node;
 if(strcmp(parse_cstr(),"namespace"))
 {
 return 0;
 }
 ret=mkst("namespace",0,p_current_line,p_current_col);
 parse_next();
 node=parse_id_null();
 st_add_subtree(ret,node);
 if(strcmp(parse_cstr(),";"))
 {
 error(p_current_line,p_current_col,"expected \';\' after expression.");
 }
 parse_next();
 return ret;
}
struct syntax_tree *parse_stmt(void)
{
 struct syntax_tree *ret;
 if(ret=parse_label_stmt())
 {
 return ret;
 }
 if(ret=parse_stmt_block())
 {
 return ret;
 }
 if(ret=parse_static_decl_stmt())
 {
 return ret;
 }
 if(ret=parse_extern_decl_stmt())
 {
 return ret;
 }
 if(ret=parse_decl_stmt())
 {
 return ret;
 }
 if(ret=parse_expr())
 {
 return ret;
 }
 if(ret=parse_asm())
 {
 return ret;
 }
 if(ret=parse_if_stmt())
 {
 return ret;
 }
 if(ret=parse_while_stmt())
 {
 return ret;
 }
 if(ret=parse_dowhile_stmt())
 {
 return ret;
 }
 if(ret=parse_return_stmt())
 {
 return ret;
 }
 if(ret=parse_break_stmt())
 {
 return ret;
 }
 if(ret=parse_goto_stmt())
 {
 return ret;
 }
 if(!strcmp(parse_cstr(),";"))
 {
 ret=mkst("null",0,p_current_line,p_current_col);
 parse_next();
 return ret;
 }
 return 0;
}
struct syntax_tree *parse_fundef(void)
{
 int n;
 struct syntax_tree *ret,*node,*t;
 n=0;
 if(node=parse_type())
 {
 ret=mkst("decl",0,p_current_line,p_current_col);
 st_add_subtree(ret,node);
 while(1)
 {
 node=parse_decl();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid declaration.");
 }
 st_add_subtree(ret,node);
 if(!strcmp(parse_cstr(),"="))
 {
 parse_next();
 node=parse_init();
 if(!node)
 {
 error(p_current_line,p_current_col,"invalid initializer.");
 }
 t=mkst("Init",0,p_current_line,p_current_col);
 st_add_subtree(t,node);
 st_add_subtree(ret,t);
 }
 ++n;
 if(strcmp(parse_cstr(),","))
 {
 break;
 }
 parse_next();
 }
 if(strcmp(parse_cstr(),";"))
 {
 if(n==1&&!strcmp(parse_cstr(),"{"))
 {
 node=parse_stmt_block();
 if(node==0)
 {
 error(p_current_line,p_current_col,"invalid function definition.");
 }
 st_add_subtree(ret,node);
 ret->name="fundef";
 return ret;
 }
 error(p_current_line,p_current_col,"expected \';\' after declarations.");
 }
 parse_next();
 return ret;
 }
 return 0;
}
 
struct syntax_tree *parse_file(void)
{
 struct syntax_tree *ret,*node;
 ret=mkst("file",0,p_current_line,p_current_col);
 while(1)
 {
 if(node=parse_fundef())
 {
 st_add_subtree(ret,node);
 }
 else if(node=parse_namespace())
 {
 st_add_subtree(ret,node);
 }
 else if(node=parse_asm())
 {
 st_add_subtree(ret,node);
 }
 else
 {
 break;
 }
 }
 return ret;
}
 
void parse_global_init(void)
{
 p_current_line=1;
 p_current_col=1;
 keyw_list[0]="break";
 keyw_list[1]="char";
 keyw_list[2]="do";
 keyw_list[3]="double";
 keyw_list[4]="else";
 keyw_list[5]="extern";
 keyw_list[6]="float";
 keyw_list[7]="goto";
 keyw_list[8]="if";
 keyw_list[9]="int";
 keyw_list[10]="long";
 keyw_list[11]="return";
 keyw_list[12]="short";
 keyw_list[13]="signed";
 keyw_list[14]="sizeof";
 keyw_list[15]="static";
 keyw_list[16]="union";
 keyw_list[17]="unsigned";
 keyw_list[18]="void";
 keyw_list[19]="while";
 keyw_list[20]="asm";
 keyw_list[21]="namespace";
}
struct syntax_tree *syntax_tree_dup(struct syntax_tree *root)
{
 struct syntax_tree *node;
 int x;
 x=0;
 if(root==0)
 {
 return 0;
 }
 node=scc__xmalloc(sizeof(*node));
 memcpy(node,root,sizeof(*node));
 if(node->value)
 {
 node->value=scc__xstrdup(root->value);
 }
 if(node->count_subtrees)
 {
 node->subtrees=scc__xmalloc(node->count_subtrees*sizeof(void *));
 while(x<node->count_subtrees)
 {
 node->subtrees[x]=syntax_tree_dup(root->subtrees[x]);
 ++x;
 }
 }
 return node;
}
struct id_tab
{
 char *name;
 struct syntax_tree *type;
 struct syntax_tree *decl;
 struct id_tab *next;
 long int def;
};
struct struct_tab
{
 char *name;
 struct syntax_tree *decl;
 struct struct_tab *next;
};
struct translate_stack
{
 struct id_tab *local_id[1021];
 long int num;
 struct translate_stack *next;
};
struct control_labels
{
 long int l1;
 long int l2;
 long int l3;
 struct control_labels *next;
};
char *current_namespace;
char *get_namespace(void)
{
 if(current_namespace==0||!strcmp(current_namespace,"<NULL>"))
 {
 return 0;
 }
 return current_namespace;
}
struct translate_env
{
 long int next_num;
 long int next_label;
 struct id_tab *global_id[1021];
 struct struct_tab *struct_tab[1021];
 struct struct_tab *union_tab[1021];
 struct translate_stack *stack;
 int write;
 int label_in_use;
 long int func_num;
 struct control_labels *label;
 struct control_labels *break_label;
 long int func_type;
} t_env;
struct expr_ret
{
 unsigned long int value;
 int is_lval;
 short int is_const;
 short int needs_deref;
 long ptr_offset;
 struct syntax_tree *type;
 struct syntax_tree *decl;
};
void expr_ret_release(struct expr_ret *ret)
{
 syntax_tree_release(ret->type);
 syntax_tree_release(ret->decl);
}
void calculate_expr(struct syntax_tree *root,struct expr_ret *ret);
struct struct_tab *_struct_tab_find(struct struct_tab **tab,char *name)
{
 int hash;
 struct struct_tab *node;
 hash=name_hash(name);
 node=tab[hash];
 while(node)
 {
 if(!strcmp(node->name,name))
 {
 return node;
 }
 node=node->next;
 }
 return 0;
}
struct struct_tab *struct_tab_find(struct struct_tab **tab,char *name)
{
 char *new_name;
 char *ns;
 struct struct_tab *ret;
 ns=get_namespace();
 if(ns)
 {
 new_name=scc__xstrdup(ns);
 new_name=scc__str_s_app(new_name,"__");
 new_name=scc__str_s_app(new_name,name);
 ret=_struct_tab_find(tab,new_name);
 free(new_name);
 if(ret)
 {
 return ret;
 }
 }
 return _struct_tab_find(tab,name);
}
void _struct_tab_add(struct struct_tab **tab,char *name,struct syntax_tree *decl)
{
 int hash;
 struct struct_tab *node;
 hash=name_hash(name);
 node=scc__xmalloc(sizeof(node));
 node->name=name;
 node->decl=decl;
 node->next=tab[hash];
 tab[hash]=node;
}
void struct_tab_add(struct struct_tab **tab,char *name,struct syntax_tree *decl)
{
 char *new_name;
 char *ns;
 struct struct_tab *ret;
 ns=get_namespace();
 if(ns)
 {
 new_name=scc__xstrdup(ns);
 new_name=scc__str_s_app(new_name,"__");
 new_name=scc__str_s_app(new_name,name);
 _struct_tab_add(tab,new_name,decl);
 }
 else
 {
 _struct_tab_add(tab,name,decl);
 }
}
struct id_tab *id_tab_find(struct id_tab **tab,char *name)
{
 int hash;
 struct id_tab *node;
 hash=name_hash(name);
 node=tab[hash];
 while(node)
 {
 if(!strcmp(node->name,name))
 {
 return node;
 }
 node=node->next;
 }
 return 0;
}
void id_tab_add(struct id_tab **tab,char *name,struct syntax_tree *type,struct syntax_tree *decl,int def)
{
 int hash;
 struct id_tab *node;
 hash=name_hash(name);
 node=scc__xmalloc(sizeof(*node));
 node->name=name;
 node->type=type;
 node->decl=decl;
 node->def=def;
 node->next=tab[hash];
 tab[hash]=node;
}
struct id_tab *id_find(char *name)
{
 char *name1;
 struct translate_stack *node;
 struct id_tab *ret;
 char *new_name;
 char *ns;
 node=t_env.stack;
 while(node)
 {
 name1=scc__xstrdup("_$lo");
 name1=scc__str_i_app(name1,node->num);
 name1=scc__str_s_app(name1,"$");
 name1=scc__str_s_app(name1,name);
 if(ret=id_tab_find(node->local_id,name1))
 {
 free(name1);
 return ret;
 }
 if(ret=id_tab_find(t_env.global_id,name1))
 {
 free(name1);
 return ret;
 }
 free(name1);
 node=node->next;
 }
 ns=get_namespace();
 if(ns)
 {
 new_name=scc__xstrdup(ns);
 new_name=scc__str_s_app(new_name,"__");
 new_name=scc__str_s_app(new_name,name);
 ret=id_tab_find(t_env.global_id,new_name);
 free(new_name);
 if(ret)
 {
 return ret;
 }
 }
 return id_tab_find(t_env.global_id,name);
}
struct id_tab *id_find2(char *name)
{
 char *name1;
 struct translate_stack *node;
 struct id_tab *ret;
 char *new_name;
 char *ns;
 node=t_env.stack;
 if(node)
 {
 name1=scc__xstrdup("_$lo");
 name1=scc__str_i_app(name1,node->num);
 name1=scc__str_s_app(name1,"$");
 name1=scc__str_s_app(name1,name);
 if(ret=id_tab_find(node->local_id,name1))
 {
 free(name1);
 return ret;
 }
 if(ret=id_tab_find(t_env.global_id,name1))
 {
 free(name1);
 return ret;
 }
 free(name1);
 return 0;
 }
 ns=get_namespace();
 if(ns)
 {
 new_name=scc__xstrdup(ns);
 new_name=scc__str_s_app(new_name,"__");
 new_name=scc__str_s_app(new_name,name);
 ret=id_tab_find(t_env.global_id,new_name);
 free(new_name);
 if(ret)
 {
 return ret;
 }
 }
 return id_tab_find(t_env.global_id,name);
}
void translate_stack_push(void)
{
 struct translate_stack *node;
 node=scc__xmalloc(sizeof(*node));
 memset(node,0,sizeof(*node));
 node->num=t_env.next_num;
 ++t_env.next_num;
 node->next=t_env.stack;
 t_env.stack=node;
}
void translate_stack_pop(void)
{
 struct translate_stack *node;
 struct id_tab *tab,*t;
 int x;
 x=0;
 node=t_env.stack;
 while(x<1021)
 {
 tab=node->local_id[x];
 while(tab)
 {
 t=tab;
 tab=t->next;
 syntax_tree_release(t->type);
 syntax_tree_release(t->decl);
 free(t->name);
 free(t);
 }
 ++x;
 }
 
 t_env.stack=node->next;
 free(node);
}
void control_label_push(void)
{
 struct control_labels *node;
 node=scc__xmalloc(sizeof(*node));
 t_env.next_label+=3;
 node->l1=t_env.next_label;
 node->l2=t_env.next_label+1;
 node->l3=t_env.next_label+2;
 node->next=t_env.label;
 t_env.label=node;
}
void control_label_pop(void)
{
 struct control_labels *node;
 node=t_env.label;
 t_env.label=node->next;
 free(node);
}
int is_global(void)
{
 if(t_env.stack==0)
 {
 return 1;
 }
 return 0;
}
void outc(char c)
{
 scc__stream_putc(c);
}
void out_flush(void)
{
}
void c_write(char *buf,int size)
{
 if(t_env.write)
 {
 return;
 }
 while(size)
 {
 outc(*buf);
 ++buf;
 --size;
 }
}
void c_write_num(unsigned long num)
{
 char *buf;
 buf=scc__str_i_app(0,num);
 c_write(buf,strlen(buf));
 free(buf);
}
unsigned long int type_size(struct syntax_tree *type,struct syntax_tree *decl);
int is_pointer(struct syntax_tree *decl);
struct syntax_tree *array_function_to_pointer(struct syntax_tree *decl);
void translate_block(struct syntax_tree *root,int push);
struct syntax_tree *get_struct_member_list(struct syntax_tree *type,int def);
char *get_decl_id(struct syntax_tree *decl)
{
 while(strcmp(decl->name,"Identifier"))
 {
 decl=decl->subtrees[0];
 }
 return decl->value;
}
struct syntax_tree *get_decl_type(struct syntax_tree *decl)
{
 if(!strcmp(decl->name,"Identifier"))
 {
 return decl;
 }
 while(strcmp(decl->subtrees[0]->name,"Identifier"))
 {
 decl=decl->subtrees[0];
 }
 return decl;
}
struct syntax_tree *decl_next(struct syntax_tree *decl)
{
 struct syntax_tree *node,*t,*t1,*tp;
 tp=0;
 node=syntax_tree_dup(decl);
 if(!strcmp(decl->name,"Identifier"))
 {
 return node;
 }
 t=get_decl_type(decl);
 t=t->subtrees[0];
 t1=syntax_tree_dup(t);
 t=node;
 while(strcmp(t->subtrees[0]->name,"Identifier"))
 {
 tp=t;
 t=t->subtrees[0];
 }
 syntax_tree_release(t);
 if(tp==0)
 {
 node=t1;
 }
 else
 {
 tp->subtrees[0]=t1;
 }
 return node;
}
void struct_check(struct syntax_tree *type)
{
 int x;
 struct syntax_tree *t,*d;
 struct struct_tab *node;
 x=1;
 while(x<type->count_subtrees)
 {
 t=type->subtrees[x];
 d=get_decl_type(type->subtrees[x+1]);
 if(strcmp(d->name,"pointer"))
 {
 if(!strcmp(t->name,"struct"))
 {
 node=struct_tab_find(t_env.struct_tab,t->subtrees[0]->value);
 if(!node)
 {
 error(t->line,t->col,"incomplete type.");
 }
 }
 if(!strcmp(t->name,"union"))
 {
 node=struct_tab_find(t_env.union_tab,t->subtrees[0]->value);
 if(!node)
 {
 error(t->line,t->col,"incomplete type.");
 }
 }
 }
 x+=2;
 }
}
void decl_check(struct syntax_tree *type,struct syntax_tree *decl)
{
 struct syntax_tree *t;
 int x,y;
 char *id1,*id2;
 t=decl;
 while(strcmp(decl->name,"Identifier"))
 {
 if(!strcmp(decl->subtrees[0]->name,"function"))
 {
 if(!strcmp(decl->name,"function"))
 {
 error(decl->line,decl->col,"function returning a function declared.");
 }
 if(!strcmp(decl->name,"array")||!strcmp(decl->name,"array_nosize"))
 {
 error(decl->line,decl->col,"function returning an array declared.");
 }
 }
 if(!strcmp(decl->subtrees[0]->name,"array")||!strcmp(decl->subtrees[0]->name,"array_nosize"))
 {
 if(!strcmp(decl->name,"function"))
 {
 error(decl->line,decl->col,"array of functions declared.");
 }
 }
 if(!strcmp(decl->name,"function"))
 {
 x=1;
 while(x<decl->count_subtrees)
 {
 decl_check(decl->subtrees[x],decl->subtrees[x+1]);
 if(!is_pointer(decl->subtrees[x+1]))
 {
 if(!strcmp(decl->subtrees[x]->name,"struct"))
 {
 error(decl->subtrees[x]->line,decl->subtrees[x]->col,"cannot use structure type as function argument.");
 }
 if(!strcmp(decl->subtrees[x]->name,"union"))
 {
 error(decl->subtrees[x]->line,decl->subtrees[x]->col,"cannot use union type as function argument.");
 }
 }
 x+=2;
 }
 }
 decl=decl->subtrees[0];
 }
 decl=t;
 if(!strcmp(decl->name,"Identifier"))
 {
 if(!strcmp(type->name,"void"))
 {
 error(type->line,type->col,"invalid use of \'void\'.");
 }
 }
 if(!strcmp(decl->name,"function"))
 {
 if(!strcmp(type->name,"struct"))
 {
 error(type->line,type->col,"cannot use structure type as returning value.");
 }
 if(!strcmp(type->name,"union"))
 {
 error(type->line,type->col,"cannot use union type as returning value.");
 }
 }
 if(!strcmp(decl->name,"array")||!strcmp(decl->name,"array_nosize"))
 {
 if(!strcmp(type->name,"void"))
 {
 error(type->line,type->col,"invalid use of \'void\'.");
 }
 }
 if(!strcmp(type->name,"struct")||!strcmp(type->name,"union"))
 {
 x=1;
 while(x<type->count_subtrees)
 {
 decl_check(type->subtrees[x],type->subtrees[x+1]);
 t=get_decl_type(type->subtrees[x+1]);
 if(!strcmp(t->name,"function"))
 {
 error(t->line,t->col,"cannot use function as structure or union member.");
 }
 id1=get_decl_id(type->subtrees[x+1]);
 y=x+2;
 while(y<type->count_subtrees)
 {
 id2=get_decl_id(type->subtrees[y+1]);
 t=type->subtrees[y+1];
 if(!strcmp(id1,id2))
 {
 error(t->line,t->col,"duplicate member name.");
 }
 y+=2;
 }
 x+=2;
 }
 if(!strcmp(type->subtrees[0]->value,"<NULL>"))
 {
 if(type->count_subtrees==1)
 {
 error(type->line,type->col,"no structure or union name and no member list.");
 }
 }
 else
 {
 if(type->count_subtrees==1&&!is_pointer(decl)&&!get_struct_member_list(type,0))
 {
 error(type->line,type->col,"incomplete type.");
 }
 }
 struct_check(type);
 }
}
struct syntax_tree *get_struct_member_list(struct syntax_tree *type,int def)
{
 int is_union;
 struct struct_tab *node;
 char *msg;
 if(!strcmp(type->name,"struct"))
 {
 is_union=0;
 }
 else if(!strcmp(type->name,"union"))
 {
 is_union=1;
 }
 else
 {
 return 0;
 }
 if(def&&type->count_subtrees!=1)
 {
 if(strcmp(type->subtrees[0]->value,"<NULL>"))
 {
 if(is_union)
 {
 if(struct_tab_find(t_env.union_tab,type->subtrees[0]->value))
 {
 error(type->line,type->col,"union redefined.");
 }
 struct_tab_add(t_env.union_tab,type->subtrees[0]->value,type);
 }
 else
 {
 if(struct_tab_find(t_env.struct_tab,type->subtrees[0]->value))
 {
 error(type->line,type->col,"structure redefined.");
 }
 struct_tab_add(t_env.struct_tab,type->subtrees[0]->value,type);
 }
 }
 return type;
 }
 if(is_union)
 {
 node=struct_tab_find(t_env.union_tab,type->subtrees[0]->value);
 }
 else
 {
 node=struct_tab_find(t_env.struct_tab,type->subtrees[0]->value);
 }
 if(!node)
 {
 return 0;
 }
 return node->decl;
}
int type_cmp(struct syntax_tree *type1,struct syntax_tree *decl1,struct syntax_tree *type2,struct syntax_tree *decl2)
{
 int x;
 if(strcmp(type1->name,type2->name))
 {
 return 1;
 }
 if(!strcmp(type1->name,"struct")||!strcmp(type1->name,"union"))
 {
 if(strcmp(type1->subtrees[0]->name,type2->subtrees[0]->name))
 {
 return 1;
 }
 }
 while(!strcmp(decl1->name,decl2->name))
 {
 if(!strcmp(decl1->name,"Identifier"))
 {
 return 0;
 }
 if(!strcmp(decl1->name,"function"))
 {
 x=1;
 if(decl1->count_subtrees!=decl2->count_subtrees)
 {
 return 1;
 }
 while(x<decl1->count_subtrees)
 {
 if(type_cmp(decl1->subtrees[x],decl1->subtrees[x+1],decl2->subtrees[x],decl2->subtrees[x+1]))
 {
 return 1;
 }
 x+=2;
 }
 }
 decl1=decl1->subtrees[0];
 decl2=decl2->subtrees[0];
 }
 return 1;
}
void check_decl1(struct syntax_tree *type,struct syntax_tree *decl,char *name)
{
 struct id_tab *id;
 struct syntax_tree *decl1;
 if(name==0)
 {
 name=get_decl_id(decl);
 }
 if(!strcmp(name,"<NULL>"))
 {
 return;
 }
 if(id=id_find2(name))
 {
 if(type_cmp(type,decl,id->type,id->decl))
 {
 error(type->line,type->col,"identifier redeclared as different type.");
 }
 }
}
int check_decl2(struct syntax_tree *type,struct syntax_tree *decl,char *name)
{
 struct id_tab *id;
 struct syntax_tree *decl1;
 if(name==0)
 {
 name=get_decl_id(decl);
 }
 if(!strcmp(name,"<NULL>"))
 {
 return 0;
 }
 if(id=id_find2(name))
 {
 if(id->def)
 {
 error(decl->line,decl->col,"identifier redefined.");
 }
 if(type_cmp(type,decl,id->type,id->decl))
 {
 error(decl->line,decl->col,"identifier redeclared as different type.");
 }
 return 1;
 }
 return 0;
}
void add_decl(struct syntax_tree *type,struct syntax_tree *decl,int nodefine,int force_global,struct syntax_tree *init,int no_change_name)
{
 int global,class;
 long int array_size;
 long int size;
 char *name;
 struct syntax_tree *decl1,*decl2;
 struct expr_ret result;
 char *str;
 class=0;
 array_size=-1;
 decl1=get_decl_type(decl);
 if(init)
 {
 error(init->line,init->col,"initializer not supported.");
 }
 if(!strcmp(decl1->name,"function"))
 {
 global=1;
 class=1;
 decl2=decl_next(decl);
 if(is_pointer(decl2))
 {
 t_env.func_type=0;
 }
 else if(!strcmp(type->name,"float"))
 {
 t_env.func_type=2;
 }
 else if(!strcmp(type->name,"hfloat"))
 {
 t_env.func_type=1;
 }
 else
 {
 t_env.func_type=0;
 }
 syntax_tree_release(decl2);
 }
 else
 {
 global=is_global();
 if(!strcmp(decl1->name,"array"))
 {
 class=2;
 calculate_expr(decl1->subtrees[1],&result);
 if(result.is_const==0)
 {
 error(decl->line,decl->col,"cannot determine array size.");
 }
 array_size=result.value;
 expr_ret_release(&result);
 }
 else if(!strcmp(decl1->name,"array_nosize"))
 {
 error(decl->line,decl->col,"cannot determine array size.");
 }
 }
 if(array_size==-1&&init&&!strcmp(init->name,"init"))
 {
 array_size=init->count_subtrees;
 }
 if(global||no_change_name)
 {
 char *ns;
 if(global&&strcmp(get_decl_id(decl),"<NULL>")&&(ns=get_namespace()))
 {
 name=scc__xstrdup(ns);
 name=scc__str_s_app(name,"__");
 name=scc__str_s_app(name,get_decl_id(decl));
 }
 else
 {
 name=scc__xstrdup(get_decl_id(decl));
 }
 }
 else
 {
 name=scc__xstrdup("_$lo");
 name=scc__str_i_app(name,t_env.stack->num);
 name=scc__str_s_app(name,"$");
 name=scc__str_s_app(name,get_decl_id(decl));
 }
 if(nodefine)
 {
 if(global)
 {
 check_decl1(type,decl,name);
 }
 else
 {
 check_decl1(type,decl,0);
 }
 }
 else
 {
 if(global)
 {
 if(check_decl2(type,decl,name)&&class!=1)
 {
 free(name);
 return;
 }
 }
 else
 {
 if(check_decl2(type,decl,0)&&class!=1)
 {
 free(name);
 return;
 }
 }
 }
 if(class==0)
 {
 if(global||force_global)
 {
 c_write("global ",7);
 }
 else
 {
 c_write("local ",6);
 }
 if(!strcmp(decl1->name,"pointer"))
 {
 c_write("u64 ",4);
 }
 else if(!strcmp(decl1->name,"Identifier"))
 {
 if(!strcmp(type->name,"struct")||!strcmp(type->name,"union"))
 {
 c_write("mem ",4);
 size=type_size(type,decl);
 str=scc__str_i_app(0,size);
 c_write(str,strlen(str));
 free(str);
 c_write(" ",1);
 }
 else
 {
 c_write(type->name,strlen(type->name));
 c_write(" ",1);
 }
 }
 }
 else if(class==1)
 {
 if(!nodefine)
 {
 c_write("fun ",4);
 }
 }
 else if(class==2)
 {
 if(global||force_global)
 {
 c_write("global ",7);
 }
 else
 {
 c_write("local ",6);
 }
 c_write("mem ",4);
 decl2=decl_next(decl);
 size=type_size(type,decl2);
 syntax_tree_release(decl2);
 str=scc__str_i_app(0,size*array_size);
 c_write(str,strlen(str));
 free(str);
 c_write(" ",1);
 }
 if(!nodefine||class!=1)
 {
 c_write(name,strlen(name));
 c_write("\n",1);
 }
 decl1=syntax_tree_dup(decl);
 decl2=get_decl_type(decl1);
 if(!strcmp(decl2->name,"Identifier"))
 {
 free(decl2->value);
 decl2->value=scc__xstrdup(name);
 }
 else
 {
 free(decl2->subtrees[0]->value);
 decl2->subtrees[0]->value=scc__xstrdup(name);
 }
 if(global||force_global)
 {
 id_tab_add(t_env.global_id,name,syntax_tree_dup(type),decl1,!nodefine);
 }
 else
 {
 id_tab_add(t_env.stack->local_id,name,syntax_tree_dup(type),decl1,!nodefine);
 
 }
}
void translate_decl(struct syntax_tree *root)
{
 int x;
 struct syntax_tree *type,*decl,*init,*mlist;
 struct syntax_tree *decl1;
 char *name;
 int nodefine;
 x=1;
 nodefine=0;
 type=root->subtrees[0];
 struct_check(type);
 if(mlist=get_struct_member_list(type,1))
 {
 type=mlist;
 }
 while(x<root->count_subtrees)
 {
 decl=root->subtrees[x];
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"function"))
 {
 nodefine=1;
 }
 if(x==root->count_subtrees-1)
 {
 init=0;
 }
 else
 {
 init=root->subtrees[x+1];
 if(strcmp(init->name,"Init"))
 {
 init=0;
 }
 }
 decl_check(type,decl);
 if(init)
 {
 add_decl(type,decl,nodefine,0,init->subtrees[0],0);
 
 }
 else
 {
 add_decl(type,decl,nodefine,0,0,0);
 }
 ++x;
 if(init)
 {
 ++x;
 }
 }
}
void translate_fundef(struct syntax_tree *root)
{
 struct syntax_tree *type,*decl,*block;
 struct syntax_tree *decl1,*decl2;
 int x;
 type=root->subtrees[0];
 decl=root->subtrees[1];
 block=root->subtrees[2];
 decl2=get_decl_type(decl);
 if(strcmp(decl2->name,"function"))
 {
 error(decl->line,decl->col,"declaration is not a function.");
 }
 decl_check(type,decl);
 add_decl(type,decl,0,0,0,0);
 ++t_env.func_num;
 c_write("arglist\n",8);
 x=1;
 translate_stack_push();
 while(x<decl2->count_subtrees)
 {
 decl1=array_function_to_pointer(decl2->subtrees[x+1]);
 add_decl(decl2->subtrees[x],decl1,0,0,0,0);
 x+=2;
 }
 c_write("enda\n",5);
 translate_block(block,0);
 translate_stack_pop();
 c_write("endf\n",5);
}
unsigned long int type_size(struct syntax_tree *type,struct syntax_tree *decl)
{
 struct syntax_tree *decl1,*t,*mlist;
 struct expr_ret result;
 unsigned long int ret,size;
 int x;
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"pointer"))
 {
 return 8;
 }
 if(!strcmp(decl1->name,"array"))
 {
 t=decl_next(decl);
 ret=type_size(type,t);
 syntax_tree_release(t);
 calculate_expr(decl1->subtrees[1],&result);
 if(result.is_const==0)
 {
 error(decl->line,decl->col,"cannot determine array size.");
 }
 ret*=result.value;
 expr_ret_release(&result);
 return ret;
 }
 if(!strcmp(decl1->name,"array_nosize"))
 {
 return 0;
 }
 if(!strcmp(decl1->name,"Identifier"))
 {
 if(!strcmp(type->name,"void"))
 {
 return 0;
 }
 if(!strcmp(type->name,"s8")||!strcmp(type->name,"u8"))
 {
 return 1;
 }
 if(!strcmp(type->name,"s16")||!strcmp(type->name,"u16"))
 {
 return 2;
 }
 if(!strcmp(type->name,"s32")||!strcmp(type->name,"u32"))
 {
 return 4;
 }
 if(!strcmp(type->name,"s64")||!strcmp(type->name,"u64"))
 {
 return 8;
 }
 if(!strcmp(type->name,"hfloat"))
 {
 return 4;
 }
 if(!strcmp(type->name,"float"))
 {
 return 8;
 }
 if(!strcmp(type->name,"struct"))
 {
 mlist=get_struct_member_list(type,0);
 ret=0;
 x=1;
 while(x<mlist->count_subtrees)
 {
 ret+=type_size(mlist->subtrees[x],mlist->subtrees[x+1]);
 x+=2;
 }
 return ret;
 }
 if(!strcmp(type->name,"union"))
 {
 mlist=get_struct_member_list(type,0);
 ret=0;
 x=1;
 while(x<mlist->count_subtrees)
 {
 size=type_size(mlist->subtrees[x],mlist->subtrees[x+1]);
 if(size>ret)
 {
 ret=size;
 }
 x+=2;
 }
 return ret;
 }
 }
 return 0;
}
int is_basic_type(struct syntax_tree *type)
{
 if(!strcmp(type->name,"s8")||!strcmp(type->name,"u8"))
 {
 return 1;
 }
 if(!strcmp(type->name,"s16")||!strcmp(type->name,"u16"))
 {
 return 1;
 }
 if(!strcmp(type->name,"s32")||!strcmp(type->name,"u32"))
 {
 return 1;
 }
 if(!strcmp(type->name,"s64")||!strcmp(type->name,"u64"))
 {
 return 1;
 }
 if(!strcmp(type->name,"float")||!strcmp(type->name,"hfloat"))
 {
 return 1;
 }
 return 0;
}
int is_basic_decl(struct syntax_tree *decl)
{
 struct syntax_tree *decl1;
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 return 1;
 }
 return 0;
}
int is_float_type(struct syntax_tree *type)
{
 if(!strcmp(type->name,"float")||!strcmp(type->name,"hfloat"))
 {
 return 1;
 }
 return 0;
}
int is_pointer_array_function(struct syntax_tree *decl)
{
 struct syntax_tree *decl1;
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"pointer"))
 {
 return 1;
 }
 if(!strcmp(decl1->name,"array"))
 {
 return 1;
 }
 if(!strcmp(decl1->name,"array_nosize"))
 {
 return 1;
 }
 if(!strcmp(decl1->name,"function"))
 {
 return 1;
 }
 return 0;
}
int is_pointer_array(struct syntax_tree *decl)
{
 struct syntax_tree *decl1;
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"pointer"))
 {
 return 1;
 }
 if(!strcmp(decl1->name,"array"))
 {
 return 1;
 }
 if(!strcmp(decl1->name,"array_nosize"))
 {
 return 1;
 }
 return 0;
}
int is_function(struct syntax_tree *decl)
{
 struct syntax_tree *decl1;
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"function"))
 {
 return 1;
 }
 return 0;
}
int is_array_function(struct syntax_tree *decl)
{
 struct syntax_tree *decl1;
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"function"))
 {
 return 1;
 }
 if(!strcmp(decl1->name,"array"))
 {
 return 1;
 }
 if(!strcmp(decl1->name,"array_nosize"))
 {
 return 1;
 }
 return 0;
}
int is_pointer(struct syntax_tree *decl)
{
 struct syntax_tree *decl1;
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"pointer"))
 {
 return 1;
 }
 return 0;
}
int is_void_ptr(struct syntax_tree *type,struct syntax_tree *decl)
{
 if(strcmp(type->name,"void"))
 {
 return 0;
 }
 if(strcmp(decl->name,"pointer"))
 {
 return 0;
 }
 if(strcmp(decl->subtrees[0]->name,"Identifier"))
 {
 return 0;
 }
 return 1;
}
int is_void(struct syntax_tree *type,struct syntax_tree *decl)
{
 if(strcmp(type->name,"void"))
 {
 return 0;
 }
 if(strcmp(decl->name,"Identifier"))
 {
 return 0;
 }
 return 1;
}
int if_type_compat(struct syntax_tree *type,struct syntax_tree *decl,struct syntax_tree *type2,struct syntax_tree *decl2,int option)
{
 int s1,s2;
 if(is_void(type,decl)||is_void(type2,decl2))
 {
 return 1;
 }
 s1=is_basic_type(type)&&is_basic_decl(decl)||is_pointer_array_function(decl);
 s2=is_basic_type(type2)&&is_basic_decl(decl2)||is_pointer_array_function(decl2);
 if(!s1||!s2)
 {
 return 1;
 }
 s1=is_float_type(type)&&!is_pointer_array_function(decl);
 s2=is_float_type(type2)&&!is_pointer_array_function(decl2);
 if(s1!=s2)
 {
 return 1;
 }
 return 0;
}
int is_integer_type(struct syntax_tree *type,struct syntax_tree *decl)
{
 int s1;
 if(is_void(type,decl))
 {
 return 0;
 }
 s1=is_basic_type(type)&&is_basic_decl(decl)||is_pointer_array_function(decl);
 if(!s1)
 {
 return 0;
 }
 s1=is_float_type(type)&&!is_pointer_array_function(decl);
 if(s1)
 {
 return 0;
 }
 return 1;
}
struct syntax_tree *array_function_to_pointer(struct syntax_tree *decl)
{
 struct syntax_tree *decl1,*ret,*node;
 ret=syntax_tree_dup(decl);
 decl1=get_decl_type(ret);
 if(!strcmp(decl1->name,"array"))
 {
 decl1->name="pointer";
 }
 else if(!strcmp(decl1->name,"array_nosize"))
 {
 decl1->name="pointer";
 }
 else if(!strcmp(decl1->name,"function"))
 {
 node=mkst("pointer",0,decl1->line,decl1->col);
 st_add_subtree(node,decl1->subtrees[0]);
 decl1->subtrees[0]=node;
 }
 return ret;
}
void array_function_to_pointer2(struct syntax_tree **decl)
{
 struct syntax_tree *decl1;
 decl1=array_function_to_pointer(*decl);
 syntax_tree_release(*decl);
 *decl=decl1;
}
long int get_member_offset(struct syntax_tree *type,char *name)
{
 int x;
 long int off;
 off=0;
 if(!strcmp(type->name,"union"))
 {
 x=1;
 while(x<type->count_subtrees)
 {
 if(!strcmp(get_decl_id(type->subtrees[x+1]),name))
 {
 return 0;
 }
 x+=2;
 }
 }
 else if(!strcmp(type->name,"struct"))
 {
 x=1;
 while(x<type->count_subtrees)
 {
 if(!strcmp(get_decl_id(type->subtrees[x+1]),name))
 {
 return off;
 }
 off+=type_size(type->subtrees[x],type->subtrees[x+1]);
 x+=2;
 }
 }
 return -1;
}
struct syntax_tree *get_member_type(struct syntax_tree *type,char *name)
{
 int x;
 if(!strcmp(type->name,"union"))
 {
 x=1;
 while(x<type->count_subtrees)
 {
 if(!strcmp(get_decl_id(type->subtrees[x+1]),name))
 {
 return type->subtrees[x];
 }
 x+=2;
 }
 }
 else if(!strcmp(type->name,"struct"))
 {
 x=1;
 while(x<type->count_subtrees)
 {
 if(!strcmp(get_decl_id(type->subtrees[x+1]),name))
 {
 return type->subtrees[x];
 }
 x+=2;
 }
 }
 return 0;
}
struct syntax_tree *get_member_decl(struct syntax_tree *type,char *name)
{
 int x;
 if(!strcmp(type->name,"union"))
 {
 x=1;
 while(x<type->count_subtrees)
 {
 if(!strcmp(get_decl_id(type->subtrees[x+1]),name))
 {
 return type->subtrees[x+1];
 }
 x+=2;
 }
 }
 else if(!strcmp(type->name,"struct"))
 {
 x=1;
 while(x<type->count_subtrees)
 {
 if(!strcmp(get_decl_id(type->subtrees[x+1]),name))
 {
 return type->subtrees[x+1];
 }
 x+=2;
 }
 }
 return 0;
}
void translate_static_decl(struct syntax_tree *root)
{
 int x;
 struct syntax_tree *type,*decl,*init,*mlist;
 struct syntax_tree *decl1;
 char *name;
 int nodefine;
 x=1;
 nodefine=0;
 type=root->subtrees[0];
 struct_check(type);
 if(mlist=get_struct_member_list(type,1))
 {
 type=mlist;
 }
 while(x<root->count_subtrees)
 {
 decl=root->subtrees[x];
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"function"))
 {
 nodefine=1;
 }
 if(x==root->count_subtrees-1)
 {
 init=0;
 }
 else
 {
 init=root->subtrees[x+1];
 if(strcmp(init->name,"Init"))
 {
 init=0;
 }
 }
 decl_check(type,decl);
 if(init)
 {
 add_decl(type,decl,nodefine,1,init->subtrees[0],0);
 
 }
 else
 {
 add_decl(type,decl,nodefine,1,0,0);
 }
 ++x;
 if(init)
 {
 ++x;
 }
 }
}
void translate_extern_decl(struct syntax_tree *root)
{
 int x;
 struct syntax_tree *type,*decl,*init,*mlist;
 struct syntax_tree *decl1;
 char *name;
 x=1;
 type=root->subtrees[0];
 struct_check(type);
 if(mlist=get_struct_member_list(type,1))
 {
 type=mlist;
 }
 while(x<root->count_subtrees)
 {
 decl=root->subtrees[x];
 decl1=get_decl_type(decl);
 if(x==root->count_subtrees-1)
 {
 init=0;
 }
 else
 {
 init=root->subtrees[x+1];
 if(strcmp(init->name,"Init"))
 {
 init=0;
 }
 }
 decl_check(type,decl);
 if(init)
 {
 add_decl(type,decl,1,1,init->subtrees[0],0);
 
 }
 else
 {
 add_decl(type,decl,1,1,0,0);
 }
 ++x;
 if(init)
 {
 ++x;
 }
 }
}
long int new_tmp_name;
char *mktmpname(void)
{
 char *ret;
 ++new_tmp_name;
 ret=scc__xstrdup("_$T$");
 ret=scc__str_i_app(ret,new_tmp_name);
 return ret;
}
unsigned long int const_to_num(char *str)
{
 unsigned long int ret;
 int x;
 ret=0;
 if(str[0]=='\'')
 {
 ++str;
 if(str[0]=='\\')
 {
 if(str[1]=='\\')
 {
 ret='\\';
 }
 else if(str[1]=='n')
 {
 ret='\n';
 }
 else if(str[1]=='t')
 {
 ret='\t';
 }
 else if(str[1]=='v')
 {
 ret='\v';
 }
 else if(str[1]=='r')
 {
 ret='\r';
 }
 else if(str[1]=='\'')
 {
 ret='\'';
 }
 else if(str[1]=='\"')
 {
 ret='\"';
 }
 else if(str[1]=='\?')
 {
 ret='\?';
 }
 else if(str[1]>='0'&&str[1]<='7')
 {
 x=1;
 while(str[x]>='0'&&str[x]<='7')
 {
 ret=(ret<<3)+(str[x]-'0');
 ++x;
 }
 }
 else if(str[1]=='x')
 {
 x=2;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 ret=ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 ret=ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 }
 else
 {
 ret='\\';
 }
 }
 else
 {
 ret=str[0];
 }
 }
 else if(str[0]>='1'&&str[0]<='9')
 {
 x=0;
 while(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*10+(str[x]-'0');
 ++x;
 }
 }
 else if(str[1]=='X'||str[1]=='x')
 {
 x=2;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 ret=ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 ret=ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 }
 else
 {
 x=0;
 while(str[x]>='0'&&str[x]<='7')
 {
 ret=(ret<<3)+(str[x]-'0');
 ++x;
 }
 }
 return ret;
}
double fconst_to_num(char *str)
{
 int s;
 char c;
 double n,n1;
 s=0;
 n=0.0;
 n1=0.1;
 while(c=*str)
 {
 if(c=='.')
 {
 if(!s)
 {
 s=1;
 }
 else
 {
 break;
 }
 }
 if(c>='0'&&c<='9')
 {
 if(s)
 {
 n+=n1*(double)(c-'0');
 n1*=0.1;
 }
 else
 {
 n=n*10.0+(double)(c-'0');
 }
 }
 else
 {
 break;
 }
 ++str;
 }
 return n;
}
struct syntax_tree *get_addr(struct syntax_tree *decl)
{
 struct syntax_tree *decl1,*ret,*node;
 ret=syntax_tree_dup(decl);
 decl1=get_decl_type(ret);
 node=mkst("pointer",0,decl1->line,decl1->col);
 if(!strcmp(decl1->name,"Identifier"))
 {
 st_add_subtree(node,decl1);
 return node;
 }
 st_add_subtree(node,decl1->subtrees[0]);
 decl1->subtrees[0]=node;
 return ret;
}
void calculate_id(struct syntax_tree *root,struct expr_ret *ret)
{
 struct id_tab *id;
 struct syntax_tree *decl;
 id=id_find(root->value);
 if(!id)
 {
 error(root->line,root->col,"identifier not declared.");
 }
 decl=get_decl_type(id->decl);
 ret->is_lval=1;
 if(!strcmp(decl->name,"function"))
 {
 ret->is_lval=0;
 }
 
 ret->is_const=0;
 ret->needs_deref=0;
 ret->type=syntax_tree_dup(id->type);
 ret->decl=syntax_tree_dup(id->decl);
}
void calculate_const(struct syntax_tree *root,struct expr_ret *ret)
{
 char *t_name;
 struct syntax_tree *type,*decl,*node;
 if(root->value[0]=='\"')
 {
 t_name=mktmpname();
 type=mkst("s8",0,root->line,root->col);
 node=mkst("Identifier",t_name,root->line,root->col);
 decl=mkst("pointer",0,root->line,root->col);
 st_add_subtree(decl,node);
 ret->type=type;
 ret->decl=decl;
 ret->is_lval=0;
 ret->is_const=0;
 ret->needs_deref=0;
 c_write("local u64 ",10);
 c_write(t_name,strlen(t_name));
 c_write("\n",1);
 c_write("mov ",4);
 c_write(t_name,strlen(t_name));
 c_write(" ",1);
 c_write(root->value,strlen(root->value));
 c_write("\n",1);
 }
 else
 {
 ret->is_lval=0;
 ret->is_const=1;
 ret->needs_deref=0;
 ret->type=mkst("u64",0,root->line,root->col);
 ret->decl=mkst("Identifier","<NULL>",root->line,root->col);
 ret->value=const_to_num(root->value);
 }
}
void calculate_fconst(struct syntax_tree *root,struct expr_ret *ret)
{
 char *t_name;
 t_name=mktmpname();
 ret->is_lval=0;
 ret->is_const=0;
 ret->needs_deref=0;
 ret->type=mkst("float",0,root->line,root->col);
 ret->decl=mkst("Identifier",t_name,root->line,root->col);
 c_write("local float ",12);
 c_write(t_name,strlen(t_name));
 c_write("\n",1);
 c_write("mov ",4);
 c_write(t_name,strlen(t_name));
 c_write(" ",1);
 c_write(root->value,strlen(root->value));
 c_write("\n",1);
}
void deref_ptr(struct expr_ret *ret,int line,int col)
{
 char *str,*old_name;
 struct syntax_tree *decl,*t;
 char *size;
 int s;
 s=1;
 if(!ret->needs_deref)
 {
 return;
 }
 str=mktmpname();
 decl=decl_next(ret->decl);
 syntax_tree_release(ret->decl);
 ret->decl=decl;
 t=get_decl_type(ret->decl);
 if(!strcmp(t->name,"pointer"))
 {
 old_name=t->subtrees[0]->value;
 t->subtrees[0]->value=str;
 size="q ";
 }
 else if(!strcmp(t->name,"Identifier"))
 {
 if(!strcmp(ret->type->name,"struct"))
 {
 error(line,col,"invalid use of structure.");
 }
 if(!strcmp(ret->type->name,"union"))
 {
 error(line,col,"invalid use of union.");
 }
 if(!strcmp(ret->type->name,"void"))
 {
 error(line,col,"invalid type.");
 }
 if(!strcmp(ret->type->name,"s8")||!strcmp(ret->type->name,"u8"))
 {
 size="b ";
 }
 else if(!strcmp(ret->type->name,"s16")||!strcmp(ret->type->name,"u16"))
 {
 size="w ";
 }
 else if(!strcmp(ret->type->name,"s32")||!strcmp(ret->type->name,"u32"))
 {
 size="l ";
 }
 else if(!strcmp(ret->type->name,"s64")||!strcmp(ret->type->name,"u64"))
 {
 size="q ";
 }
 else if(!strcmp(ret->type->name,"float"))
 {
 size="f ";
 }
 else if(!strcmp(ret->type->name,"hfloat"))
 {
 size="h ";
 }
 old_name=t->value;
 t->value=str;
 }
 else if(ret->ptr_offset)
 {
 s=0;
 old_name=t->subtrees[0]->value;
 t->subtrees[0]->value=str;
 array_function_to_pointer2(&ret->decl);
 str=get_decl_id(ret->decl);
 add_decl(ret->type,ret->decl,0,0,0,1);
 c_write("add ",4);
 c_write(str,strlen(str));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write_num(ret->ptr_offset);
 ret->ptr_offset=0;
 c_write("\n",1);
 free(old_name);
 }
 else
 {
 s=0;
 array_function_to_pointer2(&ret->decl);
 }
 if(s)
 {
 add_decl(ret->type,ret->decl,0,0,0,1);
 if(ret->ptr_offset)
 {
 c_write("ldo",3);
 }
 else
 {
 c_write("ld",2);
 }
 c_write(size,2);
 c_write(str,strlen(str));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 if(ret->ptr_offset)
 {
 c_write(" ",1);
 c_write_num(ret->ptr_offset);
 ret->ptr_offset=0;
 }
 c_write("\n",1);
 free(old_name);
 }
}
void scale_result(struct syntax_tree *type,struct syntax_tree *decl,long int scale)
{
 char *str,*old_str;
 struct syntax_tree *decl1;
 if(scale!=1)
 {
 str=mktmpname();
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 old_str=decl1->value;
 decl1->value=str;
 }
 else
 {
 old_str=decl1->subtrees[0]->value;
 decl1->subtrees[0]->value=str;
 }
 add_decl(type,decl,0,0,0,1);
 c_write("mul ",4);
 c_write(str,strlen(str));
 c_write(" ",1);
 c_write(old_str,strlen(old_str));
 c_write(" ",1);
 free(old_str);
 old_str=scc__str_i_app(0,scale);
 c_write(old_str,strlen(old_str));
 c_write("\n",1);
 free(old_str);
 }
}
void r_scale_result(struct syntax_tree *type,struct syntax_tree *decl,long int scale)
{
 char *str,*old_str;
 struct syntax_tree *decl1;
 if(scale!=1)
 {
 str=mktmpname();
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 old_str=decl1->value;
 decl1->value=str;
 }
 else
 {
 old_str=decl1->subtrees[0]->value;
 decl1->subtrees[0]->value=str;
 }
 add_decl(type,decl,0,0,0,1);
 c_write("div ",4);
 c_write(str,strlen(str));
 c_write(" ",1);
 c_write(old_str,strlen(old_str));
 c_write(" ",1);
 free(old_str);
 old_str=scc__str_i_app(0,scale);
 c_write(old_str,strlen(old_str));
 c_write("\n",1);
 free(old_str);
 }
}
struct branch_args
{
 long int ltrue;
 long int lfalse;
};
void write_label_name(long int num)
{
 char *str;
 str=scc__str_i_app(0,num);
 c_write(str,strlen(str));
 free(str);
}
void write_label(long int num)
{
 c_write("label ",6);
 write_label_name(num);
 c_write("\n",1);
}
void translate_branch(struct syntax_tree *root,struct branch_args *args);
void translate_branch_relop(struct syntax_tree *root,struct branch_args *args,char *ins1,char *ins2)
{
 struct expr_ret left,right;
 char *left_name,*right_name;
 int val;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(!left.is_const&&!right.is_const)
 {
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 }
 if(left.is_const&&right.is_const)
 {
 val=0;
 if(!strcmp(ins1,"bgt "))
 {
 if(left.value>right.value)
 {
 val=1;
 }
 }
 else if(!strcmp(ins1,"blt "))
 {
 if(left.value<right.value)
 {
 val=1;
 }
 }
 else if(!strcmp(ins1,"bge "))
 {
 if(left.value>=right.value)
 {
 val=1;
 }
 }
 else if(!strcmp(ins1,"ble "))
 {
 if(left.value<=right.value)
 {
 val=1;
 }
 }
 else if(!strcmp(ins1,"beq "))
 {
 if(left.value==right.value)
 {
 val=1;
 }
 }
 else if(!strcmp(ins1,"bne "))
 {
 if(left.value!=right.value)
 {
 val=1;
 }
 }
 if(val&&args->ltrue!=-1)
 {
 c_write("bal ",4);
 write_label_name(args->ltrue);
 c_write("\n",1);
 }
 else if(!val&&args->lfalse!=-1)
 {
 c_write("bal ",4);
 write_label_name(args->lfalse);
 c_write("\n",1);
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 if(left.is_const)
 {
 left_name=scc__str_i_app(0,left.value);
 }
 else
 {
 left_name=get_decl_id(left.decl);
 }
 if(right.is_const)
 {
 right_name=scc__str_i_app(0,right.value);
 }
 else
 {
 right_name=get_decl_id(right.decl);
 }
 if(args->ltrue!=-1)
 {
 c_write(ins1,4);
 c_write(left_name,strlen(left_name));
 c_write(" ",1);
 c_write(right_name,strlen(right_name));
 c_write(" ",1);
 write_label_name(args->ltrue);
 c_write("\n",1);
 if(args->lfalse!=-1)
 {
 c_write("bal ",4);
 write_label_name(args->lfalse);
 c_write("\n",1);
 }
 }
 else if(args->lfalse!=-1)
 {
 c_write(ins2,4);
 c_write(left_name,strlen(left_name));
 c_write(" ",1);
 c_write(right_name,strlen(right_name));
 c_write(" ",1);
 write_label_name(args->lfalse);
 c_write("\n",1);
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void translate_branch_and(struct syntax_tree *root,struct branch_args *args)
{
 struct branch_args left,right;
 control_label_push();
 right.ltrue=args->ltrue;
 right.lfalse=args->lfalse;
 if(args->lfalse==-1)
 {
 args->lfalse=t_env.label->l3;
 }
 left.ltrue=-1;
 left.lfalse=args->lfalse;
 translate_branch(root->subtrees[0],&left);
 translate_branch(root->subtrees[1],&right);
 write_label(t_env.label->l3);
 control_label_pop();
}
void translate_branch_or(struct syntax_tree *root,struct branch_args *args)
{
 struct branch_args left,right;
 int s;
 control_label_push();
 right.ltrue=args->ltrue;
 right.lfalse=args->lfalse;
 if(args->ltrue==-1)
 {
 args->ltrue=t_env.label->l3;
 }
 left.ltrue=args->ltrue;
 left.lfalse=-1;
 translate_branch(root->subtrees[0],&left);
 translate_branch(root->subtrees[1],&right);
 write_label(t_env.label->l3);
 control_label_pop();
}
void translate_branch_not(struct syntax_tree *root,struct branch_args *args)
{
 struct branch_args arg;
 arg.ltrue=args->lfalse;
 arg.lfalse=args->ltrue;
 translate_branch(root->subtrees[0],&arg);
}
void translate_branch(struct syntax_tree *root,struct branch_args *args)
{
 struct expr_ret result;
 char *name;
 if(!strcmp(root->name,"<="))
 {
 translate_branch_relop(root,args,"ble ","bgt ");
 }
 else if(!strcmp(root->name,">="))
 {
 translate_branch_relop(root,args,"bge ","blt ");
 }
 else if(!strcmp(root->name,"<"))
 {
 translate_branch_relop(root,args,"blt ","bge ");
 }
 else if(!strcmp(root->name,">"))
 {
 translate_branch_relop(root,args,"bgt ","ble ");
 }
 else if(!strcmp(root->name,"=="))
 {
 translate_branch_relop(root,args,"beq ","bne ");
 }
 else if(!strcmp(root->name,"!="))
 {
 translate_branch_relop(root,args,"bne ","beq ");
 }
 else if(!strcmp(root->name,"!"))
 {
 translate_branch_not(root,args);
 }
 else if(!strcmp(root->name,"&&"))
 {
 translate_branch_and(root,args);
 }
 else if(!strcmp(root->name,"||"))
 {
 translate_branch_or(root,args);
 }
 else
 {
 calculate_expr(root,&result);
 deref_ptr(&result,root->line,root->col);
 if(result.is_const)
 {
 if(result.value&&args->ltrue!=-1)
 {
 c_write("bal ",4);
 write_label_name(args->ltrue);
 c_write("\n",1);
 }
 else if(!result.value&&args->lfalse!=-1)
 {
 c_write("bal ",4);
 write_label_name(args->lfalse);
 c_write("\n",1);
 }
 expr_ret_release(&result);
 return;
 }
 name=get_decl_id(result.decl);
 if(args->ltrue!=-1)
 {
 c_write("bne ",4);
 c_write(name,strlen(name));
 c_write(" 0 ",3);
 write_label_name(args->ltrue);
 c_write("\n",1);
 if(args->lfalse!=-1)
 {
 c_write("bal ",4);
 write_label_name(args->lfalse);
 c_write("\n",1);
 }
 }
 else if(args->lfalse!=-1)
 {
 c_write("beq ",4);
 c_write(name,strlen(name));
 c_write(" 0 ",3);
 write_label_name(args->lfalse);
 c_write("\n",1);
 }
 expr_ret_release(&result);
 }
}
void calculate_assign(struct syntax_tree *root,struct expr_ret *ret,char *op1,char *op2)
{
 struct expr_ret left,right;
 char *str,*name,*tname;
 struct syntax_tree *decl1,*t;
 int size;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_lval==0||is_array_function(left.decl))
 {
 error(root->line,root->col,"lvalue required here.");
 }
 if(right.is_const)
 {
 str=scc__str_i_app(0,right.value);
 }
 else
 {
 deref_ptr(&right,root->line,root->col);
 str=scc__xstrdup(get_decl_id(right.decl));
 }
 name=get_decl_id(left.decl);
 if(left.needs_deref)
 {
 decl1=decl_next(left.decl);
 if(if_type_compat(left.type,decl1,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 t=get_decl_type(decl1);
 c_write(op2,strlen(op2));
 if(left.ptr_offset)
 {
 c_write("o",1);
 }
 if(!strcmp(t->name,"pointer"))
 {
 c_write("q ",2);
 }
 else if(!strcmp(t->name,"Identifier"))
 {
 if(!strcmp(left.type->name,"struct"))
 {
 error(root->line,root->col,"invalid use of structure.");
 }
 if(!strcmp(left.type->name,"union"))
 {
 error(root->line,root->col,"invalid use of union.");
 }
 size=type_size(left.type,decl1);
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("f ",2);
 }
 else
 {
 c_write("h ",2);
 }
 }
 else if(size==1)
 {
 c_write("b ",2);
 }
 else if(size==2)
 {
 c_write("w ",2);
 }
 else if(size==4)
 {
 c_write("l ",2);
 }
 else if(size==8)
 {
 c_write("q ",2);
 }
 else
 {
 error(root->line,root->col,"invalid assignment.");
 }
 }
 else
 {
 error(root->line,root->col,"invalid assignment.");
 }
 syntax_tree_release(decl1);
 }
 else
 {
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 c_write(op1,strlen(op1));
 c_write(" ",1);
 if(strcmp(op1,"mov"))
 {
 c_write(name,strlen(name));
 c_write(" ",1);
 }
 }
 c_write(name,strlen(name));
 c_write(" ",1);
 c_write(str,strlen(str));
 if(left.needs_deref&&left.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(left.ptr_offset);
 }
 c_write("\n",1);
 free(str);
 ret->is_lval=0;
 ret->is_const=right.is_const;
 ret->decl=syntax_tree_dup(right.decl);
 ret->type=syntax_tree_dup(right.type);
 ret->needs_deref=0;
 if(ret->is_const)
 {
 ret->value=right.value;
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_add(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 long int scale;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 scale=1;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 ret->value=left.value+right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=array_function_to_pointer(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,1))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'+\'.");
 }
 else if(!is_basic_type(right.type))
 {
 error(right.decl->line,right.decl->col,"invalid use of \'+\'.");
 }
 new_name=mktmpname();
 if(is_pointer_array_function(left.decl))
 {
 decl1=decl_next(left.decl);
 scale=type_size(left.type,decl1);
 syntax_tree_release(decl1);
 if(scale==0)
 {
 scale=1;
 }
 }
 new_decl=array_function_to_pointer(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 if(right.is_const)
 {
 right.value*=scale;
 }
 else
 {
 scale_result(right.type,right.decl,scale);
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("add ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_mul(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 ret->value=left.value*right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'*\'.");
 }
 if(is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as left operand of \'*\'.");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("mul ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_sub(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 long int scale;
 int r_scale;
 scale=1;
 r_scale=0;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 ret->value=left.value-right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=array_function_to_pointer(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,1))
 {
 error(root->line,root->col,"incompatible type.");
 }
 new_name=mktmpname();
 if(is_pointer_array_function(right.decl))
 {
 if(!is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"invalid use of \'-\'.");
 }
 decl1=decl_next(left.decl);
 scale=type_size(left.type,decl1);
 syntax_tree_release(decl1);
 if(scale==0)
 {
 scale=1;
 }
 new_type=mkst("s64",0,left.type->line,left.type->col);
 new_decl=mkst("Identifier","<NULL>",left.type->line,left.type->col);
 r_scale=1;
 }
 else 
 {
 if(is_pointer_array_function(left.decl))
 {
 decl1=decl_next(left.decl);
 scale=type_size(left.type,decl1);
 syntax_tree_release(decl1);
 if(scale==0)
 {
 scale=1;
 }
 }
 new_decl=array_function_to_pointer(left.decl);
 new_type=syntax_tree_dup(left.type);
 }
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 if(right.is_const)
 {
 if(!r_scale)
 {
 right.value*=scale;
 }
 }
 else
 {
 if(!r_scale)
 {
 scale_result(right.type,right.decl,scale);
 }
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("sub ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 if(r_scale)
 {
 r_scale_result(ret->type,ret->decl,scale);
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_div(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 if(right.value==0)
 {
 error(root->line,root->col,"division by zero.");
 }
 ret->value=left.value/right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'/\'.");
 }
 if(is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as left operand of \'/\'.");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("div ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_mod(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 if(right.value==0)
 {
 error(root->line,root->col,"mod by zero.");
 }
 ret->value=left.value%right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'%\'.");
 }
 if(is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as left operand of \'%\'.");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("mod ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_and(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 ret->value=left.value&right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'&\'.");
 }
 if(is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as left operand of \'&\'.");
 }
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("and ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_orr(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 ret->value=left.value|right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'|\'.");
 }
 if(is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as left operand of \'|\'.");
 }
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("orr ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_eor(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 ret->value=left.value^right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'^\'.");
 }
 if(is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as left operand of \'^\'.");
 }
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("eor ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_lsh(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 ret->value=left.value<<right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'<<\'.");
 }
 if(is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as left operand of \'<<\'.");
 }
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("lsh ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_rsh(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_const&&right.is_const)
 {
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 ret->value=left.value>>right.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(left.decl);
 ret->type=syntax_tree_dup(left.type);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array_function(right.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as right operand of \'>>\'.");
 }
 if(is_pointer_array_function(left.decl))
 {
 error(right.decl->line,right.decl->col,"cannot use pointer as left operand of \'>>\'.");
 }
 if(is_float_type(left.type)||is_float_type(right.type))
 {
 error(root->line,root->col,"invalid operation for floats.");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("rsh ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(left.is_const)
 {
 new_name=scc__str_i_app(0,left.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 free(new_name);
 if(right.is_const)
 {
 new_name=scc__str_i_app(0,right.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_neg(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret result;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&result);
 array_function_to_pointer2(&result.decl);
 if(result.is_const)
 {
 ret->value=-result.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(result.decl);
 ret->type=syntax_tree_dup(result.type);
 expr_ret_release(&result);
 return;
 }
 deref_ptr(&result,root->line,root->col);
 if(!is_basic_decl(result.decl))
 {
 error(root->line,root->col,"invalid operand for \'-\'");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(result.decl);
 new_type=syntax_tree_dup(result.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 add_decl(new_type,new_decl,0,0,0,1);
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 c_write("neg ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 new_name=scc__xstrdup(get_decl_id(result.decl));
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&result);
}
void calculate_not(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret result;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&result);
 array_function_to_pointer2(&result.decl);
 if(result.is_const)
 {
 ret->value=~result.value;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=1;
 ret->decl=syntax_tree_dup(result.decl);
 ret->type=syntax_tree_dup(result.type);
 expr_ret_release(&result);
 return;
 }
 deref_ptr(&result,root->line,root->col);
 if(!is_basic_decl(result.decl))
 {
 error(root->line,root->col,"invalid operand for \'~\'");
 }
 new_name=mktmpname();
 new_decl=syntax_tree_dup(result.decl);
 new_type=syntax_tree_dup(result.type);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 add_decl(new_type,new_decl,0,0,0,1);
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 c_write("not ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 new_name=scc__xstrdup(get_decl_id(result.decl));
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&result);
}
 
void calculate_member(struct syntax_tree *root,struct expr_ret *ret)
{
 struct syntax_tree *mlist,*type,*decl,*decl1;
 long int off;
 struct expr_ret result;
 char *new_name;
 
 calculate_expr(root->subtrees[0],&result);
 if(result.needs_deref)
 {
 decl1=decl_next(result.decl);
 if(!is_basic_decl(decl1))
 {
 error(root->line,root->col,"bad member name.");
 }
 syntax_tree_release(decl1);
 ret->ptr_offset=result.ptr_offset;
 }
 else
 {
 if(!is_basic_decl(result.decl))
 {
 error(root->line,root->col,"bad member name.");
 }
 }
 mlist=get_struct_member_list(result.type,0);
 if(!mlist)
 {
 error(root->line,root->col,"bad member name.");
 }
 type=get_member_type(mlist,root->subtrees[1]->value);
 if(type==0)
 {
 error(root->line,root->col,"bad member name.");
 }
 decl=get_member_decl(mlist,root->subtrees[1]->value);
 off=get_member_offset(mlist,root->subtrees[1]->value);
 type=syntax_tree_dup(type);
 
 
 decl=get_addr(decl);
 new_name=scc__xstrdup(get_decl_id(result.decl));
 decl1=get_decl_type(decl);
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ret->ptr_offset+=off;
 
 ret->is_const=0;
 ret->is_lval=1;
 ret->needs_deref=1;
 ret->type=type;
 ret->decl=decl;
 expr_ret_release(&result);
}
void calculate_member_ptr(struct syntax_tree *root,struct expr_ret *ret)
{
 struct syntax_tree *mlist,*type,*decl,*decl1;
 long int off;
 struct expr_ret result;
 char *new_name;
 
 calculate_expr(root->subtrees[0],&result);
 deref_ptr(&result,root->line,root->col);
 if(!is_pointer_array(result.decl))
 {
 error(root->line,root->col,"invalid use of \'->\'.");
 }
 decl1=decl_next(result.decl);
 if(!is_basic_decl(decl1))
 {
 error(root->line,root->col,"invalid use of \'->\'.");
 }
 syntax_tree_release(decl1);
 
 mlist=get_struct_member_list(result.type,0);
 if(!mlist)
 {
 error(root->line,root->col,"bad member name.");
 }
 type=get_member_type(mlist,root->subtrees[1]->value);
 if(type==0)
 {
 error(root->line,root->col,"bad member name.");
 }
 decl=get_member_decl(mlist,root->subtrees[1]->value);
 off=get_member_offset(mlist,root->subtrees[1]->value);
 type=syntax_tree_dup(type);
 decl=get_addr(decl);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 new_name=scc__xstrdup(get_decl_id(result.decl));
 decl1=get_decl_type(decl);
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 
 ret->is_const=0;
 ret->is_lval=1;
 ret->needs_deref=1;
 ret->type=type;
 ret->decl=decl;
 ret->ptr_offset=off;
 expr_ret_release(&result);
}
void calculate_sizeof(struct syntax_tree *root,struct expr_ret *ret)
{
 int w;
 struct expr_ret result;
 struct syntax_tree *type,*decl;
 long int size;
 w=t_env.write;
 t_env.write=1;
 calculate_expr(root->subtrees[0],&result);
 if(result.needs_deref)
 {
 decl=decl_next(result.decl);
 syntax_tree_release(result.decl);
 result.decl=decl;
 }
 type=get_struct_member_list(result.type,0);
 if(type==0)
 {
 type=result.type;
 }
 size=type_size(type,result.decl);
 expr_ret_release(&result);
 t_env.write=w;
 ret->is_const=1;
 ret->value=size;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->decl=mkst("Identifier","<NULL>",root->line,root->col);
 ret->type=mkst("u64",0,root->line,root->col);
}
void calculate_sizeof_type(struct syntax_tree *root,struct expr_ret *ret)
{
 long int size;
 struct syntax_tree *type;
 type=get_struct_member_list(root->subtrees[0],0);
 if(type==0)
 {
 type=root->subtrees[0];
 }
 size=type_size(type,root->subtrees[1]);
 ret->is_const=1;
 ret->value=size;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->decl=mkst("Identifier","<NULL>",root->line,root->col);
 ret->type=mkst("u64",0,root->line,root->col);
}
void calculate_addr(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret result;
 struct syntax_tree *type,*decl,*decl1;
 char *new_name,*str;
 calculate_expr(root->subtrees[0],&result);
 if(result.is_lval==0)
 {
 error(root->line,root->col,"lvalue required here.");
 }
 if(result.needs_deref)
 {
 if(result.ptr_offset)
 {
 new_name=mktmpname();
 decl=syntax_tree_dup(result.decl);
 type=syntax_tree_dup(result.type);
 decl1=get_decl_type(decl);
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 add_decl(type,decl,0,0,0,1);
 
 c_write("add ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 str=get_decl_id(result.decl);
 c_write(str,strlen(str));
 c_write(" ",1);
 c_write_num(result.ptr_offset);
 c_write("\n",1);
 
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->type=type;
 ret->decl=decl;
 expr_ret_release(&result);
 }
 else
 {
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->type=result.type;
 ret->decl=result.decl;
 }
 }
 else
 {
 new_name=mktmpname();
 decl=get_addr(result.decl);
 type=syntax_tree_dup(result.type);
 decl1=get_decl_type(decl);
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 add_decl(type,decl,0,0,0,1);
 if(result.ptr_offset)
 {
 c_write("adro ",5);
 }
 else
 {
 c_write("adr ",4);
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 str=get_decl_id(result.decl);
 c_write(str,strlen(str));
 if(result.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(result.ptr_offset);
 }
 c_write("\n",1);
 
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->type=type;
 ret->decl=decl;
 expr_ret_release(&result);
 }
}
void calculate_deref(struct syntax_tree *root,struct expr_ret *ret)
{
 calculate_expr(root->subtrees[0],ret);
 deref_ptr(ret,root->line,root->col);
 if(!is_pointer_array(ret->decl))
 {
 error(root->line,root->col,"pointer required here.");
 }
 ret->is_lval=1;
 ret->needs_deref=1;
}
void calculate_index_ptr(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1;
 long int scale;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 scale=1;
 
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 
 if(right.is_const)
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 else
 {
 new_name=mktmpname();
 }
 decl1=decl_next(left.decl);
 scale=type_size(left.type,decl1);
 syntax_tree_release(decl1);
 if(scale==0)
 {
 scale=1;
 }
 new_decl=array_function_to_pointer(left.decl);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 if(right.is_const)
 {
 right.value*=scale;
 }
 else
 {
 scale_result(right.type,right.decl,scale);
 }
 
 ret->is_lval=1;
 ret->needs_deref=1;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 if(right.is_const)
 {
 ret->ptr_offset=right.value;
 }
 else
 {
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("add ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 new_name=get_decl_id(left.decl);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 new_name=get_decl_id(right.decl);
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_index(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1,*decl2;
 long int scale;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 long ptr_offset;
 scale=1;
 
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 
 deref_ptr(&right,root->line,root->col);
 if(!is_basic_type(right.type)||!is_basic_decl(right.decl)||is_float_type(right.type))
 {
 error(root->line,root->col,"array indexes can only be integers.");
 }
 if(left.needs_deref)
 {
 decl1=decl_next(left.decl);
 if(!is_pointer_array(decl1))
 {
 error(root->line,root->col,"pointer required here.");
 }
 syntax_tree_release(decl1);
 ret->ptr_offset=left.ptr_offset;
 }
 else
 {
 if(!is_pointer_array(left.decl))
 {
 error(root->line,root->col,"pointer required here.");
 }
 }
 
 if(left.needs_deref)
 {
 decl1=decl_next(left.decl);
 }
 else
 {
 decl1=syntax_tree_dup(left.decl);
 }
 if(is_pointer(decl1))
 {
 memset(ret,0,sizeof(*ret));
 calculate_index_ptr(root,ret);
 syntax_tree_release(decl1);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 if(right.is_const)
 {
 new_name=scc__xstrdup(get_decl_id(left.decl));
 }
 else
 {
 new_name=mktmpname();
 }
 decl2=decl_next(decl1);
 scale=type_size(left.type,decl2);
 syntax_tree_release(decl2);
 if(scale==0)
 {
 scale=1;
 }
 new_decl=array_function_to_pointer(decl1);
 syntax_tree_release(decl1);
 new_type=syntax_tree_dup(left.type);
 decl1=get_decl_type(new_decl);
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 if(right.is_const)
 {
 right.value*=scale;
 }
 else
 {
 scale_result(right.type,right.decl,scale);
 }
 
 ret->is_lval=1;
 ret->needs_deref=1;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 if(right.is_const)
 {
 ret->ptr_offset+=right.value;
 }
 else
 {
 add_decl(new_type,new_decl,0,0,0,1);
 c_write("add ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 new_name=get_decl_id(left.decl);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 new_name=get_decl_id(right.decl);
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_inc(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret result;
 struct syntax_tree *decl1,*decl2;
 long int scale,size;
 struct syntax_tree *new_type,*new_decl;
 char *new_name,*old_name,*str;
 scale=1;
 calculate_expr(root->subtrees[0],&result);
 if(result.is_lval==0||is_array_function(result.decl))
 {
 error(root->line,root->col,"lvalue required here.");
 }
 if(result.needs_deref)
 {
 new_name=mktmpname();
 decl1=decl_next(result.decl);
 if(!is_integer_type(result.type,decl1))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array(decl1))
 {
 decl2=decl_next(decl1);
 scale=type_size(result.type,decl2);
 if(scale==0)
 {
 scale=1;
 }
 size=8;
 syntax_tree_release(decl2);
 }
 else if(is_basic_type(result.type)&&is_basic_decl(decl1))
 {
 size=type_size(result.type,decl1);
 }
 else
 {
 error(root->line,root->col,"invalid operand for \'++\'.");
 }
 new_type=syntax_tree_dup(result.type);
 
 new_decl=syntax_tree_dup(decl1);
 decl2=get_decl_type(new_decl);
 if(!strcmp(decl2->name,"Identifier"))
 {
 old_name=decl2->value;
 decl2->value=new_name;
 }
 else
 {
 old_name=decl2->subtrees[0]->value;
 decl2->subtrees[0]->value=new_name;
 }
 add_decl(new_type,new_decl,0,0,0,1);
 if(result.ptr_offset)
 {
 if(is_float_type(result.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(result.type->name,"float"))
 {
 c_write("ldof ",5);
 }
 else
 {
 c_write("ldoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("ldob ",5);
 }
 else if(size==2)
 {
 c_write("ldow ",5);
 }
 else if(size==4)
 {
 c_write("ldol ",5);
 }
 else if(size==8)
 {
 c_write("ldoq ",5);
 }
 }
 else
 {
 if(is_float_type(result.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(result.type->name,"float"))
 {
 c_write("ldf ",4);
 }
 else
 {
 c_write("ldh ",4);
 }
 }
 else if(size==1)
 {
 c_write("ldb ",4);
 }
 else if(size==2)
 {
 c_write("ldw ",4);
 }
 else if(size==4)
 {
 c_write("ldl ",4);
 }
 else if(size==8)
 {
 c_write("ldq ",4);
 }
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 if(result.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(result.ptr_offset);
 }
 c_write("\n",1);
 
 c_write("add ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 
 str=scc__str_i_app(0,scale);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 if(result.ptr_offset)
 {
 if(is_float_type(result.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(result.type->name,"float"))
 {
 c_write("stof ",5);
 }
 else
 {
 c_write("stoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("stob ",5);
 }
 else if(size==2)
 {
 c_write("stow ",5);
 }
 else if(size==4)
 {
 c_write("stol ",5);
 }
 else if(size==8)
 {
 c_write("stoq ",5);
 }
 }
 else
 {
 if(is_float_type(result.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(result.type->name,"float"))
 {
 c_write("stf ",4);
 }
 else
 {
 c_write("sth ",4);
 }
 }
 else if(size==1)
 {
 c_write("stb ",4);
 }
 else if(size==2)
 {
 c_write("stw ",4);
 }
 else if(size==4)
 {
 c_write("stl ",4);
 }
 else if(size==8)
 {
 c_write("stq ",4);
 }
 }
 
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 if(result.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(result.ptr_offset);
 }
 c_write("\n",1);
 
 free(old_name);
 syntax_tree_release(decl1);
 
 ret->type=new_type;
 ret->decl=new_decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 else
 {
 if(!is_integer_type(result.type,result.decl))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array(result.decl))
 {
 decl2=decl_next(result.decl);
 scale=type_size(result.type,decl2);
 if(scale==0)
 {
 scale=1;
 }
 syntax_tree_release(decl2);
 }
 old_name=get_decl_id(result.decl);
 c_write("add ",4);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 str=scc__str_i_app(0,scale);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 ret->type=syntax_tree_dup(result.type);
 ret->decl=syntax_tree_dup(result.decl);
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 expr_ret_release(&result);
}
void calculate_dec(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret result;
 struct syntax_tree *decl1,*decl2;
 long int scale,size;
 struct syntax_tree *new_type,*new_decl;
 char *new_name,*old_name,*str;
 scale=1;
 calculate_expr(root->subtrees[0],&result);
 if(result.is_lval==0||is_array_function(result.decl))
 {
 error(root->line,root->col,"lvalue required here.");
 }
 if(result.needs_deref)
 {
 new_name=mktmpname();
 decl1=decl_next(result.decl);
 if(!is_integer_type(result.type,decl1))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array(decl1))
 {
 decl2=decl_next(decl1);
 scale=type_size(result.type,decl2);
 if(scale==0)
 {
 scale=1;
 }
 size=8;
 syntax_tree_release(decl2);
 }
 else if(is_basic_type(result.type)&&is_basic_decl(decl1))
 {
 size=type_size(result.type,decl1);
 }
 else
 {
 error(root->line,root->col,"invalid operand for \'--\'.");
 }
 new_type=syntax_tree_dup(result.type);
 
 new_decl=syntax_tree_dup(decl1);
 decl2=get_decl_type(new_decl);
 if(!strcmp(decl2->name,"Identifier"))
 {
 old_name=decl2->value;
 decl2->value=new_name;
 }
 else
 {
 old_name=decl2->subtrees[0]->value;
 decl2->subtrees[0]->value=new_name;
 }
 add_decl(new_type,new_decl,0,0,0,1);
 if(result.ptr_offset)
 {
 if(is_float_type(result.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(result.type->name,"float"))
 {
 c_write("ldof ",5);
 }
 else
 {
 c_write("ldoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("ldob ",5);
 }
 else if(size==2)
 {
 c_write("ldow ",5);
 }
 else if(size==4)
 {
 c_write("ldol ",5);
 }
 else if(size==8)
 {
 c_write("ldoq ",5);
 }
 }
 else
 {
 if(is_float_type(result.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(result.type->name,"float"))
 {
 c_write("ldf ",4);
 }
 else
 {
 c_write("ldh ",4);
 }
 }
 else if(size==1)
 {
 c_write("ldb ",4);
 }
 else if(size==2)
 {
 c_write("ldw ",4);
 }
 else if(size==4)
 {
 c_write("ldl ",4);
 }
 else if(size==8)
 {
 c_write("ldq ",4);
 }
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 if(result.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(result.ptr_offset);
 }
 c_write("\n",1);
 
 c_write("sub ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 
 str=scc__str_i_app(0,scale);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 if(result.ptr_offset)
 {
 if(is_float_type(result.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(result.type->name,"float"))
 {
 c_write("stof ",5);
 }
 else
 {
 c_write("stoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("stob ",5);
 }
 else if(size==2)
 {
 c_write("stow ",5);
 }
 else if(size==4)
 {
 c_write("stol ",5);
 }
 else if(size==8)
 {
 c_write("stoq ",5);
 }
 }
 else
 {
 if(is_float_type(result.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(result.type->name,"float"))
 {
 c_write("stf ",4);
 }
 else
 {
 c_write("sth ",4);
 }
 }
 else if(size==1)
 {
 c_write("stb ",4);
 }
 else if(size==2)
 {
 c_write("stw ",4);
 }
 else if(size==4)
 {
 c_write("stl ",4);
 }
 else if(size==8)
 {
 c_write("stq ",4);
 }
 }
 
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 if(result.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(result.ptr_offset);
 }
 c_write("\n",1);
 
 free(old_name);
 syntax_tree_release(decl1);
 
 ret->type=new_type;
 ret->decl=new_decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 else
 {
 if(!is_integer_type(result.type,result.decl))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_pointer_array(result.decl))
 {
 decl2=decl_next(result.decl);
 scale=type_size(result.type,decl2);
 if(scale==0)
 {
 scale=1;
 }
 syntax_tree_release(decl2);
 }
 old_name=get_decl_id(result.decl);
 c_write("sub ",4);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 str=scc__str_i_app(0,scale);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 ret->type=syntax_tree_dup(result.type);
 ret->decl=syntax_tree_dup(result.decl);
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 expr_ret_release(&result);
}
void calculate_assign_add(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1,*decl2;
 long int scale,size;
 struct syntax_tree *new_type,*new_decl;
 char *new_name,*old_name,*str;
 scale=1;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_lval==0||is_array_function(left.decl))
 {
 error(root->line,root->col,"lvalue required here.");
 }
 deref_ptr(&right,root->line,root->col);
 if(!is_basic_decl(right.decl))
 {
 error(root->line,root->col,"invalid operand for \'+=\'.");
 }
 if(left.needs_deref)
 {
 new_name=mktmpname();
 decl1=decl_next(left.decl);
 if(is_pointer_array(decl1))
 {
 decl2=decl_next(decl1);
 scale=type_size(left.type,decl2);
 if(scale==0)
 {
 scale=1;
 }
 size=8;
 syntax_tree_release(decl2);
 }
 else if(is_basic_type(left.type)&&is_basic_decl(decl1))
 {
 size=type_size(left.type,decl1);
 }
 else
 {
 error(root->line,root->col,"invalid operand for \'+=\'.");
 }
 
 new_type=syntax_tree_dup(left.type);
 
 new_decl=array_function_to_pointer(decl1);
 decl2=get_decl_type(new_decl);
 if(!strcmp(decl2->name,"Identifier"))
 {
 old_name=decl2->value;
 decl2->value=new_name;
 }
 else
 {
 old_name=decl2->subtrees[0]->value;
 decl2->subtrees[0]->value=new_name;
 }
 add_decl(new_type,new_decl,0,0,0,1);
 if(left.ptr_offset)
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("ldof ",5);
 }
 else
 {
 c_write("ldoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("ldob ",5);
 }
 else if(size==2)
 {
 c_write("ldow ",5);
 }
 else if(size==4)
 {
 c_write("ldol ",5);
 }
 else if(size==8)
 {
 c_write("ldoq ",5);
 }
 }
 else
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("ldf ",4);
 }
 else
 {
 c_write("ldh ",4);
 }
 }
 else if(size==1)
 {
 c_write("ldb ",4);
 }
 else if(size==2)
 {
 c_write("ldw ",4);
 }
 else if(size==4)
 {
 c_write("ldl ",4);
 }
 else if(size==8)
 {
 c_write("ldq ",4);
 }
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 if(left.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(left.ptr_offset);
 }
 c_write("\n",1);
 
 if(right.is_const)
 {
 str=scc__str_i_app(0,scale*right.value);
 }
 else
 {
 scale_result(right.type,right.decl,scale);
 str=scc__xstrdup(get_decl_id(right.decl));
 }
 
 c_write("add ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 
 
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 if(left.ptr_offset)
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("stof ",5);
 }
 else
 {
 c_write("stoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("stob ",5);
 }
 else if(size==2)
 {
 c_write("stow ",5);
 }
 else if(size==4)
 {
 c_write("stol ",5);
 }
 else if(size==8)
 {
 c_write("stoq ",5);
 }
 }
 else
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("stf ",4);
 }
 else
 {
 c_write("sth ",4);
 }
 }
 else if(size==1)
 {
 c_write("stb ",4);
 }
 else if(size==2)
 {
 c_write("stw ",4);
 }
 else if(size==4)
 {
 c_write("stl ",4);
 }
 else if(size==8)
 {
 c_write("stq ",4);
 }
 }
 
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 if(left.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(left.ptr_offset);
 }
 c_write("\n",1);
 syntax_tree_release(decl1);
 
 ret->type=new_type;
 ret->decl=new_decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 else
 {
 if(is_pointer_array(left.decl))
 {
 decl2=decl_next(left.decl);
 scale=type_size(left.type,decl2);
 if(scale==0)
 {
 scale=1;
 }
 syntax_tree_release(decl2);
 }
 
 if(right.is_const)
 {
 str=scc__str_i_app(0,scale*right.value);
 }
 else
 {
 scale_result(right.type,right.decl,scale);
 str=scc__xstrdup(get_decl_id(right.decl));
 }
 
 old_name=get_decl_id(left.decl);
 c_write("add ",4);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 ret->type=syntax_tree_dup(left.type);
 ret->decl=syntax_tree_dup(left.decl);
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_assign_sub(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1,*decl2;
 long int scale,size;
 struct syntax_tree *new_type,*new_decl;
 char *new_name,*old_name,*str;
 scale=1;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_lval==0||is_array_function(left.decl))
 {
 error(root->line,root->col,"lvalue required here.");
 }
 deref_ptr(&right,root->line,root->col);
 if(!is_basic_decl(right.decl))
 {
 error(root->line,root->col,"invalid operand for \'-=\'.");
 }
 if(left.needs_deref)
 {
 new_name=mktmpname();
 decl1=decl_next(left.decl);
 if(is_pointer_array(decl1))
 {
 decl2=decl_next(decl1);
 scale=type_size(left.type,decl2);
 if(scale==0)
 {
 scale=1;
 }
 size=8;
 syntax_tree_release(decl2);
 }
 else if(is_basic_type(left.type)&&is_basic_decl(decl1))
 {
 size=type_size(left.type,decl1);
 }
 else
 {
 error(root->line,root->col,"invalid operand for \'-=\'.");
 }
 
 new_type=syntax_tree_dup(left.type);
 
 new_decl=array_function_to_pointer(decl1);
 decl2=get_decl_type(new_decl);
 if(!strcmp(decl2->name,"Identifier"))
 {
 old_name=decl2->value;
 decl2->value=new_name;
 }
 else
 {
 old_name=decl2->subtrees[0]->value;
 decl2->subtrees[0]->value=new_name;
 }
 add_decl(new_type,new_decl,0,0,0,1);
 
 if(left.ptr_offset)
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("ldof ",5);
 }
 else
 {
 c_write("ldoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("ldob ",5);
 }
 else if(size==2)
 {
 c_write("ldow ",5);
 }
 else if(size==4)
 {
 c_write("ldol ",5);
 }
 else if(size==8)
 {
 c_write("ldoq ",5);
 }
 }
 else
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("ldf ",4);
 }
 else
 {
 c_write("ldh ",4);
 }
 }
 else if(size==1)
 {
 c_write("ldb ",4);
 }
 else if(size==2)
 {
 c_write("ldw ",4);
 }
 else if(size==4)
 {
 c_write("ldl ",4);
 }
 else if(size==8)
 {
 c_write("ldq ",4);
 }
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 if(left.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(left.ptr_offset);
 }
 c_write("\n",1);
 
 if(right.is_const)
 {
 str=scc__str_i_app(0,scale*right.value);
 }
 else
 {
 scale_result(right.type,right.decl,scale);
 str=scc__xstrdup(get_decl_id(right.decl));
 }
 
 c_write("sub ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 
 
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 if(left.ptr_offset)
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("stof ",5);
 }
 else
 {
 c_write("stoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("stob ",5);
 }
 else if(size==2)
 {
 c_write("stow ",5);
 }
 else if(size==4)
 {
 c_write("stol ",5);
 }
 else if(size==8)
 {
 c_write("stoq ",5);
 }
 }
 else
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("stf ",4);
 }
 else
 {
 c_write("sth ",4);
 }
 }
 else if(size==1)
 {
 c_write("stb ",4);
 }
 else if(size==2)
 {
 c_write("stw ",4);
 }
 else if(size==4)
 {
 c_write("stl ",4);
 }
 else if(size==8)
 {
 c_write("stq ",4);
 }
 }
 
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 if(left.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(left.ptr_offset);
 }
 c_write("\n",1);
 syntax_tree_release(decl1);
 
 ret->type=new_type;
 ret->decl=new_decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 else
 {
 if(is_pointer_array(left.decl))
 {
 decl2=decl_next(left.decl);
 scale=type_size(left.type,decl2);
 if(scale==0)
 {
 scale=1;
 }
 syntax_tree_release(decl2);
 }
 
 if(right.is_const)
 {
 str=scc__str_i_app(0,scale*right.value);
 }
 else
 {
 scale_result(right.type,right.decl,scale);
 str=scc__xstrdup(get_decl_id(right.decl));
 }
 
 old_name=get_decl_id(left.decl);
 c_write("sub ",4);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 ret->type=syntax_tree_dup(left.type);
 ret->decl=syntax_tree_dup(left.decl);
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_assign_op(struct syntax_tree *root,struct expr_ret *ret,char *op,char *ins)
{
 struct expr_ret left,right;
 struct syntax_tree *decl1,*decl2;
 long int size;
 struct syntax_tree *new_type,*new_decl;
 char *new_name,*old_name,*str;
 char *msg;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 if(left.is_lval==0)
 {
 error(root->line,root->col,"lvalue required here.");
 }
 deref_ptr(&right,root->line,root->col);
 if(!is_basic_decl(right.decl))
 {
 msg=scc__xstrdup("invalid operand for \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(root->line,root->col,msg);
 }
 if(is_float_type(right.type)&&strcmp(op,"*=")&&strcmp(op,"/="))
 {
 msg=scc__xstrdup("invalid operand for \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(root->line,root->col,msg);
 }
 if(left.needs_deref)
 {
 new_name=mktmpname();
 decl1=decl_next(left.decl);
 if(is_basic_type(left.type)&&is_basic_decl(decl1))
 {
 if(is_float_type(left.type)&&strcmp(op,"*=")&&strcmp(op,"/="))
 {
 msg=scc__xstrdup("invalid operand for \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(root->line,root->col,msg);
 }
 size=type_size(left.type,decl1);
 }
 else
 {
 msg=scc__xstrdup("invalid operand for \'");
 msg=scc__str_s_app(msg,op);
 msg=scc__str_s_app(msg,"\'.");
 error(root->line,root->col,msg);
 }
 
 new_type=syntax_tree_dup(left.type);
 
 new_decl=syntax_tree_dup(decl1);
 decl2=get_decl_type(new_decl);
 if(!strcmp(decl2->name,"Identifier"))
 {
 old_name=decl2->value;
 decl2->value=new_name;
 }
 else
 {
 old_name=decl2->subtrees[0]->value;
 decl2->subtrees[0]->value=new_name;
 }
 add_decl(new_type,new_decl,0,0,0,1);
 
 if(left.ptr_offset)
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("ldof ",5);
 }
 else
 {
 c_write("ldoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("ldob ",5);
 }
 else if(size==2)
 {
 c_write("ldow ",5);
 }
 else if(size==4)
 {
 c_write("ldol ",5);
 }
 else if(size==8)
 {
 c_write("ldoq ",5);
 }
 }
 else
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("ldf ",4);
 }
 else
 {
 c_write("ldh ",4);
 }
 }
 else if(size==1)
 {
 c_write("ldb ",4);
 }
 else if(size==2)
 {
 c_write("ldw ",4);
 }
 else if(size==4)
 {
 c_write("ldl ",4);
 }
 else if(size==8)
 {
 c_write("ldq ",4);
 }
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 if(left.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(left.ptr_offset);
 }
 c_write("\n",1);
 
 if(right.is_const)
 {
 str=scc__str_i_app(0,right.value);
 }
 else
 {
 str=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(ins,strlen(ins));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 
 
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 if(left.ptr_offset)
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("stof ",5);
 }
 else
 {
 c_write("stoh ",5);
 }
 }
 else if(size==1)
 {
 c_write("stob ",5);
 }
 else if(size==2)
 {
 c_write("stow ",5);
 }
 else if(size==4)
 {
 c_write("stol ",5);
 }
 else if(size==8)
 {
 c_write("stoq ",5);
 }
 }
 else
 {
 if(is_float_type(left.type)&&is_basic_decl(decl1))
 {
 if(!strcmp(left.type->name,"float"))
 {
 c_write("stf ",4);
 }
 else
 {
 c_write("sth ",4);
 }
 }
 else if(size==1)
 {
 c_write("stb ",4);
 }
 else if(size==2)
 {
 c_write("stw ",4);
 }
 else if(size==4)
 {
 c_write("stl ",4);
 }
 else if(size==8)
 {
 c_write("stq ",4);
 }
 }
 
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(new_name,strlen(new_name));
 if(left.ptr_offset)
 {
 c_write(" ",1);
 c_write_num(left.ptr_offset);
 }
 c_write("\n",1);
 syntax_tree_release(decl1);
 
 ret->type=new_type;
 ret->decl=new_decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 else
 {
 
 if(right.is_const)
 {
 str=scc__str_i_app(0,right.value);
 }
 else
 {
 str=scc__xstrdup(get_decl_id(right.decl));
 }
 
 old_name=get_decl_id(left.decl);
 c_write(ins,strlen(ins));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(old_name,strlen(old_name));
 c_write(" ",1);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 ret->type=syntax_tree_dup(left.type);
 ret->decl=syntax_tree_dup(left.decl);
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 }
 expr_ret_release(&left);
 expr_ret_release(&right);
}
void calculate_branch(struct syntax_tree *root,struct expr_ret *ret)
{
 char *new_name;
 struct syntax_tree *type,*decl;
 struct branch_args args;
 control_label_push();
 new_name=mktmpname();
 type=mkst("u64",0,root->line,root->col);
 decl=mkst("Identifier",new_name,root->line,root->col);
 add_decl(type,decl,0,0,0,1);
 args.ltrue=-1;
 args.lfalse=t_env.label->l2;
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 0\n",3);
 
 translate_branch(root,&args);
 
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 1\n",3);
 write_label(t_env.label->l2);
 control_label_pop();
 free(new_name);
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->type=type;
 ret->decl=decl;
}
void calculate_relop(struct syntax_tree *root,struct expr_ret *ret,char *ins)
{
 struct expr_ret left,right;
 char *str;
 struct syntax_tree *type,*decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],&right);
 deref_ptr(&left,root->line,root->col);
 deref_ptr(&right,root->line,root->col);
 if(left.is_const&&right.is_const)
 {
 ret->value=1;
 if(!strcmp(ins,"bgt "))
 {
 if(left.value>right.value)
 {
 ret->value=0;
 }
 }
 else if(!strcmp(ins,"blt "))
 {
 if(left.value<right.value)
 {
 ret->value=0;
 }
 }
 else if(!strcmp(ins,"bge "))
 {
 if(left.value>=right.value)
 {
 ret->value=0;
 }
 }
 else if(!strcmp(ins,"ble "))
 {
 if(left.value<=right.value)
 {
 ret->value=0;
 }
 }
 else if(!strcmp(ins,"beq "))
 {
 if(left.value==right.value)
 {
 ret->value=0;
 }
 }
 else if(!strcmp(ins,"bne "))
 {
 if(left.value!=right.value)
 {
 ret->value=0;
 }
 }
 ret->is_const=1;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->type=mkst("u64",0,root->line,root->col);
 ret->decl=mkst("Identifier","<NULL>",root->line,root->col);
 expr_ret_release(&left);
 expr_ret_release(&right);
 return;
 }
 new_name=mktmpname();
 type=mkst("u64",0,root->line,root->col);
 decl=mkst("Identifier",new_name,root->line,root->col);
 add_decl(type,decl,0,0,0,1);
 if(!left.is_const&&!right.is_const)
 {
 if(if_type_compat(left.type,left.decl,right.type,right.decl,0))
 {
 error(root->line,root->col,"incompatible type.");
 }
 }
 control_label_push();
 
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 0\n",3);
 
 c_write(ins,4);
 if(left.is_const)
 {
 str=scc__str_i_app(0,left.value);
 }
 else
 {
 str=scc__xstrdup(get_decl_id(left.decl));
 }
 c_write(str,strlen(str));
 c_write(" ",1);
 free(str);
 
 if(right.is_const)
 {
 str=scc__str_i_app(0,right.value);
 }
 else
 {
 str=scc__xstrdup(get_decl_id(right.decl));
 }
 c_write(str,strlen(str));
 c_write(" ",1);
 free(str);
 
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 1\n",3);
 
 c_write("label ",6);
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 control_label_pop();
 free(new_name);
 expr_ret_release(&left);
 expr_ret_release(&right);
 ret->type=type;
 ret->decl=decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
}
void calculate_lnot(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret result;
 char *str;
 struct syntax_tree *type,*decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&result);
 deref_ptr(&result,root->line,root->col);
 if(result.is_const)
 {
 ret->value=1;
 if(result.value)
 {
 ret->value=0;
 }
 ret->is_const=1;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->type=mkst("u64",0,root->line,root->col);
 ret->decl=mkst("Identifier","<NULL>",root->line,root->col);
 }
 else
 {
 new_name=mktmpname();
 type=mkst("u64",0,root->line,root->col);
 decl=mkst("Identifier",new_name,root->line,root->col);
 add_decl(type,decl,0,0,0,1);
 
 control_label_push();
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 0\n",3);
 
 c_write("bne ",4);
 str=scc__xstrdup(get_decl_id(result.decl));
 c_write(str,strlen(str));
 c_write(" 0 ",3);
 free(str);
 
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 1\n",3);
 
 c_write("label ",6);
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 ret->type=type;
 ret->decl=decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 
 control_label_pop();
 }
 expr_ret_release(&result);
}
void calculate_land(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 char *str;
 struct syntax_tree *type,*decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 deref_ptr(&left,root->line,root->col);
 if(left.is_const)
 {
 if(left.value==0)
 {
 ret->value=0;
 ret->is_const=1;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->type=mkst("u64",0,root->line,root->col);
 ret->decl=mkst("Identifier","<NULL>",root->line,root->col);
 expr_ret_release(&left);
 return;
 }
 }
 
 new_name=mktmpname();
 type=mkst("u64",0,root->line,root->col);
 decl=mkst("Identifier",new_name,root->line,root->col);
 add_decl(type,decl,0,0,0,1);
 
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 0\n",3);
 
 control_label_push();
 
 c_write("beq ",4);
 
 str=get_decl_id(left.decl);
 c_write(str,strlen(str));
 c_write(" 0 ",3);
 
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 
 calculate_expr(root->subtrees[1],&right);
 deref_ptr(&right,root->line,root->col);
 if(!right.is_const||right.value!=0)
 {
 
 if(!right.is_const)
 {
 c_write("beq ",4);
 
 str=get_decl_id(right.decl);
 c_write(str,strlen(str));
 c_write(" 0 ",3);
 
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 }
 
 
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 1\n",3);
 
 }
 c_write("label ",6);
 
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 ret->type=type;
 ret->decl=decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 
 expr_ret_release(&right);
 expr_ret_release(&left);
 control_label_pop();
}
void calculate_lor(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left,right;
 char *str;
 struct syntax_tree *type,*decl;
 char *new_name;
 calculate_expr(root->subtrees[0],&left);
 deref_ptr(&left,root->line,root->col);
 if(left.is_const)
 {
 if(left.value!=0)
 {
 ret->value=1;
 ret->is_const=1;
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->type=mkst("u64",0,root->line,root->col);
 ret->decl=mkst("Identifier","<NULL>",root->line,root->col);
 expr_ret_release(&left);
 return;
 }
 }
 
 new_name=mktmpname();
 type=mkst("u64",0,root->line,root->col);
 decl=mkst("Identifier",new_name,root->line,root->col);
 add_decl(type,decl,0,0,0,1);
 
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 1\n",3);
 
 control_label_push();
 
 c_write("bne ",4);
 
 str=get_decl_id(left.decl);
 c_write(str,strlen(str));
 c_write(" 0 ",3);
 
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 
 calculate_expr(root->subtrees[1],&right);
 deref_ptr(&right,root->line,root->col);
 if(!right.is_const||right.value==0)
 {
 
 if(!right.is_const)
 {
 c_write("bne ",4);
 
 str=get_decl_id(right.decl);
 c_write(str,strlen(str));
 c_write(" 0 ",3);
 
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 }
 
 
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" 0\n",3);
 
 }
 c_write("label ",6);
 
 str=scc__str_i_app(0,t_env.label->l2);
 c_write(str,strlen(str));
 c_write("\n",1);
 free(str);
 
 ret->type=type;
 ret->decl=decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 
 expr_ret_release(&right);
 expr_ret_release(&left);
 control_label_pop();
}
void calculate_call(struct syntax_tree *root,struct expr_ret *ret)
{
 int x;
 struct syntax_tree *type,*decl,*decl1;
 struct expr_ret result,func;
 char *name,*new_name;
 calculate_expr(root->subtrees[0],&func);
 deref_ptr(&func,root->line,root->col);
 if(!is_function(func.decl))
 {
 if(!is_pointer_array(func.decl))
 {
 error(root->line,root->col,"calling a non-function.");
 }
 decl=decl_next(func.decl);
 syntax_tree_release(func.decl);
 func.decl=decl;
 if(!is_function(func.decl))
 {
 error(root->line,root->col,"calling a non-function.");
 }
 }
 decl1=get_decl_type(func.decl);
 if(decl1->count_subtrees-1>>1!=root->count_subtrees-1)
 {
 error(root->line,root->col,"numbers of arguments did not match.");
 }
 x=root->count_subtrees;
 while(x>1)
 {
 --x;
 calculate_expr(root->subtrees[x],&result);
 deref_ptr(&result,root->subtrees[x]->line,root->subtrees[x]->col);
 if(if_type_compat(result.type,result.decl,decl1->subtrees[x*2-1],decl1->subtrees[x*2],1))
 {
 error(root->line,root->col,"incompatible type.");
 }
 if(is_float_type(decl1->subtrees[x*2-1])&&!is_pointer_array_function(decl1->subtrees[x*2]))
 {
 if(!strcmp(decl1->subtrees[x*2-1]->name,"float"))
 {
 c_write("pushf ",6);
 }
 else
 {
 c_write("pushh ",6);
 }
 }
 else
 {
 c_write("push ",5);
 }
 if(result.is_const)
 {
 name=scc__str_i_app(0,result.value);
 }
 else
 {
 name=scc__xstrdup(get_decl_id(result.decl));
 }
 c_write(name,strlen(name));
 c_write("\n",1);
 free(name);
 expr_ret_release(&result);
 }
 new_name=mktmpname();
 type=syntax_tree_dup(func.type);
 decl=decl_next(func.decl);
 decl1=get_decl_type(decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 add_decl(type,decl,0,0,0,1);
 if(is_basic_decl(decl)&&is_float_type(type))
 {
 if(!strcmp(type->name,"float"))
 {
 c_write("fcall ",6);
 }
 else
 {
 c_write("hcall ",6);
 }
 }
 else
 {
 c_write("call ",5);
 }
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 name=get_decl_id(func.decl);
 c_write(name,strlen(name));
 c_write("\n",1);
 
 if(root->count_subtrees>1)
 {
 c_write("del ",4);
 name=scc__str_i_app(0,root->count_subtrees-1);
 c_write(name,strlen(name));
 c_write("\n",1);
 free(name);
 }
 
 
 ret->type=type;
 ret->decl=decl;
 ret->is_const=0;
 ret->is_lval=0;
 ret->needs_deref=0;
 
 expr_ret_release(&func);
}
void calculate_cast(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret result;
 struct syntax_tree *decl1;
 struct syntax_tree *new_type,*new_decl;
 char *new_name;
 calculate_expr(root->subtrees[2],&result);
 array_function_to_pointer2(&result.decl);
 deref_ptr(&result,root->line,root->col);
 new_name=mktmpname();
 new_decl=syntax_tree_dup(root->subtrees[1]);
 new_type=syntax_tree_dup(root->subtrees[0]);
 decl1=get_decl_type(new_decl);
 if(!strcmp(decl1->name,"Identifier"))
 {
 free(decl1->value);
 decl1->value=new_name;
 }
 else if(!strcmp(decl1->name,"pointer"))
 {
 free(decl1->subtrees[0]->value);
 decl1->subtrees[0]->value=new_name;
 }
 else
 {
 error(root->line,root->col,"invalid cast.");
 }
 add_decl(new_type,new_decl,0,0,0,1);
 ret->is_lval=0;
 ret->needs_deref=0;
 ret->is_const=0;
 ret->decl=new_decl;
 ret->type=new_type;
 c_write("mov ",4);
 c_write(new_name,strlen(new_name));
 c_write(" ",1);
 if(result.is_const)
 {
 new_name=scc__str_i_app(0,result.value);
 }
 else
 {
 new_name=scc__xstrdup(get_decl_id(result.decl));
 }
 c_write(new_name,strlen(new_name));
 c_write("\n",1);
 free(new_name);
 expr_ret_release(&result);
}
void calculate_expr(struct syntax_tree *root,struct expr_ret *ret)
{
 struct expr_ret left;
 memset(ret,0,sizeof(*ret));
 memset(&left,0,sizeof(left));
 if(!strcmp(root->name,"Identifier"))
 {
 calculate_id(root,ret);
 }
 else if(!strcmp(root->name,"Constant"))
 {
 calculate_const(root,ret);
 }
 else if(!strcmp(root->name,"FConstant"))
 {
 calculate_fconst(root,ret);
 }
 else if(!strcmp(root->name,","))
 {
 calculate_expr(root->subtrees[0],&left);
 calculate_expr(root->subtrees[1],ret);
 expr_ret_release(&left);
 }
 else if(!strcmp(root->name,"="))
 {
 calculate_assign(root,ret,"mov","st");
 }
 else if(!strcmp(root->name,"+"))
 {
 calculate_add(root,ret);
 }
 else if(!strcmp(root->name,"*"))
 {
 calculate_mul(root,ret);
 }
 else if(!strcmp(root->name,"-"))
 {
 calculate_sub(root,ret);
 }
 else if(!strcmp(root->name,"/"))
 {
 calculate_div(root,ret);
 }
 else if(!strcmp(root->name,"%"))
 {
 calculate_mod(root,ret);
 }
 else if(!strcmp(root->name,"&"))
 {
 calculate_and(root,ret);
 }
 else if(!strcmp(root->name,"|"))
 {
 calculate_orr(root,ret);
 }
 else if(!strcmp(root->name,"^"))
 {
 calculate_eor(root,ret);
 }
 else if(!strcmp(root->name,"<<"))
 {
 calculate_lsh(root,ret);
 }
 else if(!strcmp(root->name,">>"))
 {
 calculate_rsh(root,ret);
 }
 else if(!strcmp(root->name,"neg"))
 {
 calculate_neg(root,ret);
 }
 else if(!strcmp(root->name,"~"))
 {
 calculate_not(root,ret);
 }
 else if(!strcmp(root->name,"."))
 {
 calculate_member(root,ret);
 }
 else if(!strcmp(root->name,"->"))
 {
 calculate_member_ptr(root,ret);
 }
 else if(!strcmp(root->name,"sizeof"))
 {
 calculate_sizeof(root,ret);
 }
 else if(!strcmp(root->name,"sizeof_type"))
 {
 calculate_sizeof_type(root,ret);
 }
 else if(!strcmp(root->name,"addr"))
 {
 calculate_addr(root,ret);
 }
 else if(!strcmp(root->name,"deref"))
 {
 calculate_deref(root,ret);
 }
 else if(!strcmp(root->name,"[]"))
 {
 calculate_index(root,ret);
 }
 else if(!strcmp(root->name,"++"))
 {
 calculate_inc(root,ret);
 }
 else if(!strcmp(root->name,"--"))
 {
 calculate_dec(root,ret);
 }
 else if(!strcmp(root->name,"+="))
 {
 calculate_assign_add(root,ret);
 }
 else if(!strcmp(root->name,"-="))
 {
 calculate_assign_sub(root,ret);
 }
 else if(!strcmp(root->name,"*="))
 {
 calculate_assign_op(root,ret,"*=","mul");
 }
 else if(!strcmp(root->name,"/="))
 {
 calculate_assign_op(root,ret,"/=","div");
 }
 else if(!strcmp(root->name,"%="))
 {
 calculate_assign_op(root,ret,"%=","mod");
 }
 else if(!strcmp(root->name,"<<="))
 {
 calculate_assign_op(root,ret,"<<=","lsh");
 }
 else if(!strcmp(root->name,">>="))
 {
 calculate_assign_op(root,ret,">>=","rsh");
 }
 else if(!strcmp(root->name,"&="))
 {
 calculate_assign_op(root,ret,"&=","and");
 }
 else if(!strcmp(root->name,"|="))
 {
 calculate_assign_op(root,ret,"|=","orr");
 }
 else if(!strcmp(root->name,"^="))
 {
 calculate_assign_op(root,ret,"^=","eor");
 }
 else if(!strcmp(root->name,">"))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,"<"))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,">="))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,"<="))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,"=="))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,"!="))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,"!"))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,"&&"))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,"||"))
 {
 calculate_branch(root,ret);
 }
 else if(!strcmp(root->name,"call"))
 {
 calculate_call(root,ret);
 }
 else if(!strcmp(root->name,"call_noarg"))
 {
 calculate_call(root,ret);
 }
 else if(!strcmp(root->name,"cast"))
 {
 calculate_cast(root,ret);
 }
 else
 {
 error(root->line,root->col,"unsupported operator.");
 }
}
void translate_stmt(struct syntax_tree *root);
void translate_block(struct syntax_tree *root,int push)
{
 int x;
 struct syntax_tree *node;
 x=0;
 if(push)
 {
 translate_stack_push();
 }
 while(x<root->count_subtrees)
 {
 node=root->subtrees[x];
 translate_stmt(node);
 ++x;
 }
 if(push)
 {
 translate_stack_pop();
 }
}
void translate_return(struct syntax_tree *root)
{
 struct expr_ret ret;
 char *name;
 if(root->count_subtrees)
 {
 calculate_expr(root->subtrees[0],&ret);
 deref_ptr(&ret,root->line,root->col);
 if(ret.is_const)
 {
 name=scc__str_i_app(0,ret.value);
 }
 else
 {
 name=scc__xstrdup(get_decl_id(ret.decl));
 }
 if(t_env.func_type==1)
 {
 c_write("retvalh ",8);
 }
 else if(t_env.func_type==2)
 {
 c_write("retvalf ",8);
 }
 else
 {
 c_write("retval ",7);
 }
 c_write(name,strlen(name));
 expr_ret_release(&ret);
 free(name);
 c_write("\n",1);
 }
 else
 {
 c_write("ret\n",4);
 }
}
void translate_if(struct syntax_tree *root)
{
 struct branch_args args;
 control_label_push();
 
 args.ltrue=-1;
 args.lfalse=t_env.label->l3;
 translate_branch(root->subtrees[0],&args);
 translate_stmt(root->subtrees[1]);
 write_label(t_env.label->l3);
 
 control_label_pop();
}
void translate_while(struct syntax_tree *root)
{
 int l;
 struct control_labels *label;
 struct branch_args args;
 l=t_env.label_in_use;
 control_label_push();
 t_env.label_in_use=1;
 label=t_env.break_label;
 t_env.break_label=t_env.label;
 
 args.ltrue=-1;
 args.lfalse=t_env.label->l3;
 translate_branch(root->subtrees[0],&args);
 write_label(t_env.label->l1);
 translate_stmt(root->subtrees[1]);
 args.ltrue=t_env.label->l1;
 args.lfalse=-1;
 translate_branch(root->subtrees[0],&args);
 write_label(t_env.label->l3);
 
 control_label_pop();
 t_env.label_in_use=l;
 t_env.break_label=label;
}
void translate_dowhile(struct syntax_tree *root)
{
 int l;
 struct control_labels *label;
 struct branch_args args;
 l=t_env.label_in_use;
 control_label_push();
 t_env.label_in_use=1;
 label=t_env.break_label;
 t_env.break_label=t_env.label;
 
 write_label(t_env.label->l1);
 translate_stmt(root->subtrees[0]);
 args.ltrue=t_env.label->l1;
 args.lfalse=-1;
 translate_branch(root->subtrees[1],&args);
 write_label(t_env.label->l3);
 
 control_label_pop();
 t_env.label_in_use=l;
 t_env.break_label=label;
}
void translate_break(struct syntax_tree *root)
{
 char *name;
 if(!t_env.label_in_use)
 {
 error(root->line,root->col,"unexpected \'break\'.");
 }
 c_write("bal ",4);
 name=scc__str_i_app(0,t_env.break_label->l3);
 c_write(name,strlen(name));
 c_write("\n",1);
 free(name);
 
}
void translate_goto(struct syntax_tree *root)
{
 char *name;
 c_write("bal ",4);
 name=scc__xstrdup("_$CL$");
 name=scc__str_i_app(name,t_env.func_num);
 name=scc__str_s_app(name,"$");
 name=scc__str_s_app(name,root->subtrees[0]->value);
 c_write(name,strlen(name));
 c_write("\n",1);
 free(name);
}
void translate_label(struct syntax_tree *root)
{
 char *name;
 c_write("label ",6);
 name=scc__xstrdup("_$CL$");
 name=scc__str_i_app(name,t_env.func_num);
 name=scc__str_s_app(name,"$");
 name=scc__str_s_app(name,root->subtrees[0]->value);
 c_write(name,strlen(name));
 c_write("\n",1);
 free(name);
}
void translate_ifelse(struct syntax_tree *root)
{
 struct branch_args args;
 control_label_push();
 
 args.ltrue=-1;
 args.lfalse=t_env.label->l2;
 translate_branch(root->subtrees[0],&args);
 translate_stmt(root->subtrees[1]);
 c_write("bal ",4);
 write_label_name(t_env.label->l3);
 c_write("\n",1);
 write_label(t_env.label->l2);
 translate_stmt(root->subtrees[2]);
 write_label(t_env.label->l3);
 
 control_label_pop();
}
void translate_asm(struct syntax_tree *node)
{
 char *str;
 c_write("asm ",4);
 str=node->subtrees[0]->value;
 c_write(str,strlen(str));
 c_write("\n",1);
}
void translate_stmt(struct syntax_tree *node)
{
 struct expr_ret ret;
 if(!strcmp(node->name,"asm"))
 {
 translate_asm(node);
 }
 if(!strcmp(node->name,"decl"))
 {
 translate_decl(node);
 }
 if(!strcmp(node->name,"static_decl"))
 {
 translate_static_decl(node);
 }
 if(!strcmp(node->name,"extern_decl"))
 {
 error(node->line,node->col,"\'extern\' not supported.");
 }
 else if(!strcmp(node->name,"expr"))
 {
 calculate_expr(node->subtrees[0],&ret);
 expr_ret_release(&ret);
 }
 else if(!strcmp(node->name,"block"))
 {
 translate_block(node,1);
 }
 else if(!strcmp(node->name,"return"))
 {
 translate_return(node);
 }
 else if(!strcmp(node->name,"if"))
 {
 translate_if(node);
 }
 else if(!strcmp(node->name,"ifelse"))
 {
 translate_ifelse(node);
 }
 else if(!strcmp(node->name,"while"))
 {
 translate_while(node);
 }
 else if(!strcmp(node->name,"dowhile"))
 {
 translate_dowhile(node);
 }
 else if(!strcmp(node->name,"break"))
 {
 translate_break(node);
 }
 else if(!strcmp(node->name,"goto"))
 {
 translate_goto(node);
 }
 else if(!strcmp(node->name,"Label"))
 {
 translate_label(node);
 }
 
}
void translate_file(struct syntax_tree *root)
{
 int x;
 x=0;
 while(x<root->count_subtrees)
 {
 if(!strcmp(root->subtrees[x]->name,"decl"))
 {
 translate_decl(root->subtrees[x]);
 }
 else if(!strcmp(root->subtrees[x]->name,"fundef"))
 {
 translate_fundef(root->subtrees[x]);
 }
 else if(!strcmp(root->subtrees[x]->name,"namespace"))
 {
 current_namespace=root->subtrees[x]->subtrees[0]->value;
 }
 else if(!strcmp(root->subtrees[x]->name,"asm"))
 {
 translate_asm(root->subtrees[x]);
 }
 ++x;
 }
}
 
void scc_run(void)
{
 struct syntax_tree *root;
 l_global_init();
 expr_global_init();
 type_global_init();
 parse_global_init();
 load_file();
 p_current_word=l_words_head;
 root=parse_file();
 translate_file(root);
 out_flush();
}
namespace scc_back;
long int current_line;
void error(int line,char *msg)
{
 char *str;
 str=scc__xstrdup("line ");
 str=scc__str_i_app(str,line);
 str=scc__str_s_app(str,": error: ");
 str=scc__str_s_app(str,msg);
 str=scc__str_c_app(str,'\n');
 __syscall((long)(1),(long)(2),(long)(str),(long)(strlen(str)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(231),(long)(2),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
}
int name_hash(char *str)
{
 unsigned int hash;
 hash=0;
 while(*str)
 {
 hash=(hash<<11|hash>>21)+*str;
 ++str;
 }
 return hash%1021;
}
int readc(void)
{
 return scc__stream_getc();
}
char *read_line(void)
{
 char *str;
 char c;
 int x;
 str=0;
 x=0;
 while((c=readc())!=-1)
 {
 if(c=='\n')
 {
 if(str==0)
 {
 str=scc__xstrdup(" ");
 }
 break;
 }
 str=scc__str_c_app2(str,x,c);
 ++x;
 }
 ++current_line;
 return str;
}
long int slen(char *str)
{
 int c;
 long int l;
 l=0;
 if(*str=='\"')
 {
 l=1;
 while(str[l])
 {
 if(str[l]=='\"')
 {
 ++l;
 break;
 }
 if(str[l]=='\\')
 {
 ++l;
 if(str[l]==0)
 {
 error(current_line,"string not complete.");
 }
 }
 ++l;
 }
 return l;
 }
 while(c=*str)
 {
 if(c==32||c=='\t'||c=='\v'||c=='\r')
 {
 break;
 }
 ++l;
 ++str;
 }
 return l;
}
char *snext(char *str)
{
 long int l;
 if(!str)
 {
 return 0;
 }
 l=slen(str);
 str+=l;
 while(*str==32||*str=='\t'||*str=='\v'||*str=='\r')
 {
 ++str;
 }
 if(*str==0)
 {
 return 0;
 }
 return str;
}
char *sdup(char *str)
{
 char *ret;
 long int l;
 if(str==0)
 {
 return 0;
 }
 l=slen(str);
 if(l==0)
 {
 return 0;
 }
 ret=scc__xmalloc(l+1);
 memcpy(ret,str,l);
 ret[l]=0;
 return ret;
}
char outc_buf[65536];
int outc_x;
void outc(char c)
{
 int n;
 if(outc_x==65536)
 {
 __syscall((long)(1),(long)(scc__fdo),(long)(outc_buf),(long)(outc_x),(long)(0),(long)(0),(long)(0));
 outc_x=0;
 }
 outc_buf[outc_x]=c;
 ++outc_x;
}
void out_flush(void)
{
 if(outc_x)
 {
 __syscall((long)(1),(long)(scc__fdo),(long)(outc_buf),(long)(outc_x),(long)(0),(long)(0),(long)(0));
 }
}
void outs(char *str)
{
 while(*str)
 {
 outc(*str);
 ++str;
 }
}
void out_label(char *label)
{
 outs("@");
 outs(label);
 outs("\n");
}
void out_label_name(char *label)
{
 outs(label);
}
void out_reg64(int reg)
{
 if(reg==1)
 {
 outs("%rbx");
 }
 else if(reg==2)
 {
 outs("%rsi");
 }
 else if(reg==3)
 {
 outs("%rdi");
 }
 else if(reg==4)
 {
 outs("%r8");
 }
 else if(reg==5)
 {
 outs("%r9");
 }
 else if(reg==6)
 {
 outs("%r12");
 }
 else if(reg==7)
 {
 outs("%r13");
 }
 else if(reg==8)
 {
 outs("%r14");
 }
 else if(reg==9)
 {
 outs("%r15");
 }
 else if(reg==10)
 {
 outs("%r10");
 }
 else if(reg==11)
 {
 outs("%r11");
 }
}
void out_reg32(int reg)
{
 if(reg==1)
 {
 outs("%ebx");
 }
 else if(reg==2)
 {
 outs("%esi");
 }
 else if(reg==3)
 {
 outs("%edi");
 }
 else if(reg==4)
 {
 outs("%r8d");
 }
 else if(reg==5)
 {
 outs("%r9d");
 }
 else if(reg==6)
 {
 outs("%r12d");
 }
 else if(reg==7)
 {
 outs("%r13d");
 }
 else if(reg==8)
 {
 outs("%r14d");
 }
 else if(reg==9)
 {
 outs("%r15d");
 }
 else if(reg==10)
 {
 outs("%r10d");
 }
 else if(reg==11)
 {
 outs("%r11d");
 }
}
void out_reg16(int reg)
{
 if(reg==1)
 {
 outs("%bx");
 }
 else if(reg==2)
 {
 outs("%si");
 }
 else if(reg==3)
 {
 outs("%di");
 }
 else if(reg==4)
 {
 outs("%r8w");
 }
 else if(reg==5)
 {
 outs("%r9w");
 }
 else if(reg==6)
 {
 outs("%r12w");
 }
 else if(reg==7)
 {
 outs("%r13w");
 }
 else if(reg==8)
 {
 outs("%r14w");
 }
 else if(reg==9)
 {
 outs("%r15w");
 }
 else if(reg==10)
 {
 outs("%r10w");
 }
 else if(reg==11)
 {
 outs("%r11w");
 }
}
void out_reg8(int reg)
{
 if(reg==1)
 {
 outs("%bl");
 }
 else if(reg==2)
 {
 outs("%sil");
 }
 else if(reg==3)
 {
 outs("%dil");
 }
 else if(reg==4)
 {
 outs("%r8b");
 }
 else if(reg==5)
 {
 outs("%r9b");
 }
 else if(reg==6)
 {
 outs("%r12b");
 }
 else if(reg==7)
 {
 outs("%r13b");
 }
 else if(reg==8)
 {
 outs("%r14b");
 }
 else if(reg==9)
 {
 outs("%r15b");
 }
 else if(reg==10)
 {
 outs("%r10b");
 }
 else if(reg==11)
 {
 outs("%r11b");
 }
}
void out_reg(int class,int reg)
{
 if(class==1||class==2)
 {
 out_reg8(reg);
 }
 else if(class==3||class==4)
 {
 out_reg16(reg);
 }
 else if(class==5||class==6||class==9)
 {
 out_reg32(reg);
 }
 else if(class==7||class==8||class==10)
 {
 out_reg64(reg);
 }
}
char *get_len(int class)
{
 if(class==1||class==2)
 {
 return "b";
 }
 else if(class==3||class==4)
 {
 return "w";
 }
 else if(class==5||class==6)
 {
 return "l";
 }
 else if(class==7||class==8)
 {
 return "q";
 }
}
void out_num64(unsigned long int n)
{
 char *str;
 str=scc__str_i_app(0,n);
 outs(str);
 free(str);
}
void out_num32(unsigned long int n)
{
 out_num64(n&0xffffffff);
}
void out_num16(unsigned long int n)
{
 out_num64(n&0xffff);
}
void out_num8(unsigned long int n)
{
 out_num64(n&0xff);
}
void out_num(int class,unsigned long int n)
{
 if(class==1||class==2)
 {
 out_num8(n);
 }
 else if(class==3||class==4)
 {
 out_num16(n);
 }
 else if(class==5||class==6)
 {
 out_num32(n);
 }
 else if(class==7||class==8)
 {
 out_num64(n);
 }
 else if(class==10)
 {
 out_num64(n);
 }
 else if(class==9)
 {
 float n2;
 n2=*(double *)&n;
 out_num32(*(unsigned int *)&n2);
 }
}
void out_rax(int class)
{
 if(class==1||class==2)
 {
 outs("%al");
 }
 else if(class==3||class==4)
 {
 outs("%ax");
 }
 else if(class==5||class==6||class==9)
 {
 outs("%eax");
 }
 else if(class==7||class==8||class==10)
 {
 outs("%rax");
 }
}
void out_rcx(int class)
{
 if(class==1||class==2)
 {
 outs("%cl");
 }
 else if(class==3||class==4)
 {
 outs("%cx");
 }
 else if(class==5||class==6||class==9)
 {
 outs("%ecx");
 }
 else if(class==7||class==8||class==10)
 {
 outs("%rcx");
 }
}
void out_rdx(int class)
{
 if(class==1||class==2)
 {
 outs("%dl");
 }
 else if(class==3||class==4)
 {
 outs("%dx");
 }
 else if(class==5||class==6||class==9)
 {
 outs("%edx");
 }
 else if(class==7||class==8||class==10)
 {
 outs("%rdx");
 }
}
void out_acd(int class,int reg)
{
 if(reg==0)
 {
 out_rax(class);
 }
 else if(reg==1)
 {
 out_rcx(class);
 }
 else if(reg==2)
 {
 out_rdx(class);
 }
}
void acd_extend(int reg,int newclass,int oldclass)
{
 int size1,size2;
 if(newclass==9||newclass==10)
 {
 if(oldclass!=9&&oldclass!=10)
 {
 if(oldclass<7)
 {
 acd_extend(reg,7,oldclass);
 oldclass=7;
 }
 if(newclass==10)
 {
 outs("cvtsi2sd ");
 }
 else
 {
 outs("cvtsi2ss ");
 }
 out_acd(oldclass,reg);
 outs(",%xmm0");
 if(newclass==9)
 {
 outs("movd %xmm0,");
 }
 else
 {
 outs("movq %xmm0,");
 }
 out_acd(newclass,reg);
 outs("\n");
 }
 else if(newclass==9&&oldclass==10)
 {
 outs("movq ");
 out_acd(oldclass,reg);
 outs(",%xmm0\ncvtsd2ss %xmm0,%xmm0\nmovd %xmm0,");
 out_acd(newclass,reg);
 outs("\n");
 }
 else if(newclass==10&&oldclass==9)
 {
 outs("movd ");
 out_acd(oldclass,reg);
 outs(",%xmm0\ncvtss2sd %xmm0,%xmm0\nmovq %xmm0,");
 out_acd(newclass,reg);
 outs("\n");
 }
 return;
 }
 else if(oldclass==9)
 {
 outs("movd ");
 out_acd(9,reg);
 outs(",%xmm0\ncvtss2si %xmm0,");
 out_acd(8,reg);
 outs("\n");
 return;
 }
 else if(oldclass==10)
 {
 outs("movq ");
 out_acd(10,reg);
 outs(",%xmm0\ncvtsd2si %xmm0,");
 out_acd(8,reg);
 outs("\n");
 return;
 }
 size1=newclass-1>>1;
 size2=oldclass-1>>1;
 if(size1<=size2)
 {
 return;
 }
 outs("mov");
 if(size1==3&&size2==2&&!(oldclass&1))
 {
 outs(" ");
 out_acd(5,reg);
 outs(",");
 out_acd(5,reg);
 outs("\n");
 return;
 }
 if(oldclass&1)
 {
 outs("s");
 }
 else
 {
 outs("z");
 }
 if(size2==0)
 {
 outs("b");
 }
 else if(size2==1)
 {
 outs("w");
 }
 else if(size2==2)
 {
 outs("l");
 }
 else if(size2==3)
 {
 outs("q");
 }
 if(size1==0)
 {
 outs("b ");
 }
 else if(size1==1)
 {
 outs("w ");
 }
 else if(size1==2)
 {
 outs("l ");
 }
 else if(size1==3)
 {
 outs("q ");
 }
 out_acd(oldclass,reg);
 outs(",");
 out_acd(newclass,reg);
 outs("\n");
}
char *sgetc(char *str,char *ret)
{
 int x;
 if(str[0]=='\\')
 {
 if(str[1]=='\\')
 {
 *ret='\\';
 return str+2;
 }
 else if(str[1]=='n')
 {
 *ret='\n';
 return str+2;
 }
 else if(str[1]=='t')
 {
 *ret='\t';
 return str+2;
 }
 else if(str[1]=='v')
 {
 *ret='\v';
 return str+2;
 }
 else if(str[1]=='r')
 {
 *ret='\r';
 return str+2;
 }
 else if(str[1]=='\'')
 {
 *ret='\'';
 return str+2;
 }
 else if(str[1]=='\"')
 {
 *ret='\"';
 return str+2;
 }
 else if(str[1]=='\?')
 {
 *ret='\?';
 return str+2;
 }
 else if(str[1]>='0'&&str[1]<='7')
 {
 x=1;
 *ret=0;
 while(str[x]>='0'&&str[x]<='7')
 {
 *ret=(*ret<<3)+(str[x]-'0');
 ++x;
 }
 return str+x;
 }
 else if(str[1]=='x')
 {
 x=2;
 *ret=0;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 *ret=*ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 *ret=*ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 *ret=*ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 return str+x;
 }
 else
 {
 *ret='\\';
 return str+1;
 }
 }
 else
 {
 *ret=str[0];
 return str+1;
 }
}
void out_str(char *str)
{
 char c[2];
 c[1]=0;
 str=str+1;
 while(*str&&*str!='\"')
 {
 str=sgetc(str,c);
 outs(c);
 }
}
struct ins
{
 char *args[4];
 long int var_num[3];
 long int line;
 short is_const[2];
 char is_global[3];
 char scale;
 unsigned long int const_val[2];
 int count_args;
 int op;
 long int stack_size;
 unsigned long valdef[4];
 unsigned long valuse[4];
 unsigned long valin[4];
 unsigned long valout[4];
 unsigned long int used_regs;
 unsigned int mark;
 unsigned short int mark2;
 unsigned short int mark3;
 long int off;
 long arg_map[11];
 struct ins *branch;
 struct ins *next;
} *ins_head,*ins_end;
long int next_num;
struct label_tab
{
 char *name;
 struct ins *ins;
 struct label_tab *next;
} *label_tab[1021];
void label_tab_add(char *name,struct ins *ins)
{
 int hash;
 struct label_tab *node;
 hash=name_hash(name);
 node=scc__xmalloc(sizeof(*node));
 node->name=scc__xstrdup(name);
 node->ins=ins;
 node->next=label_tab[hash];
 label_tab[hash]=node;
}
struct label_tab *label_tab_find(char *name)
{
 int hash;
 struct label_tab *node;
 hash=name_hash(name);
 node=label_tab[hash];
 while(node)
 {
 if(!strcmp(node->name,name))
 {
 return node;
 }
 node=node->next;
 }
 return 0;
}
struct id_tab
{
 char *name;
 long int num;
 int class;
 int unused;
 long int size;
 long int off;
 long int reg;
 long int storage;
 struct ins *def;
 struct ins *endf;
 struct id_tab *next;
} *global_id[1021],*local_id[1021],*args_id[1021];
void id_tab_add(struct id_tab **tab,char *name,long int num,long int class,long int size,long int off,struct ins *def,struct ins *endf,int unused)
{
 int hash;
 struct id_tab *node;
 hash=name_hash(name);
 node=scc__xmalloc(sizeof(*node));
 node->name=scc__xstrdup(name);
 node->num=num;
 node->class=class;
 node->size=size;
 node->off=off;
 node->def=def;
 node->endf=endf;
 node->reg=-1;
 node->unused=unused;
 node->next=tab[hash];
 tab[hash]=node;
}
struct id_tab *id_tab_find(struct id_tab **tab,char *name)
{
 int hash;
 struct id_tab *node;
 hash=name_hash(name);
 node=tab[hash];
 while(node)
 {
 if(!strcmp(node->name,name))
 {
 return node;
 }
 node=node->next;
 }
 return 0;
}
void id_tab_release(struct id_tab **tab)
{
 int x;
 struct id_tab *node;
 x=0;
 while(x<1021)
 {
 while(tab[x])
 {
 node=tab[x];
 tab[x]=node->next;
 free(node->name);
 free(node);
 }
 ++x;
 }
}
struct ins *next_op(struct ins *ins)
{
 while(ins&&!ins->op)
 {
 if(ins->count_args)
 {
 if(!strcmp(ins->args[0],"endf"))
 {
 return 0;
 }
 }
 ins=ins->next;
 }
 return ins;
}
 
unsigned long int const_to_num(char *str)
{
 unsigned long int ret;
 int x;
 ret=0;
 if(str[0]=='\'')
 {
 ++str;
 if(str[0]=='\\')
 {
 if(str[1]=='\\')
 {
 ret='\\';
 }
 else if(str[1]=='n')
 {
 ret='\n';
 }
 else if(str[1]=='t')
 {
 ret='\t';
 }
 else if(str[1]=='v')
 {
 ret='\v';
 }
 else if(str[1]=='r')
 {
 ret='\r';
 }
 else if(str[1]=='\'')
 {
 ret='\'';
 }
 else if(str[1]=='\"')
 {
 ret='\"';
 }
 else if(str[1]=='\?')
 {
 ret='\?';
 }
 else if(str[1]>='0'&&str[1]<='7')
 {
 x=1;
 while(str[x]>='0'&&str[x]<='7')
 {
 ret=(ret<<3)+(str[x]-'0');
 ++x;
 }
 }
 else if(str[1]=='x')
 {
 x=2;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 ret=ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 ret=ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 }
 else
 {
 ret='\\';
 }
 }
 else
 {
 ret=str[0];
 }
 }
 else if(str[0]>='1'&&str[0]<='9')
 {
 x=0;
 while(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*10+(str[x]-'0');
 ++x;
 }
 }
 else if(str[1]=='X'||str[1]=='x')
 {
 x=2;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 ret=ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 ret=ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 }
 else
 {
 x=0;
 while(str[x]>='0'&&str[x]<='7')
 {
 ret=(ret<<3)+(str[x]-'0');
 ++x;
 }
 }
 return ret;
}
unsigned long int fconst_to_num(char *str,int *status)
{
 unsigned long int ret;
 int x;
 x=0;
 *status=0;
 if(str[0]<'0'||str[0]>'9')
 {
 return 0;
 }
 while(str[x])
 {
 if(str[x]=='.')
 {
 double a,b;
 int s;
 x=0;
 s=0;
 a=0.0;
 b=0.1;
 while(str[x])
 {
 if(str[x]=='.')
 {
 s=1;
 }
 else if(s)
 {
 a+=b*(double)(str[x]-'0');
 b*=0.1;
 }
 else
 {
 a=a*10.0+(double)(str[x]-'0');
 }
 ++x;
 }
 memcpy(&ret,&a,8);
 *status=1;
 return ret;
 }
 ++x;
 }
 return 0;
}
 
void ins_add(char *str)
{
 int x;
 struct ins *node;
 node=scc__xmalloc(sizeof(*node));
 node->line=current_line;
 node->count_args=0;
 node->op=0;
 node->used_regs=0;
 node->is_const[0]=0;
 node->is_const[1]=0;
 node->is_global[0]=0;
 node->is_global[1]=0;
 node->is_global[2]=0;
 node->const_val[0]=0;
 node->const_val[1]=0;
 memset(node->arg_map,0xff,11*8);
 x=0;
 while(x<4)
 {
 if(node->args[x]=sdup(str))
 {
 ++node->count_args;
 }
 str=snext(str);
 ++x;
 if(x==1&&node->count_args)
 {
 if(!strcmp(node->args[0],"mov"))
 {
 node->op=12;
 }
 if(!strcmp(node->args[0],"not"))
 {
 node->op=1;
 }
 if(!strcmp(node->args[0],"neg"))
 {
 node->op=1;
 }
 if(!strcmp(node->args[0],"adr"))
 {
 node->op=11;
 }
 if(!strcmp(node->args[0],"adro"))
 {
 node->op=11;
 }
 if(!strcmp(node->args[0],"add"))
 {
 node->op=13;
 }
 if(!strcmp(node->args[0],"sub"))
 {
 node->op=14;
 }
 if(!strcmp(node->args[0],"mul"))
 {
 node->op=17;
 }
 if(!strcmp(node->args[0],"div"))
 {
 node->op=2;
 }
 if(!strcmp(node->args[0],"mod"))
 {
 node->op=2;
 }
 if(!strcmp(node->args[0],"and"))
 {
 node->op=2;
 }
 if(!strcmp(node->args[0],"orr"))
 {
 node->op=2;
 }
 if(!strcmp(node->args[0],"eor"))
 {
 node->op=2;
 }
 if(!strcmp(node->args[0],"lsh"))
 {
 node->op=2;
 }
 if(!strcmp(node->args[0],"rsh"))
 {
 node->op=2;
 }
 if(!strcmp(node->args[0],"push"))
 {
 node->op=3;
 }
 if(!strcmp(node->args[0],"pushf"))
 {
 node->op=3;
 }
 if(!strcmp(node->args[0],"pushh"))
 {
 node->op=3;
 }
 if(!strcmp(node->args[0],"retval"))
 {
 node->op=9;
 }
 if(!strcmp(node->args[0],"retvalh"))
 {
 node->op=9;
 }
 if(!strcmp(node->args[0],"retvalf"))
 {
 node->op=9;
 }
 if(!strcmp(node->args[0],"ret"))
 {
 node->op=10;
 }
 if(!strcmp(node->args[0],"call"))
 {
 node->op=4;
 }
 if(!strcmp(node->args[0],"fcall"))
 {
 node->op=4;
 }
 if(!strcmp(node->args[0],"hcall"))
 {
 node->op=4;
 }
 if(!strcmp(node->args[0],"stob"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stow"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stol"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stoq"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stof"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stoh"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"ldob"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldow"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldol"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldoq"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldof"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldoh"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"stb"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stw"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stl"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stq"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"stf"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"sth"))
 {
 node->op=5;
 }
 if(!strcmp(node->args[0],"ldb"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldw"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldl"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldq"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldf"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"ldh"))
 {
 node->op=6;
 }
 if(!strcmp(node->args[0],"beq"))
 {
 node->op=7;
 }
 if(!strcmp(node->args[0],"bne"))
 {
 node->op=7;
 }
 if(!strcmp(node->args[0],"bgt"))
 {
 node->op=7;
 }
 if(!strcmp(node->args[0],"blt"))
 {
 node->op=7;
 }
 if(!strcmp(node->args[0],"bge"))
 {
 node->op=7;
 }
 if(!strcmp(node->args[0],"ble"))
 {
 node->op=7;
 }
 if(!strcmp(node->args[0],"bal"))
 {
 node->op=8;
 }
 }
 }
 node->next=0;
 if(ins_head)
 {
 ins_end->next=node;
 }
 else
 {
 ins_head=node;
 }
 ins_end=node;
}
long int data_size;
void load_global_vars(void)
{
 struct ins *node;
 long int class,size;
 char *name;
 long int off;
 off=0;
 node=ins_head;
 while(node)
 {
 ++next_num;
 if(node->count_args>=3)
 {
 if(!strcmp(node->args[0],"global"))
 {
 if(!strcmp(node->args[1],"mem"))
 {
 if(node->count_args<4)
 {
 error(node->line,"too few arguments.");
 }
 size=const_to_num(node->args[2]);
 class=0;
 name=node->args[3];
 }
 else if(!strcmp(node->args[1],"s8"))
 {
 size=1;
 class=1;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"u8"))
 {
 size=1;
 class=2;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"s16"))
 {
 size=2;
 class=3;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"u16"))
 {
 size=2;
 class=4;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"s32"))
 {
 size=4;
 class=5;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"u32"))
 {
 size=4;
 class=6;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"s64"))
 {
 size=8;
 class=7;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"u64"))
 {
 size=8;
 class=8;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"void"))
 {
 size=8;
 class=8;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"float"))
 {
 size=8;
 class=10;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"hfloat"))
 {
 size=4;
 class=9;
 name=node->args[2];
 }
 else
 {
 error(node->line,"invalid type.");
 }
 if(!id_tab_find(global_id,name))
 {
 if(strcmp(name,"<NULL>"))
 {
 id_tab_add(global_id,name,next_num,class,size,off,0,0,0);
 }
 else
 {
 size=0;
 }
 }
 }
 else
 {
 size=0;
 }
 }
 else
 {
 size=0;
 }
 off+=size;
 off=off+15&0xfffffffffffffff0;
 node=node->next;
 }
 data_size=off;
}
void load_labels(void)
{
 struct ins *node;
 node=ins_head;
 while(node)
 {
 if(node->count_args>=2)
 {
 if(!strcmp(node->args[0],"label"))
 {
 if(!label_tab_find(node->args[1]))
 {
 label_tab_add(node->args[1],node);
 }
 }
 }
 node=node->next;
 }
}
void load_branches(void)
{
 struct ins *node;
 int b;
 struct label_tab *label;
 node=ins_head;
 while(node)
 {
 if(node->count_args>1)
 {
 b=0;
 if(!strcmp(node->args[0],"beq"))
 {
 b=1;
 }
 else if(!strcmp(node->args[0],"bne"))
 {
 b=1;
 }
 else if(!strcmp(node->args[0],"blt"))
 {
 b=1;
 }
 else if(!strcmp(node->args[0],"bgt"))
 {
 b=1;
 }
 else if(!strcmp(node->args[0],"ble"))
 {
 b=1;
 }
 else if(!strcmp(node->args[0],"bge"))
 {
 b=1;
 }
 else if(!strcmp(node->args[0],"bal"))
 {
 b=2;
 }
 if(b==1)
 {
 if(node->count_args<4)
 {
 error(node->line,"too few arguments.");
 }
 label=label_tab_find(node->args[3]);
 if(!label)
 {
 error(node->line,"label not defined.");
 }
 node->branch=label->ins;
 }
 else if(b==2)
 {
 label=label_tab_find(node->args[1]);
 if(!label)
 {
 error(node->line,"label not defined.");
 }
 node->branch=label->ins;
 }
 else
 {
 node->branch=0;
 }
 }
 else
 {
 node->branch=0;
 }
 node=node->next;
 }
}
struct ins *fstart,*fend;
long int fline;
long int fend_line;
struct id_list
{
 long int num;
 char *name;
 long int flag;
 struct id_list *next;
} *id_list_head;
void id_list_add(char *name)
{
 struct id_list *node;
 struct id_tab *id;
 node=scc__xmalloc(sizeof(*node));
 node->flag=0;
 id=id_tab_find(local_id,name);
 if(!id)
 {
 node->flag=1;
 id=id_tab_find(args_id,name);
 if(!id)
 {
 id=id_tab_find(global_id,name);
 }
 }
 if(id->unused)
 {
 free(node);
 return;
 }
 node->num=id->num;
 node->name=scc__xstrdup(name);
 node->next=id_list_head;
 id_list_head=node;
}
void id_list_release(void)
{
 struct id_list *node;
 while(node=id_list_head)
 {
 id_list_head=node->next;
 free(node->name);
 free(node);
 }
}
struct reg_map
{
 unsigned int *bitmap;
 struct reg_map *next;
 unsigned long int uses;
 unsigned long int n;
} *reg_map_head,*reg_map_end;
unsigned long int count_reg_maps;
struct reg_map *new_reg_map(void)
{
 struct reg_map *node;
 long int size;
 size=current_line/32+1;
 node=scc__xmalloc(sizeof(*node));
 node->bitmap=scc__xmalloc(size*4);
 memset(node->bitmap,0,size*4);
 node->next=0;
 node->uses=0;
 node->n=count_reg_maps;
 if(reg_map_head)
 {
 reg_map_end->next=node;
 }
 else
 {
 reg_map_head=node;
 }
 reg_map_end=node;
 ++count_reg_maps;
 return node;
}
void reg_map_release(void)
{
 struct reg_map *node;
 while(node=reg_map_head)
 {
 reg_map_head=node->next;
 free(node->bitmap);
 free(node);
 }
 reg_map_end=0;
 count_reg_maps=0;
}
void reg_map_sort(void)
{
 int s;
 struct reg_map *p,*node,*t;
 do
 {
 s=0;
 p=0;
 node=reg_map_head;
 if(node)
 {
 while(node->next)
 {
 if(node->next->uses>node->uses)
 {
 t=node->next;
 node->next=t->next;
 t->next=node;
 if(p)
 {
 p->next=t;
 }
 else
 {
 reg_map_head=t;
 }
 s=1;
 p=t;
 }
 else
 {
 p=node;
 node=node->next;
 }
 }
 }
 }
 while(s);
}
unsigned long int get_reg_index(unsigned long int n)
{
 unsigned long int reg;
 struct reg_map *node;
 reg=0;
 node=reg_map_head;
 while(node)
 {
 if(node->n==n)
 {
 break;
 }
 node=node->next;
 ++reg;
 }
 return reg;
}
 
void init_def_use(void)
{
 struct ins *node;
 char *str;
 struct id_list *id;
 int x;
 unsigned long a;
 a=1;
 node=fstart;
 while(node&&node!=fend)
 {
 id=id_list_head;
 x=0;
 while(id)
 {
 if(node->op==1||node->op==11||node->op==12)
 {
 
 if(id->num==node->var_num[1])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 else if(id->num==node->var_num[0])
 {
 node->valdef[x>>6]|=a<<(x&63);
 }
 }
 else if(node->op==2||node->op==13||node->op==14||node->op==17)
 {
 if(id->num==node->var_num[2])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 else if(id->num==node->var_num[1])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 else if(id->num==node->var_num[0])
 {
 node->valdef[x>>6]|=a<<(x&63);
 }
 }
 else if(node->op==3)
 {
 if(id->num==node->var_num[0])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 }
 else if(node->op==4)
 {
 if(id->num==node->var_num[1])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 else if(id->num==node->var_num[0])
 {
 node->valdef[x>>6]|=a<<(x&63);
 }
 }
 else if(node->op==5)
 {
 if(id->num==node->var_num[1])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 else if(id->num==node->var_num[0])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 }
 else if(node->op==6)
 {
 if(id->num==node->var_num[1])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 else if(id->num==node->var_num[0])
 {
 node->valdef[x>>6]|=a<<(x&63);
 }
 }
 else if(node->op==7)
 {
 if(id->num==node->var_num[1])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 else if(id->num==node->var_num[0])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 }
 else if(node->op==9)
 {
 if(id->num==node->var_num[0])
 {
 node->valuse[x>>6]|=a<<(x&63);
 }
 }
 ++x;
 id=id->next;
 }
 node=node->next;
 }
}
void calculate_df(void)
{
 struct ins *ins;
 unsigned long int s;
 unsigned long int old_in[4];
 ins=fstart;
 while(ins&&ins!=fend)
 {
 ins->valin[0]=0;
 ins->valin[1]=0;
 ins->valin[2]=0;
 ins->valin[3]=0;
 ins=ins->next;
 }
 do
 {
 s=0;
 ins=fstart;
 while(ins&&ins!=fend)
 {
 ins->valout[0]=0;
 ins->valout[1]=0;
 ins->valout[2]=0;
 ins->valout[3]=0;
 if(ins->next&&ins->next!=fend&&ins->op!=8&&ins->op!=9&&ins->op!=10)
 {
 ins->valout[0]|=ins->next->valin[0];
 ins->valout[1]|=ins->next->valin[1];
 ins->valout[2]|=ins->next->valin[2];
 ins->valout[3]|=ins->next->valin[3];
 }
 if(ins->branch)
 {
 ins->valout[0]|=ins->branch->valin[0];
 ins->valout[1]|=ins->branch->valin[1];
 ins->valout[2]|=ins->branch->valin[2];
 ins->valout[3]|=ins->branch->valin[3];
 }
 old_in[0]=ins->valin[0];
 old_in[1]=ins->valin[1];
 old_in[2]=ins->valin[2];
 old_in[3]=ins->valin[3];
 ins->valin[0]=ins->valuse[0]|ins->valout[0]&~ins->valdef[0];
 ins->valin[1]=ins->valuse[1]|ins->valout[1]&~ins->valdef[1];
 ins->valin[2]=ins->valuse[2]|ins->valout[2]&~ins->valdef[2];
 ins->valin[3]=ins->valuse[3]|ins->valout[3]&~ins->valdef[3];
 s|=old_in[0]^ins->valin[0];
 s|=old_in[1]^ins->valin[1];
 s|=old_in[2]^ins->valin[2];
 s|=old_in[3]^ins->valin[3];
 ins=ins->next;
 }
 }
 while(s);
}
unsigned int *gen_var_map(int index)
{
 long int size;
 unsigned int *ret;
 long int x;
 struct ins *ins;
 unsigned long a;
 a=1;
 size=current_line-current_line%32+32;
 ret=scc__xmalloc(size/8);
 memset(ret,0,size/8);
 x=fline;
 ins=fstart;
 while(ins&&ins!=fend)
 {
 if((ins->valin[index>>6]|ins->valdef[index>>6])&a<<(index&63))
 {
 ret[x/32]|=1<<x%32;
 }
 ++x;
 ins=ins->next;
 }
 return ret;
}
int if_reg_available(struct reg_map *rmap,unsigned int *vmap)
{
 long int size,x,n;
 size=current_line/32+1;
 x=fline/32;
 n=fend_line/32+1;
 while(x<size&&x<n)
 {
 if(rmap->bitmap[x]&vmap[x])
 {
 return 0;
 }
 ++x;
 }
 return 1;
}
void use_reg(struct reg_map *rmap,unsigned int *vmap)
{
 long int size,x,n;
 size=current_line/32+1;
 x=fline/32;
 n=fend_line/32+1;
 while(x<size&&x<n)
 {
 rmap->bitmap[x]|=vmap[x];
 ++x;
 }
 ++rmap->uses;
}
void get_reg(void)
{
 struct ins *ins;
 struct id_list *id;
 struct id_tab *tab;
 unsigned int *map;
 struct reg_map *rmap;
 int x,s;
 ins=fstart;
 while(ins&&ins!=fend)
 {
 ins->valdef[0]=0;
 ins->valdef[1]=0;
 ins->valdef[2]=0;
 ins->valdef[3]=0;
 ins->valuse[0]=0;
 ins->valuse[1]=0;
 ins->valuse[2]=0;
 ins->valuse[3]=0;
 ins=ins->next;
 }
 init_def_use();
 calculate_df();
 x=0;
 id=id_list_head;
 while(id)
 {
 s=0;
 tab=id_tab_find(local_id,id->name);
 if(!tab)
 {
 tab=id_tab_find(args_id,id->name);
 s=1;
 }
 map=gen_var_map(x);
 rmap=reg_map_head;
 while(rmap)
 {
 if(if_reg_available(rmap,map))
 {
 if(!s||(rmap->n>=11||fstart->arg_map[rmap->n]==-1))
 {
 break;
 }
 }
 rmap=rmap->next;
 }
 if(!rmap)
 {
 rmap=new_reg_map();
 }
 if(fstart&&(rmap->n<11||!s))
 {
 tab->reg=rmap->n;
 if(tab->reg<11)
 {
 fstart->used_regs|=1<<tab->reg;
 }
 if(s)
 {
 fstart->arg_map[tab->reg]=tab->off;
 }
 use_reg(rmap,map);
 }
 free(map);
 reg_map_sort();
 ++x;
 id=id->next;
 }
 id_list_release();
}

void load_local_vars(void)
{
 struct ins *node;
 long int class,size,unused;
 char *name;
 long int arglist,off;
 int count;
 int x;
 node=ins_head;
 arglist=0;
 x=0;
 while(node)
 {
 ++next_num;
 if(node->count_args&&!strcmp(node->args[0],"arglist"))
 {
 arglist=1;
 off=0;
 }
 else if(node->count_args&&!strcmp(node->args[0],"enda"))
 {
 arglist=0;
 }
 else if(node->count_args>=3)
 {
 if(!strcmp(node->args[0],"local"))
 {
 unused=0;
 if(!strcmp(node->args[1],"mem"))
 {
 if(node->count_args<4)
 {
 error(node->line,"too few arguments.");
 }
 size=const_to_num(node->args[2]);
 class=0;
 name=node->args[3];
 }
 else if(!strcmp(node->args[1],"s8"))
 {
 size=1;
 class=1;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"u8"))
 {
 size=1;
 class=2;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"s16"))
 {
 size=2;
 class=3;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"u16"))
 {
 size=2;
 class=4;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"s32"))
 {
 size=4;
 class=5;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"u32"))
 {
 size=4;
 class=6;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"s64"))
 {
 size=8;
 class=7;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"u64"))
 {
 size=8;
 class=8;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"void"))
 {
 size=8;
 class=8;
 unused=1;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"float"))
 {
 size=8;
 class=10;
 name=node->args[2];
 }
 else if(!strcmp(node->args[1],"hfloat"))
 {
 size=4;
 class=9;
 name=node->args[2];
 }
 else
 {
 error(node->line,"invalid type.");
 }
 if(!id_tab_find(global_id,name))
 {
 if(arglist)
 {
 id_tab_add(args_id,name,next_num,class,size,off,0,0,0);
 ++off;
 }
 else
 {
 id_tab_add(local_id,name,next_num,class,size,0,0,0,unused);
 }
 }
 else
 {
 error(node->line,"duplicate identifier.");
 }
 }
 }
 node=node->next;
 }
}
void reg_init(void)
{
 struct ins *ins,*node;
 struct id_tab *id;
 int x,class;
 long int arglist;
 char *name;
 long int num;
 long int off,size;
 struct id_list *il;
 char c,c1;
 ins=ins_head;
 while(ins)
 {
 x=1;
 while(x<ins->count_args)
 {
 if(id=id_tab_find(local_id,ins->args[x]))
 {
 ins->var_num[x-1]=id->num;
 }
 else if(id=id_tab_find(args_id,ins->args[x]))
 {
 ins->var_num[x-1]=id->num;
 }
 else if(id=id_tab_find(global_id,ins->args[x]))
 {
 ins->var_num[x-1]=id->num;
 ins->is_global[x-1]=1;
 }
 else
 {
 ins->var_num[x-1]=0;
 if(x>=2)
 {
 int y;
 y=0;
 while(c1=ins->args[x][y])
 {
 if(c1=='.')
 {
 break;
 }
 ++y;
 }
 c=ins->args[x][0];
 if(c>='0'&&c<='9'&&c1!='.'||c=='\'')
 {
 ins->is_const[x-2]=1;
 ins->const_val[x-2]=const_to_num(ins->args[x]);
 }
 else if(c>='0'&&c<='9')
 {
 ins->is_const[x-2]=1;
 }
 }
 }
 ++x;
 }
 while(x<4)
 {
 ins->var_num[x-1]=0;
 ++x;
 }
 ins=ins->next;
 }
 
 ins=ins_head;
 fstart=ins;
 fend=ins;
 x=0;
 arglist=0;
 fline=0;
 fend_line=0;
 num=0;
 off=0;
 while(ins)
 {
 if(ins->count_args)
 {
 if(!strcmp(ins->args[0],"fun"))
 {
 fstart=ins;
 fend=ins;
 fline=num;
 fend_line=num;
 off=0;
 while(fend&&(!fend->count_args||strcmp(fend->args[0],"endf")))
 {
 fend=fend->next;
 ++fend_line;
 }
 }
 else if(!strcmp(ins->args[0],"arglist"))
 {
 arglist=1;
 }
 else if(!strcmp(ins->args[0],"enda"))
 {
 arglist=0;
 }
 else if(!strcmp(ins->args[0],"endf"))
 {
 if(fstart)
 {
 if(x)
 {
 x=0;
 get_reg();
 }
 reg_map_release();
 }
 }
 else if(!strcmp(ins->args[0],"local"))
 {
 if(!strcmp(ins->args[1],"mem"))
 {
 if(ins->count_args<4)
 {
 error(ins->line,"too few arguments.");
 }
 class=0;
 name=ins->args[3];
 }
 else if(!strcmp(ins->args[1],"s8"))
 {
 class=1;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"u8"))
 {
 class=2;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"s16"))
 {
 class=3;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"u16"))
 {
 class=4;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"s32"))
 {
 class=5;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"u32"))
 {
 class=6;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"s64"))
 {
 class=7;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"u64"))
 {
 class=8;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"void"))
 {
 class=8;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"float"))
 {
 class=10;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"hfloat"))
 {
 class=9;
 name=ins->args[2];
 }
 else
 {
 error(ins->line,"invalid type.");
 }
 if(class!=0&&fstart)
 {
 id_list_add(name);
 ++x;
 if(x==256)
 {
 x=0;
 get_reg();
 }
 }
 }
 }
 ++num;
 ins=ins->next;
 }
 off=0;
 arglist=0;
 ins=ins_head;
 fstart=0;
 x=0;
 while(ins)
 {
 if(ins->count_args)
 {
 if(!strcmp(ins->args[0],"fun"))
 {
 fstart=ins;
 x=0;
 off=0;
 fstart->stack_size=0;
 }
 else if(!strcmp(ins->args[0],"arglist"))
 {
 arglist=1;
 }
 else if(!strcmp(ins->args[0],"enda"))
 {
 arglist=0;
 }
 else if(!strcmp(ins->args[0],"endf"))
 {
 if(fstart)
 {
 fstart->stack_size-=32;
 if(x>=11)
 {
 fstart->stack_size-=(x-10)*8;
 }
 fstart->stack_size&=0xfffffffffffffff0;
 }
 }
 else if(!strcmp(ins->args[0],"adr"))
 {
 if(ins->count_args<3)
 {
 error(ins->line,"too few arguments.");
 }
 if(id=id_tab_find(local_id,ins->args[2]))
 {
 if(id->reg>=0)
 {
 id->reg=-1;
 off-=size;
 off=off&0xfffffffffffffff0;
 id->off=off;
 if(fstart)
 {
 fstart->stack_size=off;
 }
 }
 }
 else if(id=id_tab_find(args_id,ins->args[2]))
 {
 if(id->reg>=0)
 {
 id->reg=-1;
 }
 }
 }
 else if(!strcmp(ins->args[0],"adro"))
 {
 if(ins->count_args<4)
 {
 error(ins->line,"too few arguments.");
 }
 if(id=id_tab_find(local_id,ins->args[2]))
 {
 if(id->reg>=0)
 {
 id->reg=-1;
 off-=size;
 off=off&0xfffffffffffffff0;
 id->off=off;
 if(fstart)
 {
 fstart->stack_size=off;
 }
 }
 }
 else if(id=id_tab_find(args_id,ins->args[2]))
 {
 if(id->reg>=0)
 {
 id->reg=-1;
 }
 }
 }
 else if(!strcmp(ins->args[0],"local"))
 {
 if(ins->count_args<3)
 {
 error(ins->line,"too few arguments.");
 }
 if(!strcmp(ins->args[1],"mem"))
 {
 if(ins->count_args<4)
 {
 error(ins->line,"too few arguments.");
 }
 size=const_to_num(ins->args[2]);
 name=ins->args[3];
 }
 else if(!strcmp(ins->args[1],"s8"))
 {
 size=1;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"u8"))
 {
 size=1;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"s16"))
 {
 size=2;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"u16"))
 {
 size=2;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"s32"))
 {
 size=4;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"u32"))
 {
 size=4;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"s64"))
 {
 size=8;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"u64"))
 {
 size=8;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"void"))
 {
 size=8;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"float"))
 {
 size=8;
 name=ins->args[2];
 }
 else if(!strcmp(ins->args[1],"hfloat"))
 {
 size=4;
 name=ins->args[2];
 }
 else
 {
 error(ins->line,"invalid type.");
 }
 
 if(id=id_tab_find(local_id,name))
 {
 if(id->reg==-1)
 {
 off-=size;
 off=off&0xfffffffffffffff0;
 id->off=off;
 if(fstart)
 {
 fstart->stack_size=off;
 }
 }
 else if(id->reg>x)
 {
 x=id->reg;
 }
 }
 }
 }
 ++num;
 ins=ins->next;
 }
 
}
struct id_tab *id_find(char *name)
{
 struct id_tab *ret;
 if(ret=id_tab_find(local_id,name))
 {
 ret->storage=0;
 return ret;
 }
 if(ret=id_tab_find(args_id,name))
 {
 ret->storage=1;
 return ret;
 }
 if(ret=id_tab_find(global_id,name))
 {
 ret->storage=2;
 return ret;
 }
 return 0;
}
long int fun_stack_size;
struct operand
{
 long int type;
 struct id_tab *tab;
 unsigned long int value;
 long int fvalue;
 long int is_float;
 char *str;
};
void get_operand(struct ins *ins,int index,struct operand *ret)
{
 char *str;
 int s;
 memset(ret,0,sizeof(*ret));
 if(index>=ins->count_args)
 {
 error(ins->line,"too few arguments.");
 }
 str=ins->args[index];
 ret->str=str;
 if(ret->tab=id_find(str))
 {
 if(ret->tab->class==0)
 {
 ret->type=0;
 }
 else
 {
 ret->type=1;
 }
 }
 else if(str[0]>='0'&&str[0]<='9'||str[0]=='\'')
 {
 ret->type=2;
 ret->fvalue=fconst_to_num(str,&s);
 ret->is_float=s;
 ret->value=const_to_num(str);
 }
 else
 {
 ret->type=3;
 }
}
int op_is_reg(struct operand *op)
{
 if(!op->tab)
 {
 return 0;
 }
 if(op->tab->reg>=0&&op->tab->reg<11)
 {
 return 1;
 }
 return 0;
}
int op_is_const(struct operand *op)
{
 if(op->type==2||op->type==3)
 {
 return 1;
 }
 return 0;
}
int op_is_addr(struct operand *op)
{
 if(op->type==0)
 {
 return 1;
 }
 return 0;
}
void op_out_const(int class,struct operand *op)
{
 unsigned long val;
 double fval;
 float hval;
 if(op->type==2)
 {
 if(class==9||class==10)
 {
 if(op->is_float)
 {
 if(class==10)
 {
 out_num(class,op->fvalue);
 }
 else
 {
 memcpy(&fval,&op->fvalue,8);
 hval=fval;
 val=0;
 memcpy(&val,&hval,4);
 out_num(class,val);
 }
 }
 else
 {
 if(class==10)
 {
 fval=(double)op->value;
 memcpy(&val,&fval,8);
 out_num(class,val);
 }
 else
 {
 hval=(float)op->value;
 val=0;
 memcpy(&val,&hval,4);
 out_num(class,val);
 }
 }
 }
 else
 {
 if(op->is_float)
 {
 val=(long)op->fvalue;
 out_num(class,val);
 }
 else
 {
 out_num(class,op->value);
 }
 }
 }
 else if(op->type==3)
 {
 outs("@");
 outs(op->str);
 }
}
void op_out_reg(int class,struct operand *op)
{
 out_reg(class,op->tab->reg+1);
}
void op_out_mem(struct operand *op)
{
 long int x;
 if(op->tab->storage==0)
 {
 if(op->tab->reg>=11)
 {
 x=op->tab->reg-11;
 out_num(7,x*8+fun_stack_size);
 }
 else
 {
 out_num(7,op->tab->off);
 }
 outs("(%rbp)");
 }
 else if(op->tab->storage==2)
 {
 outs("@_$DATA+");
 out_num(7,op->tab->off);
 }
 else if(op->tab->storage==1)
 {
 out_num(7,op->tab->off*8+16);
 outs("(%rbp)");
 }
}
void op_out_mem_off(struct operand *op,struct operand *off)
{
 long int x;
 if(op->tab->storage==0)
 {
 if(op->tab->reg>=11)
 {
 x=op->tab->reg-11;
 out_num(7,x*8+fun_stack_size+off->value);
 }
 else
 {
 out_num(7,op->tab->off+off->value);
 }
 outs("(%rbp)");
 }
 else if(op->tab->storage==2)
 {
 outs("@_$DATA+");
 out_num(7,op->tab->off+off->value);
 }
 else if(op->tab->storage==1)
 {
 out_num(7,op->tab->off*8+16+off->value);
 outs("(%rbp)");
 }
}
int if_class_signed(int class)
{
 if(class==9||class==10)
 {
 return 0;
 }
 if(class&1)
 {
 return 1;
 }
 return 0;
}
int opcmp(struct operand *op1,struct operand *op2)
{
 int class1,class2;
 class1=0;
 class2=0;
 if(op_is_reg(op1))
 {
 class1=1;
 }
 else if(op_is_const(op1))
 {
 class1=2;
 }
 else if(op_is_addr(op1))
 {
 class1=3;
 }
 if(op_is_reg(op2))
 {
 class2=1;
 }
 else if(op_is_const(op2))
 {
 class2=2;
 }
 else if(op_is_addr(op2))
 {
 class2=3;
 }
 if(class1!=class2)
 {
 return 1;
 }
 if(class1==0)
 {
 if(op1->tab->storage!=op2->tab->storage)
 {
 return 1;
 }
 if(op1->tab->reg!=op2->tab->reg)
 {
 return 1;
 }
 if(op1->tab->off==op2->tab->off)
 {
 return 0;
 }
 }
 else if(class1==1)
 {
 if(op1->tab->reg==op2->tab->reg)
 {
 return 0;
 }
 }
 return 1;
}
void reg_extend(int class,int old_class,struct operand *op)
{
 int size1,size2;
 if(class==9||class==10)
 {
 if(old_class!=9&&old_class!=10)
 {
 if(old_class<7)
 {
 reg_extend(7,old_class,op);
 old_class=7;
 }
 if(class==10)
 {
 outs("cvtsi2sd ");
 }
 else
 {
 outs("cvtsi2ss ");
 }
 op_out_reg(old_class,op);
 outs(",%xmm0\n");
 if(class==10)
 {
 outs("movq %xmm0,");
 }
 else
 {
 outs("movd %xmm0,");
 }
 op_out_reg(class,op);
 outs("\n");
 }
 else if(class==9&&old_class==10)
 {
 outs("movq ");
 op_out_reg(10,op);
 outs(",%xmm0\ncvtsd2ss %xmm0,%xmm0\nmovd %xmm0,");
 op_out_reg(9,op);
 outs("\n");
 }
 else if(class==10&&old_class==9)
 {
 outs("movd ");
 op_out_reg(9,op);
 outs(",%xmm0\ncvtss2sd %xmm0,%xmm0\nmovq %xmm0,");
 op_out_reg(10,op);
 outs("\n");
 }
 return;
 } 
 else if(old_class==9)
 {
 outs("movd ");
 op_out_reg(9,op);
 outs(",%xmm0\ncvtss2si %xmm0,");
 op_out_reg(8,op);
 outs("\n");
 return;
 }
 else if(old_class==10)
 {
 outs("movq ");
 op_out_reg(10,op);
 outs(",%xmm0\ncvtsd2si %xmm0,");
 op_out_reg(8,op);
 outs("\n");
 return;
 }
 size1=class-1>>1;
 size2=old_class-1>>1;
 if(size1<=size2)
 {
 return;
 }
 outs("mov");
 if(size1==3&&size2==2&&!(old_class&1))
 {
 outs(" ");
 op_out_reg(5,op);
 outs(",");
 op_out_reg(5,op);
 outs("\n");
 return;
 }
 if(old_class&1)
 {
 outs("s");
 }
 else
 {
 outs("z");
 }
 if(size2==0)
 {
 outs("b");
 }
 else if(size2==1)
 {
 outs("w");
 }
 else if(size2==2)
 {
 outs("l");
 }
 else if(size2==3)
 {
 outs("q");
 }
 if(size1==0)
 {
 outs("b ");
 }
 else if(size1==1)
 {
 outs("w ");
 }
 else if(size1==2)
 {
 outs("l ");
 }
 else if(size1==3)
 {
 outs("q ");
 }
 op_out_reg(old_class,op);
 outs(",");
 op_out_reg(class,op);
 outs("\n");
}
void out_ins_acd1(char *ins1,char *ins2,char *ins3,struct operand *op1,int reg,int class)
{
 outs(ins1);
 if(ins2)
 {
 outs(ins2);
 }
 if(ins3)
 {
 outs(ins3);
 }
 outs(" ");
 if(op1)
 {
 if(op_is_reg(op1))
 {
 op_out_reg(op1->tab->class,op1);
 outs(",");
 out_acd(op1->tab->class,reg);
 }
 else if(op_is_const(op1))
 {
 outs("$");
 op_out_const(class,op1);
 outs(",");
 out_acd(class,reg);
 }
 else
 {
 op_out_mem(op1);
 outs(",");
 if(op_is_addr(op1))
 {
 out_acd(8,reg);
 }
 else
 {
 out_acd(class,reg);
 }
 }
 }
 outs("\n");
 if(op_is_addr(op1))
 {
 acd_extend(reg,class,8);
 }
 else if(!op_is_const(op1))
 {
 acd_extend(reg,class,op1->tab->class);
 }
}
void out_ins_acd2(char *ins1,char *ins2,char *ins3,int reg,struct operand *op1,int class)
{
 outs(ins1);
 if(ins2)
 {
 outs(ins2);
 }
 if(ins3)
 {
 outs(ins3);
 }
 outs(" ");
 out_acd(class,reg);
 if(op1)
 {
 outs(",");
 if(op_is_reg(op1))
 {
 op_out_reg(class,op1);
 }
 else if(op_is_const(op1))
 {
 outs("$");
 op_out_const(class,op1);
 }
 else
 {
 op_out_mem(op1);
 }
 }
 outs("\n");
}
void out_ins_acd3(char *ins1,char *ins2,char *ins3,int reg1,int reg2,int class)
{
 outs(ins1);
 if(ins2)
 {
 outs(ins2);
 }
 if(ins3)
 {
 outs(ins3);
 }
 outs(" ");
 out_acd(class,reg1);
 outs(",");
 out_acd(class,reg2);
 outs("\n");
}
void out_ins(char *ins1,char *ins2,char *ins3,struct operand *op1,struct operand *op2,char *ins4,int class)
{
 if(class==0)
 {
 if(op2)
 {
 class=op2->tab->class;
 }
 else
 {
 class=op1->tab->class;
 }
 }
 if(op_is_reg(op1)&&op1->tab->class!=9&&op2->tab->class!=9)
 {
 reg_extend(class,op1->tab->class,op1);
 }
 outs(ins1);
 if(ins2)
 {
 outs(ins2);
 }
 if(ins3)
 {
 outs(ins3);
 }
 outs(" ");
 if(op_is_reg(op1))
 {
 op_out_reg(class,op1);
 }
 else if(op_is_const(op1))
 {
 outs("$");
 op_out_const(class,op1);
 }
 else
 {
 op_out_mem(op1);
 }
 if(op2)
 {
 outs(",");
 if(op_is_reg(op2))
 {
 op_out_reg(class,op2);
 }
 else if(op_is_const(op2))
 {
 outs("$");
 op_out_const(class,op2);
 }
 else
 {
 op_out_mem(op2);
 }
 }
 if(ins4)
 {
 outs(ins4);
 }
 outs("\n");
 if(op2)
 {
 if(op_is_reg(op2))
 {
 reg_extend(class,op2->tab->class,op2);
 }
 }
}
int needs_convert(struct operand *op,struct operand *op2)
{
 if(op2->tab->class-1>>1>op->tab->class-1>>1)
 {
 return 1;
 }
 return 0;
}
int last_store_valid;
struct operand last_store[2];
char *fun_name;
 
void gen_mov(struct ins *ins)
{
 struct operand op1,op2;
 int class1,class2;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 class1=0;
 class2=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(!opcmp(&op1,&op2))
 {
 return;
 }
 if(class1==1)
 {
 if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 op_out_reg(op2.tab->class,&op1);
 outs("\n");
 reg_extend(op1.tab->class,op2.tab->class,&op1);
 }
 else if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 op_out_reg(op2.tab->class,&op1);
 outs("\n");
 reg_extend(op1.tab->class,op2.tab->class,&op1);
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 op_out_reg(8,&op1);
 outs("\n");
 }
 }
 else if(class1==0)
 {
 if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 }
 else
 {
 error(ins->line,"invalid op.");
 }
}
void gen_hfloat_basic_op(int class1,int class2,int class3,struct operand *op1,struct operand *op2,struct operand *op3,char *ins)
{
 if(class2==1&&class3==1)
 {
 if(op2->tab->class==9&&op3->tab->class==9)
 {
 outs("movd ");
 op_out_reg(6,op2);
 outs(",%xmm0\nmovd ");
 op_out_reg(6,op3);
 outs(",%xmm1\n");
 outs(ins);
 outs("%xmm1,%xmm0\n");
 if(class1==0)
 {
 outs("movss %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movd %xmm0,");
 op_out_reg(6,op1);
 }
 outs("\n");
 return;
 }
 }
 if(class2==0&&class3==1)
 {
 if(op2->tab->class==9&&op3->tab->class==9)
 {
 outs("movss ");
 op_out_mem(op2);
 outs(",%xmm0\nmovd ");
 op_out_reg(6,op3);
 outs(",%xmm1\n");
 outs(ins);
 outs("%xmm1,%xmm0\n");
 if(class1==0)
 {
 outs("movss %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movd %xmm0,");
 op_out_reg(6,op1);
 }
 outs("\n");
 return;
 }
 }
 if(class2==1&&class3==0)
 {
 if(op2->tab->class==9&&op3->tab->class==9)
 {
 outs("movd ");
 op_out_reg(6,op2);
 outs(",%xmm0\n");
 outs(ins);
 op_out_mem(op3);
 outs(",%xmm0\n");
 if(class1==0)
 {
 outs("movss %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movd %xmm0,");
 op_out_reg(6,op1);
 }
 outs("\n");
 return;
 }
 }
 if(class2==0&&class3==0)
 {
 if(op2->tab->class==9&&op3->tab->class==9)
 {
 outs("movss ");
 op_out_mem(op2);
 outs(",%xmm0\n");
 outs(ins);
 op_out_mem(op3);
 outs(",%xmm0\n");
 if(class1==0)
 {
 outs("movss %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movd %xmm0,");
 op_out_reg(6,op1);
 }
 outs("\n");
 return;
 }
 }
 if(class2==3)
 {
 outs("lea ");
 op_out_mem(op2);
 outs(",%rax\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(op2);
 outs(",");
 out_rax(op2->tab->class);
 outs("\n");
 acd_extend(0,op1->tab->class,op2->tab->class);
 }
 else if(class2==1)
 {
 outs("mov ");
 op_out_reg(8,op2);
 outs(",%rax\n");
 acd_extend(0,op1->tab->class,op2->tab->class);
 }
 else
 {
 outs("mov ");
 op_out_const(9,op2);
 outs(",%eax\n");
 }
 if(class3==3)
 {
 outs("lea ");
 op_out_mem(op3);
 outs(",%rcx\n");
 }
 else if(class3==0)
 {
 outs("mov ");
 op_out_mem(op3);
 outs(",");
 out_rcx(op3->tab->class);
 outs("\n");
 acd_extend(1,op1->tab->class,op3->tab->class);
 }
 else if(class3==1)
 {
 outs("mov ");
 op_out_reg(8,op3);
 outs(",%rcx\n");
 acd_extend(1,op1->tab->class,op3->tab->class);
 }
 else
 {
 outs("mov $");
 op_out_const(9,op3);
 outs(",%eax\n");
 }
 outs("movd %eax,%xmm0\n");
 outs("movd %ecx,%xmm1\n");
 outs(ins);
 outs("%xmm1,%xmm0\n");
 if(class1==0)
 {
 outs("movss %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movd %xmm0,");
 op_out_reg(6,op1);
 }
 outs("\n");
}
void gen_float_basic_op(int class1,int class2,int class3,struct operand *op1,struct operand *op2,struct operand *op3,char *ins)
{
 if(class2==1&&class3==1)
 {
 if(op2->tab->class==10&&op3->tab->class==10)
 {
 outs("movq ");
 op_out_reg(8,op2);
 outs(",%xmm0\nmovq ");
 op_out_reg(8,op3);
 outs(",%xmm1\n");
 outs(ins);
 outs("%xmm1,%xmm0\n");
 if(class1==0)
 {
 outs("movsd %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movq %xmm0,");
 op_out_reg(8,op1);
 }
 outs("\n");
 return;
 }
 }
 if(class2==0&&class3==1)
 {
 if(op2->tab->class==10&&op3->tab->class==10)
 {
 outs("movsd ");
 op_out_mem(op2);
 outs(",%xmm0\nmovq ");
 op_out_reg(8,op3);
 outs(",%xmm1\n");
 outs(ins);
 outs("%xmm1,%xmm0\n");
 if(class1==0)
 {
 outs("movsd %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movq %xmm0,");
 op_out_reg(8,op1);
 }
 outs("\n");
 return;
 }
 }
 if(class2==1&&class3==0)
 {
 if(op2->tab->class==10&&op3->tab->class==10)
 {
 outs("movq ");
 op_out_reg(8,op2);
 outs(",%xmm0\n");
 outs(ins);
 op_out_mem(op3);
 outs(",%xmm0\n");
 if(class1==0)
 {
 outs("movsd %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movq %xmm0,");
 op_out_reg(8,op1);
 }
 outs("\n");
 return;
 }
 }
 if(class2==0&&class3==0)
 {
 if(op2->tab->class==10&&op3->tab->class==10)
 {
 outs("movsd ");
 op_out_mem(op2);
 outs(",%xmm0\n");
 outs(ins);
 op_out_mem(op3);
 outs(",%xmm0\n");
 if(class1==0)
 {
 outs("movsd %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movq %xmm0,");
 op_out_reg(8,op1);
 }
 outs("\n");
 return;
 }
 }
 if(class2==3)
 {
 outs("lea ");
 op_out_mem(op2);
 outs(",%rax\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(op2);
 outs(",");
 out_rax(op2->tab->class);
 outs("\n");
 acd_extend(0,op1->tab->class,op2->tab->class);
 }
 else if(class2==1)
 {
 outs("mov ");
 op_out_reg(8,op2);
 outs(",%rax\n");
 acd_extend(0,op1->tab->class,op2->tab->class);
 }
 else
 {
 outs("mov ");
 op_out_const(10,op2);
 outs(",%rax\n");
 }
 if(class3==3)
 {
 outs("lea ");
 op_out_mem(op3);
 outs(",%rcx\n");
 }
 else if(class3==0)
 {
 outs("mov ");
 op_out_mem(op3);
 outs(",");
 out_rcx(op3->tab->class);
 outs("\n");
 acd_extend(1,op1->tab->class,op3->tab->class);
 }
 else if(class3==1)
 {
 outs("mov ");
 op_out_reg(8,op3);
 outs(",%rcx\n");
 acd_extend(1,op1->tab->class,op3->tab->class);
 }
 else
 {
 outs("mov $");
 op_out_const(10,op3);
 outs(",%rax\n");
 }
 outs("movq %rax,%xmm0\n");
 outs("movq %rcx,%xmm1\n");
 outs(ins);
 outs("%xmm1,%xmm0\n");
 if(class1==0)
 {
 outs("movsd %xmm0,");
 op_out_mem(op1);
 }
 else
 {
 outs("movq %xmm0,");
 op_out_reg(8,op1);
 }
 outs("\n");
}
void gen_basic_op(struct ins *ins,char *op)
{
 struct operand op1,op2,op3;
 int class1,class2,class3;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 class3=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(op_is_reg(&op3))
 {
 class3=1;
 }
 else if(op_is_const(&op3))
 {
 class3=2;
 }
 else if(op_is_addr(&op3))
 {
 class3=3;
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(op1.tab->class==10&&(!strcmp(op,"add")||!strcmp(op,"sub")))
 {
 if(!strcmp(op,"add"))
 {
 gen_float_basic_op(class1,class2,class3,&op1,&op2,&op3,"addsd ");
 }
 else
 {
 gen_float_basic_op(class1,class2,class3,&op1,&op2,&op3,"subsd ");
 }
 return;
 }
 if(op1.tab->class==9&&(!strcmp(op,"add")||!strcmp(op,"sub")))
 {
 if(!strcmp(op,"add"))
 {
 gen_hfloat_basic_op(class1,class2,class3,&op1,&op2,&op3,"addss ");
 }
 else
 {
 gen_hfloat_basic_op(class1,class2,class3,&op1,&op2,&op3,"subss ");
 }
 return;
 }
 if(class1==0)
 {
 if(!opcmp(&op1,&op2))
 {
 if(class3==1)
 {
 out_ins(op,0,0,&op3,&op1,0,op1.tab->class);
 return;
 }
 if(class3==2&&op3.type==2&&(op1.tab->class<7||op3.value<0x7fffffff||op3.value>0xffffffff80000000))
 {
 if(op3.value==0&&strcmp(op,"and"))
 {
 return;
 }
 else
 {
 out_ins(op,get_len(op1.tab->class),0,&op3,&op1,0,op1.tab->class);
 return;
 }
 }
 }
 else if(class2==0)
 {
 if(class3==1)
 {
 out_ins_acd1("mov",0,0,&op2,0,op1.tab->class);
 out_ins_acd1(op,0,0,&op3,0,op1.tab->class);
 out_ins_acd2("mov",0,0,0,&op1,op1.tab->class);
 return;
 }
 else if(class3==2&&op3.type==2&&(op1.tab->class<7||op3.value<0x7fffffff||op3.value>0xffffffff80000000))
 {
 out_ins_acd1("mov",0,0,&op2,0,op1.tab->class);
 out_ins_acd1(op,0,0,&op3,0,op1.tab->class);
 out_ins_acd2("mov",0,0,0,&op1,op1.tab->class);
 return;
 }
 }
 else if(class2==1)
 {
 if(class3==1)
 {
 out_ins_acd1("mov",0,0,&op2,0,op1.tab->class);
 out_ins_acd1(op,0,0,&op3,0,op1.tab->class);
 out_ins_acd2("mov",0,0,0,&op1,op1.tab->class);
 return;
 }
 else if(class3==2&&op3.type==2&&(op1.tab->class<7||op3.value<0x7fffffff||op3.value>0xffffffff80000000))
 {
 out_ins_acd1("mov",0,0,&op2,0,op1.tab->class);
 out_ins_acd1(op,0,0,&op3,0,op1.tab->class);
 out_ins_acd2("mov",0,0,0,&op1,op1.tab->class);
 return;
 }
 }
 }
 if(class1==1)
 {
 if(class2==1)
 {
 if(class3==1)
 {
 if(!opcmp(&op1,&op2))
 {
 out_ins(op,0,0,&op3,&op1,0,op1.tab->class);
 return;
 }
 else if(!opcmp(&op1,&op3))
 {
 out_ins_acd1("mov",0,0,&op2,0,op1.tab->class);
 out_ins_acd1(op,0,0,&op3,0,op1.tab->class);
 out_ins_acd2("mov",0,0,0,&op1,op1.tab->class);
 return;
 }
 else
 {
 if(!strcmp(op,"add"))
 {
 reg_extend(5,op2.tab->class,&op2);
 reg_extend(5,op3.tab->class,&op3);
 outs("lea (");
 op_out_reg(8,&op2);
 outs(",");
 op_out_reg(8,&op3);
 outs("),");
 if(op1.tab->class<5)
 {
 op_out_reg(5,&op1);
 outs("\n");
 }
 else
 {
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 return;
 }
 out_ins("mov",0,0,&op2,&op1,0,op1.tab->class);
 out_ins(op,0,0,&op3,&op1,0,op1.tab->class);
 return;
 }
 }
 else if(class3==2&&op3.type==2)
 {
 if(op1.tab->class<7||op3.value<0x7fffffff||op3.value>0xffffffff80000000)
 {
 if(op3.value==0&&strcmp(op,"and"))
 {
 if(opcmp(&op1,&op2))
 {
 out_ins("mov",0,0,&op2,&op1,0,op1.tab->class);
 }
 return;
 }
 else if(!opcmp(&op1,&op2))
 {
 out_ins(op,0,0,&op3,&op1,0,op1.tab->class);
 return;
 }
 else
 {
 out_ins("mov",0,0,&op2,&op1,0,op1.tab->class);
 out_ins(op,0,0,&op3,&op1,0,op1.tab->class);
 return;
 }
 }
 }
 }
 else if(class2==3)
 {
 if(class3==2&&op3.type==2)
 {
 if(op3.value<0x7fffffff||op3.value>0xffffffff80000000)
 {
 out_ins("lea",0,0,&op2,&op1,0,8);
 out_ins(op,0,0,&op3,&op1,0,8);
 return;
 }
 }
 else if(class3==1)
 {
 if(opcmp(&op1,&op3))
 {
 out_ins("lea",0,0,&op2,&op1,0,8);
 out_ins(op,0,0,&op3,&op1,0,8);
 return;
 }
 }
 }
 else if(class2==0&&!needs_convert(&op2,&op1))
 {
 if(class3==2&&op3.type==2)
 {
 if(op3.value<0x7fffffff||op3.value>0xffffffff80000000)
 {
 out_ins("mov",0,0,&op2,&op1,0,op1.tab->class);
 out_ins(op,0,0,&op3,&op1,0,op1.tab->class);
 return;
 }
 }
 else if(class3==1&&opcmp(&op1,&op3))
 {
 out_ins("mov",0,0,&op2,&op1,0,op1.tab->class);
 out_ins(op,0,0,&op3,&op1,0,op1.tab->class);
 return;
 }
 }
 }
 if(class2==3)
 {
 out_ins_acd1("lea",0,0,&op2,0,8);
 }
 else
 {
 out_ins_acd1("mov",0,0,&op2,0,op1.tab->class);
 }
 if(class3==3)
 {
 out_ins_acd1("lea",0,0,&op3,1,8);
 }
 else
 {
 out_ins_acd1("mov",0,0,&op3,1,op1.tab->class);
 }
 out_ins_acd3(op,0,0,1,0,op1.tab->class);
 out_ins_acd2("mov",0,0,0,&op1,op1.tab->class);
}
void gen_mul(struct ins *ins)
{
 struct operand op1,op2,op3;
 int class1,class2,class3;
 int sign;
 unsigned long int x,n;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 class3=0;
 sign=1;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 else if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 if(op_is_reg(&op3))
 {
 if(!if_class_signed(op3.tab->class))
 {
 sign=0;
 }
 class3=1;
 }
 else if(op_is_const(&op3))
 {
 class3=2;
 }
 else if(op_is_addr(&op3))
 {
 class3=3;
 }
 else if(!if_class_signed(op3.tab->class))
 {
 sign=0;
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(op1.tab->class==10)
 {
 gen_float_basic_op(class1,class2,class3,&op1,&op2,&op3,"mulsd ");
 return;
 }
 if(op1.tab->class==9)
 {
 gen_hfloat_basic_op(class1,class2,class3,&op1,&op2,&op3,"mulss ");
 return;
 }
 if(class3==2&&op3.type==2)
 {
 if(class1==1&&class2==1)
 {
 n=2;
 x=1;
 if(op3.value==0)
 {
 out_ins("xor",0,0,&op1,&op1,0,op1.tab->class);
 return;
 }
 else if(op3.value==1)
 {
 if(opcmp(&op1,&op2))
 {
 out_ins("mov",0,0,&op2,&op1,0,op1.tab->class);
 }
 return;
 }
 else if(!opcmp(&op1,&op2))
 {
 while(x<64)
 {
 if(n==op3.value)
 {
 outs("shl $");
 out_num8(x);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 return;
 }
 n=n<<1;
 ++x;
 }
 }
 else
 {
 out_ins("mov",0,0,&op2,&op1,0,op1.tab->class);
 while(x<64)
 {
 if(n==op3.value)
 {
 outs("shl $");
 out_num8(x);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 return;
 }
 n=n<<1;
 ++x;
 }
 }
 }
 }
 if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 if(class3==1)
 {
 outs("mov ");
 op_out_reg(op3.tab->class,&op3);
 outs(",");
 out_rcx(op3.tab->class);
 outs("\n");
 acd_extend(1,op1.tab->class,op3.tab->class);
 }
 else if(class3==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op3);
 outs(",");
 out_rcx(op1.tab->class);
 outs("\n");
 }
 else if(class3==0)
 {
 outs("mov ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(op3.tab->class);
 outs("\n");
 acd_extend(1,op1.tab->class,op3.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(8);
 outs("\n");
 }
 if(sign)
 {
 outs("i");
 }
 outs("mul ");
 out_rcx(op1.tab->class);
 outs("\n");
 
 if(class1==1)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class1==0)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
}
void gen_div(struct ins *ins)
{
 struct operand op1,op2,op3;
 int class1,class2,class3;
 int sign;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 class3=0;
 sign=1;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 else if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 if(op_is_reg(&op3))
 {
 if(!if_class_signed(op3.tab->class))
 {
 sign=0;
 }
 class3=1;
 }
 else if(op_is_const(&op3))
 {
 class3=2;
 }
 else if(op_is_addr(&op3))
 {
 class3=3;
 }
 else if(!if_class_signed(op3.tab->class))
 {
 sign=0;
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(op1.tab->class==10)
 {
 gen_float_basic_op(class1,class2,class3,&op1,&op2,&op3,"divsd ");
 return;
 }
 if(op1.tab->class==9)
 {
 gen_hfloat_basic_op(class1,class2,class3,&op1,&op2,&op3,"divss ");
 return;
 }
 if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 if(class3==1)
 {
 outs("mov ");
 op_out_reg(op3.tab->class,&op3);
 outs(",");
 out_rcx(op3.tab->class);
 outs("\n");
 acd_extend(1,op1.tab->class,op3.tab->class);
 }
 else if(class3==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op3);
 outs(",");
 out_rcx(op1.tab->class);
 outs("\n");
 }
 else if(class3==0)
 {
 outs("mov ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(op3.tab->class);
 outs("\n");
 acd_extend(1,op1.tab->class,op3.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(8);
 outs("\n");
 }
 if(op1.tab->class==1||op1.tab->class==2)
 {
 if(sign)
 {
 outs("mov %al,%ah\n");
 outs("shr $7,%ah");
 outs("neg %ah\n");
 }
 else
 {
 outs("xor %ah,%ah");
 }
 }
 else
 {
 if(sign)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 out_rdx(op1.tab->class);
 outs("\n");
 outs("shr $");
 if(op1.tab->class==3||op1.tab->class==4)
 {
 outs("15,");
 }
 else if(op1.tab->class==5||op1.tab->class==6)
 {
 outs("31,");
 }
 else
 {
 outs("63,");
 }
 out_rdx(op1.tab->class);
 outs("\n");
 outs("neg ");
 out_rdx(op1.tab->class);
 outs("\n");
 }
 else
 {
 outs("xor ");
 out_rdx(op1.tab->class);
 outs(",");
 out_rdx(op1.tab->class);
 outs("\n");
 }
 }
 if(sign)
 {
 outs("i");
 }
 outs("div ");
 out_rcx(op1.tab->class);
 outs("\n");
 
 if(class1==1)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class1==0)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
}
void gen_mod(struct ins *ins)
{
 struct operand op1,op2,op3;
 int class1,class2,class3;
 int sign;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 class3=0;
 sign=1;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 else if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 if(op_is_reg(&op3))
 {
 if(!if_class_signed(op3.tab->class))
 {
 sign=0;
 }
 class3=1;
 }
 else if(op_is_const(&op3))
 {
 class3=2;
 }
 else if(op_is_addr(&op3))
 {
 class3=3;
 }
 else if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 if(class3==1)
 {
 outs("mov ");
 op_out_reg(op3.tab->class,&op3);
 outs(",");
 out_rcx(op3.tab->class);
 outs("\n");
 acd_extend(1,op1.tab->class,op3.tab->class);
 }
 else if(class3==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op3);
 outs(",");
 out_rcx(op1.tab->class);
 outs("\n");
 }
 else if(class3==0)
 {
 outs("mov ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(op3.tab->class);
 outs("\n");
 acd_extend(1,op1.tab->class,op3.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(8);
 outs("\n");
 }
 if(op1.tab->class==1||op1.tab->class==2)
 {
 if(sign)
 {
 outs("mov %al,%ah\n");
 outs("shr $7,%ah");
 outs("neg %ah\n");
 }
 else
 {
 outs("xor %ah,%ah");
 }
 }
 else
 {
 if(sign)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 out_rdx(op1.tab->class);
 outs("\n");
 outs("shr $");
 if(op1.tab->class==3||op1.tab->class==4)
 {
 outs("15,");
 }
 else if(op1.tab->class==5||op1.tab->class==6)
 {
 outs("31,");
 }
 else
 {
 outs("63,");
 }
 out_rdx(op1.tab->class);
 outs("\n");
 outs("neg ");
 out_rdx(op1.tab->class);
 outs("\n");
 }
 else
 {
 outs("xor ");
 out_rdx(op1.tab->class);
 outs(",");
 out_rdx(op1.tab->class);
 outs("\n");
 }
 }
 if(sign)
 {
 outs("i");
 }
 outs("div ");
 out_rcx(op1.tab->class);
 outs("\n");
 if(op1.tab->class==1||op1.tab->class==2)
 {
 outs("mov %ah,%al\n");
 }
 else
 {
 outs("mov ");
 out_rdx(op1.tab->class);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 }
 
 if(class1==1)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class1==0)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
}
void gen_lsh(struct ins *ins)
{
 struct operand op1,op2,op3;
 int class1,class2,class3;
 int sign;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 class3=0;
 sign=1;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 else if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 if(op_is_reg(&op3))
 {
 class3=1;
 }
 else if(op_is_const(&op3))
 {
 class3=2;
 }
 else if(op_is_addr(&op3))
 {
 class3=3;
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 if(class3==1)
 {
 outs("mov ");
 op_out_reg(1,&op3);
 outs(",");
 out_rcx(1);
 outs("\n");
 }
 else if(class3==2)
 {
 outs("mov $");
 op_out_const(1,&op3);
 outs(",");
 out_rcx(1);
 outs("\n");
 }
 else if(class3==0)
 {
 outs("mov ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(1);
 outs("\n");
 }
 else
 {
 outs("lea ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(8);
 outs("\n");
 }
 outs("shl %cl,");
 out_rax(op1.tab->class);
 outs("\n");
 
 if(class1==1)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class1==0)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
}
void gen_rsh(struct ins *ins)
{
 struct operand op1,op2,op3;
 int class1,class2,class3;
 int sign;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 class3=0;
 sign=1;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 else if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 if(op_is_reg(&op3))
 {
 class3=1;
 }
 else if(op_is_const(&op3))
 {
 class3=2;
 }
 else if(op_is_addr(&op3))
 {
 class3=3;
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 if(class3==1)
 {
 outs("mov ");
 op_out_reg(1,&op3);
 outs(",");
 out_rcx(1);
 outs("\n");
 }
 else if(class3==2)
 {
 outs("mov $");
 op_out_const(1,&op3);
 outs(",");
 out_rcx(1);
 outs("\n");
 }
 else if(class3==0)
 {
 outs("mov ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(1);
 outs("\n");
 }
 else
 {
 outs("lea ");
 op_out_mem(&op3);
 outs(",");
 out_rcx(8);
 outs("\n");
 }
 if(sign)
 {
 outs("sar %cl,");
 }
 else
 {
 outs("shr %cl,");
 }
 out_rax(op1.tab->class);
 outs("\n");
 
 if(class1==1)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class1==0)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
}
void gen_branch(struct ins *ins,char *op_1,char *op_2,char *op_3,char *op_4)
{
 struct operand op1,op2;
 int class1,class2;
 int sign,c;
 c=0;
 if(ins->count_args<4)
 {
 error(ins->line,"too few arguments.");
 }
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 class1=0;
 class2=0;
 sign=1;
 if(op_is_reg(&op1))
 {
 if(!if_class_signed(op1.tab->class))
 {
 sign=0;
 }
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 c=8;
 }
 else if(!if_class_signed(op1.tab->class))
 {
 sign=0;
 }
 if(op_is_reg(&op2))
 {
 if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 c=8;
 }
 else if(!if_class_signed(op2.tab->class))
 {
 sign=0;
 }
 if(class1==0||class1==1)
 {
 if(class2==0||class2==1)
 {
 if(op1.tab->class>op2.tab->class)
 {
 c=op1.tab->class;
 }
 else
 {
 c=op2.tab->class;
 }
 }
 else
 {
 c=op1.tab->class;
 }
 }
 else
 {
 if(class2==0||class2==1)
 {
 c=op2.tab->class;
 }
 else
 {
 c=8;
 }
 }
 if(c==9||c==10)
 {
 sign=0;
 }
 if(class1==1)
 {
 outs("mov ");
 op_out_reg(op1.tab->class,&op1);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 acd_extend(0,c,op1.tab->class);
 }
 else if(class1==2)
 {
 outs("mov $");
 op_out_const(c,&op1);
 outs(",");
 out_rax(c);
 outs("\n");
 }
 else if(class1==0)
 {
 outs("mov ");
 op_out_mem(&op1);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 acd_extend(0,c,op1.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op1);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rcx(op2.tab->class);
 outs("\n");
 acd_extend(1,c,op2.tab->class);
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(c,&op2);
 outs(",");
 out_rcx(c);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rcx(op2.tab->class);
 outs("\n");
 acd_extend(1,c,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rcx(8);
 outs("\n");
 }
 if(c==10)
 {
 outs("movq %rax,%xmm0\n");
 outs("movq %rcx,%xmm1\n");
 outs("comisd ");
 outs("%xmm1,%xmm0\n");
 }
 else if(c==9)
 {
 outs("movd %eax,%xmm0\n");
 outs("movd %ecx,%xmm1\n");
 outs("comiss ");
 outs("%xmm1,%xmm0\n");
 }
 else
 {
 outs("cmp ");
 out_rcx(c);
 outs(",");
 out_rax(c);
 outs("\n");
 }
 if(sign)
 {
 outs(op_1);
 }
 else
 {
 outs(op_2);
 }
 outs(" @_$LB");
 outs(ins->args[3]);
 outs("\n");
 last_store_valid=0;
}
void gen_ld(struct ins *ins,int c)
{
 struct operand op1,op2;
 int class1,class2;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 class1=0;
 class2=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(class1==1)
 {
 if(class2==1)
 {
 reg_extend(8,op2.tab->class,&op2);
 outs("mov (");
 op_out_reg(8,&op2);
 outs("),");
 op_out_reg(c,&op1);
 outs("\n");
 reg_extend(op1.tab->class,c,&op1);
 }
 else if(class2==3)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 op_out_reg(c,&op1);
 outs("\n");
 reg_extend(op1.tab->class,c,&op1);
 }
 else
 {
 if(class2==2)
 {
 outs("mov $");
 op_out_const(8,&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,8,op2.tab->class);
 }
 outs("mov (%rax),");
 op_out_reg(c,&op1);
 outs("\n");
 reg_extend(op1.tab->class,c,&op1);
 }
 }
 else if(class1==0)
 {
 if(class2==1)
 {
 reg_extend(8,op2.tab->class,&op2);
 outs("mov (");
 op_out_reg(8,&op2);
 outs("),");
 out_rax(c);
 outs("\n");
 
 acd_extend(0,op1.tab->class,c);
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else if(class2==3)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(c);
 outs("\n");
 
 acd_extend(0,op1.tab->class,c);
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else
 {
 if(class2==2)
 {
 outs("mov $");
 op_out_const(8,&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,8,op2.tab->class);
 }
 outs("mov (%rax),");
 out_rax(c);
 outs("\n");
 acd_extend(0,op1.tab->class,c);
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 }
}
void gen_ldo(struct ins *ins,int c)
{
 struct operand op1,op2,op3;
 int class1,class2;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(op3.type!=2)
 {
 error(ins->line,"invalid op.");
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(class1==1)
 {
 if(class2==1)
 {
 reg_extend(8,op2.tab->class,&op2);
 outs("mov ");
 op_out_const(8,&op3);
 outs("(");
 op_out_reg(8,&op2);
 outs("),");
 op_out_reg(c,&op1);
 outs("\n");
 reg_extend(op1.tab->class,c,&op1);
 }
 else if(class2==3)
 {
 outs("mov ");
 op_out_mem_off(&op2,&op3);
 outs(",");
 op_out_reg(c,&op1);
 outs("\n");
 reg_extend(op1.tab->class,c,&op1);
 }
 else
 {
 if(class2==2)
 {
 outs("mov $");
 op_out_const(8,&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,8,op2.tab->class);
 }
 outs("mov ");
 op_out_const(8,&op3);
 outs("(%rax),");
 op_out_reg(c,&op1);
 outs("\n");
 reg_extend(op1.tab->class,c,&op1);
 }
 }
 else if(class1==0)
 {
 if(class2==1)
 {
 reg_extend(8,op2.tab->class,&op2);
 outs("mov ");
 op_out_const(8,&op3);
 outs("(");
 op_out_reg(8,&op2);
 outs("),");
 out_rax(c);
 outs("\n");
 
 acd_extend(0,op1.tab->class,c);
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else if(class2==3)
 {
 outs("mov ");
 op_out_mem_off(&op2,&op3);
 outs(",");
 out_rax(c);
 outs("\n");
 
 acd_extend(0,op1.tab->class,c);
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else
 {
 if(class2==2)
 {
 outs("mov $");
 op_out_const(8,&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,8,op2.tab->class);
 }
 outs("mov ");
 op_out_const(8,&op3);
 outs("(%rax),");
 out_rax(c);
 outs("\n");
 acd_extend(0,op1.tab->class,c);
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 }
}
void gen_st(struct ins *ins,int c)
{
 struct operand op1,op2;
 int class1,class2;
 int op2_pos;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 class1=0;
 class2=0;
 op2_pos=1;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 op2_pos=0;
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(class2==1)
 {
 reg_extend(c,op2.tab->class,&op2);
 }
 else if(class2==2)
 {
 if(class1==1&&op2.type==2&&(c<7||op2.value<=0x7fffffff||op2.value>=0xffffffff80000000))
 {
 outs("mov");
 outs(get_len(c));
 outs(" $");
 op_out_const(c,&op2);
 outs(",(");
 op_out_reg(8,&op1);
 outs(")\n");
 last_store_valid=0;
 return;
 }
 outs("mov $");
 op_out_const(c,&op2);
 outs(",");
 out_rax(c);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,c,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 if(class1==1)
 {
 reg_extend(8,op1.tab->class,&op1);
 outs("mov ");
 if(op2_pos)
 {
 out_rax(c);
 }
 else
 {
 op_out_reg(c,&op2);
 }
 outs(",(");
 op_out_reg(8,&op1);
 outs(")\n");
 }
 else if(class1==3)
 {
 outs("mov ");
 if(op2_pos)
 {
 out_rax(c);
 }
 else
 {
 op_out_reg(c,&op2);
 }
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else 
 {
 if(class1==0)
 {
 outs("mov ");
 op_out_mem(&op1);
 outs(",");
 out_rcx(op1.tab->class);
 outs("\n");
 acd_extend(1,8,op1.tab->class);
 }
 else if(class1==2)
 {
 outs("mov $");
 op_out_const(8,&op1);
 outs(",");
 out_rcx(8);
 outs("\n");
 }
 outs("mov ");
 if(op2_pos)
 {
 out_rax(c);
 }
 else
 {
 op_out_reg(c,&op2);
 }
 outs(",(%rcx)\n");
 }
 last_store_valid=0;
}
void gen_sto(struct ins *ins,int c)
{
 struct operand op1,op2,op3;
 int class1,class2;
 int op2_pos;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 op2_pos=1;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 op2_pos=0;
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(op3.type!=2)
 {
 error(ins->line,"invalid op.");
 }
 if(class2==1)
 {
 reg_extend(c,op2.tab->class,&op2);
 }
 else if(class2==2)
 {
 if(class1==1&&op2.type==2&&(c<7||op2.value<=0x7fffffff||op2.value>=0xffffffff80000000))
 {
 outs("mov");
 outs(get_len(c));
 outs(" $");
 op_out_const(c,&op2);
 outs(",");
 op_out_const(8,&op3);
 outs("(");
 op_out_reg(8,&op1);
 outs(")\n");
 last_store_valid=0;
 return;
 }
 outs("mov $");
 op_out_const(c,&op2);
 outs(",");
 out_rax(c);
 outs("\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,c,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 if(class1==1)
 {
 reg_extend(8,op1.tab->class,&op1);
 outs("mov ");
 if(op2_pos)
 {
 out_rax(c);
 }
 else
 {
 op_out_reg(c,&op2);
 }
 outs(",");
 op_out_const(8,&op3);
 outs("(");
 op_out_reg(8,&op1);
 outs(")\n");
 }
 else if(class1==3)
 {
 outs("mov ");
 if(op2_pos)
 {
 out_rax(c);
 }
 else
 {
 op_out_reg(c,&op2);
 }
 outs(",");
 op_out_mem_off(&op1,&op3);
 outs("\n");
 }
 else 
 {
 if(class1==0)
 {
 outs("mov ");
 op_out_mem(&op1);
 outs(",");
 out_rcx(op1.tab->class);
 outs("\n");
 acd_extend(1,8,op1.tab->class);
 }
 else if(class1==2)
 {
 outs("mov $");
 op_out_const(8,&op1);
 outs(",");
 out_rcx(8);
 outs("\n");
 }
 outs("mov ");
 if(op2_pos)
 {
 out_rax(c);
 }
 else
 {
 op_out_reg(c,&op2);
 }
 outs(",");
 op_out_const(8,&op3);
 outs("(%rcx)\n");
 }
 last_store_valid=0;
}
void gen_push(struct ins *ins,int c)
{
 struct operand op1;
 int class1;
 get_operand(ins,1,&op1);
 class1=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(class1==2&&op1.type==2&&(op1.value<=0x7fffffff||op1.value>=0xffffffff80000000))
 {
 outs("pushq $");
 op_out_const(8,&op1);
 outs("\n");
 return;
 }
 if(class1==1)
 {
 if(c<=8&&op1.tab->class<=8||c==op1.tab->class)
 {
 reg_extend(c,op1.tab->class,&op1);
 outs("push ");
 op_out_reg(7,&op1);
 outs("\n");
 }
 else
 {
 outs("mov ");
 op_out_reg(7,&op1);
 outs(",%rax\n");
 acd_extend(0,c,op1.tab->class);
 outs("push %rax\n");
 }
 }
 else
 {
 if(class1==2)
 {
 outs("mov $");
 op_out_const(c,&op1);
 outs(",%rax\n");
 }
 else if(class1==0)
 {
 outs("mov ");
 op_out_mem(&op1);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 acd_extend(0,c,op1.tab->class);
 }
 else if(class1==3)
 {
 outs("lea ");
 op_out_mem(&op1);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 outs("push %rax\n");
 }
}
void gen_call(struct ins *ins,int if_float)
{
 struct operand op1,op2;
 int class1,class2;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 class1=0;
 class2=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(class1==2||class1==3)
 {
 error(ins->line,"invalid op.");
 }
 if(class2==2)
 {
 outs("call ");
 op_out_const(8,&op2);
 outs("\n");
 }
 else if(class2==1)
 {
 reg_extend(8,op2.tab->class,&op2);
 outs("call *");
 op_out_reg(8,&op2);
 outs("\n");
 }
 else
 {
 if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,8,op2.tab->class);
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 outs("call *%rax\n");
 }
 last_store_valid=0;
 if(op1.tab->unused)
 {
 return;
 }
 if(if_float==1)
 {
 acd_extend(0,op1.tab->class,9);
 }
 else if(if_float==2)
 {
 acd_extend(0,op1.tab->class,10);
 }
 else
 {
 acd_extend(0,op1.tab->class,8);
 }
 if(class1==1)
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else
 {
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
}
void gen_retval(struct ins *ins,int c)
{
 struct operand op1;
 int class1;
 struct ins *p;
 get_operand(ins,1,&op1);
 class1=0;
 if(fun_name==0)
 {
 error(ins->line,"ret outside of function.");
 }
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(class1==1)
 {
 reg_extend(c,op1.tab->class,&op1);
 outs("mov ");
 op_out_reg(7,&op1);
 outs(",%rax\n");
 }
 else
 {
 if(class1==2)
 {
 outs("mov $");
 op_out_const(c,&op1);
 outs(",%rax\n");
 }
 else if(class1==0)
 {
 outs("mov ");
 op_out_mem(&op1);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 acd_extend(0,c,op1.tab->class);
 }
 else if(class1==3)
 {
 outs("lea ");
 op_out_mem(&op1);
 outs(",");
 out_rax(8);
 outs("\n");
 }
 }
 p=ins->next;
 while(p)
 {
 if(p->op)
 {
 outs("jmp ");
 outs("@");
 outs(fun_name);
 outs("$END\n");
 break;
 }
 if(p->count_args&&!strcmp(p->args[0],"endf"))
 {
 break;
 }
 p=p->next;
 }
}
 
void gen_not(struct ins *ins)
{
 struct operand op1,op2;
 int class1,class2;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 class1=0;
 class2=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(class1==1)
 {
 if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 outs("not ");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class2==1)
 {
 reg_extend(op1.tab->class,op2.tab->class,&op2);
 outs("mov ");
 op_out_reg(op1.tab->class,&op2);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 outs("not ");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 outs("not ");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 op_out_reg(8,&op1);
 outs("\n");
 outs("not ");
 op_out_reg(8,&op1);
 outs("\n");
 }
 }
 else if(class1==0)
 {
 if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 outs("not ");
 out_rax(op1.tab->class);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else if(class2==1)
 {
 reg_extend(op1.tab->class,op2.tab->class,&op2);
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 outs("not ");
 out_rax(op1.tab->class);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 outs("not ");
 out_rax(op1.tab->class);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 outs("not ");
 out_rax(8);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 }
 else
 {
 error(ins->line,"invalid op.");
 }
}
 
void gen_neg(struct ins *ins)
{
 struct operand op1,op2;
 int class1,class2;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 class1=0;
 class2=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if((class1==0||class1==1)&&op1.tab->class==9)
 { 
 if(class2==3)
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",%ecx\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rcx(op2.tab->class);
 outs("\n");
 acd_extend(1,op1.tab->class,op2.tab->class);
 }
 else if(class2==1)
 {
 outs("mov ");
 op_out_reg(8,&op2);
 outs(",%rcx\n");
 acd_extend(1,op1.tab->class,op2.tab->class);
 }
 else
 {
 outs("mov ");
 op_out_const(9,&op2);
 outs(",%ecx\n");
 }
 outs("btc $31,%ecx\n");
 outs("mov %ecx,");
 if(class1==0)
 {
 op_out_mem(&op1);
 }
 else
 {
 op_out_reg(6,&op1);
 }
 outs("\n");
 return;
 }
 else if((class1==0||class1==1)&&op1.tab->class==10)
 { 
 if(class2==3)
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",%rcx\n");
 }
 else if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rcx(op2.tab->class);
 outs("\n");
 acd_extend(1,op1.tab->class,op2.tab->class);
 }
 else if(class2==1)
 {
 outs("mov ");
 op_out_reg(8,&op2);
 outs(",%rcx\n");
 acd_extend(1,op1.tab->class,op2.tab->class);
 }
 else
 {
 outs("mov ");
 op_out_const(10,&op2);
 outs(",%rcx\n");
 }
 outs("btc $63,%rcx\n");
 outs("mov %rcx,");
 if(class1==0)
 {
 op_out_mem(&op1);
 }
 else
 {
 op_out_reg(8,&op1);
 }
 outs("\n");
 return;
 }
 if(class1==1)
 {
 if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 outs("neg ");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class2==1)
 {
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 op_out_reg(op2.tab->class,&op1);
 outs("\n");
 reg_extend(op1.tab->class,op2.tab->class,&op1);
 outs("neg ");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 outs("neg ");
 op_out_reg(op1.tab->class,&op1);
 outs("\n");
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 op_out_reg(8,&op1);
 outs("\n");
 outs("neg ");
 op_out_reg(8,&op1);
 outs("\n");
 }
 }
 else if(class1==0)
 {
 if(class2==0)
 {
 outs("mov ");
 op_out_mem(&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 outs("neg ");
 out_rax(op1.tab->class);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else if(class2==1)
 {
 reg_extend(op1.tab->class,op2.tab->class,&op2);
 outs("mov ");
 op_out_reg(op2.tab->class,&op2);
 outs(",");
 out_rax(op2.tab->class);
 outs("\n");
 acd_extend(0,op1.tab->class,op2.tab->class);
 outs("neg ");
 out_rax(op1.tab->class);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else if(class2==2)
 {
 outs("mov $");
 op_out_const(op1.tab->class,&op2);
 outs(",");
 out_rax(op1.tab->class);
 outs("\n");
 outs("neg ");
 out_rax(op1.tab->class);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 outs("neg ");
 out_rax(8);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 }
 else
 {
 error(ins->line,"invalid op.");
 }
}
 
void gen_adr(struct ins *ins)
{
 struct operand op1,op2;
 int class1,class2;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 class1=0;
 class2=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(class2==1||class2==2)
 {
 error(ins->line,"invalid op.");
 }
 if(class1==1)
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 op_out_reg(8,&op1);
 outs("\n");
 }
 else if(class1==0)
 {
 outs("lea ");
 op_out_mem(&op2);
 outs(",");
 out_rax(8);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else
 {
 error(ins->line,"invalid op.");
 }
}
void gen_adro(struct ins *ins)
{
 struct operand op1,op2,op3;
 int class1,class2;
 get_operand(ins,1,&op1);
 get_operand(ins,2,&op2);
 get_operand(ins,3,&op3);
 class1=0;
 class2=0;
 if(op_is_reg(&op1))
 {
 class1=1;
 }
 else if(op_is_const(&op1))
 {
 class1=2;
 }
 else if(op_is_addr(&op1))
 {
 class1=3;
 }
 if(op_is_reg(&op2))
 {
 class2=1;
 }
 else if(op_is_const(&op2))
 {
 class2=2;
 }
 else if(op_is_addr(&op2))
 {
 class2=3;
 }
 if(class2==1||class2==2||op3.type!=2)
 {
 error(ins->line,"invalid op.");
 }
 if(class1==1)
 {
 outs("lea ");
 op_out_mem_off(&op2,&op3);
 outs(",");
 op_out_reg(8,&op1);
 outs("\n");
 }
 else if(class1==0)
 {
 outs("lea ");
 op_out_mem_off(&op2,&op3);
 outs(",");
 out_rax(8);
 outs("\n");
 outs("mov ");
 out_rax(op1.tab->class);
 outs(",");
 op_out_mem(&op1);
 outs("\n");
 }
 else
 {
 error(ins->line,"invalid op.");
 }
}
void write_msg(void)
{
 struct ins *ins;
 int x;
 long int num;
 char *name;
 num=1;
 ins=ins_head;
 while(ins)
 {
 x=1;
 while(x<ins->count_args)
 {
 if(ins->args[x][0]=='\"'&&strcmp(ins->args[0],"asm"))
 {
 
 name=scc__xstrdup("_$MSG");
 name=scc__str_i_app(name,num);
 outs("@");
 outs(name);
 outs("\n");
 outs(".string ");
 outs(ins->args[x]);
 outs("\n");
 free(ins->args[x]);
 ins->args[x]=name;
 ++num;
 }
 ++x;
 }
 ins=ins->next;
 }
}
void gen_code(struct ins *ins)
{
 unsigned long int size;
 int x;
 int in_asm;
 if(ins->count_args)
 {
 if(!strcmp(ins->args[0],"mov"))
 {
 gen_mov(ins);
 }
 else if(!strcmp(ins->args[0],"add"))
 {
 gen_basic_op(ins,"add");
 }
 else if(!strcmp(ins->args[0],"sub"))
 {
 gen_basic_op(ins,"sub");
 }
 else if(!strcmp(ins->args[0],"and"))
 {
 gen_basic_op(ins,"and");
 }
 else if(!strcmp(ins->args[0],"orr"))
 {
 gen_basic_op(ins,"or");
 }
 else if(!strcmp(ins->args[0],"eor"))
 {
 gen_basic_op(ins,"xor");
 }
 else if(!strcmp(ins->args[0],"mul"))
 {
 gen_mul(ins);
 }
 else if(!strcmp(ins->args[0],"div"))
 {
 gen_div(ins);
 }
 else if(!strcmp(ins->args[0],"mod"))
 {
 gen_mod(ins);
 }
 else if(!strcmp(ins->args[0],"lsh"))
 {
 gen_lsh(ins);
 }
 else if(!strcmp(ins->args[0],"rsh"))
 {
 gen_rsh(ins);
 }
 else if(!strcmp(ins->args[0],"ble"))
 {
 gen_branch(ins,"jle","jbe","jg","ja");
 }
 else if(!strcmp(ins->args[0],"bge"))
 {
 gen_branch(ins,"jge","jae","jl","jb");
 }
 else if(!strcmp(ins->args[0],"blt"))
 {
 gen_branch(ins,"jl","jb","jge","jae");
 }
 else if(!strcmp(ins->args[0],"bgt"))
 {
 gen_branch(ins,"jg","ja","jle","jbe");
 }
 else if(!strcmp(ins->args[0],"beq"))
 {
 gen_branch(ins,"je","je","jne","jne");
 }
 else if(!strcmp(ins->args[0],"bne"))
 {
 gen_branch(ins,"jne","jne","je","je");
 }
 else if(!strcmp(ins->args[0],"ldb"))
 {
 gen_ld(ins,1);
 }
 else if(!strcmp(ins->args[0],"ldw"))
 {
 gen_ld(ins,3);
 }
 else if(!strcmp(ins->args[0],"ldl"))
 {
 gen_ld(ins,5);
 }
 else if(!strcmp(ins->args[0],"ldq"))
 {
 gen_ld(ins,7);
 }
 else if(!strcmp(ins->args[0],"ldf"))
 {
 gen_ld(ins,10);
 }
 else if(!strcmp(ins->args[0],"ldh"))
 {
 gen_ld(ins,9);
 }
 else if(!strcmp(ins->args[0],"stb"))
 {
 gen_st(ins,1);
 }
 else if(!strcmp(ins->args[0],"stw"))
 {
 gen_st(ins,3);
 }
 else if(!strcmp(ins->args[0],"stl"))
 {
 gen_st(ins,5);
 }
 else if(!strcmp(ins->args[0],"stq"))
 {
 gen_st(ins,7);
 }
 else if(!strcmp(ins->args[0],"stf"))
 {
 gen_st(ins,10);
 }
 else if(!strcmp(ins->args[0],"sth"))
 {
 gen_st(ins,9);
 }
 else if(!strcmp(ins->args[0],"ldob"))
 {
 gen_ldo(ins,1);
 }
 else if(!strcmp(ins->args[0],"ldow"))
 {
 gen_ldo(ins,3);
 }
 else if(!strcmp(ins->args[0],"ldol"))
 {
 gen_ldo(ins,5);
 }
 else if(!strcmp(ins->args[0],"ldoq"))
 {
 gen_ldo(ins,7);
 }
 else if(!strcmp(ins->args[0],"ldof"))
 {
 gen_ldo(ins,10);
 }
 else if(!strcmp(ins->args[0],"ldoh"))
 {
 gen_ldo(ins,9);
 }
 else if(!strcmp(ins->args[0],"stob"))
 {
 gen_sto(ins,1);
 }
 else if(!strcmp(ins->args[0],"stow"))
 {
 gen_sto(ins,3);
 }
 else if(!strcmp(ins->args[0],"stol"))
 {
 gen_sto(ins,5);
 }
 else if(!strcmp(ins->args[0],"stoq"))
 {
 gen_sto(ins,7);
 }
 else if(!strcmp(ins->args[0],"stof"))
 {
 gen_sto(ins,10);
 }
 else if(!strcmp(ins->args[0],"stoh"))
 {
 gen_sto(ins,9);
 }
 else if(!strcmp(ins->args[0],"push"))
 {
 gen_push(ins,7);
 }
 else if(!strcmp(ins->args[0],"pushh"))
 {
 gen_push(ins,9);
 }
 else if(!strcmp(ins->args[0],"pushf"))
 {
 gen_push(ins,10);
 }
 else if(!strcmp(ins->args[0],"call"))
 {
 gen_call(ins,0);
 }
 else if(!strcmp(ins->args[0],"hcall"))
 {
 gen_call(ins,1);
 }
 else if(!strcmp(ins->args[0],"fcall"))
 {
 gen_call(ins,2);
 }
 else if(!strcmp(ins->args[0],"retval"))
 {
 gen_retval(ins,7);
 }
 else if(!strcmp(ins->args[0],"retvalh"))
 {
 gen_retval(ins,9);
 }
 else if(!strcmp(ins->args[0],"retvalf"))
 {
 gen_retval(ins,10);
 }
 else if(!strcmp(ins->args[0],"not"))
 {
 gen_not(ins);
 }
 else if(!strcmp(ins->args[0],"neg"))
 {
 gen_neg(ins);
 }
 else if(!strcmp(ins->args[0],"adr"))
 {
 gen_adr(ins);
 }
 else if(!strcmp(ins->args[0],"adro"))
 {
 gen_adro(ins);
 }
 else if(!strcmp(ins->args[0],"del"))
 {
 if(ins->count_args<2)
 {
 error(ins->line,"too few arguments.");
 }
 size=const_to_num(ins->args[1]);
 if(size)
 {
 outs("add $");
 out_num64(size*8);
 outs(",%rsp\n");
 }
 }
 else if(!strcmp(ins->args[0],"fun"))
 {
 if(ins->count_args<2)
 {
 error(ins->line,"too few arguments.");
 }
 fstart=ins;
 fun_name=ins->args[1];
 fun_stack_size=ins->stack_size;
 out_label(fun_name);
 outs("push %rbp\n");
 outs("mov %rsp,%rbp\n");
 if(ins->stack_size)
 {
 outs("sub $");
 out_num64(-ins->stack_size);
 outs(",%rsp\n");
 }
 x=0;
 while(x<11)
 {
 if(ins->used_regs&1<<x)
 {
 outs("push ");
 out_reg64(x+1);
 outs("\n");
 if(ins->arg_map[x]!=-1)
 {
 outs("mov ");
 out_num(7,ins->arg_map[x]*8+16);
 outs("(%rbp),");
 out_reg64(x+1);
 outs("\n");
 }
 }
 ++x;
 }
 last_store_valid=0;
 }
 else if(!strcmp(ins->args[0],"endf"))
 {
 if(fun_name)
 {
 outs("@");
 out_label_name(fun_name);
 outs("$END\n");
 x=11;
 while(x)
 {
 --x;
 if(fstart->used_regs&1<<x)
 {
 outs("pop ");
 out_reg64(x+1);
 outs("\n");
 }
 }
 outs("mov %rbp,%rsp\npop %rbp\nret\n");
 fstart=0;
 }
 else
 {
 error(ins->line,"endf without fun.");
 }
 fun_name=0;
 last_store_valid=0;
 }
 else if(!strcmp(ins->args[0],"ret"))
 {
 struct ins *p;
 p=ins->next;
 while(p)
 {
 if(p->op)
 {
 outs("jmp ");
 outs("@");
 outs(fun_name);
 outs("$END\n");
 break;
 }
 if(p->count_args&&!strcmp(p->args[0],"endf"))
 {
 break;
 }
 p=p->next;
 }
 last_store_valid=0;
 }
 else if(!strcmp(ins->args[0],"bal"))
 {
 if(ins->count_args<2)
 {
 error(ins->line,"too few arguments.");
 }
 outs("jmp @_$LB");
 outs(ins->args[1]);
 outs("\n");
 last_store_valid=0;
 }
 else if(!strcmp(ins->args[0],"label"))
 {
 if(ins->count_args<2)
 {
 error(ins->line,"too few arguments.");
 }
 outs("@_$LB");
 outs(ins->args[1]);
 outs("\n");
 last_store_valid=0;
 }
 else if(!strcmp(ins->args[0],"asm"))
 {
 if(ins->count_args<2)
 {
 error(ins->line,"too few arguments.");
 }
 out_str(ins->args[1]);
 outs("\n");
 }
 }
}
 
void bcode_run(void)
{
 char *str;
 struct ins *node;
 while(str=read_line())
 {
 ins_add(str);
 free(str);
 }
 load_global_vars();
 load_labels();
 load_branches();
 load_local_vars();
 reg_init();
 write_msg();
 node=ins_head;
 while(node)
 {
 gen_code(node);
 node=node->next;
 }
 
 outs(".datasize ");
 out_num64(data_size);
 outs("\n");
 out_flush();
}
namespace scc;
int main(int argc,char **argv)
{
 if(argc<3)
 {
 __syscall((long)(1),(long)(1),(long)("Usage: scc <input> <output>\n"),(long)(28),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 scc__fdi=__syscall((long)(2),(long)(argv[1]),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(scc__fdi<0)
 {
 __syscall((long)(1),(long)(1),(long)("Cannot open input file\n"),(long)(23),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 scc__fdo=__syscall((long)(2),(long)(argv[2]),(long)(578),(long)(0644),(long)(0),(long)(0),(long)(0));
 if(scc__fdo<0)
 {
 __syscall((long)(1),(long)(1),(long)("Cannot open output file\n"),(long)(24),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 scc_front__scc_run();
 scc_back__bcode_run();
 __syscall((long)(3),(long)(scc__fdi),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(scc__fdo),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 return 0;
}
namespace assembler;
void *xmalloc(long int size)
{
 void *ptr;
 ptr=malloc(size+16);
 if(ptr==0)
 {
 __syscall((long)(1),(long)(2),(long)("FATAL: cannot allocate memory.\n"),(long)(31),(long)(0),(long)(0),(long)(0));
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 return ptr;
}
long int __str_size(long int size)
{
 long int val;
 val=128;
 while(val<size)
 {
 val=val*3>>1;
 }
 return val;
}
char *xstrdup(char *str)
{
 long int l;
 char *new_str;
 l=strlen(str);
 new_str=xmalloc(__str_size(l+1));
 memcpy(new_str,str,l);
 new_str[l]=0;
 return new_str;
}
 
char *str_c_app(char *s,int c)
{
 char *new_str;
 long int l,l1,l2;
 if(s==0)
 {
 new_str=xmalloc(128);
 new_str[0]=c;
 new_str[1]=0;
 }
 else
 {
 l=strlen(s);
 l1=__str_size(l+1);
 l2=__str_size(l+2);
 if(l1==l2)
 {
 new_str=s;
 new_str[l]=c;
 new_str[l+1]=0;
 }
 else
 {
 new_str=xmalloc(l2);
 memcpy(new_str,s,l);
 new_str[l]=c;
 new_str[l+1]=0;
 free(s);
 }
 }
 return new_str;
}
char *str_c_app2(char *s,long off,int c)
{
 char *new_str;
 long int l,l1,l2;
 if(s==0)
 {
 new_str=xmalloc(128);
 new_str[0]=c;
 new_str[1]=0;
 }
 else
 {
 l=strlen(s+off)+off;
 l1=__str_size(l+1);
 l2=__str_size(l+2);
 if(l1==l2)
 {
 new_str=s;
 new_str[l]=c;
 new_str[l+1]=0;
 }
 else
 {
 new_str=xmalloc(l2);
 memcpy(new_str,s,l);
 new_str[l]=c;
 new_str[l+1]=0;
 free(s);
 }
 }
 return new_str;
}
char *str_s_app(char *s,char *s2)
{
 while(*s2)
 {
 s=str_c_app(s,*s2);
 s2=s2+1;
 }
 return s;
}
char *str_i_app(char *s,unsigned long int n)
{
 unsigned long int a;
 a=10000000000000000000;
 int c;
 if(n==0)
 {
 return str_c_app(s,'0');
 }
 while(a>n)
 {
 a/=10;
 }
 while(a)
 {
 c=n/a;
 n%=a;
 a/=10;
 s=str_c_app(s,c+'0');
 }
 return s;
}
int fdi,fdo,fde;
void error(int line,char *msg)
{
 char *str;
 str=xstrdup("line ");
 str=str_i_app(str,line);
 str=str_s_app(str,": error: ");
 str=str_s_app(str,msg);
 str=str_c_app(str,'\n');
 __syscall((long)(1),(long)(2),(long)(str),(long)(strlen(str)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(231),(long)(2),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
}
int name_hash(char *str)
{
 unsigned int hash;
 hash=20000;
 while(*str)
 {
 hash=(hash<<11|hash>>21)+*str;
 ++str;
 }
 return hash%1021;
}
unsigned long int pc,data_size,data_addr;
struct lines *l;
int stage;
long int current_line;
int readc(void)
{
 static unsigned char buf[65536];
 static int x,n;
 int n1,c;
 if(x==n)
 {
 n1=__syscall((long)(0),(long)(fdi),(long)(buf),(long)(65536),(long)(0),(long)(0),(long)(0));
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
char *read_line(void)
{
 char *str;
 char c;
 int x;
 x=0;
 str=0;
 while((c=readc())!=-1)
 {
 if(c=='\n')
 {
 if(str==0)
 {
 str=xstrdup(" ");
 }
 break;
 }
 str=str_c_app2(str,x,c);
 ++x;
 }
 ++current_line;
 return str;
}
struct lines
{
 char *str;
 long int line;
 unsigned long int ins_pos;
 unsigned long int prev_ins_pos;
 int needs_recompile;
 int ins_len;
 char ins_buf[48];
 char *ins_buf2;
 unsigned long int ins_off;
 unsigned long int optimize;
 struct lines *next;
} *lines_head,*lines_end;
void load_file(void)
{
 char *str;
 struct lines *node;
 while(str=read_line())
 {
 node=xmalloc(sizeof(*node));
 node->str=str;
 node->line=current_line;
 node->next=0;
 node->ins_buf2=0;
 if(lines_head)
 {
 lines_end->next=node;
 }
 else
 {
 lines_head=node;
 }
 lines_end=node;
 }
}
struct elf_header
{
 unsigned char ident[16];
 unsigned short int type;
 unsigned short int machine;
 unsigned int version;
 unsigned long int entry;
 unsigned long int phoff;
 unsigned long int shoff;
 unsigned int flags;
 unsigned short int ehsize;
 unsigned short int phentsize;
 unsigned short int phnum;
 unsigned short int shentsize;
 unsigned short int shnum;
 unsigned short int shstrndx;
} elf_header;
struct elf_program_header
{
 unsigned int type;
 unsigned int flags;
 unsigned long int offset;
 unsigned long int vaddr;
 unsigned long int paddr;
 unsigned long int filesz;
 unsigned long int memsz;
 unsigned long int align;
};
unsigned long int spos;
void swrite(void *buf,unsigned long int size)
{
 unsigned char *new_data;
 if(l->ins_len+size>48)
 {
 new_data=xmalloc(l->ins_len+size);
 if(l->ins_len<=48)
 {
 memcpy(new_data,l->ins_buf,l->ins_len);
 }
 else
 {
 memcpy(new_data,l->ins_buf2,l->ins_len);
 }
 memcpy(new_data+l->ins_len,buf,size);
 free(l->ins_buf2);
 l->ins_buf2=new_data;
 }
 else
 {
 memcpy(l->ins_buf+l->ins_len,buf,size);
 }
 l->ins_len+=size;
 spos+=size;
 pc+=size;
}
void soutc(char c)
{
 swrite(&c,1);
}
char outc_buf[65536];
int outc_x;
void outc(char c)
{
 int n;
 if(outc_x==65536)
 {
 __syscall((long)(1),(long)(fdo),(long)(outc_buf),(long)(outc_x),(long)(0),(long)(0),(long)(0));
 outc_x=0;
 }
 outc_buf[outc_x]=c;
 ++outc_x;
}
void out_flush(void)
{
 if(outc_x)
 {
 __syscall((long)(1),(long)(fdo),(long)(outc_buf),(long)(outc_x),(long)(0),(long)(0),(long)(0));
 }
}
void c_write(char *buf,int size)
{
 while(size)
 {
 outc(*buf);
 ++buf;
 --size;
 }
}
void out_addr(unsigned long int addr)
{
 int x;
 x=64;
 do
 {
 x-=4;
 __syscall((long)(1),(long)(fde),(long)("0123456789ABCDEF"+(addr>>x&0xf)),(long)(1),(long)(0),(long)(0),(long)(0));
 }
 while(x);
 __syscall((long)(1),(long)(fde),(long)(": "),(long)(2),(long)(0),(long)(0),(long)(0));
}
 
void mkelf(void)
{
 struct elf_program_header phead[2];
 unsigned long int addr,size;
 memcpy(&elf_header,"\x7f\x45\x4c\x46\x02\x01\x01",7);
 elf_header.type=2;
 elf_header.machine=0x3e;
 elf_header.version=1;
 elf_header.phoff=0x40;
 elf_header.ehsize=0x40;
 elf_header.phentsize=0x38;
 elf_header.phnum=2;
 elf_header.shentsize=0x40;
 __syscall((long)(1),(long)(fdo),(long)(&elf_header),(long)(0x40),(long)(0),(long)(0),(long)(0));
 phead[0].type=1;
 phead[0].flags=0x5;
 phead[0].offset=0;
 phead[0].vaddr=0x10000;
 phead[0].paddr=0x10000;
 phead[0].filesz=spos+0xb0;
 phead[0].memsz=spos+0xb0;
 phead[0].align=0x1000;
 phead[1].type=1;
 phead[1].flags=0x6;
 phead[1].offset=0;
 phead[1].vaddr=0x20000000;
 phead[1].paddr=0x20000000;
 phead[1].filesz=0;
 phead[1].memsz=data_size;
 phead[1].align=0x1000;
 __syscall((long)(1),(long)(fdo),(long)(phead),(long)(sizeof(phead)),(long)(0),(long)(0),(long)(0));
 l=lines_head;
 while(l)
 {
 if(l->ins_len>48)
 {
 c_write(l->ins_buf2,l->ins_len);
 }
 else
 {
 c_write(l->ins_buf,l->ins_len);
 }
 if(fde>=0)
 {
 out_addr(l->ins_pos);
 __syscall((long)(1),(long)(fde),(long)(l->str),(long)(strlen(l->str)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(fde),(long)("\n"),(long)(1),(long)(0),(long)(0),(long)(0));
 }
 l=l->next;
 }
 out_flush();
}
char *read_str(char **str,char c)
{
 char *s;
 char c1;
 int x;
 s=0;
 x=0;
 s=str_c_app(s,c);
 ++*str;
 while(c1=**str)
 {
 s=str_c_app2(s,x,c1);
 ++x;
 if(c1==c)
 {
 break;
 }
 if(c1=='\\')
 {
 ++*str;
 c1=**str;
 if(c1==0)
 {
 break;
 }
 s=str_c_app2(s,x,c1);
 ++x;
 }
 ++*str;
 }
 if(c1)
 {
 ++*str;
 }
 return s;
}
char *skip_spaces(char *str)
{
 while(*str==32||*str=='\r'||*str=='\t'||*str=='\v')
 {
 ++str;
 }
 return str;
}
int is_id(char c)
{
 if(c>='0'&&c<='9'||c>='A'&&c<='Z'||c>='a'&&c<='z'||c=='_')
 {
 return 1;
 }
 return 0;
}
int is_id2(char c)
{
 if(c>='0'&&c<='9'||c>='A'&&c<='Z'||c>='a'&&c<='z'||c=='_'||c=='$')
 {
 return 1;
 }
 return 0;
}
char *read_word(char **str)
{
 char *str1,*ret;
 int x;
 x=0;
 str1=skip_spaces(*str);
 if(*str1==0)
 {
 return 0;
 }
 ret=0;
 if(is_id(*str1))
 {
 while(is_id2(*str1))
 {
 ret=str_c_app2(ret,x,*str1);
 ++x;
 ++str1;
 }
 *str=str1;
 return ret;
 }
 else if(*str1=='\'')
 {
 *str=str1;
 return read_str(str,'\'');
 }
 else if(*str1=='\"')
 {
 *str=str1;
 return read_str(str,'\"');
 }
 ret=str_c_app(ret,*str1);
 *str=str1+1;
 return ret;
}
unsigned long int const_to_num(char *str)
{
 unsigned long int ret;
 int x;
 ret=0;
 if(str[0]=='\'')
 {
 ++str;
 if(str[0]=='\\')
 {
 if(str[1]=='\\')
 {
 ret='\\';
 }
 else if(str[1]=='n')
 {
 ret='\n';
 }
 else if(str[1]=='t')
 {
 ret='\t';
 }
 else if(str[1]=='v')
 {
 ret='\v';
 }
 else if(str[1]=='r')
 {
 ret='\r';
 }
 else if(str[1]=='\'')
 {
 ret='\'';
 }
 else if(str[1]=='\"')
 {
 ret='\"';
 }
 else if(str[1]=='\?')
 {
 ret='\?';
 }
 else if(str[1]>='0'&&str[1]<='7')
 {
 x=1;
 while(str[x]>='0'&&str[x]<='7')
 {
 ret=(ret<<3)+(str[x]-'0');
 ++x;
 }
 }
 else if(str[1]=='x')
 {
 x=2;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 ret=ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 ret=ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 }
 else
 {
 ret='\\';
 }
 }
 else
 {
 ret=str[0];
 }
 }
 else if(str[0]>='1'&&str[0]<='9')
 {
 x=0;
 while(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*10+(str[x]-'0');
 ++x;
 }
 }
 else if(str[1]=='X'||str[1]=='x')
 {
 x=2;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 ret=ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 ret=ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 ret=ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 }
 else
 {
 x=0;
 while(str[x]>='0'&&str[x]<='7')
 {
 ret=(ret<<3)+(str[x]-'0');
 ++x;
 }
 }
 return ret;
}
char *sgetc(char *str,char *ret)
{
 int x;
 if(str[0]=='\\')
 {
 if(str[1]=='\\')
 {
 *ret='\\';
 return str+2;
 }
 else if(str[1]=='n')
 {
 *ret='\n';
 return str+2;
 }
 else if(str[1]=='t')
 {
 *ret='\t';
 return str+2;
 }
 else if(str[1]=='v')
 {
 *ret='\v';
 return str+2;
 }
 else if(str[1]=='r')
 {
 *ret='\r';
 return str+2;
 }
 else if(str[1]=='\'')
 {
 *ret='\'';
 return str+2;
 }
 else if(str[1]=='\"')
 {
 *ret='\"';
 return str+2;
 }
 else if(str[1]=='\?')
 {
 *ret='\?';
 return str+2;
 }
 else if(str[1]>='0'&&str[1]<='7')
 {
 x=1;
 *ret=0;
 while(str[x]>='0'&&str[x]<='7')
 {
 *ret=(*ret<<3)+(str[x]-'0');
 ++x;
 }
 return str+x;
 }
 else if(str[1]=='x')
 {
 x=2;
 *ret=0;
 while(1)
 {
 if(str[x]>='0'&&str[x]<='9')
 {
 *ret=*ret*16+(str[x]-'0');
 }
 else if(str[x]>='A'&&str[x]<='F')
 {
 *ret=*ret*16+(str[x]-'A'+10);
 }
 else if(str[x]>='a'&&str[x]<='f')
 {
 *ret=*ret*16+(str[x]-'a'+10);
 }
 else
 {
 break;
 }
 ++x;
 }
 return str+x;
 }
 else
 {
 *ret='\\';
 return str+1;
 }
 }
 else
 {
 *ret=str[0];
 return str+1;
 }
}
int format_hash(char *format)
{
 char c;
 int brackets;
 unsigned int hash;
 brackets=0;
 hash=301;
 while(c=*format)
 {
 if(c=='(')
 {
 ++brackets;
 }
 else if(c==')')
 {
 --brackets;
 }
 else if(!brackets)
 {
 if(c=='*')
 {
 hash=hash*97+31;
 }
 else if(c==',')
 {
 hash=hash*89+19;
 }
 else if(c=='%')
 {
 hash=hash*47+173;
 }
 }
 ++format;
 }
 return hash%1021;
}
struct label
{
 char *name;
 unsigned long int value;
 struct label *next;
} *label_tab[1021];
void label_tab_add(char *name)
{
 int hash;
 struct label *label;
 hash=name_hash(name);
 label=xmalloc(sizeof(*label));
 label->name=name;
 label->value=pc;
 label->next=label_tab[hash];
 label_tab[hash]=label;
}
struct label *label_tab_find(char *name)
{
 int hash;
 struct label *label;
 hash=name_hash(name);
 label=label_tab[hash];
 while(label)
 {
 if(!strcmp(label->name,name))
 {
 return label;
 }
 label=label->next;
 }
 return 0;
}
int parse_num(char **str,unsigned long int *result)
{
 char *old_str,*word;
 int s;
 struct label *label;
 old_str=*str;
 *str=skip_spaces(*str);
 s=0;
 if(**str=='-')
 {
 ++*str;
 s=1;
 }
 if(**str=='@')
 {
 
 ++*str;
 word=read_word(str);
 if(!strcmp(word,"_$DATA"))
 {
 free(word);
 if(s)
 {
 *result=-data_addr;
 }
 else
 {
 *result=data_addr;
 }
 l->needs_recompile=1;
 return 0;
 }
 else
 {
 label=label_tab_find(word);
 if(stage)
 {
 if(label)
 {
 free(word);
 *result=label->value;
 if(s)
 {
 *result=-*result;
 }
 return 0;
 }
 error(l->line,"label undefined.");
 }
 else
 {
 l->needs_recompile=1;
 }
 }
 free(word);
 return -2;
 }
 else if(**str>='0'&&**str<='9'||**str=='\'')
 {
 *result=const_to_num(*str);
 word=read_word(str);
 free(word);
 }
 else
 {
 *str=old_str;
 return -1;
 }
 if(s)
 {
 *result=-*result;
 }
 return 0;
}
int parse_const(char **str,unsigned long int *result)
{
 unsigned long int num;
 int ret,s,s1;
 char *old_str;
 old_str=*str;
 s=0;
 s1=0;
 *result=0;
 while(1)
 {
 ret=parse_num(str,&num);
 if(ret==-1)
 {
 *str=old_str;
 return -1;
 }
 if(ret==-2)
 {
 s=1;
 }
 if(s1)
 {
 *result-=num;
 }
 else
 {
 *result+=num;
 }
 *str=skip_spaces(*str);
 if(**str=='+')
 {
 s1=0;
 ++*str;
 }
 else if(**str=='-')
 {
 s1=1;
 ++*str;
 }
 else
 {
 break;
 }
 }
 if(s)
 {
 *result=0;
 }
 return 0;
}
int str_match(char **pstr,char *str)
{
 int l;
 char *old_str;
 old_str=*pstr;
 l=strlen(str);
 *pstr=skip_spaces(*pstr);
 if(strncmp(*pstr,str,l))
 {
 *pstr=old_str;
 return 0;
 }
 *pstr+=l;
 return 1;
}
int str_match2(char **pstr,char *str,int l)
{
 char *old_str;
 old_str=*pstr;
 *pstr=skip_spaces(*pstr);
 if(strncmp(*pstr,str,l))
 {
 *pstr=old_str;
 return 0;
 }
 *pstr+=l;
 return 1;
}
int parse_reg32(char **str)
{
 if(str_match2(str,"eax",3))
 {
 return 0;
 }
 if(str_match2(str,"ecx",3))
 {
 return 1;
 }
 if(str_match2(str,"edx",3))
 {
 return 2;
 }
 if(str_match2(str,"ebx",3))
 {
 return 3;
 }
 if(str_match2(str,"esp",3))
 {
 return 4;
 }
 if(str_match2(str,"ebp",3))
 {
 return 5;
 }
 if(str_match2(str,"esi",3))
 {
 return 6;
 }
 if(str_match2(str,"edi",3))
 {
 return 7;
 }
 if(str_match2(str,"r8d",3))
 {
 return 8;
 }
 if(str_match2(str,"r9d",3))
 {
 return 9;
 }
 if(str_match2(str,"r10d",4))
 {
 return 10;
 }
 if(str_match2(str,"r11d",4))
 {
 return 11;
 }
 if(str_match2(str,"r12d",4))
 {
 return 12;
 }
 if(str_match2(str,"r13d",4))
 {
 return 13;
 }
 if(str_match2(str,"r14d",4))
 {
 return 14;
 }
 if(str_match2(str,"r15d",4))
 {
 return 15;
 }
 if(str_match2(str,"eiz",3))
 {
 return -2;
 }
 return -1;
}
int parse_reg16(char **str)
{
 if(str_match2(str,"ax",2))
 {
 return 0;
 }
 if(str_match2(str,"cx",2))
 {
 return 1;
 }
 if(str_match2(str,"dx",2))
 {
 return 2;
 }
 if(str_match2(str,"bx",2))
 {
 return 3;
 }
 if(str_match2(str,"sp",2))
 {
 return 4;
 }
 if(str_match2(str,"bp",2))
 {
 return 5;
 }
 if(str_match2(str,"si",2))
 {
 return 6;
 }
 if(str_match2(str,"di",2))
 {
 return 7;
 }
 if(str_match2(str,"r8w",3))
 {
 return 8;
 }
 if(str_match2(str,"r9w",3))
 {
 return 9;
 }
 if(str_match2(str,"r10w",4))
 {
 return 10;
 }
 if(str_match2(str,"r11w",4))
 {
 return 11;
 }
 if(str_match2(str,"r12w",4))
 {
 return 12;
 }
 if(str_match2(str,"r13w",4))
 {
 return 13;
 }
 if(str_match2(str,"r14w",4))
 {
 return 14;
 }
 if(str_match2(str,"r15w",4))
 {
 return 15;
 }
 return -1;
}
int parse_reg8(char **str)
{
 if(str_match2(str,"al",2))
 {
 return 0;
 }
 if(str_match2(str,"cl",2))
 {
 return 1;
 }
 if(str_match2(str,"dl",2))
 {
 return 2;
 }
 if(str_match2(str,"bl",2))
 {
 return 3;
 }
 if(str_match2(str,"r8b",3))
 {
 return 8;
 }
 if(str_match2(str,"r9b",3))
 {
 return 9;
 }
 if(str_match2(str,"r10b",4))
 {
 return 10;
 }
 if(str_match2(str,"r11b",4))
 {
 return 11;
 }
 if(str_match2(str,"r12b",4))
 {
 return 12;
 }
 if(str_match2(str,"r13b",4))
 {
 return 13;
 }
 if(str_match2(str,"r14b",4))
 {
 return 14;
 }
 if(str_match2(str,"r15b",4))
 {
 return 15;
 }
 if(str_match2(str,"spl",3))
 {
 return 20;
 }
 if(str_match2(str,"bpl",3))
 {
 return 21;
 }
 if(str_match2(str,"sil",3))
 {
 return 22;
 }
 if(str_match2(str,"dil",3))
 {
 return 23;
 }
 if(str_match2(str,"ah",2))
 {
 return 28;
 }
 if(str_match2(str,"ch",2))
 {
 return 29;
 }
 if(str_match2(str,"dh",2))
 {
 return 30;
 }
 if(str_match2(str,"bh",2))
 {
 return 31;
 }
 return -1;
}
int parse_reg64(char **str)
{
 if(str_match2(str,"rax",3))
 {
 return 0;
 }
 if(str_match2(str,"rcx",3))
 {
 return 1;
 }
 if(str_match2(str,"rdx",3))
 {
 return 2;
 }
 if(str_match2(str,"rbx",3))
 {
 return 3;
 }
 if(str_match2(str,"rsp",3))
 {
 return 4;
 }
 if(str_match2(str,"rbp",3))
 {
 return 5;
 }
 if(str_match2(str,"rsi",3))
 {
 return 6;
 }
 if(str_match2(str,"rdi",3))
 {
 return 7;
 }
 if(str_match2(str,"r8",2))
 {
 return 8;
 }
 if(str_match2(str,"r9",2))
 {
 return 9;
 }
 if(str_match2(str,"r10",3))
 {
 return 10;
 }
 if(str_match2(str,"r11",3))
 {
 return 11;
 }
 if(str_match2(str,"r12",3))
 {
 return 12;
 }
 if(str_match2(str,"r13",3))
 {
 return 13;
 }
 if(str_match2(str,"r14",3))
 {
 return 14;
 }
 if(str_match2(str,"r15",3))
 {
 return 15;
 }
 if(str_match2(str,"riz",3))
 {
 return -2;
 }
 return -1;
}
int parse_creg(char **str)
{
 if(str_match2(str,"cr0",3))
 {
 return 0;
 }
 if(str_match2(str,"cr2",3))
 {
 return 2;
 }
 if(str_match2(str,"cr3",3))
 {
 return 3;
 }
 if(str_match2(str,"cr4",3))
 {
 return 4;
 }
 if(str_match2(str,"cr8",3))
 {
 return 8;
 }
 return -1;
}
int parse_xreg(char **str)
{
 if(str_match2(str,"xmm0",4))
 {
 return 0;
 }
 if(str_match2(str,"xmm10",5))
 {
 return 10;
 }
 if(str_match2(str,"xmm11",5))
 {
 return 11;
 }
 if(str_match2(str,"xmm12",5))
 {
 return 12;
 }
 if(str_match2(str,"xmm13",5))
 {
 return 13;
 }
 if(str_match2(str,"xmm14",5))
 {
 return 14;
 }
 if(str_match2(str,"xmm15",5))
 {
 return 15;
 }
 if(str_match2(str,"xmm1",4))
 {
 return 1;
 }
 if(str_match2(str,"xmm2",4))
 {
 return 2;
 }
 if(str_match2(str,"xmm3",4))
 {
 return 3;
 }
 if(str_match2(str,"xmm4",4))
 {
 return 4;
 }
 if(str_match2(str,"xmm5",4))
 {
 return 5;
 }
 if(str_match2(str,"xmm6",4))
 {
 return 6;
 }
 if(str_match2(str,"xmm7",4))
 {
 return 7;
 }
 if(str_match2(str,"xmm8",4))
 {
 return 8;
 }
 if(str_match2(str,"xmm9",4))
 {
 return 9;
 }
 return -1;
}
int parse_yreg(char **str)
{
 if(str_match2(str,"ymm0",4))
 {
 return 0;
 }
 if(str_match2(str,"ymm10",5))
 {
 return 10;
 }
 if(str_match2(str,"ymm11",5))
 {
 return 11;
 }
 if(str_match2(str,"ymm12",5))
 {
 return 12;
 }
 if(str_match2(str,"ymm13",5))
 {
 return 13;
 }
 if(str_match2(str,"ymm14",5))
 {
 return 14;
 }
 if(str_match2(str,"ymm15",5))
 {
 return 15;
 }
 if(str_match2(str,"ymm1",4))
 {
 return 1;
 }
 if(str_match2(str,"ymm2",4))
 {
 return 2;
 }
 if(str_match2(str,"ymm3",4))
 {
 return 3;
 }
 if(str_match2(str,"ymm4",4))
 {
 return 4;
 }
 if(str_match2(str,"ymm5",4))
 {
 return 5;
 }
 if(str_match2(str,"ymm6",4))
 {
 return 6;
 }
 if(str_match2(str,"ymm7",4))
 {
 return 7;
 }
 if(str_match2(str,"ymm8",4))
 {
 return 8;
 }
 if(str_match2(str,"ymm9",4))
 {
 return 9;
 }
 return -1;
}
struct addr
{
 char bit32;
 char reg1;
 char reg2;
 char scale;
 unsigned int offset;
};
int parse_addr(char **str,struct addr *addr)
{
 char *old_str;
 unsigned long int off;
 old_str=*str;
 addr->offset=0;
 if(!str_match(str,"("))
 {
 if(parse_const(str,&off)==-1)
 {
 return -1;
 }
 if(off>0x7fffffff&&off<0xffffffff80000000)
 {
 error(l->line,"address out of range.");
 }
 addr->offset=off;
 if(!str_match(str,"("))
 {
 addr->bit32=0;
 addr->reg1=-1;
 addr->reg2=-1;
 addr->scale=0;
 return 0;
 }
 }
 if(!str_match(str,"%"))
 {
 error(l->line,"register required.");
 }
 if((addr->reg1=parse_reg64(str))!=-1)
 {
 addr->bit32=0;
 if(str_match(str,")"))
 {
 addr->reg2=-1;
 addr->scale=0;
 return 0;
 }
 else if(!str_match(str,","))
 {
 error(l->line,"expected \')\' or \',\' after register.");
 }
 if(!str_match(str,"%"))
 {
 error(l->line,"register required.");
 }
 if((addr->reg2=parse_reg64(str))==-1)
 {
 error(l->line,"invalid index register.");
 }
 if(addr->reg2==4)
 {
 error(l->line,"invalid index register.");
 }
 if(str_match(str,")"))
 {
 addr->scale=0;
 return 0;
 }
 else if(!str_match(str,","))
 {
 error(l->line,"expected \')\' or \',\' after register.");
 }
 if(str_match(str,"1"))
 {
 addr->scale=0;
 }
 else if(str_match(str,"2"))
 {
 addr->scale=0x40;
 }
 else if(str_match(str,"4"))
 {
 addr->scale=0x80;
 }
 else if(str_match(str,"8"))
 {
 addr->scale=0xc0;
 }
 else
 {
 error(l->line,"invalid scaler.");
 }
 if(!str_match(str,")"))
 {
 error(l->line,"expected \')\' after scaler.");
 }
 return 0;
 }
 else if((addr->reg1=parse_reg32(str))!=-1)
 {
 addr->bit32=1;
 if(str_match(str,")"))
 {
 addr->reg2=-1;
 addr->scale=0;
 return 0;
 }
 else if(!str_match(str,","))
 {
 error(l->line,"expected \')\' or \',\' after register.");
 }
 if(!str_match(str,"%"))
 {
 error(l->line,"register required.");
 }
 if((addr->reg2=parse_reg32(str))==-1)
 {
 error(l->line,"invalid index register.");
 }
 if(addr->reg2==4)
 {
 error(l->line,"invalid index register.");
 }
 if(str_match(str,")"))
 {
 addr->scale=0;
 return 0;
 }
 else if(!str_match(str,","))
 {
 error(l->line,"expected \')\' or \',\' after register.");
 }
 if(str_match(str,"1"))
 {
 addr->scale=0;
 }
 else if(str_match(str,"2"))
 {
 addr->scale=0x40;
 }
 else if(str_match(str,"4"))
 {
 addr->scale=0x80;
 }
 else if(str_match(str,"8"))
 {
 addr->scale=0xc0;
 }
 else
 {
 error(l->line,"invalid scaler.");
 }
 if(!str_match(str,")"))
 {
 error(l->line,"expected \')\' after scaler.");
 }
 return 0;
 }
 else if(str_match(str,"rip"))
 {
 if(!str_match(str,")"))
 {
 error(l->line,"expected \')\' after %rip.");
 }
 addr->bit32=0;
 addr->reg1=16;
 addr->reg2=-1;
 addr->scale=0;
 return 0;
 }
 else
 {
 error(l->line,"invalid address.");
 }
}
struct ins_args
{
 struct addr addr;
 char reg1;
 char reg2;
 char pad[6];
 unsigned long int imm;
};
int get_ins_args(char *input,char *format,struct ins_args *args)
{
 char *word;
 while(word=read_word(&format))
 {
 if(!strcmp(word,"ADDR"))
 {
 if(parse_addr(&input,&args->addr))
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"B1"))
 {
 if((args->reg1=parse_reg8(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"B2"))
 {
 if((args->reg2=parse_reg8(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"W1"))
 {
 if((args->reg1=parse_reg16(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"W2"))
 {
 if((args->reg2=parse_reg16(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"L1"))
 {
 if((args->reg1=parse_reg32(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"L2"))
 {
 if((args->reg2=parse_reg32(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"Q1"))
 {
 if((args->reg1=parse_reg64(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"Q2"))
 {
 if((args->reg2=parse_reg64(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"C1"))
 {
 if((args->reg1=parse_creg(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"C2"))
 {
 if((args->reg2=parse_creg(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"X1"))
 {
 if((args->reg1=parse_xreg(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"X2"))
 {
 if((args->reg2=parse_xreg(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"Y1"))
 {
 if((args->reg1=parse_yreg(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"Y2"))
 {
 if((args->reg2=parse_yreg(&input))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!strcmp(word,"I"))
 {
 if((parse_const(&input,&args->imm))==-1)
 {
 free(word);
 return -1;
 }
 }
 else if(!str_match(&input,word))
 {
 free(word);
 return -1;
 }
 free(word);
 }
 input=skip_spaces(input);
 if(*input!=0)
 {
 return -1;
 }
 return 0;
}
struct ins
{
 char *name;
 char *format;
 char *prefix;
 char *opcode;
 char opcode_len;
 char rex;
 short int modrm;
 unsigned int flags;
 int (*special_handler)(char *,struct ins_args *);
 struct ins *next;
} *ins_list[1021];
 
 
void ins_add(char *format,char *prefix,char *opcode,int opcode_len,int rex,int modrm,unsigned int flags,int (*special_handler)(char *,struct ins_args *))
{
 struct ins *ins;
 int hash;
 hash=format_hash(format);
 ins=xmalloc(sizeof(*ins));
 ins->name=read_word(&format);
 ins->format=format;
 ins->prefix=prefix;
 ins->opcode=opcode;
 ins->opcode_len=opcode_len;
 ins->rex=rex;
 ins->modrm=modrm;
 ins->flags=flags;
 ins->special_handler=special_handler;
 hash+=name_hash(ins->name);
 hash=hash%1021;
 ins->next=ins_list[hash];
 ins_list[hash]=ins;
}
void write_addr_prefix(struct addr *addr)
{
 if(addr->bit32)
 {
 soutc(0x67);
 }
}
unsigned char get_addr_rex(struct addr *addr)
{
 unsigned char rex;
 rex=0;
 if(addr->reg1>=8&&addr->reg1<16)
 {
 rex|=0x41;
 }
 if(addr->reg2>=8&&addr->reg1<16)
 {
 rex|=0x42;
 }
 return rex;
}
void write_addr(int modrm,struct addr *addr)
{
 int reg,reg2;
 if(addr->reg1<0)
 {
 if(addr->reg2<0)
 {
 soutc(modrm|0x04);
 soutc(0x25);
 swrite(&addr->offset,4);
 }
 else
 {
 soutc(modrm|0x04);
 soutc(0x05|addr->scale);
 swrite(&addr->offset,4);
 }
 }
 else if(addr->reg1==16)
 {
 soutc(modrm|0x05);
 swrite(&addr->offset,4);
 }
 else if(addr->reg2<0)
 {
 reg=addr->reg1&7;
 if(addr->offset==0&&reg!=5)
 {
 if(reg==4)
 {
 soutc(modrm|0x04);
 soutc(0x24);
 }
 else
 {
 soutc(modrm|reg);
 }
 }
 else if(addr->offset<=0x7f||addr->offset>=0xffffff80)
 {
 soutc(modrm|0x40|reg);
 if(reg==4)
 {
 soutc(0x24);
 }
 swrite(&addr->offset,1);
 }
 else
 {
 soutc(modrm|0x80|reg);
 if(reg==4)
 {
 soutc(0x24);
 }
 swrite(&addr->offset,4);
 }
 }
 else
 {
 reg=addr->reg1&7;
 reg2=addr->reg2&7;
 if(addr->offset==0&&reg!=5)
 {
 soutc(modrm|0x04);
 soutc(addr->scale|reg2<<3|reg);
 }
 else if(addr->offset<=0x7f||addr->offset>=0xffffff80)
 {
 soutc(modrm|0x44);
 soutc(addr->scale|reg2<<3|reg);
 swrite(&addr->offset,1);
 }
 else
 {
 soutc(modrm|0x84);
 soutc(addr->scale|reg2<<3|reg);
 swrite(&addr->offset,4);
 }
 }
}
int write_default_ins(struct ins *ins,struct ins_args *args)
{
 int rex,modrm;
 int s;
 rex=ins->rex;
 modrm=ins->modrm;
 if(ins->flags&2)
 {
 s=ins->flags&12;
 if(s==0)
 {
 if(ins->flags&128)
 {
 if(args->imm>0xff&&args->imm<0xffffffffffffff80)
 {
 return -1;
 }
 }
 else
 {
 if(args->imm>0x7f&&args->imm<0xffffffffffffff80)
 {
 return -1;
 }
 }
 }
 else if(s==4)
 {
 if(ins->flags&128)
 {
 if(args->imm>0xffff&&args->imm<0xffffffffffff8000)
 {
 return -1;
 }
 }
 else
 {
 if(args->imm>0x7fff&&args->imm<0xffffffffffff8000)
 {
 return -1;
 }
 }
 }
 else if(s==8)
 {
 if(ins->flags&128)
 {
 if(args->imm>0xffffffff&&args->imm<0xffffffff80000000)
 {
 return -1;
 }
 }
 else
 {
 if(args->imm>0x7fffffff&&args->imm<0xffffffff80000000)
 {
 return -1;
 }
 }
 }
 }
 if(ins->flags&16)
 {
 write_addr_prefix(&args->addr);
 rex|=get_addr_rex(&args->addr);
 }
 if(ins->flags&32)
 {
 if(args->reg1>=8&&args->reg1<16)
 {
 rex|=0x41;
 }
 if(args->reg1>=20&&args->reg1<24)
 {
 rex|=0x40;
 }
 modrm|=args->reg1&7;
 }
 if(ins->flags&64)
 {
 if(args->reg2>=8&&args->reg2<16)
 {
 rex|=0x44;
 }
 if(args->reg2>=20&&args->reg2<24)
 {
 rex|=0x40;
 }
 modrm|=(args->reg2&7)<<3;
 }
 if(ins->prefix)
 {
 swrite(ins->prefix,strlen(ins->prefix));
 }
 if(rex)
 {
 if(ins->flags&32)
 {
 if(args->reg1>=28&&args->reg1<32)
 {
 error(l->line,"invalid register with REX.");
 }
 }
 if(ins->flags&64)
 {
 if(args->reg2>=28&&args->reg2<32)
 {
 error(l->line,"invalid register with REX.");
 }
 }
 soutc(rex);
 }
 swrite(ins->opcode,ins->opcode_len);
 if(ins->flags&16)
 {
 write_addr(modrm,&args->addr);
 }
 else if(ins->flags&1)
 {
 soutc(modrm|0xc0);
 }
 if(ins->flags&2)
 {
 s=ins->flags&12;
 if(s==0)
 {
 swrite(&args->imm,1);
 }
 else if(s==4)
 {
 swrite(&args->imm,2);
 }
 else if(s==8)
 {
 swrite(&args->imm,4);
 }
 else if(s==12)
 {
 swrite(&args->imm,8);
 }
 }
 return 0;
}
int movl_handler(char *opcode,struct ins_args *args)
{
 if(args->reg1>=8)
 {
 soutc(0x41);
 }
 soutc(0xb8|args->reg1&7);
 swrite(&args->imm,4);
 return 0;
}
int movq_handler(char *opcode,struct ins_args *args)
{
 if(args->reg1>=8)
 {
 soutc(0x49);
 }
 else
 {
 soutc(0x48);
 }
 soutc(0xb8|args->reg1&7);
 swrite(&args->imm,8);
 return 0;
}
int movw_handler(char *opcode,struct ins_args *args)
{
 soutc(0x66);
 if(args->reg1>=8)
 {
 soutc(0x41);
 }
 soutc(0xb8|args->reg1&7);
 swrite(&args->imm,2);
 return 0;
}
int movb_handler(char *opcode,struct ins_args *args)
{
 if(args->reg1>=20&&args->reg1<24)
 {
 soutc(0x40);
 }
 else if(args->reg1>=8&&args->reg1<16)
 {
 soutc(0x41);
 }
 soutc(0xb0|args->reg1&7);
 swrite(&args->imm,1);
 return 0;
}
int movq_handler2(char *opcode,struct ins_args *args)
{
 if(args->imm>0xffffffff)
 {
 return 1;
 }
 if(args->reg1>=8)
 {
 soutc(0x41);
 }
 soutc(0xb8|args->reg1&7);
 swrite(&args->imm,4);
 return 0;
}
void ins_init_mov(void)
{
 ins_add("mov %W1,%ds",0,"\x8e",1,0,0xd8,32|1,0);
 ins_add("mov %W1,%es",0,"\x8e",1,0,0xc0,32|1,0);
 ins_add("mov %W1,%fs",0,"\x8e",1,0,0xe0,32|1,0);
 ins_add("mov %W1,%gs",0,"\x8e",1,0,0xe8,32|1,0);
 ins_add("mov %W1,%ss",0,"\x8e",1,0,0xd0,32|1,0);
 
 ins_add("mov %ds,%L1",0,"\x8c",1,0,0xd8,32|1,0);
 ins_add("mov %es,%L1",0,"\x8c",1,0,0xc0,32|1,0);
 ins_add("mov %fs,%L1",0,"\x8c",1,0,0xe0,32|1,0);
 ins_add("mov %gs,%L1",0,"\x8c",1,0,0xe8,32|1,0);
 ins_add("mov %ss,%L1",0,"\x8c",1,0,0xd0,32|1,0);
 
 ins_add("movsbw %B1,%W2","\x66","\x0f\xbe",2,0,0,(32|64)|1,0);
 ins_add("movsbl %B1,%L2",0,"\x0f\xbe",2,0,0,(32|64)|1,0);
 ins_add("movsbq %B1,%Q2",0,"\x0f\xbe",2,0x48,0,(32|64)|1,0);
 ins_add("movswl %W1,%L2",0,"\x0f\xbf",2,0,0,(32|64)|1,0);
 ins_add("movswq %W1,%Q2",0,"\x0f\xbf",2,0x48,0,(32|64)|1,0);
 ins_add("movslq %L1,%Q2",0,"\x63",1,0x48,0,(32|64)|1,0);
 
 ins_add("movzbw %B1,%W2","\x66","\x0f\xb6",2,0,0,(32|64)|1,0);
 ins_add("movzbl %B1,%L2",0,"\x0f\xb6",2,0,0,(32|64)|1,0);
 ins_add("movzbq %B1,%Q2",0,"\x0f\xb6",2,0,0,(32|64)|1,0);
 ins_add("movzwl %W1,%L2",0,"\x0f\xb7",2,0,0,(32|64)|1,0);
 ins_add("movzwq %W1,%Q2",0,"\x0f\xb7",2,0,0,(32|64)|1,0);
 
 ins_add("movsbw ADDR,%W2","\x66","\x0f\xbe",2,0,0,(64|16),0);
 ins_add("movsbl ADDR,%L2",0,"\x0f\xbe",2,0,0,(64|16),0);
 ins_add("movsbq ADDR,%Q2",0,"\x0f\xbe",2,0x48,0,(64|16),0);
 ins_add("movswl ADDR,%L2",0,"\x0f\xbf",2,0,0,(64|16),0);
 ins_add("movswq ADDR,%Q2",0,"\x0f\xbf",2,0x48,0,(64|16),0);
 ins_add("movslq ADDR,%Q2",0,"\x63",1,0x48,0,(64|16),0);
 
 ins_add("movzbw ADDR,%W2","\x66","\x0f\xb6",2,0,0,(64|16),0);
 ins_add("movzbl ADDR,%L2",0,"\x0f\xb6",2,0,0,(64|16),0);
 ins_add("movzbq ADDR,%Q2",0,"\x0f\xb6",2,0x48,0,(64|16),0);
 ins_add("movzwl ADDR,%L2",0,"\x0f\xb7",2,0,0,(64|16),0);
 ins_add("movzwq ADDR,%Q2",0,"\x0f\xb7",2,0x48,0,(64|16),0);
 
 
 ins_add("movw $I,ADDR","\x66","\xc7",1,0,0,(2|4|16)|128,0);
 ins_add("mov ADDR,%W2","\x66","\x8b",1,0,0,(64|16),0);
 ins_add("mov %W2,ADDR","\x66","\x89",1,0,0,(64|16),0);
 
 ins_add("movb $I,ADDR",0,"\xc6",1,0,0,(2|0|16)|128,0);
 ins_add("mov ADDR,%B2",0,"\x8a",1,0,0,(64|16),0);
 ins_add("mov %B2,ADDR",0,"\x88",1,0,0,(64|16),0);
 
 ins_add("movl $I,ADDR",0,"\xc7",1,0,0,(2|8|16)|128,0);
 ins_add("mov ADDR,%L2",0,"\x8b",1,0,0,(64|16),0);
 ins_add("mov %L2,ADDR",0,"\x89",1,0,0,(64|16),0);
 
 ins_add("movq $I,ADDR",0,"\xc7",1,0x48,0,(2|8|16),0);
 ins_add("mov ADDR,%Q2",0,"\x8b",1,0x48,0,(64|16),0);
 ins_add("mov %Q2,ADDR",0,"\x89",1,0x48,0,(64|16),0);
 
 ins_add("mov $I,%W1",0,0,0,0,0,0,movw_handler);
 ins_add("mov $I,%B1",0,0,0,0,0,0,movb_handler);
 ins_add("mov $I,%L1",0,0,0,0,0,0,movl_handler);
 ins_add("mov $I,%Q1",0,0,0,0,0,0,movq_handler);
 ins_add("mov $I,%Q1",0,"\xc7",1,0x48,0,(2|8|32)|1,0);
 ins_add("mov $I,%Q1",0,0,0,0,0,0,movq_handler2);
 
 ins_add("mov %W2,%W1","\x66","\x89",1,0,0,(32|64)|1,0);
 ins_add("mov %B2,%B1",0,"\x88",1,0,0,(32|64)|1,0);
 ins_add("mov %L2,%L1",0,"\x89",1,0,0,(32|64)|1,0);
 ins_add("mov %Q2,%Q1",0,"\x89",1,0x48,0,(32|64)|1,0);
 
}
int jmp_handler(char *opcode,struct ins_args *args)
{
 unsigned int val;
 if(args->imm-pc-5>0x7fffffff&&args->imm-pc-5<0xffffffff80000000)
 {
 error(l->line,"branch out of range.");
 }
 val=args->imm-pc-2;
 if(val>0x7f&&val<0xffffff80)
 {
 val=val-3;
 soutc(0xe9);
 swrite(&val,4);
 }
 else
 {
 soutc(0xeb);
 swrite(&val,1);
 }
 l->needs_recompile=1;
 return 0;
}
int jcond_handler(char *opcode,struct ins_args *args)
{
 unsigned int val;
 if(args->imm-pc-6>0x7fffffff&&args->imm-pc-6<0xffffffff80000000)
 {
 error(l->line,"branch out of range.");
 }
 val=args->imm-pc-2;
 if(val>0x7f&&val<0xffffff80)
 {
 val=val-4;
 swrite(opcode+1,2);
 swrite(&val,4);
 }
 else
 {
 swrite(opcode,1);
 swrite(&val,1);
 }
 l->needs_recompile=1;
 return 0;
}
int call_handler(char *opcode,struct ins_args *args)
{
 unsigned int val;
 if(args->imm-pc-5>0x7fffffff&&args->imm-pc-5<0xffffffff80000000)
 {
 error(l->line,"branch out of range.");
 }
 val=args->imm-pc-5;
 soutc(0xe8);
 swrite(&val,4);
 l->needs_recompile=1;
 return 0;
}
void ins_init_jmp(void)
{
 ins_add("jmp I",0,0,0,0,0,0,jmp_handler);
 ins_add("jmp *%Q1",0,"\xff",1,0,0x20,32|1,0);
 ins_add("jmp *ADDR",0,"\xff",1,0,0x20,16,0);
 
 ins_add("jo I",0,"\x70\x0f\x80",0,0,0,0,jcond_handler);
 ins_add("jno I",0,"\x71\x0f\x81",0,0,0,0,jcond_handler);
 ins_add("jb I",0,"\x72\x0f\x82",0,0,0,0,jcond_handler);
 ins_add("jae I",0,"\x73\x0f\x83",0,0,0,0,jcond_handler);
 ins_add("je I",0,"\x74\x0f\x84",0,0,0,0,jcond_handler);
 ins_add("jne I",0,"\x75\x0f\x85",0,0,0,0,jcond_handler);
 ins_add("jbe I",0,"\x76\x0f\x86",0,0,0,0,jcond_handler);
 ins_add("ja I",0,"\x77\x0f\x87",0,0,0,0,jcond_handler);
 ins_add("js I",0,"\x78\x0f\x88",0,0,0,0,jcond_handler);
 ins_add("jns I",0,"\x79\x0f\x89",0,0,0,0,jcond_handler);
 ins_add("jp I",0,"\x7a\x0f\x8a",0,0,0,0,jcond_handler);
 ins_add("jnp I",0,"\x7b\x0f\x8b",0,0,0,0,jcond_handler);
 ins_add("jl I",0,"\x7c\x0f\x8c",0,0,0,0,jcond_handler);
 ins_add("jge I",0,"\x7d\x0f\x8d",0,0,0,0,jcond_handler);
 ins_add("jle I",0,"\x7e\x0f\x8e",0,0,0,0,jcond_handler);
 ins_add("jg I",0,"\x7f\x0f\x8f",0,0,0,0,jcond_handler);
 
 ins_add("call I",0,0,0,0,0,0,call_handler);
 ins_add("call *%Q1",0,"\xff",1,0,0x10,32|1,0);
 ins_add("call *ADDR",0,"\xff",1,0,0x10,16,0);
 
 ins_add("ret",0,"\xc3",1,0,0,0,0);
}
void ins_init_basic_op(void)
{
 ins_add("inc %L1",0,"\xff",1,0,0,32|1,0);
 ins_add("inc %Q1",0,"\xff",1,0x48,0,32|1,0);
 ins_add("inc %W1","\x66","\xff",1,0,0,32|1,0);
 ins_add("inc %B1",0,"\xfe",1,0,0,32|1,0);
 ins_add("incl ADDR",0,"\xff",1,0,0,16,0);
 ins_add("incq ADDR",0,"\xff",1,0x48,0,16,0);
 ins_add("incw ADDR","\x66","\xff",1,0,0,16,0);
 ins_add("incb ADDR",0,"\xfe",1,0,0,16,0);
 
 ins_add("dec %L1",0,"\xff",1,0,0x08,32|1,0);
 ins_add("dec %Q1",0,"\xff",1,0x48,0x08,32|1,0);
 ins_add("dec %W1","\x66","\xff",1,0,0x08,32|1,0);
 ins_add("dec %B1",0,"\xfe",1,0,0x08,32|1,0);
 ins_add("decl ADDR",0,"\xff",1,0,0x08,16,0);
 ins_add("decq ADDR",0,"\xff",1,0x48,0x08,16,0);
 ins_add("decw ADDR","\x66","\xff",1,0,0x08,16,0);
 ins_add("decb ADDR",0,"\xfe",1,0,0x08,16,0);
 
 ins_add("not %L1",0,"\xf7",1,0,0x10,32|1,0);
 ins_add("not %Q1",0,"\xf7",1,0x48,0x10,32|1,0);
 ins_add("not %W1","\x66","\xf7",1,0,0x10,32|1,0);
 ins_add("not %B1",0,"\xf6",1,0,0x10,32|1,0);
 ins_add("notl ADDR",0,"\xf7",1,0,0x10,16,0);
 ins_add("notq ADDR",0,"\xf7",1,0x48,0x10,16,0);
 ins_add("notw ADDR","\x66","\xf7",1,0,0x10,16,0);
 ins_add("notb ADDR",0,"\xf6",1,0,0x10,16,0);
 
 ins_add("neg %L1",0,"\xf7",1,0,0x18,32|1,0);
 ins_add("neg %Q1",0,"\xf7",1,0x48,0x18,32|1,0);
 ins_add("neg %W1","\x66","\xf7",1,0,0x18,32|1,0);
 ins_add("neg %B1",0,"\xf6",1,0,0x18,32|1,0);
 ins_add("negl ADDR",0,"\xf7",1,0,0x18,16,0);
 ins_add("negq ADDR",0,"\xf7",1,0x48,0x18,16,0);
 ins_add("negw ADDR","\x66","\xf7",1,0,0x18,16,0);
 ins_add("negb ADDR",0,"\xf6",1,0,0x18,16,0);
 
 ins_add("cmp %L2,%L1",0,"\x39",1,0,0,(32|64)|1,0);
 ins_add("cmp %Q2,%Q1",0,"\x39",1,0x48,0,(32|64)|1,0);
 ins_add("cmp %W2,%W1","\x66","\x39",1,0,0,(32|64)|1,0);
 ins_add("cmp %B2,%B1",0,"\x38",1,0,0,(32|64)|1,0);
 ins_add("cmp $I,%L1",0,"\x81",1,0,0x38,(2|8|32)|1|128,0);
 ins_add("cmp $I,%eax",0,"\x3d",1,0,0,2|8|128,0);
 ins_add("cmp $I,%L1",0,"\x83",1,0,0x38,(2|0|32)|1,0);
 ins_add("cmp $I,%Q1",0,"\x81",1,0x48,0x38,(2|8|32)|1,0);
 ins_add("cmp $I,%rax",0,"\x3d",1,0x48,0,2|8,0);
 ins_add("cmp $I,%Q1",0,"\x83",1,0x48,0x38,(2|0|32)|1,0);
 ins_add("cmp $I,%W1","\x66","\x81",1,0,0x38,(2|4|32)|1|128,0);
 ins_add("cmp $I,%ax","\x66","\x3d",1,0,0,2|4|128,0);
 ins_add("cmp $I,%W1","\x66","\x83",1,0,0x38,(2|0|32)|1,0);
 ins_add("cmp $I,%B1",0,"\x80",1,0,0x38,(2|0|32)|1|128,0);
 ins_add("cmp $I,%al",0,"\x3c",1,0,0,2|0|128,0);
 ins_add("cmpl $I,ADDR",0,"\x81",1,0,0x38,(2|8|16)|128,0);
 ins_add("cmpl $I,ADDR",0,"\x83",1,0,0x38,(2|0|16),0);
 ins_add("cmpq $I,ADDR",0,"\x81",1,0x48,0x38,(2|8|16),0);
 ins_add("cmpq $I,ADDR",0,"\x83",1,0x48,0x38,(2|0|16),0);
 ins_add("cmpw $I,ADDR","\x66","\x81",1,0,0x38,(2|4|16)|128,0);
 ins_add("cmpw $I,ADDR","\x66","\x83",1,0,0x38,(2|0|16),0);
 ins_add("cmpb $I,ADDR",0,"\x80",1,0,0x38,(2|0|16)|128,0);
 ins_add("cmp %L2,ADDR",0,"\x39",1,0,0,(64|16),0);
 ins_add("cmp ADDR,%L2",0,"\x3b",1,0,0,(64|16),0);
 ins_add("cmp %Q2,ADDR",0,"\x39",1,0x48,0,(64|16),0);
 ins_add("cmp ADDR,%Q2",0,"\x3b",1,0x48,0,(64|16),0);
 ins_add("cmp %W2,ADDR","\x66","\x39",1,0,0,(64|16),0);
 ins_add("cmp ADDR,%W2","\x66","\x3b",1,0,0,(64|16),0);
 ins_add("cmp %B2,ADDR",0,"\x38",1,0,0,(64|16),0);
 ins_add("cmp ADDR,%B2",0,"\x3a",1,0,0,(64|16),0);
 
 ins_add("test %L2,%L1",0,"\x85",1,0,0,(32|64)|1,0);
 ins_add("test %Q2,%Q1",0,"\x85",1,0x48,0,(32|64)|1,0);
 ins_add("test %W2,%W1","\x66","\x85",1,0,0,(32|64)|1,0);
 ins_add("test %B2,%B1",0,"\x84",1,0,0,(32|64)|1,0);
 ins_add("test $I,%L1",0,"\xf7",1,0,0,(2|8|32)|1|128,0);
 ins_add("test $I,%eax",0,"\xa9",1,0,0,2|8|128,0);
 ins_add("test $I,%Q1",0,"\xf7",1,0x48,0,(2|8|32)|1,0);
 ins_add("test $I,%rax",0,"\xa9",1,0x48,0,2|8,0);
 ins_add("test $I,%W1","\x66","\xf7",1,0,0,(2|4|32)|1|128,0);
 ins_add("test $I,%ax","\x66","\xa9",1,0,0,2|4|128,0);
 ins_add("test $I,%B1",0,"\xf6",1,0,0,(2|0|32)|1|128,0);
 ins_add("test $I,%al",0,"\xa8",1,0,0,2|0|128,0);
 ins_add("testl $I,ADDR",0,"\xf7",1,0,0,(2|8|16)|128,0);
 ins_add("testq $I,ADDR",0,"\xf7",1,0x48,0,(2|8|16),0);
 ins_add("testw $I,ADDR","\x66","\xf7",1,0,0,(2|4|16)|128,0);
 ins_add("testb $I,ADDR",0,"\xf6",1,0,0,(2|0|16)|128,0);
 ins_add("test %L2,ADDR",0,"\x85",1,0,0,(64|16),0);
 ins_add("test ADDR,%L2",0,"\x85",1,0,0,(64|16),0);
 ins_add("test %Q2,ADDR",0,"\x85",1,0x48,0,(64|16),0);
 ins_add("test ADDR,%Q2",0,"\x85",1,0x48,0,(64|16),0);
 ins_add("test %W2,ADDR","\x66","\x85",1,0,0,(64|16),0);
 ins_add("test ADDR,%W2","\x66","\x85",1,0,0,(64|16),0);
 ins_add("test %B2,ADDR",0,"\x84",1,0,0,(64|16),0);
 ins_add("test ADDR,%B2",0,"\x84",1,0,0,(64|16),0);
 
 ins_add("shl $I,%L1",0,"\xc1",1,0,0x20,(2|0|32)|128|1,0);
 ins_add("shl $I,%Q1",0,"\xc1",1,0x48,0x20,(2|0|32)|128|1,0);
 ins_add("shl $I,%W1","\x66","\xc1",1,0,0x20,(2|0|32)|128|1,0);
 ins_add("shl $I,%B1",0,"\xc0",1,0,0x20,(2|0|32)|128|1,0);
 ins_add("shl %cl,%L1",0,"\xd3",1,0,0x20,32|1,0);
 ins_add("shl %cl,%Q1",0,"\xd3",1,0x48,0x20,32|1,0);
 ins_add("shl %cl,%W1","\x66","\xd3",1,0,0x20,32|1,0);
 ins_add("shl %cl,%B1",0,"\xd2",1,0,0x20,32|1,0);
 ins_add("shll $I,ADDR",0,"\xc1",1,0,0x20,(2|0|16)|128,0);
 ins_add("shlq $I,ADDR",0,"\xc1",1,0x48,0x20,(2|0|16)|128,0);
 ins_add("shll $I,ADDR","\x66","\xc1",1,0,0x20,(2|0|16)|128,0);
 ins_add("shlb $I,ADDR",0,"\xc0",1,0,0x20,(2|0|16)|128,0);
 
 ins_add("shr $I,%L1",0,"\xc1",1,0,0x28,(2|0|32)|128|1,0);
 ins_add("shr $I,%Q1",0,"\xc1",1,0x48,0x28,(2|0|32)|128|1,0);
 ins_add("shr $I,%W1","\x66","\xc1",1,0,0x28,(2|0|32)|128|1,0);
 ins_add("shr $I,%B1",0,"\xc0",1,0,0x28,(2|0|32)|128|1,0);
 ins_add("shr %cl,%L1",0,"\xd3",1,0,0x28,32|1,0);
 ins_add("shr %cl,%Q1",0,"\xd3",1,0x48,0x28,32|1,0);
 ins_add("shr %cl,%W1","\x66","\xd3",1,0,0x28,32|1,0);
 ins_add("shr %cl,%B1",0,"\xd2",1,0,0x28,32|1,0);
 ins_add("shrl $I,ADDR",0,"\xc1",1,0,0x28,(2|0|16)|128,0);
 ins_add("shrq $I,ADDR",0,"\xc1",1,0x48,0x28,(2|0|16)|128,0);
 ins_add("shrl $I,ADDR","\x66","\xc1",1,0,0x28,(2|0|16)|128,0);
 ins_add("shrb $I,ADDR",0,"\xc0",1,0,0x28,(2|0|16)|128,0);
 
 ins_add("sar $I,%L1",0,"\xc1",1,0,0x38,(2|0|32)|128|1,0);
 ins_add("sar $I,%Q1",0,"\xc1",1,0x48,0x38,(2|0|32)|128|1,0);
 ins_add("sar $I,%W1","\x66","\xc1",1,0,0x38,(2|0|32)|128|1,0);
 ins_add("sar $I,%B1",0,"\xc0",1,0,0x38,(2|0|32)|128|1,0);
 ins_add("sar %cl,%L1",0,"\xd3",1,0,0x38,32|1,0);
 ins_add("sar %cl,%Q1",0,"\xd3",1,0x48,0x38,32|1,0);
 ins_add("sar %cl,%W1","\x66","\xd3",1,0,0x38,32|1,0);
 ins_add("sar %cl,%B1",0,"\xd2",1,0,0x38,32|1,0);
 ins_add("sarl $I,ADDR",0,"\xc1",1,0,0x38,(2|0|16)|128,0);
 ins_add("sarq $I,ADDR",0,"\xc1",1,0x48,0x38,(2|0|16)|128,0);
 ins_add("sarl $I,ADDR","\x66","\xc1",1,0,0x38,(2|0|16)|128,0);
 ins_add("sarb $I,ADDR",0,"\xc0",1,0,0x38,(2|0|16)|128,0);
 
 ins_add("push %rax",0,"\x50",1,0,0,0,0);
 ins_add("push %rcx",0,"\x51",1,0,0,0,0);
 ins_add("push %rdx",0,"\x52",1,0,0,0,0);
 ins_add("push %rbx",0,"\x53",1,0,0,0,0);
 ins_add("push %rsp",0,"\x54",1,0,0,0,0);
 ins_add("push %rbp",0,"\x55",1,0,0,0,0);
 ins_add("push %rsi",0,"\x56",1,0,0,0,0);
 ins_add("push %rdi",0,"\x57",1,0,0,0,0);
 ins_add("push %r8",0,"\x50",1,0x41,0,0,0);
 ins_add("push %r9",0,"\x51",1,0x41,0,0,0);
 ins_add("push %r10",0,"\x52",1,0x41,0,0,0);
 ins_add("push %r11",0,"\x53",1,0x41,0,0,0);
 ins_add("push %r12",0,"\x54",1,0x41,0,0,0);
 ins_add("push %r13",0,"\x55",1,0x41,0,0,0);
 ins_add("push %r14",0,"\x56",1,0x41,0,0,0);
 ins_add("push %r15",0,"\x57",1,0x41,0,0,0);
 ins_add("pushq $I",0,"\x68",1,0,0,2|8,0);
 ins_add("pushq ADDR",0,"\xff",1,0,0x30,16,0);
 
 ins_add("pop %rax",0,"\x58",1,0,0,0,0);
 ins_add("pop %rcx",0,"\x59",1,0,0,0,0);
 ins_add("pop %rdx",0,"\x5a",1,0,0,0,0);
 ins_add("pop %rbx",0,"\x5b",1,0,0,0,0);
 ins_add("pop %rsp",0,"\x5c",1,0,0,0,0);
 ins_add("pop %rbp",0,"\x5d",1,0,0,0,0);
 ins_add("pop %rsi",0,"\x5e",1,0,0,0,0);
 ins_add("pop %rdi",0,"\x5f",1,0,0,0,0);
 ins_add("pop %r8",0,"\x58",1,0x41,0,0,0);
 ins_add("pop %r9",0,"\x59",1,0x41,0,0,0);
 ins_add("pop %r10",0,"\x5a",1,0x41,0,0,0);
 ins_add("pop %r11",0,"\x5b",1,0x41,0,0,0);
 ins_add("pop %r12",0,"\x5c",1,0x41,0,0,0);
 ins_add("pop %r13",0,"\x5d",1,0x41,0,0,0);
 ins_add("pop %r14",0,"\x5e",1,0x41,0,0,0);
 ins_add("pop %r15",0,"\x5f",1,0x41,0,0,0);
 ins_add("popq ADDR",0,"\x8f",1,0,0,16,0);
 
 ins_add("lea ADDR,%L2",0,"\x8d",1,0,0,(64|16),0);
 ins_add("lea ADDR,%Q2",0,"\x8d",1,0x48,0,(64|16),0);
 ins_add("lea ADDR,%W2","\x66","\x8d",1,0,0,(64|16),0);
 
 ins_add("mul %L1",0,"\xf7",1,0,0x20,32|1,0);
 ins_add("mul %Q1",0,"\xf7",1,0x48,0x20,32|1,0);
 ins_add("mul %W1","\x66","\xf7",1,0,0x20,32|1,0);
 ins_add("mul %B1",0,"\xf6",1,0,0x20,32|1,0);
 ins_add("mull ADDR",0,"\xf7",1,0,0x20,16,0);
 ins_add("mulq ADDR",0,"\xf7",1,0x48,0x20,16,0);
 ins_add("mulw ADDR","\x66","\xf7",1,0,0x20,16,0);
 ins_add("mulb ADDR",0,"\xf6",1,0,0x20,16,0);
 
 ins_add("imul %L1",0,"\xf7",1,0,0x28,32|1,0);
 ins_add("imul %Q1",0,"\xf7",1,0x48,0x28,32|1,0);
 ins_add("imul %W1","\x66","\xf7",1,0,0x28,32|1,0);
 ins_add("imul %B1",0,"\xf6",1,0,0x28,32|1,0);
 ins_add("imull ADDR",0,"\xf7",1,0,0x28,16,0);
 ins_add("imulq ADDR",0,"\xf7",1,0x48,0x28,16,0);
 ins_add("imulw ADDR","\x66","\xf7",1,0,0x28,16,0);
 ins_add("imulb ADDR",0,"\xf6",1,0,0x28,16,0);
 
 ins_add("div %L1",0,"\xf7",1,0,0x30,32|1,0);
 ins_add("div %Q1",0,"\xf7",1,0x48,0x30,32|1,0);
 ins_add("div %W1","\x66","\xf7",1,0,0x30,32|1,0);
 ins_add("div %B1",0,"\xf6",1,0,0x30,32|1,0);
 ins_add("divl ADDR",0,"\xf7",1,0,0x30,16,0);
 ins_add("divq ADDR",0,"\xf7",1,0x48,0x30,16,0);
 ins_add("divw ADDR","\x66","\xf7",1,0,0x30,16,0);
 ins_add("divb ADDR",0,"\xf6",1,0,0x30,16,0);
 
 ins_add("idiv %L1",0,"\xf7",1,0,0x38,32|1,0);
 ins_add("idiv %Q1",0,"\xf7",1,0x48,0x38,32|1,0);
 ins_add("idiv %W1","\x66","\xf7",1,0,0x38,32|1,0);
 ins_add("idiv %B1",0,"\xf6",1,0,0x38,32|1,0);
 ins_add("idivl ADDR",0,"\xf7",1,0,0x38,16,0);
 ins_add("idivq ADDR",0,"\xf7",1,0x48,0x38,16,0);
 ins_add("idivw ADDR","\x66","\xf7",1,0,0x38,16,0);
 ins_add("idivb ADDR",0,"\xf6",1,0,0x38,16,0);
 
 ins_add("add %L2,%L1",0,"\x01",1,0,0,(32|64)|1,0);
 ins_add("add %Q2,%Q1",0,"\x01",1,0x48,0,(32|64)|1,0);
 ins_add("add %W2,%W1","\x66","\x01",1,0,0,(32|64)|1,0);
 ins_add("add %B2,%B1",0,"\x00",1,0,0,(32|64)|1,0);
 ins_add("add $I,%L1",0,"\x81",1,0,0,(2|8|32)|1|128,0);
 ins_add("add $I,%eax",0,"\x05",1,0,0,2|8|128,0);
 ins_add("add $I,%L1",0,"\x83",1,0,0,(2|0|32)|1,0);
 ins_add("add $I,%Q1",0,"\x81",1,0x48,0,(2|8|32)|1,0);
 ins_add("add $I,%rax",0,"\x05",1,0x48,0,2|8,0);
 ins_add("add $I,%Q1",0,"\x83",1,0x48,0,(2|0|32)|1,0);
 ins_add("add $I,%W1","\x66","\x81",1,0,0,(2|4|32)|1|128,0);
 ins_add("add $I,%ax","\x66","\x05",1,0,0,2|4|128,0);
 ins_add("add $I,%W1","\x66","\x83",1,0,0,(2|0|32)|1,0);
 ins_add("add $I,%B1",0,"\x80",1,0,0,(2|0|32)|1|128,0);
 ins_add("add $I,%al",0,"\x04",1,0,0,2|0|128,0);
 ins_add("addl $I,ADDR",0,"\x81",1,0,0,(2|8|16)|128,0);
 ins_add("addl $I,ADDR",0,"\x83",1,0,0,(2|0|16),0);
 ins_add("addq $I,ADDR",0,"\x81",1,0x48,0,(2|8|16),0);
 ins_add("addq $I,ADDR",0,"\x83",1,0x48,0,(2|0|16),0);
 ins_add("addw $I,ADDR","\x66","\x81",1,0,0,(2|4|16)|128,0);
 ins_add("addw $I,ADDR","\x66","\x83",1,0,0,(2|0|16),0);
 ins_add("addb $I,ADDR",0,"\x80",1,0,0,(2|0|16)|128,0);
 ins_add("add %L2,ADDR",0,"\x01",1,0,0,(64|16),0);
 ins_add("add ADDR,%L2",0,"\x03",1,0,0,(64|16),0);
 ins_add("add %Q2,ADDR",0,"\x01",1,0x48,0,(64|16),0);
 ins_add("add ADDR,%Q2",0,"\x03",1,0x48,0,(64|16),0);
 ins_add("add %W2,ADDR","\x66","\x01",1,0,0,(64|16),0);
 ins_add("add ADDR,%W2","\x66","\x03",1,0,0,(64|16),0);
 ins_add("add %B2,ADDR",0,"\x00",1,0,0,(64|16),0);
 ins_add("add ADDR,%B2",0,"\x02",1,0,0,(64|16),0);
 
 ins_add("adc %L2,%L1",0,"\x11",1,0,0,(32|64)|1,0);
 ins_add("adc %Q2,%Q1",0,"\x11",1,0x48,0,(32|64)|1,0);
 ins_add("adc %W2,%W1","\x66","\x11",1,0,0,(32|64)|1,0);
 ins_add("adc %B2,%B1",0,"\x10",1,0,0,(32|64)|1,0);
 ins_add("adc $I,%L1",0,"\x81",1,0,0x10,(2|8|32)|1|128,0);
 ins_add("adc $I,%L1",0,"\x83",1,0,0x10,(2|0|32)|1,0);
 ins_add("adc $I,%Q1",0,"\x81",1,0x48,0x10,(2|8|32)|1,0);
 ins_add("adc $I,%Q1",0,"\x83",1,0x48,0x10,(2|0|32)|1,0);
 ins_add("adc $I,%W1","\x66","\x81",1,0,0x10,(2|4|32)|1|128,0);
 ins_add("adc $I,%W1","\x66","\x83",1,0,0x10,(2|0|32)|1,0);
 ins_add("adc $I,%B1",0,"\x80",1,0,0x10,(2|0|32)|1|128,0);
 ins_add("adcl $I,ADDR",0,"\x81",1,0,0x10,(2|8|16)|128,0);
 ins_add("adcl $I,ADDR",0,"\x83",1,0,0x10,(2|0|16),0);
 ins_add("adcq $I,ADDR",0,"\x81",1,0x48,0x10,(2|8|16),0);
 ins_add("adcq $I,ADDR",0,"\x83",1,0x48,0x10,(2|0|16),0);
 ins_add("adcw $I,ADDR","\x66","\x81",1,0,0x10,(2|4|16)|128,0);
 ins_add("adcw $I,ADDR","\x66","\x83",1,0,0x10,(2|0|16),0);
 ins_add("adcb $I,ADDR",0,"\x80",1,0,0x10,(2|0|16)|128,0);
 ins_add("adc %L2,ADDR",0,"\x11",1,0,0,(64|16),0);
 ins_add("adc ADDR,%L2",0,"\x13",1,0,0,(64|16),0);
 ins_add("adc %Q2,ADDR",0,"\x11",1,0x48,0,(64|16),0);
 ins_add("adc ADDR,%Q2",0,"\x13",1,0x48,0,(64|16),0);
 ins_add("adc %W2,ADDR","\x66","\x11",1,0,0,(64|16),0);
 ins_add("adc ADDR,%W2","\x66","\x13",1,0,0,(64|16),0);
 ins_add("adc %B2,ADDR",0,"\x10",1,0,0,(64|16),0);
 ins_add("adc ADDR,%B2",0,"\x12",1,0,0,(64|16),0);
 
 ins_add("sub %L2,%L1",0,"\x29",1,0,0,(32|64)|1,0);
 ins_add("sub %Q2,%Q1",0,"\x29",1,0x48,0,(32|64)|1,0);
 ins_add("sub %W2,%W1","\x66","\x29",1,0,0,(32|64)|1,0);
 ins_add("sub %B2,%B1",0,"\x28",1,0,0,(32|64)|1,0);
 ins_add("sub $I,%L1",0,"\x81",1,0,0x28,(2|8|32)|1|128,0);
 ins_add("sub $I,%eax",0,"\x2d",1,0,0,2|8|128,0);
 ins_add("sub $I,%L1",0,"\x83",1,0,0x28,(2|0|32)|1,0);
 ins_add("sub $I,%Q1",0,"\x81",1,0x48,0x28,(2|8|32)|1,0);
 ins_add("sub $I,%rax",0,"\x2d",1,0x48,0,2|8,0);
 ins_add("sub $I,%Q1",0,"\x83",1,0x48,0x28,(2|0|32)|1,0);
 ins_add("sub $I,%W1","\x66","\x81",1,0,0x28,(2|4|32)|1|128,0);
 ins_add("sub $I,%ax","\x66","\x2d",1,0,0,2|4|128,0);
 ins_add("sub $I,%W1","\x66","\x83",1,0,0x28,(2|0|32)|1,0);
 ins_add("sub $I,%B1",0,"\x80",1,0,0x28,(2|0|32)|1|128,0);
 ins_add("sub $I,%al",0,"\x2c",1,0,0,2|0|128,0);
 ins_add("subl $I,ADDR",0,"\x81",1,0,0x28,(2|8|16)|128,0);
 ins_add("subl $I,ADDR",0,"\x83",1,0,0x28,(2|0|16),0);
 ins_add("subq $I,ADDR",0,"\x81",1,0x48,0x28,(2|8|16),0);
 ins_add("subq $I,ADDR",0,"\x83",1,0x48,0x28,(2|0|16),0);
 ins_add("subw $I,ADDR","\x66","\x81",1,0,0x28,(2|4|16)|128,0);
 ins_add("subw $I,ADDR","\x66","\x83",1,0,0x28,(2|0|16),0);
 ins_add("subb $I,ADDR",0,"\x80",1,0,0x28,(2|0|16)|128,0);
 ins_add("sub %L2,ADDR",0,"\x29",1,0,0,(64|16),0);
 ins_add("sub ADDR,%L2",0,"\x2b",1,0,0,(64|16),0);
 ins_add("sub %Q2,ADDR",0,"\x29",1,0x48,0,(64|16),0);
 ins_add("sub ADDR,%Q2",0,"\x2b",1,0x48,0,(64|16),0);
 ins_add("sub %W2,ADDR","\x66","\x29",1,0,0,(64|16),0);
 ins_add("sub ADDR,%W2","\x66","\x2b",1,0,0,(64|16),0);
 ins_add("sub %B2,ADDR",0,"\x28",1,0,0,(64|16),0);
 ins_add("sub ADDR,%B2",0,"\x2a",1,0,0,(64|16),0);
 
 ins_add("sbb %L2,%L1",0,"\x19",1,0,0,(32|64)|1,0);
 ins_add("sbb %Q2,%Q1",0,"\x19",1,0x48,0,(32|64)|1,0);
 ins_add("sbb %W2,%W1","\x66","\x19",1,0,0,(32|64)|1,0);
 ins_add("sbb %B2,%B1",0,"\x18",1,0,0,(32|64)|1,0);
 ins_add("sbb $I,%L1",0,"\x81",1,0,0x18,(2|8|32)|1|128,0);
 ins_add("sbb $I,%L1",0,"\x83",1,0,0x18,(2|0|32)|1,0);
 ins_add("sbb $I,%Q1",0,"\x81",1,0x48,0x18,(2|8|32)|1,0);
 ins_add("sbb $I,%Q1",0,"\x83",1,0x48,0x18,(2|0|32)|1,0);
 ins_add("sbb $I,%W1","\x66","\x81",1,0,0x18,(2|4|32)|1|128,0);
 ins_add("sbb $I,%W1","\x66","\x83",1,0,0x18,(2|0|32)|1,0);
 ins_add("sbb $I,%B1",0,"\x80",1,0,0x18,(2|0|32)|1|128,0);
 ins_add("sbbl $I,ADDR",0,"\x81",1,0,0x18,(2|8|16)|128,0);
 ins_add("sbbl $I,ADDR",0,"\x83",1,0,0x18,(2|0|16),0);
 ins_add("sbbq $I,ADDR",0,"\x81",1,0x48,0x18,(2|8|16),0);
 ins_add("sbbq $I,ADDR",0,"\x83",1,0x48,0x18,(2|0|16),0);
 ins_add("sbbw $I,ADDR","\x66","\x81",1,0,0x18,(2|4|16)|128,0);
 ins_add("sbbw $I,ADDR","\x66","\x83",1,0,0x18,(2|0|16),0);
 ins_add("sbbb $I,ADDR",0,"\x80",1,0,0x18,(2|0|16)|128,0);
 ins_add("sbb %L2,ADDR",0,"\x19",1,0,0,(64|16),0);
 ins_add("sbb ADDR,%L2",0,"\x1b",1,0,0,(64|16),0);
 ins_add("sbb %Q2,ADDR",0,"\x19",1,0x48,0,(64|16),0);
 ins_add("sbb ADDR,%Q2",0,"\x1b",1,0x48,0,(64|16),0);
 ins_add("sbb %W2,ADDR","\x66","\x19",1,0,0,(64|16),0);
 ins_add("sbb ADDR,%W2","\x66","\x1b",1,0,0,(64|16),0);
 ins_add("sbb %B2,ADDR",0,"\x18",1,0,0,(64|16),0);
 ins_add("sbb ADDR,%B2",0,"\x1a",1,0,0,(64|16),0);
 
 ins_add("and %L2,%L1",0,"\x21",1,0,0,(32|64)|1,0);
 ins_add("and %Q2,%Q1",0,"\x21",1,0x48,0,(32|64)|1,0);
 ins_add("and %W2,%W1","\x66","\x21",1,0,0,(32|64)|1,0);
 ins_add("and %B2,%B1",0,"\x20",1,0,0,(32|64)|1,0);
 ins_add("and $I,%L1",0,"\x81",1,0,0x20,(2|8|32)|1|128,0);
 ins_add("and $I,%eax",0,"\x25",1,0,0,2|8|128,0);
 ins_add("and $I,%L1",0,"\x83",1,0,0x20,(2|0|32)|1,0);
 ins_add("and $I,%Q1",0,"\x81",1,0x48,0x20,(2|8|32)|1,0);
 ins_add("and $I,%rax",0,"\x25",1,0x48,0,2|8,0);
 ins_add("and $I,%Q1",0,"\x83",1,0x48,0x20,(2|0|32)|1,0);
 ins_add("and $I,%W1","\x66","\x81",1,0,0x20,(2|4|32)|1|128,0);
 ins_add("and $I,%ax","\x66","\x25",1,0,0,2|4|128,0);
 ins_add("and $I,%W1","\x66","\x83",1,0,0x20,(2|0|32)|1,0);
 ins_add("and $I,%B1",0,"\x80",1,0,0x20,(2|0|32)|1|128,0);
 ins_add("and $I,%al",0,"\x24",1,0,0,2|0|128,0);
 ins_add("andl $I,ADDR",0,"\x81",1,0,0x20,(2|8|16)|128,0);
 ins_add("andl $I,ADDR",0,"\x83",1,0,0x20,(2|0|16),0);
 ins_add("andq $I,ADDR",0,"\x81",1,0x48,0x20,(2|8|16),0);
 ins_add("andq $I,ADDR",0,"\x83",1,0x48,0x20,(2|0|16),0);
 ins_add("andw $I,ADDR","\x66","\x81",1,0,0x20,(2|4|16)|128,0);
 ins_add("andw $I,ADDR","\x66","\x83",1,0,0x20,(2|0|16),0);
 ins_add("andb $I,ADDR",0,"\x80",1,0,0x20,(2|0|16)|128,0);
 ins_add("and %L2,ADDR",0,"\x21",1,0,0,(64|16),0);
 ins_add("and ADDR,%L2",0,"\x23",1,0,0,(64|16),0);
 ins_add("and %Q2,ADDR",0,"\x21",1,0x48,0,(64|16),0);
 ins_add("and ADDR,%Q2",0,"\x23",1,0x48,0,(64|16),0);
 ins_add("and %W2,ADDR","\x66","\x21",1,0,0,(64|16),0);
 ins_add("and ADDR,%W2","\x66","\x23",1,0,0,(64|16),0);
 ins_add("and %B2,ADDR",0,"\x20",1,0,0,(64|16),0);
 ins_add("and ADDR,%B2",0,"\x22",1,0,0,(64|16),0);
 
 ins_add("or %L2,%L1",0,"\x09",1,0,0,(32|64)|1,0);
 ins_add("or %Q2,%Q1",0,"\x09",1,0x48,0,(32|64)|1,0);
 ins_add("or %W2,%W1","\x66","\x09",1,0,0,(32|64)|1,0);
 ins_add("or %B2,%B1",0,"\x08",1,0,0,(32|64)|1,0);
 ins_add("or $I,%L1",0,"\x81",1,0,0x08,(2|8|32)|1|128,0);
 ins_add("or $I,%eax",0,"\x0d",1,0,0,2|8|128,0);
 ins_add("or $I,%L1",0,"\x83",1,0,0x08,(2|0|32)|1,0);
 ins_add("or $I,%Q1",0,"\x81",1,0x48,0x08,(2|8|32)|1,0);
 ins_add("or $I,%rax",0,"\x0d",1,0x48,0,2|8,0);
 ins_add("or $I,%Q1",0,"\x83",1,0x48,0x08,(2|0|32)|1,0);
 ins_add("or $I,%W1","\x66","\x81",1,0,0x08,(2|4|32)|1|128,0);
 ins_add("or $I,%ax","\x66","\x0d",1,0,0,2|4|128,0);
 ins_add("or $I,%W1","\x66","\x83",1,0,0x08,(2|0|32)|1,0);
 ins_add("or $I,%B1",0,"\x80",1,0,0x08,(2|0|32)|1|128,0);
 ins_add("or $I,%al",0,"\x0c",1,0,0,2|0|128,0);
 ins_add("orl $I,ADDR",0,"\x81",1,0,0x08,(2|8|16)|128,0);
 ins_add("orl $I,ADDR",0,"\x83",1,0,0x08,(2|0|16),0);
 ins_add("orq $I,ADDR",0,"\x81",1,0x48,0x08,(2|8|16),0);
 ins_add("orq $I,ADDR",0,"\x83",1,0x48,0x08,(2|0|16),0);
 ins_add("orw $I,ADDR","\x66","\x81",1,0,0x08,(2|4|16)|128,0);
 ins_add("orw $I,ADDR","\x66","\x83",1,0,0x08,(2|0|16),0);
 ins_add("orb $I,ADDR",0,"\x80",1,0,0x08,(2|0|16)|128,0);
 ins_add("or %L2,ADDR",0,"\x09",1,0,0,(64|16),0);
 ins_add("or ADDR,%L2",0,"\x0b",1,0,0,(64|16),0);
 ins_add("or %Q2,ADDR",0,"\x09",1,0x48,0,(64|16),0);
 ins_add("or ADDR,%Q2",0,"\x0b",1,0x48,0,(64|16),0);
 ins_add("or %W2,ADDR","\x66","\x09",1,0,0,(64|16),0);
 ins_add("or ADDR,%W2","\x66","\x0b",1,0,0,(64|16),0);
 ins_add("or %B2,ADDR",0,"\x08",1,0,0,(64|16),0);
 ins_add("or ADDR,%B2",0,"\x0a",1,0,0,(64|16),0);
 
 ins_add("xor %L2,%L1",0,"\x31",1,0,0,(32|64)|1,0);
 ins_add("xor %Q2,%Q1",0,"\x31",1,0x48,0,(32|64)|1,0);
 ins_add("xor %W2,%W1","\x66","\x31",1,0,0,(32|64)|1,0);
 ins_add("xor %B2,%B1",0,"\x30",1,0,0,(32|64)|1,0);
 ins_add("xor $I,%L1",0,"\x81",1,0,0x30,(2|8|32)|1|128,0);
 ins_add("xor $I,%eax",0,"\x35",1,0,0,2|8|128,0);
 ins_add("xor $I,%L1",0,"\x83",1,0,0x30,(2|0|32)|1,0);
 ins_add("xor $I,%Q1",0,"\x81",1,0x48,0x30,(2|8|32)|1,0);
 ins_add("xor $I,%rax",0,"\x35",1,0x48,0,2|8,0);
 ins_add("xor $I,%Q1",0,"\x83",1,0x48,0x30,(2|0|32)|1,0);
 ins_add("xor $I,%W1","\x66","\x81",1,0,0x30,(2|4|32)|1|128,0);
 ins_add("xor $I,%ax","\x66","\x35",1,0,0,2|4|128,0);
 ins_add("xor $I,%W1","\x66","\x83",1,0,0x30,(2|0|32)|1,0);
 ins_add("xor $I,%B1",0,"\x80",1,0,0x30,(2|0|32)|1|128,0);
 ins_add("xor $I,%al",0,"\x34",1,0,0,2|0|128,0);
 ins_add("xorl $I,ADDR",0,"\x81",1,0,0x30,(2|8|16)|128,0);
 ins_add("xorl $I,ADDR",0,"\x83",1,0,0x30,(2|0|16),0);
 ins_add("xorq $I,ADDR",0,"\x81",1,0x48,0x30,(2|8|16),0);
 ins_add("xorq $I,ADDR",0,"\x83",1,0x48,0x30,(2|0|16),0);
 ins_add("xorw $I,ADDR","\x66","\x81",1,0,0x30,(2|4|16)|128,0);
 ins_add("xorw $I,ADDR","\x66","\x83",1,0,0x30,(2|0|16),0);
 ins_add("xorb $I,ADDR",0,"\x80",1,0,0x30,(2|0|16)|128,0);
 ins_add("xor %L2,ADDR",0,"\x31",1,0,0,(64|16),0);
 ins_add("xor ADDR,%L2",0,"\x33",1,0,0,(64|16),0);
 ins_add("xor %Q2,ADDR",0,"\x31",1,0x48,0,(64|16),0);
 ins_add("xor ADDR,%Q2",0,"\x33",1,0x48,0,(64|16),0);
 ins_add("xor %W2,ADDR","\x66","\x31",1,0,0,(64|16),0);
 ins_add("xor ADDR,%W2","\x66","\x33",1,0,0,(64|16),0);
 ins_add("xor %B2,ADDR",0,"\x30",1,0,0,(64|16),0);
 ins_add("xor ADDR,%B2",0,"\x32",1,0,0,(64|16),0);
 
 ins_add("btc $I,%L1",0,"\x0f\xba",2,0,0x38,(2|0|32)|1,0);
 ins_add("btc $I,%Q1",0,"\x0f\xba",2,0x48,0x38,(2|0|32)|1,0);
}
void ins_init_xchg(void)
{
 ins_add("xchg %L2,%L1",0,"\x87",1,0,0,(32|64)|1,0);
 ins_add("xchg %eax,%ecx",0,"\x91",1,0,0,0,0);
 ins_add("xchg %eax,%edx",0,"\x92",1,0,0,0,0);
 ins_add("xchg %eax,%ebx",0,"\x93",1,0,0,0,0);
 ins_add("xchg %eax,%esp",0,"\x94",1,0,0,0,0);
 ins_add("xchg %eax,%ebp",0,"\x95",1,0,0,0,0);
 ins_add("xchg %eax,%esi",0,"\x96",1,0,0,0,0);
 ins_add("xchg %eax,%edi",0,"\x97",1,0,0,0,0);
 ins_add("xchg %eax,%r8d",0,"\x90",1,0x41,0,0,0);
 ins_add("xchg %eax,%r9d",0,"\x91",1,0x41,0,0,0);
 ins_add("xchg %eax,%r10d",0,"\x92",1,0x41,0,0,0);
 ins_add("xchg %eax,%r11d",0,"\x93",1,0x41,0,0,0);
 ins_add("xchg %eax,%r12d",0,"\x94",1,0x41,0,0,0);
 ins_add("xchg %eax,%r13d",0,"\x95",1,0x41,0,0,0);
 ins_add("xchg %eax,%r14d",0,"\x96",1,0x41,0,0,0);
 ins_add("xchg %eax,%r15d",0,"\x97",1,0x41,0,0,0);
 ins_add("xchg %ecx,%eax",0,"\x91",1,0,0,0,0);
 ins_add("xchg %edx,%eax",0,"\x92",1,0,0,0,0);
 ins_add("xchg %ebx,%eax",0,"\x93",1,0,0,0,0);
 ins_add("xchg %esp,%eax",0,"\x94",1,0,0,0,0);
 ins_add("xchg %ebp,%eax",0,"\x95",1,0,0,0,0);
 ins_add("xchg %esi,%eax",0,"\x96",1,0,0,0,0);
 ins_add("xchg %edi,%eax",0,"\x97",1,0,0,0,0);
 ins_add("xchg %r8d,%eax",0,"\x90",1,0x41,0,0,0);
 ins_add("xchg %r9d,%eax",0,"\x91",1,0x41,0,0,0);
 ins_add("xchg %r10d,%eax",0,"\x92",1,0x41,0,0,0);
 ins_add("xchg %r11d,%eax",0,"\x93",1,0x41,0,0,0);
 ins_add("xchg %r12d,%eax",0,"\x94",1,0x41,0,0,0);
 ins_add("xchg %r13d,%eax",0,"\x95",1,0x41,0,0,0);
 ins_add("xchg %r14d,%eax",0,"\x96",1,0x41,0,0,0);
 ins_add("xchg %r15d,%eax",0,"\x97",1,0x41,0,0,0);
 ins_add("xchg %eax,%eax",0,"\x87\xc0",2,0,0,0,0);
 
 ins_add("xchg %Q2,%Q1",0,"\x87",1,0x48,0,(32|64)|1,0);
 ins_add("xchg %rax,%rcx",0,"\x91",1,0x48,0,0,0);
 ins_add("xchg %rax,%rdx",0,"\x92",1,0x48,0,0,0);
 ins_add("xchg %rax,%rbx",0,"\x93",1,0x48,0,0,0);
 ins_add("xchg %rax,%rsp",0,"\x94",1,0x48,0,0,0);
 ins_add("xchg %rax,%rbp",0,"\x95",1,0x48,0,0,0);
 ins_add("xchg %rax,%rsi",0,"\x96",1,0x48,0,0,0);
 ins_add("xchg %rax,%rdi",0,"\x97",1,0x48,0,0,0);
 ins_add("xchg %rax,%r8",0,"\x90",1,0x49,0,0,0);
 ins_add("xchg %rax,%r9",0,"\x91",1,0x49,0,0,0);
 ins_add("xchg %rax,%r10",0,"\x92",1,0x49,0,0,0);
 ins_add("xchg %rax,%r11",0,"\x93",1,0x49,0,0,0);
 ins_add("xchg %rax,%r12",0,"\x94",1,0x49,0,0,0);
 ins_add("xchg %rax,%r13",0,"\x95",1,0x49,0,0,0);
 ins_add("xchg %rax,%r14",0,"\x96",1,0x49,0,0,0);
 ins_add("xchg %rax,%r15",0,"\x97",1,0x49,0,0,0);
 ins_add("xchg %rcx,%rax",0,"\x91",1,0x48,0,0,0);
 ins_add("xchg %rdx,%rax",0,"\x92",1,0x48,0,0,0);
 ins_add("xchg %rbx,%rax",0,"\x93",1,0x48,0,0,0);
 ins_add("xchg %rsp,%rax",0,"\x94",1,0x48,0,0,0);
 ins_add("xchg %rbp,%rax",0,"\x95",1,0x48,0,0,0);
 ins_add("xchg %rsi,%rax",0,"\x96",1,0x48,0,0,0);
 ins_add("xchg %rdi,%rax",0,"\x97",1,0x48,0,0,0);
 ins_add("xchg %r8,%rax",0,"\x90",1,0x49,0,0,0);
 ins_add("xchg %r9,%rax",0,"\x91",1,0x49,0,0,0);
 ins_add("xchg %r10,%rax",0,"\x92",1,0x49,0,0,0);
 ins_add("xchg %r11,%rax",0,"\x93",1,0x49,0,0,0);
 ins_add("xchg %r12,%rax",0,"\x94",1,0x49,0,0,0);
 ins_add("xchg %r13,%rax",0,"\x95",1,0x49,0,0,0);
 ins_add("xchg %r14,%rax",0,"\x96",1,0x49,0,0,0);
 ins_add("xchg %r15,%rax",0,"\x97",1,0x49,0,0,0);
 ins_add("xchg %rax,%rax",0,"\x87\xc0",2,0x48,0,0,0);
 
 ins_add("xchg %W2,%W1","\x66","\x87",1,0,0,(32|64)|1,0);
 ins_add("xchg %ax,%cx","\x66","\x91",1,0,0,0,0);
 ins_add("xchg %ax,%dx","\x66","\x92",1,0,0,0,0);
 ins_add("xchg %ax,%bx","\x66","\x93",1,0,0,0,0);
 ins_add("xchg %ax,%sp","\x66","\x94",1,0,0,0,0);
 ins_add("xchg %ax,%bp","\x66","\x95",1,0,0,0,0);
 ins_add("xchg %ax,%si","\x66","\x96",1,0,0,0,0);
 ins_add("xchg %ax,%di","\x66","\x97",1,0,0,0,0);
 ins_add("xchg %ax,%r8w","\x66","\x90",1,0x41,0,0,0);
 ins_add("xchg %ax,%r9w","\x66","\x91",1,0x41,0,0,0);
 ins_add("xchg %ax,%r10w","\x66","\x92",1,0x41,0,0,0);
 ins_add("xchg %ax,%r11w","\x66","\x93",1,0x41,0,0,0);
 ins_add("xchg %ax,%r12w","\x66","\x94",1,0x41,0,0,0);
 ins_add("xchg %ax,%r13w","\x66","\x95",1,0x41,0,0,0);
 ins_add("xchg %ax,%r14w","\x66","\x96",1,0x41,0,0,0);
 ins_add("xchg %ax,%r15w","\x66","\x97",1,0x41,0,0,0);
 ins_add("xchg %cx,%ax","\x66","\x91",1,0,0,0,0);
 ins_add("xchg %dx,%ax","\x66","\x92",1,0,0,0,0);
 ins_add("xchg %bx,%ax","\x66","\x93",1,0,0,0,0);
 ins_add("xchg %sp,%ax","\x66","\x94",1,0,0,0,0);
 ins_add("xchg %bp,%ax","\x66","\x95",1,0,0,0,0);
 ins_add("xchg %si,%ax","\x66","\x96",1,0,0,0,0);
 ins_add("xchg %di,%ax","\x66","\x97",1,0,0,0,0);
 ins_add("xchg %r8w,%ax","\x66","\x90",1,0x41,0,0,0);
 ins_add("xchg %r9w,%ax","\x66","\x91",1,0x41,0,0,0);
 ins_add("xchg %r10w,%ax","\x66","\x92",1,0x41,0,0,0);
 ins_add("xchg %r11w,%ax","\x66","\x93",1,0x41,0,0,0);
 ins_add("xchg %r12w,%ax","\x66","\x94",1,0x41,0,0,0);
 ins_add("xchg %r13w,%ax","\x66","\x95",1,0x41,0,0,0);
 ins_add("xchg %r14w,%ax","\x66","\x96",1,0x41,0,0,0);
 ins_add("xchg %r15w,%ax","\x66","\x97",1,0x41,0,0,0);
 ins_add("xchg %ax,%ax","\x66","\x87\xc0",2,0,0,0,0);
 
 ins_add("xchg %B2,%B1",0,"\x86",1,0,0,(32|64)|1,0);
 
 ins_add("xchg %L2,ADDR",0,"\x87",1,0,0,(64|16),0);
 ins_add("xchg ADDR,%L2",0,"\x87",1,0,0,(64|16),0);
 ins_add("xchg %Q2,ADDR",0,"\x87",1,0x48,0,(64|16),0);
 ins_add("xchg ADDR,%Q2",0,"\x87",1,0x48,0,(64|16),0);
 ins_add("xchg %W2,ADDR","\x66","\x87",1,0,0,(64|16),0);
 ins_add("xchg ADDR,%W2","\x66","\x87",1,0,0,(64|16),0);
 ins_add("xchg %B2,ADDR",0,"\x86",1,0,0,(64|16),0);
 ins_add("xchg ADDR,%B2",0,"\x86",1,0,0,(64|16),0);
 
 ins_add("xadd %L2,ADDR",0,"\x0f\xc1",2,0,0,(64|16),0);
}
void ins_init_io(void)
{
 ins_add("in $I,%al",0,"\xe4",1,0,0,2|0|128,0);
 ins_add("out %al,$I",0,"\xe6",1,0,0,2|0|128,0);
}
void ins_init_system(void)
{
 ins_add("int $I",0,"\xcd",1,0,0,2|0|128,0);
 ins_add("int3",0,"\xcc",1,0,0,0,0);
 ins_add("syscall",0,"\x0f\x05",2,0,0,0,0);
 ins_add("cli",0,"\xfa",1,0,0,0,0);
 ins_add("sti",0,"\xfb",1,0,0,0,0);
 ins_add("hlt",0,"\xf4",1,0,0,0,0);
 ins_add("lgdt ADDR",0,"\x0f\x01",2,0,0x10,16,0);
 ins_add("lidt ADDR",0,"\x0f\x01",2,0,0x18,16,0);
 ins_add("ltr %W1",0,"\x0f\x00",2,0,0xd8,32|1,0);
 ins_add("mov %C2,%Q1",0,"\x0f\x20",2,0,0,(32|64)|1,0);
 ins_add("mov %Q1,%C2",0,"\x0f\x22",2,0,0,(32|64)|1,0);
 ins_add("iretq",0,"\xcf",1,0x48,0,0,0);
 ins_add("lretq",0,"\xcb",1,0x48,0,0,0);
 ins_add("rdmsr",0,"\x0f\x32",2,0,0,0,0);
 ins_add("wrmsr",0,"\x0f\x30",2,0,0,0,0);
 ins_add("cpuid",0,"\x0f\xa2",2,0,0,0,0);
 ins_add("pushfq",0,"\x9c",1,0,0,0,0);
 ins_add("popfq",0,"\x9d",1,0,0,0,0);
}
void ins_init_fpu(void)
{
 ins_add("fldl ADDR",0,"\xdd",1,0,0,16,0);
 ins_add("fstpl ADDR",0,"\xdd",1,0,0x18,16,0);
 ins_add("flds ADDR",0,"\xd9",1,0,0,16,0);
 ins_add("fstps ADDR",0,"\xd9",1,0,0x18,16,0);
 ins_add("fildq ADDR",0,"\xdf",1,0,0x28,16,0);
 ins_add("fistpq ADDR",0,"\xdf",1,0,0x38,16,0);
 ins_add("faddp",0,"\xde\xc1",2,0,0,0,0);
 ins_add("fsubp",0,"\xde\xe1",2,0,0,0,0);
 ins_add("fsubrp",0,"\xde\xe9",2,0,0,0,0);
 ins_add("fmulp",0,"\xde\xc9",2,0,0,0,0);
 ins_add("fdivp",0,"\xde\xf1",2,0,0,0,0);
 ins_add("fdivrp",0,"\xde\xf9",2,0,0,0,0);
 ins_add("fcomip",0,"\xdf\xf1",2,0,0,0,0);
 ins_add("fchs",0,"\xd9\xe0",2,0,0,0,0);
}
void ins_init_sse(void)
{
 ins_add("movups %X1,%X2",0,"\x0f\x10",2,0,0,(32|64)|1,0);
 ins_add("movups ADDR,%X2",0,"\x0f\x10",2,0,0,(64|16),0);
 ins_add("movups %X2,ADDR",0,"\x0f\x11",2,0,0,(64|16),0);
 ins_add("movq %Q1,%X2","\x66","\x0f\x6e",2,0x48,0,(32|64)|1,0);
 ins_add("movq %X2,%Q1","\x66","\x0f\x7e",2,0x48,0,(32|64)|1,0);
 ins_add("movd %L1,%X2","\x66","\x0f\x6e",2,0,0,(32|64)|1,0);
 ins_add("movd %X2,%L1","\x66","\x0f\x7e",2,0,0,(32|64)|1,0);
 ins_add("addsd %X1,%X2","\xf2","\x0f\x58",2,0,0,(32|64)|1,0);
 ins_add("addsd ADDR,%X2","\xf2","\x0f\x58",2,0,0,(64|16),0);
 ins_add("subsd %X1,%X2","\xf2","\x0f\x5c",2,0,0,(32|64)|1,0);
 ins_add("subsd ADDR,%X2","\xf2","\x0f\x5c",2,0,0,(64|16),0);
 ins_add("mulsd %X1,%X2","\xf2","\x0f\x59",2,0,0,(32|64)|1,0);
 ins_add("mulsd ADDR,%X2","\xf2","\x0f\x59",2,0,0,(64|16),0);
 ins_add("divsd %X1,%X2","\xf2","\x0f\x5e",2,0,0,(32|64)|1,0);
 ins_add("divsd ADDR,%X2","\xf2","\x0f\x5e",2,0,0,(64|16),0);
 ins_add("comisd %X1,%X2","\x66","\x0f\x2f",2,0,0,(32|64)|1,0);
 ins_add("addss %X1,%X2","\xf3","\x0f\x58",2,0,0,(32|64)|1,0);
 ins_add("addss ADDR,%X2","\xf3","\x0f\x58",2,0,0,(64|16),0);
 ins_add("subss %X1,%X2","\xf3","\x0f\x5c",2,0,0,(32|64)|1,0);
 ins_add("subss ADDR,%X2","\xf3","\x0f\x5c",2,0,0,(64|16),0);
 ins_add("mulss %X1,%X2","\xf3","\x0f\x59",2,0,0,(32|64)|1,0);
 ins_add("mulss ADDR,%X2","\xf3","\x0f\x59",2,0,0,(64|16),0);
 ins_add("divss %X1,%X2","\xf3","\x0f\x5e",2,0,0,(32|64)|1,0);
 ins_add("divss ADDR,%X2","\xf3","\x0f\x5e",2,0,0,(64|16),0);
 ins_add("comiss %X1,%X2",0,"\x0f\x2f",2,0,0,(32|64)|1,0);
 ins_add("movsd %X2,ADDR","\xf2","\x0f\x11",2,0,0,(64|16),0);
 ins_add("movsd ADDR,%X2","\xf2","\x0f\x10",2,0,0,(64|16),0);
 ins_add("movsd %X1,%X2","\xf2","\x0f\x10",2,0,0,(32|64)|1,0);
 ins_add("movss %X2,ADDR","\xf3","\x0f\x11",2,0,0,(64|16),0);
 ins_add("movss ADDR,%X2","\xf3","\x0f\x10",2,0,0,(64|16),0);
 ins_add("movss %X1,%X2","\xf3","\x0f\x10",2,0,0,(32|64)|1,0);
 ins_add("cmpsd $I,%X1,%X2","\xf2","\x0f\xc2",2,0,0,(32|64)|1|2|0,0);
 ins_add("addpd %X1,%X2","\x66","\x0f\x58",2,0,0,(32|64)|1,0);
 ins_add("subpd %X1,%X2","\x66","\x0f\x5c",2,0,0,(32|64)|1,0);
 ins_add("mulpd %X1,%X2","\x66","\x0f\x59",2,0,0,(32|64)|1,0);
 ins_add("divpd %X1,%X2","\x66","\x0f\x5e",2,0,0,(32|64)|1,0);
 ins_add("maxpd ADDR,%X2","\x66","\x0f\x5f",2,0,0,(64|16),0);
 ins_add("minpd ADDR,%X2","\x66","\x0f\x5d",2,0,0,(64|16),0);
 ins_add("maxsd %X1,%X2","\xf2","\x0f\x5f",2,0,0,(32|64)|1,0);
 ins_add("minsd %X1,%X2","\xf2","\x0f\x5d",2,0,0,(32|64)|1,0);
 ins_add("maxpd %X1,%X2","\x66","\x0f\x5f",2,0,0,(32|64)|1,0);
 ins_add("minpd %X1,%X2","\x66","\x0f\x5d",2,0,0,(32|64)|1,0);
 ins_add("cmpss $I,%X1,%X2","\xf3","\x0f\xc2",2,0,0,(32|64)|1|2|0,0);
 ins_add("addps %X1,%X2",0,"\x0f\x58",2,0,0,(32|64)|1,0);
 ins_add("subps %X1,%X2",0,"\x0f\x5c",2,0,0,(32|64)|1,0);
 ins_add("mulps %X1,%X2",0,"\x0f\x59",2,0,0,(32|64)|1,0);
 ins_add("divps %X1,%X2",0,"\x0f\x5e",2,0,0,(32|64)|1,0);
 ins_add("maxps ADDR,%X2",0,"\x0f\x5f",2,0,0,(64|16),0);
 ins_add("minps ADDR,%X2",0,"\x0f\x5d",2,0,0,(64|16),0);
 ins_add("maxss %X1,%X2",0,"\x0f\x5f",2,0,0,(32|64)|1,0);
 ins_add("minss %X1,%X2",0,"\x0f\x5d",2,0,0,(32|64)|1,0);
 ins_add("maxps %X1,%X2",0,"\x0f\x5f",2,0,0,(32|64)|1,0);
 ins_add("minps %X1,%X2",0,"\x0f\x5d",2,0,0,(32|64)|1,0);
 ins_add("addpd ADDR,%X2","\x66","\x0f\x58",2,0,0,(64|16),0);
 ins_add("subpd ADDR,%X2","\x66","\x0f\x5c",2,0,0,(64|16),0);
 ins_add("mulpd ADDR,%X2","\x66","\x0f\x59",2,0,0,(64|16),0);
 ins_add("divpd ADDR,%X2","\x66","\x0f\x5e",2,0,0,(64|16),0);
 ins_add("addps ADDR,%X2",0,"\x0f\x58",2,0,0,(64|16),0);
 ins_add("subps ADDR,%X2",0,"\x0f\x5c",2,0,0,(64|16),0);
 ins_add("mulps ADDR,%X2",0,"\x0f\x59",2,0,0,(64|16),0);
 ins_add("divps ADDR,%X2",0,"\x0f\x5e",2,0,0,(64|16),0);
 ins_add("cvtss2sd %X1,%X2","\xf3","\x0f\x5a",2,0,0,(32|64)|1,0);
 ins_add("cvtsd2ss %X1,%X2","\xf2","\x0f\x5a",2,0,0,(32|64)|1,0);
 ins_add("cvtsi2ss %L1,%X2","\xf3","\x0f\x2a",2,0,0,(32|64)|1,0);
 ins_add("cvtss2si %X1,%L2","\xf3","\x0f\x2d",2,0,0,(32|64)|1,0);
 ins_add("cvtsi2ss %Q1,%X2","\xf3","\x0f\x2a",2,0x48,0,(32|64)|1,0);
 ins_add("cvtss2si %X1,%Q2","\xf3","\x0f\x2d",2,0x48,0,(32|64)|1,0);
 ins_add("cvtsi2sd %L1,%X2","\xf2","\x0f\x2a",2,0,0,(32|64)|1,0);
 ins_add("cvtsd2si %X1,%L2","\xf2","\x0f\x2d",2,0,0,(32|64)|1,0);
 ins_add("cvtsi2sd %Q1,%X2","\xf2","\x0f\x2a",2,0x48,0,(32|64)|1,0);
 ins_add("cvtsd2si %X1,%Q2","\xf2","\x0f\x2d",2,0x48,0,(32|64)|1,0);
 ins_add("shufps $I,%X1,%X2",0,"\x0f\xc6",2,0,0,(32|64)|1|2|0,0);
 ins_add("cmppd $I,%X1,%X2","\x66","\x0f\xc2",2,0,0,(32|64)|1|2|0,0);
 ins_add("cmpps $I,%X1,%X2",0,"\x0f\xc2",2,0,0,(32|64)|1|2|0,0);
 ins_add("cmppd $I,ADDR,%X2","\x66","\x0f\xc2",2,0,0,(64|16)|2|0,0);
 ins_add("cmpps $I,ADDR,%X2",0,"\x0f\xc2",2,0,0,(64|16)|2|0,0);
 ins_add("cmpsd $I,ADDR,%X2","\xf3","\x0f\xc2",2,0,0,(64|16)|2|0,0);
 ins_add("cmpss $I,ADDR,%X2","\xf2","\x0f\xc2",2,0,0,(64|16)|2|0,0);
 ins_add("andps %X1,%X2",0,"\x0f\x54",2,0,0,(32|64)|1,0);
 ins_add("orps %X1,%X2",0,"\x0f\x56",2,0,0,(32|64)|1,0);
}
void ins_init_avx(void)
{
 ins_add("vmovups ADDR,%Y2",0,"\xc5\xfc\x10",3,0,0,(64|16),0);
 ins_add("vmovups %Y2,ADDR",0,"\xc5\xfc\x11",3,0,0,(64|16),0);
}
void ins_write(char *input)
{
 struct ins *ins;
 struct ins_args args;
 char *p,*word;
 int hash;
 hash=format_hash(input);
 word=read_word(&input);
 hash+=name_hash(word);
 hash=hash%1021;
 ins=ins_list[hash];
 while(ins)
 {
 if(!strcmp(ins->name,word))
 {
 if(!get_ins_args(input,ins->format,&args))
 {
 if(ins->special_handler)
 {
 if(!ins->special_handler(ins->opcode,&args))
 {
 free(word);
 return;
 }
 }
 else
 {
 if(!write_default_ins(ins,&args))
 {
 free(word);
 return;
 }
 }
 }
 }
 ins=ins->next;
 }
 error(l->line,"unknown instruction.");
}
void ins_init(void)
{
 ins_add("nop",0,"\x90",1,0,0,0,0);
 ins_init_mov();
 ins_init_jmp();
 ins_init_basic_op();
 ins_init_xchg();
 ins_init_io();
 ins_init_system();
 ins_init_fpu();
 ins_init_sse();
 ins_init_avx();
}
void parse_pseudo_op(char *str)
{
 char *word,*p,c;
 unsigned long int val;
 if(str_match(&str,"string"))
 {
 word=read_word(&str);
 if(*word!='\"')
 {
 error(l->line,"expected string after \'.string\'.");
 }
 p=word+1;
 while(*p!='\"')
 {
 p=sgetc(p,&c);
 soutc(c);
 }
 free(word);
 soutc(0);
 }
 else if(str_match(&str,"entry"))
 {
 l->needs_recompile=1;
 elf_header.entry=pc;
 }
 else if(str_match(&str,"datasize"))
 {
 word=read_word(&str);
 if(word)
 {
 data_size=const_to_num(word);
 free(word);
 }
 }
 else if(str_match(&str,"byte"))
 {
 do
 {
 if(parse_const(&str,&val)==-1)
 {
 error(l->line,"invalid constant expression.");
 }
 swrite(&val,1);
 }
 while(str_match(&str,","));
 }
 else if(str_match(&str,"word"))
 {
 do
 {
 if(parse_const(&str,&val)==-1)
 {
 error(l->line,"invalid constant expression.");
 }
 swrite(&val,2);
 }
 while(str_match(&str,","));
 }
 else if(str_match(&str,"long"))
 {
 do
 {
 if(parse_const(&str,&val)==-1)
 {
 error(l->line,"invalid constant expression.");
 }
 swrite(&val,4);
 }
 while(str_match(&str,","));
 }
 else if(str_match(&str,"quad"))
 {
 do
 {
 if(parse_const(&str,&val)==-1)
 {
 error(l->line,"invalid constant expression.");
 }
 swrite(&val,8);
 }
 while(str_match(&str,","));
 }
 else if(str_match(&str,"offset"))
 {
 word=read_word(&str);
 if(word)
 {
 val=const_to_num(word);
 free(word);
 if(val<spos)
 {
 error(l->line,"invalid offset.");
 }
 while(val!=spos)
 {
 soutc(0);
 }
 l->needs_recompile=1;
 }
 }
 else if(str_match(&str,"addr"))
 {
 word=read_word(&str);
 if(word)
 {
 val=const_to_num(word);
 free(word);
 pc=val;
 l->needs_recompile=1;
 }
 }
 else if(str_match(&str,"dataaddr"))
 {
 word=read_word(&str);
 if(word)
 {
 data_addr=const_to_num(word);
 }
 }
 else if(str_match(&str,"align"))
 {
 word=read_word(&str);
 if(word)
 {
 val=const_to_num(word);
 if(val<20)
 {
 while((1<<val)-1&spos)
 {
 soutc(0);
 }
 l->needs_recompile=1;
 }
 }
 }
 else
 {
 error(l->line,"unknown pseudo-op.");
 }
}
int main(int argc,char **argv)
{
 char *str,*word;
 struct label *label;
 int s,n;
 struct lines *l_head,*l_end;
 long int ins_size;
 if(argc<3)
 {
 __syscall((long)(1),(long)(1),(long)("Usage: asm <input> <output> [addrmap]\n"),(long)(38),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 fdi=__syscall((long)(2),(long)(argv[1]),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fdi<0)
 {
 __syscall((long)(1),(long)(1),(long)("Cannot open input file\n"),(long)(23),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 fdo=__syscall((long)(2),(long)(argv[2]),(long)(578),(long)(0755),(long)(0),(long)(0),(long)(0));
 if(fdo<0)
 {
 __syscall((long)(1),(long)(1),(long)("Cannot open output file\n"),(long)(24),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 if(argc>=4)
 {
 fde=__syscall((long)(2),(long)(argv[3]),(long)(578),(long)(0644),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 fde=-1;
 }
 data_addr=0x20000000;
 load_file();
 elf_header.entry=0;
 pc=0x100b0;
 ins_init();
 l_head=0;
 l_end=0;
 ins_size=0;
 spos=0;
 l=lines_head;
 while(l)
 {
 str=skip_spaces(l->str);
 l->ins_len=0;
 l->ins_buf2=0;
 l->needs_recompile=0;
 if(*str&&*str!='#')
 {
 if(*str=='.')
 {
 parse_pseudo_op(str+1);
 }
 else if(*str=='@')
 {
 ++str;
 word=read_word(&str);
 if(label_tab_find(word))
 {
 error(l->line,"label redefined.");
 }
 label_tab_add(word);
 l->needs_recompile=1;
 }
 else
 {
 ins_write(str);
 }
 }
 l=l->next;
 }
 stage=1;
 do
 {
 s=0;
 n=0;
 spos=0;
 elf_header.entry=0;
 pc=0x100b0;
 l=lines_head;
 while(l)
 {
 l->ins_pos=pc;
 if(l->needs_recompile)
 {
 str=skip_spaces(l->str);
 if(*str=='@')
 {
 ++str;
 word=read_word(&str);
 if(label=label_tab_find(word))
 {
 if(label->value!=pc)
 {
 label->value=pc;
 s=1;
 }
 }
 free(word);
 }
 else
 {
 l->ins_len=0;
 free(l->ins_buf2);
 l->ins_buf2=0;
 if(*str=='.')
 {
 parse_pseudo_op(str+1);
 }
 else
 {
 ins_write(str);
 }
 }
 }
 else
 {
 pc+=l->ins_len;
 spos+=l->ins_len;
 }
 l=l->next;
 ++n;
 }
 }
 while(s);
 l=lines_head;
 spos=0;
 while(l)
 {
 spos+=l->ins_len;
 l=l->next;
 }
 mkelf();
 __syscall((long)(3),(long)(fdi),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(3),(long)(fdo),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fde>=0)
 {
 __syscall((long)(3),(long)(fde),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 return 0;
}
namespace;
 
int exec_cmd(char *s,int size)
{
 char *arg[1030];
 int x;
 if(s[0]=='#')
 {
 return 0;
 }
 __syscall((long)(1),(long)(1),(long)(s),(long)(strlen(s)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\n"),(long)(1),(long)(0),(long)(0),(long)(0));
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
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 pid=__syscall((long)(57),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(pid==0)
 {
 if(__syscall((long)(81),(long)(project_dir_fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 signal(2,((void *)0));
 signal(3,((void *)0));
 signal(20,((void *)0));
 unblock_sigwinch();
 __syscall((long)(231),(long)(scpp__main(x,arg)),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else if(pid>0)
 {
 waitpid(pid,&ret,0);
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 return ret;
 }
 if(!strcmp(arg[0],"scc"))
 {
 int pid;
 int ret;
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 pid=__syscall((long)(57),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(pid==0)
 {
 if(__syscall((long)(81),(long)(project_dir_fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 signal(2,((void *)0));
 signal(3,((void *)0));
 signal(20,((void *)0));
 unblock_sigwinch();
 __syscall((long)(231),(long)(scc__main(x,arg)),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else if(pid>0)
 {
 waitpid(pid,&ret,0);
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 return ret;
 }
 if(!strcmp(arg[0],"asm"))
 {
 int pid;
 int ret;
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 pid=__syscall((long)(57),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(pid==0)
 {
 if(__syscall((long)(81),(long)(project_dir_fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 signal(2,((void *)0));
 signal(3,((void *)0));
 signal(20,((void *)0));
 unblock_sigwinch();
 __syscall((long)(231),(long)(assembler__main(x,arg)),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else if(pid>0)
 {
 waitpid(pid,&ret,0);
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 return ret;
 }
 if(!strcmp(arg[0],"mkdir"))
 {
 int pid;
 int ret;
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 pid=__syscall((long)(57),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(pid==0)
 {
 if(__syscall((long)(81),(long)(project_dir_fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 signal(2,((void *)0));
 signal(3,((void *)0));
 signal(20,((void *)0));
 unblock_sigwinch();
 
 int ret,x1;
 if(x<2)
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 x1=1;
 while(x1<x)
 {
 while(*arg[x1]=='/')
 {
 ++arg[x1];
 }
 ret=__syscall((long)(83),(long)(arg[x1]),(long)(0755),(long)(0),(long)(0),(long)(0),(long)(0));
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
 __syscall((long)(231),(long)(ret),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else if(pid>0)
 {
 waitpid(pid,&ret,0);
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 return ret;
 }
 if(!strcmp(arg[0],"rename"))
 {
 int pid;
 int ret;
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 pid=__syscall((long)(57),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(pid==0)
 {
 if(__syscall((long)(81),(long)(project_dir_fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 signal(2,((void *)0));
 signal(3,((void *)0));
 signal(20,((void *)0));
 unblock_sigwinch();
 
 if(x<3)
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 while(*arg[1]=='/')
 {
 ++arg[1];
 }
 while(*arg[2]=='/')
 {
 ++arg[2];
 }
 if(*arg[1]==0||*arg[2]==0)
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 ret=__syscall((long)(82),(long)(arg[1]),(long)(arg[2]),(long)(0),(long)(0),(long)(0),(long)(0));
 __syscall((long)(231),(long)(ret),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else if(pid>0)
 {
 waitpid(pid,&ret,0);
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 return ret;
 }
 if(!strcmp(arg[0],"remove"))
 {
 int pid;
 int ret;
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 pid=__syscall((long)(57),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(pid==0)
 {
 if(__syscall((long)(81),(long)(project_dir_fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 signal(2,((void *)0));
 signal(3,((void *)0));
 signal(20,((void *)0));
 unblock_sigwinch();
 
 int x1;
 if(x<2)
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 x1=1;
 while(x1<x)
 {
 remove_file(arg[x1]);
 ++x1;
 }
 __syscall((long)(231),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else if(pid>0)
 {
 waitpid(pid,&ret,0);
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 return ret;
 }
 arg[x]=((void *)0);
 int pid;
 int ret;
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 pid=__syscall((long)(57),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 if(pid==0)
 {
 if(__syscall((long)(81),(long)(project_dir_fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0)))
 {
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 signal(2,((void *)0));
 signal(3,((void *)0));
 signal(20,((void *)0));
 unblock_sigwinch();
 execv(arg[0],arg);
 __syscall((long)(231),(long)(1),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 }
 else if(pid>0)
 {
 waitpid(pid,&ret,0);
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
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
 fd=__syscall((long)(257),(long)(project_dir_fd),(long)("build-script"),(long)(0),(long)(0),(long)(0),(long)(0));
 if(fd>=0)
 {
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 while(1)
 {
 if(buf_x==buf_size)
 {
 buf_x=0;
 buf_size=__syscall((long)(0),(long)(fd),(long)(buf),(long)(1024),(long)(0),(long)(0),(long)(0));
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
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 project_files_load();
 __syscall((long)(1),(long)(1),(long)("\nPress any key to continue\n"),(long)(27),(long)(0),(long)(0),(long)(0));
 getc();
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
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
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 project_files_load();
 __syscall((long)(1),(long)(1),(long)("\nPress any key to continue\n"),(long)(27),(long)(0),(long)(0),(long)(0));
 getc();
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 return 0;
 }
 }
 __syscall((long)(3),(long)(fd),(long)(0),(long)(0),(long)(0),(long)(0),(long)(0));
 project_files_load();
 }
 __syscall((long)(1),(long)(1),(long)("\nPress any key to continue\n"),(long)(27),(long)(0),(long)(0),(long)(0));
 getc();
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 return 0;
 }
 if(c==4283163) 
 {
 if(project_file_x)
 {
 --project_file_x;
 }
 return 0;
 }
 if(c==4348699) 
 {
 ++project_file_x;
 return 0;
 }
 if(c==4479771) 
 {
 project_go_to_parent();
 return 0;
 }
 if(c==4414235) 
 {
 char *name;
 name=project_open_file();
 if(name)
 {
 char *new_file_name;
 struct stat st;
 long pos;
 new_file_name=malloc(strlen(current_path)+strlen(name)+5);
 if(new_file_name)
 {
 strcpy(new_file_name,current_path);
 strcat(new_file_name,name);
 if(__syscall((long)(262),(long)(project_dir_fd),(long)(new_file_name),(long)(&st),(long)(0x100),(long)(0),(long)(0))==0)
 {
 pos=get_edit_cursor_pos(st.dev,st.ino);
 pos=edit__edit_file(new_file_name,pos);
 set_edit_cursor_pos(st.dev,st.ino,pos);
 }
 else
 {
 edit__edit_file(new_file_name,0);
 }
 free(new_file_name);
 }
 }
 return 0;
 }
 if(c=='D'||c=='d')
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("Directory Name: "),(long)(16),(long)(0),(long)(0),(long)(0));
 char dir_name[256];
 char c;
 int i;
 i=0;
 while(__syscall((long)(0),(long)(0),(long)(&c),(long)(1),(long)(0),(long)(0),(long)(0))==1&&c!='\n')
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
 __syscall((long)(258),(long)(project_dir_fd),(long)(new_dir_name),(long)(0755),(long)(0),(long)(0),(long)(0));
 project_files_load();
 project_file_x=0;
 free(new_dir_name);
 }
 }
 
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 0;
 }
 if(c=='F'||c=='f')
 {
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("File Name: "),(long)(11),(long)(0),(long)(0),(long)(0));
 char file_name[256];
 char c;
 int i;
 i=0;
 while(__syscall((long)(0),(long)(0),(long)(&c),(long)(1),(long)(0),(long)(0),(long)(0))==1&&c!='\n')
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
 __syscall((long)(259),(long)(project_dir_fd),(long)(new_file_name),(long)(0100644),(long)(0),(long)(0),(long)(0));
 project_files_load();
 project_file_x=0;
 free(new_file_name);
 }
 }
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 0;
 }
 if(c=='^')
 {
 struct project_file *file;
 char *new_file_name;
 char c[2];
 file=project_file_current();
 if(file==((void *)0))
 {
 return 0;
 }
 if(!strcmp(file->name,"build-script")&&!strcmp(current_path,"./"))
 {
 return 0;
 }
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 new_file_name=malloc(strlen(current_path)+256);
 if(new_file_name)
 {
 strcpy(new_file_name,current_path);
 strcat(new_file_name,file->name);
 if(file->is_dir)
 {
 __syscall((long)(1),(long)(1),(long)("Remove directory (AND ITS CONTENTS) \""),(long)(37),(long)(0),(long)(0),(long)(0));
 }
 else
 {
 __syscall((long)(1),(long)(1),(long)("Remove file \""),(long)(13),(long)(0),(long)(0),(long)(0));
 }
 __syscall((long)(1),(long)(1),(long)(new_file_name),(long)(strlen(new_file_name)),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\" (y/N)? "),(long)(9),(long)(0),(long)(0),(long)(0));
 if(__syscall((long)(0),(long)(0),(long)(c),(long)(2),(long)(0),(long)(0),(long)(0))==2&&(c[0]=='y'||c[0]=='Y')&&c[1]=='\n')
 {
 remove_project_file(new_file_name);
 project_files_load();
 project_file_x=0;
 }
 free(new_file_name);
 }
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&term),(long)(0),(long)(0),(long)(0));
 return 0;
 }
 return 0;
}
void paint_all(void)
{
 int val;
 do
 {
 project_files_display();
 unblock_sigwinch();
 val=winsize_change;
 winsize_change=0;
 block_sigwinch();
 }
 while(val);
}
int main(int argc,char **argv)
{
 int c;
 if(argc<2)
 {
 __syscall((long)(1),(long)(1),(long)("Usage: cuide <ProjectDirectory>\n"),(long)(32),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("If <ProjectDirectory> does not exist, a new project will be created.\n"),(long)(69),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 if(init_project(argv[1]))
 {
 __syscall((long)(1),(long)(1),(long)("Failed to initialize project.\n"),(long)(30),(long)(0),(long)(0),(long)(0));
 return 1;
 }
 project_files_load();
 signal(2,((void *)1));
 signal(3,((void *)1));
 signal(20,((void *)1));
 block_sigwinch();
 signal(28,SH_winch);
 if(__syscall((long)(16),(long)(0),(long)(0x5413),(long)(&winsz),(long)(0),(long)(0),(long)(0)))
 {
 return 1;
 }
 pbuf=malloc(2*2048*2048);
 if(pbuf==((void *)0))
 {
 return 1;
 }
 if(term_init())
 {
 return 1;
 }
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
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
 winsize_change=0;
 memset(pbuf,0,2*(int)winsz.col*(int)winsz.row);
 paint_all();
 display_pbuf();
 }
 __syscall((long)(16),(long)(0),(long)(0x5402),(long)(&old_term),(long)(0),(long)(0),(long)(0));
 __syscall((long)(1),(long)(1),(long)("\033[2J\033[1;1H"),(long)(10),(long)(0),(long)(0),(long)(0));
 return 0;
}
