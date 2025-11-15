    AREA |.data|, DATA, readwrite
; Four bytes of data stored in memory
data_bytes  DCB 0x12, 0x34, 0x56, 0x78  ;; Example data to be added
result      DCD 0                         ; Storage for final result

    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY

main
    LDR r0, =data_bytes     ; r0 = base address of data
    MOV r1, #4              ; r1 = number of bytes to add
    MOV r2, #0              ; r2 = accumulator for sum
    MOV r5, #0              ; r5 = carry register

loop
    LDRB r3, [r0], #1       ; Load one byte from memory and increment pointer
    BL Add_byte             ; Call subroutine to add r3 to r2 with carry tracking
    SUBS r1, r1, #1         ; Decrement byte counter
    BNE loop                ; If more bytes, continue loop

    LDR r4, =result         ; Store final sum into result
    STR r2, [r4]

    B .

; Subroutine: Add_byte
; Adds byte in r3 to accumulator r2
; If overflow (carry out of 8 bits), increment r5
Add_byte
    ADDS r2, r2, r3         ; Add byte to accumulator with flags
    BCC no_carry            ; If no carry, skip
    ADD r5, r5, #1          ; If carry, increment carry register
no_carry
    BX lr                   ; Return from subroutine
