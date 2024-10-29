TITLE Impressão e leitura de Matriz com a soma dos números
.MODEL SMALL
.STACK 100h

.DATA
MATRIZ DB 4 dup(4 dup(?))
msg1 DB 10,13,"INSIRA UM NUMERO: $",10,13


.CODE

; Macro para pular linha
NOVA_LINHA MACRO
    push ax
    push dx
    MOV DL, 0Dh         ; Retorno de carro
    MOV AH, 02h
    INT 21h
    MOV DL, 0Ah         ; Nova linha
    INT 21h
    pop dx
    pop ax
ENDM

LER PROC
parte1:
    MOV Ch,4
    xor bx,bx
lecol:
    mov cl,4
    XOR SI,SI

leitura:
    LEA DX,msg1
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    NOVA_LINHA
    sub AL,30h
    MOV MATRIZ [BX + SI], AL
    INC SI
    dec cl
    jnz leitura
    add bx,4
    dec ch
    jnz lecol
    RET
LER ENDP

IMPRIMIR PROC

    MOV Ch,4
    xor bx,bx
imp1:
    mov cl,4
    XOR SI,SI

imp2:

    MOV AH,2
    mov dl, matriz[bx+si]
    or dl,30h
    INT 21H
    
    INC SI
    dec cl
    jnz imp2
    add bx,4
    dec ch
    nova_linha
    jnz imp1
    RET

IMPRIMIR ENDP


soma proc
    mov ch,4
    xor bx,bx
    sm1:
    mov cl,4
    xor si,si
    sm2:
    MOV AL, matriz[bx+si]
    SUB AL,30h
    ADD DL,AL
    inc si
    dec cl
    jnz sm2
    add BX,4
    dec ch
    jnz sm1
    RET

    soma endp

soma_impresao proc

mov al,dl
or al,30h
mov ah,2
int 21h
ret
soma_impresao endp
MAIN PROC

MOV AX,@DATA
MOV DS,AX

CALL ler
CALL Imprimir
CALL soma
CALL soma_impresao

    MOV AH, 4Ch          ; Função de término do programa
    INT 21h

MAIN ENDP
END MAIN