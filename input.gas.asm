.section .data
text: .ascii "Your Input here: "
buffer: .ascii ""

.section .text
.global _start


_start:

	movl $4, %eax
	movl $1, %ebx
	movl $text, %ecx
	movl $22, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $buffer, %ecx
	movl $80, %edx
	int $0x80	

	movl $4, %eax
	movl $1, %ebx
	movl $buffer, %ecx
	movl $26, %edx
	int $0x80

	movl $1, %eax
	movl $0, %ebx
	int $0x80	
