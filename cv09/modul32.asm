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



	global add_iN_iN
add_iN_iN:
	enter 0, 0
	push edi
	push esi
	mov ecx, [ebp+16]  ; ecx = N
	mov edi, [ebp+8]   ; edi = n1
	mov esi, [ebp+12]  ; esi = n2
	mov edx, 0         ; index
	clc                ; CF = 0
.loop:
	mov eax, [esi + edx*4]
	adc [edi + edx*4], eax
	inc edx
	loop .loop
	mov eax, 0
	adc eax, 0
	pop esi
	pop edi
	leave
	ret


	global sub_iN_iN
sub_iN_iN:
	enter 0, 0
	push edi
	push esi
	mov ecx, [ebp+16]  ; ecx = N
	mov edi, [ebp+8]   ; edi = n1
	mov esi, [ebp+12]  ; esi = n2
	mov edx, 0         ; index
	clc                ; CF = 0
.loop:
	mov eax, [esi + edx*4]
	sbb [edi + edx*4], eax
	inc edx
	loop .loop
	mov eax, 0
	adc eax, 0
	pop esi
	pop edi
	leave
	ret



	global shr_iN
shr_iN:
	enter 0, 0
	
	mov ecx, [ebp+12]   ; N
	mov edx, [ebp+8]    ; n

	clc
.loop:
	rcr dword [edx + ecx*4-4], 1
	loop .loop
	mov eax, 0
	adc eax, 0
	leave
	ret




	global shl_iN
shl_iN:
	enter 0, 0
	mov ecx, [ebp+12]   ; N
	mov edx, [ebp+8]    ; n

	clc
	mov eax, 0
.loop:
	rcl dword [edx + eax*4], 1
	inc eax
	loop .loop
	mov eax, 0
	adc eax, 0
	leave
	ret


	global shrd_iN_i32
shrd_iN_i32:
	enter 0, 0
	push ebx

	mov ecx, [ebp+12]  ; okolik
	mov ebx, 0
	mov edx, [ebp+8]   ; n
	dec dword [ebp+16] ; N--

.loop:
	mov eax, [edx+ebx*4+4]   ; n[i+1]
	shrd [edx+ebx*4], eax, cl
	inc ebx
	;add edx, 4         ; i++
	cmp ebx, [ebp+16]        ; if(i<N)
	jl .loop
	shr dword [edx+ebx*4], cl
	
	pop ebx
	leave
	ret






