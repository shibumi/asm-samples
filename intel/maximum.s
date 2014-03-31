;Intel translation of maximum.s in AT&T

section .data

data_items:
  dd 3,90,34,75,54,34,222,33,22,11,66,0

section .text

global _start

_start:

  mov edi, 0
  mov eax, dword[edi*4 + data_items]
  mov ebx, eax

start_loop:

  cmp eax, 0
  je loop_exit
  inc edi
  mov eax, dword[edi*4 + data_items]
  cmp eax, ebx
  jle start_loop

  mov ebx, eax
  jmp start_loop

loop_exit:
  
  mov eax, 1
  int 0x80

