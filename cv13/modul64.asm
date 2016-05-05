	bits 64
    ;parameters:  RDI, RSI, RDX, RCX, R8, R9
	;free2use:    RAX, R10, R11

	section .data
_tmp dd 0,0,0,0
	section .text
	global vsphere, pytha, vecsum, vecsize
vsphere:
	movsd xmm2, xmm0
	mulsd xmm0, xmm2 ; 2*r
	mulsd xmm0, xmm2 ; 3*r
	mulsd xmm0, xmm1 ; PI
	mov eax, 4
	cvtsi2sd xmm2, eax
	mulsd xmm0, xmm2
	mov eax, 3
	cvtsi2sd xmm2, eax
	divsd xmm0, xmm2
	ret
	
	extern sqrtf
pytha:
	mulss xmm0, xmm0
	mulss xmm1, xmm1
	addss xmm0, xmm1
	call sqrtf
	ret

vecsum:
	;movsd xmm0, [rdi]
	;movsd xmm1, [rsi]
	;dec rcx
	mov rcx, rdx
.loop:
	movsd xmm0, [rdi+rcx*8-8]
	movsd xmm1, [rsi+rcx*8-8]
	addsd xmm0, xmm1
	movsd [rdi+rcx*8-8], xmm0
	loop .loop
	ret

	extern sqrt
vecsize:
	mov rcx, rsi
	mov eax, 0   ; null the sum
	cvtsi2sd xmm0, eax

.loop:
	movsd xmm1, [rdi+rcx*8-8]
	mulsd xmm1, xmm1
	addsd xmm0, xmm1
	loop .loop
	call sqrt
	ret


	; ---------------------------------------

	global arrsum
arrsum:
	movups xmm0, [rdi]  ; first 4 elements
	movsx rcx, esi      ; N
	sar rcx, 2          ; N/4
	dec rcx
.loop:
	add rdi, 16         ; 4*32b
	addps xmm0, [rdi]
	loop .loop
	movups  [_tmp], xmm0
	addss xmm0, [_tmp+4]
	addss xmm0, [_tmp+8]
	addss xmm0, [_tmp+12]
	ret


	global max
max:
	movss xmm0, [rdi]
	movsx rcx, esi    ; N
	dec rcx
.loop:
	comiss xmm0, [rdi+rcx*4]
	ja .nothing
	movss xmm0, [rdi+rcx*4]
.nothing:
	loop .loop
	ret

	global prumer
prumer:
	mov eax, 0
	cvtsi2ss xmm0, eax ; sum
	movsx rcx, esi     ; N
.loop:
	addss xmm0, [rdi+rcx*4-4]
	loop .loop
	cvtsi2ss xmm1, esi ; (float) N
	divss xmm0, xmm1   ; /N
	ret
	
	global fl2i
fl2i:
	cvtss2si eax, xmm0
	ret

	global obvod
obvod:
	addsd xmm0, xmm0 ; 2*r
	mulsd xmm0, xmm1 ; *PI
	ret


	global fl2dbl
fl2dbl:
	cvtss2sd xmm0, xmm0
	ret
	
	global retfl, retdbl
retfl:
	ret

retdbl:
	ret

