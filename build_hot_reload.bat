@echo off

if not exist "./bin/dev" (
	mkdir "./bin/dev"
)

rem Uncomment these lines if you want to build an atlas from any aseprite files in a `textures` subfolder.
rem odin build atlas_builder -use-separate-modules -out:atlas_builder.exe -strict-style -vet-using-stmt -vet-using-param -vet-style -vet-semicolon -debug
rem IF %ERRORLEVEL% NEQ 0 exit /b 1
rem atlas_builder.exe
rem IF %ERRORLEVEL% NEQ 0 exit /b 1

rem Build game.dll
odin build src/game -show-timings -use-separate-modules -define:RAYLIB_SHARED=true -build-mode:dll -out:bin/dev/game.dll -strict-style -vet-unused -vet-using-stmt -vet-using-param -vet-style -vet-semicolon -debug
IF %ERRORLEVEL% NEQ 0 exit /b 1

rem If game.exe already running: Then only compile game.dll and exit cleanly
set EXE=bin/dev/game.exe
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% exit /b 1

rem build game.exe
odin build src/main_hot_reload -use-separate-modules -out:bin/dev/game.exe -strict-style -vet-using-stmt -vet-using-param -vet-style -vet-semicolon -debug
IF %ERRORLEVEL% NEQ 0 exit /b 1

rem copy raylib.dll from odin folder to here
if not exist "bin/dev/raylib.dll" (
	echo "Please copy raylib.dll from <your_odin_compiler>/vendor/raylib/windows/raylib.dll to the same directory as game.exe"
	exit /b 1
)

exit /b 0
