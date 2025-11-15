	AREA |.data|, Data, Readwrite
Ara1	DCD	5, 10, 15, 20, 25
Sum	DCD	0
	
    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY


main 
	LDR r0, =Ara
	MOV r1, #4; last index
	MOV r3, #0; sum 
	
LOOP
	LDR r2, [r0, r1, lsl #2]
	ADD r3, r3, r2
	SUBS r1, r1, #1
	BPL LOOP
	
	LDR r0, =Sum
	STR r3, [r0]
	END