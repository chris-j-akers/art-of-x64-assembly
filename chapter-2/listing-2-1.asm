        option casemap:none

    NEWLINE  =   10
    NUL      =   0

        .data

i   qword   1
j   qword   123
k   qword   456789

title_str   byte    "Listing 2-1", 0

fmt_str_1    byte    "i=%d, converted to hex=%x", NEWLINE, NUL
fmt_str_2    byte    "j=%d, converted to hex=%x", NEWLINE, NUL
fmt_str_3    byte    "k=%d, converted to hex=%x", NEWLINE, NUL

    .code

    externdef   printf:proc

; =====================================================================

    public get_title
get_title proc
    lea rax, title_str
    ret
get_title endp

; =====================================================================

public asm_main

asm_main proc

    sub     rsp, 56
    
    lea     rcx, fmt_str_1
    mov     rdx, i
    mov     r8, rdx
    call    printf

    lea     rcx, fmt_str_2
    mov     rdx, j
    mov     r8, rdx
    call    printf

    lea     rcx, fmt_str_3
    mov     rdx, k
    mov     r8, rdx
    call    printf

    add     rsp, 56
    ret
    
asm_main endp
    end
