;通过各种寻址方式查分数表
data segment
score dw 100,91,98,97,93
      dw 99,94,96,92,95
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax; ds用来存放2班3号学生的成绩
    ;直接寻址
    mov dx,ds:[0eh]
    mov bx,0eh   
    ;寄存器间接寻址
    mov dx,[bx]
    mov bp,0eh
    ;段超越
    mov dx,ds:[bp]
    ;寄存器相对寻址
    mov si,0eh
    mov dx,score[si]
    ;基址变址寻址
    mov bx,offset score
    mov di,0eh
    mov dx,[bx][di]
    ;相对基址变址寻址
    mov bx,10
    mov si,4
    mov dx,score[bx][si]
    mov ah,4ch
    int 21h
code ends
end start