#pmake: lcl os_nto cpu_386 trap x86
#
# Create the QNX Neutrino std.trp
#
host_os  = nto
host_cpu = 386

target_cpu = x86
target_os  = nto

srv   = lcl
which = TRAP

extra_objs = $(nto_trap_objs)

!include $(trap_dir)/lcl/nto/nto.mif
!include $(trap_dir)/lcl/lcl.mif
!include $(trap_dir)/master.mif
