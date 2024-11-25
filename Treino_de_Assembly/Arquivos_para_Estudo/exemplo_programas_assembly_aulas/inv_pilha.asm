TITLE Matriz
.MODEL SMALL
.STACK 0100H
.CODE
MAIN PROC  
    
    CALL INVERTE

    MOV AH,4CH              ; termina o programa
    INT 21H
MAIN ENDP

INVERTE PROC NEAR
;   INVERTE STRING LIDO
;   UTILIZA AX, CX E DX - SALVOS NA PILHA E RESTAURADOS

    PUSH AX
    PUSH CX
    PUSH DX

    MOV AH,02
    MOV DL,'?'
    INT 21H

    XOR CX,CX
    MOV AH,01
LER:
    INT 21H
    CMP AL,0DH
    JE SAI
    PUSH AX
    INC CX
    JMP LER
SAI:
    
    JCXZ FIM
    MOV AH,02
IMPRIME:
    POP DX
    INT 21H
    LOOP IMPRIME
FIM:
    POP DX
    POP CX
    POP AX
    RET
INVERTE ENDP
END MAIN
