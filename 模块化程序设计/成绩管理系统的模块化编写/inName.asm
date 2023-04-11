public inName
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
data ends

code segment public 'code'
    assume cs:code,ds:data
inName proc ;输入名字
    push ax
    push bx
    push cx
    push dx
    mov al,n
    mov cl,nl
    mul cl
    mov dx,offset nameA
    add dx,ax
    mov ah,10
    int 21h
    mov bx,dx
    mov byte ptr [bx],0dh
    inc bx 
    mov byte ptr [bx],0ah
    pop dx
    pop cx
    pop bx
    pop ax
    ret
inName endp
code ends
end