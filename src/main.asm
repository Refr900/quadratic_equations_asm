global main

extern scanf
extern putchar
extern printf
extern __main

section .text
solve:
    push    rbp

    movapd  xmm3, xmm2
    movq    r9, xmm2
    movq    r8, xmm1
    movq    rdx, xmm0
    lea     rcx, [rel equation_fmt]
    
    mov     rbp, rsp
    sub     rsp, 112
    
    movups  oword [rsp+30H], xmm6
    movapd  xmm6, xmm1
    movsd   qword [rsp+28H], xmm2
    movapd  xmm2, xmm1
    movapd  xmm1, xmm0
    movups  oword [rsp+40H], xmm7
    movapd  xmm7, xmm0
    movups  oword [rsp+50H], xmm8
    movapd  xmm8, xmm6
    movups  oword [rsp+60H], xmm9
    pxor    xmm9, xmm9
    call    printf

    movsd   xmm3, qword [rsp+28H]
    movsd   xmm0, qword [rel const_four]
    mulsd   xmm8, xmm8
    lea     rcx,  [rel d_eq_str]
    mulsd   xmm0, xmm7
    mulsd   xmm0, xmm3
    subsd   xmm8, xmm0
    movapd  xmm1, xmm8
    movq    rdx, xmm8
    call    printf

    comisd  xmm8, xmm9
    ja      two_roots

    mov     ecx, 10
    call    putchar

    ucomisd xmm8, xmm9
    jpe     no_roots
    jnz     no_roots
    
    addsd   xmm7, xmm7
    xorpd   xmm6, oword [rel neg]
    lea     rcx, [rel x_eq_str]
    movapd  xmm1, xmm6
    divsd   xmm1, xmm7
    movq    rdx, xmm1
    movups  xmm6, oword [rsp+30H]
    movups  xmm7, oword [rsp+40H]
    movups  xmm8, oword [rsp+50H]
    movups  xmm9, oword [rsp+60H]
    leave
    jmp     printf
no_roots:
    movups  xmm6, oword [rsp+30H]
    movups  xmm7, oword [rsp+40H]
    lea     rcx,  [rel no_roots_str]
    movups  xmm8, oword [rsp+50H]
    movups  xmm9, oword [rsp+60H]
    leave
    jmp     printf
two_roots:
    sqrtsd  xmm8, xmm8
    
    lea     rcx, [rel d_sqrt_eq_str]
    movapd  xmm1, xmm8
    movq    rdx, xmm8
    call    printf

    movapd  xmm1, xmm8
    addsd   xmm7, xmm7
    lea     rcx, [rel x1_eq_str]
    subsd   xmm1, xmm6
    divsd   xmm1, xmm7
    movq    rdx, xmm1
    call    printf
    
    xorpd   xmm6, oword [rel neg]
    lea     rcx, [rel x2_eq_str]
    movapd  xmm1, xmm6
    subsd   xmm1, xmm8
    divsd   xmm1, xmm7
    movq    rdx, xmm1

    movups  xmm6, oword [rsp+30H]
    movups  xmm7, oword [rsp+40H]
    movups  xmm8, oword [rsp+50H]
    movups  xmm9, oword [rsp+60H]
    leave
    jmp     printf

input:
    push    r13
    push    r12
    push    rbp
    push    rdi
    push    rsi

    lea     r13, [rel zero_coefficient_str]
    lea     r12, [rel input_start_str]
    lea     rbp, [rel input_delim]
    lea     rsi, [rel fmt_coefficient]
    
    push    rbx
    mov     rbx, rcx
    sub     rsp, 72

    movups  oword [rsp+30H], xmm6
    lea     rdi, [rsp+28H]
    pxor    xmm6, xmm6
    mov     qword [rsp+28H], 0
    jmp     .loop_inner
.loop:
    mov     rcx, r13
    call    printf
.loop_inner:
    mov     rcx, r12
    call    printf

    mov     rcx, rbx
    call    printf

    mov     rcx, rbp
    call    printf

    mov     rdx, rdi
    mov     rcx, rsi
    call    scanf
        
    movsd   xmm0, qword [rsp+28H]
    ucomisd xmm0, xmm6
    jpe     .return
    jz      .loop
.return:
    movups  xmm6, oword [rsp+30H]
    add     rsp, 72
    pop     rbx
    pop     rsi
    pop     rdi
    pop     rbp
    pop     r12
    pop     r13
    ret

main:
    sub     rsp, 40

    lea     rcx, [rel equation_str]
    call    printf

    lea     rcx, [rel a_str]
    call    input

    lea     rcx, [rel b_str]
    movapd  xmm6, xmm0
    call    input

    lea     rcx, [rel c_str]
    movsd   qword [rsp+28H], xmm0
    call    input

    movsd   xmm1, qword [rsp+28H]
    movapd  xmm2, xmm0
    movapd  xmm0, xmm6
    call    solve
    
    xor     eax, eax
    add     rsp, 40
    ret

section .rodata  align=16
equation_fmt: db "| %.7gx^2 + %.7gx + %.7g = 0",10,0
d_eq_str:  db "| D = %.7g",0
d_sqrt_eq_str:  db " = %.7g^2",10,0
x1_eq_str: db "| x1 = %.7g",10,0
x2_eq_str: db "| x2 = %.7g",10,0
x_eq_str: db "| x = %.7g",10,0
no_roots_str: db "| No real roots :(",10,0
input_start_str: db "> ",0
input_delim: db ": ",0
fmt_coefficient: db "%lf",0
zero_coefficient_str: db "error: Coefficient can't be zero! (for now, oopsie :#)",10,0
equation_str: db "| ax^2 + bx + c = 0",10,0
a_str: db "a",0
b_str: db "b",0
c_str: db "c",0

align   16
const_four: dq 4.0
align   16
neg: dq 8000000000000000H 
