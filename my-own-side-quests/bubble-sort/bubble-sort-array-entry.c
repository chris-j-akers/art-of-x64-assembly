#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

extern int32_t* bubble_sort(int *array, int array_len);
void print_array(const int32_t *array, const int32_t array_len);
void fill_array(int32_t* array, int32_t array_len);

void fill_array(int32_t* array, const int32_t array_len) {
    int32_t max = 0x7FFFFFFF;

    srand(time(NULL));
    for (int i=0; i<array_len; i++) {
        array[i] = (int32_t)rand();
    }
}

void print_array(const int32_t *array, const int32_t array_len) {
    for (int i=0; i<array_len; i++) {
        printf("[%p] Array[%ld] = [%ld]\n", &array[i], i, array[i]);
    }
}

void c_bubble_sort(int32_t *array, const int32_t array_len) {
    bool swapped = true;
    int32_t temp;

    do {
        swapped = false;
        for(int i=0; i<array_len; i++) {
            if (array[i] > array[i+1]) {
                temp = array[i+1];
                array[i+1] = array[i];
                array[i] = temp;
                swapped = true;
            }
        }
    } while(swapped == true);
}

void duplicate_array(const int32_t* src_array, int32_t* dest_array, const int32_t array_len) {
    for (int i=0; i<array_len; i++) {
        dest_array[i] = src_array[i];
    }    
}

int main() {
    int array_len = 200000;

    int32_t *c_array = malloc(array_len * sizeof(int32_t));
    int32_t *asm_array = malloc(array_len * sizeof(int32_t));

    fill_array(c_array, array_len);
    duplicate_array(c_array, asm_array, array_len);

    clock_t begin;
    clock_t end;
    double time_spent;

    printf("Sorting using C function...\n");
    begin = clock();
    c_bubble_sort(c_array, array_len);
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Time spent sorting in C: %f\n", time_spent);

    printf("Sorting using MASM function...\n");
    begin = clock();
    bubble_sort(asm_array, array_len);
    end = clock();
    time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Time spent sorting in MASM: %f\n", time_spent);

    free(c_array);
    free(asm_array);

    return 0;
}



