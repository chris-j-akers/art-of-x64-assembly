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
; RAX   = Copy of array address used to reset scan (and subsequent return value)
; RBX   = Address of last element of the array (must preserve on stack!)
; RCX   = Paramater: Contains address of array
; RDX   = Parameter: Contains length of array (Int32_t)
; R8D   = Store for current value (n) being compared
; R9D   = Store for (n+1) so it can be used to compare against n
; R10b  = 1/0 based on whether we swapped values during last array scan

                ; (R)(E)BX is not volatile so have to preserve it
                push    rbx
                sub     rsp, 56

                ; store array address in rax so, 1) it's ready to return when
                ; done 2) we can use it again when we're resetting the count 
                ; for each array scan.
                mov     rax, rcx
                
                ; load rbx with address of last element in the array. We'll use
                ; this value in a `cmp` to check whether we've reached the end
                ; of the array (rather than use up another register/var with a 
                ; separate counter)

                ; to avoid array[0]..array[Len-1] shennanigans
                dec     rdx  

                ; numbers we're sorting are all 4-byte (32-bit) signed ints
                lea     rbx, [rcx + (rdx*4)] 

                ; set R10b to 'false' (0)
                xor     r10b, r10b

check:          ; have we reached end of the array? Check by comparing the 
                ; address in rcx with the address in rbx (see above)
                cmp     rcx, rbx
                jb      compare

                ; we are at the end of the array, but did we swap any values
                ; during the previous scan?
                cmp     r10b, 0
                
                ; no, so we must be done sorting!
                je      done

                ; yep, so reset to start another scan through the array.
                mov     rcx, rax
                xor     r10b, r10b

compare:        mov     r8d, int32_t ptr [rcx]
                mov     r9d, int32_t ptr [rcx+4]
                cmp     r8d, r9d
                jng     continue

                ; we need to swap as the next elem is higher than the current
                ; one.
                
                ; already stored rcx value in r8d, so now get the n+1 
                ; value from r9d
                mov     [rcx+4], r8d
                mov     [rcx], r9d

                ; Set r10b to true
                mov     r10b, 1

continue:       add     rcx, 4
                jmp     check                

done:           add     rsp, 56
                pop     rbx
                ret

bubble_sort     ENDP
                ; END of source file
                END
