    AREA |.data|, DATA, READWRITE
BATTERY_LEVEL        DCD 0x00000020          
LOAD_STATUS        DCD 0x00000001          
MODE  DCD 0x00000000          
    
    AREA |.text|, CODE, READONLY
    EXPORT main
    ENTRY
main
    LDR r0, =0x20000000         
    LDR r1, [r0]                

    LDR r0, =0x20000004         
    LDR r2, [r0]                

    
    MOV r3, #2                  
    
    
    MOV r4, #20
    CMP r1, r4                  
    BHS check_high_battery      
    
    
    CMP r2, #1                  
    MOVEQ r3, #1                
    B store_result              
    
check_high_battery:
    
    MOV r4, #80
    CMP r1, r4                  
    MOVHI r3, #3                
    
store_result:
    LDR r0, =0x20000008         
    STR r3, [r0]                
    
    BX lr                       
    END