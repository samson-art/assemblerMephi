; 	так как не оговорено иное, буду считать введенное число беззнаковым 
;	и то, что оно заканчивается символом 'o' (oct).
include io.asm

stack segment stack
	dw 128 dup (?)
stack ends

data segment
	
data ends

code segment 'code'
	assume ss:stack, ds:data, cs:code
inword8:
	push bp
	mov bp, sp	
	sub sp,8
	push cx
	push ax
	push bx
	push dx
	iax equ word ptr [bp-4]
	idx equ word ptr [bp-6]
	i equ word ptr [bp-2]
	occ equ word ptr [bp-8]
	mov iax, 0
	mov idx, 0
	mov i, 0
	mov occ, 8
	
	mov cx, sp   ; чтобы далее узнать когда прервать цикл

input:	
	inch al
	cmp al, 'o'
	jz obr
	sub al, 48
	mov ah, 0
	push ax
	jmp input		; посимвольно считываем число пока не встретим символ 'o' 
				; и закидываем в стек
obr:	
l:	pop ax
	mov bx, 0
l1:	
	cmp i, bx	
	jz l2
	mul occ
	
	inc bx
	jmp l1			; получили нужную степень восьмёрки 
l2:	add iax, ax
	adc idx, dx
	inc i
	cmp cx, sp		; прибавляем результат в локальные переменные
	jnz l
	
	mov dx, idx
	mov ax, iax		; достаем в dx:ax результат задачи
	
	add sp, 8		
	pop dx
	pop bx
	pop cx	
	pop ax
	mov sp, bp
	pop bp	
	ret 
start:
	mov ax,data
	mov ds,ax
	call inword8
    finish
code ends
    end start 
