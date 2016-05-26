
;1. Napiste fci, ktera provede rotaci cisla doprava o N bitu. [32b] (9)
;	long long rol64(long long x, int N)
;	{
;		return x >>>> N;
;	}
	
rol64:
	enter 0, 0
	mov ecx, [ebp+16] ; N 
.loop:
	clc
	mov eax, [ebp+8]
	rcr eax, 1        ; get CF
	rcr DWORD [ebp+12], 1
	rcr DWORD [ebp+8], 1
	loop .loop
	mov ebp, [ebp+12]
	mov eax, [ebp+8]
	leave
	ret
	

;2. Napiste fci, ktera secte cisla pole, ktera jsou delitelna cislem 'nasobek'. [32b/64b] (9)
;	int soucet(int *p, int N, int nasobek)
	
soucet:				; 32b
	enter 0, 0
	push esi
	push ebx
	mov ecx, [ebp+12]	; N
	mov esi, [ebp+8]	; p
	xor ebx, ebx
.loop:
	mov eax, [esi+ecx*4-4]
	cdq
	idiv DWORD [ebp+16]
	cmp EDX, 0			; reminder?
	jne .skip
	add ebx, [esi+ecx*4-4]
.skip:
	loop .loop
	mov eax, ebx
	pop ebx
	pop esi
	leave
	ret
	
; 3. Napiste fci, ktera spocita velikost vektoru. Pouzijte externi fci sqrt. [32b/64b] (9)
;	int delka(int *p, int N)
;	{
;		return sqrt(p1*p1+p2*p2+...);
;	}

	extern sqrt
delka:				; 32b
	enter 0, 0
	push ebx
	push edi
	xor ebx, ebx
	mov ecx, [ebp+12] ; N
	mov edx, [ebp+8]  ; p
.loop:
	mov eax, [edi+ecx*4-4]
	imul eax
	add ebx, eax
	loop .loop
	push ebx
	call sqrt
	pop ebx
	; restore
	pop edi
	pop ebx
	leave
	ret

; 4. Napiste fci porovnavajici 2 vektory. Vyuzijte napsanou funkci delka. [32b/64b] (9)
;	int porovnani(int *v1, int *v2, int N)
;	{
;		int l1 = delka(v1, N);
;		int l2 = delka(v2, N);
;		l1-=l2;
;		if(l1==0) return 0;
;		if(l1>0) return 1;
;		return -1
;	}

porovnani:			; 32b
	enter 0, 0
	push edi
	push DWORD [ebp+16] ; N
	push DWORD [ebp+8]  ; v1
	call delka
	mov edi, eax        ; l1
	pop eax
	push dword [ebp+12]
	call delka
	sub edi, eax
	test edi, edi
	jg .bigger
	jl .smaller
	xor eax, eax         ; equal
	jmp .end
.bigger:
	mov eax, 1
	jmp .end
.smaller:
	mov eax, -1
	;jmp .end
.end:
	pop edi
	leave
	ret
	
; 5. Napiste fci, ktera spocita pocet mezer v retezci. [32b/64b] (9)
;	int pocet(char *s);

pocet:					; 32b
	enter 0, 0
	xor eax, eax     ;result
	mov edx, [ebp+8] ;s
.loop:
	mov cl, [edx]
	cmp cl, 0		 ; end?
	je .end
	cmp cl, ' '		 ; space?
	jne .continue
	inc eax
.continue:
	inc edx
	jmp .loop
.end:
	leave
	ret

6. Napiste fci, ktera odstrani pocatecni mezery v retezci. [32b/64b] (10)
;	char* trim_space(char* source)
;	{
;		char *s = source;
;		while(*s!='\0' && *s==' ') s++;
;		strcpy(source, s);
;		return source
;	}

	extern strcpy:
trim_space:				; 32b
	enter 0, 0
	mov eax, [ebp+8] ; source
	mov edx, eax     ; s
.find:
	mov cl, [edx]
	cmp cl, 0        ; end?
	je .found
	cmp cl, ' '      ; space?
	jne .found
	inc edx
	jmp .find
.found:
	push edx
	push eax
	call strcpy
	pop edx
	pop edx
	leave
	ret
