AREA    |.data|, DATA, READWRITE
Number          DCD     0x0000C123    ; Original 32-bit number
Complement      DCD     0x00000000    ; Storage for the complement result

    AREA |.text|, CODE, READONLY     
    ENTRY                          
    EXPORT main                    

main
    ldr r0, =Number                 ; Load address of Number into r0
    ldr r1, [r0]                    ; Load the value of Number into r1

    mvn r1, r1                      ; Perform one's complement (NOT) operation on r1

    ldr r0, =Complement             ; Load address of Complement into r0
    str r1, [r0]                    ; Store the complemented value into Complement

    end                             ; End of program