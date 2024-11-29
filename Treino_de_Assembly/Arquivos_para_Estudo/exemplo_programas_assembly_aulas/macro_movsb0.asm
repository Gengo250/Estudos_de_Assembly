TITLE MACRO COPIA STRING
.MODEL SMALL
.STACK 0100H

PUSH_ALL  MACRO  
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
ENDM
POP_ALL  MACRO  
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
ENDM
IMP_STR MACRO FONTE,QUANTIDADE
    LOCAL REPETE
    PUSH_ALL
    CLD
    LEA SI, FONTE
    MOV AH,02
    MOV CX, QUANTIDADE
REPETE:
    MOV DL,[SI]
    INT 21H
    INC SI
    LOOP REPETE 
    POP_ALL
ENDM
COPIA_STR MACRO FONTE, DESTINO, QUANTIDADE
    LOCAL REPETE
    PUSH_ALL
    STD
    LEA SI, FONTE
    LEA DI, DESTINO
    ADD SI,7
    ADD DI,7
    MOV CX, QUANTIDADE
REPETE:
    MOVSB
    LOOP REPETE 
    POP_ALL
ENDM
.DATA
	STR1 DB 'OSC 2S24'
	STR2 DB  8 DUP(?)
	QTDE EQU 8
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX                ; inicializa DS
	MOV ES,AX                ; inicializa ES

	COPIA_STR STR1,STR2,QTDE
    IMP_STR STR2,8


    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN