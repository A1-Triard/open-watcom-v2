#!/bin/sh
# *****************************************************************
# setvars - Linux version
# *****************************************************************
# NOTE: Do not use this script directly, but copy it and
#       modify it as necessary for your own use!!

# Change this to point your Open Watcom source tree
export OWROOT=/home/ow/ow

# Set this entry to use native compiler tools
export OWUSENATIVETOOLS=0

# Subdirectory to be used for building OW build tools
export OWOBJDIR=binbuild

# Set this variable to 1 to get default windowing support in clib
export OWDEFAULT_WINDOWING=0

# Change following entries to point your existing Open Watcom installation
if [ "$OWUSENATIVETOOLS" -ne "1" ]; then
    export WATCOM=/home/ow/ow19
    export INCLUDE=$WATCOM/lh
    export PATH=$WATCOM/binl:$PATH
    export OWUSENATIVETOOLS
fi

# Documentation related variables

# Set this variable to 0 to suppress documentation build
export OWDOCBUILD=0

# Change this to the PATH required by GhostScript for PDF creation on used host OS (optional)
# export OWGHOSTSCRIPTPATH=$PATH

# set appropriate variables to point to Windows help compilers which you have installed
# export OWWIN95HC=hcrtf
# export OWHHC=hhc

# build process requires WGML utility which is available only as DOS executable
# it is necessary to have some DOS emulator installed
# DOSBOX emulator is available on most platforms
# DOSEMU emulator is available on Linux (Intel platform)
# if DOSBOX emulator is used then OWDOSBOX variable must be set
# Uncoment and set OWDOSBOX variable bellow to point to DOSBOX emulator executable

# export OWDOSBOX=dosbox

# Invoke the script for the common environment
. $OWROOT/cmnvars.sh

cd $OWROOT
