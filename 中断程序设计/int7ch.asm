data segment
    msg db 0ah,0dh,"2005 202012143 Zhou tong$"
data ends
code segment
assume cs:code,ds:data
start:
    mov ah,25h
    mov al,7ch
    push cs
    pop ds
    mov dx,offset int7c
    int 21h
    mov ah,31h
    mov al,0
    mov dx,int7cend-int7cstart+16
    int 21h
int7c proc near
int7cstart:
    push ax
    push ds
    push dx
    mov ax,data
    mov ds,ax
    lea dx,msg
    mov ah,9
    int 21h
    pop dx
    pop ds
    pop ax
    iret
int7cend:nop
int7c endp
code ends
end start