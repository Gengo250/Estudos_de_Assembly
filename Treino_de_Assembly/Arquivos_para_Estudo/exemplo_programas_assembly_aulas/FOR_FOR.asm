TITLE   PROG FOR
.MODEL  SMALL
.STACK  100H
.CODE
MAIN    PROC
    MOV AH,02H
    MOV BX,20
    MOV CX,4
NOVA_LINHA:
    XCHG BX,CX
    MOV CX,20
    MOV DL,'*'

FACA_LINHA:
    INT 21H
LOOP FACA_LINHA

    MOV DL,10
    INT 21H 
    XCHG BX,CX
LOOP NOVA_LINHA
 
;retorno ao DOS

    MOV AH,4CH    ;funcao DOS para saida
    INT 21H              ;saindo
MAIN    ENDP
END MAIN