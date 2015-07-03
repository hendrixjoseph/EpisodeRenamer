@echo off

setlocal enabledelayedexpansion

set season=3
set filetype=avi

rem If check is true, then the rename commands will be outputted rather than executed.
set check=true

set old=0
set new=0

for /R %%G in (*.%filetype%) do (
	set "oldName=%%G"
	set "oldName=!oldName:%CD%\=!"
		
	set oldNames[!old!]=!oldName!
	
	set /a old=!old!+1
)

for /f "delims=" %%A in (episodeNames.txt) do (
	
	set "newName=%%A.%filetype%"
	
	set newNames[!new!]=!newName!
	
	set /a new=!new!+1
)

if !old!==!new! (
	
	set /a end=!old!-1
	
	for /L %%i in (0,1,!end!) do (
	
		set /a episodeNumber=%%i+1
	
		if !episodeNumber! GEQ 10 (
			set zero=
		) else (
			set zero=0
		)
		
		set "newNames[%%i]=%season%.!zero!!episodeNumber! !newNames[%%i]!"
	
		if "%check%"=="true" (
			echo ren "!oldNames[%%i]!" "!newNames[%%i]!"
		) else (
			echo ren "!oldNames[%%i]!" "!newNames[%%i]!"
			ren "!oldNames[%%i]!" "!newNames[%%i]!"
		)
	)
	
	if "%check%"=="true" (
			echo !old! files to rename.
	) else (
			echo !old! files renamed.
	)
) else (
	echo Number of names in episodeNames.txt ^(!new!^) does not match the number of %filetype% files ^(!old!^).
)

pause
