    AREA |.rodata|, DATA, READONLY
nums       DCD     10, 20, 30, 40, 50      ; Array of numbers
count      EQU     5                      ; Number of elements

    AREA |.data|, DATA, READWRITE
avgVal     DCD     0                      ; Result will be stored here

    AREA |.text|, CODE, READONLY
    ENTRY
    EXPORT main

main
    LDR     r0, =nums       ; r0 = pointer to array
    MOV     r1, #0          ; r1 = sum
    MOV     r2, #0          ; r2 = index (i)

loop
    CMP     r2, #count      ; while i < count
    BEQ     compute_avg     ; if i == count, exit loop

    LDR     r3, [r0], #4    ; r3 = nums[i], r0 += 4
    ADD     r1, r1, r3      ; sum += nums[i]
    ADD     r2, r2, #1      ; i++

    B       loop

compute_avg
    MOV     r4, #count      ; r4 = count
    CMP     r4, #0          ; avoid division by zero
    BEQ     stop

    SDIV    r5, r1, r4      ; r5 = sum / count (integer division)
    LDR     r6, =avgVal
    STR     r5, [r6]        ; store result

stop
    B       stop
    END
