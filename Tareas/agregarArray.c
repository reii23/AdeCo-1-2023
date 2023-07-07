#include <stdio.h>

int main() {
    int array[100];
// Incrementa cada elemento de un arreglo de 100 números por un valor de 10. /
    int scalar = 10;
    
    int *ptr = &array[99];
    
    while(ptr >= array) {
        *ptr = *ptr + scalar;
        ptr--; 
    }
    
    return 0;
}

