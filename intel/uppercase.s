;Intel translation of power.s in AT&T syntax
;execute it with: ./uppercase <inputfile> <outputfile>

section .bss 

BUFFEREND EQU 1
buffer: RESB BUFFEREND


section .text
global _start

_start:

mov ebp, esp

mov eax, 0x5
mov ebx, [ebp+0x8]
mov ecx, 0x0
int 0x80

push eax

mov eax, 0x5
mov ebx, [ebp+0xC]
mov ecx, 03101q
mov edx, 0666q
int 0x80

push eax

loop:
mov ebx, [ebp-0x4]
mov eax, 3
mov ecx, buffer
mov edx, BUFFEREND
int 0x80

push eax

cmp BYTE  [buffer], 97
jl next_byte
cmp BYTE  [buffer], 122
jg next_byte

sub BYTE  [buffer], 32

next_byte:

mov edx, eax
mov eax, 0x4
mov ebx, [ebp-0x8]
mov ecx, buffer
int 0x80

pop eax

cmp eax, BUFFEREND
jne loopexit

jmp loop

loopexit:
mov eax, 1
mov ebx, 0
int 0x80



