	bits 32
	section .data

	section .text

; 1.
	global ror64
ror64:
	enter 0, 0
	mov ecx, [ebp+16]
.loop:
	clc
	mov eax, [ebp+12]
	rcr eax, 1             ; just to get carry
	rcr DWORD [ebp+8], 1
	rcr DWORD [ebp+12], 1
	loop .loop
	mov edx, [ebp+12]
	mov eax, [ebp+8]
	leave
	ret

; 2.
	global llmax
llmax:
	enter 0, 0
	mov eax, [ebp+12]
	cmp eax, [ebp+20]
	ja .first
	jb .second
	mov eax, [ebp+8]
	cmp eax, [ebp+16]
	jb .second
.first:
	mov edx, [ebp+12]
	mov eax, [ebp+8]
	jmp .end
.second:
	mov edx, [ebp+20]
	mov eax, [ebp+16]
	jmp .end
.end:
	leave
	ret

; 3.
	global polemax
polemax:
	enter 0, 0
	push esi
	mov ecx, [ebp+12]
	mov esi, [ebp+8]
	mov edx, [esi+ecx*8-4]
	mov eax, [esi+ecx*8-8]
	dec ecx
.loop:
	push DWORD [esi+ecx*8-4]
	push DWORD [esi+ecx*8-8]
	push edx
	push eax
	call llmax	
	loop .loop
	pop esi	
	leave
	ret	

; 4.
	global satur_plus
satur_plus:
	enter 0, 0
	mov eax, [ebp+8]
	add eax, [ebp+12]
	jno .end
	cmp eax, 0
	jl .negative
	; positive
	mov eax, 0x7fffffff
	jmp .end
.negative:
	mov eax, 0x80000000
.end:
	leave
	ret	

; 5.
	global pocet_dig
pocet_dig:
	enter 0, 0
	xor eax, eax
	mov edx, [ebp+8]
.loop:
	cmp BYTE [edx], 0
	je .end
	cmp BYTE [edx], '0'
	jl .continue
	cmp BYTE [edx], '9'
	jg .continue
	inc eax
.continue:
	inc edx
	jmp .loop
.end:
	leave
	ret	

; 6.
	global strkate
	extern strlen
strkate:
	enter 0, 0
	push ebx
	push edi
	push esi
	mov esi, [ebp+8]
	mov edi, [ebp+12]
	push esi
	call strlen
	pop edx
	
	mov ebx, eax
	push edi
	call strlen
	pop ecx
	mov ecx, eax
	
.loop:
	mov al, [edi+ecx-1]
	add ebx, ecx
	mov [esi+ebx-1], al
	sub ebx, ecx
	loop .loop
	mov eax, esi
	pop esi
	pop edi
	pop ebx
	leave
	ret	


