#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void multiply(int **a, int **b, int **c, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            c[i][j] = 0;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int k = 0; k < n; k++) {
            int aik = a[i][k];
            for (int j = 0; j < n; j += 4) { 
                c[i][j] += aik * b[k][j];
                c[i][j + 1] += aik * b[k][j + 1];
                c[i][j + 2] += aik * b[k][j + 2];
                c[i][j + 3] += aik * b[k][j + 3];
            }
        }
    }
}

int main() {
    int n;

    printf("Ingrese el tamaño de la matriz: ");
    scanf("%d", &n);

    int **a = malloc(n * sizeof(int *));
    int **b = malloc(n * sizeof(int *));
    int **c = malloc(n * sizeof(int *));

    for (int i = 0; i < n; i++) {
        a[i] = malloc(n * sizeof(int));
        b[i] = malloc(n * sizeof(int));
        c[i] = malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            a[i][j] = i + j;
            b[i][j] = i - j;
        }
    }

    clock_t start, end;
    double cpu_time_used;

    start = clock();
 
    multiply(a, b, c, n);

    end = clock();

    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

    printf("Tiempo de cálculo de matriz %dx%d: %f segundos\n", n, n, cpu_time_used);

    for (int i = 0; i < n; i++) {
        free(a[i]);
        free(b[i]);
        free(c[i]);
    }

    free(a);
    free(b);
    free(c);

    return 0;
}
