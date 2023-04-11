data segment 
    nameA db 5 dup(13,?,13 dup('$'))
    scoreAsc db 5 dup(4 dup('$'))
    rank dw 0,1,2,3,4
    scoreN dw 5 dup(0)
    n db 0      ;n代表学号
    sn dw 5     ;sn代表学生数量
    info1 db 0dh,0ah,'name:$'
    info2 db 0dh,0ah,'score:$'
    nl db 15
    sl db 4
    x db 3 dup(?)
data ends

stack segment stack
    dw 512 dup(0)
stack ends
code segment
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    ;初始化录入次数
    mov cx,sn
loopm:
    lea dx,info1;打印输入姓名提示信息
    mov ah,9
    int 21h 
    call inName
    lea dx,info2;打印输入成绩提示信息
    int 21h
    call inScore
    inc n;记录学号
    loop loopm
    call sort
    call dis
    mov ah,4ch
    int 21h
code ends
end start

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