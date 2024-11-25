TITLE Entrada e Saida hexadecimal
.MODEL SMALL
.DATA

    MSG1  DB 13,10,'ENTRE COM O NUMERO HEXADECIMAL:  ', '$'
    NHEXA  DB 13,10,'O NUMERO EH ', 13,10,'$'
    
.CODE
MAIN PROC    
        MOV AX,@DATA
        MOV DS,AX
        MOV AH,09
        LEA DX, MSG1
        INT 21H 
        CALL ENTHEX
        MOV AH,09
        LEA DX, NHEXA
        INT 21H 
        CALL SAIHEX
        MOV AH,4CH
        INT 21H
main endp
ENTHEX PROC
        XOR BX,BX       ;inicializa BX com zero
        MOV CL,4        ;inicializa contador com 4
        MOV CH,4
        MOV AH,1h       ;prepara entrada pelo teclado
        INT 21h 
;WHILE
TOPO:   
        CMP AL,0Dh      ;? o CR ?
        JE  SAI
        CMP AL, 39h     ;caracter n?mero ou letra?
        JA  LETRA       ;caracter j? est? na faixa ASCII
        AND AL,0Fh      ;n?mero: retira 30h do ASCII
        JMP  DESL
LETRA:  SUB AL,37h      ;converte letra para bin?rio
DESL:   SHL BX,CL     ;desloca BX 4 casas ? esquerda
        OR BL,AL        ;insere valor nos bits 0 a 3 de BX
        DEC CH
        INT 21H
        JNZ TOPO        ;faz o la?o 4 VEZES
;end_while
SAI:
        RET
ENTHEX ENDP      
SAIHEX PROC     
;BX j? contem n?mero bin?rio
        MOV CH,4    ;CH contador de caracteres hexa
        MOV CL,4    ;CL contador de delocamentos
        MOV AH,2h   ;prepara exibi??o no monitor
;for 4 vezes do
TOPO1:  MOV DL,BH   ;captura em DL os oito bits mais significativos de BX
        SHR DL,CL   ;resta em DL os 4 bits mais significativos de BX
;if DL , 10
        CMP DL, 0Ah ;testa se ? letra ou n?mero
        JAE LETRA1
;then
        ADD DL,30h  ;? n?mero: soma-se 30h
        JMP PT1
;else
LETRA1:  ADD DL,37h  ;ao valor soma-se 37h -> ASCII
;end_if
PT1:    INT 21h     ;exibe
        ROL BX,CL   ;roda BX 4 casas para a direita
        DEC CH
        JNZ TOPO1    ;faz o FOR 4 vezes
;end_for
        RET
SAIHEX ENDP
end main

        