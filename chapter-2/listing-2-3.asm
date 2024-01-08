                option casemap:none

NEWLINE         =       10
MAX_LEN         =       256

                .data
title_str       byte    "Listing-2-3", 0

prompt_1        byte    "Enter an integer between 0 and 127:", 0
fmt_str_1       byte    "Value in hexadecimal: %x", NEWLINE, 0
fmt_str_2       byte    "Invert all the bits (hexadecimal): %x", NEWLINE, 0
fmt_str_3       byte    "Add 1 (hexadecimal): %x", NEWLINE, 0
fmt_str_4       byte    "Output as signed integer: %d", NEWLINE, 0
fmt_str_5       byte    "Using neg instruction: %d", NEWLINE, 0

int_value       sqword  ?
input           byte    MAX_LEN dup (?)

                .code
                externdef printf:proc
                externdef atoi:proc
                externdef read_line:proc

                public get_title
get_title       proc

                lea     rax, title_str
                ret
get_title       endp

                public asm_main
asm_main        proc

                sub     rsp, 56

                lea     rcx, prompt_1
                call    printf

                lea     rcx, input
                mov     rdx, MAX_LEN
                call    read_line

                lea     rcx, input
                call    atoi
                and     rax, 0ffh       ; Only keep Lower 8 bits
                mov     int_value, rax

                ; Print input value (in decimal) as hex number

                lea     rcx, fmt_str_1
                mov     rdx, rax
                call    printf

                ; Let's do two's complement methods! Basically, this listing manually performs
                ; two's complement, then does it with the neg instruction. I guess just to show
                ; you the results are the same.

                mov     rdx, int_value
                not     dl                      ; Only work with 8-bit values
                lea     rcx, fmt_str_2          ; Bit confusing he put this here, probably should be at the top?
                call    printf

                ; Invert all the bits and add 1. Bit confusing he inverts again, but I guess he wants
                ; to show what it looks like at each stage and rcx/rdx are volatile so need to be
                ; re-done after the printf call, above.

                mov     rdx, int_value
                not     rdx
                add     rdx, 1
                and     rdx, 0ffh       ; Keep only lower 8-bits, remember!

                lea     rcx, fmt_str_3
                call    printf

                ; Negate value and print as signed int - we use full 64-bits here because C++ %d 
                ; placeholder expects 32-bits and will ignore the higher 32-bits of a 64-but number

                mov     rdx, int_value
                not     rdx
                add     rdx, 1
                lea     rcx, fmt_str_4
                call    printf

                ; Negate using the neg instruction

                mov     rdx, int_value
                neg     rdx
                lea     rcx, fmt_str_5
                call    printf

                add     rsp, 56
                ret
asm_main        endp
                end


