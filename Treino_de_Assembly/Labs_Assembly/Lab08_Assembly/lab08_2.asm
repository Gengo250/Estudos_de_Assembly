.MODEL SMALL
.STACK 100H
.DATA
    msgInput DB 'Entre com um numero decimal (maximo 16 bits): $'
    msgResult DB 0DH, 0AH, 'O valor binario armazenado em BX e: $'
    CR DB 13 ; Carriage Return (Enter)
.CODE
START:
    ; Inicializa DS
    MOV AX, @DATA
    MOV DS, AX

    ; Exibir mensagem de entrada
    MOV AH, 09H
    LEA DX, msgInput
    INT 21H

    ; Limpa BX para armazenar o resultado
    XOR BX, BX

READ_CHAR:
    ; Lê um caractere do teclado
    MOV AH, 01H
    INT 21H

    ; Verifica se é o marcador de fim de string (CR)
    CMP AL, CR
    JE END_INPUT

    ; Converte o caractere '0' ou '1' para valor binário
    SUB AL, '0'

    ; Desloca BX uma posição à esquerda e coloca o bit lido
    ROL BX, 1    ; Rotaciona BX à esquerda (abre espaço no LSB)
    OR BL, AL    ; Coloca o bit lido no LSB de BX

    ; Continua lendo o próximo caractere
    JMP READ_CHAR

END_INPUT:
    ; Exibir mensagem de resultado
    MOV AH, 09H
    LEA DX, msgResult
    INT 21H

    ; Exibir o valor binário em BX
    CALL PRINT_BINARY

    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H

; Rotina para imprimir o valor binário armazenado em BX
PRINT_BINARY PROC
    PUSH AX
    PUSH BX
    MOV CX, 16       ; 16 bits de BX

PRINT_LOOP:
    ; Desloca BX para a esquerda e imprime o bit mais significativo
    RCL BX, 1
    JC PRINT_1       ; Se carry flag = 1, imprimir '1'
    MOV DL, '0'      ; Caso contrário, imprimir '0'
    JMP PRINT_CHAR

PRINT_1:
    MOV DL, '1'

PRINT_CHAR:
    MOV AH, 02H      ; Função de imprimir caractere
    INT 21H
    LOOP PRINT_LOOP  ; Continua até imprimir todos os 16 bits

    POP BX
    POP AX
    RET
PRINT_BINARY ENDP

END START
