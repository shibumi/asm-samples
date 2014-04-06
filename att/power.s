#Original by http://fionalerntprogrammieren.wordpress.com
#What it does: (3 ^ 0) + (5 ^ 2)

.global _start
_start:
  pushl $0
  pushl $3
  call power
  pushl %edx
  pushl $2
  pushl $5
  call power
  addl $8, %esp
  popl %ebx
  addl %edx, %ebx
  movl $1, %eax
  int $0x80

power:
  movl 4(%esp), %ebx
  movl 8(%esp), %ecx
  cmpl $0, %ecx
  je one
  movl %ebx, %edx

power_loop_start:
  cmpl $1, %ecx
  je end_power
  movl %edx, %eax
  imull %ebx, %eax
  movl %eax, %edx
  decl %ecx
  jmp power_loop_start

one:
  movl $1, %edx

end_power:
  ret


