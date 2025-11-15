    AREA |.rodata|, DATA, READONLY
nums       DCD     7, 13, -8, 25, 0x10, -30, 18
count      EQU     7                 ; number of elements

    AREA |.data|, DATA, READWRITE
maxVal     DCD     0

    AREA |.text|, CODE, READONLY
    ENTRY
    EXPORT main

main
    LDR     r0, =nums       ; r0 points to start of array
    LDR     r1, [r0], #4    ; r1 = nums[0], and r0 points to next element
    MOV     r2, r1          ; r2 = max = nums[0]
    MOV     r4, #1          ; r4 = index (starts from 1)

loop
    CMP     r4, #count      ; compare index with count
    BEQ     done            ; if all elements processed, exit loop

    LDR     r1, [r0], #4    ; r1 = nums[i], post-increment pointer
    CMP     r1, r2          ; compare current element with max. r1-r2
    MOVGT   r2, r1          ; if current > max, update max
    ADD     r4, r4, #1      ; i++

    B       loop            ; repeat loop

done
    LDR     r3, =maxVal
    STR     r2, [r3]        ; store max in memory

stop
    B stop
    END
