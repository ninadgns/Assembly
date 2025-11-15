    Area |.data|, Data, Readwrite
Ara 10, 20, 30, 40, 50, 60

    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY
main


LDR r0, =Ara       ; r0 = address of Ara
    MOV r2, #5         ; r2 = end index
    MOV r3, #0         ; r3 = start index

Loop
    LDR r4, [r0, r2, LSL #2] ; r4 = Ara[r2]
    LDR r5, [r0, r3, LSL #2] ; r5 = Ara[r3]
    STR r5, [r0, r2, LSL #2] ; Ara[r2] = r5
    STR r4, [r0, r3, LSL #2] ; Ara[r3] = r4
    ADDS r3, r3, #1
    SUBS r2, r2, #1
    CMP r3, r2
    BLT Loop           ; continue while r3 < r2