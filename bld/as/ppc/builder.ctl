# wasppc Builder Control file
# ===========================

set PROJDIR=<CWD>
set PROJNAME=wasppc

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK ( <1> <BINTOOL> ) rel ]
    cdsay <PROJDIR>

[ BLOCK <BINTOOL> rel ]
#======================
    <CPCMD> <OWOBJDIR>/bwasppc.exe <OWBINDIR>/bwasppc<CMDEXT>

[ BLOCK <BINTOOL> clean ]
#========================
    echo rm -f <OWBINDIR>/bwasppc<CMDEXT>
    rm -f <OWBINDIR>/bwasppc<CMDEXT>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/wasppc.exe     <OWRELROOT>/binw/wasppc.exe
    <CCCMD> dos386/wasppc.sym     <OWRELROOT>/binw/wasppc.sym
    <CCCMD> os2386/wasppc.exe     <OWRELROOT>/binp/wasppc.exe
    <CCCMD> os2386/wasppc.sym     <OWRELROOT>/binp/wasppc.sym
    <CCCMD> nt386/wasppc.exe      <OWRELROOT>/binnt/wasppc.exe
    <CCCMD> nt386/wasppc.sym      <OWRELROOT>/binnt/wasppc.sym
    <CCCMD> linux386/wasppc.exe   <OWRELROOT>/binl/wasppc
    <CCCMD> linux386/wasppc.sym   <OWRELROOT>/binl/wasppc.sym
    <CCCMD> ntaxp/wasppc.exe      <OWRELROOT>/axpnt/wasppc.exe
    <CCCMD> ntaxp/wasppc.sym      <OWRELROOT>/axpnt/wasppc.sym

[ BLOCK . . ]
#============
cdsay <PROJDIR>
