.model small
.stack 100h 
.data
    MSG1  db 10,13,"Digite até 7 valores: $"
    MSG2  db 10,13,"Seu vetor invertido: $"
    vetor db 0 ,0 ,0 , 0, 0, 0, 0
.code
main proc
                      mov  ax, @data
                      mov  ds, ax

                      call lervetor

                      call InverterVetor

                      call imprimirNovoVetor


                      mov  ah, 4ch
                      int  21h


main endp

lervetor proc

                      push cx
                      push BX

                      lea  dx, MSG1
                      mov  ah, 9
                      int  21h

                      xor  bx, bx
                      mov  cx, 7

    LeituraLoop:      
                      mov  ah, 1
                      int  21h

                      sub al, '0'

                      mov  [vetor+bx], al
                      inc  BX
                      loop LeituraLoop

                      pop  bx
                      pop  cx

                      RET
lervetor endp
    
InverterVetor proc
                      push si
                      push cx

                      xor  si, si
                      mov  cx, 7

    pushloop:         
                      mov  al, [vetor+si]
                      xor  ah, ah
                      push AX
                      inc  si
                      loop pushloop
        
                      mov  cx, 7
                      xor  si, si

    PopLoop:          
                      pop  ax
                      mov  [vetor+si], al
                      inc  si
                      loop PopLoop

                      pop  si
                      pop  cx

                      RET

InverterVetor endp

imprimirNovoVetor proc
                      push si
                      push cx

                      lea  dx, MSG2
                      mov  ah, 9
                      int  21h

                      mov  cx, 7
                      xor  si,si
    ImprimirLoop:     
                      mov  dl, [vetor+si]
                      add  dl, '0'
                      mov  ah, 2
                      int  21h

                      mov  dl, ' '
                      int  21h
                      inc si
    loop ImprimirLoop

                      pop  si
                      pop  CX

                      RET

imprimirNovoVetor endp
end main 