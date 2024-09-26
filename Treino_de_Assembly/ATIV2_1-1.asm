.MODEL SMALL
.DATA
    MSG1 DB 'Digite um caracter: $'
    MSG2 DB 10,13,'O caracter em maiusculo e: $'
.CODE
MAIN PROC
    
    ; Acessa às variáveis definidas em .DATA
         MOV AX,@DATA
         MOV DS,AX

    ; Exibe a MSG1 na tela do usuário
         MOV AH,9
         LEA DX,MSG1
         INT 21H

    ; Lê o caracter do teclado e salva o caracter lido em AL
         MOV AH,1
         INT 21H

    ; Copia o caracter lido em BL
         MOV BL,AL

   
    ; Converte para maiúscula subtraindo 32
         SUB BL,32


    ; Exibe o caracter Line Feed
         MOV AH,2
         MOV DL,10
         INT 21H

    ; Exibe a MSG2 na tela do usuário
         MOV AH,9
         LEA DX,MSG2
         INT 21H

    ; Exibe o caracter alterado para maiúsculo que foi lido (salvado anteriormente em BL)
         MOV AH,2
         MOV DL,BL
         INT 21H

    ; Finaliza o programa
         MOV AH, 4Ch
         INT 21H
MAIN ENDP
END MAIN