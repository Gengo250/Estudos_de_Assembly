TITLE vetor  versao 0
.MODEL SMALL
.stack 0100h
.DATA
   
    NSOMA  DB 13,10,'A SOMA = ', '$'
    LISTA  DW 0,1,2,1,1,0,1,1,1,1
.CODE
MAIN PROC    
    MOV AX,@DATA
    MOV DS,AX
    
    XOR AX,AX          ;inicializa AX com zero
    XOR SI,SI       ;SI recebe INDICE 
    MOV CX, 10         ;contador inicializado no. de elementos
SOMA:   
        ADD AX,LISTA[SI]    ;acumula AX com o elemento de LISTA apontado por SI
        ADD SI,2       ;movimenta o ponteiro para o pr?ximo        
        LOOP  SOMA     ;faz o laco até CX = 0
    LEA DX, NSOMA
    PUSH AX
    MOV AH,09
    INT 21H
    POP AX
    MOV DX,AX
    OR DL,30H               ; numero em caractere
    MOV AH,2                ; imprime a soma
    INT 21H
    MOV AH,4CH              ; termina o programa
    INT 21H
MAIN ENDP
END MAIN
