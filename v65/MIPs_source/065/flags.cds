



/*

RESET KERNEL FLAGS

This function will reset the flags in the kernel. If the kernel fails
to set the flags then something may be wrong.

*/

__kernel_FLAGS_Reset:
addiu sp, sp, $FE00
sq at, $0000(sp)
sq v0, $0010(sp)
sq v1, $0020(sp)
sq a0, $0030(sp)
sq a1, $0040(sp)
sq a2, $0050(sp)
sq a3, $0060(sp)
sq t0, $0070(sp)
sq t1, $0080(sp)
sq t2, $0090(sp)
sq t3, $00a0(sp)
sq t4, $00b0(sp)
sq t5, $00c0(sp)
sq t6, $00d0(sp)
sq t7, $00e0(sp)
sq s0, $00f0(sp)
sq s1, $0100(sp)
sq s2, $0110(sp)
sq s3, $0120(sp)
sq s4, $0130(sp)
sq s5, $0140(sp)
sq s6, $0150(sp)
sq s7, $0160(sp)
sq t8, $0170(sp)
sq t9, $0180(sp)
sq k0, $0190(sp)
sq k1, $01a0(sp)
sq fp, $01b0(sp)
sq gp, $01c0(sp)
sq ra, $01d0(sp)



// check timer (needed so the flags are in sync with kernel)
// timer limit
addiu s0, zero, $D0 // around 6 seconds = A0
// set timer address
setreg s1, :__kernel_timerVar
// get timer count
lw s2, $0000(s1)
sub s3, s2, s0
bltz s3, :__kernelFLAGS_incrementTimer
nop

// check __kernelCheck_FLAG
setreg s0, :__kernelCheck_FLAG
lbu s0, $0000(s0)
bne s0, zero, :__kernel_FLAGS_ResetFlags
nop


// ELSE, remove player
// disable master packet sender so cheater believes they are still playing
lui t2, $0064
sw zero, $C104(t2)

// kill session
lui t2, $0046
sb zero, $A0C1(t2)



// Reset Flags 1
__kernel_FLAGS_ResetFlags:
setreg s0, :__kernel_FLAG_1
sw zero, $0000(s0) // kernel_FLAG_1
sw zero, $0004(s0) // kernel_FLAG_2
sw zero, $0008(s0) // kernel_FLAG_3
sw zero, $000c(s0) // kernel_FLAG_4
sw zero, $0010(s0) // codescanner2_FLAG_1
sw zero, $0014(s0) // memoryscanner_FLAG_1

// reset timer
sw zero, $0000(s1)
beq zero, zero, :__kernel_FLAGS_end
nop

__kernelFLAGS_incrementTimer:
addiu s2, s2, $1
sw s2, $0000(s1)

__kernel_FLAGS_end:
// set refresh hook flag
setreg t0, :__kernelCheck_FLAG
addiu t1, zero, $1
sw t1, $0000(t0)

lq at, $0000(sp)
lq v0, $0010(sp)
lq v1, $0020(sp)
lq a0, $0030(sp)
lq a1, $0040(sp)
lq a2, $0050(sp)
lq a3, $0060(sp)
lq t0, $0070(sp)
lq t1, $0080(sp)
lq t2, $0090(sp)
lq t3, $00a0(sp)
lq t4, $00b0(sp)
lq t5, $00c0(sp)
lq t6, $00d0(sp)
lq t7, $00e0(sp)
lq s0, $00f0(sp)
lq s1, $0100(sp)
lq s2, $0110(sp)
lq s3, $0120(sp)
lq s4, $0130(sp)
lq s5, $0140(sp)
lq s6, $0150(sp)
lq s7, $0160(sp)
lq t8, $0170(sp)
lq t9, $0180(sp)
lq k0, $0190(sp)
lq k1, $01a0(sp)
lq fp, $01b0(sp)
lq gp, $01c0(sp)
lq ra, $01d0(sp)
// original function to jump to
j $001A3B20
addiu sp, sp, $0200

