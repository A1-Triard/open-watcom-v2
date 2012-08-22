# WHC Prerequisite Tool Build Control File
# ========================================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

set TMP_BUILD_PLATFORM=<BUILD_PLATFORM>

[ BLOCK <OWLINUXBUILD> bootstrap ]
#=================================
    set BUILD_PLATFORM=<BUILD_PLATFORM>boot

[ BLOCK <1> clean ]
#==================
    echo rm -f -r <PROJDIR>/<OWPREOBJDIR>
    rm -f -r <PROJDIR>/<OWPREOBJDIR>
    rm -f <OWBINDIR>/whc
    rm -f <OWBINDIR>/whc.exe
    set BUILD_PLATFORM=

[ BLOCK <BUILD_PLATFORM> dos386 ]
#================================
    mkdir <PROJDIR>/<OWPREOBJDIR>
    cdsay <PROJDIR>/<OWPREOBJDIR>
    wmake -h -f ../dos386/makefile prebuild=1
    <CPCMD> whc.exe <OWBINDIR>/whc.exe

[ BLOCK <BUILD_PLATFORM> os2386 ]
#================================
    mkdir <PROJDIR>/<OWPREOBJDIR>
    cdsay <PROJDIR>/<OWPREOBJDIR>
    wmake -h -f ../os2386/makefile prebuild=1
    <CPCMD> whc.exe <OWBINDIR>/whc.exe

[ BLOCK <BUILD_PLATFORM> nt386 ]
#===============================
    mkdir <PROJDIR>/<OWPREOBJDIR>
    cdsay <PROJDIR>/<OWPREOBJDIR>
    wmake -h -f ../nt386/makefile prebuild=1
    <CPCMD> whc.exe <OWBINDIR>/whc.exe

[ BLOCK <BUILD_PLATFORM> linux386 ]
#===============================
    mkdir <PROJDIR>/<OWPREOBJDIR>
    cdsay <PROJDIR>/<OWPREOBJDIR>
    wmake -h -f ../linux386/makefile prebuild=1
    <CPCMD> whc.exe <OWBINDIR>/whc

[ BLOCK . . ]
#============
set BUILD_PLATFORM=<TMP_BUILD_PLATFORM>
set TMP_BUILD_PLATFORM=

cdsay <PROJDIR>
