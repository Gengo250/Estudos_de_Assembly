TITLE Matriz
.MODEL SMALL
.stack 0100h
pula_linha macro
    PUSH AX
    PUSH DX
    MOV AH,02
    MOV DL,10
    INT 21H
    POP DX
    POP AX
endm

.DATA
    VETOR DB ?,?,?,?
    MATRIZ DW 1,2,3,4
           DW 5,6,7,8
           DW 9,10,11,12
           
    NMATRIZ  DB 13,10,'A MATRIZ = ', 13,10, '$'
    ;PULA_LINHA  DB, 13, 10, '$'

.CODE
MAIN PROC    
    MOV AX,@DATA
    MOV DS,AX
    LEA BX,VETOR
    MOV [BX],1
    ;XOR AX,AX          ;inicializa AX com zero
    XOR SI,SI             ;inicializa o indexador de coluna
    MOV BX,16          ;BX indica o 1o. elemento da linha 3
    MOV CX,4           ;CX contem o número de elementos de linha
L1:     MOV MATRIZ [BX][SI], 0      ;carrega na linha 3
        ADD SI,2           ;incrementa 2 em SI -> tipo DW = 2 bytes
        LOOP L1          ;faz o laço até que CX seja zero
    LEA DX, NMATRIZ    ; IMPRIME MENSAGEM EM NMATRIZ
    MOV AH,09
    INT 21H
    MOV AH,2                                       ;inicializa o indexador de coluna
    MOV BX,0                     ;BX indica o 1o. elemento da linha 2
    MOV DI,3                        ; número de LINHAS
L2:
    XOR SI,SI     
    MOV CX,4                        ;CX contem o número de elementos de linha
L3:     MOV DX, MATRIZ [BX][SI]      ;carrega zero no operando calculado
        OR DL,30H                   ; nUmero em caractere
                           ; imprime a soma
        INT 21H
        ADD SI,2                    ;incrementa 2 em SI -> tipo DW = 2 bytes
        LOOP L3 
   ;LEA DX, PULA_LINHA
    ;MOV AH,09H
   ; INT 21H
   pula_linha
    ADD BX,8
    DEC DI
    JNZ L2    
    MOV AH,4CH              ; termina o programa
    INT 21H
MAIN ENDP
END MAIN
