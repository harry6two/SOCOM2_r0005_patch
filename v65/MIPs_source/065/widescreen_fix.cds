







/*

// render HUD hook
address $001EC440 // constant hook needed for checking night vision and patch stuff
j :__HUD_draw_blackbox

*/


// zoom scope hook -- not needed
//address $005B9790
//j :__HUD_draw_blackbox

__ENABLE_widescreen:
// set t0 to first code to check
setreg t0, :__widescreen_code

__widescreen_LOOP:
// get first line in stack (address)
lw t1, $0000(t0)
// check if first line is 0, if so end function
beq t1, zero, :__widescreen_codes_END
nop

// get second line in stack (data)
lw t2, $0004(t0)
// stored data
sw t2, $0000(t1)
// loop
beq zero, zero, :__widescreen_LOOP
// increment to next position in stack
addiu t0, t0, $8

__widescreen_codes_END:
jr ra
nop


__widescreen_code:
hexcode $00291674 
hexcode $3C023F3C // camera distance
hexcode $004A44AC 
hexcode $3FACCCCD // stretch vertical render
hexcode $0049E9F0 
hexcode $3F3C28F6 // HUD horizontal stretch 
hexcode $0049E9F4 
hexcode $3F800000 // HUD vertical stretch 
hexcode $0049EA00 
hexcode $44E2A000 // HUD horizontal offset
hexcode $0049EA04 
hexcode $44E42000 // HUD vertical offset
// end code stack
nop 
nop

__widescreen_HUD_normal:
hexcode $0049E9F0 
hexcode $3F3C28F6 // HUD horizontal stretch 
hexcode $0049E9F4 
hexcode $3F800000 // HUD vertical stretch 
hexcode $0049EA00 
hexcode $44E2A000 // HUD horizontal offset
hexcode $0049EA04 
hexcode $44E42000 // HUD vertical offset
// end code stack
nop
nop
__widescreen_HUD_stretch:
hexcode $0049E9F0 
hexcode $3F800000 // HUD horizontal stretch 
hexcode $0049E9F4 
hexcode $3F800000 // HUD vertical stretch 
hexcode $0049EA00 
hexcode $44D80000 // HUD horizontal offset
hexcode $0049EA04 
hexcode $44E40000 // HUD vertical offset
// end code stack
nop
nop



__widescreen_set_HUD_aspectRatio:
addiu sp, sp, $ff80
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)

// check if widescreen is enabled
setreg t0, :widescreen_game_BOOL
lbu t0, $0000(t0)
beq t0, zero, :__widescreen__HUD_end
nop

// get zoom mode from pptr
lui t0, $0044
lw t0, $0C38(t0)
// check if pptr exists
beq t0, zero, :__widescreen__HUD_end
nop


lbu t0, $0200(t0)
// check if 0 -- no zoom
beq t0, zero, :__widescreen__render_HUD_normal
nop
// check if 1 -- first person
addiu t1, zero, $1
beq t0, t1, :__widescreen__render_HUD_normal
nop

// else, player is zoomed in
__widescreen__render_HUD_stretched:
// stretch HUD
setreg a0, :__widescreen_HUD_stretch
jal :__write_code_stack
nop
beq zero, zero, :__widescreen__HUD_end
nop


__widescreen__render_HUD_normal:
// normal HUD
setreg a0, :__widescreen_HUD_normal
jal :__write_code_stack
nop

__widescreen__HUD_end:
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
jr ra
addiu sp, sp, $80




// a0 = XY coord of origin
__blackbox_a0:
hexcode $00000000
hexcode $00000000

// a1 = XY coord of destination
__blackbox_a1:
hexcode $00000000
hexcode $43E10000

__blackbox_color1:
hexcode $00000000
hexcode $00000000
hexcode $00000000
hexcode $3f800000


__blackbox_color2:
hexcode $00000000
hexcode $00000000
hexcode $00000000
hexcode $3f800000

// space between variables above and the next function
nop
nop
nop
nop
nop
nop
nop
nop




