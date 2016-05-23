	bits 32
	section .data

	section .text
	global rol64
; 1.
rol64:
	enter 0, 0
	mov ecx, [ebp+16] ; N
.loop:
	clc
	mov eax, [ebp+12]
	rcl eax, 1           ; just to get CF
	rcl DWORD [ebp+8], 1
	rcl DWORD [ebp+12], 1
	loop .loop
	mov edx, [ebp+12]
	mov eax, [ebp+8]
	leave
	ret

; 2.
	global soucet
soucet:
	enter 0, 0
	push esi
	mov esi, [ebp+8]
	xor eax, eax
	xor edx, edx
	mov ecx, [ebp+12] ; N
.loop:
	add eax, [esi+ecx*4-4]
	adc edx, 0
	loop .loop
	pop esi
	leave
	ret
	
; 3. Let's add 2 biggest numbers: 0xffffffff*2^1 = 0xffffffff << 1, one bit is added. We can add 2^32 numbers together (counter size), therefore 32 additional bits are needed. This condition is satisfied, as return data type can hold 64 bits of information.
; For clarity: 0xffffffff*0xffffffff = 0xfffffffe 00000001

; 4.
	global satur_plus
satur_plus:
	enter 0, 0
	xor edx, edx
	mov eax, [ebp+8]
	add eax, [ebp+12]
	jno .finally
	; overflow occured
	jl .negative
	mov eax, 0x7fffffff
	jmp .finally
.negative:
	mov eax, 0x80000000
.finally:
	leave
	ret

; 5.
	global nasob
nasob:
	enter 0, 0
	mov eax, [ebp+12]
	mov edx, [ebp+16]
	mul edx
	push eax
	mov ecx, edx
	mov eax, [ebp+8]
	mov edx, [ebp+16]
	mul edx
	add eax, ecx
	pop edx
	leave
	ret	


; 6.
	global trim_space
trim_space:
	enter 0, 0
	push edi
	push esi
	mov esi, [ebp+8]
	mov edi, [ebp+8]
.findstart:
	mov dl, [esi]
	test dl, dl
	jz .relocate
	cmp dl, ' '
	jne .relocate
	inc esi
	jmp .findstart
.relocate:
	; variant 1
	mov dl, [esi]
	mov BYTE [edi], dl
	cmp dl, 0
	je .end
	inc edi
	inc esi
	jmp .relocate
		
	; variant 2
	;lodsb
	;stosb
	;cmp al, 0
	;je .end
	;jmp .relocate
.end:
	pop esi
	pop edi
	mov eax, [ebp+0x8]
	leave
	ret




