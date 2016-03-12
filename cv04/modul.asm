	bits 32

	section .data


	section .text

	global mystrlen
mystrlen:
	enter 0,0
	push edi

	mov edi, [ebp + 8]    ; *str
	mov al, 0             ; \0 we are looking for
	mov dx, ds            ; es = ds (so complicated because memory is queried)
	mov es, dx
	xor ecx, ecx
	not ecx               ; max length (strcpy, not strncpy)

	; cld (std)           ; DF = 0, which is default

	repne scasb           ; compare until not equal to eax; repeat is not atomic

	sub edi, [ebp+8]      ; get length of string\0
	dec edi               ; not interested in \0

	mov eax, edi          ; set as return value

	pop edi
	leave
	ret

	
	extern strlen         ; From C libraries
	global mystrcmp
mystrcmp:
	enter 0,0
	push edi
	push esi

	mov esi, [ebp + 12]  ; *src
	mov edi, [ebp + 8]   ; *dest
	xor ecx, ecx
	
	push esi             ; get len of one of the strings (does not matter which one)
	;call mystrlen
	call strlen
	pop edx              ; clean stack from esi (can be changed, so no pop esi!)
	mov ecx, eax         ; get length
	inc ecx              ; because loop decrements first
	

	mov ax, ds
	mov es, ax
	
	repe cmpsb

	mov eax, 1          ; possible return values
	mov edi, 0
	mov esi, -1

	cmove eax, edi       ; equal?  set 0
	cmova eax, esi       ; first is smaller? set 1

	pop esi
	pop edi
	leave
	ret


	global upper
upper:
	enter 0, 0
	push edi
	push esi
	push ebx

	mov edi, [ebp+8]
	mov esi, edi         ; working with the same string
	mov ax, ds
	mov es, ax

.zpet:
	lodsb
	or al, al
	jz .hura              ; \0?
	
	mov bx, 0xffff
	mov dx, ~('a'-'A')    ; for alternative #2

	cmp al, 'a'
	jb .za
	cmp al, 'z'
	;ja .za               ; alternative #1
	;and al, ~('a'-'A')   ; alternative #1
	cmovbe bx, dx         ; alternative #2
.za:
	and al, bl            ; alternative #2
	stosb
	jmp .zpet
	
.hura:
	pop ebx
	pop esi
	pop edi
	leave
	ret



; TASK
	global unchar
unchar:
	enter 0,0
	push edi
	push esi

	mov dl, BYTE [ebp + 12]    ; forbidden
	mov edi, [ebp + 8]         ; string
	mov esi, edi

.lup:
	lodsb
	cmp al, dl
	je .ignored
	stosb
.ignored:
	or al, al                  ; end of string?
	jz .break
	jmp .lup

.break:
	pop esi
	pop edi
	leave
	ret

	
	global meemcpy
meemcpy:
	enter 0,0
	push edi
	push esi
	mov edi, [ebp + 8]      ; *dst
	mov esi, [ebp + 12]     ; *src
	mov ecx, [ebp + 16]     ; length
	
	mov ax, ds
	mov es, ax
	

	cmp edi, esi
	jbe .continue           ; destination does not start after source, this will be safe

	mov eax, esi            ; tmp = src
	add eax, ecx            ; tmp += length
	cmp eax, edi           
	ja .fromthetop          ; tmp > 0? (esi ends after edi start?)
	jmp .continue           ; esi ends before edi start, this is safe

.fromthetop:
	std                     ; set direction flag
	jmp .continue

.continue:
	repne movsb

	cld                     ; clear direction flag always
	pop esi
	pop edi
	leave
	ret

