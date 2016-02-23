	bits 32

	section .data
	extern delka, pole, soucet

	section.text
	global suma_pole

suma_pole:
	mov eax, 0
	mov ecx, [delka]	
zpet:
	add eax, [pole + ecx * 4 - 4]     ; -4 because of loop nature
;	add eax, [pole+(ecx-1)*4]         ; also possible (ecx won't be decremented internally)
	loop zpet                         ; if(--ECX) goto zpet;
	mov [soucet], eax
	ret


