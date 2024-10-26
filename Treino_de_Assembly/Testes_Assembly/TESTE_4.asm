.model small
.stack 100h
.DATA
.code
main proc

        mov bl, 3 ;adiciona o valor 3 para o registrador bl
        mov cl, 3; adiciona o valor 3 para o registrador cl

        add bl, cl; soma bl e cl (3+3)
        add bl, '0'; converte o resultado ASCII que esta armazenado em bl em hexadecimal 

        mov dl, bl ;move o conteudo de bl para dl para saída do dado
        mov ah, 2; printa na tela o resultado final (6)
        int 21h 

        mov ah, 4ch; encerra o programa 
        int 21h

main ENDP
end main 