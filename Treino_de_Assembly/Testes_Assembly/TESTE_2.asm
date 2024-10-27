TITLE TESTE
.MODEL SMALL
.DATA 
 MSG1 DB 10,13,"DIGITE UMA LETRA MAIUSCULA: $"
 MSG2 DB 10,13,"SUA LETRA minuscula CORRESPONDENTE: $"
.CODE
MAIN PROC
    mov ax, @DATA ;acessa o segmento .DATA
    mov ds, ax 

    mov ah, 9
    lea dx, MSG1 ;exibe a mensagem 1
    int 21h

    mov ah, 1 ;usuario digita o caracter e salva em AL
    int 21h

    mov bl, AL ;move o conteúdo para bl

    add bl, 32 ;adiciona 32 em bl para transformar a letra maiuscula para minuscula 

    mov ah, 9
    lea dx, MSG2 ;exibe a mensagem 2
    int 21h 

    mov ah, 2 
    mov dl, bl ;exibe o resultado esperado
    int 21h



    mov ah, 4Ch ;encerra o programa
    int 21h 

MAIN ENDP
    END MAIN 



