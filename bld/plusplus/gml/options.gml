:cmt
:cmt GML Macros used:
:cmt
:cmt    :chain. <char> <usage>                  options that start with <char>
:cmt                                            can be chained together i.e.,
:cmt                                            -oa -ox -ot => -oaxt
:cmt    :option. <option> <synonym> ...         define an option
:cmt    :target. <arch1> <arch2> ...            valid for these architectures
:cmt    :ntarget. <arch1> <arch2> ...           not valid for these architectures
:cmt    :immediate. <fn>                        <fn> is called when option parsed
:cmt    :code. <source-code>                    <source-code> is executed when option parsed
:cmt    :enumerate. <field> [<value>]           option is one value in <name> enumeration
:cmt    :number. [<fn>] [<default>]             =<n> allowed; call <fn> to check
:cmt    :id. [<fn>]                             =<id> req'd; call <fn> to check
:cmt    :char.[<fn>]                            =<char> req'd; call <fn> to check
:cmt    :file.                                  =<file> req'd
:cmt    :path.                                  =<path> req'd
:cmt    :special. <fn> [<arg_usage_text>]       call <fn> to parse option
:cmt    :optional.                              value is optional
:cmt    :noequal.                               args can't have option '='
:cmt    :argequal. <char>                       args use <char> instead of '='
:cmt    :internal.                              option is undocumented
:cmt    :prefix.                                prefix of a :special. option
:cmt    :usage. <text>                          English usage text
:cmt    :jusage. <text>                         Japanese usage text
:cmt    :title.                                 English title usage text
:cmt    :jtitle.                                Japanese title usage text
:cmt    :page.                                  text for paging usage message
:cmt    :nochain.                               option isn't chained with other options
:cmt    :timestamp.                             kludge to record "when" an option
:cmt                                            is set so that dependencies
:cmt                                            between options can be simulated

:cmt    where:
:cmt        <arch>:     i86, 386, axp, any, dbg, qnx, ppc, linux, sparc, haiku

:cmt    Translations are required for the :jtitle. and :jusage. tags
:cmt    if there is no text associated with the tag.

:title. Usage: wpp [options] file [options]
:jtitle. 使用方法: wpp [options] file [options]
:target. i86
:title. Usage: wpp386 [options] file [options]
:jtitle. 使用方法: wpp386 [options] file [options]
:target. 386
:title. Usage: wppaxp [options] file [options]
:jtitle. 使用方法: wppaxp [options] file [options]
:target. axp
:title. Usage: wppppc [options] file [options]
:jtitle. 使用方法: wppppc [options] file [options]
:target. ppc
:title. Options:
:jtitle. ?I?v?V?�?�:
:target. any
:title. \t    ( /option is also accepted )
:jtitle. \t    ( /optionも使用できます )
:target. i86 386 axp ppc
:ntarget. qnx linux bsd haiku
:title. \t    ( '=' is always optional, i.e., -w4 -zp4 )
:jtitle. \t    ( '='は常に省略可能です?Bつまり -w4 -zp4 )
:target. any

:page. (Press return to continue)
:jusage. (続行するために何か?L?[を押して下さい)

:chain. p preprocess source file
:jusage. p ?\?[?X?t?@?C?汲�前�?理します
:chain. o optimization
:jusage. o 最適化

:option. 0
:target. i86
:enumerate. arch_i86
:usage. 8086 instructions
:jusage. 8086 命令

:option. 1
:target. i86
:enumerate. arch_i86
:usage. 186 instructions
:jusage. 186 命令

:option. 2
:target. i86
:enumerate. arch_i86
:usage. 286 instructions
:jusage. 286 命令

:option. 3
:target. i86
:enumerate. arch_i86
:usage. 386 instructions
:jusage. 386 命令

:option. 4
:target. i86
:enumerate. arch_i86
:usage. 386 instructions, optimize for 486
:jusage. 386 命令, 486用最適化

:option. 5
:target. i86
:enumerate. arch_i86
:usage. 386 instructions, optimize for Pentium
:jusage. 386 命令, Pentium用最適化

:option. 6
:target. i86
:enumerate. arch_i86
:usage. 386 instructions, optimize for Pentium Pro
:jusage. 386 命令, Pentium Pro用最適化

:option. 3r 3
:target. 386
:enumerate. arch_386
:usage. 386 register calling conventions
:jusage. 386 ?�?W?X?^呼び出し規約

:option. 3s
:target. 386
:enumerate. arch_386
:usage. 386 stack calling conventions
:jusage. 386 ?X?^?b?N呼び出し規約

:option. 4r 4
:target. 386
:enumerate. arch_386
:usage. 486 register calling conventions
:jusage. 486 ?�?W?X?^呼び出し規約

:option. 4s
:target. 386
:enumerate. arch_386
:usage. 486 stack calling conventions
:jusage. 486 ?X?^?b?N呼び出し規約

:option. 5r 5
:target. 386
:enumerate. arch_386
:usage. Pentium register calling conventions
:jusage. Pentium ?�?W?X?^呼び出し規約

:option. 5s
:target. 386
:enumerate. arch_386
:usage. Pentium stack calling conventions
:jusage. Pentium ?X?^?b?N呼び出し規約

:option. 6r 6
:target. 386
:enumerate. arch_386
:usage. Pentium Pro register calling conventions
:jusage. Pentium Pro ?�?W?X?^呼び出し規約

:option. 6s
:target. 386
:enumerate. arch_386
:usage. Pentium Pro stack calling conventions
:jusage. Pentium Pro ?X?^?b?N呼び出し規約

:option. as
:target. axp
:usage. assume short integers are aligned
:jusage. short ?ｮ?狽ｪ?ｮ列していると仮定します

:option. bc
:target. any
:usage. build target is a console application
:jusage. 構築?^?[?Q?b?gは?R?�?\?[?凶?A?v?�?P?[?V?�?唐ﾅす

:option. bd
:target. any
:usage. build target is a dynamic link library (DLL)
:jusage. 構築?^?[?Q?b?gは?_?C?i?~?b?N･?�?�?N･?�?C?u?�?鰍ﾅす(DLL)

:option. bg
:target. any
:usage. build target is a GUI application
:jusage. 構築?^?[?Q?b?gはGUI?A?v?�?P?[?V?�?唐ﾅす

:option. bm
:target. any
:usage. build target is a multi-thread environment
:jusage. 構築?^?[?Q?b?gは?}?�?`?X?�?b?h環境です

:option. br
:target. 386 axp ppc
:usage. build target uses DLL version of C/C++ run-time library
:jusage. 構築?^?[?Q?b?gはDLL版のC/C++実行時?�?C?u?�?鰍�使用します

:option. bw
:target. any
:usage. build target is a default windowing application
:jusage. 構築?^?[?Q?b?gは?f?t?H?�?g･?E?B?�?h?E･?A?v?�?P?[?V?�?唐ﾅす

:option. bt
:target. any
:id.
:optional.
:usage. build target is operating system <id>
:jusage. 構築?^?[?Q?b?gは?I?y?�?[?e?B?�?O･?V?X?e?� <id>

:option. d0
:target. any
:enumerate. debug_info
:timestamp.
:usage. no debugging information
:jusage. ?f?o?b?O情報はありません

:option. d1
:target. any
:enumerate. debug_info
:timestamp.
:usage. line number debugging information
:jusage. 行番号?f?o?b?O情報

:option. d2
:target. any
:enumerate. debug_info
:timestamp.
:usage. symbolic debugging information
:jusage. 完全?V?�?{?�?f?o?b?O情報

:option. d2i
:target. any
:enumerate. debug_info
:timestamp.
:usage. -d2 and debug inlines; emit inlines as COMDATs
:jusage. ?C?�?�?C?投ﾖ?狽ﾌ展開なしの-d2;?C?�?�?C?投ﾖ?狽ﾍCOMDATとして出力

:option. d2s
:target. any
:enumerate. debug_info
:timestamp.
:usage. -d2 and debug inlines; emit inlines as statics
:jusage. ?C?�?�?C?投ﾖ?狽ﾌ展開なしの-d2;?C?�?�?C?投ﾖ?狽ﾍstaticとして出力

:option. d2t d2~
:target. any
:enumerate. debug_info
:timestamp.
:usage. -d2 but without type names
:jusage. 型名なしの完全?V?�?{?�?f?o?b?O情報

:option. d3
:target. any
:enumerate. debug_info
:timestamp.
:usage. symbolic debugging information with unreferenced type names
:jusage. 参照されていない型名を含む完全?V?�?{?�?f?o?b?O情報

:option. d3i
:target. any
:enumerate. debug_info
:timestamp.
:usage. -d3 and debug inlines; emit inlines as COMDATs
:jusage. ?C?�?�?C?投ﾖ?狽ﾌ展開なしの-d3;?C?�?�?C?投ﾖ?狽ﾍCOMDATとして出力

:option. d3s
:target. any
:enumerate. debug_info
:timestamp.
:usage. -d3 and debug inlines; emit inlines as statics
:jusage. ?C?�?�?C?投ﾖ?狽ﾌ展開なしの-d3;?C?�?�?C?投ﾖ?狽ﾍstaticとして出力

:option. d+
:target. any
:special. scanDefinePlus
:usage. allow extended -d macro definitions
:jusage. 拡張された -d ?}?N?穀闍`を許可します

:option. db
:target. any
:prefix.
:usage. generate browsing information
:jusage. ?u?�?E?Y情報を?ｶ?ｬします

:option. d
:target. any
:special. scanDefine <name>[=text]
:usage. same as #define name [text] before compilation
:jusage. ?R?�?p?C?拒Oの #define name [text] と同じ

:option. ecc
:target. i86 386
:enumerate. intel_call_conv
:usage. set default calling convention to __cdecl
:jusage.

:option. ecd
:target. i86 386
:enumerate. intel_call_conv
:usage. set default calling convention to __stdcall
:jusage.

:option. ecf
:target. i86 386
:enumerate. intel_call_conv
:usage. set default calling convention to __fastcall
:jusage.

:option. eco
:target. i86 386
:enumerate. intel_call_conv
:internal.
:usage. set default calling convention to _Optlink
:jusage.

:option. ecp
:target. i86 386
:enumerate. intel_call_conv
:usage. set default calling convention to __pascal
:jusage.

:option. ecr
:target. i86 386
:enumerate. intel_call_conv
:usage. set default calling convention to __fortran
:jusage.

:option. ecs
:target. i86 386
:enumerate. intel_call_conv
:usage. set default calling convention to __syscall
:jusage.

:option. ecw
:target. i86 386
:enumerate. intel_call_conv
:usage. set default calling convention to __watcall (default)
:jusage.

:option. ee
:target. any
:usage. call epilogue hook routine
:jusage. ?G?s?�?[?O･?t?b?N?�?[?`?唐�呼び出します

:option. ef
:target. any
:usage. use full path names in error messages
:jusage. ?G?�?[???b?Z?[?Wに完全?p?X名を使用します

:option. ei
:target. any
:enumerate. enum_size
:usage. force enum base type to use at least an int
:jusage. enum型の?x?[?X型としてint型?ﾈ上の大きさを使用します

:option. em
:target. any
:enumerate. enum_size
:usage. force enum base type to use minimum integral type
:jusage. enum型の?x?[?X型として最小の?ｮ?伯^を使用します

:option. en
:target. any
:usage. emit routine names in the code segment
:jusage. ?�?[?`?当ｼを?R?[?h?Z?O???�?gに出力します

:option. ep
:target. any
:number. checkPrologSize 0
:usage. call prologue hook routine with <num> stack bytes available
:jusage. <num>?o?C?gの?X?^?b?Nを使用する?v?�?�?[?O･?t?b?N･?�?[?`?唐�呼び出します

:option. eq
:target. any
:immediate. handleOptionEQ
:usage. do not display error messages (but still write to .err file)
:jusage. ?G?�?[???b?Z?[?Wを表示しません(しかし.err?t?@?C?汲ﾉは書き込みます)

:option. er
:target. any
:usage. do not recover from undefined symbol errors
:jusage. 未定義?V?�?{?�?G?�?[から回復しません

:option. et
:target. 386
:usage. emit Pentium profiling code
:jusage. Pentium?v?�?t?@?C?�?�?O･?R?[?hを?ｶ?ｬします

:option. et0
:target. 386
:usage. emit Pentium-CTR0 profiling code
:jusage. Pentium-CTR0?v?�?t?@?C?�?�?O･?R?[?hを?ｶ?ｬします

:option. etp
:target. 386
:internal.
:usage. emit Timing for Profiler
:jusage. ?v?�?t?@?C?奄ﾌ?^?C?~?�?Oを出力します

:option. esp
:target. 386
:internal.
:usage. emit Statement counting for Profiler
:jusage. ?v?�?t?@?C?於p?X?e?[?g???�?g･?J?E?�?e?B?�?Oを出力します

:option. ew
:target. any
:immediate. handleOptionEW
:usage. alternate error message formatting
:jusage. 別の?G?�?[???b?Z?[?W形式を使用します

:option. ez
:target. 386
:usage. generate PharLap EZ-OMF object files
:jusage. PharLap EZ-OMF?I?u?W?F?N?g･?t?@?C?汲�?ｶ?ｬします

:option. e
:target. any
:number. checkErrorLimit
:usage. set limit on number of error messages
:jusage. ?G?�?[???b?Z?[?W?狽ﾌ?ｧ限を?ﾝ定します

:option. fbi
:target. any
:special. scanFBI
:internal.
:usage. generate browsing information
:jusage. ?u?�?E?Y情報を?ｶ?ｬします

:option. fbx
:target. any
:special. scanFBX
:internal.
:usage. do not generate browsing information
:jusage. ?u?�?E?Y情報を?ｶ?ｬしません

:option. fc
:target. any
:file.
:immediate. handleOptionFC
:usage. specify file of command lines to be batch processed
:jusage. ?o?b?`�?理する?R?}?�?h?�?C?唐ﾌ?t?@?C?汲�指定します

:option. fh
:target. any
:file.
:optional.
:timestamp.
:usage. use pre-compiled header (PCH) file
:jusage. ?v?�?R?�?p?C?凶?w?b?_?[(PCH)を使用します

:option. fhd
:target. any
:usage. store debug info for PCH once (DWARF only)
:jusage. PCH用?f?o?b?O情報を1度格納します(DWARFのみ)

:option. fhq
:target. any
:file.
:optional.
:timestamp.
:usage. do not display PCH activity warnings
:jusage. PCH使用???b?Z?[?Wを表示しません

:option. fhw
:target. any
:usage. force compiler to write PCH (will never read)
:jusage. PCHを書き込みに強?ｧします (読みません)

:option. fhwe
:target. any
:usage. don't count PCH activity warnings (see -we option)
:jusage. PCH使用???b?Z?[?Wを?G?�?[として?ｵいません(-we?I?v?V?�?梼Q照)

:option. fhr
:target. any
:usage. force compiler to read PCH (will never write)
:jusage. PCHを読み込みに強?ｧします (書きません)

:option. fhr!
:target. any
:usage. compiler will read PCH without checking include files
:jusage. ?R?�?p?C?奄ﾍ?C?�?N?�?[?h?t?@?C?汲�?`?F?b?Nすることなく?APCH読み込みます
:internal.

:option. fi
:target. any
:file.
:usage. force <file> to be included
:jusage. 強?ｧ的に<file>を?C?�?N?�?[?hします

:option. fip
:target. any
:file.
:optional.
:usage. automatic inclusion of <file> instead of _preincl.h (default)
:jusage.

:option. fo
:target. any
:file.
:optional.
:usage. set object or preprocessor output file name
:jusage. ?I?u?W?F?N?gまたは?v?�?v?�?Z?b?Tの出力?t?@?C?許ｼを?ﾝ定します

:option. fr
:target. any
:file.
:optional.
:usage. set error file name
:jusage. ?G?�?[･?t?@?C?許ｼを?ﾝ定します

:option. ft
:target. any
:enumerate. file_83
:usage. check for truncated versions of file names
:jusage. ?ﾘり詰めた?t?@?C?許ｼを?`?F?b?Nします

:option. fx
:target. any
:enumerate. file_83
:usage. do not check for truncated versions of file names
:jusage. ?ﾘり詰めた?t?@?C?許ｼを?`?F?b?Nしません

:option. fzh
:target. any
:usage. do not automatically postfix include file names
:jusage. do not automatically postfix include file names

:option. fzs
:target. any
:usage. do not automatically postfix source file names
:jusage. do not automatically postfix source file names

:option. 87d
:target. i86 386
:number. CmdX86CheckStack87 0
:enumerate. intel_fpu_model
:internal.
:usage. inline 80x87 instructions with specified depth
:jusage. 指定した?[さの?C?�?�?C?�80x87命令

:option. fpc
:target. i86 386
:enumerate. intel_fpu_model
:usage. calls to floating-point library
:jusage. 浮動小?箔_?�?C?u?�?鰍�呼び出します

:option. fpi
:target. i86 386
:enumerate. intel_fpu_model
:usage. inline 80x87 instructions with emulation
:jusage. ?G?~?�?�?[?V?�?燈tき?C?�?�?C?�80x87命令

:option. fpi87
:target. i86 386
:enumerate. intel_fpu_model
:usage. inline 80x87 instructions
:jusage. ?C?�?�?C?�80x87命令

:option. fp2 fp287
:target. i86 386
:enumerate. intel_fpu_level
:usage. generate 287 floating-point code
:jusage. 287浮動小?箔_?R?[?hを?ｶ?ｬします

:option. fp3 fp387
:target. i86 386
:enumerate. intel_fpu_level
:usage. generate 387 floating-point code
:jusage. 387浮動小?箔_?R?[?hを?ｶ?ｬします

:option. fp5
:target. i86 386
:enumerate. intel_fpu_level
:usage. optimize floating-point for Pentium
:jusage. Pentium用浮動小?箔_最適化をします

:option. fp6
:target. i86 386
:enumerate. intel_fpu_level
:usage. optimize floating-point for Pentium Pro
:jusage. Pentium Pro用浮動小?箔_最適化をします

:option. fpr
:target. i86 386
:usage. generate backward compatible 80x87 code
:jusage. ?o?[?W?�?�9.0?ﾈ前と互換の80x87?R?[?hを?ｶ?ｬします

:option. fpd
:target. i86 386
:usage. enable Pentium FDIV check
:jusage. Pentium FDIV?`?F?b?Nをします

:option. g
:target. i86 386
:id.
:usage. set code group name
:jusage. ?R?[?h･?O?�?[?v名を?ﾝ定します

:option. hw
:target. i86 386 
:enumerate. dbg_output
:usage. generate Watcom debugging information
:jusage. Watcom?f?o?b?O情報を?ｶ?ｬします

:option. hd
:target. i86 386 axp ppc
:enumerate. dbg_output
:usage. generate DWARF debugging information
:jusage. DWARF?f?o?b?O情報を?ｶ?ｬします

:option. hda
:target. i86 386 axp ppc
:enumerate. dbg_output
:usage. generate DWARF debugging information
:jusage. DWARF?f?o?b?O情報を?ｶ?ｬします
:internal.

:option. hc
:target. i86 386 axp ppc
:enumerate. dbg_output
:usage. generate Codeview debugging information
:jusage. Codeview?f?o?b?O情報を?ｶ?ｬします

:option. i
:target. any
:path.
:usage. add another include path
:jusage. ?C?�?N?�?[?h･?p?Xを追加します

:option. j
:target. any
:usage. change char default from unsigned to signed
:jusage. char型の?f?t?H?�?gをunsignedからsignedに変更します

:option. jw
:target. any
:usage. warn about default char promotion to int
:jusage.
:internal.

:option. k
:target. any
:usage. continue processing files (ignore errors)
:jusage. ?t?@?C?居?理を続行します(?G?�?[を無視します)

:option. la
:target. axp
:usage. output Alpha assembly listing
:jusage. Alpha?A?Z?�?u?冠?�?X?gを出力します
:internal.

:option. lo
:target. axp
:usage. output OWL listing
:jusage. OWL?�?X?gを出力します
:internal.

:option. mc
:target. i86 386
:enumerate. mem_model
:usage. compact memory model (small code/large data)
:jusage. ?R?�?p?N?g･???�?冠?�?f?�(?X?�?[?凶?R?[?h/?�?[?W･?f?[?^)

:option. mf
:target. 386
:enumerate. mem_model
:usage. flat memory model (small code/small data assuming CS=DS=SS=ES)
:jusage. ?t?�?b?g･???�?冠?�?f?�(?X?�?[?凶?R?[?h/CS=DS=SS=ESを仮定した?X?�?[?凶?f?[?^)

:option. mfi
:target. 386
:enumerate. mem_model
:usage. flat memory model (interrupt functions will assume flat model)
:jusage. ?t?�;?g･???�?冠?�??�(割り込み関?狽�?t?�;?g?�??汲ﾅあると仮定する)

:option. mh
:target. i86
:enumerate. mem_model
:usage. huge memory model (large code/huge data)
:jusage. ?q?�?[?W･???�?冠?�?f?�(?�?[?W･?R?[?h/?q?�?[?W･?f?[?^)

:option. ml
:target. i86 386
:enumerate. mem_model
:usage. large memory model (large code/large data)
:jusage. ?�?[?W･???�?冠?�?f?�(?�?[?W･?R?[?h/?�?[?W･?f?[?^)

:option. mm
:target. i86 386
:enumerate. mem_model
:usage. medium memory model (large code/small data)
:jusage. ?~?f?B?A?�･???�?冠?�?f?�(?�?[?W･?R?[?h/?X?�?[?凶?f?[?^)

:option. ms
:target. i86 386
:enumerate. mem_model
:usage. small memory model (small code/small data)
:jusage. ?X?�?[?凶???�?冠?�?f?�(?X?�?[?凶?R?[?h/?X?�?[?凶?f?[?^)

:option. nc
:target. i86 386
:id.
:usage. set code class name
:jusage. ?R?[?h･?N?�?X名を?ﾝ定します

:option. nd
:target. i86 386
:id.
:usage. set data segment name
:jusage. ?f?[?^･?Z?O???�?g名を?ﾝ定します

:option. nm
:target. i86 386 axp ppc
:file.
:usage. set module name
:jusage. ?�?W?�?[?許ｼを?ﾝ定します

:option. nt
:target. i86 386
:id.
:usage. set name of text segment
:jusage. ?e?L?X?g･?Z?O???�?g名を?ﾝ定します

:option. oa
:target. any
:usage. relax aliasing constraints
:jusage. ?G?C?�?A?Xの?ｧ約を緩?aします

:option. ob
:target. any
:usage. enable branch prediction
:jusage. 分岐予測にそった?R?[?hを?ｶ?ｬします

:option. oc
:target. i86 386 axp ppc
:usage. disable <call followed by return> to <jump> optimization
:jusage. <call followed by return>から<jump>の最適化を無効にします

:option. od
:target. any
:enumerate. opt_level
:timestamp.
:usage. disable all optimizations
:jusage. すべての最適化を無効にします

:option. oe
:target. any
:number. checkOENumber 100
:usage. expand user functions inline (<num> controls max size)
:jusage. ?�?[?U関?狽�?C?�?�?C?涛W開します(<num>は最大ｻｲｽﾞを?ｧ御します)

:option. of
:target. i86 386
:usage. generate traceable stack frames as needed
:jusage. 必要に応じて?g?�?[?X可能な?X?^?b?N･?t?�?[?�を?ｶ?ｬします

:option. of+
:target. i86 386
:usage. always generate traceable stack frames
:jusage. 常に?g?�?[?X可能な?X?^?b?N･?t?�?[?�を?ｶ?ｬします

:option. oh
:target. any
:usage. enable expensive optimizations (longer compiles)
:jusage. 最適化を繰り返します(?R?�?p?C?汲ｪ長くなります)

:option. oi
:target. any
:usage. expand intrinsic functions inline
:jusage. 組込み関?狽�?C?�?�?C?涛W開します

:option. oi+
:target. any
:usage. enable maximum inlining depth
:jusage. ?C?�?�?C?涛W開の?[さを最大にします

:option. ok
:target. any
:usage. include prologue/epilogue in flow graph
:jusage. ?v?�?�?[?Oと?G?s?�?[?Oを?t?�?[?ｧ御可能にします

:option. ol
:target. any
:usage. enable loop optimizations
:jusage. ?�?[?v最適化を可能にします

:option. ol+
:target. any
:usage. enable loop unrolling optimizations
:jusage. ?�?[?v?E?A?�?�?[?�?�?Oで?�?[?v最適化を可能にします

:option. om
:target. i86 386 axp ppc
:usage. generate inline code for math functions
:jusage. 算術関?狽�?C?�?�?C?唐ﾌ80x87?R?[?hで展開して?ｶ?ｬします

:option. on
:target. any
:usage. allow numerically unstable optimizations
:jusage. ?白l的にやや不?ｳ確になるがより高速な最適化を可能にします

:option. oo
:target. any
:usage. continue compilation if low on memory
:jusage. ???�?鰍ｪ足りなくなっても?R?�?p?C?汲�継続します

:option. op
:target. any
:usage. generate consistent floating-point results
:jusage. ?鼕ﾑした浮動小?箔_計算の結果を?ｶ?ｬします

:option. or
:target. any
:usage. reorder instructions for best pipeline usage
:jusage. 最適な?p?C?v?�?C?唐�使用するために命令を並べ替えます

:option. os
:target. any
:enumerate. opt_size_time
:timestamp.
:usage. favor code size over execution time in optimizations
:jusage. 実行時間より?R?[?h?T?C?Yの最適化を優?謔ｵます

:option. ot
:target. any
:enumerate. opt_size_time
:timestamp.
:usage. favor execution time over code size in optimizations
:jusage. ?R?[?h?T?C?Yより実行時間の最適化を優?謔ｵます

:option. ou
:target. any
:usage. all functions must have unique addresses
:jusage. すべての関?狽ﾍそれぞれ固有の?A?h?�?Xを必ず持ちます

:option. ox
:target. any
:enumerate. opt_level
:timestamp.
:usage. equivalent to -obmiler -s
:jusage. -obmiler -sと同等

:option. oz
:target. any
:usage. NULL points to valid memory in the target environment
:jusage. NULLは?A?^?[?Q?b?g環境内の有効な???�?鰍�指します

:option. ad
:target. any
:file.
:optional.
:usage. generate make style automatic dependency file
:jusage. generate make style automatic dependency file

:option. adbs
:target. any
:usage. force path separators to '\\' in auto-depend file
:jusage. force path separators to '\\' in auto-depend file

:option. adfs
:target. any
:usage. force path separators to '/' in auto-depend file
:jusage. force path separators to '/' in auto-depend file

:option. add
:target. any
:file.
:optional.
:usage. specify first dependency in make style auto-depend file
:jusage. specify first dependency in make style auto-depend file

:option. adhp
:target. any
:file.
:optional.
:usage. specify default path for headers without one
:jusage. specify default path for headers without one

:option. adt
:target. any
:file.
:optional.
:usage. specify target in make style auto-depend file
:jusage. specify target in make style auto-depend file

:option. pil
:target. any
:nochain.
:usage. preprocessor ignores #line directives
:jusage. preprocessor ignores #line directives

:option. p
:target. any
:usage.
:jusage.

:option. pe
:target. any
:usage. encrypt identifiers
:jusage. 識別子を?ﾃ号化します

:option. pl
:target. any
:usage. insert #line directives
:jusage. #line擬似命令を挿入します

:option. pj
:target. any
:internal.
:usage. insert // #line comments
:jusage. // #line擬似命令を挿入します

:option. pc
:target. any
:usage. preserve comments
:jusage. ?R???�?gを残します

:option. pw
:target. any
:number. checkPPWidth
:usage. wrap output lines at <num> columns. Zero means no wrap.
:jusage. 出力行を<num>桁で?ﾜり返します. 0は?ﾜり返しません.

:option. p#
:target. any
:char.
:internal.
:usage. set preprocessor delimiter to something other than '#'
:jusage. ?v?�?v?�?Z?b?Tの区?ﾘり記号を'#'?ﾈ外の何かに?ﾝ定します

:option. q
:target. any
:usage. operate quietly (display only error messages)
:jusage. 無???b?Z?[?W?�?[?hで動作します(?G?�?[???b?Z?[?Wのみ表示されます)

:option. r
:target. i86 386
:usage. save/restore segment registers across calls
:jusage. 関?伯ﾄび出しの前後で?Z?O???�?g?�?W?X?^を退避/?�?X?g?Aします

:option. re
:target. 386
:internal.
:usage. special Neutrino R/W data access code generation
:jusage.

:option. ri
:target. i86 386
:usage. return chars and shorts as ints
:jusage. 全ての関?狽ﾌ?�?狽ﾆ戻り値をint型に変換します

:option. rod
:target. any
:path.
:internal.
:usage. specified <path> contains read-only files
:jusage. 指定された<path>には読み込み?齬p?t?@?C?汲ｪ含まれています

:option. s
:target. any
:usage. remove stack overflow checks
:jusage. ?X?^?b?N?I?[?o?t?�?[?E?`?F?b?Nを削除します

:option. sg
:target. i86 386
:usage. generate calls to grow the stack
:jusage. ?X?^?b?Nを増加する呼び出しを?ｶ?ｬします

:option. si
:target. axp
:usage. generate calls to initialize local storage
:jusage. ?�?[?J?凶???�?鰍�初期化する呼び出しを?ｶ?ｬします

:option. st
:target. i86 386
:usage. touch stack through SS first
:jusage. まず最初にSSを通して?X?^?b?N?E?^?b?`します

:option. t
:target. any
:number. checkTabWidth
:usage. set number of spaces in a tab stop
:jusage. ?^?u･?X?g?b?vに対応する空白の?狽�?ﾝ定します

:option. tp
:target. dbg
:id.
:usage. set #pragma on( <id> )
:jusage. #pragma on( <id> )を?ﾝ定します

:option. u
:target. any
:special. scanUndefine [=<name>]
:usage. undefine macro name
:jusage. ?}?N?獄ｼを未定義にします

:option. v
:target. any
:usage. output function declarations to .def file
:jusage. .def?t?@?C?汲ﾉ関?�?骭ｾを出力します

:option. vcap
:target. 386 axp
:usage. VC++ compatibility: alloca allowed in argument lists
:jusage. VC++ 互換?ｫ: ?�?�?�?X?gの中でallocaを使用できます

:option. w
:target. any
:enumerate. warn_level
:number. checkWarnLevel
:usage. set warning level number
:jusage. 警�??�?x?渠ﾔ号を?ﾝ定します

:option. wcd
:target. any
:number.
:multiple.
:usage. warning control: disable warning message <num>
:jusage. 警�??ｧ御: 警�????b?Z?[?W<num>を禁止します

:option. wce
:target. any
:number.
:multiple.
:usage. warning control: enable warning message <num>
:jusage. 警�??ｧ御: 警�????b?Z?[?W <num> の表示をします

:option. we
:target. any
:usage. treat all warnings as errors
:jusage. すべての警�?を?G?�?[として?ｵいます

:option. wpx
:target. any
:internal.
:usage. internal experimental option, check prototypes defined already
:jusage.

:option. wx
:target. any
:enumerate. warn_level
:usage. set warning level to maximum setting
:jusage. 警�??�?x?汲�最大?ﾝ定にします

:option. x
:target. any
:usage. ignore INCLUDE environment variable
:jusage. ignore INCLUDE environment variable

:option. xbnm
:target. any
:internal.
:usage. use latest (incompatible) name mangling algorithms
:jusage. 

:option. xbsa
:target. any
:internal.
:usage. do not align segments if at all possible
:jusage. 

:option. xbov1
:target. any
:internal.
:usage. WP 13.3.3.2 change
:jusage. 

:option. xcmb
:target. any
:internal.
:usage. bind modifiers during template instantiation
:jusage. ?e?�?v?�?[?gを?C?�?X?^?�?X化する間に修飾子を?o?C?�?hします

:option. xcpi
:target. any
:internal.
:usage. instantiate template functions if a prototype is visible
:jusage. ?v?�?g?^?C?vがあれば?A?e?�?v?�?[?g関?狽�?C?�?X?^?�?X化します

:option. xd
:target. any
:enumerate. exc_level
:usage. disable exception handling (default) 
:jusage. 例外�?理を使用不可にします(?f?t?H?�?g) 

:option. xds
:target. any
:enumerate. exc_level
:usage. disable exception handling (table-driven destructors)
:jusage. 例外�?理を使用不可にします(?e?[?u?凶?h?�?u?唐ﾌ?f?X?g?�?N?^)

:option. xdt
:target. any
:enumerate. exc_level
:usage. disable exception handling (same as -xd)
:jusage. 例外�?理を使用不可にします(-xdと同じ)

:option. xr
:target. any
:usage. enable RTTI
:jusage. RTTIを使用可能にします

:option. xs
:target. any
:enumerate. exc_level
:usage. enable exception handling 
:jusage. 例外�?理を使用可能にします

:option. xss
:target. any
:enumerate. exc_level
:usage. enable exception handling (table-driven destructors)
:jusage. 例外�?理を使用可能にします(?e?[?u?凶?h?�?u?唐ﾌ?f?X?g?�?N?^)

:option. xst
:target. any
:enumerate. exc_level
:usage. enable exception handling (direct calls for destruction)
:jusage. 例外�?理を使用可能にします(?f?X?g?�?N?^への直?ﾚ呼出し)

:option. xgls
:target. i86
:internal.
:usage. only check seg of i86 far pointers when checking NULL equality
:jusage.

:option. xgv
:target. 386
:internal.
:usage. indexed global variables
:jusage. ?C?�?f?b?N?X付き?O?�?[?o?虚ﾏ?�

:option. xto
:target. any
:internal.
:usage. obfuscate type signature names
:jusage.

:option. xx
:target. any
:nochain.
:usage. ignore default directories for file search (.,../h,../c,...)
:jusage. ignore default directories for file search (.,../h,../c,...)

:option. za
:target. any
:enumerate. iso
:usage. disable extensions (i.e., accept only ISO/ANSI C++)
:jusage. 拡張機能を使用不可にします(つまり, ISO/ANSI C++のみ受け付けます)

:option. za0x
:target. any
:usage. enable some features of the upcoming ISO C++0x standard
:jusage.

:option. zam
:target. any
:usage. disable all predefined non-ISO extension macros
:jusage. disable all predefined non-ISO extension macros

:option. zat
:target. any
:usage. disable alternative tokens (e.g. and, or, not)
:jusage.

:option. zc
:target. i86 386
:usage. place const data into the code segment
:jusage. ?�?e?�?虚ｶ字列を?R?[?h?Z?O???�?gに入れます

:option. zdf
:target. i86 386
:enumerate. ds_peg
:usage. DS floats (i.e. not fixed to DGROUP)
:jusage. DSを浮動にします(つまりDGROUPに固定しません)

:option. zdp
:target. i86 386
:enumerate. ds_peg
:usage. DS is pegged to DGROUP
:jusage. DSをDGROUPに固定します

:option. zdl
:target. 386
:usage. load DS directly from DGROUP
:jusage. DGROUPからDSに直?ﾚ?�?[?hします

:option. ze
:target. any
:enumerate. iso
:usage. enable extensions (i.e., near, far, export, etc.)
:jusage. 拡張機能を使用可能にします(つまり, near, far, export, 等.)

:option. zf
:target. any
:usage. scope of for loop initializer extends beyond loop
:jusage. FIX ME

:option. zfw
:target. i86
:usage. generate FWAIT instructions on 386 and later
:jusage.

:option. zfw
:target. 386
:usage. generate FWAIT instructions
:jusage.

:option. zff
:target. i86 386
:enumerate. fs_peg
:usage. FS floats (i.e. not fixed to a segment)
:jusage. FSを浮動にします(つまり, 1つの?Z?O???�?gに固定しません)

:option. zfp
:target. i86 386
:enumerate. fs_peg
:usage. FS is pegged to a segment
:jusage. FSを1つの?Z?O???�?gに固定します

:option. zg
:target. any
:usage. generate function prototypes using base types
:jusage. 基本型を使用した関?�?v?�?g?^?C?vを?ｶ?ｬします

:option. zgf
:target. i86 386
:enumerate. gs_peg
:usage. GS floats (i.e. not fixed to a segment)
:jusage. GSを浮動にします(つまり, 1つの?Z?O???�?gに固定しません)

:option. zgp
:target. i86 386
:enumerate. gs_peg
:usage. GS is pegged to a segment
:jusage. GSを1つの?Z?O???�?gに固定します

:option. zi
:target. dbg
:usage. dump informational statistics to stdout
:jusage. 情報として統計値をstdoutに出力します

:option. zk0 zk
:target. any
:enumerate. char_set
:usage. double-byte character support: Kanji
:jusage. 2?o?C?g文字?T?|?[?g: 日本語

:option. zk1
:target. any
:enumerate. char_set
:usage. double-byte character support: Chinese/Taiwanese
:jusage. 2?o?C?g文字?T?|?[?g: 中国語/台?p語

:option. zk2
:target. any
:enumerate. char_set
:usage. double-byte character support: Korean
:jusage. 2?o?C?g文字?T?|?[?g: 韓国語

:option. zk0u
:target. any
:enumerate. char_set
:usage. translate double-byte Kanji to Unicode
:jusage. 2?o?C?g漢字をUnicodeに変換します

:option. zkl
:target. any
:enumerate. char_set
:usage. double-byte character support: local installed language
:jusage. 2?o?C?g文字?T?|?[?g: ?�?[?J?汲ﾉ?C?�?X?g?[?汲ｳれた言語

:option. zku
:target. any
:enumerate. char_set
:number.
:usage. load Unicode translate table for specified code page
:jusage. 指定した?R?[?h?y?[?WのUnicode変換?e?[?u?汲�?�?[?hします

:option. zl
:target. any
:usage. remove default library information
:jusage. ?f?t?H?�?g･?�?C?u?�?鰹�報を削除します

:option. zld
:target. any
:usage. remove file dependency information
:jusage. ?t?@?C?�?ﾋ存情報を削除します

:option. zlf
:target. any
:usage. always generate default library information
:jusage. ?f?t?H?�?g･?�?C?u?�?鰹�報を常に?ｶ?ｬします

:option. zls
:target. any
:usage. remove automatically inserted symbols
:jusage. remove automatically inserted symbols

:option. zm
:target. i86 386
:usage. emit functions in separate segments
:jusage. 各関?狽�別の?Z?O???�?gに入れます

:option. zm
:target. axp
:usage. emit functions in separate sections
:jusage. 各関?狽�別の?Z?O???�?gに入れます

:option. zmf
:target. i86 386
:usage. emit functions in separate segments (near functions allowed)
:jusage. 各関?狽�別の?Z?O???�?gに入れます(near関?狽ｪ可能です)

:option. zo
:target. 386
:usage. use exception-handling for a specific operating system
:jusage. 指定された?I?y?�?[?e?B?�?O･?V?X?e?�用の例外�?理を使用します

:option. zp
:target. any
:number. checkPacking
:usage. pack structure members with alignment {1,2,4,8,16}
:jusage. 構造体???�?o?[を{1,2,4,8,16}に?ｮ列して?p?b?Nします

:option. zpw
:target. any
:usage. output warning when padding is added in a class
:jusage. ?N?�?Xに?p?f?B?�?Oが追加されたときに警�?します

:option. zq
:target. any
:usage. operate quietly (display only error messages)
:jusage. 無???b?Z?[?W?�?[?hで動作します(?G?�?[???b?Z?[?Wのみ表示されます)

:option. zro
:target. any
:usage. omit floating point rounding calls (non ANSI)
:jusage. omit floating point rounding calls (non ANSI)

:option. zri
:target. 386
:usage. inline floating point rounding calls
:jusage. inline floating point rounding calls

:option. zs
:target. any
:usage. syntax check only
:jusage. 構文?`?F?b?Nのみを行います

:option. zt
:target. i86 386
:number. CmdX86CheckThreshold 256
:usage. far data threshold (i.e., larger objects go in far memory)
:jusage. far?f?[?^敷居値(つまり, 敷居値より大きい?I?u?W?F?N?gをfar???�?鰍ﾉ置きます)

:option. zu
:target. i86 386
:usage. SS != DGROUP (i.e., do not assume stack is in data segment)
:jusage. SS != DGROUP (つまり, ?X?^?b?Nが?f?[?^?Z?O???�?gにあると仮定しません)

:option. zv
:target. any
:usage. enable virtual function removal optimization
:jusage. 仮想関?狽�削除する最適化を行います

:option. zw
:target. i86 386
:enumerate. win
:usage. generate code for Microsoft Windows
:jusage. Microsoft Windows用の?R?[?hを?ｶ?ｬします

:option. zws
:target. i86
:enumerate. win
:usage. generate code for Microsoft Windows with smart callbacks
:jusage. ?X?}?[?g･?R?[?�?o?b?NをするMicrosoft Windows用?R?[?hを?ｶ?ｬします

:option. z\W
:target. i86
:enumerate. win
:usage. more efficient Microsoft Windows entry sequences
:jusage. より効果的なMicrosoft Windows?G?�?g?�?R?[?h列を?ｶ?ｬします

:option. z\Ws
:target. i86
:enumerate. win
:usage. generate code for Microsoft Windows with smart callbacks
:jusage. ?X?}?[?g･?R?[?�?o?b?NをするMicrosoft Windows用?R?[?hを?ｶ?ｬします

:option. zx
:target. i86 386
:usage. assume functions will modify FPU registers
:jusage. 関?狽ｪFPU?�?W?X?^を変更すると仮定します
:internal.

:option. zz
:target. 386
:usage. remove "@size" from __stdcall function names (10.0 compatible)
:jusage. "@size"を__stdcall関?薄ｼから削除します(10.0との互換?ｫ)
