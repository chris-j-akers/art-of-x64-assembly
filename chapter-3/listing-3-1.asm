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
C_TITLE_STR     byte            "Listing 3-1", MC_NUL
C_FMT_STR_1     byte            "i[0]=%d ", MC_NUL
C_FMT_STR_2     byte            "i[1]=%d ", MC_NUL
C_FMT_STR_3     byte            "i[2]=%d ", MC_NUL
C_FMT_STR_4     byte            "i[3]=%d ", MC_NEWLINE, MC_NUL

                .DATA
; Variable declarations
; <name>        <TYPE>      (DUP) <VALUE|?|(?)>
i               byte            0, 1, 2, 3 

                .CODE
                ; EXTERNDEF here | EXTERNDEF <func>:<PROC>
                EXTERNDEF printf:PROC

; ==============================================================================
; get_title()
; ==============================================================================
                PUBLIC get_title
get_title       PROC

                lea rax, C_TITLE_STR
                ret

get_title       ENDP

; ==============================================================================
; asm_main()
; ==============================================================================
asm_main        PROC
                push    rbx                             ; Why? Typo? We don't
                                                        ; touch RBX.

                sub     rsp, 48                         ; Why 48 all of a 
                                                        ; sudden?

                lea     rcx, C_FMT_STR_1
                movzx   rdx, i[0]
                call printf

                lea     rcx, C_FMT_STR_2
                movzx   rdx, i[1]
                call printf

                lea     rcx, C_FMT_STR_3
                movzx   rdx, i[2]
                call printf

                lea     rcx, C_FMT_STR_4
                movzx   rdx, i[3]
                call printf                        

                add rsp, 48                             ; Que?
                pop rbx                                 ; Que?
                ret

asm_main        ENDP

; LABEL         MNEMONIC      VALUE

                ; END of source file
                END
; ==============================================================================