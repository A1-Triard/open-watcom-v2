# wlink Builder Control file
# ==========================

set PROJDIR=<CWD>
set PROJNAME=wlink

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel ]
    cdsay <PROJDIR>

[ BLOCK <BINTOOL> build ]
#========================
    cdsay <PROJDIR>
    <CPCMD> <OWOBJDIR>/bwlink.exe     <OWBINDIR>/bwlink<CMDEXT>
    <CCCMD> <OWOBJDIR>/bwlinkd<DYEXT> <OWBINDIR>/bwlinkd<DYEXT>

[ BLOCK <BINTOOL> clean ]
#========================
    echo rm -f <OWBINDIR>/bwlink<CMDEXT>
    rm -f <OWBINDIR>/bwlink<CMDEXT>
    rm -f <OWBINDIR>/bwlinkd<DYEXT>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/wlink.exe                <OWRELROOT>/binw/
    <CCCMD> dos386/wlink.sym                <OWRELROOT>/binw/
    <CCCMD> ms2wlink/dosi86/ms2wlink.exe    <OWRELROOT>/binw/
    <CCCMD> fcenable/dosi86/fcenable.exe    <OWRELROOT>/binw/
    <CCCMD> exe2bin/dosi86/exe2bin.exe      <OWRELROOT>/binw/
    <CCCMD> wlink.lnk/binw/wlsystem.lnk     <OWRELROOT>/binw/
    <CCCMD> wlink.lnk/binw/wlink.lnk        <OWRELROOT>/binw/
    <CCCMD> ovlldr/dosi86/wovl.lib          <OWRELROOT>/lib286/dos/
#    <CCCMD> ovlldr/dosi86/wmovl.lib         <OWRELROOT>/lib286/dos/

    <CCCMD> os2386/wlink.exe                <OWRELROOT>/binp/
    <CCCMD> os2386/wlink.sym                <OWRELROOT>/binp/
    <CCCMD> os2386/wlinkd.dll               <OWRELROOT>/binp/dll/
    <CCCMD> os2386/wlinkd.sym               <OWRELROOT>/binp/dll/
    <CCCMD> ms2wlink/os2i86/ms2wlink.exe    <OWRELROOT>/binp/
    <CCCMD> fcenable/os2i86/fcenable.exe    <OWRELROOT>/binp/
    <CCCMD> exe2bin/os2386/exe2bin.exe      <OWRELROOT>/binp/
    <CCCMD> wlink.lnk/binp/wlink.lnk        <OWRELROOT>/binp/

    <CCCMD> nt386/wlink.exe                 <OWRELROOT>/binnt/
    <CCCMD> nt386/wlink.sym                 <OWRELROOT>/binnt/
    <CCCMD> nt386/wlinkd.dll                <OWRELROOT>/binnt/
    <CCCMD> nt386/wlinkd.sym                <OWRELROOT>/binnt/
    <CCCMD> ms2wlink/nt386/ms2wlink.exe     <OWRELROOT>/binnt/
    <CCCMD> fcenable/nt386/fcenable.exe     <OWRELROOT>/binnt/
    <CCCMD> exe2bin/nt386/exe2bin.exe       <OWRELROOT>/binnt/
    <CCCMD> wlink.lnk/binnt/wlink.lnk       <OWRELROOT>/binnt/

    <CCCMD> linux386/wlink.exe              <OWRELROOT>/binl/wlink
    <CCCMD> linux386/wlink.sym              <OWRELROOT>/binl/
    <CCCMD> ms2wlink/linux386/ms2wlink.exe  <OWRELROOT>/binl/ms2wlink
    <CCCMD> fcenable/linux386/fcenable.exe  <OWRELROOT>/binl/fcenable
    <CCCMD> exe2bin/linux386/exe2bin.exe    <OWRELROOT>/binl/exe2bin
    <CCCMD> wlink.lnk/binl/wlink.lnk        <OWRELROOT>/binl/

    <CCCMD> ntaxp/wlink.exe                 <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wlink.sym                 <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wlinkd.dll                <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wlinkd.sym                <OWRELROOT>/axpnt/
    <CCCMD> exe2bin/ntaxp/exe2bin.exe       <OWRELROOT>/axpnt/
    <CCCMD> wlaxpnt.lnk                     <OWRELROOT>/axpnt/wlink.lnk
    <CCCMD> wlink.lnk/axpnt/wlink.lnk       <OWRELROOT>/axpnt/

    <CCCMD> qnx386/wlink.exe                <OWRELROOT>/qnx/binq/wlink
    <CCCMD> qnx386/wlink.sym                <OWRELROOT>/qnx/sym/
    <CCCMD> wlink.lnk/binq/wlink.lnk        <OWRELROOT>/qnx/etc/

    <CCCMD> ntx64/wlink.exe                 <OWRELROOT>/binnt64/
    <CCCMD> ntx64/wlinkd.dll                <OWRELROOT>/binnt64/
    <CCCMD> ms2wlink/ntx64/ms2wlink.exe     <OWRELROOT>/binnt64/
    <CCCMD> fcenable/ntx64/fcenable.exe     <OWRELROOT>/binnt64/
    <CCCMD> exe2bin/ntx64/exe2bin.exe       <OWRELROOT>/binnt64/
    <CCCMD> wlink.lnk/binnt64/wlink.lnk     <OWRELROOT>/binnt64/

    <CCCMD> linuxx64/wlink.exe              <OWRELROOT>/binl64/wlink
    <CCCMD> wlink.lnk/binl64/wlink.lnk      <OWRELROOT>/binl64/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
