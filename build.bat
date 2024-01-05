echo off
ml64 /Fo".\\build\\" /nologo /c /Zi /Cp %1/%2.asm
cl /Fo".\\build\\" /nologo /O2 /Zi /utf-8 /EHa /Fe".\\build\\"%2.exe /Fd".\\build\\" c.cpp ".\build\"%2.obj
