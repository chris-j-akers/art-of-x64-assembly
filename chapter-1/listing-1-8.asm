        option casemap:none

nl      =   10
max_len =   256

        .data

title_str   byte    'Listing 1-8', 0
prompt      byte    'Enter a string: ', 0
fmt_str     byte    'User entered "%s"', nl, 0

; This is basically an array, similar to: `byte input[max_len]` in C
; 'max_len' (256, defined above) dups of an uninitialised (?) byte
input       byte    max_len dup (?)

        .code

        externdef       printf:proc
        externdef       read_line:proc

; ===========================================
        public get_title
get_title  proc

        lea rax, title_str
        ret
get_title endp

; ===========================================
        public asm_main
asm_main proc
        sub rsp, 56
        lea rcx, prompt
        call printf

        ; We NUL terminate the input string already, just in case
        ; there was an error and weend up returning 
        ; an empty string
        mov input, 0

        ; Read out input by calling read_line() which is defined
        ; in the CPP file.
        lea rcx, input
        mov rdx, max_len
        call read_line

        ; Now print the string the user inputted
        ; by calling printf and passing the string
        ; and the input string for the placeholder (%s)
        lea rcx, fmt_str
        lea rdx, input
        call printf

        add rsp, 56
        ret

asm_main endp
         end