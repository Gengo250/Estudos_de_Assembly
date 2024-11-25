
.MODEL small
.STACK 100h
 .DATA
	MSG1 DW 1234h,5678h
.CODE
MAIN PROC
  

.CODE
	MOV AX,@DATA
    MOV DS,AX
    MOV CX,4
	LEA BX, MSG1     ; bx aponta para msg1
	MOV AX, [BX]       ; AX <- 0030h
.VOLTA:
	INC BX               ; bx aponta para 
	MOV DL, [BX]          ; dl <- 00h
    LOOP .VOLTA
    MOV AH,4ch             ;DOS terminate program function
    INT  21h                ;terminate the program
MAIN ENDP
   END MAIN