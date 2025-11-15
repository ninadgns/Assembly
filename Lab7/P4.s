	AREA |.data|, Data, Readwrite
Ara	DCD	5, 25, 10, 47, 15
Largest DCD    0


    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY

main 
	LDR r0, =Ara
	MOV r1, #4; last index
    MOV r2, #0; max value

LOOP
    LDR r3, [r0, r1, lsl #2] ; load Ara[r1]
    CMP r3, r2              ; compare with current max
    BLE SKIP               ; if Ara[r1] <= max, skip update
    MOV r2, r3              ; update max if Ara[r1] > max
SKIP
    SUBS r1, r1, #1        ; decrement index
    BPL LOOP               ; branch if r1 >= 0

    LDR r0, =Largest       ; load address of Largest
    STR r2, [r0]           ; store the largest value found

    END                     ;; end of program
