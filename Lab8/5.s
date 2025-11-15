    AREA |.data|, data, readwrite

bcd_counter DCB 0x00        
delay_count DCD 100 ; demo value for testing      

    AREA |.text|, code, readonly
    EXPORT main
    ENTRY

main
    MOV r0, #0x00
    LDR r1, =bcd_counter    
    STRB r0, [r1]

counter_loop
    LDR r1, =bcd_counter
    LDRB r0, [r1]

    BL delay_1_second       

    BL increment_bcd        

    LDR r1, =bcd_counter
    STRB r0, [r1]

    CMP r0, #0xA0
    BNE counter_loop

    MOV r0, #0x00
    LDR r1, =bcd_counter
    STRB r0, [r1]
    B counter_loop          


increment_bcd
    PUSH {r1, r2, lr}

    AND r1, r0, #0x0F       
    AND r2, r0, #0xF0       
    LSR r2, r2, #4          

    ADD r1, r1, #1
    CMP r1, #10
    BLT no_carry

    MOV r1, #0   
    ADD r2, r2, #1          

    CMP r2, #10
    BLT no_carry

    MOV r0, #0xA0
    B increment_done

no_carry
    LSL r2, r2, #4
    ORR r0, r1, r2          

increment_done
    POP {r1, r2, lr}
    BX lr


delay_1_second
    PUSH {r0, r1, lr}

    LDR r0, =delay_count
    LDR r1, [r0]

delay_loop
    SUBS r1, r1, #1
    BNE delay_loop

    POP {r0, r1, lr}
    BX lr

    END
