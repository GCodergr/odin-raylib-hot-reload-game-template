@echo off

if not exist "./bin/debug" (
	mkdir "./bin/debug"
)

odin build src/main_release -define:RAYLIB_SHARED=false -out:bin/debug/game_debug.exe -no-bounds-check -subsystem:windows -debug
