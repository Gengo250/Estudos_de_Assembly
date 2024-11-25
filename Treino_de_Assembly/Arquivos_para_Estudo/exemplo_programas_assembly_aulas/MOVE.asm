
.MODEL small
.STACK 100h
 .DATA
    MENS DB 'ALO',13,10,'$'

    
.CODE
MAIN PROC
  

.CODE
	MOV AX,@DATA
    MOV DS,AX

    LEA DX, MENS
    MOV AH,9
    INT 21H
    
    ADD MENS,20H

    LEA DX, MENS
    MOV AH,9
    INT 21H
	     
    
    MOV AH,4ch             ;DOS terminate program function
    INT  21h                ;terminate the program
MAIN ENDP
   END MAIN