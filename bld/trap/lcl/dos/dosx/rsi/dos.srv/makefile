#pmake: build serv lcl os_dos dsx cpu_386 x86 rsi

host_os  = dos
host_cpu = i86

target_cpu = x86
target_os  = rsi

srv  = rsi
which = SERVER

!include $(rsilib_dir)/client.mif

extra_objs = rsiacc.obj
extra_incs = $(rsilib_inc_dirs)
extra_libs = $(rsilib_lib)

extra_cppflags = -DDOS4G
extra_c_flags = -zu

!include $(trap_dir)/lcl/dos/dosx/dosx.mif
!include $(trap_dir)/master.mif
