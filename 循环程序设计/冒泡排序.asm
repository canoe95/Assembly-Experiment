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
    jae sort    ;若大于等于则跳转，即外层循环完开始排序
    mov sn, 0

inner:            ;内层循环
    cmp sn, 8    ;与班级人数比较
    jae trans2    ;大于等于则跳转至下一层外层循环
    mov al, cn
    mov cl, 8    ;班级号乘8获取班级成绩首地址
    mul cl
    mov bx, ax    ;将班级首地址存入bx
    mov al, sn    ;sn为班级第几号学生
    mov ah, 0
    mov si, ax    ;班级第几个学生存入si
    cmp score[bx][si], 90
    jb  less    ;小于则跳转,大于等于则继续，处理大于等于90分数
    mov al, dn    ;dn是good数组的下标
    mov ah, 0
    mov di, ax    ;good数组下标
    mov al, score[bx][si]
    mov good[di], al
    inc dn
    jmp trans1    ;转入下一次内层循环

less:    ;处理小于90分数
    cmp score[bx][si], 60    ;与60比较
    jae trans1    ;大于等于则跳转，进行下一层内层循环
    mov al, bn    ;bn是fail数组的下标
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

sort:
    ;排列优秀成绩
    ;dn为下标数，即外层循环执行次数
    ;将外层循环执行次数转存到cx中
    ;实际上这里的循环是loop(cx)，当cx=0，退出
    mov cl, dn
    mov ch, 0
    dec cx
loop1:    
    ;cx入栈
    push cx
    ;初始化内层循环，从第一个开始比较
    mov bx, 0
loop2:
    mov al, good[bx]
    cmp al, good[bx+1]
    jge next1;jump greater or equal 大于等于跳转
    xchg al, good[bx+1];两个地址交换值
    mov good[bx], al
next1:
    add bx, 1
    loop loop2
    pop cx
    loop loop1

    ;排列不及格成绩
    mov cl, bn
    mov ch, 0
    dec cx
loop3:
    push cx
    mov bx, 0
loop4:
    mov al, fail[bx]
    cmp al, fail[bx+1]
    jge next2
    xchg al, fail[bx+1]
    mov fail[bx], al
next2:
    add bx, 1
    loop loop4
    pop cx
    loop loop3

exit:
    mov ah, 4ch
    int 21h

code ends
end start