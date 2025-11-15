
	AREA |.data|, DATA, READWRITE
Num1        DCD 0x00180018          ; First number (120 in decimal)
Num2        DCD 0x002A002A          ; Second number (42 in decimal)
SmallerNum  DCD 0x00000000          ; Will store the smaller number
    


        AREA    |.text|, CODE, READONLY
    EXPORT  __main
    ENTRY

__main  PROC

    ; Load the values of Num1 and Num2
    LDR r0, =Num1               ; Load address of Num1
    LDR r1, [r0]               ; Load value of Num1 into r1
    
    LDR r0, =Num2               ; Load address of Num2
    LDR r2, [r0]               ; Load value of Num2 into r2
    
    ; Compare the two numbers
    CMP r1, r2                  ; Compare r1 (Num1) with r2 (Num2)
    MOVGT R5, #1                ; If A > B, set R5 = 1
    MOVEQ R5, #0                ; If A == B, set R5 = 0
    MOVLT R5, #-1               ; If A < B, set R5 = -1

    LDR r0, =SmallerNum
    STR R5, [R0]                ; Store result to memory
	
    END



