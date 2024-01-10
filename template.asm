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

; Constants
                .CONST  
; <C_NAME>      <TYPE>      <VALUE>                

                .DATA
; Variable declarations
; <name>        <TYPE>      (DUP) <VALUE|?|(?)>

                .CODE
                ; EXTERNDEF here | EXTERNDEF <func>:<PROC>

; ==============================================================================
; get_title()
; ==============================================================================
                PUBLIC get_title
get_title       PROC

                lea rax, MC_TITLE
                ret

get_title       ENDP
; ==============================================================================

; LABEL         MNEMONIC      VALUE

                ; END of source file
                END
