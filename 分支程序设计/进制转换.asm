;0-255的十进制转十六进制
data segment
    tip db 0DH,0AH,'DEC=$'
    info db 'HEX=$'
    res db 3 dup(0)
data ends
code segment
    assume cs:code,ds:data
start: 
    mov ax,data
    mov ds,ax
let:; 输入提示
    mov dx,offset tip
    mov ah,9    
    int 21h
    mov si,0;储存输入数字位数
let0:; 输入字符并做出判断
    mov ah,1
    int 21h
    cmp al,1bh;判断ESC
    je let5;相等则跳转
    cmp al,0dh;判断回车
    je let1
    sub al,30h;减去ASCII码存入res中
    mov res[si],al
    inc si
    jmp let0;继续输入
let1:
    mov dx,offset info;输出提示信息
    mov ah,9
    int 21h
    mov bx,0
    mov di,0
    cmp si,1;判断位数
    je let2;若为1位数，跳转至let2
    cmp si,2
    je let3;若为2位数，跳转至let3
    ;当为3位数，继续执行let1
    mov al,res[di];di=0，将res最高位放在al中
    inc di;di=1
    mov cl,100
    mul cl;将al*100倍获得百位数
    add bx,ax;将百位结果加在bx中
let3:
    ;若从let1顺序执行，res为三位数，此时di=1，获取输入数字的十位
    ;若从let1跳转过来，res为两位数，此时di=0，获取输入数字的十位
    mov al,res[di]
    ;di=1或di=2
    inc di
    mov cl,10
    mul cl;AX=AL*CL
    add bx,ax;将十位结果加在bx上
let2:
    mov al,res[di];取出输入数字的个位
    mov ah,0
    add bx,ax;结果加在BX上

    ;10进制转16进制
    ;ax÷cl
    ;结果中商是16进制的低位，余数为16进制的高位
    ;即ah中为16进制低位，al中为16进制高位
    mov ax,bx;将输入数字转存在ax中
    mov cl,16
    div cl;除以
    ;判断高位是否小于等于9，若大于则要转换为对应字母，要多加7
    cmp al,9;
    jbe let6;小于等于则跳转
    add al,7
let6:
    add al,30h;将余数（16进制高位）转为ascii码，准备输出
    mov cl,ah;转存商（16进制低位）到cl中
    mov dl,al;转存余数到dl中
    ;输出余数，即16进制高位
    mov ah,2
    int 21h
    mov al,cl;将cl中的商转存到al
    cmp al,9;判断是否小于等于9，若大于同样要加7转为相应字母的ascii码
    jbe let7;小于等于则跳转
    add al,7
let7:;输出16进制低位
    add al,30h
    mov dl,al
    mov ah,2
    int 21h
    jmp let
let5:;退出程序
    mov ah,4ch
    int 21h
code ends
end start