Title Lab05_05.ASM
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Digite um numero (0-9): $'
    MSG2 DB 10,13,'A somatoria e: $'
.CODE
MAIN PROC
    ; Acessa às variáveis definidas em .DATA
         MOV AX,@DATA
         MOV DS,AX

    ; Inicializa a soma
         MOV SI, 0

    ; Loop para ler 5 números
    MOV CX, 5
READ_NUMBERS:
    ; Exibe a MSG1 na tela do usuário
         MOV AH,9
         LEA DX,MSG1
         INT 21H

    ; Lê um número do teclado e salva o número lido em AL
         MOV AH,1
         INT 21H

    ; Converte o caractere ASCII para número
         SUB AL, '0'

    ; Adiciona o número à soma
         ADD SI, AX

    ; Decrementa o contador e repete o loop
         LOOP READ_NUMBERS

    ; Exibe o caracter Line Feed
         MOV AH,2
         MOV DL,10
         INT 21H

    ; Exibe a MSG2 na tela do usuário
         MOV AH,9
         LEA DX,MSG2
         INT 21H

    ; Converte a soma para ASCII e exibe
         MOV AX, SI
         ADD AX, '0'
         MOV DL, AL
         MOV AH, 2
         INT 21H

    ; Finaliza o programa
         MOV AH, 4Ch
         INT 21H
MAIN ENDP
END MAIN
