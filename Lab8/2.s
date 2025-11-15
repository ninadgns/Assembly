	AREA |.data|, data, readwrite
; Matrix A (3x3)
matrixA DCD 2, 4, 6, 1, 3, 5, 0, 2, 8
; Matrix B (3x3)  
matrixB DCD 1, 0, 2, 3, 4, 5, 6, 7, 8
; Result matrix C (3x3) - initialized to zeros
matrixC DCD 0, 0, 0, 0, 0, 0, 0, 0, 0

; Matrix dimensions
rowsA   DCD 3      ; Rows of matrix A
colsA   DCD 3      ; Columns of matrix A (also rows of matrix B)
colsB   DCD 3      ; Columns of matrix B

    AREA |.text|, code, readonly
    EXPORT main
    ENTRY

main
    ; Load matrix addresses
    ldr r0, =matrixA    ; Base address of matrix A
    ldr r1, =matrixB    ; Base address of matrix B
    ldr r2, =matrixC    ; Base address of result matrix C
    
    ; Load matrix dimensions
    ldr r3, =rowsA
    ldr r3, [r3]        ; r3 = rows of A
    ldr r4, =colsA
    ldr r4, [r4]        ; r4 = columns of A (rows of B)
    ldr r5, =colsB
    ldr r5, [r5]        ; r5 = columns of B
    
    ; Initialize loop counters
    mov r6, #0          ; i = 0 (row counter for A)
    
outer_loop
    cmp r6, r3          ; Compare i with rows of A
    bge end_program     ; If i >= rowsA, exit
    
    mov r7, #0          ; j = 0 (column counter for B)
    
middle_loop
    cmp r7, r5          ; Compare j with columns of B
    bge next_row        ; If j >= colsB, go to next row
    
    mov r8, #0          ; k = 0 (inner loop counter)
    mov r9, #0          ; sum = 0 (accumulator for C[i][j])
    
inner_loop
    cmp r8, r4          ; Compare k with columns of A
    bge store_result    ; If k >= colsA, store result
    
    ; Calculate A[i][k] address: A + (i * colsA + k) * 4
    mul r10, r6, r4     ; i * colsA
    add r10, r10, r8    ; i * colsA + k
    lsl r10, r10, #2    ; (i * colsA + k) * 4
    ldr r11, [r0, r10]  ; Load A[i][k]
    
    ; Calculate B[k][j] address: B + (k * colsB + j) * 4
    mul r12, r8, r5     ; k * colsB
    add r12, r12, r7    ; k * colsB + j
    lsl r12, r12, #2    ; (k * colsB + j) * 4
    ldr r12, [r1, r12]  ; Load B[k][j] (reuse r12)
    
    ; Multiply A[i][k] * B[k][j] and add to sum
    mul r11, r11, r12   ; A[i][k] * B[k][j] (reuse r11)
    add r9, r9, r11     ; sum += A[i][k] * B[k][j]
    
    add r8, r8, #1      ; k++
    b inner_loop
    
store_result
    ; Calculate C[i][j] address: C + (i * colsB + j) * 4
    mul r10, r6, r5     ; i * colsB
    add r10, r10, r7    ; i * colsB + j
    lsl r10, r10, #2    ; (i * colsB + j) * 4
    str r9, [r2, r10]   ; Store sum in C[i][j]
    
    add r7, r7, #1      ; j++
    b middle_loop
    
next_row
    add r6, r6, #1      ; i++
    b outer_loop
    
end_program
    ; Program ends here
    mov r0, #0          ; Return 0
    bx lr               ; Return to caller
    
    END
