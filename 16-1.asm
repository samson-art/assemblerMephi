; ��� ����������� ����������� ������� ���� �����������
; ��������� 866 (� Notepad++: ���� ��������� - ��������� -
; ��������� - OEM 866).
; �᫨ ⥪��, ��稭�� � �⮩ ��ப�, �⠥��� ��ଠ�쭮,
; � 䠩� � �ࠢ��쭮� ����஢��.

include io.asm ;������祭�� ����権 �����-�뢮��

stack segment stack
	dw 1024 dup (?)
stack ends

data segment
; ���� ��� ��६����� � ����⠭�

data ends

code segment 'code'
	assume ss:stack, ds:data, cs:code
; ���� ��� ���ᠭ�� ��楤��
nok777:
	push bp
	mov bp, sp
a equ word ptr [bp+4]
b equ word ptr [bp+6]
sub sp, 10
nod equ word ptr [bp-2]
nok equ word ptr [bp-4]
	;sub sp, 10
ma equ word ptr [bp-6]
mb equ word ptr [bp-8]
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
	jmp l2

ex:	
	mov nod, bx
	outint nod
	newline
	mov ax, ma
	mov bx, mb
	cwd
	imul bx
	idiv nod
	mov nok, ax
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
nok1:
	outint nok
	cmp nok, 0
	jl fin
	xor dx,dx
	mov cx, 1
l123:
	imul cx
	push ax
	inc cx
	cmp dx, 0
	jz l123
	pop ax
	mov nok,ax
fin:
	newline 
	outint nok 
	mov sp, bp
	pop bp
	ret
start:
	mov ax,data
	mov ds,ax
; ������� �ணࠬ�� ������ �ᯮ�������� �����
	
	inint ax
	push ax
	inint ax
	push ax
	call nok777
    finish
code ends
    end start 
