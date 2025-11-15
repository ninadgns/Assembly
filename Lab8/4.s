    AREA |.data|, DATA, readwrite
bcd_value   DCB 0x57
binary_out  DCD 0            

    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY

main
    LDR r0, =bcd_value      
    LDRB r1, [r0]           
    BL BCD_binary           

    LDR r3, =binary_out     
    STR r2, [r3]

    B .                     

BCD_binary
    AND r3, r1, #0xF0       
    MOV r3, r3, LSR #4      
    MOV r5, #10             
    MUL r3, r3, r5          

    AND r4, r1, #0x0F       
    ADD r2, r3, r4          

    BX lr
