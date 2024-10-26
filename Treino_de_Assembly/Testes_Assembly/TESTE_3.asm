TITLE teste
.MODEL SMALL
.DATA
    MSG1 DB 10,13, "Digite um caracter: $"
    MSG2 db 10,13, "O caracter digitado foi: $"
.CODE
MAIN PROC

    MOV AX, @DATA ;inicializa o segmento .DATA
    MOV DS, AX

    MOV AH, 09
    LEA DX, MSG1 ; exibe a mensagem 1
    INT 21h

    mov ah, 1 ;lê o caracter e salva o conteúdo em AL
    int 21h 

    mov bl, AL ; move o conteúdo de al para bl

    mov ah, 09
    LEA dx, MSG2 ;exibe a mensagem 2
    int 21h 

    mov dl, bl ; move o contúdo salvo de bl para dl para o conteúdo ser ""traduzido" corretamente
    mov ah, 2
    int 21h 

    mov ah, 4ch ; encerra o programa 
    int 21h 


    MAIN ENDP 
    END MAIN