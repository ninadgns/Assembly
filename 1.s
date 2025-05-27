    AREA    |.data|, DATA, READWRITE
DCD    W  0x12345678    ; Sample value for W
DCD    X  0x87654321    ; Sample value for X
DCD    Y  0xABCDEF01    ; Sample value for Y
DCD    Z  0x23456789    ; Sample value for Z
DCD    F  0x00000000    ; Result for F = W.X + Y.Z

    AREA |.text|, CODE, READONLY
    ENTRY
    EXPORT main

main
    ldr r0, =W
    ldr r1, [r0]
    ldr r0, =X
    ldr r2, [r0]
    and r3, r1, r2

    ldr r0, =Y
    ldr r1, [r0]
    ldr r0, =Z
    ldr r2, [r0]
    and r4, r1, r2
    mvn r4, r4

    orr r5, r3, r4

    ldr r0, =F
    str r5, [r0]

    B STOP                     
    END