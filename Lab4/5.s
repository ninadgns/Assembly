    AREA    |.data|, DATA, READWRITE
DECIMAL_INPUT DCD   1234            ; Example decimal input (can be changed)
BINARY_RESULT SPACE  33             ; Space for binary result (32 bits + null terminator)

    AREA    |.text|, CODE, READONLY
    ENTRY                           ; Program entry point
    EXPORT main                     ; Make main visible to the linker

main
    ; Load the decimal number to convert
    ldr     r0, =DECIMAL_INPUT      ; Load address of decimal input
    ldr     r0, [r0]                ; Load decimal value into r0
    
    ; Set up binary result buffer
    ldr     r1, =BINARY_RESULT      ; r1 points to binary result buffer
    
    ; Check if input is zero (special case)
    cmp     r0, #0
    bne     start_conversion
    
    ; Handle zero input
    mov     r2, #'0'                ; ASCII '0'
    strb    r2, [r1], #1            ; Store '0'
    mov     r2, #0                  ; Null terminator
    strb    r2, [r1]
    b       done
    
start_conversion
    ; Find the most significant bit first
    ; We'll process bits from MSB to LSB to avoid reversing later
    mov     r2, #31                 ; Start with bit 31 (most significant bit)
    
find_msb
    mov     r3, #1                  ; Mask for current bit
    lsl     r3, r3, r2              ; Shift to bit position
    tst     r0, r3                  ; Test if bit is set
    bne     convert_loop            ; If set, we found MSB, start conversion
    subs    r2, r2, #1              ; Move to next bit
    bpl     find_msb                ; Continue if not below bit 0
    
convert_loop
    ; Process all bits from MSB to LSB
    mov     r3, #1                  ; Mask for current bit
    lsl     r3, r3, r2              ; Shift to bit position
    
    ; Test bit and store ASCII '0' or '1'
    tst     r0, r3
    moveq   r4, #'0'                ; ASCII '0' if bit is clear
    movne   r4, #'1'                ; ASCII '1' if bit is set
    strb    r4, [r1], #1            ; Store character and increment pointer
    
    ; Move to next bit
    subs    r2, r2, #1              ; Decrement bit position
    bpl     convert_loop            ; Continue if not below bit 0
    
    ; Add null terminator
    mov     r2, #0
    strb    r2, [r1]

done
    ; End of program
    END