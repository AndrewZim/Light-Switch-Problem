#include <iostream>
#include <Windows.h>
extern "C" int light_switch(int switches);
int main()
{
    LARGE_INTEGER timestart;
    LARGE_INTEGER timeend;
    LARGE_INTEGER frequency;
    int switches_on;
    int switches = 1000000;
    std::cout << "Light Switch Problem, how many switches? ";
    std::cin >> switches;
    if (switches < 1 or switches > 1000000) {
        switches = 1000000;
    }
    std::cout << "Light Switch Problem with " << switches << " switches\n";
    QueryPerformanceFrequency(&frequency);
    QueryPerformanceCounter(&timestart);
    switches_on = light_switch(switches);
    QueryPerformanceCounter(&timeend);
    std::cout << switches_on << " switches on\n";
    std::cout << "Finished in " << (timeend.QuadPart - timestart.QuadPart) * 1000000 / frequency.QuadPart << " microseconds";
    return(0);
}

