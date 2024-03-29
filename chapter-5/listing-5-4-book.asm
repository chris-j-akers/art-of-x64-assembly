; Listing 5-4
;
; Preserving registers (caller) example

; This doesn't work either and it's Hyde's code :shrug:


               option  casemap:none

nl             =       10

              .const
ttlStr        byte    "Listing 5-4", 0
space         byte    " ", 0
asterisk      byte    '*, %d', nl, 0

              .data
saveRBX       qword   ?
        
              .code
              externdef printf:proc

; Return program title to C++ program:

              public get_title
get_title      proc
              lea rax, ttlStr
              ret
get_title      endp



; print40Spaces-
; 
;  Prints out a sequence of 40 spaces
; to the console display.

print40Spaces proc
              sub  rsp, 48   ;"Magic" instruction
              mov  ebx, 40
printLoop:    lea  rcx, space
              call printf
              dec  ebx
              jnz  printLoop ;Until ebx==0
              add  rsp, 48   ;"Magic" instruction
              ret
print40Spaces endp


; Here is the "asmMain" function.

              public  asm_main
asm_main       proc
              push    rbx
                
; "Magic" instruction offered without
; explanation at this point:

              sub     rsp, 40

              mov     rbx, 20
astLp:        mov     saveRBX, rbx
              call    print40Spaces
              lea     rcx, asterisk
              mov     rdx, saveRBX
              call    printf
              mov     rbx, saveRBX
              dec     rbx
              jnz     astLp

              add     rsp, 40
              pop     rbx
              ret     ;Returns to caller
asm_main       endp
              end