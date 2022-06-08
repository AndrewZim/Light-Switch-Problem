.386
.model flat, c
.code
public light_switch
light_switch proc switches
        mov     edx, esp
        mov     ecx, switches   ;how many switches
        mov     ebx, ecx
        shr     ecx, 2          ;divide by 4
        xor     eax, eax        ;zero the register
init:   push    eax             ;push 4 bytes
        loop    init            ;initialize the memory space
        mov     eax, 0          ;which person
personloop: inc eax             ;next person
        cmp     eax, ebx
        ja      doneswitch      ;all persons are done switching
        mov     edi, esp
        dec     edi             ;1 indexed array
        call    switchloop      ;do all switches for this person
        jmp     personloop
doneswitch: mov ecx, ebx
        mov     eax, 0          ;zero the counter
        mov     esi, esp
count:  cmp byte ptr[esi], 0
        je      count1
        inc     eax             ;count the switches that are set
count1: inc esi
        loop    count
        mov     esp, edx        ;restore stack pointer
        ret
light_switch endp
switchloop: 
        add     edi, eax        ;next switch
        cmp     edi, edx
        jae     @F
        xor byte ptr[edi], 1    ;toggle one switch
        jmp     switchloop  
@@:     ret
        end