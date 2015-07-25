; args.s - gets argumets and prints them out
;=============================================

sys_exit    equ     1
sys_read    equ     3
sys_write   equ     4
stdin       equ     0
stdout      equ     1
stderr      equ     3

section .data
noArgsMsg: db "No Arguments specified", 0x0A
lenNoArgsMsg: equ $-noArgsMsg
newLineCharacter: db  0x0A
lenNewLineCharacter: equ $-newLineCharacter

section .text
global _start

_start:
  ; push base pointer to stack and save esp in ebp
  push ebp
  mov ebp, esp

  ; if no arguments are given jump to quit
  cmp dword[ebp + 4], 1
  je noArgs

  ; set ebx = 3, because first argument is at [ebp + 12]
  mov ebx, 3


checkForArgument:
  ; function checks for next argument
  mov edi, dword[ebp + 4 * ebx]

  ; check for null-byte
  test edi, edi
  jz quit

  ; execute getLength then print Argument
  call getLength
  push edi
  push ecx
  call printArg

  ; increment ebx for next argument
  inc ebx
  jmp checkForArgument


noArgs:
  ; print noArgsMsg
  mov eax, sys_write
  mov ebx, stdout
  mov ecx, noArgsMsg
  mov edx, lenNoArgsMsg
  int 0x80
  jmp quit

getLength:
  ; get string length
  ; string is in edi register
  ; save edi address in edx
  mov edx, edi
  
  ; set ecx to highest value and clear eax
  xor ecx, ecx   
  not ecx
  xor eax, eax

  ; clear direction flag and scan string for nullbyte
  cld
  repne scasb

  ; replace ecx with two-complement and compute ecx - 2
  neg ecx
  dec ecx
  dec ecx
  mov edi, edx    
  ret

printArg:
  ; print argument
  push ebp
  ; saving ebx
  push ebx
  mov ebp, esp
  mov eax, sys_write
  mov ebx, stdout
  mov ecx, dword[ebp + 16]
  mov edx, dword[ebp + 12]
  int 0x80
  call printNewLine
  ; restoring ebx
  pop ebx
  pop ebp
  ret

quit:
  ; quit programm
  mov eax, sys_exit
  xor ebx, ebx
  int 0x80
  
printNewLine:
  ; function for printing newline-character
  push ebp,
  mov ebp, esp
  mov eax, sys_write
  mov ebx, stdout
  mov ecx, newLineCharacter
  mov edx, lenNewLineCharacter
  int 0x80
  pop ebp
  ret
