echo off
ml64 /Fo".\\build\\" /nologo /c /Zi /Cp bubble-sort-array-counter.asm
cl /Fo".\\build\\" /nologo /O2 /Zi /utf-8 /EHa /Fe".\\build\\"bubble-sort-array.exe /Fd".\\build\\" bubble-sort-array-entry.c ".\build\"bubble-sort-array-counter.obj
