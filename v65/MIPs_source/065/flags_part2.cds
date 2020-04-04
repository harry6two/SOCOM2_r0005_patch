



__refreshHook_setFLAG_FNC:
// set refresh hook flag
setreg t0, :__refreshHook_FLAG
addiu t1, zero, $1
sw t1, $0000(t0)

__refreshHook_setFLAG_FNC_end:
//end
jr ra
nop









// main loop flag check
// hook: j from 001E70EC
__mainLoop_refreshFLAG_check_FNC:
// once connected to LAN
lui t0, $0046
lbu t0, $A0C1(t0)
beq t0, zero, :__mainLoop_refreshFLAG_check_FNC_end
nop

// check refreshHook_FLAG
setreg t0, :__refreshHook_FLAG
lbu t1, $0000(t0)
bne t1, zero, :__mainLoop_refreshFLAG_check_FNC_zeroRefreshFLAG
nop

// ELSE, remove player
// disable master packet sender so cheater believes they are still playing
lui t2, $0064
sw zero, $C104(t2)

// kill session
lui t2, $0046
sb zero, $A0C1(t2)


__mainLoop_refreshFLAG_check_FNC_zeroRefreshFLAG:
sw zero, $0000(t0)

__mainLoop_refreshFLAG_check_FNC_end:
// original branch address
j $001E70D0
nop






// return from kernel hook
// 001A6DC4 branch to 001A6E34
_returnFromKernel_check_FNC:
// check timer (needed so the flags are in sync with kernel)
// timer limit
addiu t0, zero, $400
// set timer address
setreg t1, $000f8ff8
// get timer count
lw t2, $0000(t1)
sub t3, t2, t0
bltz t3, :_returnFromKernel_check_FNC_end
nop

// Reset Flags 2
setreg t0, :__kernel_FLAG_1
sw zero, $0000(t0) // kernel_FLAG_1
sw zero, $0004(t0) // kernel_FLAG_2
sw zero, $0008(t0) // kernel_FLAG_3
sw zero, $000c(t0) // kernel_FLAG_4
sw zero, $0010(t0) // codescanner2_FLAG_1
sw zero, $0014(t0) // memoryscanner_FLAG_1

// zero refreshHookFLAG
setreg t0, :__refreshHook_FLAG
sw zero, $0000(t0)

// check __kernelCheck_FLAG
setreg t0, :__kernelCheck_FLAG
lbu t1, $0000(t0)
bne t1, zero, :_returnFromKernel_check_FNC_end
nop


// ELSE, remove player
// disable master packet sender so cheater believes they are still playing
lui t2, $0064
sw zero, $C104(t2)

// kill session
lui t2, $0046
sb zero, $A0C1(t2)


_returnFromKernel_check_FNC_end:
// original check
bgez v0, :_returnFromKernel_check_FNC_v0EqualZero
nop
// original no jump
j $001A6DCC
nop
_returnFromKernel_check_FNC_v0EqualZero:
j $001A6DDC
nop






