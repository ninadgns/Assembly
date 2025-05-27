; ARM Cortex-M4 Assembly Program to perform division on 8-bit, 16-bit, and 32-bit numbers

    AREA    |.data|, DATA
; 8-bit numbers
num8_dividend    DCB     200         ; 8-bit dividend
num8_divisor     DCB     5           ; 8-bit divisor
quot8            SPACE   1           ; 8-bit quotient
rem8             SPACE   1           ; 8-bit remainder
    
; 16-bit numbers
num16_dividend   DCW     30000       ; 16-bit dividend
num16_divisor    DCW     123         ; 16-bit divisor
quot16           SPACE   2           ; 16-bit quotient
rem16            SPACE   2           ; 16-bit remainder
    
; 32-bit numbers
num32_dividend   DCD     2000000000  ; 32-bit dividend
num32_divisor    DCD     1234567     ; 32-bit divisor
quot32           SPACE   4           ; 32-bit quotient
rem32            SPACE   4           ; 32-bit remainder

    AREA    |.text|, CODE, READONLY
    EXPORT  __main
    ENTRY

__main  PROC
    ; Division of 8-bit numbers
    LDR     R0, =num8_dividend   ; Load address of dividend
    LDRB    R0, [R0]             ; Load 8-bit dividend
    LDR     R1, =num8_divisor    ; Load address of divisor
    LDRB    R1, [R1]             ; Load 8-bit divisor
    
    ; Perform division
    UDIV    R2, R0, R1           ; R2 = R0 / R1 (quotient)
    MLS     R3, R2, R1, R0       ; R3 = R0 - (R2 * R1) (remainder)
    
    ; Store results
    LDR     R4, =quot8
    STRB    R2, [R4]             ; Store quotient
    LDR     R4, =rem8
    STRB    R3, [R4]             ; Store remainder
    
    ; Division of 16-bit numbers
    LDR     R0, =num16_dividend  ; Load address of dividend
    LDRH    R0, [R0]             ; Load 16-bit dividend
    LDR     R1, =num16_divisor   ; Load address of divisor
    LDRH    R1, [R1]             ; Load 16-bit divisor
    
    ; Perform division
    UDIV    R2, R0, R1           ; R2 = R0 / R1 (quotient)
    MLS     R3, R2, R1, R0       ; R3 = R0 - (R2 * R1) (remainder)
    
    ; Store results
    LDR     R4, =quot16
    STRH    R2, [R4]             ; Store quotient
    LDR     R4, =rem16
    STRH    R3, [R4]             ; Store remainder
    
    ; Division of 32-bit numbers
    LDR     R0, =num32_dividend  ; Load address of dividend
    LDR     R0, [R0]             ; Load 32-bit dividend
    LDR     R1, =num32_divisor   ; Load address of divisor
    LDR     R1, [R1]             ; Load 32-bit divisor
    
    ; Perform division
    UDIV    R2, R0, R1           ; R2 = R0 / R1 (quotient)
    MLS     R3, R2, R1, R0       ; R3 = R0 - (R2 * R1) (remainder)
    
    ; Store results
    LDR     R4, =quot32
    STR     R2, [R4]             ; Store quotient
    LDR     R4, =rem32
    STR     R3, [R4]             ; Store remainder
    
    ; End program
    B       .
    ENDP
    END