.model small 
.stack 100h 
.DATA
.code
main proc 

mov bl, 3 ;adiciona o valor 3 para o registrador bl
mov cl, 1; adiciona o valor 1 para o registrador cl

sub bl, cl ;subtrai o valor de cl em bl (bl-cl)
add bl, '0' ;para convertero valor da subtração armazena em bl temos que converter o numero ASCII para o seu respctivo hexadecimal adicionando 48 em bl ou '0'

mov dl, bl

mov ah, 2 ;imprime na tela o resultdo armazenado em bl
int 21h

mov ah,4ch ;encerra o programa 
int 21h


main ENDP
end main 