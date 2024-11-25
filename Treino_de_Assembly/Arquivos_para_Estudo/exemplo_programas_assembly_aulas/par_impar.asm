TITLE PAR OU IMPAR
.MODEL SMALL
.DATA

    MSG1  DB 'ENTRE COM O NUMERO', 13,10,'$'
    NPAR  DB 13,10,'O NUMERO EH PAR ', 13,10,'$'
    NIMPAR  DB 13,10,'O NUMERO EH IMPAR', 13,10,'$'
.CODE
MAIN PROC
     MOV AX,@DATA
     MOV DS,AX

     LEA DX, MSG1
     MOV AH,09
     INT 21H

     MOV AH,1h       ;função DOS para entrada pelo teclado
     INT 21h         ;entra, caracter está no AL
     MOV DL,AL
     MOV AH,2
     INT 21H
     AND DL,0Fh      ;TRANSFORMA EN NUMERO
     MOV BL,DL

     MOV AH,9

     TEST BL,01H

     JNZ IMPAR

     LEA DX, NPAR
     
     INT 21H

     JMP FIM
IMPAR:
     LEA DX, NIMPAR
     
     INT 21H
     
FIM:
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN 
