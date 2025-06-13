; TEAM PROJECT A: BUBBLE SORT - USER INPUTS 8 NUMBERS (0-100) AND DISPLAYS SORTED OUTPUT

; LC-3 Bubble Sort Program
; Reads 8 numbers from user (0-100), sorts ascending, prints sorted list

.ORIG x3000

    ; Initialize stack pointer (not strictly necessary here, but reserved)
    LEA R6, STACK

	; Print prompt
    LEA R0, PROMPT
    PUTS

	; Call input routine
    JSR READ_INPUTS      ; Get numbers from the user

	; Call bubble sort routine
    JSR BUBBLE_SORT      ; Sort the numbers with bubble sort

	; Call print routine
    JSR PRINT_ARRAY      ; Print the sorted results
    HALT

;========================
; READ_INPUTS
; Reads 8 decimal numbers into ARRAY
;========================
READ_INPUTS
    ST R1, SAVE_R1
    ST R2, SAVE_R2
    ST R3, SAVE_R3
    LEA R1, ARRAY        ; Pointer to array start
    AND R2, R2, #0       ; Counter = 0

READ_LOOP
     ;===Read tens digit=== 
    GETC
    OUT
    LD R3, ZERO_CHAR
    NOT R3, R3
    ADD R3, R3, #1
    ADD R0, R0, R3       ; Make it 0–9
    AND R4, R4, #0
    ADD R4, R0, R0
    ADD R4, R4, R4
    ADD R4, R4, R4
    ADD R4, R4, R0
    ADD R4, R4, R0       ; Multiply by 10

    ;===Read ones digit===
    GETC
    OUT
    LD R3, ZERO_CHAR
    NOT R3, R3
    ADD R3, R3, #1
    ADD R0, R0, R3       ; Make it 0–9

    ADD R0, R0, R4       ; Combine tens and ones
    STR R0, R1, #0       ; Store the number

    GETC                 ; Get the ENTER
    LD R3, ASCII_NEWLINE
    OUT

    ADD R1, R1, #1       ; Go to next element  in array
    ADD R2, R2, #1       ; Increment 1
    ADD R3, R2, #-8      ; Check if it is 8 numbers yet
    BRn READ_LOOP        ; If not, keep going

    LD R1, SAVE_R1
    LD R2, SAVE_R2
    LD R3, SAVE_R3
    RET

;========================
; BUBBLE_SORT
; Sorts 8-element array ascending order
;========================
BUBBLE_SORT
    ST R1, SAVE_R1
    ST R2, SAVE_R2
    ST R3, SAVE_R3
    ST R4, SAVE_R4
    ST R5, SAVE_R5

    LD R4, COUNT_8
    ADD R4, R4, #-1      ; Outer loop: 7 passes

OUTER_LOOP
    AND R1, R1, #0       ; Start inner loop at index 0
    LEA R5, ARRAY
    LD R3, COUNT_8
    ADD R3, R3, #-1      ; Inner loop: up to 7

IN_LOOP
    LDR R2, R5, #0       ; Get current
    LDR R6, R5, #1       ; Get next
    NOT R0, R6
    ADD R0, R0, #1
    ADD R0, R2, R0
    BRn NO_SWAP
    STR R6, R5, #0       ; Swap if out of order
    STR R2, R5, #1

NO_SWAP
    ADD R5, R5, #1
    ADD R3, R3, #-1
    BRp IN_LOOP           ; Do the next inner pass

    ADD R4, R4, #-1
    BRp OUTER_LOOP        ; More outer passes

    LD R1, SAVE_R1
    LD R2, SAVE_R2
    LD R3, SAVE_R3
    LD R4, SAVE_R4
    LD R5, SAVE_R5
    RET

;========================
; PRINT_ARRAY
; Prints 8 decimal numbers, one per line
;========================
PRINT_ARRAY
    ST R1, SAVE_R1
    ST R2, SAVE_R2
    ST R3, SAVE_R3
    
    LEA R0, RESULT_PROMPT
    PUTS

    LEA R1, ARRAY
    LD R2, COUNT_8

PRINT_LOOP
    LDR R3, R1, #0
    AND R4, R4, #0
    ADD R4, R3, #0

    AND R5, R5, #0        ; Tens digit
PRINT_TENS
    ADD R4, R4, #-10
    BRn PRINT_ONES
    ADD R5, R5, #1
    BRnzp PRINT_TENS

PRINT_ONES
    ADD R4, R4, #10       ; Restore ones

    LD R0, ZERO_CHAR
    ADD R0, R0, R5
    OUT                   ; Print tens place
    LD R0, ZERO_CHAR
    ADD R0, R0, R4
    OUT                   ; Print ones place
    LD R0, ASCII_NEWLINE
    OUT                   ; New line

    ADD R1, R1, #1
    ADD R2, R2, #-1
    BRp PRINT_LOOP

    LD R1, SAVE_R1
    LD R2, SAVE_R2
    LD R3, SAVE_R3
    RET

;========================
; Data
;========================
ARRAY        .BLKW 8
COUNT_8      .FILL #8
ZERO_CHAR    .FILL x0030
ASCII_NEWLINE .FILL x000A
PROMPT        .STRINGZ "Enter 8 numbers (00-99), press ENTER after each:\nExample: 01, 09, 45, etc.\n"
RESULT_PROMPT .STRINGZ "Result:\n"
SAVE_R1      .BLKW 1
SAVE_R2      .BLKW 1
SAVE_R3      .BLKW 1
SAVE_R4      .BLKW 1
SAVE_R5      .BLKW 1
STACK        .BLKW 20

.END
