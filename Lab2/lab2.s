
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
Num1        DCW 0x0018          ; First number (120 in decimal)
Num2        DCW 0x002A          ; Second number (42 in decimal)
SmallerNum  DCW 0x0000          ; Will store the smaller number
    
    AREA |.text|, CODE, READONLY
main
    ; Load the values of Num1 and Num2
    LDR r0, =Num1               ; Load address of Num1
    LDRH r1, [r0]               ; Load value of Num1 into r1
    
    LDR r0, =Num2               ; Load address of Num2
    LDRH r2, [r0]               ; Load value of Num2 into r2
    
    ; Compare the two numbers
    CMP r1, r2                  ; Compare r1 (Num1) with r2 (Num2)
    BLS Num1IsSmaller           ; Branch if r1 <= r2 (Num1 is smaller or equal)
    
    ; If we get here, Num2 is smaller
    LDR r0, =SmallerNum         ; Load address of SmallerNum
    STRH r2, [r0]               ; Store Num2 as the smaller number
    B Done                      ; Branch to Done
    
Num1IsSmaller
    LDR r0, =SmallerNum         ; Load address of SmallerNum
    STRH r1, [r0]               ; Store Num1 as the smaller number
    
Done
STOP
    B STOP                      ; Infinite loop
    END