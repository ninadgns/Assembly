; ARM Cortex-M4 Assembly Program to perform 64-bit addition, subtraction, and multiplication
; and store result in memory

    AREA    |.data|, DATA
num1        DCD     0xFFFFFFFF, 0x00000007  ; First 64-bit number (high, low words)
num2        DCD     0x00000000, 0x00000002  ; Second 64-bit number (high, low words)
add_result  SPACE   8                       ; 8 bytes (64 bits) to store addition result
sub_result  SPACE   8                       ; 8 bytes (64 bits) to store subtraction result
mul_result  SPACE   16                      ; 16 bytes (128 bits) to store multiplication result

    AREA    |.text|, CODE, READONLY
    EXPORT  __main
    ENTRY

__main  PROC
    ; Load addresses of the data
    LDR     R12, =num1           ; Address of first number
    LDR     R11, =num2           ; Address of second number
    LDR     R10, =add_result     ; Address to store addition result
    LDR     R9, =sub_result      ; Address to store subtraction result
    LDR     R8, =mul_result      ; Address to store multiplication result
    
    ; 1. Addition of 64-bit numbers
    LDMIA   R12, {R0, R1}        ; Load num1 into R1:R0 (high:low)
    LDMIA   R11, {R2, R3}        ; Load num2 into R3:R2 (high:low)
    
    ADDS    R0, R0, R2           ; Add low words with carry
    ADC     R1, R1, R3           ; Add high words with carry
    
    STMIA   R10, {R0, R1}        ; Store result in add_result
    
    ; 2. Subtraction of 64-bit numbers
    LDMIA   R12, {R0, R1}        ; Load num1 into R1:R0 (high:low)
    LDMIA   R11, {R2, R3}        ; Load num2 into R3:R2 (high:low)
    
    SUBS    R0, R0, R2           ; Subtract low words with borrow
    SBC     R1, R1, R3           ; Subtract high words with borrow
    
    STMIA   R9, {R0, R1}         ; Store result in sub_result
    
    ; 3. Multiplication of 64-bit numbers (complete implementation)
    ; For full 64x64 multiplication, we need to break it into parts
    LDMIA   R12, {R0, R1}        ; Load num1 into R1:R0 (high:low) (R0=low, R1=high)
    LDMIA   R11, {R2, R3}        ; Load num2 into R3:R2 (high:low) (R2=low, R3=high)
    
    ; Let's denote R0 as A, R1 as B, R2 as C, R3 as D
    ; We're multiplying (B:A) by (D:C) to get a 128-bit result
    
    ; Step 1: Calculate A*C (low words) - will go in result word 0 and potentially carry to word 1
    UMULL   R4, R5, R0, R2       ; R5:R4 = A*C (R4=low, R5=high)
    
    ; Step 2: Calculate A*D (cross product) - will contribute to result words 1 and 2
    UMULL   R6, R7, R0, R3       ; R7:R6 = A*D
    
    ; Step 3: Calculate B*C (cross product) - will contribute to result words 1 and 2
    UMULL   R0, R1, R1, R2       ; R1:R0 = B*C (reusing R0, R1)
    
    ; Step 4: Add cross products to form middle words
    ADDS    R6, R6, R5           ; Add high word of A*C to low word of A*D
    ADCS    R7, R7, #0           ; Add carry to high word of A*D
    
    ADDS    R6, R6, R0           ; Add low word of B*C to current middle sum
    ADCS    R7, R7, R1           ; Add high word of B*C with carry
    ADC     R1, #0               ; Capture any carry out in R1
    
    ; Step 5: Calculate B*D (high words) - will contribute to result words 2 and 3
    UMULL   R0, R5, R3, R3       ; R5:R0 = B*D (reusing R0, overwriting R5)
    
    ; Step 6: Combine with existing results
    ADDS    R7, R7, R0           ; Add low word of B*D to high middle word
    ADCS    R1, R1, R5           ; Add high word of B*D with carry to highest word
    ADC     R5, #0               ; Capture final carry (will be 0 in most cases)
    
    ; Store the complete 128-bit result
    STR     R4, [R8, #0]         ; Store word 0 (lowest)
    STR     R6, [R8, #4]         ; Store word 1
    STR     R7, [R8, #8]         ; Store word 2
    STR     R1, [R8, #12]        ; Store word 3 (highest)
    
    ; End program
    B       .
    ENDP
    END