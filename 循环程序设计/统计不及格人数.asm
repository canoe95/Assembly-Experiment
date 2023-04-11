data segment
    score db 23,45,60,90,91,88,66,77
          db 95,86,90,95,100,0,42,23
          db 65,64,59,91,92,78,59,44
    good  db 3 dup(0)
    fail  db 3 dup(0)
    sn       db 0
    cn    db 0
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

outer:            ;外层循环
    cmp cn, 3    ;与班级数比较
    jae exit    ;若大于等于则跳转，即外层循环完退出程序
    mov sn, 0    ;初始化内层循环

inner:            ;内层循环
    cmp sn, 8    ;与班级人数比较
    jae trans2    ;大于等于则跳转至下一层外层循环
    mov al, cn
    mov cl, 8    ;班级号乘8获取班级成绩首地址
    mul cl
    mov bx, ax    ;将班级首地址存入bx
    mov al, sn    ;将班级序列号转存入al
    mov ah, 0
    mov si, ax    ;将班级序列号转存入si
    cmp score[bx][si], 90
    jb  less    ;小于则跳转,大于等于则继续
    ;处理大于等于90分数，即优秀成绩
    mov al, cn    ;外层循环数=班级号
    mov ah, 0
    mov di, ax    ;第几个班
    inc good[di]
    jmp trans1    ;转入下一次内层循环过渡

less:    ;处理小于90分数
    cmp score[bx][si], 60    ;与60比较
    jae trans1    ;大于等于则跳转，进行下一层内层循环
    ;处理小于60分，即不及格成绩
    mov al, cn
    mov ah, 0
    mov di, ax
    inc fail[di]

trans1:            ;内层循环跳转过渡
    inc sn
    jmp inner
trans2:            ;外层循环跳转过度
    inc cn
    jmp outer
exit:
    mov ah, 4ch
    int 21h

code ends
end start