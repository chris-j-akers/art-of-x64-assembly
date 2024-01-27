; ==============================================================================
; NOTES
; ==============================================================================
; Volatile Registers: RAX, RCX, RDX, R8, R9, R10
; ==============================================================================

                ; Case-sensitivity
                ;
                ; There's actually an assembler option to switch this on, but 
                ; will leave here for now.

                ; It's required when we're mixing assembler with C/C++
                OPTION CASEMAP:NONE

; Typedefs

uint8_t         TYPEDEF     SBYTE
int8_t          TYPEDEF     BYTE

uint16_t        TYPEDEF     WORD
int16_t         TYPEDEF     SWORD

uint32_t        TYPEDEF     DWORD
int32_t         TYPEDEF     SDWORD

uint64_t        TYPEDEF     QWORD
int64_t         TYPEDEF     SQWORD

pointer         TYPEDEF     QWORD


; Top-level Manifest Constants (values that will replace their name anywhere
; it appears in source). Note that these values can actually be defined anywhere
; in as long as it's before the first time they're used, it's just that Hyde
; tends to put them at the top.

; <MC_NAME>     =           <VALUE>
MC_NEWLINE      =               10
MC_NUL          =               0
; Constants
                .CONST  
; <C_NAME>      <TYPE>      <VALUE>                
C_TITLE_STR     BYTE            "Multi-Dim Array Access Test", MC_NUL  
C_MSG_STR       BYTE            "Final value is %d", MC_NEWLINE, MC_NUL    

                .DATA
; Variable declarations
; <name>        <TYPE>      (DUP) <VALUE|?|(?)>
my_array        int32_t     1, 2, 3, 4,
                            5, 6, 7, 8,
                            9, 10, 11, 12,
                            13, 14, 15, 16
                            
                .CODE
                ; EXTERNDEF here | EXTERNDEF <func>:<PROC>
                EXTERNDEF printf:proc
; LABEL         MNEMONIC      VALUE

; ==============================================================================
; get_title()
; ==============================================================================
                PUBLIC get_title
get_title       PROC

                lea             rax, C_TITLE_STR
                ret

get_title       ENDP
; ==============================================================================


; ==============================================================================
; asm_main()
; ==============================================================================

; This needs cleaning up - the addr modes confused me. I need to move the
; address of the array into a register before I can offset it, can't just
; use it without LARGEADDRESSAWARE:NO enabled.

; Convert this into a proc?


; Need to think about passing that last var - maybe read next part of the 
; book :D

get_val         PROC

                ; Address of array (RCX)
                ; Row Index (EDX)
                ; Col Index (R8D)
                ; Data Size (R9D)

                sub     rsp,56
                push    rcx
                push    rdx
                push    r9
                push    r10
                
                ; Preserve ebx
                push    ebx

                imul    r8d, [rsp-32]




get_val         ENDP

asm_main        PROC

; Access my_array[2, 3] (12) - Zero-based index
                sub     rsp, 56 ; I need to allocate an extra byte, here 
                                ; and I think it's because I need to make
                                ; space for arguments in functions I'm calling
                                ; which is printf in this case. Not sure, will
                                ; check.
                
                mov     [rsp+32],4      ; Row length
                lea     rcx, array
                mov     rdx, 3
                mov     r8d, 2
                mov     r9d, 4
                call    get_val



                lea     rcx, C_MSG_STR
                call    printf

                add     rsp, 56
                ret
asm_main        ENDP

                ; END of source file
                END
