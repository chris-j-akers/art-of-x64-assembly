echo off
REM ml64 /Fo".\\build\\" /nologo /c /Zi /Cp bubble-sort-array-counter.asm
ml64 /Fo".\\build\\" /nologo /c /Cp bubble-sort-array-address.asm
REM cl /Fo".\\build\\" /nologo /O2 /Zi /utf-8 /EHa /Fe".\\build\\"bubble-sort-array.exe /Fd".\\build\\" bubble-sort-array-entry.c ".\build\"bubble-sort-array-counter.obj
cl /Fo".\\build\\" /nologo /O2 /utf-8 /EHa /Fe".\\build\\"bubble-sort-array.exe /Fd".\\build\\" bubble-sort-array-entry.c ".\build\"bubble-sort-array-address.obj
