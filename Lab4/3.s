; ARM Cortex-M4 Assembly Program to convert a BCD number to its equivalent HEX number

    AREA    |.data|, DATA
; BCD number stored as bytes (one digit per byte) - 123456789
bcd_number  DCB     0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09
bcd_length  EQU     ($ - bcd_number)
hex_result  SPACE   4                       ; 32-bit result (can hold up to 9 BCD digits)

    AREA    |.text|, CODE, READONLY
    EXPORT  __main
    ENTRY

__main  PROC
    ; Convert BCD to HEX
    MOV     R0, #0              ; Clear R0 register to store result
    LDR     R1, =bcd_number     ; Load address of BCD number
    MOV     R2, #bcd_length     ; Load number of BCD digits
    
    ; Process each BCD digit
bcd_to_hex_loop
    CMP     R2, #0              ; Check if we processed all digits
    BEQ     bcd_to_hex_done     ; If done, exit loop
    
    MOV     R3, #10             ; Multiplier for decimal
    MUL     R0, R0, R3          ; Multiply current result by 10
    
    LDRB    R4, [R1], #1        ; Load next BCD digit and increment pointer
    ADD     R0, R0, R4          ; Add digit to result
    
    SUBS    R2, R2, #1          ; Decrement counter
    B       bcd_to_hex_loop     ; Continue loop
    
bcd_to_hex_done
    ; Store the result
    LDR     R1, =hex_result
    STR     R0, [R1]            ; Store result in memory
    
    ; End program
    B       .
    ENDP
    END