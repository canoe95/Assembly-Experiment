;分支程序
;0退出
;1输出hello world
;2大小写字母转换
;输入x，计算y=2x+3
data segment
    table dw prog0,prog1,prog2,prog3
    info  db 0ah,0dh,'Please input 0-3:$'
    hello db 0ah,0dh,'Hello World!$'   
    func  db 0dh,0dh,'Y=2X+3=$' 
    bye   db 0ah,0dh,'goodbye!$'
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
let0:                 ;输出提示信息，用户输入0-3
    lea dx,info
    mov ah,9            
    int 21h           ;9号功能输出字符串提示用户输入

    mov ah,1          ;输入
    int 21h
    sub al,30h        ;减去ASCII码转换输入信息为数字0-3
    mov ah,0
    shl ax,1          ;输入信息*2，用于找table表中对应的标号的偏移地址
    mov bx,ax
    jmp table[bx]     ;根据输入序号，在table中进行相对地址寻址跳转至相应程序段

prog1:                ;1号程序:调用9号功能输出HelloWorld
    mov dx,offset hello
    mov ah,9
    int 21h
    jmp let0          ;返回继续输入0-3

prog2:                ;2号程序，转换输入字母大小写并输出
    mov dl,0ah
    mov ah,2         ;调用2号功能输出一个换行
    int 21h      
    mov ah,1          ;调用1号功能输入
    int 21h
    test al,20h       ;测试指令，大小写字母ASCII码第6位不同
    jz let1           ;大写，则转移
    and al,0dfh       ;小写变为大写
    jmp let2
let1:
    or al,20h         ;大写变为小写
let2: ;输出转换后的字母
    mov dl,al
    mov ah,2          
    int 21h
    jmp let0     ;返回继续输入0-3

prog3:          ;3号程序: y=2x+3方程
    mov dl,0ah
    mov ah,2
    int 21h        ;输出换行
    mov ah,1    ;输入数字x
    int 21h
    mov bl,al    ;将输入数字转存于bl
    lea dx,func    ;lea传递有效地址
    mov ah,9
    int 21h        ;输出'Y=2X+3='
    sub bl,30h
    mov al,2
    imul bl
    aam        ;乘法进位
    mov bx,3
    add ax,bx
    aaa        ;加法进位
    add ax,3030h    ;变成ascii码形式准备输出
    ;依次打印高低位显示加法结果
    mov bx,ax    
    mov dl,bh
    mov ah,2
    int 21h        
    mov dl,bl
    int 21h        
    jmp let0        ;返回继续输入0-3      

prog0:              ;程序终止
    lea dx,bye
    mov ah,9
    int 21h
    mov ah,4ch
    int 21h
code ends
end start