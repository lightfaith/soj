	bits 64

	section .data


	section .text
	global deleni
deleni:
	movsx r8, edx     ; divisor
	xor rdx, rdx
	mov rax, rsi      ; high a
	div r8
	push rax

	mov rax, rdi
	div  r8
	mov [rcx], edx
	pop rdx

	ret

