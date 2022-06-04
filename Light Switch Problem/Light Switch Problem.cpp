#include <iostream>
#include <Windows.h>
extern "C" int light_switch1(int switches);

int light_switch(int switches);
int main()
{
    LARGE_INTEGER timestart;
    LARGE_INTEGER timeend;
    LARGE_INTEGER frequency;
    int switches_on;
    int switches = 100;

    std::cout << "Light Switch Problem with " << switches << " switches\n";
    QueryPerformanceFrequency(&frequency);
    QueryPerformanceCounter(&timestart);
    switches_on = light_switch1(switches);
    QueryPerformanceCounter(&timeend);
    std::cout << switches_on << " switches on\n";
    std::cout << "Finished in " << (timeend.QuadPart - timestart.QuadPart) * 1000000 / frequency.QuadPart << " microseconds";
    return(0);
}
int light_switch(int switches)
{
    __asm {
        mov edx, esp
        mov eax, 0
        mov ecx, switches
        mov ebx, ecx
        shr ecx, 2
init:   push eax
        loop init; initialize the memory space
        mov eax, 0; which person
personloop: inc eax
        cmp eax, ebx
        ja  done
        mov edi, esp
        call switchloop
        jmp personloop
switchloop: xor byte ptr[edi], 1
        add edi, eax
        cmp edi, edx
        jb switchloop
        ret
done:   mov ecx, ebx
        mov eax, 0
        mov esi, esp
count:  cmp byte ptr[esi], 0
        je count1
        inc eax
count1: inc esi
        loop count
        nop
        mov esp, edx
    }
}
