	AREA |.data|, DATA, READWRITE
Fib_0 DCD 0
Fib_1 DCD 1
n DCD 10
Fib_n DCD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY

main
    LDR r1, =n         
    ldr r1, [r1]       

    mov r3, #0
    mov r4, #1    
    
    ldr r5, =Fib_n     
    str r3, [r5]                ;fib(0) = 0
    str r4, [r5, #4]            ;fib(1) = 1
    
    mov r0, #2                  ;start with fib(2)
    
loop
    cmp r0, r1         
    bge done           
    
    add r6, r3, r4              ;add fib(n-2) + fib(n-1)
    str r6, [r5, r0, lsl #2]    
    
    mov r3, r4         
    mov r4, r6         
    
    add r0, r0, #1     
    b loop             
    
done
    
    b done
	END