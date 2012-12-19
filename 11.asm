; ─ы  ъюЁЁхъЄэюую юЄюсЁрцхэш  Ёєёёъшї сєът шёяюы№чєщЄх
; ъюфшЁютъє 866 (т Notepad++: ьхэ■ ╩юфшЁютъш - ╩юфшЁютъш -
; ╩шЁшыышЎр - OEM 866).
; Если текст, начиная с этой строки, читается нормально,
; то файл в правильной кодировке.

include io.asm ;подключение операций ввода-вывода

stack segment stack
	dw 128 dup (?)
stack ends

data segment
; место для переменных и констант
	
data ends

code segment 'code'
	assume ss:stack, ds:data, cs:code
; место для описания процедур
inword8:
	push bp
	mov bp, sp	; стд
	sub sp,8
	push cx
	push ax
	push bx
	push dx
	
	
					;
	iax equ word ptr [bp-4]
	idx equ word ptr [bp-6]
	i equ word ptr [bp-2]
	occ equ word ptr [bp-8]
	mov iax, word ptr 0
	mov idx, word ptr 0
	mov i, word ptr 0
	mov occ, word ptr 8
	
	mov cx, sp
input:	
	
	inch al
	cmp al, 'o'
	jz obr
	sub al, 48
	mov ah, 0
	push ax
	;inc cx			; cl счётчик кол-ва цифр в числе
	jmp input

obr:	
l:	pop ax
	mov bx, 0
	;dec cx
l1:	
	cmp i, bx		;ch счётчик стемени 8
	jz l2
	mul occ
	
	inc bx
	jmp l1
l2:	add iax, ax
	adc idx, dx
	
	inc i
	cmp cx, sp
	jnz l
	;loop l
	
	mov dx, idx
	mov ax, iax
	outword ax ; for myself
	newline 	; for myself
	outword dx ; for my self
	add sp, 8
	pop dx
	pop bx
	pop cx	; std
	pop ax
	pop bp	
	ret 
start:
	mov ax,data
	mov ds,ax
	; поскольку не оговорена форма ввода
	; буду считать, что число в 8СС заканчивается символом 'o'
	; 
	call inword8
    finish
code ends
    end start 
