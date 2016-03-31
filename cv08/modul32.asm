	bits 32

	section .data


	section .text
	global div_iN_i32
div_iN_i32:
	enter 0, 0
	push ebx

	mov ebx, [ebp+8] ; *n
	mov ecx, [ebp+16];  N
	xor edx, edx
	
.loop:
	mov eax, [ebx+ecx*4-4] ; load number from array (like digit), eax = n[ecx-1]
	div dword [ebp+12]     ; /%
	mov [ebx+ecx*4-4], eax ; n[ecx-1] = eax
	loop .loop

	mov eax, edx           ; remainder
	
	pop ebx
	leave
	ret



	global add_iN_i32
add_iN_i32:
	enter 0, 0
	push ebx

	mov ebx, [ebp+8]            ; *n
	mov ecx, [ebp+16]           ;  N
	dec ecx
	mov eax, [ebp+12]           ; scitanec

	mov edx, 1                  ; i
	add [ebx], eax              ; n[0] += scitanec
.loop:
	jnc .out
	adc [ebx + edx*4], dword 0  ; maybe carry?
	inc edx                     ; preserves CF
	loop .loop
.out:
	pop ebx
	leave
	ret



	global mul_iN_i32
mul_iN_i32:
	enter 0, 0
	push ebx
	push edi

	mov ecx, [ebp+16]          ;  N
	mov ebx, [ebp+8]           ; *n
	mov edi, 0                 ; tmpedx
.loop:
	mov eax, [ebx]             ; n[i]
	mul dword [ebp+12]         ; eax*=cinitel
	add eax, edi               ; eax + old edx
	adc edx, 0                 ; carry?
	mov edi, edx               ; save edx for next round
	mov [ebx], eax             ; write part of the result that won't change
	add ebx, 4                 ; n++
	loop .loop

	; mov eax, edx               ; overflow
	
	pop edi
	pop ebx
	leave
	ret
