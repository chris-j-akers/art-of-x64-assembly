#include <stdio.h>

extern "C"
{
    // We will write this assembler function in a separate file
    // then compile it to an .obj file. We we compile this C++ program
    // we will link it to the assembler object file which will
    // provide the source for this function.
    void asmFunc(void);
};

int main() {
    printf("Calling asmMain:\n");
    asmFunc();
    printf("Returned from asmMain\n");
}