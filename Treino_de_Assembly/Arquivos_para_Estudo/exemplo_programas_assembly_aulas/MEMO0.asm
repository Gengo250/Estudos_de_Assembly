
.MODEL small
.STACK 100h
 .DATA
    LF EQU 0AH
    CR EQU 0DH
    LINHA EQU 'OLA VAMOS COMECAR'

    MENS DB LINHA,LF,CR,'$'
	MSG1 DW 30H,31H,32H,33H,34H

.CODE
MAIN PROC
  

.CODE
	MOV AX,@DATA
    MOV DS,AX


   LEA DX, MENS
   MOV AH,9
   INT 21H
	LEA BX, MSG1     ; bx aponta para msg1
	MOV AX, [BX]       ; AX <- 0030h
    ADD BX,4
	MOV DL, [BX]          ; dl <- 00h
    
    MOV AH,4ch             ;DOS terminate program function
    INT  21h                ;terminate the program
MAIN ENDP
   END MAIN