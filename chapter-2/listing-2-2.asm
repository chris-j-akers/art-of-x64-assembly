                option casemap:none

NEWLINE         =       10

                .data
        
left_op         dword   0f0f0f0fh
right_op_1      dword   0f0f0f0f0h
right_op_2      dword   12345678h

title_str       byte    "Listing 2-2", 0

fmt_str_1       byte    "%lx AND %lx = %lx", NEWLINE, 0
fmt_str_2       byte    "%lx OR %lx = %lx", NEWLINE, 0
fmt_str_3       byte    "%lx XOR %lx = %lx", NEWLINE, 0
fmt_str_4       byte    "NOT %lx = %lx", NEWLINE, 0

                .code
                externdef printf:proc

                public get_title
get_title       proc

                lea     rax, title_str
                ret
get_title       endp


                public asm_main
asm_main        proc

                sub     rsp, 56

                ; AND instruction

                lea     rcx, fmt_str_1          ; This has to be RDX because it's loading an address which is a 64-bit pointer
                mov     edx, left_op            ; EDX because it's a 32-bit value
                mov     r8d, right_op_1         ; r8d because it's a 32-bit value
                mov     r9d, edx                ; Ditto, above
                and     r9d, r8d
                call    printf

                lea     rcx, fmt_str_1
                mov     edx, left_op
                mov     r8d, right_op_2
                mov     r9d, r8d
                and     r9d, edx
                call    printf

                ; OR instruction

                lea     rcx, fmt_str_2
                mov     edx, left_op
                mov     r8d, right_op_1
                mov     r9d, edx
                or      r9d, r8d
                call    printf
                
                lea     rcx, fmt_str_1
                mov     edx, left_op
                mov     r8d, right_op_2
                mov     r9d, r8d
                or      r9d, edx
                call    printf
                                
                ; XOR instruction

                lea     rcx, fmt_str_3
                mov     edx, left_op
                mov     r8d, right_op_1
                mov     r9d, edx
                xor     r9d, r8d
                call    printf

                lea     rcx, fmt_str_1
                mov     edx, left_op
                mov     r8d, right_op_2
                mov     r9d, r8d
                xor     r9d, edx
                call    printf                
                
                ; NOT instruction

                lea     rcx, fmt_str_4
                mov     edx, left_op
                mov     r8d, edx
                not     r8d
                call    printf

                lea     rcx, fmt_str_4
                mov     edx, right_op_1
                mov     r8d, edx
                not     r8d
                call    printf

                lea     rcx, fmt_str_4
                mov     edx, right_op_2
                mov     r8d, edx
                not     r8d
                call    printf

                add     rsp, 56
                ret
asm_main        endp
                end



