	bits 32

	section .data
	extern delka, pole32, pole8, soucet32, prumer32, nasob32, nasob8, okolik
	
	section .text
	global suma_pole32, avg_pole32, suma_pole8, avg_pole8, multiply32, multiply8, shift32, shift8

suma_pole32:
	mov eax, 0
	mov ecx, [delka]	
.for:                                   ; local label
	add eax, [pole32 + ecx * 4 - 4]     ; -4 because of loop nature
;	add eax, [pole32+(ecx-1)*4]         ; also possible (ecx won't be decremented internally)
	loop .for                           ; if(--ECX) goto zpet;
	mov [soucet32], eax
	ret

avg_pole32:
	call suma_pole32
	cdq
	idiv DWORD [delka]
	mov [prumer32], eax
	ret


suma_pole8:
	xor eax, eax
	mov ecx, [delka]	
.for:                                     ; local label
	movsx ebx, BYTE[pole8 + ecx * 1 - 1]
	add eax, ebx                          ; -4 because of loop nature
	loop .for                             ; if(--ECX) goto zpet;
	mov [soucet32], eax
	ret

avg_pole8:
	call suma_pole8
	cdq
	idiv DWORD [delka]
	mov [prumer32], eax
	ret

multiply32:
	mov ebx, [nasob32]
	mov ecx, [delka]
.for:
	mov eax, DWORD [pole32 + ecx * 4 - 4]
	imul ebx
	mov DWORD [pole32 + ecx * 4 - 4], eax
	loop .for
	ret

multiply8:
	mov bl, [nasob8]
	mov ecx, [delka]
.for:
	mov al, BYTE [pole8 + ecx * 1 - 1]
	imul bl
	mov BYTE [pole8 + ecx * 1 - 1], al
	loop .for
	ret


shift32:
	mov ecx, [delka]
.for:
	mov eax, DWORD [pole32 + ecx * 4 - 4]
	; store loop counter ecx
	push ecx
	mov cl, [okolik]
	sar eax, cl
	pop ecx
	mov DWORD [pole32 + ecx * 4 - 4], eax
	loop .for
	ret

shift8:
	mov ecx, [delka]
.for:
	mov al, BYTE [pole8 + ecx * 1 - 1]
	push ecx
	mov cl, [okolik]
	sar al, cl
	pop ecx
	mov BYTE [pole8 + ecx * 1 - 1], al
	loop .for
	ret


