@echo off
set "BUILD_TYPE=Release"
set "BUILD_DIR=.\build\win-x64-msvc"
set "LIBS_DIR=.\gpt4all.net.Runtime\win-x64"

REM Cleanup env
rmdir /s /q %BUILD_DIR%

REM Create directories
mkdir %BUILD_DIR%
mkdir %LIBS_DIR%

REM Build
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -S . -B %BUILD_DIR% -A x64

:BUILD
REM Build the project
cmake --build "%BUILD_DIR%" --parallel --config %BUILD_TYPE%

REM Check the exit code of the build command
if %errorlevel% neq 0 (
    echo Build failed. Retrying...
    goto BUILD
)

mkdir gpt4all.net.Runtime/win-x64

REM Copy the DLLs to the desired location
del /F /A /Q %LIBS_DIR%
copy /Y "%BUILD_DIR%\bin\Release\*.dll" gpt4all.net.Runtime\win-x64
move /Y "%LIBS_DIR%\llmodel.dll" ".\%LIBS_DIR%\libllmodel.dll"

echo Batch script execution completed.