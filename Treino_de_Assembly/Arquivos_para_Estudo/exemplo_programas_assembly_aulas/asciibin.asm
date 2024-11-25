.model small
.code
main proc
    mov ah,01
    int 21h
    and al,0fh
    mov ah,4ch  ; fim programa
    int 21h
main endp
end main