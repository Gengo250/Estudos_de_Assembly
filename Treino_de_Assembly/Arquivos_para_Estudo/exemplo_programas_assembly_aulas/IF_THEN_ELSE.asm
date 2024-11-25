TITLE   PROG IF
.MODEL  SMALL
.STACK  100H
.CODE
MAIN    PROC
;
;inicializando o registrador DS
  
    MOV AL,'X'
    MOV BL,'R'
    MOV AH,02H
    CMP AL,BL
    JAE  ENTAO   
    MOV DL,al
    JMP SAI
ENTAO:          ;continuação do programa    
    MOV DL,bl
;retorno ao DOS
SAI:
    INT 21H
    MOV AH,4CH    ;função DOS para saída
    INT 21H              ;saindo
MAIN    ENDP
        END MAIN
