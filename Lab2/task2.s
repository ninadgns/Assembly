    AREA STACK, NOINIT, READWRITE, ALIGN=3
    SPACE 1024                  ; Reserve 1024 bytes for stack

    AREA |.vectors|, CODE, READONLY
    EXPORT __Vectors
__Vectors
    DCD __stack_top             ; Initial stack pointer
    DCD Reset_Handler           ; Reset handler
    DCD 0                       ; NMI handler (placeholder)
    DCD 0                       ; HardFault handler (placeholder)

    AREA |startup|, CODE, READONLY
__stack_top EQU STACK + 1024

    EXPORT Reset_Handler
Reset_Handler
    BL main                     ; Call main
    B .                         ; Loop forever if main returns

    AREA |.data|, DATA, READWRITE
X           DCW 0x4321          ; Define 16-bit value
Y           DCW 0x1234          ; Define another 16-bit value
Result_Add  DCW 0x0000          ; Placeholder for Addition result
Result_Sub  DCW 0x0000          ; Placeholder for Subtraction result
Result_Mul  DCD 0x0000          ; Placeholder for Multiplication result

    AREA |.text|, CODE, READONLY
main
    ; Load X into r1
    LDR r0, =X
    LDRH r1, [r0]

    ; Load Y into r2
    LDR r0, =Y
    LDRH r2, [r0]

    ; -------- Addition --------
    ADD r3, r1, r2              ; r3 = r1 + r2
    LDR r0, =Result_Add
    STRH r3, [r0]

    ; -------- Subtraction --------
    SUB r3, r1, r2              ; r3 = r1 - r2
    LDR r0, =Result_Sub
    STRH r3, [r0]

    ; -------- Multiplication --------
    MUL r3, r1, r2              ; r3 = r1 * r2
    LDR r0, =Result_Mul
    STR r3, [r0]                ; Store full 32 bits (since multiplication can overflow 16 bits)
	

STOP
    B STOP                      ; Infinite loop
    END