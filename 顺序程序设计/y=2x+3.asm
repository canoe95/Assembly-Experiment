data segment
    info db "nmY=2X+3=$";
data ends
code segment
    assume ds:data,cs:code
start:
    mov ax,data
    mov ds,ax
    ;将info的首两个字符改为0dh和0ah，达到换行的效果
    mov bx,0
    mov info[bx],0dh
    inc bx
    mov info[bx],0ah
    ;获取单个字符输入，存于al
    mov ah,1
    int 21h
    ;调用9号功能打印info
    mov dx,offset info
    mov ah,9
    int 21h
    ;将输入数字-30，由ascii码变为数字
    mov ah,0
    sub al,30h
    ;乘法，imul bx即ax*bx
    mov bx,2
    imul bx
    aam ;乘法进位
    ;加法，add ax,3即ax += 3
    add ax,3
    aaa ;加法进位 
    add ax,3030h ;高低位均+30h，变回ascii码输出
    ;输出计算结果
    mov bx,ax ;将结果从ax移到bx
    mov dl,bh ;将高位bh移到dl输出
    mov ah,2 ;调用2号功能打印单个字符
    int 21h
    mov dl,bl ;将低位bl移到dl输出
    int 21h
    mov ah,4ch
    int 21h
code ends
end start