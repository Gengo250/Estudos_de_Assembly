.model small
.data
  stri db 12,?,12 dup ('$')
.code
main proc
	mov ax,@data
	mov ds,ax

	lea dx,stri
	mov ah,0ah
	int 21h

	mov ah,02
	mov dl,10
	int 21h
	
	
	lea dx,stri
	add dx,2
	mov ah,09
	int 21h
    mov ah,4ch
    int 21h
main endp
end main