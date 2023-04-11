;通过相对地址寻址的方式查学生姓名表
data segment
    stu0 db 0dh,0ah,'zhuo yu  $'
    stu1 db 0dh,0ah,'li ming  $'
    stu2 db 0dh,0ah,'li hua   $'
    stu3 db 0dh,0ah,'zhou tong$'
    stu4 db 0dh,0ah,'xiao ming$'
    tip  db 0dh,0dh,'Please input stu number:$'
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    ;打印提示信息
    mov dx, offset tip;
    mov ah, 9
    int 21h; 提示输入学号
    ;获取输入
    mov ah, 1
    int 21h
    sub al, 30h; ASCII码转数字

    ;寻址
    mov cl, 12; 每个名字包括换行共占12个字符
    mul cl
    ;打印查询到的名字
    mov dx, ax
    mov ah, 9
    int 21h
    mov ah, 4ch
    int 21h
code ends
end start