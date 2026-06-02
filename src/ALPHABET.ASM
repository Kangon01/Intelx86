.MODEL small
.STACK 100h

.CODE
MAIN PROC
    mov ah, 02h         ; INT 21h Funktion 02h: Zeichen in DL ausgeben
    mov dl, 'A'         ; Startbuchstabe

PRINT_LOOP:
    int 21h             ; DL ausgeben
    inc dl              ; naechster Buchstabe
    cmp dl, 'Z'
    jbe PRINT_LOOP      ; weiter solange DL <= 'Z'

    ; Newline (CR + LF)
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; Programm beenden
    mov ax, 4C00h
    int 21h
MAIN ENDP

END MAIN
