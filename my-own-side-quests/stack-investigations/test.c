#include <stdio.h>
#include <stdbool.h>

void foo(int p1, int p2, int p3, int p4) {
    char str[20];
    printf("Enter a string, any string!");
    gets(str);

}

int main() {
    foo(0xDEAD, 0xDEAD, 0xDEAD, 0xDEAD);
    printf("Thanks!\n");
    exit(0);
}


// Ughh, understood more now.
// The home space is reserved by the caller function, but written to by the
// callee function just before it adjusted the stack pointer.
//

// e.g. disassembly of above:


/*
0:000> uf test+0x107f

---MAIN---

test+0x1060:
00007ff6`918e1060 4883ec28        sub     rsp,28h
00007ff6`918e1064 41b9adde0000    mov     r9d,0DEADh
00007ff6`918e106a 41b8adde0000    mov     r8d,0DEADh
00007ff6`918e1070 baadde0000      mov     edx,0DEADh
00007ff6`918e1075 b9adde0000      mov     ecx,0DEADh
00007ff6`918e107a e881ffffff      call    test+0x1000 (00007ff6`918e1000)
00007ff6`918e107f 488d0d9a1f0200  lea     rcx,[test+0x23020 (00007ff6`91903020)]
00007ff6`918e1086 e875000000      call    test+0x1100 (00007ff6`918e1100)
00007ff6`918e108b 33c9            xor     ecx,ecx
00007ff6`918e108d e89e6c0000      call    test+0x7d30 (00007ff6`918e7d30)
00007ff6`918e1092 33c0            xor     eax,eax
00007ff6`918e1094 4883c428        add     rsp,28h
00007ff6`918e1098 c3              ret

0:000> uf test+0x103b

---FOO---

First four lines are FOO moving the parameters passed to it via registers into
the home space reserved by main, above *before* it adjusts the stack pointer.

At that point FOO will also reserve home space, but not for itself, for any 
function it calls to use.

test+0x1000:
00007ff6`918e1000 44894c2420      mov     dword ptr [rsp+20h],r9d
00007ff6`918e1005 4489442418      mov     dword ptr [rsp+18h],r8d
00007ff6`918e100a 89542410        mov     dword ptr [rsp+10h],edx
00007ff6`918e100e 894c2408        mov     dword ptr [rsp+8],ecx
00007ff6`918e1012 4883ec48        sub     rsp,48h
00007ff6`918e1016 488b0523200200  mov     rax,qword ptr [test+0x23040 (00007ff6`91903040)]
00007ff6`918e101d 4833c4          xor     rax,rsp
00007ff6`918e1020 4889442438      mov     qword ptr [rsp+38h],rax
00007ff6`918e1025 488d0dd41f0200  lea     rcx,[test+0x23000 (00007ff6`91903000)]
00007ff6`918e102c e8cf000000      call    test+0x1100 (00007ff6`918e1100)
00007ff6`918e1031 488d4c2420      lea     rcx,[rsp+20h]
00007ff6`918e1036 e8e1690000      call    test+0x7a1c (00007ff6`918e7a1c)
00007ff6`918e103b 488b4c2438      mov     rcx,qword ptr [rsp+38h]
00007ff6`918e1040 4833cc          xor     rcx,rsp
00007ff6`918e1043 e8a8010000      call    test+0x11f0 (00007ff6`918e11f0)
00007ff6`918e1048 4883c448        add     rsp,48h
00007ff6`918e104c c3              ret









*/