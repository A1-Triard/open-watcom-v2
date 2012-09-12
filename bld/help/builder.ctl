# whelp Builder Control file
# ===========================

set PROJDIR=<CWD>
set PROJNAME=whelp

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/deftool.ctl ]

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/whelp.exe    <OWRELROOT>/binw/whelp.exe
    <CCCMD> os2386/whelp.exe    <OWRELROOT>/binp/whelp.exe
    <CCCMD> linux386/whelp.exe  <OWRELROOT>/binl/whelp

[ BLOCK . . ]
#============
cdsay <PROJDIR>
