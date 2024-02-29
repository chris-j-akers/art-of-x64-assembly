#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

extern void bubble_sort_asm(int *array, int array_len);
extern clock_t clock();

void print_array(const int32_t *array, const int32_t array_len);
void fill_array(int32_t* array, int32_t array_len);


// Fill an array with a load of random numbers to sort!
void fill_array(int32_t* array, const int32_t array_len) {
    int32_t max = 0x7FFFFFFF;

    srand(time(NULL));
    for (int i=0; i<array_len; i++) {
        array[i] = (int32_t)rand();
    }
}

// Make a copy so we can use it twice
void clone_array(const int32_t* src_array, int32_t* dest_array, const int32_t array_len) {
    for (int i=0; i<array_len; i++) {
        dest_array[i] = src_array[i];
    }    
}

// Print it out
void print_array(const int32_t *array, const int32_t array_len) {
    for (int i=0; i<array_len; i++) {
        printf("[%p] Array[%ld] = [%ld]\n", &array[i], i, array[i]);
    }
}

// C bubble-sort function
void bubble_sort_c(int32_t *array, const int32_t array_len) {
    bool swapped = true;
    int32_t temp;

    do {
        swapped = false;
        for(int i=0; i<array_len-1; i++) {
            if (array[i] > array[i+1]) {
                temp = array[i+1];
                array[i+1] = array[i];
                array[i] = temp;
                swapped = true;
            }
        }
    } while(swapped == true);
}


int main() {
    int array_len = 1000;

    int32_t *c_array = malloc(array_len * sizeof(int32_t));
    int32_t *asm_array = malloc(array_len * sizeof(int32_t));

    fill_array(c_array, array_len);
    clone_array(c_array, asm_array, array_len);

    clock_t begin;
    clock_t end;
    double c_time_spent;
    double asm_time_spent;

    // Do C first
    begin = clock();
    bubble_sort_c(c_array, array_len);
    end = clock();
    c_time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    
    // Now Asm
    begin = clock();
    bubble_sort_asm(asm_array, array_len);
    end = clock();
    asm_time_spent = (double)(end - begin) / CLOCKS_PER_SEC;

    // Results
    printf("Time spent sorting in C: %lf\n", c_time_spent);
    printf("Time spent sorting in MASM: %lf\n", asm_time_spent);

    free(c_array);
    free(asm_array);

    return 0;
}



