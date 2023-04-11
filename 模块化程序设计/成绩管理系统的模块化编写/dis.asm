public dis
data segment common 'data'
    nameA db 5 dup(13,?,13 dup('$'))
    scoreAsc db 5 dup(4 dup('$'))
    rank dw 0,1,2,3,4
    scoreN dw 5 dup(0)
    n db 0      ;n代表学号
    sn dw 5     ;sn代表学生数量
    info db 0dh,0ah,'name:$'
    info1 db 0dh,0ah,'score:$'
    nl db 15
    sl db 4
    x db 3 dup(?)
data end

code segment public 'code'
    assume cs:code,ds:data
dis proc    ;打印结果
    push ax
    push bx
    push cx
    push dx
    push di
    mov cx,sn
    mov di,1
    mov bx,0
loopDis:
    mov dx,di
    add dl,30h    
    mov ah,2
    int 21h
    mov ax,rank[bx]
    mov dl, nl
    mul dl
    mov dx,offset nameA
    add dx,ax
    mov ah,9
    int 21h
    mov dl,0dh
    mov ah,2
    int 21h
    mov dl,0ah
    int 21h
    mov ax,rank[bx]
    mov dl,sl
    mul dl
    mov dx,offset scoreAsc
    add dx,ax
    mov ah,9
    int 21h
    mov dl,0dh
    mov ah,2
    int 21h
    mov dl,0ah
    int 21h
    add bx,2
    inc di
    loop loopDis
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
dis endp
code ends
end