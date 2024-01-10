; Packed data types

                option casemap:none


NUL             =       0
NEWLINE         =       10
MAX_LEN         =       256

                .const  ; Ooh, this is new - not a .data section, any more
title_str       byte    "Listing 2-4", NUL
month_prompt    byte    "Enter current month: ", NUL
day_prompt      byte    "Enter current day: ", NUL
year_prompt     byte    "Enter current year ", NUL
                byte    "(last two digits only): ", NUL

packed          byte    "Packed date is %04x", NEWLINE, NUL

the_date        byte    "The date is %02d/%02d/%02d"
                byte    NEWLINE, NUL

bad_day_str     byte    "Bad day value was entered "
                byte    "(expected 1-31)", NEWLINE, NUL

bad_month_str   byte    "Bad month value was entered "
                byte    "(expected 1-12)", NEWLINE, NUL

bad_year_str    byte    "Bad year value was entered "
                byte    "(expected 00-99)", NEWLINE, NUL


                .data
month           byte    ?
day             byte    ?
year            byte    ?
date            word    ?

input           byte    MAX_LEN dup (?)

                .code
                externdef printf:proc
                externdef read_line:proc
                externdef atoi:proc

; Get Title

                public get_title
get_title       proc
                lea     rax, title_str
                ret
get_title       endp

; read_num

read_num        proc
                sub     rsp, 56
                call    printf          ; The correct prompt message will be in
                                        ; RCX, having been loaded there
                                        ; before the function is called.
                lea     rcx, input
                mov     rdx, MAX_LEN
                call    read_line

                cmp     rax, NUL
                je      bad_input

                lea     rcx, input
                call    atoi

bad_input:      add     rsp, 56
                ret
read_num        endp

; asm_main

asm_main        proc
                sub     rsp, 56

                ; Get month
                lea     rcx, month_prompt
                call    read_num

                cmp     rax, 1
                jl      bad_month

                cmp     rax, 12
                jg      bad_month

                mov     month, al ; Only lower byte required, here

                ; Get Day
                lea     rcx, day_prompt
                call    read_num

                cmp     rax, 1
                jl      bad_day

                cmp     rax, 31
                jg      bad_day

                mov     day, al 

                ; Get Year
                lea     rcx, year_prompt
                call read_num

                cmp     rax, 0
                jl      bad_year

                cmp     rax, 99
                jg      bad_year

                mov     year, al

                ; Packing
                ; month = 4-bits
                ; day = 5-bits
                ; year = 7-bits
                ;       = 16-bits

                movzx   ax, month ; Month is a byte, but we also know the max value permitted by month means
                                  ; the data will fit into 4-bits (nibble) - we even have a check, above,
                                  ; so this command will move, at most 4 bits into the 16-bit ax register: 0000 0000 0000 1001
                shl     ax, 5     ; Shift left by five bits to make room for day

                or      al, day   ; Basically copies bits from the day byte into lower byte of ax which is currently
                                  ; just 0's because of the shift operation, above. OR will work because only 1s will
                                  ; be copied.
                
                shl     ax, 7     ; Now making room for the year;
                or      al, year  ; Same as with day, above. Bottom 7 bits in year are no 0s, so or will set 
                                  ; the right ones based on year bits.

                mov     date, ax

                ; print the date

                lea     rcx, packed
                movzx   rdx, date
                call    printf

                ; Unpack the date and print

                movzx   rdx, date ; <- After the shift operations, below, RDX will just be left with the month
                                  ; so it kind of looks like we're doing it backwards, but that's the plan
                mov     r9, rdx
                and     r9, 7fh ; Only keep LO 7 bits (year)
                shr     rdx, 7  ; Shift right to move day bits to LO
                mov     r8, rdx
                and     r8, 1fh ; Only keep LO 5 bits in r8 (day)
                shr     rdx, 5  ; Finally, the month
                lea     rcx, the_date
                call    printf

                jmp all_done

bad_day:
                lea     rcx, bad_day_str
                call    printf
                jmp     all_done

bad_month:
                lea     rcx, bad_month_str
                call    printf
                jmp     all_done

bad_year:
                lea     rcx, bad_year_str
                call    printf
                jmp     all_done

all_done:
                add     rsp, 56
                ret
asm_main        endp
                end