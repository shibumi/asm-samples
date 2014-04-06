#Original by http://fionalerntprogrammieren.wordpress.com
#Execute it with ./uppercase <inputfile> <outputfile>

.global _start

.equ BUFFEREND, 1
.lcomm buffer, BUFFEREND

_start:

movl %esp, %ebp

movl $5, %eax
movl 8(%ebp), %ebx
movl $0, %ecx
int $0x80

pushl %eax

movl $5, %eax
movl 12(%ebp), %ebx
movl $03101, %ecx
movl $0666, %edx
int $128

pushl %eax

loop:
movl -4(%ebp), %ebx
movl $3, %eax
movl $buffer, %ecx
movl $BUFFEREND, %edx
int $128

pushl %eax

cmpb $97, buffer
jl next_byte
cmpb $122, buffer
jg next_byte

subb $32, buffer

next_byte:

movl %eax, %edx
movl $4, %eax
movl -8(%ebp), %ebx
movl $buffer, %ecx
int $0x80

popl %eax

cmpl $BUFFEREND, %eax
jne loopexit

jmp loop

loopexit:
movl $1, %eax
movl $0, %ebx
int $0x80

