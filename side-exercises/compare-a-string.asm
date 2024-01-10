; 10/01/2024 - Let's try and write a string compare in assembler!


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

MC_MAX_LEN      =           256
MC_NUL          =           0
MC_NEWLINE      =           10

                .CONST  
; <C_NAME>      <TYPE>      <value>                

C_TITLE         BYTE        "Compare a String", MC_NUL
C_STR_1_PROMPT  BYTE        "Please enter the first string: ", MC_NUL
C_STR_2_PROMPT  BYTE        "Please enter the second string: ", MC_NUL
C_STR_EQUAL     BYTE        "Yes, they're equal!", MC_NEWLINE, MC_NUL   
C_STR_NEQUAL    BYTE        "No, they're not equal!", MC_NEWLINE, MC_NUL

                .DATA
; Variable declarations

string_1        BYTE        MC_MAX_LEN DUP (?)
string_1_len    BYTE        ?

string_2        BYTE        MC_MAX_LEN DUP (?)
string_2_len    BYTE        ?

                .CODE
                ; EXTERNDEF here | EXTERNDEF <func>:<PROC>
                EXTERNDEF read_line:PROC
                EXTERNDEF printf:PROC
                EXTERNDEF strlen:PROC

; ==============================================================================
; get_title()
; ==============================================================================
                PUBLIC get_title
get_title       PROC

                lea     rax, C_TITLE
                ret

get_title       ENDP

; ==============================================================================
; asm_main()
; ==============================================================================
                PUBLIC  asm_main
asm_main        PROC
                sub     rsp, 56
                
                ; Get string 1
                lea     rcx, C_STR_1_PROMPT
                call    printf
                lea     rcx, string_1
                mov     rdx, MC_MAX_LEN
                call    read_line
                mov     string_1_len, al

                ; Get string 2
                lea     rcx, C_STR_2_PROMPT
                call    printf
                lea     rcx, string_2
                mov     rdx, MC_MAX_LEN
                call    read_line
                mov     string_2_len, al

                ; If the strings are different lengths, then they're obviously
                ; not the same
                mov     al, string_1_len
                mov     ah, string_2_len
                cmp     al, ah
                jne     nequal

                ; Load addresses of both strings into registers so we can index
                ; along them in the loop.
                lea     rcx, string_1
                lea     rdx, string_2
top:

                ; We know each address points to just one byte so safe to 
                ; derefence into ah/al and share a register for this.

                ; De-reference byte at addr in rcx (string_1) and move into al
                mov     al, [rcx]

                ; De-reference byte at addr in rdx (string_2) x and move into ah
                mov     ah, [rdx]       
                                        
                ; Only need to check for NUL at end of one string because
                ; we know both strings are the same length due to check above.
                cmp     al, 0           
                ; If we've got this far (end of the strings), then they must
                ; be equal
                je      equal

                cmp     al, ah
                jne     nequal

                ; Get address of next byte of string_1
                inc     rcx       

                ; Get address of next byte of string_2
                inc     rdx

                ; Back to top of loop
                jmp     top

equal:
                lea     rcx, C_STR_EQUAL
                call    printf
                mov     rax, 1      ; true (1)
                jmp     done
nequal:
                lea     rcx, C_STR_NEQUAL
                call    printf  
                xor     rax, rax    ; false (0)

done:
                add     rsp, 56
                ret
asm_main        ENDP

                ; END of source file
                END
