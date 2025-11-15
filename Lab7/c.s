; Microprocessor and Assembly Language Lab 6
; ARM Cortex-M4 Assembly Language Programs for Array Operations
; Date: June 17, 2025

.text
.global _start

; =============================================================================
; Task 1: Show first and last element of an Array
; =============================================================================
_start:
    ; Load base address of array into R5
    ADR R5, Buffer
    
    ; Get first element (Buffer[0])
    LDR R0, [R5]           ; R0 = Buffer[0] (first element)
    
    ; Get last element (Buffer[4] for 5-element array)
    LDR R1, [R5, #16]      ; R1 = Buffer[4] (last element, offset = 4*4 = 16)
    
    ; Store results for display
    STR R0, FirstElement
    STR R1, LastElement
    
    B Task2                ; Jump to next task

; =============================================================================
; Task 2: Summation of array elements
; =============================================================================
Task2:
    ; Initialize
    ADR R5, Buffer         ; Base address of array
    MOV R0, #0             ; Sum accumulator
    MOV R1, #0             ; Array index
    MOV R2, #5             ; Array size

SumLoop:
    CMP R1, R2             ; Compare index with array size
    BGE SumDone            ; Branch if index >= size
    
    LDR R3, [R5, R1, LSL #2]  ; R3 = Buffer[R1], LSL #2 multiplies by 4
    ADD R0, R0, R3         ; Add element to sum
    ADD R1, R1, #1         ; Increment index
    B SumLoop
    
SumDone:
    STR R0, ArraySum       ; Store the sum
    B Task3

; =============================================================================
; Task 3: Reverse an Array
; =============================================================================
Task3:
    ; Copy original array to working array first
    ADR R5, Buffer         ; Source array
    ADR R6, WorkArray      ; Destination array
    MOV R1, #0             ; Index
    MOV R2, #5             ; Array size

CopyLoop:
    CMP R1, R2
    BGE CopyDone
    LDR R3, [R5, R1, LSL #2]
    STR R3, [R6, R1, LSL #2]
    ADD R1, R1, #1
    B CopyLoop

CopyDone:
    ; Now reverse the working array
    MOV R1, #0             ; Left index
    MOV R2, #4             ; Right index (size-1)

ReverseLoop:
    CMP R1, R2             ; If left >= right, done
    BGE ReverseDone
    
    ; Swap elements at positions R1 and R2
    LDR R3, [R6, R1, LSL #2]  ; Load left element
    LDR R4, [R6, R2, LSL #2]  ; Load right element
    STR R4, [R6, R1, LSL #2]  ; Store right at left position
    STR R3, [R6, R2, LSL #2]  ; Store left at right position
    
    ADD R1, R1, #1         ; Move left pointer right
    SUB R2, R2, #1         ; Move right pointer left
    B ReverseLoop

ReverseDone:
    B Task4

; =============================================================================
; Task 4: Find largest element of array
; =============================================================================
Task4:
    ADR R5, Buffer         ; Base address
    LDR R0, [R5]           ; Initialize max with first element
    MOV R1, #1             ; Start from second element
    MOV R2, #5             ; Array size

FindMaxLoop:
    CMP R1, R2             ; Check if we've processed all elements
    BGE FindMaxDone
    
    LDR R3, [R5, R1, LSL #2]  ; Load current element
    CMP R3, R0             ; Compare with current max
    BLE SkipUpdate         ; Branch if current <= max
    MOV R0, R3             ; Update max if current > max

SkipUpdate:
    ADD R1, R1, #1         ; Move to next element
    B FindMaxLoop

FindMaxDone:
    STR R0, MaxElement     ; Store the maximum element
    B Task5

; =============================================================================
; Task 5: Element-wise sum of two arrays
; =============================================================================
Task5:
    ADR R5, Array1         ; Base address of first array
    ADR R6, Array2         ; Base address of second array
    ADR R7, ResultArray    ; Base address of result array
    MOV R1, #0             ; Array index
    MOV R2, #5             ; Array size

AddArraysLoop:
    CMP R1, R2             ; Check if done
    BGE AddArraysDone
    
    LDR R3, [R5, R1, LSL #2]  ; Load element from Array1
    LDR R4, [R6, R1, LSL #2]  ; Load element from Array2
    ADD R0, R3, R4         ; Add the elements
    STR R0, [R7, R1, LSL #2]  ; Store result
    
    ADD R1, R1, #1         ; Next index
    B AddArraysLoop

AddArraysDone:
    ; Program complete - infinite loop
    B .

; =============================================================================
; Data Section
; =============================================================================
.data
.align 4

; Main test array
Buffer:         .word 10, 25, 3, 47, 15    ; Test data

; Additional arrays for Task 5
Array1:         .word 1, 2, 3, 4, 5
Array2:         .word 5, 4, 3, 2, 1
ResultArray:    .word 0, 0, 0, 0, 0        ; Will store sum results

; Working array for reversing
WorkArray:      .word 0, 0, 0, 0, 0

; Result storage locations
FirstElement:   .word 0
LastElement:    .word 0
ArraySum:       .word 0
MaxElement:     .word 0

.end