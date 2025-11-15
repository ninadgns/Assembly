	AREA |.data|, DATA, READWRITE
Ara DCD 1, 2, 3, 4, 5, 6, 7, 11, 9, 10
n DCD 10

    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY

main
    LDR R0, =Ara      
    LDR R1, =n        
    LDR R1, [R1]      
    SUB R1, R1, #1    ;Compare till n-1
    MOV R3, #0        ;Index i
    MOV R7, #1        ;INITIALIZE RETURN VALUE TO BE 1(SORTED)

loop
    CMP R3, R1        
    BGE end           

    LDR R4, [R0, R3, LSL #2] ;i th element
    ADD R6, R3, #1    
    LDR R5, [R0, R6, LSL #2] ;i+1 th element
    CMP R4, R5        

    BGT not_sorted     
    
    ADD R3, R3, #1    
    B loop            

not_sorted
    MOV R7, #0 ; RETURN VALUE IN R7 IF NOT SORTED
    B end             
    
end
    END
