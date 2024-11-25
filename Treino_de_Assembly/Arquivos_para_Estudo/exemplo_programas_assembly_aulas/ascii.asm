TITLE   EXIBICAO DE CARACTERES ASCII
.MODEL  SMALL
.STACK   100H
.CODE
main proc
;inicializacao de alguns registradores
;
        MOV AH,2        		;funcao DOS para exibicao de caracter
        MOV CX,200		;contador com o numero total de caracteres
        MOV DL,20      	;DL inicializado com o primeiro ASCII
;
;definicao de um processo repetitivo de 256 vezes
;
PRINT_LOOP:
        	INT 21H         		;exibir caracter na tela
        	INC DL          		;incrementa o caracter ASCII
        	DEC CX          		;decrementa o contador
        	JNZ PRINT_LOOP	;continua exibindo enquanto CX nao for 0
;
;quando CX = 0, o programa quebra a sequencia do loop   ;saida para o DOS
;
        MOV AH,4CH
        INT 21H
        main endp
END MAIN
