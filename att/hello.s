.section .data
hello: .ascii "Hello World!\n"

.section .text
.global _start

_start:

	mov $4, %eax        #Syscall 4
	mov $1, %ebx        #File Descriptor 0 == stdout
	mov $hello, %ecx    #Memory adress
	mov $13, %edx       #Length of the text
	int $0x80           #interrupt

	mov $1, %eax        #Programm exitcode
	mov $0, %ebx        #Programm exitcode
	int $0x80           #interrupt
