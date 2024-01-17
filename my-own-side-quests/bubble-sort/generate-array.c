#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>


extern int32_t* bubble_sort(int *array, int array_len);
void print_array(const int32_t *array, const int32_t array_len);
void fill_array(int32_t* array, int32_t array_len);

void fill_array(int32_t* array, const int32_t array_len) {
    int32_t max = 0x7FFFFFFF;

    srand(time(NULL));
    for (int i=0; i<array_len; i++) {
        array[i] = rand() % max;
    }
}

void print_array(const int32_t *array, const int32_t array_len) {
    for (int i=0; i<array_len-1; i++) {
        printf("Array[%d] = [%d]\n", i, array[i]);
    }
}

int main() {
    int array_len = 100;

    int32_t *array = malloc(array_len * sizeof(int32_t));

    fill_array(array, array_len);
    printf("Unsorted array is below:\n");
    print_array(array, array_len);
    bubble_sort(array, array_len);
    printf("Sorted array is below:\n");
    print_array(array, array_len);

    free(array);
    return 0;
}



