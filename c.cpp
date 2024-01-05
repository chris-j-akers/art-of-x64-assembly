#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern "C" {

    // Assembly procs called by the C++ code
    void asm_main(void);
    char* get_title(void);

    // Function called by the assembly code
    int read_line(char *dest, int max_len);

}

int read_line(char *dest, int max_len) {
    char *result = fgets(dest, max_len, stdin);
    if (result != NULL) {
        // Take newline character off end of string (replace it with NUL)
        int len = strlen(result);
        if (len >0) {
            dest[len-1] = 0;
        }
        return len;
    }
    return -1;
}


int main(void) {

    try {
        char* title = get_title();

        printf("Calling %s:\n", title);
        asm_main();
        printf("%s terminated\n", title);
    }
    catch(...) {
        printf(
                "Exception occurred during program execution\n"
                "Abnormal program termination\n"
             );
    }
}