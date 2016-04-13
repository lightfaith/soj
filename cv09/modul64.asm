	bits 64
	;parameters:  RDI, RSI, RDX, RCX, R8, R9
	;free2use:    RAX, R10, R11
	section .data


	section .text
	global div_iN_i32
div_iN_i32:

	;rdi = *n
	;edx = N
	mov rcx, rdx
	;esi = delitel
	xor rax, rax
	xor rdx, rdx
	
.loop:
	mov eax, dword [rdi+rcx*4-4] ; load number from array (like digit), eax = n[rcx-1]
	div esi                      ; /%
	mov [rdi+rcx*4-4], dword eax ; n[rcx-1] = eax
	loop .loop

	mov eax, edx                 ; remainder
	
	ret



	global add_iN_i32
add_iN_i32:
               	 ; rdi = *n
	mov ecx, edx ;  N
	dec ecx
	             ; esi = N
	mov rdx, 1                  ; i
	add [rdi], esi              ; n[0] += scitanec
.loop:
	jnc .out
	adc [rdi + rdx*4], dword 0  ; maybe carry?
	inc rdx                     ; preserves CF
	loop .loop
.out:
	ret



	global mul_iN_i32
mul_iN_i32:

	;rdi = *n
	;edx = N
	mov rcx, rdx
	xor r8, r8                 ; tmprdx
.loop:
	mov eax, [rdi]             ; n[i]
	mul esi                    ; eax*=cinitel
	add eax, r8d               ; eax + old edx
	adc edx, 0                 ; carry?
	mov r8d, edx               ; save edx for next round
	mov [rdi], eax             ; write part of the result that won't change
	add rdi, 4                 ; n++
	loop .loop

	; mov eax, edx               ; overflow
	
	ret






	global add_iN_iN
add_iN_iN:
	xor rcx, rcx
	mov ecx, edx
	xor rdx, rdx
	clc                ; CF = 0
.loop:
	mov eax, [rsi + rdx*4]
	adc [rdi + rdx*4], eax
	inc rdx
	loop .loop
	mov eax, 0
	adc eax, 0
	ret


	global sub_iN_iN
sub_iN_iN:
	xor rcx, rcx
	mov ecx, edx
	xor rdx, rdx
	clc                ; CF = 0
.loop:
	mov eax, [rsi + rdx*4]
	sbb [rdi + rdx*4], eax
	inc rdx
	loop .loop
	mov eax, 0
	adc eax, 0
	ret



	global shr_iN
shr_iN:
	mov rcx, rsi
	clc
.loop:
	rcr dword [rdi + rcx*4-4], 1
	loop .loop
	mov rax, 0
	adc rax, 0
	ret




	global shl_iN
shl_iN:
	enter 0, 0
	mov rcx, rsi
	clc
	mov rax, 0
.loop:
	rcl dword [rdi + rax*4], 1
	inc rax
	loop .loop
	mov rax, 0
	adc rax, 0
	leave
	ret


	global shrd_iN_i32
shrd_iN_i32:
	mov rcx, rsi       ; okolik
	mov r9, rdx        ; x = N
	mov r8, 0          ; i = 0
	dec rdx            ; N--

.loop:
	xor rax, rax
	mov eax, [rdi+r8*4+4]   ; n[i+1]
	shrd [rdi+r8*4], eax, cl
	inc r8
	cmp r8, r9        ; if(i<N)
	jl .loop
	shr dword [rdi+r8*4], cl

	ret






















