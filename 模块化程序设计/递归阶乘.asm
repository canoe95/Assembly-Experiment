;return n*fac(n-1);
;使用变量ax储存乘法结果
stack segment stack
    dw 512 dup(?)
stack ends
code segment
    assume cs:code,ss:stack
start:
    mov ax,5
    push ax        ;ax入栈
    call fac
    mov ah,4ch
    int 21h
fac proc
    mov bp,sp    ;保存栈顶指针
    mov bx,[bp+2]    ;取出栈顶元素
    cmp bx,1    ;如果是1的话就返回
    jne next    ;小于等于则跳转
    mov ax,1
    jmp exit
next:
    dec bx        ;bx-1入栈，进入下一层递归
    push bx
    call fac
    mov bp,sp
    mov bx,[bp+2]
    mul bl        ;ax=al*bl al=fac(n-1) bl=n
exit:
    ret 2        ;出栈，弹出两个字节
fac endp
code ends
end start