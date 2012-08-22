# WOMP Builder Control file
# =========================

set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

cdsay .

[ BLOCK <1> build rel2 ]
#=======================
#    cdsay h
#    wmake -h -i
#   cdsay ../release
#   wmake -h -i

[ BLOCK <1> rel2 cprel2 acprel2 ]
#================================
#   <CPCMD> womp.exe  <OWRELROOT>/binw/womp.exe
#   <CPCMD> wompj.exe <OWRELROOT>/binw/japan/womp.exe

[ BLOCK <1> clean ]
#==================
#     rm -f h/wmpmsg.gh
#    sweep killobjs
