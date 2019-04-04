; En mac, las llamadas a funcion llevan _ adelante
; global _borrarUltimo
; global _agregarPrimero
; extern _free
; extern _malloc

global borrarUltimo
global agregarPrimero
extern free
extern malloc

%define NULL 0
; Definir offsets para nodo
%define off_nodoDato 0
%define off_nodoProx 8
%define SIZE_NODE 16 
; Definir los offsets para lista
%define off_lPrim 0
%define SIZE_LIST 8
; Definir el tamaño de un nodo para malloc


; Recibo por RDI un puntero a la estructura lista 
borrarUltimo:
	push rbp			;alineada
	mov rbp, rsp
	sub rsp, 8
	push r12			;alineada
	xor r12, r12		;limpio r12

	; Armo stackframe
	; Recordar! Si modifico rbx, r12, r13, r14 o r15 debo pushearlos
	; Alinear pila si está desalineada

	mov r9, [rdi]									;puntero a la lista
	mov r8, [rdi]									;muevo el nodo que esta en la lista a un registro

	cmp qword[r8 + off_nodoProx], NULL 			;verifico si nodo->prox == NULL
	jnz .variosElementos
	mov rdi, r8
	call free									;limpio el nodo
	jmp .fin
	;mov dword[r9], NULL
	;mov byte[r8], NULL							
	;jmp .fin

	.variosElementos:
	mov r9, r8
	mov r8, [r9 + off_nodoProx]					;obtengo el puntero al proximo nodo
	;mov r8, [r9]
	;mov r9, r8	
	;mov r8, [r8]								
	cmp byte[r8 + off_nodoProx], NULL
	jnz .variosElementos 
	mov rdi, r8					
	call free
	mov qword[r9 + off_nodoProx], NULL

	.fin:
	pop r12
	add rsp, 8
	pop rbp
	ret



; Recibo por RDI un puntero a la estructura lista
; Recibo por RSI el dato, un entero (4 bytes), cuidado al copiar datos!
agregarPrimero:
	; Armo stackframe
	; Recordar! Si modifico rbx, r12, r13, r14 o r15 debo pushearlos
	; Alinear pila si está desalineada

	push rbp							;alineada			
	mov rbp, rsp
	push rbx							;desalineada
	sub rsp, 8							;alineada
	mov r8, rdi							;guardo en r8 la direccion de la lista
	mov rbx, rsi						;guardo en rbx el dato
	mov rdi, SIZE_NODE
	call malloc
	mov r9, [r8 + off_lPrim]
	mov [rax + off_nodoDato], ebx		;añado el dato al nodo, unNodo->dato = unInt
	mov [rax + off_nodoProx], r9		
	mov [r8], rax						;unaLista->primero = unNodo
	add rsp, 8				
	pop rbx
	pop rbp
	ret
