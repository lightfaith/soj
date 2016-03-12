	bits 32

	section .data


	section .text
	global substring
substring:
	enter 0,0
	push edi
	push esi
	mov edi, [ebp + 8]  ; destination buffer
	mov esi, [ebp + 12] ; source string
	mov edx, [ebp + 16] ; start index
	; width will be found later
	mov ax, ds
	mov es, ax

	; find the start
	mov ecx, edx
	cmp ecx, 0
	je .copy
.findstart:
	inc esi
	loop .findstart
.copy:
	; copy the part
	mov ecx, [ebp + 20] ; width
	repe movsb

	pop esi
	pop edi
	leave
	ret
	
	
	
	
;	extern strlen, strcmp	
;	global starstar
;starstar:
;	enter 0, 0
;	; prepare strings
;	; in loop run strcmp and check result==0
;	push edi
;	push esi
;	push ebx
;
;	; get desired values
;	mov edi, [ebp + 8]       ; *haystack
;	mov esi, [ebp + 12]      ; *needle
;	push esi
;	call strlen
;	mov ecx, eax             ; strlen(needle)
;	pop eax                  ; garbage
;	
;	;mov ax, ds
;	;mov es, ax
;
;	; prepare space on the stack (with zeros, 32b boundary)
;	shr ecx, 2    ; count /= 4
;	inc ecx       ; plus one, for loop
;
;.preparestack:
;	push 0x00000000
;	loop .preparestack
;
;	; now put substring(haystack) into the allocated space and simply strcmp() it
;	
;	push edi
;	call strlen
;	add esp, 4
;	mov edx, esp ; the local tmpbuffer
;	mov ebx, eax    ; length of the haystack (loop manually!)
;	sub ebx, ecx    ; because we need all possible start positions
;
;	xor ecx, ecx
;	add esp, 4      ; clean garbage
;
;.compareloop:
;	cmp ecx, ebx    ; at the end?
;	je .notfound
;
;	; get the substring
;	; first save my precious registers
;	push ecx
;	push edx
;	; call strlen
;	push esi
;	call strlen
;	; clean garbage, load my precious registers
;	add esp, 4
;	pop edx
;	pop ecx
;	; prepare for substring
;	push eax        ; width
;	push ecx        ; start
;	push edi        ; source (the haysstack)
;	push edx        ; destination (the stack)
;	call substring
;	add esp, 16     ; clean the stack

	; compare it
;	push edx
;	push esi
;	call strcmp
;	pop ebx         ; garbage
;	pop ebx         ; garbage
;	cmp eax, 0
;	je .found
;	inc ecx
;	jmp .compareloop
;	
;.found:
;	; get length of haystack, subtract counter value
;	;push edi
;	;call strlen
;	;sub eax, ecx
;	mov eax, ecx
;	jmp .return
;
;.notfound:
;	xor eax, eax
;	jmp .return

;.return:
;	pop ebx
;	pop esi
;	pop edi
;	leave
;	ret

	extern strlen, strncmp
	global starstar
starstar:
	enter 0,0
	push edi
	push esi
	push ebx

	mov edi, [ebp+8]  ; *haystack
	mov esi, [ebp+12] ; *needle

	push esi
	call strlen
	mov ebx, eax      ; strlen(needle)
	add esp, 4
	
	push edi
	call strlen
	mov ecx, eax      ; strlen(haystack)
	add esp, 4
	cmp ecx, 0
	je .notfound      ; strlen() == 0
	push ecx          ; length of the string unchanged
.lup:
	mov edx, edi
	add edx, [esp]    ; plus length
	sub edx, ecx      ; minus backward counter

	; save my precious registers
	push ecx
	push edx
	; run strcmp
	push ebx
	push esi
	push edx
	call strncmp
	add esp, 12
	; load my precious registers
	pop edx
	pop ecx
	; and what's the result?
	cmp eax, 0
	je .found
	loop .lup
	; not found, return 0
.notfound:
	mov eax, 0
	jmp .return

.found:
	mov eax, edx
	jmp .return
.return:
	pop ebx
	pop esi
	pop edi
	leave
	ret


	global minmax
minmax:
	enter 0,0
	mov eax, [ebp + 8]    ; *array
	mov ecx, [ebp + 12]   ; len
	push DWORD [eax]      ; min
	push DWORD [eax]      ; max
	push eax              ; so I can rewrite it in loop :)

.lup:
	mov eax, [esp]
	mov edx, [eax + ecx * 4 - 4]   ; get new number to compare
	
	mov eax, [ebp-4]               ; eax will hold the lower one
	cmp edx, eax
	cmovl eax, edx
	mov [ebp-4], eax               ; write eax variable into the variable (on stack)

	mov eax, [ebp-8]               ; eax will holde the greater one
	cmp edx, eax
	cmovg eax, edx
	mov [ebp-8], eax               ; write eax value into the variable (on stack)
	loop .lup

	mov eax, [ebp + 16]            ; write local min into argument pointer
	mov edx, [ebp-4]
	mov [eax], edx
	
	mov eax, [ebp + 20]            ; write local max into argument pointer
	mov edx, [ebp-8]
	mov [eax], edx

	leave
	ret



	global atoy
atoy:
	enter 0,0
	mov edx, [ebp + 8]     ; *strnum
	xor eax, eax           ; result
	xor ecx, ecx           ; actual character
	push 0                 ; minus sign

.lup:
	mov cl, BYTE [edx]     ; actual character
	cmp cl, 0              ; end of string>
	je .break             
	cmp cl, ' '            ; is space? skip
	je .continue
	cmp cl, '-'
	je .minus              ; is minus? remember to negate
	sub cl, '0'            ; normal number, do classic math
	push edx               ; save edx and null it, just in case...
	xor edx, edx
	imul eax, 10
	pop edx
	add eax, ecx
	jmp .continue
	
.minus:
	cmp eax, 0
	jg .fail               ; minus in the middle
	cmp DWORD [esp], 0
	jg .fail               ; many minuses
	inc DWORD [esp]        ; set flag to negate
	jmp .continue

.fail:
	xor eax, eax
	jmp .break

.continue:
	inc edx                ; next char
	jmp .lup

.break:
	cmp DWORD [esp], 0        
	je .return             ; no negation? return result
	neg eax
.return:
	leave
	ret


