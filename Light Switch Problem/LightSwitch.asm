.386
.model flat, c
.code
public light_switch1
light_switch1 proc switches
        mov     edx, esp
        mov     eax, 0
        mov     ecx, switches
        mov     ebx, ecx
        shr     ecx, 2
init:   push eax
        loop    init    ;initialize the memory space
        mov     eax, 0  ;which person
personloop: inc eax
        cmp     eax, ebx
        ja      done
        mov     edi, esp
        call    switchloop
        jmp     personloop
done:   mov ecx, ebx
        mov     eax, 0
        mov     esi, esp
count:  cmp byte ptr[esi], 0
        je      count1
        inc     eax
count1: inc esi
        loop    count
        nop
        mov     esp, edx
        ret
light_switch1 endp
switchloop: xor byte ptr[edi], 1
        add     edi, eax
        cmp     edi, edx
        jb      switchloop
        ret

end