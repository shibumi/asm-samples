;author Christian Rebischke <echo Q2hyaXMuUmViaXNjaGtlQGdtYWlsLmNvbQo= | base64 -d>
;very simple commandprocessor with execv and sysread/syswrite

section .bss
buffer: resb 128

section .data
msg: db "Your Input here: "
len: equ $-msg
exec: db "/bin/sh#-c#AAAABBBBCCCCDDDDD"

section .text
global _start

_start:

  mov eax, 4
  mov ebx, 1
  mov ecx, msg
  mov edx, len
  int 0x80

  mov eax, 3
  mov ebx, 0
  mov ecx, buffer
  int 0x80

  xor eax, eax
  mov byte [exec + 7], al
  mov byte [exec + 10], al
  mov long [exec + 12], exec
  lea ebx, [exec + 8]
  mov long [exec + 16], ebx
  mov ecx, buffer
  lea ebx, [ecx]
  mov long [exec + 20], ebx
  mov long [exec + 24], eax
  mov byte al, 0x0b
  mov ebx, exec
  lea ecx, [exec + 12]
  lea edx, [exec + 24]
  int 0x80
  
