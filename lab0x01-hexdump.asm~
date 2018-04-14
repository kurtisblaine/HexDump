;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
;To compile the program run these commands:

;	nasm -f elf32 -g -F dwarf lab0x01-hexdump.asm
;	ld -m elf_i386 lab0x01-hexdump.o -o go


;directed input: ./go < filename 
;		 ./go < filename | lab0x01-heaxdump | etc


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
section .text      
	global _start         
_start:
	nop 		;helps with debugging

; reads from buffer
_read:
	mov eax,3       ; preparing for sys_read call
	mov ebx,0       ; preparing for sys_read call
	mov ecx,buffer        ; offset
	mov edx,bufferLength     ; moving bufferlength for sys_read
	int 0x80        ; interrupt to activate sys_read
	mov ebp,eax     ; saving the number of bytes in unused register
	cmp eax,0       ; is EOF? if so...
	je _exit         ; jump to exit

	; prepares buffer for buffer scan
	mov esi,buffer        
	mov edi,hexString   
	xor ecx,ecx     ; this clears line and pointer to 0

; conversion of binary to hexadecimal digits
_scan:
	xor eax,eax     ; this clears eax to 0

	; calculation of the offset into the line string ( which is ecx X 3 )
	mov edx,ecx     ; copy pointer into line string into edx
	shl edx,1       ; multiply pointer by 2, shifting left
	add edx,ecx     ; multiplication X3

	; gets character and moves into ebx and eax
	mov al,byte [esi+ecx]   ; move a byte from the input buffer into register al
	mov ebx,eax     ; copy the byte in bl for second nybble

	; find the low nybble character and copy it into hexString
	and al,0Fh         ; Mask out all but the low nybble
	mov al,byte [digits+eax]   ; find the character equivalent
	mov byte [hexString+edx+2],al ; write out the character equivalent to hexString

	; find up high nybble character and insert it into hexString
	shr bl,4        ; move the highest 4 bits of char into low 4 bits
	mov bl,byte [digits+ebx] ; find up char equivalent of nybble
	mov byte [hexString+edx+1],bl ; write out the character equivalent to hexString

	; pointer to the next buffer character
	inc ecx     ; ++
	cmp ecx,ebp ; cmp to remainder of characters in buffer
	jl _scan    ; if ecx < ebp then initiate loop

	; sys_write line by line
	mov eax,4       ; preparing for sys_write call
	mov ebx,1       
	mov ecx,hexString      ; move offset of string
	mov edx,hexLength      ; move size of the string
	int 0x80         ; initiates above actions
	jmp _read        ; loops back and loads file buffer again

;prevents seg fault exits buffer read operations
_exit:
	mov eax,1       
	mov ebx,0       
	int 0x80     
	
section .bss            
	bufferLength equ 4		;buffer constant (changeable)
	buffer resb bufferLength  	;initialization of buffer
	  
section .data           
	hexString db ' 00 00 00 00 ',10 	;format type of hexString
	hexLength equ $-hexString		;length algorithm
	digits db '0123456789abcdef' 		;hex digit possibilities    
