Title Lab05_04.asm
.MODEL SMALL
.STACK 100H
.CODE
Main Proc
    MOV AX, @DATA
    MOV DS, AX

    MOV BL, 'a'      ; Inicia com a letra 'a'
    MOV CL, 0        ; Contador de letras por linha

IMPRIME_LETRA:
    MOV DL, BL       ; Carrega a letra atual em DL
    MOV AH, 02H      ; Função de saída de caractere do DOS
    INT 21H

    INC BL           ; Próxima letra
    INC CL           ; Incrementa o contador de letras na linha

    CMP CL, 4        ; Verifica se já foram impressas 4 letras
    JNE VERIFICA_FIM
    ; Se sim, imprime nova linha
    MOV DL, 13       ; Carriage Return (CR)
    MOV AH, 02H
    INT 21H
    MOV DL, 10       ; Line Feed (LF)
    MOV AH, 02H
    INT 21H
    MOV CL, 0        ; Reseta o contador de letras na linha

VERIFICA_FIM:
    CMP BL, 'z'+1    ; Verifica se chegou após a letra 'z'
    JNE IMPRIME_LETRA

    ; Verifica se restam letras sem quebra de linha
    CMP CL, 0
    JE FIM_PROGRAMA

    ; Imprime nova linha se necessário
    MOV DL, 13
    MOV AH, 02H
    INT 21H
    MOV DL, 10
    MOV AH, 02H
    INT 21H

FIM_PROGRAMA:
    MOV AH, 4CH      ; Termina o programa
    INT 21H

MAIN ENDP
END MAIN
