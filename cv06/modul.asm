	bits 64

	section .data

	
	section .text
	; param order: RDI, RSI, RDX, RCX, R8, R9
	; rewritable: RAX, R10, R11

	global nasob
nasob:
	xor rax, rax
	mov rax, rdi
	imul rax, rsi
	ret



	global nasobl
nasobl:
	mov rax, rdi
	imul rax, rsi
	ret


	global soucet
soucet:
	movsx rcx, esi ;counter -> 64b
	xor rax, rax
.lup:
	add eax, [rdi + rcx * 4 - 4]
	loop .lup
	ret


	global soucetl
soucetl:
	movsx rcx, esi
	xor rax, rax
.lup:
	movsx rdx, dword [rdi + rcx * 4 - 4]
	add rax, rdx
	loop .lup
	ret



	global soucetll
soucetll:
	movsx rcx, esi
	xor rax, rax
.lup:
	add rax, [rdi + rcx * 8 - 8]
	loop .lup
	ret



	global atob
atob:
	mov rax, rsi ; return string
	; left padding
	mov rcx, 64
.lup:
	mov [rsi], byte '0'  ; *str = '0'
	shl rdi, 1
	adc [rsi], byte 0    ; if() (*str)++;
	inc rsi              ; str++
	loop .lup
	mov [rsi], byte 0    ; \0
	ret

	

	global minmax
minmax:
	mov r10, rdx    ; min
	mov r11, rcx    ; max
	movsx rcx, esi  ; counter

	; init max and min values
	movsx r8, dword [rdi]                       ; this will be new min
	movsx r9, dword [rdi]                       ; this willl be new max
.lup:
	xor rax, rax
	movsx rax, dword [rdi + rcx * 4 - 4]
	cmp rax, r8
	cmovl r8, rax                               ; lower? update minimum
	cmp rax, r9
	cmovg r9, rax                               ; greater? update maximum
	loop .lup
	mov [r10], r8d                               ; write results into variables
	mov [r11], r9d
	ret



	global atoy
atoy:
	xor rax, rax         ; result
	xor rdx, rdx         ; char
.lup:
	mov dl, byte [rdi]
	cmp dl, 0            ; end
	je .break
	cmp dl, '0'
	jl .break 
	cmp dl, '9'
	jg .break
	
	sub dl, '0'
	imul rax, 10
	
	add rax, rdx         ; upper part is nullied, so this is ok
	inc rdi
	jmp .lup

.break:
	ret

	

	extern strlen, strncmp
	global starstar
starstar:
	; TODO BUG SOMEWHERE, main is forced to re-run
	push r12
	push r13
	push r14
	push r15

	mov r12, rdi          ; haystack
	mov r13, rsi          ; needle
	
	call strlen
	mov r14, rax          ; strlen(haystack)

	mov rdi, r13
	call strlen
	mov r15, rax          ; strlen(needle)

	mov rcx, r14
	sub rcx, r15
.lup:
	push rcx
	
	mov rdi, r12
	mov rsi, r13
	mov rdx, r15
	call strncmp
	cmp rax, 0
	je .found

	inc r12
	pop rcx
	loop .lup
	xor rax, rax          ; return null
	jmp .ret

.found:
	pop rcx
	mov rax, r12
	jmp .ret
.ret:
	pop r15
	pop r14
	pop r13
	pop r12
	ret


