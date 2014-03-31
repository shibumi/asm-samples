;Intel translation of power.s in AT&T syntax
;What it does: (3 ^ 0) + (5 ^ 2)

global _start
_start:
  push 0x0
  push 0x3
  call power
  push edx
  push 0x2
  push 0x5
  call power
  add esp, 0x8
  pop ebx
  add ebx, edx
  mov eax, 0x1
  int 0x80

power:
  mov ebx, [esp+0x4]
  mov ecx, [esp+0x8]
  cmp ecx, 0x0
  je one
  mov edx, ebx

power_loop_start:
  cmp ecx, 0x1
  je end_power
  mov eax, edx
  imul eax, ebx
  mov edx, eax
  dec ecx
  jmp power_loop_start

one:
  mov edx, 0x1

end_power:
  ret
