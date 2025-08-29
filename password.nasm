; stack frame
0x08048500 <+0>:  push   ebp                      ; save last stack frame
0x08048501 <+1>:  mov    ebp, esp                 ; create a new stack pointer
0x08048503 <+3>:  sub    esp, 0x8                 ; reseve 8 bytes for local variables!

; outside of loop
0x08048506 <+6>:  mov    DWORD PTR [ebp-0x4], 0x0 ; loop counter variable lets take i
0x0804850d <+13>: jmp    0x08048524               ; jump to 0x08048524 add 1 to i

; loop
0x0804850f <+15>: mov    eax, DWORD PTR [ebp+0x8] ; pointer varible stored in eax
0x08048512 <+18>: add    eax, DWORD PTR [ebp-0x4] ; add i to eax(variable) p[i](most likely)
0x08048515 <+21>: movzx  eax, BYTE PTR [eax]      ; takes 1 byte and zero-extend eax rest of 24 bits, putts in al ; always extends with 0s!
0x08048518 <+24>: movsx  edx, al                  ; load in 32-bit example: 0x0000000f -> 0xf
0x0804851b <+27>: mov    eax, DWORD PTR [ebp-0x4] ; load i into eax
0x0804851e <+30>: add    eax, 0x2a                ; add 42 to i
0x08048521 <+33>: cmp    edx, eax                 ; compare edx with eax. so could be like 0x43 with sum of i+42
0x08048523 <+36>: jne    0x08048534               ; jump if eax not equal to edx, go to -> 0x08048534
0x08048524 <+38>: add    DWORD PTR [ebp-0x4], 0x1 ; add 1 to i // is i++ in C
0x08048528 <+42>: cmp    DWORD PTR [ebp-0x4], 0x4 ; cmp i to 4 // i < 5 in C
0x0804852c <+46>: jle    0x0804850f               ; jump if less or equal to 0x0804850f

; outside of loop
; return and exit
0x08048534 <+52>: mov    eax, 0x1                 ; return 1 in C
0x08048539 <+57>: leave                           : pop in short
0x0804853a <+58>: ret                             ; finish!


;(* so how do we get 0xd4(8-bit) to 32-bit? *)
; here is how:
;    firat we have 0xd4 is 1 byte or 8 bits(11010100 in binary) if we want it to be 32-bit we have to use assembly:
;        movzx (zero-extend):
;            0x000000D4 in CPU fills 24 bit with 0s:
;            00000000    00000000    00000000    11010100
;            so each piece is 8 bits so 8*3 is 24(wich we need to zero extend) and 8*4 is 32(all 32 bits)
;
;        movsx (sing-extend):
;            CPU looks at highest bit (sign bit = 1 -> negative)
;            so it will fill upper 24 bits with 1s(wich is F in hex):
;            0xD4 -> 0xFFFFFFD4
;            where F = 1111
;            what i should WARN you about if the first binary number is 1 its negative as in our case so it will sing-extend with FF but if it a 0 then its positive and it will be replaced with 0!
; finish!


