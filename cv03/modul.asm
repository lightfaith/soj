	bits 32

	section .data

	section .text
	global testret, soucet, sumarray


testret:
	enter 0, 0	       ; push EBP; mov EBP, ESP; sub ESP, n
	mov eax, [ebp+8]   ; first argument

	leave              ; mov ESP, EBP; pop EBP
	ret

soucet:
	enter 0,0
	mov eax, [ebp + 8]
	add eax, [ebp + 12]
	leave
	ret

sumarray:
	enter 0, 0
	xor eax, eax
	mov ecx, [ebp+12]  ; number of elements
	mov edx, [ebp+8]   ; pointer to array
.for:
	add eax, [edx + ecx * 4 - 4]
	loop .for
	leave
	ret


	global spacenum
spacenum:
	enter 0, 0
	mov edx, [ebp+8]     ; *str
	xor eax, eax         ; pocet = 0
.lup:
	cmp BYTE [edx], 0    ; *str =='\0' (\0, not \0\0\0\0 !)
	je .hura_ven
	cmp BYTE [edx], ' '  ; *str == ' '
	jne .nospace
	inc eax              ; pocet++;
.nospace:
	inc edx              ; str++;
	jmp .lup
.hura_ven:
	leave
	ret


	global lowercount
lowercount:
	enter 0, 0
	mov edx, [ebp + 8]
	xor eax, eax
.lup:
	test BYTE [edx], 0xff ; *str & 0xff == 0
	jz .hura_ven
	cmp BYTE [edx], 'a'
	jb .nolower
	cmp BYTE [edx], 'z'
	ja .nolower
	inc eax
.nolower:
	inc edx
	jmp .lup
.hura_ven:
	leave
	ret


	global posnegcount
posnegcount:
	enter 0, 0
	push ebx ; ebx, edi and esi must be restored!
	mov edx, [ebp+8]     ; *arr
	mov ecx, [ebp+12]    ; N
	xor eax, eax         ; pos
	xor ebx, ebx         ; neg

.lup:
	CMP DWORD [edx + ecx * 4 - 4], 0
	jge .positive
	jl .negative
.positive:
	inc eax
	jmp .finally
.negative:
	inc ebx
	jmp .finally
.finally:
	loop .lup

	mov edx, [ebp + 16]
	mov [edx], eax       ; *pos = positive
	mov edx, [ebp + 20]
	mov [edx], ebx       ; *neg = negative
	xor eax, eax
	pop ebx
	leave
	ret



; task

	global lower
lower:
	enter 0,0
	mov edx, [ebp + 8]
.lup:
	cmp BYTE [edx], 0
	je .over
	cmp BYTE [edx], 'A'
	jb .continue
	cmp BYTE [edx], 'Z'
	ja .continue
	add BYTE [edx], 'a' - 'A'
.continue:
	inc edx
	jmp .lup
.over:
	leave
	ret


	global replace
replace:
	enter 0,0
	mov edx, [ebp + 8]
	mov al, [ebp + 12]
.lup:
	cmp BYTE [edx], 0
	je .over
	cmp BYTE [edx], 0x30
	jb .continue
	cmp BYTE [edx], 0x39
	ja .continue
	mov [edx], al
.continue:
	inc edx
	jmp .lup
.over:
	leave
	ret


	global oddcount
oddcount:
	enter 0,0
	push ebx
	mov edx, [ebp + 8]
	mov ecx, [ebp + 12]
	xor eax, eax
.for:
	mov ebx, [edx + ecx * 4 - 4]
	test ebx, 0x01
	jz .noincrement
	inc eax
.noincrement:
	loop .for
	pop ebx
	leave
	ret


	global avgs
avgs:
	enter 16, 0
	mov edx, [ebp + 8]
	mov ecx, 4
.nullify:
	mov DWORD [esp + ecx * 4 - 4], 0
	loop .nullify

	mov ecx, [ebp + 12]
.for:
	mov eax, [edx + ecx * 4 - 4]
	cmp DWORD eax, 0
	jg .bigger
	jl .smaller
	jmp .finally
.bigger:
	add [ebp-16], eax
	inc DWORD [ebp-8]
	jmp .finally
.smaller:
	add [ebp-12], eax
	inc DWORD [ebp-4]
	jmp .finally
.finally:
	loop .for
	
	pop eax
	cdq
	idiv DWORD [ebp-8]
	mov edx, [ebp+16]
	mov [edx], eax
	
	pop eax
	cdq
	idiv DWORD [ebp-4]
	mov edx, [ebp+20]
	mov [edx], eax
	
	leave
	ret


