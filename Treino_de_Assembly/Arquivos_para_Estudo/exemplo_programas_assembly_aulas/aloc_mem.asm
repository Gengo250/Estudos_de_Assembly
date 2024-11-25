.model small

    .DATA
	MSG1  DW 30h,31h,32h,33h,34h

.code
main proc
	mov ax,@data
    mov ds,ax
	LEA BX, MSG1     ; bx aponta para msg1
	MOV AX, [BX]       ; AX <- 0045h
	ADD BX,4               ; bx aponta para 
	MOV DL, [BX]          ; dl <- 00h
	
    mov ah,4ch
    int 21h
main endp
end main