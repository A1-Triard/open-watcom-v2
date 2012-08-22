# Builder control file for Linux. Using a separate file
# because of bootstrapping issues and the fact that only
# a small subset can be built
set PROJDIR=<CWD>

[ INCLUDE <OWROOT>/build/master.ctl ]

set OWLINUXBUILD=bootstrap
set WLINK_LNK=bootstrp.lnk

# compiled using GNU make + gcc + ar
[ INCLUDE <DEVDIR>/wmake/prereq.ctl ]
[ INCLUDE <DEVDIR>/builder/builder.ctl ]
[ INCLUDE <DEVDIR>/cpp/prereq.ctl ]
[ INCLUDE <DEVDIR>/nwlib/prereq.ctl ]

# compiled using wmake + gcc + ar/wlib
[ INCLUDE <DEVDIR>/yacc/prereq.ctl ]
[ INCLUDE <DEVDIR>/wres/prereq.ctl ]
[ INCLUDE <DEVDIR>/rc/rc/prereq.ctl ]
[ INCLUDE <DEVDIR>/wstrip/prereq.ctl ]
[ INCLUDE <DEVDIR>/orl/prereq.ctl ]
[ INCLUDE <DEVDIR>/cfloat/prereq.ctl ]
[ INCLUDE <DEVDIR>/owl/prereq.ctl ]
[ INCLUDE <DEVDIR>/dwarf/prereq.ctl ]
[ INCLUDE <DEVDIR>/wl/prereq.ctl ]
[ INCLUDE <DEVDIR>/wasm/prereq.ctl ]
[ INCLUDE <DEVDIR>/cg/prereq.ctl ]
[ INCLUDE <DEVDIR>/cc/prereq.ctl ]

# compiled using watcom utilities
[ INCLUDE <DEVDIR>/hdr/builder.ctl ]
[ INCLUDE <DEVDIR>/clib/builder.ctl ]
[ INCLUDE <DEVDIR>/mathlib/builder.ctl ]
[ INCLUDE <DEVDIR>/emu/builder.ctl ]
[ INCLUDE <DEVDIR>/wcl/prereq.ctl ]
[ INCLUDE <DEVDIR>/cfloat/builder.ctl ]
[ INCLUDE <DEVDIR>/owl/builder.ctl ]
[ INCLUDE <DEVDIR>/dwarf/builder.ctl ]
[ INCLUDE <DEVDIR>/re2c/prereq.ctl ]
[ INCLUDE <DEVDIR>/wres/builder.ctl ]
[ INCLUDE <DEVDIR>/as/builder.ctl ]
[ INCLUDE <DEVDIR>/cg/builder.ctl ]
[ INCLUDE <DEVDIR>/cc/builder.ctl ]
[ INCLUDE <DEVDIR>/plusplus/builder.ctl ]
[ INCLUDE <DEVDIR>/cpplib/builder.ctl ]
[ INCLUDE <DEVDIR>/wcl/builder.ctl ]

[ BLOCK <1> rel2 cprel2 ]
    <CPCMD> <DEVDIR>/wcl/386/linux386/wcl386.exe       <OWBINDIR>/wcl386
    <CPCMD> <DEVDIR>/wcl/i86/linux386/wcl.exe          <OWBINDIR>/wcl
    <CPCMD> <DEVDIR>/cc/386/linux386/wcc386c.exe       <OWBINDIR>/wcc386
    <CPCMD> <DEVDIR>/plusplus/386/linux386/wcpp386.exe <OWBINDIR>/wpp386
    <CPCMD> <DEVDIR>/plusplus/i86/linux386/wcppi86.exe <OWBINDIR>/wpp

[ BLOCK . . ]
set OWLINUXBUILD=normal
set WLINK_LNK=

# create full-featured wmake...

[ INCLUDE <DEVDIR>/wres/prereq.ctl ]
[ INCLUDE <DEVDIR>/rc/rc/prereq.ctl ]
[ INCLUDE <DEVDIR>/orl/builder.ctl ]
[ INCLUDE <DEVDIR>/wmake/prereq.ctl ]

# all is ready to do everything else now

[ BLOCK <1> clean ]
    rm -rf <DEVDIR>/builder/<OBJDIR>
    rm -rf <DEVDIR>/pmake/<OBJDIR>
    rm -rf <DEVDIR>/cpp/<OBJDIR>
    rm -rf <DEVDIR>/yacc/<OBJDIR>
    rm -rf <DEVDIR>/wres/<OBJDIR>
    rm -rf <DEVDIR>/rc/rc/<OBJDIR>
    rm -rf <DEVDIR>/wstrip/<OBJDIR>
    rm -rf <DEVDIR>/wmake/<OBJDIR>

    rm -rf <DEVDIR>/orl/<OBJDIR>
    rm -rf <DEVDIR>/nwlib/<OBJDIR>
    rm -rf <DEVDIR>/cfloat/<OBJDIR>
    rm -rf <DEVDIR>/owl/<OBJDIR>
    rm -rf <DEVDIR>/dwarf/dw/<OBJDIR>
    rm -rf <DEVDIR>/cg/intel/386/<OBJDIR>
    rm -rf <DEVDIR>/cc/<OBJDIR>
    rm -rf <DEVDIR>/wcl/<OBJDIR>
    rm -rf <DEVDIR>/wasm/<OBJDIR>
    rm -rf <DEVDIR>/wl/<OBJDIR>

    rm -f <OWBINDIR>/wcl386
    rm -f <OWBINDIR>/wcl
    rm -f <OWBINDIR>/wcc386
    rm -f <OWBINDIR>/wcc
    rm -f <OWBINDIR>/wpp386
    rm -f <OWBINDIR>/wpp
    rm -f <OWBINDIR>/wgml
    rm -f <OWBINDIR>/diff
    rm -f <OWBINDIR>/builder
