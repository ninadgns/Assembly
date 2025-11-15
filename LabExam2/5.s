    AREA |.data|, DATA, READWRITE
Ara        DCD  10, 12, 14,2, 4, 6, 8, 16          
Length      DCD 8
    
    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY
main
    ldr r0, =Ara
    ldr r1, =Length
    ldr r1, [r1]
    BL find_min_max


find_min_max
    push {r5, r6, r7, lr}  
    mov r5, r0            
    mov r6, r1            

    ldr r7, [r5]         
    mov r3, r7  ;min          
    mov r4, r7      ;max      
    add r5, r5, #4        
    subs r6, r6, #1       
loop
    cmp r6, #0            
    beq end_loop          
    ldr r7, [r5]         
    cmp r7, r4           
    bgt update_max        
    cmp r7, r3           
    blt update_min        
    b next_element        
update_max
    mov r4, r7           
    b next_element        
update_min
    mov r3, r7           
next_element
    add r5, r5, #4       
    subs r6, r6, #1      
    b loop                
	
end_loop
	b .
	END