public sort
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
sort proc ;排序
    push ax
    push bx
    push cx
    mov cx,sn
    dec cx
    loopS1:
    push cx
    mov bx,0
    loopS2:
    mov ax,scoreN[bx]
    cmp ax,scoreN[bx+2]
    jae cSort
    xchg ax,scoreN[bx+2]
    mov scoreN[bx],ax
    mov ax,rank[bx]
    xchg ax,rank[bx+2]
    mov rank[bx],ax
    cSort:
    add bx,2
    loop loopS2
    pop cx
    loop loopS1
    pop cx
    pop bx
    pop ax
    ret
sort endp
code ends
end