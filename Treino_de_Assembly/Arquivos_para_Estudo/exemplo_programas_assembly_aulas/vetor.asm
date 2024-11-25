TITLE vetor  versao 0
.MODEL SMALL
.stack 0100h
.DATA
   
   ; NSOMA  DB 13,10,'A SOMA = ', '$'
   LISTA  DW 0,1,2,3,4
.CODE
MAIN PROC    
    MOV AX,@DATA
    MOV DS,AX
    
     XOR BX,BX 
    MOV CX, 5         ;contador inicializado no. de elementos
EMPILHA:   
        ;ADD AX,[LISTA + BX]    ;acumula AX com o elemento de LISTA apontado por SI
        PUSH LISTA[BX] 
        ADD BX,2       
        LOOP  EMPILHA     ;faz o laco até CX = 0
        MOV CX,5
        MOV BP,SP
     DESEMPILHA:
        MOV DX,[BP]               ;********************************
         OR DL,30H               ; numero em caractere
         ADD BP,2
        MOV AH,2                ; imprime a soma
        INT 21H
        LOOP DESEMPILHA
    MOV AH,4CH              ; termina o programa
    INT 21H
MAIN ENDP
END MAIN
