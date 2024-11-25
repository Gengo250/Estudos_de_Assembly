TITLE   PROG MAIOR
.MODEL  SMALL
.STACK  100H
.DATA
   MSG1 DB 'AX É O MAIOR',13,10,'$'
   MSG2 DB 'BX É O MAIOR',13,10,'$'
   MSG3 DB 'AX = BX',13,10,'$'
.CODE
MAIN    PROC
;inicializando o registrador DS
        MOV AX,@DATA
        MOV DS,AX    	;segmento dados inicializado
	MOV AX,7FFFH
	MOV BX,7FFFH
	MOV  CX,AX    	;AX já é pressuposto ser o maior deles
	CMP  AX,BX
	JG  MAIOR
    JL MENOR
    LEA DX, MSG3
	MOV AH,09H
	INT 21H	
    JMP EXIT
MENOR:	
    LEA DX, MSG2
	MOV AH,09H
	INT 21H
	MOV  CX,BX	;caso BX seja de fato o maior deles
	JMP EXIT
MAIOR:			;continuação do programa
    LEA DX, MSG1
	MOV AH,09H
	INT 21H
;retorno ao DOS
EXIT:
        MOV AH,4CH    ;funcao DOS para saida
        INT 21H              ;saindo
MAIN    ENDP
        END MAIN
