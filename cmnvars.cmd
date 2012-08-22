@echo off
REM *****************************************************************
REM CMNVARS.CMD - common environment variables
REM *****************************************************************
REM NOTE: All scripts to set the environment must call this script at
REM       the end.

REM Set the version numbers
set BLD_VER=20
set BLD_VER_STR=2.0

REM Set up default path information variable
if "%OWDEFPATH%" == "" set OWDEFPATH=%PATH%

REM Stuff for the Open Watcom build environment
set BUILD_PLATFORM=os2386
REM Subdirectory to be used for bootstrapping/prebuild binaries
set OWBINDIR=%OWROOT%\bld\build\binp
set DWATCOM=%WATCOM%
set INCLUDE=%WATCOM%\h;%WATCOM%\h\os2
set EDPATH=%WATCOM%\eddat
set PATH=%OWBINDIR%;%OWROOT%\build;%WATCOM%\binp;%WATCOM%\binw;%OS2TKROOT%\bin;%OWDEFPATH%

echo Open Watcom compiler build environment

REM OS specifics

REM Ensure COMSPEC points to CMD.EXE
set COMSPEC=CMD.EXE

set IPFC=%OS2TKROOT%\ipfc
set BEGINLIBPATH=%WATCOM%\binp\dll
