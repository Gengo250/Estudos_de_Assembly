.MODEL SMALL
.DATA
    reg_ax DB 'registrador AX$'
    reg_bx DB 'registrador BX$'
    reg_igual DB 'registrador BX = registrador AX$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV AX,0001H
    MOV BX, 0001H
    MOV CX,AX
    CMP AX,BX
    JG AX_MAIOR
    JE IGUAL
    LEA DX,reg_bx
    MOV CX,BX
    JMP IMPRIME
AX_MAIOR:
    LEA DX,reg_ax
    JMP IMPRIME
IGUAL:
    LEA DX,reg_igual
IMPRIME:
    MOV AH,09H
    INT 21H
MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN