

// hook: 00223964




__round_START_or_END_function:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sw v0, $0004(sp)
sw v1, $0008(sp)
swc1 $f12, $000C(sp)

// RESET VOLUME
lui t0, $3f80 // 1.0 = normal volume modifier?
mtc1 $f12, t0
daddu a0, zero, zero
jal $003404E0
addiu a1, zero, $400 // 400 = normal volume


// round end/start hook for resetting timer
jal :__hostScanner_resetVariables_FNC
nop

// RESET __kernel_codesWrite_BOOL so kernel rewrites hooks
setreg t0, :__kernel_codesWrite_BOOL
sw zero, $0000(t0)


lw ra, $0000(sp)
lw v0, $0004(sp)
lw v1, $0008(sp)
lwc1 $f12, $000C(sp)
jr ra
addiu sp, sp, $0020


