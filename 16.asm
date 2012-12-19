include io.asm ;подключение операций ввода-вывода

stack segment stack
	dw 128 dup (?)
stack ends

data segment
; место для переменных и констант
	nOK dw ?
	OK dw ?
	aotr dw 0
	botr dw 0
	moda dw 0
	modb dw 0
	a dw ?
	b dw ?
data ends

code segment 'code'
	assume ss:stack, ds:data, cs:code
; место для описания процедур
myPr:
	push bp
	mov bp, sp
	push cx
	push dx
	mov ax, [bp+4]
	mov bx, [bp+6]

evk:cmp ax, bx
	jl l1
	xor dx, dx
	idiv bx
	cmp dx, 0
	jz el
	mov ax, dx
	xchg ax, bx
	jmp evk
l1:	xchg ax, bx
	jmp evk		;nod is in bx
el:	
	mov ax, a
	mov bx, b
	imul bx
	idiv cx
	outint ax	; for myself
	newline		; for myself
	; nOK is in ax
	mov cx,1
	xor dx, dx
	mov nOK, ax	; saved nOK
l666:
	mov OK, ax
	mov ax, nOK
	imul cx
	inc cx
	cmp dx, 0
	jz l666
	mov ax, OK
	outint ax ; for myself
	pop dx
	pop cx
	pop bp
	ret
start:
	mov ax,data
	mov ds,ax
; команды программы должны располагаться здесь
	inint ax
	inint bx
	newline
	;
	push ax
	push bx
	call myPr
    finish
code ends
    end start 
