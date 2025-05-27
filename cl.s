.syntax unified
.cpu cortex-m4
.thumb

.data
    ; Data section for variables
    W:      .word 0x12345678    ; Sample value for W
    X:      .word 0x87654321    ; Sample value for X
    Y:      .word 0xABCDEF01    ; Sample value for Y
    Z:      .word 0x23456789    ; Sample value for Z
    F:      .word 0x00000000    ; Result for F = W.X + Y.Z
    
    ; Variables for bit field operations
    P:      .hword 0x20F2       ; P = 0010000011110010
    Q:      .hword 0x30F0       ; Q = 0011000011110000
    R:      .hword 0xC4F8       ; R = 1100010011111000
    BF_Result: .hword 0x0000    ; Result for bit field operation
    
    ; Variables for one's complement
    Number: .word 0x0000C123    ; Input number
    Complement: .word 0x00000000 ; One's complement result
    
    ; Variables for nibble extraction
    Value:  .byte 0x5F          ; Input byte
    Result: .hword 0x0000       ; 16-bit result for nibbles

.text
.global _start

_start:
    ; Task 1: Calculate F = W.X + Y.Z (bitwise AND and OR operations)
    bl task1_boolean_operation
    
    ; Task 2: Bit field operation F = (P + Q ⊕ R).111110
    bl task2_bitfield_operation
    
    ; Task 3: One's complement
    bl task3_ones_complement
    
    ; Task 4: Disassemble byte into nibbles
    bl task4_nibble_extraction
    
    ; End program
    b end_program

;=============================================================================
; Task 1: F = W.X + Y.Z (Boolean operation)
; F = (W AND X) OR (Y AND Z)     
;=============================================================================
task1_boolean_operation:
    push {r0-r4, lr}
    
    ; Load W and X
    ldr r0, =W
    ldr r1, [r0]        ; r1 = W
    ldr r0, =X
    ldr r2, [r0]        ; r2 = X
    
    ; Calculate W.X (bitwise AND)
    and r3, r1, r2      ; r3 = W AND X
    
    ; Load Y and Z
    ldr r0, =Y
    ldr r1, [r0]        ; r1 = Y
    ldr r0, =Z
    ldr r2, [r0]        ; r2 = Z
    
    ; Calculate Y.Z (bitwise AND)
    and r4, r1, r2      ; r4 = Y AND Z
    
    ; Calculate F = W.X + Y.Z (bitwise OR)
    orr r0, r3, r4      ; r0 = (W AND X) OR (Y AND Z)
    
    ; Store result
    ldr r1, =F
    str r0, [r1]
    
    pop {r0-r4, lr}
    bx lr

;=============================================================================
; Task 2: Bit field operation F = (P + Q ⊕ R).111110
; Using 6-bit bit fields at different positions
; P bit field: bits 4-9 (0010000011110010 -> bits 4-9 = 111100)
; Q bit field: bits 4-9 (0011000011110000 -> bits 4-9 = 111100)  
; R bit field: bits 3-8 (1100010011111000 -> bits 3-8 = 111110)
;=============================================================================
task2_bitfield_operation:
    push {r0-r6, lr}
    
    ; Load P, Q, R
    ldr r0, =P
    ldrh r1, [r0]       ; r1 = P (16-bit)
    ldr r0, =Q
    ldrh r2, [r0]       ; r2 = Q (16-bit)
    ldr r0, =R
    ldrh r3, [r0]       ; r3 = R (16-bit)
    
    ; Extract 6-bit field from P (bits 4-9)
    lsr r4, r1, #4      ; Shift right by 4
    and r4, r4, #0x3F   ; Mask to get 6 bits (111111 binary)
    
    ; Extract 6-bit field from Q (bits 4-9)
    lsr r5, r2, #4      ; Shift right by 4
    and r5, r5, #0x3F   ; Mask to get 6 bits
    
    ; Extract 6-bit field from R (bits 3-8)
    lsr r6, r3, #3      ; Shift right by 3
    and r6, r6, #0x3F   ; Mask to get 6 bits
    
    ; Calculate P + Q (bitwise OR of bit fields)
    orr r0, r4, r5      ; r0 = P_field OR Q_field
    
    ; Calculate (P + Q) ⊕ R (XOR with R bit field)
    eor r0, r0, r6      ; r0 = (P_field OR Q_field) XOR R_field
    
    ; Apply mask .111110 (AND with 0x3E = 111110 binary)
    and r0, r0, #0x3E   ; Final result
    
    ; Store result
    ldr r1, =BF_Result
    strh r0, [r1]
    
    pop {r0-r6, lr}
    bx lr

;=============================================================================
; Task 3: One's complement of a number
; Input: C123, Output: FFFF3EDC (assuming 32-bit operation)
;=============================================================================
task3_ones_complement:
    push {r0-r2, lr}
    
    ; Load the number
    ldr r0, =Number
    ldr r1, [r0]        ; r1 = 0x0000C123
    
    ; Calculate one's complement (bitwise NOT)
    mvn r2, r1          ; r2 = ~r1 (one's complement)
    
    ; Store result
    ldr r0, =Complement
    str r2, [r0]        ; Store FFFF3EDC
    
    pop {r0-r2, lr}
    bx lr

;=============================================================================
; Task 4: Disassemble byte into high and low nibbles
; Input: 5F -> Output: 050F
; Low nibble (F) goes to low byte, high nibble (5) goes to high byte
;=============================================================================
task4_nibble_extraction:
    push {r0-r4, lr}
    
    ; Load the byte value
    ldr r0, =Value
    ldrb r1, [r0]       ; r1 = 0x5F
    
    ; Extract low nibble (bits 0-3)
    and r2, r1, #0x0F   ; r2 = 0x0F (low nibble)
    
    ; Extract high nibble (bits 4-7)
    lsr r3, r1, #4      ; r3 = 0x05 (high nibble shifted to low position)
    
    ; Combine nibbles: high nibble in upper byte, low nibble in lower byte
    lsl r4, r3, #8      ; r4 = 0x0500 (high nibble in upper byte)
    orr r4, r4, r2      ; r4 = 0x050F (combined result)
    
    ; Store result
    ldr r0, =Result
    strh r4, [r0]       ; Store 16-bit result
    
    pop {r0-r4, lr}
    bx lr

;=============================================================================
; End of program
;=============================================================================
end_program:
    ; Program termination
    b end_program

;=============================================================================
; Additional helper functions and examples
;=============================================================================

; Example function to display results (pseudo-code for debugging)
display_results:
    push {r0-r2, lr}
    
    ; Task 1 result
    ldr r0, =F
    ldr r1, [r0]        ; Load F result
    
    ; Task 2 result  
    ldr r0, =BF_Result
    ldrh r1, [r0]       ; Load bit field result
    
    ; Task 3 result
    ldr r0, =Complement
    ldr r1, [r0]        ; Load complement result
    
    ; Task 4 result
    ldr r0, =Result
    ldrh r1, [r0]       ; Load nibble result
    
    pop {r0-r2, lr}
    bx lr

.end