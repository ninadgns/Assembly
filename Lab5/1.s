AREA    |.data|, DATA, READWRITE
W           DCD         0x12345678    ; Sample value for W
X           DCD         0x87654321    ; Sample value for X
Y           DCD         0xABCDEF01    ; Sample value for Y
Z           DCD         0x23456789    ; Sample value for Z
F           DCD         0x00000000    ; Result for F = W.X + Y.Z


    AREA |.text|, CODE, READONLY     ; Code section
    ENTRY                           ; Program entry point
    EXPORT main                     ; Make main visible to the linker

main
    ; Calculate W AND X
    ldr r0, =W                      ; Load address of W into r0
    ldr r1, [r0]                    ; Load value of W into r1
    ldr r0, =X                      ; Load address of X into r0
    ldr r2, [r0]                    ; Load value of X into r2
    and r3, r1, r2                  ; r3 = W AND X

    ; Calculate NOT(Y AND Z)
    ldr r0, =Y                      ; Load address of Y into r0
    ldr r1, [r0]                    ; Load value of Y into r1
    ldr r0, =Z                      ; Load address of Z into r0
    ldr r2, [r0]                    ; Load value of Z into r2
    and r4, r1, r2                  ; r4 = Y AND Z
    mvn r4, r4                      ; r4 = NOT(Y AND Z)

    ; Calculate F = (W AND X) OR NOT(Y AND Z)
    orr r5, r3, r4                  ; r5 = r3 OR r4

    ; Store result in F
    ldr r0, =F                      ; Load address of F into r0
    str r5, [r0]                    ; Store result in F

    END                             ; End of program