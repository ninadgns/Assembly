; filepath: d:\Workspace\Assembly\Lab5\hex_to_bcd.s
    AREA    |.data|, DATA, READWRITE
HEX_INPUT   DCD     0x00001234      ; Example hex input (can be changed)
BCD_RESULT  FILL    10              ; Buffer to hold BCD digits (up to 10 digits for 32-bit number)

    AREA    |.text|, CODE, READONLY
    ENTRY                           ; Program entry point
    EXPORT main                     ; Make main visible to the linker

main
    ; Load the hex number to convert
    ldr     r0, =HEX_INPUT          ; Load address of hex input
    ldr     r0, [r0]                ; Load hex value into r0
    
    ; Set up BCD result buffer
    ldr     r1, =BCD_RESULT         ; r1 points to BCD result buffer
    
    ; Initialize digit counter
    mov     r2, #0                  ; r2 will track number of digits
    
hex_to_bcd_loop
    ; Check if input is zero
    cmp     r0, #0
    beq     store_done
    
    ; Divide by 10 to get the next BCD digit
    mov     r3, r0                  ; Copy current value
    ldr     r4, =0xCCCCCCCD         ; Magic number for division by 10
    umull   r5, r4, r3, r4          ; Multiply by magic number
    lsr     r4, r4, #3              ; Shift right to complete division
    
    ; r4 now contains r3/10
    
    ; Calculate remainder (digit)
    mov     r5, #10
    mul     r6, r4, r5              ; r6 = quotient * 10
    sub     r7, r3, r6              ; r7 = remainder = r3 - (quotient * 10)
    
    ; Store digit in buffer (in reverse order)
    strb    r7, [r1, r2]            ; Store digit
    add     r2, r2, #1              ; Increment digit counter
    
    ; Update hex value with quotient
    mov     r0, r4
    
    ; Continue loop
    b       hex_to_bcd_loop

store_done
    ; If the input was zero and we have no digits, add a zero
    cmp     r2, #0
    bne     reverse_digits
    mov     r7, #0
    strb    r7, [r1]
    mov     r2, #1

reverse_digits
    ; Now reverse the digits in the buffer
    mov     r3, #0                  ; Start index
    sub     r4, r2, #1              ; End index
    
    ; Check if we need to reverse
    cmp     r3, r4
    bge     conversion_done
    
reverse_loop
    ; Swap digits at r3 and r4
    ldrb    r5, [r1, r3]            ; Load digit at start
    ldrb    r6, [r1, r4]            ; Load digit at end
    strb    r6, [r1, r3]            ; Store end digit at start
    strb    r5, [r1, r4]            ; Store start digit at end
    
    ; Update indices
    add     r3, r3, #1
    sub     r4, r4, #1
    
    ; Check if we're done
    cmp     r3, r4
    blt     reverse_loop

conversion_done
    ; End of conversion, r2 contains the number of BCD digits
    ; BCD digits are stored in BCD_RESULT buffer

    ; Optionally terminate the BCD result with a null byte
    mov     r5, #0
    strb    r5, [r1, r2]
    
    b       done

done
    ; End of program
    END