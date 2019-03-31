%define NULL 0
; Completar!
%define offset_comision 0
; Completar!
%define offset_nombre 8
; Completar!
%define offset_edad 16


%define comision rsi
%define nombre rdx
%define edad rcx

; En mac, las funciones llevan un _ adelante
; En caso de mac, _printf
extern printf

; En caso de mac, global _mostrarAlumno
global mostrarAlumno

section .data
	texto: db "Nombre: %s, comision: %d, edad: %d", 0x0a, 0x00

section .text

; En caso de mac, _mostrarAlumno
; Me llega por RDI el PUNTERO a la estructura
mostrarAlumno: 						;dir de retorno
	push rbp						;pusheo rbp y la pila esta alineada
	mov rbp, rsp
	; Pila alineada
	; Recordar pushear RBX, R12, R13, R14 y R15 si se utilizan
	;push r12			;desalineada
	;add rsp, 8			;alineada
	mov comision, [rdi+offset_nombre]
	mov nombre, [rdi+offset_comision]
	mov edad, [rdi+offset_edad]
	mov rdi, texto
	;mov rax, 0  					no pincha ni corta esta linea
	call printf
	; Desencolo
	;sub rsp, 8
	;pop r12
	pop rbp
	ret
	;si la pila esta desalineada tendremos segmentation fault(core dumped)