.model small
.stack 100h 
.DATA
    array db 'a','b','c'; array de três elemnetos 
.code 
main proc 
    mov ax, @DATA ;transporta o array para ax para ser acessado
    mov ds, ax 

    mov si, offset array ;acessa ao conteúdo do array 

    mov cx, 3 ; contador cx = 3 

    l1:
        mov dx, [si]
        mov ah, 2 ;printando os elementos do array 
        int 21h 
        inc si 
    loop l1

    mov ah, 4Ch ;encerra o programa 
    int 21h 
main endp
end main 