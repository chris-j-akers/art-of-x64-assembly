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
int32_t         TYPEDEF     SDWORD

                .CODE
; ==============================================================================
; bubble_sort(uint32_t *array, uint32_t array_len)
; ==============================================================================
bubble_sort     PROC

; Want this all in registers, no vars!

; Storage
; =======
; RAX = Preserve array address
; RCX = Parameter array address (used to increment)
; RDX = Parameter array_len
; R8D = Copy of array_len for subbing to 0
; R9D = n
; R10D = n+1
; R11b  = 1/0 based on whether we swapped values during last array scan

                ; store array address in rax so, 1) it's ready to return when
                ; done 2) we can use it again when we're resetting for each 
                ; array scan.
                mov     rax, rcx

                ; store length so we can subtract as the counter
                sub     edx, 1
                mov     r8d, edx

                ; set R10b to 'false' (0)
                xor     r11b, r11b

                ; have we reached end of the array? Check by comparing the 
                ; address in rcx with the address in rbx (see above)
 check:         cmp     r8d, 0
                jne     short compare

                cmp     r11b, 0
                je      short done

                mov     rcx, rax
                mov     r8d, edx
                xor     r11b, r11b
                
                
compare:        mov     r9d, [rcx]
                mov     r10d, [rcx+4]
                cmp     r9d, r10d
                jle     short continue

                mov     [rcx+4], r9d
                mov     [rcx], r10d
                mov     r11b, 1

continue:       sub     r8d, 1
                add     rcx, 4
                jmp     short check

done:           ret

bubble_sort     ENDP
                ; END of source file
                END
