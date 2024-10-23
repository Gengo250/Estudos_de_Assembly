.MODEL SMALL
.STACK 100H
.DATA
    msgInput DB 'Digite um numero hexadecimal (ate 4 digitos): $'
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

    ; Converte o caractere hexadecimal para binário
    ; Se o caractere for de '0' a '9'
    CMP AL, '9'
    JBE DIGIT_09
    ; Se o caractere for de 'A' a 'F'
    CMP AL, 'A'
    JB INVALID_CHAR
    CMP AL, 'F'
    JA INVALID_CHAR
    SUB AL, 'A' - 10
    JMP SHIFT_BX

DIGIT_09:
    SUB AL, '0'

SHIFT_BX:
    ; Desloca BX 4 bits para a esquerda para preparar para o próximo dígito
    SHL BX, 4

    ; Insere o valor binário nos 4 bits inferiores de BX
    OR BL, AL

    ; Continua lendo o próximo caractere
    JMP READ_LOOP

INVALID_CHAR:
    ; Em caso de caractere inválido, podemos ignorar ou tratar de outra forma
    JMP READ_LOOP

END_INPUT:
    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H

END START
