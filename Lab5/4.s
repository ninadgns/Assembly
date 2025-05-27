AREA    |.data|, DATA, READWRITE
Input          DCB     0x5F          ; Input data byte (8 bits)
Output         DCW     0x0000        ; Output data halfword (16 bits)

    AREA |.text|, CODE, READONLY     
    ENTRY                          
    EXPORT main                    

main
    ; Load the address of Input into r0
    ldr r0, =Input
    ; Load the byte from Input into r1
    ldrh r1, [r0]

    ; Extract the lower 4 bits (least significant nibble)
    and r2, r1, #0x0F   
    
    ; Extract the upper 4 bits (most significant nibble)
    and r3, r1, #0xF0
    ; Shift left 4 bits to move to higher byte position
    lsl r3, r3, #4
        
    ; Combine the two parts into the final result
    orr r4, r3, r2     
    
    ; Store the result in Output
    ldr r0, =Output
    strh r4, [r0]

