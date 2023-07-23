#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void multiply_row(int **a, int **b, int **c, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            c[i][j] = 0;
            for (int k = 0; k < n; k++) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

void multiply_column(int **a, int **b, int **c, int n) {
    for (int j = 0; j < n; j++) {
        for (int i = 0; i < n; i++) {
            c[i][j] = 0;
            for (int k = 0; k < n; k++) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

void reset_matrix(int **c, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            c[i][j] = 0;
        }
    }
}

int main() {
    int n;

    printf("Ingrese el tamano de la matriz: ");
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

    // Medir el tiempo al recorrer la matriz por filas
    reset_matrix(c, n);
    start = clock();
    multiply_row(a, b, c, n);
    end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Tiempo de calculo de matriz %dx%d (por filas): %f segundos\n", n, n, cpu_time_used);

    // matriz por columnas
    reset_matrix(c, n);
    start = clock();
    multiply_column(a, b, c, n);
    end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Tiempo de calculo de matriz %dx%d (por columnas): %f segundos\n", n, n, cpu_time_used);

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
