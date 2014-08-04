#author Christian Rebischke <echo Q2hyaXMuUmViaXNjaGtlQGdtYWlsLmNvbQo= | base64 -d>
#very simple commandprocessor with execv and sysread/syswrite

.section .data
msg: .ascii "Your Input here: "
buffer: .space 128
exec: .ascii "/bin/sh#-c#AAAABBBBCCCCDDDDD"

.section .text
.global _start

_start:

#write syscall
  mov $4, %eax
  mov $1, %ebx
  mov $msg, %ecx
  mov $17, %edx
  int $0x80

#read syscall
  mov $3, %eax
  mov $0, %ebx
  mov $buffer, %ecx
  int $0x80

#execv syscall
  xor %eax, %eax
  movb %al, exec+7
  movb %al, exec+10
  movl $exec, exec+12
  lea exec+8, %ebx
  movl %ebx, exec+16
  mov $buffer, %ecx
  lea (%ecx), %ebx
  movl %ebx, exec+20
  movl %eax, exec+24
  movb $0x0b, %al
  mov $exec, %ebx
  lea exec+12, %ecx
  lea exec+24, %edx
  int $0x80
  
