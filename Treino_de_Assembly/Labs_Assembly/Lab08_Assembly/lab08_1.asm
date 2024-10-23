.MODEL SMALL
.STACK 100H
.DATA
    msgInput DB 'Digite um numero binario (ate 16 bits): $'
    msgResult DB 0DH, 0AH, 'O valor binario armazenado em BX e: $'
    CR DB 13 ; Carriage Return (Enter)
.CODE
START:
    ; Inicializa DS
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a mensagem de entrada
    MOV AH, 09H
    LEA DX, msgInput
    INT 21H

    ; Limpa BX (zera BX)
    XOR BX, BX

READ_LOOP:
    ; Lê um caractere do teclado
    MOV AH, 01H
    INT 21H

    ; Verifica se o caractere é CR (fim da entrada)
    CMP AL, CR
    JE END_INPUT

    ; Converte o caractere de ASCII '0' ou '1' para binário
    SUB AL, '0'

    ; Desloca BX uma posição à esquerda
    SHL BX, 1

    ; Armazena o bit lido no LSB de BX
    OR BL, AL

    ; Repete o loop para o próximo caractere
    JMP READ_LOOP

END_INPUT:
    ; Exibe a mensagem de resultado
    MOV AH, 09H
    LEA DX, msgResult
    INT 21H

    ; Exibe o valor binário armazenado em BX
    CALL PRINT_BINARY

    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H

; Rotina para exibir o valor binário armazenado em BX
PRINT_BINARY PROC
    PUSH AX
    PUSH BX
    MOV CX, 16       ; Número de bits para exibir (16 bits)

PRINT_LOOP:
    ; Desloca BX para a esquerda e coloca o bit mais significativo no carry
    SHL BX, 1
    JC PRINT_1       ; Se carry = 1, imprime '1'
    MOV DL, '0'      ; Se carry = 0, imprime '0'
    JMP PRINT_CHAR

PRINT_1:
    MOV DL, '1'

PRINT_CHAR:
    MOV AH, 02H      ; Função de imprimir caractere
    INT 21H
    LOOP PRINT_LOOP  ; Repete até imprimir todos os 16 bits

    POP BX
    POP AX
    RET
PRINT_BINARY ENDP

END START
