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
C_TITLE_STR     BYTE            "<TITLE STR>", MC_NUL      

                .DATA
; Variable declarations
; <name>        <TYPE>      (DUP) <VALUE|?|(?)>


                .CODE
                ; EXTERNDEF here | EXTERNDEF <func>:<PROC>
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
asm_main        PROC


asm_main        ENDP

                ; END of source file
                END
