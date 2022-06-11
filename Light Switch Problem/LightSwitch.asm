.386
.model flat, c
.code
public light_switch
light_switch proc switches
        mov     edx, esp
        mov     ecx, switches   ;how many switches
        mov     ebx, ecx
        shr     ecx, 2          ;divide by 4
        inc     ecx
        xor     eax, eax        ;zero the register
init:   push    eax             ;push 4 bytes
        loop    init            ;initialize the memory space
        mov     esp,edx
        sub     esp,ebx
        mov     eax, 1          ;start with person 1
personloop:
        mov     edi, esp
        dec     edi             ;1 indexed array
        add     edi, eax        ;next switch (first one always works)
switchloop: 
        xor byte ptr[edi], 1    ;toggle one switch
        add     edi, eax        ;next switch
        cmp     edi, edx
        jb      switchloop
        inc     eax
        cmp     eax,ebx         ;last person?
        jbe     personloop
doneswitch: mov ecx, ebx
        mov     eax, 0          ;zero the counter
        mov     esi, esp
count:  movzx   ebx,byte ptr [esi]
        add     eax,ebx
count1: inc     esi
        loop    count
        mov     esp, edx        ;restore stack pointer
        ret
light_switch endp
        end