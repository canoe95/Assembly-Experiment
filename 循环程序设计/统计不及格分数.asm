data segment
    score db 23,45,60,90,91,88,66,77
          db 95,86,90,95,100,0,42,23
          db 65,64,59,91,92,78,59,44
    good  db 24 dup(0)
    fail  db 24 dup(0)
    sn       db 0
    cn    db 0
    dn      db 0
    bn      db 0
data ends
code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

outer:            ;外层循环
    cmp cn, 3    ;与班级数比较
    jae exit    ;若大于等于则跳转，即外层循环完完成存储
    mov sn, 0    ;初始化内层循环

inner:            ;内层循环
    cmp sn, 8    ;与班级人数比较
    jae trans2    ;大于等于则跳转至下一层外层循环
    mov al, cn    ;cn为第几个班
    mov cl, 8    ;班级号乘8获取班级成绩首地址
    mul cl
    mov bx, ax    ;将班级首地址存入bx
    mov al, sn    ;sn为班级第几号学生
    mov ah, 0
    mov si, ax    ;班级序列号存入si
    cmp score[bx][si], 90
    jb  less    ;小于则跳转,大于等于则继续
    ;处理大于等于90的分数
    ;dn是good数组的下标，在数据段初始化为0
    mov al, dn
    mov ah, 0
    mov di, ax    ;将good数组当前下标存入di
    mov al, score[bx][si];将分数存入al
    mov good[di], al    ;将分数存入good数组
    inc dn        ;dn++
    jmp trans1    ;转入下一次内层循环

less:    ;处理小于90分数
    cmp score[bx][si], 60    ;与60比较
    jae trans1    ;大于等于则跳转，进行下一层内层循环
    ;bn是fail数组的下标，数据段初始化为0
    mov al, bn    
    mov ah, 0
    mov di, ax
    mov al, score[bx][si]    
    mov fail[di], al    ;将不及格分数存入fail数组
    inc bn

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
