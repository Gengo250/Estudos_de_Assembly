TITLE mensagem
.MODEL SMALL 
.STACK 100H
.DATA
    MSG1 DB 10,13,"Digite o primeiro numero: $"
    MSG2 DB 10,13,"Digite o segungo numero:  $"
    MSG3 DB 10,13,"Resultado: $"

.CODE
MAIN PROC
  mov ax, @DATA
  mov ds, ax 

  mov ah, 9
  lea dx, MSG1
  int 21h 

  mov ah, 1
  int 21h 

  mov bl, AL

  mov ah, 9
  lea dx, MSG2 
  int 21h 

  mov ah, 1 
  int 21h 

  add bl, AL
  sub bl, '0'

  mov ah, 9
  lea dx, MSG3
  int 21h 

  mov dl, bl 
  mov ah, 2 
  int 21h 

  mov ah, 4Ch
  int 21h 

MAIN ENDP
END MAIN

