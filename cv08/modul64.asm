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


