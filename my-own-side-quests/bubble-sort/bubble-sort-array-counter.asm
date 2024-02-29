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
                externdef clock:proc
; ==============================================================================
; bubble_sort(uint32_t *array, uint32_t array_len)
; ==============================================================================
bubble_sort_asm     PROC

; Want this all in registers, no vars!

; Storage
; =======
; RAX = Preserve array address / Return Sorteed Array Pointer
; RCX = Array pointer passed as parameter
; RDX = Array Length passed as parameter
; R8D = Counter
; R9D = Stores n for comparison
; R10D = Stores n+1 for comparison
; R11b = 1/0 on whether we swapped values during previous scan

                sub     rsp, 32

                ; store array address in rax so we can use it again when we're 
                ; resetting for each array scan and have it ready for when we're
                ; all done.
                mov     rax, rcx

                ; store length so we can subtract as the counter
                sub     edx, 1
                mov     r8d, edx

                ; set R10b to 'false' (0)
                xor     r11b, r11b

                ; have we gone through all the elements? Check by comparing r8d 
                ; (our counter) with 0
 check:         cmp     r8d, 0
                jne     compare

                ; Did we exchange any values?
                cmp     r11b, 0

                ; Nope, we're done
                je      done

                ; 'Fraid so, reset for another loop
                mov     rcx, rax
                mov     r8d, edx
                xor     r11b, r11b
                
                
compare:        ; We pull rcc[n] and rcx[n+1] into registers for comparison
                mov     r9d, [rcx]
                mov     r10d, [rcx+4]
                cmp     r9d, r10d
                jle     continue

                ; Swap
                mov     [rcx+4], r9d
                mov     [rcx], r10d
                mov     r11b, 1

continue:       dec     r8d
                add     rcx, 4
                jmp     check

done:           add    rsp, 32
                ret

bubble_sort_asm ENDP
                ; END of source file
                END
