	bits 32

	section .data
	extern index, value               ; in another module
	global delka, pozdrav             ; will be public
pozdrav db 'Hello World!', 10, 0      ; string, newline, \0
pole dd 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ; int pole [10]
delka dd 10

	section .text
	global do_pole, get_pole          ; public functions

do_pole:
	mov EAX, [index]
	mov EDX, [value]
	mov [pole + EAX*4], EDX
	ret

get_pole:
	mov EAX, pole                     ; return address of pole
	ret
