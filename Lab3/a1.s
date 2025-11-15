	AREA |.rodata|, DATA, READONLY
a        DCW        13       
b        DCW        9       

    AREA |.data|, DATA, READWRITE
ANDResult  DCW        0
ORResult   DCW        0
EORResult  DCW        0
NANDResult  DCW        0

 
    AREA problem1, CODE, READONLY

    ENTRY
    
    EXPORT main
main

 
	LDR     r0, =a            
    LDRH    r1, [r0]          

    LDR     r0, =b            
    LDRH    r2, [r0]          


 
    AND     r3, r1, r2        
    LDR     r0, =ANDResult    
    STRH    r3, [r0]          

 
    ORR     r4, r1, r2        
    LDR     r0, =ORResult     
    STRH    r4, [r0]          

 
 EOR     r5, r1, r2        
    LDR     r0, =EORResult    
    STRH    r5, [r0]          

 
 AND  r6, r1, r2        
 MVN  r6, r6     
    LDR     r0, =NANDResult    
    STRH    r6, [r0]          

stop 
 B stop
 END