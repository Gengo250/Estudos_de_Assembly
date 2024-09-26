TITLE TESTE
.MODEL SMALL
.CODE
MAIN PROC

         MOV AH,2
         MOV DL,"?"
         INT 21h

         MOV AH,1
         INT 21h
    
         MOV BL,AL

         MOV AH,2
         MOV DL,10

         MOV AH,2
         MOV DL,13
         INT 21h

         MOV AH,2
         MOV DL,BL
         INT 21h

         MOV AH, 4Ch
         INT 21h

MAIN ENDP
    END MAIN 



