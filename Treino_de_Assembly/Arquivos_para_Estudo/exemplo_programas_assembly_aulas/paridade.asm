TITLE PARIDADE
.MODEL SMALL
.DATA
    MSG1  DB 'ENTRE COM O NUMERO', 13,10,'$'
    NPAR  DB 13,10,'O NUMERO TEM PARIDADE PAR ', 13,10,'$'
    NIMPAR  DB 13,10,'O NUMERO TEM PARIDADE IMPAR', 13,10,'$'
.CODE
MAIN PROC
     MOV AX,@DATA
     MOV DS,AX
     LEA DX, MSG1
     MOV AH,09
     INT 21H
     MOV AH,1h       ;função DOS para entrada pelo teclado
     INT 21h         ;entra, caracter está no AL
     AND AL,0Fh      ;TRANSFORMA EN NUMERO
     MOV CX,4
VOLTA:
     SHR AL,1
     JNC SALTA
     INC BL
SALTA: LOOP VOLTA
     
     MOV AH,09    
     SHR BL,1
     JC IMPAR
     LEA DX, NPAR
     JMP IMPRIME
IMPAR:
     LEA DX, NIMPAR
IMPRIME:          
     INT 21H

    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN 
