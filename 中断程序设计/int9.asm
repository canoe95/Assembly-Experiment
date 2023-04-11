code segment
assume cs:code
start:
    mov ax,0
    mov es,ax
    push es:[0024h]
    pop es:[0202h]
    push es:[0026h]
    pop es:[0204h]
    mov ah,25h
    mov al,9
    push cs
    pop ds
    mov dx,offset int9
    int 21h
    mov ah,31h
    mov al,0
    mov dx,int9end-int9start+16
    int 21h
int9 proc near
int9start:
    push ax
    push bx
    push cx
    push es
    in al,60h
    mov bx,0
    mov es,bx
    pushf
    call dword ptr es:[0202h]
    cmp al,1eh
    jne int9ret
    mov ax,0b800h
    mov es,ax
    mov bx,1
    mov cx,2000
discoloration:
    inc byte ptr es:[bx]
    add bx,2
    loop discoloration
int9ret:
    pop es
    pop cx
    pop bx
    pop ax
    iret
int9end:
    nop
int9 endp
code ends
end start