	AREA |.data|, Data, Readwrite
Ara	DCD	5, 10, 15, 20, 25
FirstElement DCD    0
LastElement  DCD    0
	
    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY

main 
	LDR r0, =Ara
	MOV r1, #4; last index
	MOV r2, #0; first index

    LDR r3, [r0] ; Load first element
    LDR r4, [r0, r1, LSL #2] ; Load last element

    LDR r5, =FirstElement
    STR r3, [r5] ; Store first element

    LDR r6, =LastElement
    STR r4, [r6] ; Store last element
    END