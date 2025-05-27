    AREA    |.data|, DATA, READWRITE
Input          DCB     0x5F
Output      DCW     0x0000

    AREA |.text|, CODE, READONLY
    ENTRY
    EXPORT main

main

    ldr r0, =Input
    ldrh r1, [r0]

    and r2, r1, #0x0F   

    and r3, r1, #0xF0
    lsl r3, r3, #4
    
    
    orr r4, r3, r2     
    

    ldr r0, =Output
    strh r4, [r0]      

