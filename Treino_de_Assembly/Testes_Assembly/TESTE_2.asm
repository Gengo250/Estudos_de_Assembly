TITLE TESTE
.MODEL SMALL
.CODE
MAIN PROC
 mov dl, '?'
 mov ah, 2
 int 21h
 
 mov ah, 4ch
 int 21h
MAIN ENDP
    END MAIN 



