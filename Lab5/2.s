AREA    |.data|, DATA, READWRITE

P           DCW         0x20F2       ; P = 0010000011110010
Q           DCW         0x30F0       ; Q = 0011000011110000
R           DCW         0xC4F8       ; R = 1100010011111000
F_Result    DCW         0x0000      ; Result for bit field operation


    AREA |.text|, CODE, READONLY     ; Code section
    ENTRY                           ; Program entry point
    EXPORT main                     ; Make main visible to the linker

main

    ldr r0, =P                      ; Load address of P into r0
    ldrh r1, [r0]                   ; Load value of P into r1 (half word)
    ldr r0, =Q                      ; Load address of Q into r0
    ldrh r2, [r0]                   ; Load value of Q into r2 (half word)
    ldr r0, =R                      ; Load address of R into r0
    ldrh r3, [r0]                   ; Load value of R into r3 (half word)

    lsr r1, r1, #9                  ; Right shift P by 9 bits to position target bits
    lsr r2, r2, #1                  ; Right shift Q by 1 bit to position target bits
    lsr r3, r3, #5                  ; Right shift R by 5 bits to position target bits

    and r1, r1, #0x3F               ; Mask P to keep only 6 lower bits (0-5)
    and r2, r2, #0x3F               ; Mask Q to keep only 6 lower bits (0-5)
    and r3, r3, #0x3F               ; Mask R to keep only 6 lower bits (0-5)

    orr r4, r1, r2                  ; r4 = bitwise OR of masked P and Q
    eor r4, r4, r3                  ; r4 = bitwise XOR of previous result and masked R
    and r4, r4, #0x3E               ; Final mask to keep only bits 1-5 (0x3E = 111110)

    
    ldr r0, =F_Result               ; Load address of F_Result into r0
    str r4, [r0]                    ; Store the final result in F_Result
    END                             ; End of program
