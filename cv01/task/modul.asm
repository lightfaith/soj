	bits 32

	section .data
	extern retezec, index, x1, x2, x3, soucet

	section .text
	global bigger, smaller, sum

bigger:
	mov EDX, [index]
	
	; -- SOLUTION 1
	;mov ECX, retezec
	;mov AL, [ECX + EDX*1]
	;and AL, 0xdf
	;mov [ECX + EDX*1], AL
	
	; -- SOLUTION 2
	and BYTE[retezec + EDX], 0xdf  ;0b11011111
	ret

smaller:
	mov EDX, [index]
	
	; -- SOLUTION 1
	;mov ECX, retezec
	;mov AL, [ECX + EDX*1]
	;add AL, 0x20
	;mov [ECX + EDX*1], AL

	; -- SOLUTION 2
	add BYTE[retezec + EDX], 0x20
	ret

sum:
	mov EAX, 0
	add EAX, [x1]
	add EAX, [x2]
	add EAX, [x3]
	mov [soucet], EAX
	ret

