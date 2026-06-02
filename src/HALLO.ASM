.MODEL small
.STACK 100h

.DATA
    msg     DB  'Hallo Welt!', 0Dh, 0Ah, '$'

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; INT 21h, Funktion 09h: String ausgeben
    mov ah, 09h
    lea dx, msg
    int 21h
    
    ; INT 21h, Funktion 4Ch: Programm beenden
    mov ax, 4C00h
    int 21h
MAIN ENDP

END MAIN
