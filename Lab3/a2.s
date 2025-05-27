	AREA |.rodata|, DATA, READONLY
a        DCD        5        
b        DCD        11       

    AREA |.data|, DATA, READWRITE
ANDResult  DCD        0
ORResult   DCD        0
EORResult  DCD        0
NANDResult  DCD        0

 
    AREA problem1, CODE, READONLY

    ENTRY
    
    EXPORT main
main

 
	LDR     r0, =a            
    LDR    r1, [r0]          

    LDR     r0, =b            
    LDR    r2, [r0]          


 
    AND     r3, r1, r2        
    LDR     r0, =ANDResult    
    STR    r3, [r0]          

 
    ORR     r4, r1, r2        
    LDR     r0, =ORResult     
    STR    r4, [r0]          

 
 EOR     r5, r1, r2        
    LDR     r0, =EORResult    
    STR    r5, [r0]          

 
 AND  r6, r1, r2        
 MVN  r6, r6     
    LDR     r0, =NANDResult    
    STR    r6, [r0]          

stop 
 B stop
 END