
	AREA |.data|, DATA, READWRITE
Num1        DCD 0x00180018          
Num2        DCD 0x002A002A          
Result  DCD 0x00000000          
    


        AREA    |.text|, CODE, READONLY
    EXPORT  main
    ENTRY

main  PROC

    
    LDR r0, =Num1               
    LDR r1, [r0]               
    
    LDR r0, =Num2               
    LDR r2, [r0]               
    
    
    CMP r1, r2                  
    MOVGT R5, #1                
    MOVEQ R5, #0                
    MOVLT R5, #-1               

    LDR r0, =Result
    STR R5, [R0]                
	
    END



