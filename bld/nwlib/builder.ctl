# wlib Builder Control file
# =========================

set PROJDIR=<CWD>
set PROJNAME=wlib

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel ]
    cdsay <PROJDIR>

[ BLOCK <BINTOOL> build ]
#========================
    cdsay <PROJDIR>
    <CPCMD> <OWOBJDIR>/bwlib.exe     <OWBINDIR>/bwlib<CMDEXT>
    <CCCMD> <OWOBJDIR>/bwlibd<DYEXT> <OWBINDIR>/bwlibd<DYEXT>

[ BLOCK <BINTOOL> clean ]
#========================
    echo rm -f <OWBINDIR>/bwlib<CMDEXT>
    rm -f <OWBINDIR>/bwlib<CMDEXT>
    rm -f <OWBINDIR>/bwlibd<DYEXT>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/wlib.exe      <OWRELROOT>/binw/
    <CCCMD> dos386/wlib.sym      <OWRELROOT>/binw/
    <CCCMD> os2386/wlib.exe      <OWRELROOT>/binp/
    <CCCMD> os2386/wlib.sym      <OWRELROOT>/binp/
    <CCCMD> os2386/wlibd.dll     <OWRELROOT>/binp/dll/
    <CCCMD> os2386/wlibd.sym     <OWRELROOT>/binp/dll/
    <CCCMD> nt386/wlib.exe       <OWRELROOT>/binnt/
    <CCCMD> nt386/wlib.sym       <OWRELROOT>/binnt/
    <CCCMD> nt386/wlibd.dll      <OWRELROOT>/binnt/
    <CCCMD> nt386/wlibd.sym      <OWRELROOT>/binnt/
    <CCCMD> ntaxp/wlib.exe       <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wlib.sym       <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wlibd.dll      <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wlibd.sym      <OWRELROOT>/axpnt/
    <CCCMD> qnx386/wlib.exe      <OWRELROOT>/qnx/binq/wlib
    <CCCMD> qnx386/wlib.sym      <OWRELROOT>/qnx/sym/
    <CCCMD> linux386/wlib.exe    <OWRELROOT>/binl/wlib
    <CCCMD> linux386/wlib.sym    <OWRELROOT>/binl/

    <CCCMD> ntx64/wlib.exe       <OWRELROOT>/binnt64/
    <CCCMD> ntx64/wlibd.dll      <OWRELROOT>/binnt64/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
