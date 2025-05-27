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
    
    ; 3. Multiplication of 64-bit numbers
    ; For full 64x64 multiplication, we need to break it into parts
    LDMIA   R12, {R0, R1}        ; Load num1 into R1:R0 (high:low)
    LDMIA   R11, {R2, R3}        ; Load num2 into R3:R2 (high:low)
    
    ; Multiply 32-bit parts and accumulate
    MUL     R4, R0, R2           ; R4 = low(num1) * low(num2) - low part
    
    ; Calculate cross products
    MUL     R5, R0, R3           ; R5 = low(num1) * high(num2)
    MUL     R6, R1, R2           ; R6 = high(num1) * low(num2)
    
    ; Upper part of multiplication
    MUL     R7, R1, R3           ; R7 = high(num1) * high(num2) - high part
    
    ; Combine the results (partial products)
    ; Store low word directly
    STR     R4, [R8]             ; Store lowest word of result
    
    ; Middle words (cross products)
    ADDS    R5, R5, R6           ; R5 = R5 + R6 (combines cross products)
    ADC     R7, R7, #0           ; Add carry to high product
    
    ; Store middle word
    STR     R5, [R8, #4]         ; Store second word of result
    
    ; Store high word
    STR     R7, [R8, #8]         ; Store high word of result
    MOV     R0, #0               ; Clear highest word (simple implementation)
    STR     R0, [R8, #12]        ; Store highest word of result
    
    ; End program
    B       .
    ENDP
    END