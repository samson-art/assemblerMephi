include io.asm ;������祭�� �����権 �����-�뢮��

stack segment stack
	dw 1024 dup (?)
stack ends

data segment

data ends

code segment 'code'
	assume ss:stack, ds:data, cs:code

nok777:
	push bp
	mov bp, sp
a equ word ptr [bp+4]
b equ word ptr [bp+6]
sub sp, 10
.186	
	pusha
nod equ word ptr [bp-2]	; тут НОД
nok equ word ptr [bp-4]	; тут Н(аименьшее)ОК
ma equ word ptr [bp-6]	; тут храним модуль а
mb equ word ptr [bp-8]	; тут модуль б
	mov ax, a
	mov bx, b
	mov ma, ax
	mov mb, bx
	cmp ax, 0
	jg l
	neg ax
	mov ma, ax
l:	cmp bx, 0
	jg l2
	neg bx
	mov mb, bx
	
l2:	cmp ax, bx
	jb l1
	cwd
	idiv bx
	cmp dx, 0
	jz ex
	xchg ax, dx
	jmp l2
l1: xchg ax, bx	
	jmp l2		; ищем нод модулей по алгоритму эвклида

ex:	
	mov nod, bx
	mov ax, ma
	mov bx, mb
	cwd
	imul bx
	idiv nod
	mov nok, ax	; нашли нок модулей
	mov ax, a
	mov bx, b
lll:
	cmp ax, bx
	jl ll
	cmp ax, 0
	jg nok1
	neg nok
	jmp nok1
ll: xchg ax, bx	
	jmp lll
nok1:			; установили знак нок
	mov ax, nok	
	cmp nok, 0	; если нок отрицательное, то оно и является наибольшим
	jl fin
	mov cx, 1
	mov es, sp
l123:
	imul cx
	push ax
	inc cx
	cmp dx, 0		; условие что Нок уменьшается в 16бит
	jz l123	
	pop ax
fin:
	mov sp, es		; восстанавливаем значение sp 
	popa
	add sp, 10
	mov sp,bp
	pop bp
	ret
start:
	mov ax,data
	mov ds,ax
	call nok777
    finish
code ends
    end start 
