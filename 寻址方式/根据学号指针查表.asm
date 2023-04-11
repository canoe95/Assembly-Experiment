;table相当于一个指针数组，每个指针占用2个字节，根据输入找到相应指针，相对寻址找到数据
data segment
    table dw stu0,stu1,stu2,stu3,stu4
    stu0  db 0dh,0ah,'huaxue$'; 0dh为换行
    stu1  db 0dh,0ah,'shuxue$'
    stu2  db 0dh,0ah,'yingyu$'
    stu3  db 0dh,0ah,'yuwen$'
    stu4  db 0dh,0ah,'wuli$'; 长度无需一样
    info  db 0dh,'Please input stu no:$'
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax, data
    mov ds, ax
    mov dx, offset info   
    mov ah, 9     
    int 21h
    mov ah, 1; 输入学号
    int 21h
    sub al, 30h; 将学号ascii码转数字
    mov cl, 2; 在table中stu?占用两个字节，一个字（dw）为两个字节
    mul cl; 相对table的偏移地址
    mov bx, ax  
    mov dx, table[bx] ;寄存器相对寻址
    mov ah, 9; 显示名字
    int 21h
    mov ah, 4ch
    int 21h
code ends
end start