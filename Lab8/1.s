    AREA |.data|, data, readonly
ara DCD 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0x10, 0x11, 0x12

row DCD 4
rowidx DCD 2
colidx DCD 2

    AREA |.text|, code, readonly
    EXPORT main
    ENTRY

main
    ldr r0, =ara
    ldr r1, =row
    ldr r1, [r1]  ; Load row index
    ldr r2, =rowidx
    ldr r2, [r2]  ; Load row index value
    mov r2, r2, lsl #2  ; Shift row index to word offset
    ldr r3, =colidx
    ldr r3, [r3]  ; Load column index value
    mul r5, r1, r2  ; Calculate offset for row
    add r5, r5, r3, lsl #2  ; Add column offset
    ldr r4, [r0, r5]  ; Load the value at the specified row and column
    END
