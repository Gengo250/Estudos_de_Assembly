TITLE Mensagens
.MODEL SMALL
.DATA
 MSG1 DB 10,13, "ESCREVA UM CARACTER: .$"
 MSG2 DB "O CARACTER DIGITADO FOI: .$"
.CODE
 MAIN PROC
 ; Permite o acesso às variáveis definidas em .DATA
 MOV AX,@DATA
 MOV DS,AX

; Exibe na tela a string MSG1
 MOV AH,9
 LEA DX,MSG1
 INT 21h
; Lê um caracter do teclado e salva o caracter lido em AL
 MOV AH,1
 INT 21h

; Copia o caracter lido para BL
 MOV BL,AL

;Exibe o caracter Line Feed (move o cursor para a linha seguinte) 
 MOV AH,2
 MOV DL,10 
 INT 21h

; Exibe na tela a string MSG2 
 MOV AH,9
 LEA DX,MSG2
 INT 21h

; Exibe o caracter lido (salvo em BL)
 MOV AH,2
 MOV DL,BL
 INT 21h
 
 ; Finaliza o programa
 MOV AH,4Ch
 INT 21h

 MAIN ENDP
END MAIN 
