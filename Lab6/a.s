    AREA |.rodata|, DATA, READONLY
BATTERY_LEVEL        DCD 0x00180018          ; First number (120 in decimal)
LOAD_STATUS        DCD 0x002A002A          ; Second number (42 in decimal)

    AREA |.data|, DATA, READWRITE
MODE  DCD 0x00000000          ; Will store the smaller number
    
    AREA |.text|, CODE, READONLY
    EXPORT __main
    ENTRY
__main
    LDR r0, =BATTERY_LEVEL
    LDR r1, [r0]

    LDR r0, =LOAD_STATUS
    LDR r2, [r0]

    MOV r5, #20

    mov r3, #2                 ; If battery level is between 20 and 80, set r3 = 2
    cmp r1, r5
    movlt r3, #1                ; If battery level < 20, set r3 = 1

    mov r5, #80
    cmp r1, r5
    movgt r3, #3                ; If battery level > 80, set r3 = 2

    
    LDR r0, =MODE
    STR r3, [r0]                ; Store result to memory
    BX lr                       ; Return from main

    END