	AREA |.data|, Data, Readwrite
Ara1	DCD	5, 10, 15, 20, 25
Ara2    DCD	1, 2, 3, 4, 5
AraSum DCD	0, 0, 0, 0, 0
	
    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY


main 
	LDR r0, =Ara1
    LDR r1, =Ara2
    LDR r2, =AraSum
    MOV r3, #4 ; last index

LOOP
    LDR r4,[r0, r3, lsl #2] ; load Ara1[r3]
    LDR r5,[r1, r3, lsl #2] ; load Ara2[r3]
    ADD r6, r4, r5         ; sum Ara1[r3] + Ara2[r3]
    STR r6, [r2, r3, lsl #2] ; store result in AraSum[r3]
    SUBS r3, r3, #1        ; decrement index
    BPL LOOP               ; branch if r3 >= 0
    END                     ;; end of program