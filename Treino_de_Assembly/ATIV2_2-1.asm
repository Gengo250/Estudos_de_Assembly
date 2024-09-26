TITLE Mensagens
.MODEL SMALL
.DATA
    MSG1 DB 10,13, "Digite um primeiro numero (de 0 a 9): .$"
    MSG2 DB "digite um segundo numero (de 0 a 9) .$"
    MSG3 DB "A soma dos dois numeros eh: .$"
.CODE
MAIN PROC
    ; Permite o acesso às variáveis definidas em .DATA
         MOV AX,@DATA
         MOV DS,AX

    ; Exibe na tela a string MSG1
         MOV AH,9
         LEA DX,MSG1
         INT 21h

    ; Lê o primeiro número digitado, converte ele em ASCII e salva o número lido em AL
         MOV AH,1
         INT 21h
         SUB AL, '0'
         MOV BL, AL

    ;Exibe o caracter Line Feed (move o cursor para a linha seguinte)
         MOV AH,2
         MOV DL,10
         INT 21h

    ; Exibe na tela a string MSG2
         MOV AH,9
         LEA DX,MSG2
         INT 21h

    ;Lê o segundo número digitado, converte ele em ASCII e salva o caracter lido em AL
         MOV AH,1
         INT 21h
         SUB AL, '0'
         ADD BL, AL

    ;Exibe o caracter Line Feed (move o cursor para a linha seguinte)
         MOV AH,2
         MOV DL,10
         INT 21h


    ; Exibe na tela a string MSG3
         MOV AH,9
         LEA DX,MSG3
         INT 21h

    ;Converte o resultado para ASCII
         ADD BL, '0'
         MOV DL, BL
         MOV AH, 2
         INT 21h

 
    ; Finaliza o programa
         MOV AH,4Ch
         INT 21h

MAIN ENDP
END MAIN 
