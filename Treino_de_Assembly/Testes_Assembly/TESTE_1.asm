TITLE mensagem
.MODEL SMALL 
.STACK 100H
.DATA
    MSG1 DB "ROLA. $"
    MSG2 DB 10,13,"PICA. $"

.CODE
MAIN PROC
         MOV AX,@DATA
         MOV DS,AX

         MOV AH,9
         LEA DX,MSG1
         INT 21h

         MOV AH,9
         LEA DX,MSG2
         INT 21h

         MOV AH,4Ch
         INT 21h

MAIN ENDP
END MAIN

