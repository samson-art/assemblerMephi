include io.asm ;¯®€ª«îç¥­š¥ ®¯¥à æš© ¢¢®€ -¢ë¢®€ 

stack segment stack
  dw 128 dup (?)
stack ends

data segment
; ¬¥áâ® €«ï ¯¥à¥¬¥­­ëå š ª®­áâ ­â
	x2 dw 100 dup (?)
	f2 dw 0
	l2 dw 0
	x3 dw 100 dup (?)
	l3 dw 0
	f3 dw 0
	x5 dw 100 dup (?)
	l5 dw 0
	f5 dw 0
	k dw ?
	;t dw 2
data ends
	
code segment 'code'
	assume ss:stack, ds:data, cs:code
; ¬¥áâ® €«ï ®¯šá ­šï ¯à®æ¥€ãà
ochred:					; t ¢ áâ¥ª¥
	push bp
	mov bp, sp
t equ word ptr [bp+4]
.186
	pusha
	
	mov ax, f2
	add ax, l2
	xor dx, dx
	mov cx, 100
	div cx
	mov bx, dx
	mov ax, t
	mov cx, 2
	mul cx
	mov x2[bx], ax
	inc l2				; €®¡ ¢š«š í«¥¬¥­â ¢ ®ç¥à¥€ì x2
	
	mov ax, f3
	add ax, l3
	xor dx, dx
	mov cx, 100
	div cx
	mov bx, dx
	mov ax, t
	mov cx, 3
	mul cx
	mov x2[bx], ax
	inc l3					; €®¡ ¢š«š í«¥¬¥­â ¢ x3
	
	mov ax, f5
	add ax, l5
	xor dx, dx
	mov cx, 100
	div cx
	mov bx, dx
	mov ax, t
	mov cx, 5
	mul cx
	mov x2[bx], ax
	inc l5					; €®¡ ¢š«š í«¥¬¥­â ¢ x5

	popa
	pop bp
	ret
	
min: 			;¢®§¢à éï¥âáï ¢ ax
	push bp 
	mov bp, sp
.186
	pusha

	mov bx, f2
	push x2[bx]
	mov bx, f3
	push x3[bx]
	mov bx, f5
	push x5[bx]
	pop cx
	pop bx
	pop ax
	
	cmp ax, bx
	jb	l
	cmp bx, cx
	ja lll
	mov ax, bx; bx min
	inc f3
	jmp fin
l:	cmp ax, cx
	jb ll
lll:
	mov ax, cx;cx ¬¥­ìè¥¥
	inc f5
	jmp fin
ll: inc f2;ax ¬¥­ìè¥¥	
fin:
	
	popa
	pop bp
ret

minus:
	push bp 
	mov bp, sp
.186
	pusha
	
	mov bx, f2
	push x2[bx]
	mov bx, f3
	push x3[bx]
	mov bx, f5
	push x5[bx]
	pop dx
	pop cx
	pop bx
	cmp ax, bx
	jz l11
j1:	cmp ax, cx
	jnz l22
j2:	cmp ax, dx
	jnz l33
	jmp jf
l11:
	push ax
	push cx
	push dx
	inc f2
	mov cx, 100
	mov ax, f2
	xor dx, dx
	div cx
	mov f2, dx
	pop dx
	pop cx
	pop ax
	inc l2
	jmp j1
l22:
	push ax
	push cx
	push dx
	inc f3
	mov cx, 100
	mov ax, f3
	xor dx, dx
	div cx
	mov f3, dx
	pop dx
	pop cx
	pop ax
	inc l3
	jmp j2
l33:
	push ax
	push cx
	push dx
	inc f5
	mov cx, 100
	mov ax, f5
	xor dx, dx
	div cx
	mov f5, dx
	pop dx
	pop cx
	pop ax
	inc l5
jf:
	popa
	pop bp
ret
start:
	mov ax,data
	mov ds,ax
; ª®¬ ­€ë ¯à®£à ¬¬ë €®«Š­ë à á¯®« £ âìáï §€¥áì
	mov bx, f2
	mov x2[bx], 2
	mov bx, f3
	mov x3[bx], 3
	mov bx, f5
	mov x5[bx], 5		; § € «š ­ ç «­®¥ §­ ç¥­š¥ ®ç¥à¥€š
	inint ax			; ¢¢®€š¬ §­ ç¥­š¥ ª
	mov k, ax
	mov ax, 2
begin:
	
	call min
	push ax
	call ochred
	call minus
	cmp ax, k
	ja final
	outword ax
	newline
	
	
	jmp begin
final:
   finish
code ends
    end start 
