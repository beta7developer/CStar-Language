@echo off
title CStar Linker
color 1F

echo [CStar Linker] Linking started...
set input=%~1
set output=%~n1.exe

if "%input%"=="-v" (
    echo CStar Linker Version 1.0.1
    exit /b 0
)

rem === Compile the transpiled .cpp file ===
g++ -ID:\CStar\include "%input%" -w -std=c++20 -o "%output%" -lm

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Linker failed. Aborting.
    pause
    exit /b %errorlevel%
)

echo [CStar Linker] Linking successful!
echo [CStar Linker] Running "%output%"...

rem === Run the executable inside CMD ===
cmd /c "%output%"

echo.
echo [CStar Linker] Program exited.
exit /b 0
