@set OWECHO=off
@if "%OWDEBUG%" == "1" set OWECHO=on
@echo %OWECHO%
REM ...
REM Script to build the Open Watcom bootstrap tools
REM ...
if "%OWTOOLS%" == "WATCOM" (
    set PATH=%WATCOM_PATH%
)
if "%OWTOOLS%" == "VISUALC" (
    if "%OWIMAGE%" == "vs2017-win2016" call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
    if "%OWIMAGE%" == "windows-2019" call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" amd64
    if "%OWIMAGE%" == "windows-2022" call "C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvarsall.bat" amd64
)
REM ...
@echo %OWECHO%
REM ...
REM setup Help Compilers
REM ...
if "%OWBUILD_STAGE%" == "docs" (
    set OWGHOSTSCRIPTPATH=%OWCIROOT%\ntx64
    set OWWIN95HC=%OWCIROOT%\nt386\hcrtf.exe
    set OWHHC=%OWCIROOT%\nt386\hhc.exe
)
REM ...
call %OWROOT%\cmnvars.bat
REM ...
set OWVERBOSE=1
REM ...
@echo %OWECHO%
REM ...
if "%OWDEBUG%" == "1" (
    echo INCLUDE="%INCLUDE%"
    echo LIB="%LIB%"
    echo LIBPATH="%LIBPATH%"
)
REM ...
SETLOCAL EnableDelayedExpansion
set RC=0
cd %OWSRCDIR%
if "%OWBUILD_STAGE%" == "boot" (
    mkdir %OWBINDIR%\%OWOBJDIR%
    mkdir %OWSRCDIR%\wmake\%OWOBJDIR%
    cd %OWSRCDIR%\wmake\%OWOBJDIR%
    if "%OWTOOLS%" == "WATCOM" (
        wmake -f ..\wmake
    ) else (
        nmake -f ..\nmake
    )
    set RC=!ERRORLEVEL!
    if not %RC% == 1 (
        mkdir %OWSRCDIR%\builder\%OWOBJDIR%
        cd %OWSRCDIR%\builder\%OWOBJDIR%
        %OWBINDIR%\%OWOBJDIR%\wmake -f ..\binmake bootstrap=1
        set RC=!ERRORLEVEL!
        if not %RC% == 1 (
            cd %OWSRCDIR%
            builder boot
            set RC=!ERRORLEVEL!
        )
    )
)
if "%OWBUILD_STAGE%" == "build" (
    builder rel
    set RC=!ERRORLEVEL!
)
if "%OWBUILD_STAGE%" == "tests" (
REM    builder test %OWTESTTARGET%
REM    set RC=!ERRORLEVEL!
)
if "%OWBUILD_STAGE%" == "docs" (
    REM register all Help Compilers DLL's
    regsvr32 -u -s itcc.dll
    regsvr32 -s %OWCIROOT%\nt386\itcc.dll
    builder docs %OWDOCTARGET%
    set RC=!ERRORLEVEL!
)
if "%OWBUILD_STAGE%" == "inst" (
    builder install os_nt cpu_x64
    set RC=!ERRORLEVEL!
)
cd %OWROOT%
exit %RC%
