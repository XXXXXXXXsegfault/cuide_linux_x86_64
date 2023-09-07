#ifndef _PCONTEXT_C_
#define _PCONTEXT_C_
struct pcontext
{
	long rip;
	long gpreg[13];
};
int pcontext_save(struct pcontext *pcontext);
asm "@pcontext_save"
asm "mov 8(%rsp),%rcx"
asm "lea @pcontext_save_rip-@pcontext_l(%rip),%rax"
asm "@pcontext_l"
asm "mov %rax,(%rcx)"
asm "mov %rbx,8(%rcx)"
asm "mov %rsp,16(%rcx)"
asm "mov %rbp,24(%rcx)"
asm "mov %rsi,32(%rcx)"
asm "mov %rdi,40(%rcx)"
asm "mov %r8,48(%rcx)"
asm "mov %r9,56(%rcx)"
asm "mov %r10,64(%rcx)"
asm "mov %r11,72(%rcx)"
asm "mov %r12,80(%rcx)"
asm "mov %r13,88(%rcx)"
asm "mov %r14,96(%rcx)"
asm "mov %r15,104(%rcx)"
asm "xor %eax,%eax"
asm "@pcontext_save_rip"
asm "ret"
void pcontext_restore(struct pcontext *pcontext,int ret);
asm "@pcontext_restore"
asm "mov 16(%rsp),%eax"
asm "mov 8(%rsp),%rcx"
asm "mov 8(%rcx),%rbx"
asm "mov 16(%rcx),%rsp"
asm "mov 24(%rcx),%rbp"
asm "mov 32(%rcx),%rsi"
asm "mov 40(%rcx),%rdi"
asm "mov 48(%rcx),%r8"
asm "mov 56(%rcx),%r9"
asm "mov 64(%rcx),%r10"
asm "mov 72(%rcx),%r11"
asm "mov 80(%rcx),%r12"
asm "mov 88(%rcx),%r13"
asm "mov 96(%rcx),%r14"
asm "mov 104(%rcx),%r15"
asm "jmp *(%rcx)"
#endif
