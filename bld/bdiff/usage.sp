::
:: BPATCH
::
:segment BPATCH
:segment ENGLISH
:segment QNX
Usage: %C [-p] [-q] [-b] <file>
:elsesegment
Usage: bpatch {-p} {-q} {-b} <file>
:endsegment
Options:
    -p      Do not prompt for confirmation.
    -b      Do not create a .BAK file.
    -q      Print current patch level of file.
:elsesegment JAPANESE
:segment QNX
�g�p���@: %C [-p] [-q] [-b] <file>
:elsesegment
�g�p���@: bpatch {-p} {-q} {-b} <file>
:endsegment
    -p      �m�F�̉������֎~����
    -b      .BAK �t�@�C���̍쐬���֎~����
    -q      �t�@�C���̃J�����g�p�b�`���x�����o�͂���
:endsegment
::
:: BDUMP
::
:elsesegment BDUMP
:segment ENGLISH
:segment QNX
Usage: %C [-p] [-q] [-b] <file>
:elsesegment
Usage: bdump {-p} {-q} {-b} <file>
:endsegment
Options:
    -p      Do not prompt for confirmation.
    -b      Do not create a .BAK file.
    -q      Print current patch level of file.
:elsesegment JAPANESE
:segment QNX
�g�p���@: %C [-p] [-q] [-b] <file>
:elsesegment
�g�p���@: bdump {-p} {-q} {-b} <file>
:endsegment
    -p      �m�F�̉������֎~����
    -b      .BAK �t�@�C���̍쐬���֎~����
    -q      �t�@�C���̃J�����g�p�b�`���x�����o�͂���
:endsegment
::
:: BDIFF
::
:elsesegment BDIFF
Usage: bdiff <old_exe> <new_exe> <patch_file> [options]\n
Options:
    -p<file>    file to patch
    -c<file>    comment file
    -do<file>   old file's debug info
    -dn<file>   new file's debug info
    -l          don't write patch level into patch file
:endsegment
