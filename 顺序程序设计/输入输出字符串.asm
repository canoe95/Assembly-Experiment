;输出输入的字符串
data segment
    buffer db 70,?,70 dup(0)
data ends
code segment
assume cs:code,ds:data
start:
    ;获取键盘输入
    mov ax,data
    mov ds,ax
    mov dx,offset buffer
    mov ah,10
    int 21h

    ;添加换行
    mov buffer[0], 0dh
    ;找到字符串的末尾并添加字符串结束符'$'
    mov bl,buffer[1]
    mov bh,0
    add bx,2
    mov buffer[bx],'$'
    ;0ah和0dh配合连着使用可以达到换行的效果
    mov buffer[1],0ah

    ;打印输出dx内容，即buffer
    mov ah,9
    int 21h
    mov ah,4ch
    int 21h
code ends
end start