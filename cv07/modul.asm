	bits 32

	section .data


	section .text
	global soucetll
soucetll:
	enter 0,0
	mov eax, [ebp+8]    ; low A
	add eax, [ebp+16]   ; += low B         ; sub for subtract
	mov edx, [ebp+12]   ; high A
	adc edx, [ebp+20]   ; += high B (+ CF) ; sbb for subtract
	leave
	ret



	global negatell
negatell:
	enter 0, 0
	xor eax, eax
	xor edx, edx
	sub eax, [ebp+8]
	sbb edx, [ebp+12]
	leave
	ret


	global nasob
nasob:
	enter 0, 0
	
	mov eax, [ebp+8]
	imul dword [ebp+12]
	leave
	ret


	global nasobl
nasobl:                  ; 96b needed, ignoring top 32
	enter 0, 0
	mov eax, [ebp+12]	 ; high a
	mul dword [ebp+16]   ; *=b
	mov ecx, eax
	mov eax, [ebp+8]     ; low a
	mul dword [ebp+16]   ; *=b

	add edx, ecx
	leave
	ret



	global nasobll
nasobll:
	enter 0, 0
	
	mov eax, [ebp+12]      ; high a
	mul dword [ebp+16]     ; *= low b
	mov ecx, eax

	mov eax, [ebp+20]      ; high b
	mul dword [ebp+8]      ; *= low a
	add ecx, edx

	mov eax, [ebp+8]       ; low a
	mul dword [ebp+16]     ; low b
	add edx, ecx

	leave
	ret


	
	global delenil
delenil:
	enter 0, 0
	xor edx, edx          ; no mess in the edx
	mov eax, [ebp+12]     ; high a
	div dword [ebp+16]    ; /=b
	push eax              ; backup

	mov eax, [ebp+8]      ; low a
	div dword [ebp+16]    ; /=b
	
	mov ecx, [ebp+20]     ; *zbitek
	jcxz .taknic
	mov [ecx], edx
.taknic:
	pop edx

	leave
	ret





