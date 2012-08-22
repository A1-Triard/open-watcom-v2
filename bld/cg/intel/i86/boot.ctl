# i86 cg Builder Control file
# ===========================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ BLOCK <1> clean ]
#==================
    echo rm -f -r <PROJDIR>/<OWOBJDIR>
    rm -f -r <PROJDIR>/<OWOBJDIR>

[ BLOCK <1> boot ]
#=================
    echo Building the Intel i86 cg bootstrap
    mkdir <PROJDIR>/<OWOBJDIR>
    cdsay <PROJDIR>/<OWOBJDIR>
    wmake -h -f ../bootmake
    cdsay <PROJDIR>
