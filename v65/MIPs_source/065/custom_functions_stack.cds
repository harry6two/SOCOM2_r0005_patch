

// all functions on refresh screen hook

__custom_function_stack:
addiu sp, sp, $fff0
sw ra, $0000(sp)
sw v0, $0004(sp)
sw v1, $0008(sp)

// WIDESCREEN -- render HUD hook
jal :__widescreen_set_HUD_aspectRatio
nop

// PATCH MENU
jal :__patch_menu
nop
// check if patch menu is open, skipp code scanners if open. kernel scanner will continue running
setreg t0, :__menu_open_bool
lbu t0, $0000(t0)
bne t0, zero, :__custom_function_stack_end
nop

// memory scanner
jal :__memory_scanner__MAIN_FNC
nop
// code scanner
jal :__code_scanner2
nop
// host memory scanner
jal :__hostScanner_main_FNC
nop

__custom_function_stack_end:
// set refresh flag
jal :__refreshHook_setFLAG_FNC
nop
// check flags - kernel
jal :__check_flags_gameplay_kernelOnly_fnc
nop

lw ra, $0000(sp)
lw v0, $0004(sp)
lw v1, $0008(sp)
jr ra
addiu sp, sp, $10


