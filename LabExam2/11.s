	AREA |.data|, DATA, READWRITE
buffer DCD 1, 2, 3, 4, 5        
n DCD 5                         
k DCD 2                         
temp_buffer SPACE 20            

    AREA rotate_prog, CODE, READONLY
    EXPORT main
    ENTRY

main
    LDR R0, =buffer             
    LDR R1, =n                  
    LDR R1, [R1]                
    LDR R2, =k                  
    LDR R2, [R2]                
    BL rotate_k
    B end_program

rotate_k
    PUSH {R4-R9, LR}           
    LDR R3, =temp_buffer       
    MOV R4, #0                 
    
copy_first_k
    CMP R4, R2                 
    BGE copy_first_done
    
    LDR R5, [R0, R4, LSL #2]   
    STR R5, [R3, R4, LSL #2]   
    ADD R4, R4, #1             
    B copy_first_k
    
copy_first_done
    
    MOV R4, R2                 
    MOV R5, #0                 
    
shift_elements
    CMP R4, R1                 
    BGE shift_done
    
    LDR R6, [R0, R4, LSL #2]   
    STR R6, [R0, R5, LSL #2]   
    ADD R4, R4, #1             
    ADD R5, R5, #1             
    B shift_elements
    
shift_done
    
    LDR R3, =temp_buffer       
    SUB R4, R1, R2             
    MOV R6, #0                 
    
copy_temp_back
    CMP R6, R2                 
    BGE rotate_done
    
    LDR R7, [R3, R6, LSL #2]   
    STR R7, [R0, R4, LSL #2]   
    ADD R4, R4, #1             
    ADD R6, R6, #1             
    B copy_temp_back
    
rotate_done
    POP {R4-R9, LR}            
    BX LR                      

end_program
    B end_program              

    END