# PLUS Builder Control file
# =========================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ BLOCK <1> build rel2 ]
#=======================
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h

[ BLOCK <1> rel2 ]
#=================
    cdsay <PROJDIR>

[ BLOCK <1> rel2 cprel2 acprel2 ]
#================================

#
# 386 NT hosted compilers
#
  [ IFDEF (os_nt "") <2*> ]
#  i86 target
    <CPCMD> i86/nt386/wcppi86.exe   <RELROOT>/binnt/wpp.exe
    <CPCMD> i86/nt386/wcppi86.sym   <RELROOT>/binnt/wpp.sym
    <CPCMD> i86/nt386/wppdi86.dll   <RELROOT>/binnt/wppdi86.dll
    <CPCMD> i86/nt386/wppdi86.sym   <RELROOT>/binnt/wppdi86.sym
    <CPCMD> i86/nt386/wppi8601.int  <RELROOT>/binnt/wppi8601.int
#  386 target
    <CPCMD> 386/nt386/wcpp386.exe   <RELROOT>/binnt/wpp386.exe
    <CPCMD> 386/nt386/wcpp386.sym   <RELROOT>/binnt/wpp386.sym
    <CPCMD> 386/nt386/wppd386.dll   <RELROOT>/binnt/wppd386.dll
    <CPCMD> 386/nt386/wppd386.sym   <RELROOT>/binnt/wppd386.sym
    <CPCMD> 386/nt386/wpp38601.int  <RELROOT>/binnt/wpp38601.int
#  AXP target
    <CPCMD> axp/nt386/wcppaxp.exe   <RELROOT>/binnt/wppaxp.exe
    <CPCMD> axp/nt386/wcppaxp.sym   <RELROOT>/binnt/wppaxp.sym
    <CPCMD> axp/nt386/wppdaxp.dll   <RELROOT>/binnt/wppdaxp.dll
    <CPCMD> axp/nt386/wppdaxp.sym   <RELROOT>/binnt/wppdaxp.sym
    <CPCMD> axp/nt386/wppaxp01.int  <RELROOT>/binnt/wppaxp01.int

#  Optima 386 target (with -br switch)
    <CPCMD> 386/nt386.dll/wcpp386.exe   <RELROOT>/binnt/rtdll/wpp386.exe
    <CPCMD> 386/nt386.dll/wcpp386.sym   <RELROOT>/binnt/rtdll/wpp386.sym
    <CPCMD> 386/nt386.dll/wppd386.dll   <RELROOT>/binnt/rtdll/wppd386.dll
    <CPCMD> 386/nt386.dll/wppd386.sym   <RELROOT>/binnt/rtdll/wppd386.sym
    <CPCMD> 386/nt386.dll/wpp38601.int  <RELROOT>/binnt/rtdll/wpp38601.int

#
# 386 OS/2 hosted compilers
#
  [ IFDEF (os_os2 "") <2*> ]
#  i86 target
    <CPCMD> i86/os2386/wcppi86.exe   <RELROOT>/binp/wpp.exe
    <CPCMD> i86/os2386/wcppi86.sym   <RELROOT>/binp/wpp.sym
    <CPCMD> i86/os2386/wppdi86.dll   <RELROOT>/binp/dll/wppdi86.dll
    <CPCMD> i86/os2386/wppdi86.sym   <RELROOT>/binp/dll/wppdi86.sym
    <CPCMD> i86/os2386/wppi8601.int  <RELROOT>/binp/dll/wppi8601.int
#  386 target
    <CPCMD> 386/os2386/wcpp386.exe   <RELROOT>/binp/wpp386.exe
    <CPCMD> 386/os2386/wcpp386.sym   <RELROOT>/binp/wpp386.sym
    <CPCMD> 386/os2386/wppd386.dll   <RELROOT>/binp/dll/wppd386.dll
    <CPCMD> 386/os2386/wppd386.sym   <RELROOT>/binp/dll/wppd386.sym
    <CPCMD> 386/os2386/wpp38601.int  <RELROOT>/binp/dll/wpp38601.int
#  386 target
    <CPCMD> axp/os2386/wcppaxp.exe   <RELROOT>/binp/wppaxp.exe
    <CPCMD> axp/os2386/wcppaxp.sym   <RELROOT>/binp/wppaxp.sym
    <CPCMD> axp/os2386/wppdaxp.dll   <RELROOT>/binp/dll/wppdaxp.dll
    <CPCMD> axp/os2386/wppdaxp.sym   <RELROOT>/binp/dll/wppdaxp.sym
    <CPCMD> axp/os2386/wppaxp01.int  <RELROOT>/binp/dll/wppaxp01.int
  [ ENDIF ]
#
# 386 OSI hosted compilers
#
#  i86 target
#    <CPCMD> i86/osi386/wcppi86.exe   <RELROOT>/binw/wpp.exe
#    <CPCMD> i86/osi386/wcppi86.sym   <RELROOT>/binw/wpp.sym
#    <CPCMD> i86/osi386/wppi8601.int  <RELROOT>/binw/wppi8601.int
#  386 target
#    <CPCMD> 386/osi386/wcpp386.exe   <RELROOT>/binw/wpp386.exe
#    <CPCMD> 386/osi386/wcpp386.sym   <RELROOT>/binw/wpp386.sym
#    <CPCMD> 386/osi386/wpp38601.int  <RELROOT>/binw/wpp38601.int

#
# 386 DOS hosted compilers
#
  [ IFDEF (os_dos "") <2*> ]
#  i86 target
    <CPCMD> i86/dos386/wcppi86.exe   <RELROOT>/binw/wpp.exe
    <CPCMD> i86/dos386/wcppi86.sym   <RELROOT>/binw/wpp.sym
    <CPCMD> i86/dos386/wppi8601.int  <RELROOT>/binw/wppi8601.int
#  386 target
    <CPCMD> 386/dos386/wcpp386.exe   <RELROOT>/binw/wpp386.exe
    <CPCMD> 386/dos386/wcpp386.sym   <RELROOT>/binw/wpp386.sym
    <CPCMD> 386/dos386/wpp38601.int  <RELROOT>/binw/wpp38601.int
#
# 386 QNX hompilsted coers
#
  [ IFDEF (os_qnx "") <2*> ]
#  i86 target
    <CCCMD> i86/qnx386/wcppi86.exe   <RELROOT>/qnx/binq/wpp.
    <CCCMD> i86/qnx386/wcppi86.sym   <RELROOT>/qnx/sym/wpp.sym
    <CCCMD> i86/qnx386/wppi8601.int  <RELROOT>/qnx/sym/wppi8601.int
#  386 target
    <CCCMD> 386/qnx386/wcpp386.exe   <RELROOT>/qnx/binq/wpp386.
    <CCCMD> 386/qnx386/wcpp386.sym   <RELROOT>/qnx/sym/wpp386.sym
    <CCCMD> 386/qnx386/wpp38601.int  <RELROOT>/qnx/sym/wpp38601.int

#
# 386 Linux hosted compilers
#
  [ IFDEF (os_linux "") <2*> ]
#  i86 target
    <CPCMD> i86/linux386/wcppi86.exe   <RELROOT>/binl/wpp
    <CPCMD> i86/linux386/wcppi86.sym   <RELROOT>/binl/wpp.sym
    <CPCMD> i86/linux386/wppi8601.int  <RELROOT>/binl/wppi8601.int
#  386 target
    <CPCMD> 386/linux386/wcpp386.exe   <RELROOT>/binl/wpp386
    <CPCMD> 386/linux386/wcpp386.sym   <RELROOT>/binl/wpp386.sym
    <CPCMD> 386/linux386/wpp38601.int  <RELROOT>/binl/wpp38601.int

#
# AXP NT hosted compilers
#
  [ IFDEF (cpu_axp) <2*> ]
#  AXP target
    <CPCMD> axp/ntaxp/wcppaxp.exe   <RELROOT>/axpnt/wppaxp.exe
    <CPCMD> axp/ntaxp/wcppaxp.sym   <RELROOT>/axpnt/wppaxp.sym
#  386 target
    <CPCMD> 386/ntaxp/wcpp386.exe   <RELROOT>/axpnt/wpp386.exe
    <CPCMD> 386/ntaxp/wcpp386.sym   <RELROOT>/axpnt/wpp386.sym

[ BLOCK <1> clean ]
#==================
    pmake -d build <2> <3> <4> <5> <6> <7> <8> <9> -h clean

[ BLOCK . . ]
#============

cdsay <PROJDIR>
