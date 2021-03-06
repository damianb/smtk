@echo off
REM SMTk - Starbound Mod Toolkit
REM 
REM @author katana <katana@odios.us>
REM @license MIT license <https://opensource.org/licenses/MIT>
REM 
REM Copyright 2017 Damian Bushong <katana@odios.us>
REM 
REM Permission is hereby granted, free of charge, to any person obtaining a 
REM copy of this software and associated documentation files (the "Software"), 
REM to deal in the Software without restriction, including without limitation 
REM the rights to use, copy, modify, merge, publish, distribute, sublicense, 
REM and/or sell copies of the Software, and to permit persons to whom the 
REM Software is furnished to do so, subject to the following conditions:
REM 
REM The above copyright notice and this permission notice shall be included 
REM in all copies or substantial portions of the Software.
REM
REM THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
REM OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
REM FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
REM THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
REM LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
REM ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
REM OTHER DEALINGS IN THE SOFTWARE.

setlocal enabledelayedexpansion enableextensions

REM // DO. NOT. MODIFY. THESE.
REM // SERIOUSLY.  HERE BE DRAGONS.
set iserror=0
set rootdir=%~dp0
set argv=%*

REM // allow overriding the pak name via argv
if(!argv!) NEQ () (
	set pakfile=!argv!
) else (
	echo no pakfile specified to postpakhook.bat
	set iserror=1
	goto END
)

REM // Attempt to copy the mod pak into ./../_packed_mods/
for %%F in ("%rootdir%") do set dest=%%~dpF
set dest=%dest:~0,-1%
for %%F in ("%dest%") do set dest=%%~dpF
set dest=%dest:~0,-1%
set dest=%dest%\_packed_mods\

if exist %dest% (
	for %%F in ("%pakfile%") do set pakname=%%~nxF

	echo copying pak file "%pakname%" 
	echo - from %pakfile% 
	echo - to %dest%
	copy "%pakfile%" "%dest%" >nul
	if errorlevel 1 (
		echo failed to copy pak to packed_mods directory.
		set iserror=1
		goto END
	)
)

:END
exit /b %iserror%