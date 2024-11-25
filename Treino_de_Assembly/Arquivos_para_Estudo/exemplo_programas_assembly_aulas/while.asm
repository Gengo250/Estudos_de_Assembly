.model small
.code
main proc
    mov ah,01
    xor cl,cl  ; contador
le_c:
    int 21h   ; le caracter
    cmp al,13 ; = CR?
    je fim    ; sim, termina
    inc cl    ; incrementa contador
    jmp le_c    ; le de novo
fim:
    mov ah,02
   ; mov dl,10
   ; int 21h
    mov dl,cl
    or dl,30h
    int 21h
    mov ah,4ch  ; fim programa
    int 21h
    main endp
    end main

