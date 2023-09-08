@_$MSG1
.string "Usage: bin_to_asm <FILE> <ASMFILE> <TAG>\n"
@_$MSG2
.string "asm \"@"
@_$MSG3
.string "_start\"\n"
@_$MSG4
.string "asm \".byte "
@_$MSG5
.string ","
@_$MSG6
.string "\"\n"
@_$MSG7
.string "asm \"@"
@_$MSG8
.string "_end\"\n"
@_$MSG9
.string "void "
@_$MSG10
.string "_start(void);\n"
@_$MSG11
.string "void "
@_$MSG12
.string "_end(void);\n"
.entry
lea 8(%rsp),%rax
push %rax
pushq 8(%rsp)
call @main
mov %rax,%rdi
mov $231,%eax
syscall
@__syscall
push %rdi
push %rsi
push %rdx
push %r10
push %r11
push %r8
push %r9
mov 64(%rsp),%rax
mov 72(%rsp),%rdi
mov 80(%rsp),%rsi
mov 88(%rsp),%rdx
mov 96(%rsp),%r10
mov 104(%rsp),%r8
mov 112(%rsp),%r9
syscall
pop %r9
pop %r8
pop %r11
pop %r10
pop %rdx
pop %rsi
pop %rdi
ret
@vfork
pop %rdx
mov $58,%eax
syscall
jmp *%rdx
@execv
push %rbp
mov %rsp,%rbp
sub $48,%rsp
push %rbx
push %rsi
mov 24(%rbp),%rsi
push %rdi
mov 16(%rbp),%rdi
mov $0,%rax
mov %rax,18446744073709551600(%rbp)
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
lea 18446744073709551600(%rbp),%rbx
push %rbx
mov %rsi,%rbx
push %rbx
mov %rdi,%rbx
push %rbx
mov $59,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov %rbx,%rax
@execv$END
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@wait
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
mov 16(%rbp),%rsi
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov %rsi,%rbx
push %rbx
mov $18446744073709551615,%rbx
push %rbx
mov $61,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov %rbx,%rax
@wait$END
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@waitpid
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
mov 32(%rbp),%rsi
push %rdi
mov 24(%rbp),%rdi
push %r8
mov 16(%rbp),%r8
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov %esi,%ebx
movslq %ebx,%rbx
push %rbx
mov %rdi,%rbx
push %rbx
mov %r8d,%ebx
movslq %ebx,%rbx
push %rbx
mov $61,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov %rbx,%rax
@waitpid$END
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@sleep
push %rbp
mov %rsp,%rbp
sub $48,%rsp
push %rbx
mov 16(%rbp),%rbx
push %rsi
mov 24(%rbp),%rsi
mov %ebx,%ebx
mov %rbx,18446744073709551600(%rbp)
mov %esi,%ebx
mov %esi,%eax
mov $1000,%ecx
mul %ecx
mov %eax,%ebx
mov %ebx,%ebx
mov %rbx,18446744073709551608(%rbp)
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
lea 18446744073709551600(%rbp),%rsi
mov %rsi,%rbx
push %rbx
mov $35,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
@sleep$END
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@_memmove_start
@memcpy
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
mov 32(%rbp),%rbx
push %rsi
mov 24(%rbp),%rsi
push %rdi
mov 16(%rbp),%rdi
push %rcx
push %rdx
push %rbx
push %rsi
push %rdi
push %r8
push %r9
push %r10
push %r11
push %r12
mov 16(%rbp),%rax
mov 24(%rbp),%rdx
mov 32(%rbp),%rcx
cmp $8,%rcx
jb @_memcpy_X33
test $1,%dl
je @_memcpy_X11
mov (%rdx),%bl
mov %bl,(%rax)
inc %rax
inc %rdx
dec %rcx
@_memcpy_X11
test $2,%dl
je @_memcpy_X12
mov (%rdx),%bx
mov %bx,(%rax)
add $2,%rax
add $2,%rdx
sub $2,%rcx
@_memcpy_X12
test $4,%dl
je @_memcpy_X13
mov (%rdx),%ebx
mov %ebx,(%rax)
add $4,%rax
add $4,%rdx
sub $4,%rcx
@_memcpy_X13
sub $64,%rcx
jb @_memcpy_X21
@_memcpy_X22
mov (%rdx),%rbx
mov 8(%rdx),%rsi
mov 16(%rdx),%rdi
mov 24(%rdx),%r8
mov 32(%rdx),%r9
mov 40(%rdx),%r10
mov 48(%rdx),%r11
mov 56(%rdx),%r12
mov %rbx,(%rax)
mov %rsi,8(%rax)
mov %rdi,16(%rax)
mov %r8,24(%rax)
mov %r9,32(%rax)
mov %r10,40(%rax)
mov %r11,48(%rax)
mov %r12,56(%rax)
add $64,%rax
add $64,%rdx
sub $64,%rcx
jae @_memcpy_X22
@_memcpy_X21
test $32,%cl
je @_memcpy_X31
mov (%rdx),%rbx
mov 8(%rdx),%rsi
mov 16(%rdx),%rdi
mov 24(%rdx),%r8
mov %rbx,(%rax)
mov %rsi,8(%rax)
mov %rdi,16(%rax)
mov %r8,24(%rax)
add $32,%rax
add $32,%rdx
@_memcpy_X31
test $16,%cl
je @_memcpy_X32
mov (%rdx),%rbx
mov 8(%rdx),%rsi
mov %rbx,(%rax)
mov %rsi,8(%rax)
add $16,%rax
add $16,%rdx
@_memcpy_X32
test $8,%cl
je @_memcpy_X33
mov (%rdx),%rbx
mov %rbx,(%rax)
add $8,%rax
add $8,%rdx
@_memcpy_X33
test $4,%cl
je @_memcpy_X34
mov (%rdx),%ebx
mov %ebx,(%rax)
add $4,%rax
add $4,%rdx
@_memcpy_X34
test $2,%cl
je @_memcpy_X35
mov (%rdx),%bx
mov %bx,(%rax)
add $2,%rax
add $2,%rdx
@_memcpy_X35
test $1,%cl
je @_memcpy_X36
mov (%rdx),%bl
mov %bl,(%rax)
@_memcpy_X36
pop %r12
pop %r11
pop %r10
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rbx
pop %rdx
pop %rcx
mov 16(%rbp),%rax
@memcpy$END
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@memcpy_r
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
mov 32(%rbp),%rbx
push %rsi
mov 24(%rbp),%rsi
push %rdi
mov 16(%rbp),%rdi
push %rcx
push %rdx
push %rbx
push %rsi
push %rdi
push %r8
push %r9
push %r10
push %r11
push %r12
mov 16(%rbp),%rax
mov 24(%rbp),%rdx
mov 32(%rbp),%rcx
cmp $8,%rcx
jb @_memcpy_r_X33
test $1,%dl
je @_memcpy_r_X11
dec %rax
dec %rdx
dec %rcx
mov (%rdx),%bl
mov %bl,(%rax)
@_memcpy_r_X11
test $2,%dl
je @_memcpy_r_X12
sub $2,%rax
sub $2,%rdx
sub $2,%rcx
mov (%rdx),%bx
mov %bx,(%rax)
@_memcpy_r_X12
test $4,%dl
je @_memcpy_r_X13
sub $4,%rax
sub $4,%rdx
sub $4,%rcx
mov (%rdx),%ebx
mov %ebx,(%rax)
@_memcpy_r_X13
sub $64,%rcx
jb @_memcpy_r_X21
@_memcpy_r_X22
sub $64,%rax
sub $64,%rdx
mov (%rdx),%rbx
mov 8(%rdx),%rsi
mov 16(%rdx),%rdi
mov 24(%rdx),%r8
mov 32(%rdx),%r9
mov 40(%rdx),%r10
mov 48(%rdx),%r11
mov 56(%rdx),%r12
mov %rbx,(%rax)
mov %rsi,8(%rax)
mov %rdi,16(%rax)
mov %r8,24(%rax)
mov %r9,32(%rax)
mov %r10,40(%rax)
mov %r11,48(%rax)
mov %r12,56(%rax)
sub $64,%rcx
jae @_memcpy_r_X22
@_memcpy_r_X21
test $32,%cl
je @_memcpy_r_X31
sub $32,%rax
sub $32,%rdx
mov (%rdx),%rbx
mov 8(%rdx),%rsi
mov 16(%rdx),%rdi
mov 24(%rdx),%r8
mov %rbx,(%rax)
mov %rsi,8(%rax)
mov %rdi,16(%rax)
mov %r8,24(%rax)
@_memcpy_r_X31
test $16,%cl
je @_memcpy_r_X32
sub $16,%rax
sub $16,%rdx
mov (%rdx),%rbx
mov 8(%rdx),%rsi
mov %rbx,(%rax)
mov %rsi,8(%rax)
@_memcpy_r_X32
test $8,%cl
je @_memcpy_r_X33
sub $8,%rax
sub $8,%rdx
mov (%rdx),%rbx
mov %rbx,(%rax)
@_memcpy_r_X33
test $4,%cl
je @_memcpy_r_X34
sub $4,%rax
sub $4,%rdx
mov (%rdx),%ebx
mov %ebx,(%rax)
@_memcpy_r_X34
test $2,%cl
je @_memcpy_r_X35
sub $2,%rax
sub $2,%rdx
mov (%rdx),%bx
mov %bx,(%rax)
@_memcpy_r_X35
test $1,%cl
je @_memcpy_r_X36
mov -1(%rdx),%bl
mov %bl,-1(%rax)
@_memcpy_r_X36
pop %r12
pop %r11
pop %r10
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rbx
pop %rdx
pop %rcx
mov 16(%rbp),%rax
@memcpy_r$END
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@memmove
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
push %rdi
push %r8
mov 32(%rbp),%r8
push %r9
mov 24(%rbp),%r9
push %r12
mov 16(%rbp),%r12
mov %r12,%rax
mov %r9,%rcx
cmp %rcx,%rax
jb @_$LB8
mov %r12,%rdi
mov %r9,%rsi
lea (%rsi,%r8),%rbx
mov %rdi,%rax
mov %rbx,%rcx
cmp %rcx,%rax
jb @_$LB4
@_$LB8
push %r8
push %r9
push %r12
call @memcpy
mov %rax,%rbx
add $24,%rsp
mov %rbx,%rax
jmp @memmove$END
jmp @_$LB5
@_$LB4
push %r8
mov %r9,%rsi
lea (%rsi,%r8),%rbx
push %rbx
mov %r12,%rsi
lea (%rsi,%r8),%rbx
push %rbx
call @memcpy_r
mov %rax,%rbx
add $24,%rsp
mov %r12,%rax
@_$LB5
@memmove$END
pop %r12
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@_memmove_end
@memset
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
mov 32(%rbp),%rbx
push %rsi
mov 24(%rbp),%rsi
push %rdi
mov 16(%rbp),%rdi
push %rcx
push %rdx
movzbl 24(%rbp),%edx
mov $0x101010101010101,%rax
mul %rdx
mov %rax,%rdx
mov 16(%rbp),%rax
mov 32(%rbp),%rcx
cmp $8,%rcx
jb @_memset_X33
test $1,%al
je @_memset_X11
mov %dl,(%rax)
inc %rax
dec %rcx
@_memset_X11
test $2,%al
je @_memset_X12
mov %dx,(%rax)
add $2,%rax
sub $2,%rcx
@_memset_X12
test $4,%al
je @_memset_X13
mov %edx,(%rax)
add $4,%rax
sub $4,%rcx
@_memset_X13
sub $64,%rcx
jb @_memset_X21
@_memset_X22
mov %rdx,(%rax)
mov %rdx,8(%rax)
mov %rdx,16(%rax)
mov %rdx,24(%rax)
mov %rdx,32(%rax)
mov %rdx,40(%rax)
mov %rdx,48(%rax)
mov %rdx,56(%rax)
add $64,%rax
sub $64,%rcx
jae @_memset_X22
@_memset_X21
test $32,%cl
je @_memset_X31
mov %rdx,(%rax)
mov %rdx,8(%rax)
mov %rdx,16(%rax)
mov %rdx,24(%rax)
add $32,%rax
@_memset_X31
test $16,%cl
je @_memset_X32
mov %rdx,(%rax)
mov %rdx,8(%rax)
add $16,%rax
@_memset_X32
test $8,%cl
je @_memset_X33
mov %rdx,(%rax)
add $8,%rax
@_memset_X33
test $4,%cl
je @_memset_X34
mov %edx,(%rax)
add $4,%rax
@_memset_X34
test $2,%cl
je @_memset_X35
mov %dx,(%rax)
add $2,%rax
@_memset_X35
test $1,%cl
je @_memset_X36
mov %dl,(%rax)
@_memset_X36
pop %rdx
pop %rcx
mov 16(%rbp),%rax
@memset$END
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@memcmp
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
mov 32(%rbp),%rbx
push %rsi
mov 24(%rbp),%rsi
push %rdi
mov 16(%rbp),%rdi
push %rsi
push %rdi
push %rcx
mov 16(%rbp),%rsi
mov 24(%rbp),%rdi
mov 32(%rbp),%rcx
sub $8,%rcx
jb @_memcmp_X1
@_memcmp_X2
mov (%rsi),%rax
sub (%rdi),%rax
jne @_memcmp_E
add $8,%rsi
add $8,%rdi
sub $8,%rcx
jae @_memcmp_X2
@_memcmp_X1
test $4,%cl
je @_memcmp_Y1
mov (%rsi),%eax
sub (%rdi),%eax
jne @_memcmp_E
add $4,%rsi
add $4,%rdi
@_memcmp_Y1
test $2,%cl
je @_memcmp_Y2
mov (%rsi),%ax
sub (%rdi),%ax
jne @_memcmp_E
add $2,%rsi
add $2,%rdi
@_memcmp_Y2
test $1,%cl
je @_memcmp_E2
mov (%rsi),%al
sub (%rdi),%al
jne @_memcmp_E
add $1,%rsi
add $1,%rdi
jmp @_memcmp_E2
@_memcmp_E
test %eax,%eax
jne @_memcmp_E11
shr $32,%rax
@_memcmp_E11
test %ax,%ax
jne @_memcmp_E12
shr $16,%rax
@_memcmp_E12
test %al,%al
jne @_memcmp_E2
mov %ah,%al
@_memcmp_E2
movsbq %al,%rax
pop %rcx
pop %rdi
pop %rsi
@memcmp$END
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@strlen
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
push %rdi
mov 16(%rbp),%rdi
mov $0,%rsi
mov (%rdi),%bl
mov %bl,%al
mov $0,%cl
cmp %cl,%al
je @_$LB11
@_$LB9
add $1,%rsi
add $1,%rdi
mov (%rdi),%bl
mov %bl,%al
mov $0,%cl
cmp %cl,%al
jne @_$LB9
@_$LB11
mov %rsi,%rax
@strlen$END
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@strnlen
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
push %rdi
mov 24(%rbp),%rdi
push %r8
mov 16(%rbp),%r8
mov %rdi,%rax
mov $0,%rcx
cmp %rcx,%rax
jne @_$LB14
mov $0,%rax
jmp @strnlen$END
@_$LB14
sub $1,%rdi
mov $0,%rsi
mov (%r8),%bl
mov %bl,%al
mov $0,%cl
cmp %cl,%al
je @_$LB17
mov %rsi,%rax
mov %rdi,%rcx
cmp %rcx,%rax
jae @_$LB17
@_$LB20
@_$LB15
add $1,%rsi
add $1,%r8
mov (%r8),%bl
mov %bl,%al
mov $0,%cl
cmp %cl,%al
je @_$LB23
mov %rsi,%rax
mov %rdi,%rcx
cmp %rcx,%rax
jb @_$LB15
@_$LB23
@_$LB17
mov %rsi,%rax
@strnlen$END
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@strcmp
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
push %rdi
push %r8
mov 24(%rbp),%r8
push %r9
mov 16(%rbp),%r9
push %r9
call @strlen
mov %rax,%rbx
add $8,%rsp
mov %rbx,%rdi
push %r8
call @strlen
mov %rax,%rbx
add $8,%rsp
mov %rbx,%rsi
mov %rdi,%rax
mov %rsi,%rcx
cmp %rcx,%rax
jbe @_$LB26
mov %rsi,%rdi
@_$LB26
mov %rdi,%rbx
add $1,%rbx
push %rbx
push %r8
push %r9
call @memcmp
mov %eax,%ebx
add $24,%rsp
movslq %ebx,%rbx
mov %rbx,%rax
@strcmp$END
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@strncmp
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
mov 32(%rbp),%rsi
push %rdi
push %r8
mov 24(%rbp),%r8
push %r9
mov 16(%rbp),%r9
push %rsi
push %r9
call @strnlen
mov %rax,%rbx
add $16,%rsp
mov %rbx,%rdi
push %rsi
push %r8
call @strnlen
mov %rax,%rbx
add $16,%rsp
mov %rbx,%rsi
mov %rdi,%rax
mov %rsi,%rcx
cmp %rcx,%rax
jbe @_$LB29
mov %rsi,%rdi
@_$LB29
mov %rdi,%rbx
add $1,%rbx
push %rbx
push %r8
push %r9
call @memcmp
mov %eax,%ebx
add $24,%rsp
movslq %ebx,%rbx
mov %rbx,%rax
@strncmp$END
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@strcpy
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
push %rdi
mov 24(%rbp),%rdi
push %r8
mov 16(%rbp),%r8
push %rdi
call @strlen
mov %rax,%rbx
add $8,%rsp
mov %rbx,%rsi
mov %rsi,%rbx
add $1,%rbx
push %rbx
push %rdi
push %r8
call @memcpy
mov %rax,%rbx
add $24,%rsp
mov %r8,%rax
@strcpy$END
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@strcat
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
push %rdi
mov 24(%rbp),%rdi
push %r8
mov 16(%rbp),%r8
push %r8
call @strlen
mov %rax,%rbx
add $8,%rsp
mov %rbx,%rsi
push %rdi
lea (%r8,%rsi),%rbx
push %rbx
call @strcpy
mov %rax,%rbx
add $16,%rsp
mov %r8,%rax
@strcat$END
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@sprinti
push %rbp
mov %rsp,%rbp
sub $64,%rsp
push %rbx
push %rsi
mov 32(%rbp),%rsi
push %rdi
push %r8
push %r9
push %r12
mov 24(%rbp),%r12
push %r13
mov 16(%rbp),%r13
mov $10000000000000000000,%r9
mov $20,%ebx
mov %r9,%rax
mov %r12,%rcx
cmp %rcx,%rax
jbe @_$LB32
mov %ebx,%eax
mov %esi,%ecx
cmp %ecx,%eax
jle @_$LB32
@_$LB35
@_$LB30
mov %r9,%rax
mov $10,%rcx
xor %rdx,%rdx
div %rcx
mov %rax,%r9
sub $1,%ebx
mov %r9,%rax
mov %r12,%rcx
cmp %rcx,%rax
jbe @_$LB38
mov %ebx,%eax
mov %esi,%ecx
cmp %ecx,%eax
jg @_$LB30
@_$LB38
@_$LB32
mov $0,%r8d
mov %r9,%rax
mov $0,%rcx
cmp %rcx,%rax
je @_$LB41
@_$LB39
lea 18446744073709551584(%rbp),%rdi
movslq %r8d,%r8
add %r8,%rdi
mov %r12,%rax
mov %r9,%rcx
xor %rdx,%rdx
div %rcx
mov %rax,%rsi
mov %rsi,%rbx
add $48,%rbx
mov %bl,(%rdi)
mov %r12,%rax
mov %r9,%rcx
xor %rdx,%rdx
div %rcx
mov %rdx,%rax
mov %rax,%r12
mov %r9,%rax
mov $10,%rcx
xor %rdx,%rdx
div %rcx
mov %rax,%r9
add $1,%r8d
mov %r9,%rax
mov $0,%rcx
cmp %rcx,%rax
jne @_$LB39
@_$LB41
push %r13
call @strlen
mov %rax,%rbx
add $8,%rsp
mov %rbx,%rdi
movslq %r8d,%r8
push %r8
lea 18446744073709551584(%rbp),%rax
push %rax
lea (%r13,%rdi),%rbx
push %rbx
call @memcpy
mov %rax,%rbx
add $24,%rsp
lea (%rdi,%r8),%ebx
lea (%rdi,%r8),%esi
lea (%r13,%rsi),%rbx
movb $0,(%rbx)
@sprinti$END
pop %r13
pop %r12
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@sinputi
push %rbp
mov %rsp,%rbp
sub $32,%rsp
push %rbx
push %rsi
push %rdi
push %r8
push %r9
mov 24(%rbp),%r9
push %r12
mov 16(%rbp),%r12
mov $0,%rsi
mov (%r12),%bl
mov %bl,%r8b
mov %bl,%al
mov $48,%cl
cmp %cl,%al
jl @_$LB44
mov %r8b,%al
mov $57,%cl
cmp %cl,%al
jg @_$LB44
@_$LB47
@_$LB42
mov %rsi,%rdi
mov %rsi,%rax
mov $10,%rcx
mul %rcx
mov %rax,%rdi
mov %r8b,%sil
sub $48,%sil
movsbl %sil,%esi
lea (%rdi,%rsi),%rbx
mov %rbx,%rsi
add $1,%r12
mov (%r12),%bl
mov %bl,%r8b
mov %bl,%al
mov $48,%cl
cmp %cl,%al
jl @_$LB50
mov %r8b,%al
mov $57,%cl
cmp %cl,%al
jle @_$LB42
@_$LB50
@_$LB44
mov %rsi,(%r9)
mov %r12,%rax
@sinputi$END
pop %r12
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
@main
push %rbp
mov %rsp,%rbp
sub $112,%rsp
push %rbx
mov 16(%rbp),%rbx
push %rsi
push %rdi
push %r8
push %r9
push %r12
push %r13
mov 24(%rbp),%r13
mov %ebx,%eax
mov $4,%ecx
cmp %ecx,%eax
jge @_$LB53
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $41,%rbx
push %rbx
mov $@_$MSG1,%rsi
mov %rsi,%rbx
push %rbx
mov $1,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $1,%rax
jmp @main$END
@_$LB53
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov 8(%r13),%rsi
mov %rsi,%rbx
push %rbx
mov $2,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov %rbx,%r8
mov %r8d,%eax
mov $0,%ecx
cmp %ecx,%eax
jge @_$LB56
mov $1,%rax
jmp @main$END
@_$LB56
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $420,%rbx
push %rbx
mov $578,%rbx
push %rbx
mov 16(%r13),%rsi
mov %rsi,%rbx
push %rbx
mov $2,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov %rbx,%rdi
mov %edi,%eax
mov $0,%ecx
cmp %ecx,%eax
jge @_$LB59
mov $1,%rax
jmp @main$END
@_$LB59
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $6,%rbx
push %rbx
mov $@_$MSG2,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov 24(%r13),%rbx
push %rbx
call @strlen
mov %rax,%rsi
add $8,%rsp
mov %rsi,%rbx
push %rbx
mov 24(%r13),%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $8,%rbx
push %rbx
mov $@_$MSG3,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $32,%rbx
push %rbx
lea 18446744073709551584(%rbp),%rbx
push %rbx
mov %r8d,%ebx
movslq %ebx,%rbx
push %rbx
mov $0,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov %rbx,%r9
mov %rbx,%rax
mov $0,%rcx
cmp %rcx,%rax
jle @_$LB62
@_$LB60
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $11,%rbx
push %rbx
mov $@_$MSG4,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%r12d
mov %r12d,%eax
mov %r9d,%ecx
cmp %ecx,%eax
jge @_$LB65
@_$LB63
mov $0,%al
mov %al,18446744073709551552(%rbp)
pushq $1
lea 18446744073709551584(%rbp),%rsi
movslq %r12d,%r12
add %r12,%rsi
mov (%rsi),%bl
movzbq %bl,%rbx
push %rbx
lea 18446744073709551552(%rbp),%rax
push %rax
call @sprinti
add $24,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
lea 18446744073709551552(%rbp),%rax
push %rax
call @strlen
mov %rax,%rsi
add $8,%rsp
mov %rsi,%rbx
push %rbx
lea 18446744073709551552(%rbp),%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
add $1,%r12d
mov %r12d,%eax
mov %r9d,%ecx
cmp %ecx,%eax
je @_$LB68
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $1,%rbx
push %rbx
mov $@_$MSG5,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
@_$LB68
mov %r12d,%eax
mov %r9d,%ecx
cmp %ecx,%eax
jl @_$LB63
@_$LB65
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $2,%rbx
push %rbx
mov $@_$MSG6,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $32,%rbx
push %rbx
lea 18446744073709551584(%rbp),%rbx
push %rbx
mov %r8d,%ebx
movslq %ebx,%rbx
push %rbx
mov $0,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov %rbx,%r9
mov %rbx,%rax
mov $0,%rcx
cmp %rcx,%rax
jg @_$LB60
@_$LB62
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $6,%rbx
push %rbx
mov $@_$MSG7,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov 24(%r13),%rbx
push %rbx
call @strlen
mov %rax,%rsi
add $8,%rsp
mov %rsi,%rbx
push %rbx
mov 24(%r13),%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $6,%rbx
push %rbx
mov $@_$MSG8,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $5,%rbx
push %rbx
mov $@_$MSG9,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov 24(%r13),%rbx
push %rbx
call @strlen
mov %rax,%rsi
add $8,%rsp
mov %rsi,%rbx
push %rbx
mov 24(%r13),%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $14,%rbx
push %rbx
mov $@_$MSG10,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $5,%rbx
push %rbx
mov $@_$MSG11,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov 24(%r13),%rbx
push %rbx
call @strlen
mov %rax,%rsi
add $8,%rsp
mov %rsi,%rbx
push %rbx
mov 24(%r13),%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $0,%rbx
push %rbx
mov $12,%rbx
push %rbx
mov $@_$MSG12,%rsi
mov %rsi,%rbx
push %rbx
mov %edi,%ebx
movslq %ebx,%rbx
push %rbx
mov $1,%rbx
push %rbx
call @__syscall
mov %rax,%rbx
add $56,%rsp
mov $0,%rax
@main$END
pop %r13
pop %r12
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rbx
mov %rbp,%rsp
pop %rbp
ret
.datasize 0
