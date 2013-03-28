@echo off
REM *****************************************************************
REM SETVARS.CMD - OS/2 version
REM *****************************************************************
REM NOTE: Do not use this batch file directly, but copy it and
REM       modify it as necessary for your own use!!

REM Change this to point your Open Watcom source tree
set OWROOT=c:\ow\ow

REM Set this entry to use native compiler tools
set OWUSENATIVE=0

REM Subdirectory to be used for building OW build tools
set OWOBJDIR=binbuild

REM Set this variable to 1 to get debug build
set OWDEBUGBUILD=0

REM Set this variable to 1 to get default windowing support in clib
set OWDEFAULT_WINDOWING=0

REM Change following entries to point your existing Open Watcom installation
if '%OWUSENATIVETOOLS%' == '1' goto host_setup
set WATCOM=c:\ow\ow19
set INCLUDE=%WATCOM%\h;%WATCOM%\h\os2
set BEGINLIBPATH=%WATCOM%\binp\dll;%BEGINLIBPATH%
set PATH=%WATCOM%\binp;%WATCOM%\binw;%PATH%
:host_setup

REM Documentation related variables

REM Set this variable to 0 to suppress documentation build
set OWDOCBUILD=1

REM Change this to the PATH required by GhostScript for PDF creation on used host OS (optional)
REM set OWGHOSTSCRIPTPATH=%PATH%

REM Change these variables to point Windows help compilers which you have installed
REM set OWWIN95HC=hcrtf
REM set OWHHC=hhc

REM Invoke the script for the common environment
call %OWROOT%\cmnvars.cmd

cd %OWROOT%
