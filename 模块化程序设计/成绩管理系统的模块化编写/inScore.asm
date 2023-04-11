public inScore
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
inScore proc ;输入成绩
    push ax
    push bx
    push cx
    push dx
    push bp
    push si
    push di
    mov al,n
    mov cl,sl
    mul cl
    mov bp,offset scoreAsc
    add bp,ax
let0:
    mov ah,1
    int 21h
    cmp al,0dh
    je let1
    mov ds:[bp][si],al
    sub al,30h
    mov x[si],al
    inc si
    jmp let0
let1:
    mov bx,0
    mov di,0
    cmp si,1
    je let2
    cmp si,2
    je let3
    mov al,x[di]
    mov cl,100
    mul cl
    add bx,ax
    inc di
let3:
    mov al,x[di]
    mov cl,10
    mul cl
    add bx,ax
    inc di
let2:
    add bl,x[di]
    mov al,n
    mov cl,2
    mul cl
    mov si,ax
    mov scoreN[si],bx
    pop di
    pop si
    pop bp
    pop dx
    pop cx
    pop bx
    pop ax
    ret
inScore endp
code ends
end