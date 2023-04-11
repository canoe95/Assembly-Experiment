extrn sort:near, inName:near, inScore:near, dis:near
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

stack segment stack
    dw 512 dup(0)
stack ends

code segment public 'code'
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov cx,sn
    loopm:
    mov dx,offset info
    mov ah,9
    int 21h 
    call inName
    mov dx,offset info1
    int 21h
    call inScore
    inc n
    loop loopm
    call sort
    call dis
    mov ah,4ch
    int 21h
code ends
end start