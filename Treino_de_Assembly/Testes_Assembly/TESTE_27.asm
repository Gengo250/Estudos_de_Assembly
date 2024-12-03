TITLE RotateVector
.MODEL SMALL
.STACK 100h

.DATA
    ; Define the vector of 5 elements
    vector      DW 1, 2, 3, 4, 5    ; Original vector

    ; Define the rotation count k
    k           DW 2               ; Rotate 2 times to the left

    ; Messages for display
    msgOriginal DB 'Original Vector: $'
    msgRotated  DB 13, 10, 'Rotated Vector: $'

    ; Buffer for displaying elements
    buffer      DB 6 DUP ('$')      ; Buffer for number to string conversion

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display original vector
    LEA DX, msgOriginal
    MOV AH, 09h
    INT 21h

    LEA SI, vector
    MOV CX, 5                       ; Number of elements
    CALL DisplayVector

    ; Rotate the vector k times
    MOV CX, k                       ; Load rotation count
RotateLoop:
    CALL RotateLeft
    LOOP RotateLoop

    ; Display rotated vector
    LEA DX, msgRotated
    MOV AH, 09h
    INT 21h

    LEA SI, vector
    MOV CX, 5                       ; Number of elements
    CALL DisplayVector

    ; Terminate program
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

;------------------------------------------------------------
; Procedure to rotate the vector to the left by one position
;------------------------------------------------------------
RotateLeft PROC
    ; Save registers
    PUSH AX
    PUSH BX
    PUSH CX ; cx = 2
    PUSH SI

    ; Rotate vector[0..4] to the left by one position
    LEA SI, vector
    MOV AX, [SI]                    ; AX = vector[0]
    MOV CX, 4                       ; Number of elements to shift

ShiftLoop:
    MOV BX, [SI+2]                  ; BX = vector[i+1]
    MOV [SI], BX                    ; vector[i] = vector[i+1]
    ADD SI, 2
    LOOP ShiftLoop

    MOV [SI], AX                    ; vector[4] = original vector[0]

    ; Restore registers
    POP SI
    POP CX
    POP BX
    POP AX
    RET
RotateLeft ENDP

;------------------------------------------------------------
; Procedure to display the vector elements
; Input: SI points to the vector, CX = number of elements
;------------------------------------------------------------
DisplayVector PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    ; Display elements
DisplayLoop:
    MOV AX, [SI]                    ; Load element
    LEA DI, buffer
    CALL WordToString               ; Convert number to string

    ; Display the number
    MOV AH, 09h
    LEA DX, buffer
    INT 21h

    ; Display space
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ADD SI, 2                       ; Move to next element
    LOOP DisplayLoop

    ; New line
    MOV AH, 02h
    MOV DL, 13                      ; Carriage Return
    INT 21h
    MOV DL, 10                      ; Line Feed
    INT 21h

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DisplayVector ENDP

;------------------------------------------------------------
; Procedure to convert a word in AX to a string in DI
;------------------------------------------------------------
WordToString PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    ; Initialize variables
    MOV SI, DI                      ; SI points to the buffer
    MOV CX, 0                       ; Digit counter

    ; Check if AX is zero
    CMP AX, 0
    JNE ConvertLoop
    MOV BYTE PTR [SI], '0'
    INC SI
    JMP ConvertEnd

ConvertLoop:
    MOV BX, 10
DivideLoop:
    XOR DX, DX                      ; Clear DX
    DIV BX                          ; AX / 10
    PUSH DX                         ; Remainder
    INC CX                          ; Increment digit counter
    CMP AX, 0
    JNE DivideLoop

; Pop digits and store in buffer
PopDigits:
    POP DX
    ADD DL, '0'
    MOV [SI], DL
    INC SI
    LOOP PopDigits

ConvertEnd:
    ; Terminate string
    MOV BYTE PTR [SI], '$'

    ; Restore registers
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
WordToString ENDP

END MAIN
