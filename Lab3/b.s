	AREA |.rodata|, DATA, READONLY
a        DCD        0xF0000005

    AREA |.data|, DATA, READWRITE
LSRResult  DCD        0
ASRResult   DCD        0
LSLResult  DCD        0

 
    AREA problem1, CODE, READONLY

    ENTRY
    
    EXPORT main
main

 
	LDR     r0, =a            
    LDR    r1, [r0]          

    LSR   r2, r1, #2
    LDR     r0, =LSRResult

    STR    r2, [r0]

    ASR   r3, r1, #2
    LDR     r0, =ASRResult
    STR    r3, [r0]

    LSL   r4, r1, #2
    LDR     r0, =LSLResult
    STR    r4, [r0]


stop 
 B stop
 END