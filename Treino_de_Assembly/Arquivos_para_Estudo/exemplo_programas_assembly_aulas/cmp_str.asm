title le string com backspace
.MODEL SMALL
.STACK 0100H
.DATA
	STR1 DB 'ABC' 
	STR2 DB 'ABC'
	NAO DB 'NAO$'
	SIM DB 'SIM$'
	.CODE
main proc
	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX                	; inicializa ES
	MOV CX,3
	CLD                             	; zera DF
	LEA SI,STR1     	; aponta STR1
	LEA DI,STR2
	REPE CMPSB
	 JZ eh
        	LEA DX, NAO
        	JMP IMPR
eh:
        	LEA DX,SIM
IMPR:
        	MOV AH,9 
	INT 21H 	
    mov ah,4ch
    int 21h
    end main