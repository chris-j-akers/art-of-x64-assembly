#include <stdio.h>
#include <stdlib.h>

extern "C"
{
    // We will write this assembler function in a separate file
    // then compile it to an .obj file. We we compile this C++ program
    // we will link it to the assembler object file which will
    // provide the source for this function.

    // I have changed this slightly so that the asm puts a value into rax
    // which will be the return value (int). The original
    // listing is void.
    int asmFunc(void);
};

int main() {
    unsigned int ret;
    printf("Calling asmMain:\n");

    // As above, asmFunc() just puts a number into rax and this
    // seems to pick it up fine.
    ret = asmFunc();

    printf("Returned from asmMain, return value is: %d\n", ret);
    exit(ret);
}


