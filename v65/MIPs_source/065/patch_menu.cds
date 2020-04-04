

// ** HOOK MOVED TO CUSTOM FUNCTIONS STACK **

//address $002CED04
//j :__patch_menu


//address $000A2000


__options_timer:
nop

__option_index:
hexcode $00000001 // 1 by default
nop

__max_option_index:
hexcode $7
nop

__menu_open_bool:
nop

__option_OPTION_title:
print "PATCH OPTIONS"
nop

__r0005_version:
print "r0005v65"
nop

__option_OPTION_1:
print "LOOK SPEED:     %.1f"
nop
__option_OPTION_2:
print "XHAIR COLOR:    %s"
nop
__option_OPTION_3:
print "BRIGHTNESS:     %.0f%%"
nop
__option_OPTION_4:
print "ROUND START:   %s"
nop
__option_OPTION_5:
print "ASPECT RATIO:  %s"
nop
__option_OPTION_6:
print "CLEAR BANNED PLAYERS"
nop
__option_OPTION_7:
print "CLOSE"
nop

__option_roundstart_crouch:
print "CROUCHING"
nop
__option_roundstart_stand:
print "STANDING"
nop

__option_aspectratio_43:
print "4:3"
nop
__option_aspectratio_169:
print "16:9"
nop

__option_calc_aspectratio:
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop


__options_KDR:
print "KDR: %.1f   FPS: %d"

__options_calc_KDR:
nop
nop
nop
nop
nop
nop

__xhair_color_yellow:
print "YELLOW"
nop
__xhair_color_red:
print "RED"
nop
__xhair_color_blue:
print "BLUE"
nop
__xhair_color_green:
print "GREEN"
nop
__xhair_color_pink:
print "PINK"
nop
__xhair_color_value_yellow:
hexcode $43480000
hexcode $43480000
hexcode $41C00000
nop
__xhair_color_value_red:
hexcode $43480000
hexcode $41C00000
hexcode $41C00000
nop
__xhair_color_value_blue:
hexcode $41200000
hexcode $41F00000
hexcode $43480000
nop
__xhair_color_value_green:
hexcode $41200000
hexcode $43480000
hexcode $41200000
nop
__xhair_color_value_pink:
hexcode $43480000
hexcode $41A00000
hexcode $43020000
nop
__xhair_color_id:
nop 
/* 
0 - yellow
1 - red
2 - blue
3 - green
4 - pink
*/

__option_calc_roundstart:
nop
nop
nop
nop
nop
nop
nop
nop
nop
__option_calc_lookspeed:
nop
nop
nop
nop
nop
nop
nop
__option_calc_xhair:
nop
nop
nop
nop
nop
nop
nop
nop
__option_calc_brightness:
nop
nop
nop
nop
nop
nop
nop
nop



// menu options size
__menu_option_font_size:
hexcode $3F59999A






// MENU X and Y start offsets
__menu_start_X_offset:
hexcode $42CC0000
__menu_start_Y_offset:
hexcode $42CC0000



// -------------------------BACKGROUND BORDER BOX
__backgroundbox_border_a0:
hexcode $430C0000 //42F00000 //433E0000
hexcode $41F00000 //40A00000
__backgroundbox_border_a1:
hexcode $43FF0000 //44048000 //43E10000
hexcode $41F00000
__backgroundbox_border_rgba:
hexcode $3e2c0000 //3e2c0000 
hexcode $3e2c0000 //3e2c0000 
hexcode $3e340000 //3e4C0000 
hexcode $3E99999A

// -------------------------BACKGROUND BOX
__backgroundbox_a0:
hexcode $43110000 // 43430000
hexcode $420C0000 // 41200000
// a1 = XY coord of destination
__backgroundbox_a1:
hexcode $43FC8000 //43DE8000
hexcode $420C0000
__backgroundbox_rgba:
hexcode $3d800000 //3d000000
hexcode $3d800000 //3d2c0000
hexcode $3D83126F //3d944000 //3d800000
hexcode $3ECCCCCD

// -------------------------TITLE BOX
__titlebox_a0:
hexcode $43110000 //43430000 // from left
hexcode $420C0000 
__titlebox_a1:
hexcode $43FC8000 //43DE8000
hexcode $420C0000
__titlebox_rgba:
hexcode $3dff0000 //3d000000
hexcode $3dff0000 //3d2c0000
hexcode $3dff0000 //3d800000
hexcode $3F19999A

// -------------------------STATS BOX
__statsbox_a0:
hexcode $43110000 //43430000 // from left
hexcode $436E0000 //435A0000 
__statsbox_a1:
hexcode $43FC8000 //43DE8000
hexcode $436E0000 //435A0000 
__statsbox_rgba:
hexcode $3dff0000 //3d000000
hexcode $3dff0000 //3d2c0000
hexcode $3dff0000 //3d800000
hexcode $3F19999A



__patch_menu:
addiu sp, sp, $FFF0
sw ra, $0000(sp)

// check if player is in game
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__patch_menu_end
nop
// render options menu
jal :__options
nop
// control menu
jal :__control_option
nop
// change screen map render width
jal :__objectRENDERdistance
nop

__patch_menu_end:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $10



__objectRENDERdistance:
addiu sp, sp, $FFF0
sw ra, $0000(sp)

// viewpointer: 00488DE8 or 00488DF8
// check if widescreen is enabled
setreg t0, :widescreen_game_BOOL
lbu t0, $0000(t0)
beq t0, zero, :__OBJECTrenderWidth__normal
nop

// check if pptr exists
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__OBJECTrenderWidth__normal
nop

// check if viewpointer exists
lui t0, $0049
lw t1, $8DF8(t0)
beq t1, zero, :__OBJECTrenderWidth__normal
nop

// 1.0
lui t0, $3F80 // 1.0 -- default is 0.70
// store max map render distance X
sw t0, $01D0(t1)


// continue to original function
__OBJECTrenderWidth__normal:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $10





__control_option:
addiu sp, sp, $FF80
sw ra, $0000(sp)
sw t9, $0004(sp)
sw s0, $0008(sp)
sw v0, $000c(sp)
sw v1, $0010(sp)
sw a0, $0014(sp)
sw a1, $0018(sp)
sw a2, $001c(sp)
sw a3, $0020(sp)
sw s1, $0024(sp)
sw s2, $0028(sp)
sw s3, $002C(sp)
sw s4, $0030(sp)
sw s5, $0034(sp)
sw s6, $0038(sp)
sw s7, $003C(sp)

// default index
setreg s1, :__option_index
// max index
setreg s2, :__max_option_index
lw s2, $0000(s2)
// get current index id
lw s3, $0000(s1)



// ------------------------------ TIMER SETUP
// set max options timer
addiu s6, zero, $4
// get options timer
setreg s7, :__options_timer
lb t0, $0000(s7)
beq t0, s6, :__continue_to_menu_controls
nop

// else increment timer
__increment_options_timer2:
addiu t0, t0, $1
sw t0, $0000(s7)


// check if timer is max, otherwise skip
bne t0, s6, :__options_setup_end2
nop


__continue_to_menu_controls:
// --------------------------------- CONTROLS


// ------ OPEN/CLOSE MENU
// get button press
lui t0, $0045
lh t0, $F15C(t0)

// check if anything is pressed, if so reset timer for next call
addiu t1, zero, $ffff
beq t0, t1, :__options_setup_end2
nop
__reset_timer_branch:
// else, reset timer to zero
sw zero, $0000(s7)


// check if player is using sureshot
lui t2, $0069
lbu t2, $4F14(t2)
addiu t3, zero, $4
beq t2, t3, :playerIsUsing_sureshot
nop

// check L1 and X pressed --precision
addiu t1, zero, $bbff
beq t0, t1, :__options_OPENorCLOSE_menu
nop
beq zero, zero, :__options_isMenuOpen
nop

playerIsUsing_sureshot:
// check L1 and DPAD down pressed --sureshot
addiu t1, zero, $fbbf
beq t0, t1, :__options_OPENorCLOSE_menu
nop

// check for START button to close menu
//addiu t1, zero, $fff7
//beq t0, t1, :____options_close_menu
//nop

__options_isMenuOpen:
// check if menu is already open, if not disable rest of controls
setreg t3, :__menu_open_bool
lw t3, $0000(t3)
beq t3, zero, :__options_setup_end2
nop


// check for TRIANGLE button to close menu
addiu t1, zero, $efff
beq t0, t1, :____options_close_menu
nop

// check for CRICLE button to close menu
addiu t1, zero, $dfff
beq t0, t1, :____options_close_menu
nop

// else check if menu is open and controls
beq zero, zero, :__check_if_menu_is_open
nop



__options_OPENorCLOSE_menu:
// disable/enable player movement
lui t6, $0041
lw t6, $5FF0(t6)
lw t6, $00BC(t6)
lw t6, $00C0(t6)
// offset 221 = 0, disable movement
// offset 221 = 3, enable movement

// check __menu_open_bool
setreg t3, :__menu_open_bool
lw t4, $0000(t3)
beq t4, zero, :__open_options_menu
nop
// else close options menu
//sw zero, $0000(t3)
// enable player movement
//sb zero, $0221(t6)
beq zero, zero, :__options_UPandDOWN_buttons
nop

__open_options_menu:
addiu t5, zero, $1
sw t5, $0000(t3)
// disable player movement
addiu t5, zero, $3
sb t5, $0221(t6)
beq zero, zero, :__check_if_menu_is_open
nop
// ------------------------


// -----  CLOSE MENU
____options_close_menu:
// check __menu_open_bool
setreg t3, :__menu_open_bool
// disable/enable player movement
lui t6, $0041
lw t6, $5FF0(t6)
lw t6, $00BC(t6)
lw t6, $00C0(t6)
// else close options menu
sw zero, $0000(t3)
// enable player movement
sb zero, $0221(t6)
beq zero, zero, :__options_UPandDOWN_buttons
nop



// check if menu is open, if not then do not enable controls
__check_if_menu_is_open:
setreg t3, :__menu_open_bool
lw t4, $0000(t3)
beq t4, zero, :__options_setup_end2
nop

// ------ UP and DOWN
__options_UPandDOWN_buttons:
// check if pressing down
addiu t1, zero, $ffbf
bne t0, t1, :__check_next_button
nop
// check if max index
beq s3, s2, :__is_max_index_downbtn
nop
// increase index position
addiu s3, s3, $1
// check if zero, if so set to max index position
// continue
beq zero, zero, :__continue_to_draw_menu
nop
// is max index, set index back to 1
__is_max_index_downbtn:
addiu s3, zero, $1
// continue
beq zero, zero, :__continue_to_draw_menu
nop

__check_next_button:
// check if pressing up
addiu t1, zero, $ffef
bne t0, t1, :__continue_to_draw_menu
nop

// decrement index
addiu s3, s3, $ffff

// check if 0, if so set to max index position
bne s3, zero, :__continue_to_draw_menu
nop

// else is = 0, set to max index
daddu s3, s2, zero

__skip_options_control:
// --------------------------------- 

__continue_to_draw_menu:
// save index after button presses
sw s3, $0000(s1)
lbu s3, $0000(s1) // get index value


// --------------------------------------- EXECUTE OPTION
// check if menu is open
setreg t3, :__menu_open_bool
lw t4, $0000(t3)
beq t4, zero, :__options_setup_end2
nop

// s3 = index position
// get button press
//lui t0, $0045
//lh t0, $F15C(t0)

// check X pressed -- moved to individual functions so multiple buttons can be used
//addiu t1, zero, $bfff
//bne t0, t1, :__options_setup_end2
//nop

// check if option 1
addiu t0, zero, $1
beq s3, t0, :__option_1_execute
nop
// check if option 2
addiu t0, zero, $2
beq s3, t0, :__option_2_execute
nop
// check if option 3
addiu t0, zero, $3
beq s3, t0, :__option_3_execute
nop
// check if option 4
addiu t0, zero, $4
beq s3, t0, :__option_4_execute
nop

// check if option 5
addiu t0, zero, $5
beq s3, t0, :__option_5_execute
nop
// check if option 6
addiu t0, zero, $6
beq s3, t0, :__option_6_execute
nop
// check if option 7
addiu t0, zero, $7
beq s3, t0, :__option_7_execute
nop
// check if option 8
addiu t0, zero, $8
beq s3, t0, :__option_8_execute
nop

// else, break
beq zero, zero, :__options_setup_end2
nop

__option_1_execute:
// lookspeed control function
jal :__lookspeed_control
nop
beq zero, zero, :__options_setup_end2
nop

__option_2_execute:
// xhair control function
jal :__xhair_control
nop
beq zero, zero, :__options_setup_end2
nop

__option_3_execute:
// brightness function
jal :__brightness_options_menu
nop
beq zero, zero, :__options_setup_end2
nop

__option_4_execute:
// round start position function
jal :__roundstart_options_menu
nop
beq zero, zero, :__options_setup_end2
nop


__option_5_execute:
// aspect ratio function
jal :__aspectratio_options_menu
nop
beq zero, zero, :__options_setup_end2
nop

__option_6_execute:
// clear banned players
jal :__clearBannedPlayers_options_menu
nop
beq zero, zero, :__options_setup_end2
nop

__option_7_execute:
// close menu function
jal :__close_options_menu
nop
beq zero, zero, :__options_setup_end2
nop

__option_8_execute:
// function here
beq zero, zero, :__options_setup_end2
nop


// --------------------------------------------------

__options_setup_end2:
lw ra, $0000(sp)
lw t9, $0004(sp)
lw s0, $0008(sp)
lw v0, $000c(sp)
lw v1, $0010(sp)
lw a0, $0014(sp)
lw a1, $0018(sp)
lw a2, $001c(sp)
lw a3, $0020(sp)
lw s1, $0024(sp)
lw s2, $0028(sp)
lw s3, $002C(sp)
lw s4, $0030(sp)
lw s5, $0034(sp)
lw s6, $0038(sp)
lw s7, $003C(sp)
jr ra
addiu sp, sp, $80


/*
__write_code_stack:
// a0 = code stack to write
__write_code_stack_LOOP:
// get first line in stack (address)
lw t1, $0000(a0)
// check if first line is 0, if so end function
beq t1, zero, :__write_code_stack_END
nop

// get second line in stack (data)
lw t2, $0004(a0)
// stored data
sw t2, $0000(t1)
// loop
beq zero, zero, :__write_code_stack_LOOP
// increment to next position in stack
addiu a0, a0, $8

__write_code_stack_END:
jr ra
nop
*/
__aspectratio_options_169_code:
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
__aspectratio_options_43_code:
hexcode $00291674 
hexcode $3C023F80 // camera distance
hexcode $004A44AC 
hexcode $3F800000 // stretch vertical render
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




__aspectratio_options_menu:
addiu sp, sp, $FFE0
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)
sw s2, $000c(sp)

// check if player is using PCSX2, if not skip function.
// NOTE: Drawing black bars will randomly freeze ps2.
/*
setreg t0, :pcsx2_BOOL
lw t0, $0000(t0)
beq t0, zero, :__aspectratio_options_menu_end
nop
*/

// set s0 as widescreen_game_BOOL
setreg s0, :widescreen_game_BOOL

// check if DPAD_RIGHT is pressed
lui t0, $0045
lh t0, $F15C(t0)
addiu t1, zero, $ffdf
beq t0, t1, :__aspectratio_DPAD_RIGHTorLEFT
nop
// check if DPAD_LEFT pressed
addiu t1, zero, $ff7f
beq t0, t1, :__aspectratio_DPAD_RIGHTorLEFT
nop
// ELSE, END
beq zero, zero, :__aspectratio_options_menu_end
nop



__aspectratio_DPAD_RIGHTorLEFT:
// check current ratio
lui t0, $004A
lw t0, $E9F0(t0)
lui t1, $3f80
beq t0, t1, :__aspectratio_options_set_169
nop

// else set to 4:3
setreg a0, :__aspectratio_options_43_code
// set widescreen_game_BOOL to 0
sw zero, $0000(s0)
// set manual camera update float
setreg a1, $43E480F1 // this value is calculated by the udpate cam function
beq zero, zero, :__aspectratio_options_update_camera
nop

__aspectratio_options_set_169:
// set widescreen_game_BOOL to 1
addiu t0, zero, $1
sw t0, $0000(s0)
setreg a0, :__aspectratio_options_169_code
// set manual camera update float
setreg a1, $43A7CEB1 // this value is calculated by the udpate cam function

__aspectratio_options_update_camera:
// apply aspect ratio code
jal :__write_code_stack
nop
// update camera 00488DE8 or 00488DF8
lui a0, $0049
lw a0, $8DF8(a0) // camera pointer

// manual update camera (needed for ps2)
sw a1, $0290(a0)

//jal $002915F0
//nop
__aspectratio_options_menu_end:
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $000c(sp)
jr ra
addiu sp, sp, $20










__roundstart_options_menu:
addiu sp, sp, $FFE0
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)
sw s2, $000c(sp)

// get current round start position
setreg s0, $00597FBC
lb s1, $0000(s0)

// check if DPAD_RIGHT is pressed
lui t0, $0045
lh t0, $F15C(t0)
addiu t1, zero, $ffdf
beq t0, t1, :__roundstart_DPAD_RIGHTorLEFT
nop
// check if DPAD_LEFT pressed
addiu t1, zero, $ff7f
beq t0, t1, :__roundstart_DPAD_RIGHTorLEFT
nop
// ELSE, END
beq zero, zero, :__roundstart_options_menu_end
nop

__roundstart_DPAD_RIGHTorLEFT:
beq s1, zero, :__roundstart_options_save_crouch
nop
// else, set STAND
sb zero, $0000(s0)
beq zero, zero, :__roundstart_options_menu_end
nop
__roundstart_options_save_crouch:
addiu t0, zero, $1
// set STANDING position
sb t0, $0000(s0)

__roundstart_options_menu_end:
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $000c(sp)
jr ra
addiu sp, sp, $20








__brightness_options_menu:
addiu sp, sp, $FFE0
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)
sw s2, $000c(sp)

// get current brightness, 0.5 = default
setreg s0, $00726044
lw s1, $0000(s0)
mtc1 $f12, s1


// check if DPAD_RIGHT is pressed
lui t0, $0045
lh t0, $F15C(t0)
addiu t1, zero, $ffdf
beq t0, t1, :__brightness_DPAD_RIGHT
nop
// check if DPAD_LEFT pressed
addiu t1, zero, $ff7f
beq t0, t1, :__brightness_DPAD_LEFT
nop
// ELSE, END
beq zero, zero, :__brightness_options_menu_end
nop

// DPAD RIGHT pressed
__brightness_DPAD_RIGHT:
// check if max value
setreg t0, $3F733333 // 0.95
mtc1 $f1, t0
// end function if max value
c.le.s $f12, $f1
// if brightness < 0.95
bc1f :__brightness_options_menu_end
nop 

// else increment value by 0.05
setreg t0, $3D4CCCCD
mtc1 $f1, t0
add.s $f12, $f12, $f1
beq zero, zero, :__brightness_options_menu_end
nop

// DPAD LEFT pressed
__brightness_DPAD_LEFT:
c.lt.s $f12, zero
// if brightness < 0
bc1t :__brightness_set_zero
nop 

// else decrement by 0.05
setreg t0, $3D4CCCCD
mtc1 $f1, t0
sub.s $f12, $f12, $f1
// check if new brightness is too low, if so set to 0
c.lt.s $f12, zero
// if brightness < 0
bc1t :__brightness_set_zero
nop 

beq zero, zero, :__brightness_options_menu_end
nop
__brightness_set_zero:
mtc1 $f12, zero

__brightness_options_menu_end:
// update brightness via $f12
swc1 $f12, $0000(s0)
jal $003AFBE0 // update brightness function
nop

lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $000c(sp)
jr ra
addiu sp, sp, $20


__clearBannedPlayers_options_menu:
addiu sp, sp, $FFF0
sw ra, $0000(sp)

// check if CROSS is pressed
lui t0, $0045
lh t0, $F15C(t0)
addiu t1, zero, $bfff
bne t0, t1, :__skip_clearBannedPlayers_menu
nop

// clear banned players
setreg t0, :__hostScanner_bannedPlayers
setreg t1, :__hostScanner_bannedPlayers_end


_clearBannedPlayers_menu__next:
beq t0, t1, :__skip_clearBannedPlayers_menu
nop
// zero IP
sq zero, $0000(t0)
// increment to next IP and branch
beq zero, zero, :_clearBannedPlayers_menu__next
addiu t0, t0, $10

__skip_clearBannedPlayers_menu:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $10


__close_options_menu:
addiu sp, sp, $FFF0
sw ra, $0000(sp)

// check if CROSS is pressed
lui t0, $0045
lh t0, $F15C(t0)
addiu t1, zero, $bfff
bne t0, t1, :__skip_close_menu
nop

// menu open bool
setreg t3, :__menu_open_bool
// disable menu
sw zero, $0000(t3)
// disable/enable player movement
lui t6, $0041
lw t6, $5FF0(t6)
lw t6, $00BC(t6)
lw t6, $00C0(t6)
// enable player movement
sb zero, $0221(t6)

__skip_close_menu:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $10



__xhair_control:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sw s0, $0004(sp)

// get xhair color id
setreg s0, :__xhair_color_id
lw t2, $0000(s0)


// check if DPAD_RIGHT is pressed
lui t0, $0045
lh t0, $F15C(t0)
addiu t1, zero, $ffdf
beq t0, t1, :__xhair_DPAD_RIGHT
nop
// check if DPAD_LEFT pressed
addiu t1, zero, $ff7f
beq t0, t1, :__xhair_DPAD_LEFT
nop
// ELSE, END
beq zero, zero, :__xhair_control_end
nop



__xhair_DPAD_RIGHT:
// check if id is max index
addiu t0, zero, $4
bne t2, t0, :__xhair_dpadright_increment
nop
// else, reset id to 0
sw zero, $0000(s0)
lw t2, $0000(s0)
beq zero, zero, :__xhair_apply_colors
nop

__xhair_dpadright_increment:
// increment by 1
addiu t2, t2, $1
sw t2, $0000(s0)
beq zero, zero, :__xhair_apply_colors
nop


__xhair_DPAD_LEFT:
// check if id is minimum aka 0
bne t2, zero, :__xhair_dpadleft_decrement
nop
// else, reset to position 4
addiu t2, zero, $4
sw t2, $0000(s0)
beq zero, zero, :__xhair_apply_colors
nop

// decrease index by 1
__xhair_dpadleft_decrement:
addiu t2, t2, $ffff // -1
sw t2, $0000(s0)


__xhair_apply_colors:
// get current xhair color id
lw t2, $0000(s0)

// check if red
addiu t3, zero, $1
beq t2, t3, :set_xhair_red
nop

// check if blue
addiu t3, zero, $2
beq t2, t3, :set_xhair_blue
nop

// check if green
addiu t3, zero, $3
beq t2, t3, :set_xhair_green
nop

// check if pink
addiu t3, zero, $4
beq t2, t3, :set_xhair_pink
nop

// yellow
set_xhair_yellow:
setreg t0, :__xhair_color_value_yellow
beq zero, zero, :__save_xhair_colors
nop

// red
set_xhair_red:
setreg t0, :__xhair_color_value_red
beq zero, zero, :__save_xhair_colors
nop

// blue
set_xhair_blue:
setreg t0, :__xhair_color_value_blue
beq zero, zero, :__save_xhair_colors
nop

// green
set_xhair_green:
setreg t0, :__xhair_color_value_green
beq zero, zero, :__save_xhair_colors
nop

// pink
set_xhair_pink:
setreg t0, :__xhair_color_value_pink
beq zero, zero, :__save_xhair_colors
nop


__save_xhair_colors:
/*
003DC5A0 - r
003DC5A8 - g
003DC5B0 - b
*/
// set xhair color addresses and save values from t0
lui t2, $003E
// r
lw t3, $0000(t0)
sw t3, $C5A0(t2)
// g
lw t3, $0004(t0)
sw t3, $C5A8(t2)
// b
lw t3, $0008(t0)
sw t3, $C5B0(t2)

__xhair_control_end:
lw ra, $0000(sp)
lw s0, $0004(sp)
jr ra
addiu sp, sp, $20
















__lookspeed_control:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sw s0, $0004(sp)

// get look speed
lui s0, $0045
lwc1 $f0, $C290(s0)

// check if DPAD_RIGHT is pressed
lui t0, $0045
lh t0, $F15C(t0)
addiu t1, zero, $ffdf
beq t0, t1, :__lookspeed_DPAD_RIGHT
nop
// check if DPAD_LEFT pressed
addiu t1, zero, $ff7f
beq t0, t1, :__lookspeed_DPAD_LEFT
nop
// ELSE, END
beq zero, zero, :__lookspeed_end
nop


__lookspeed_DPAD_RIGHT:
// check if max value of 10.0
setreg t0, $411E6666
mtc1 $f1, t0
c.le.s $f0, $f1
// if lookspeed >= 10.0
bc1f :__lookspeed_end
nop 
// if lookspeed < 10.0
setreg t0, $3DCCCCCD // 0.1
mtc1 $f1, t0
add.s $f0, $f0, $f1
swc1 $f0, $C290(s0) // store incremented value into look_speed
beq zero, zero, :__lookspeed_end
nop


__lookspeed_DPAD_LEFT:
// check if max value of 0.0
setreg t0, $3DCCCCCD
mtc1 $f1, t0
// if lookspeed <= 0
c.le.s $f0, $f1
bc1t :__lookspeed_end
nop 
// if lookspeed > 0.0
setreg t0, $3DCCCCCD // 0.1
mtc1 $f1, t0
sub.s $f0, $f0, $f1
swc1 $f0, $C290(s0) // store incremented value into look_speed
beq zero, zero, :__lookspeed_end
nop

__lookspeed_end:
lw ra, $0000(sp)
lw s0, $0004(sp)
jr ra
addiu sp, sp, $20
















__options:
addiu sp, sp, $FF80
sw ra, $0000(sp)
sw t9, $0004(sp)
sw s0, $0008(sp)
sw v0, $000c(sp)
sw v1, $0010(sp)
sw a0, $0014(sp)
sw a1, $0018(sp)
sw a2, $001c(sp)
sw a3, $0020(sp)
sw s1, $0024(sp)
sw s2, $0028(sp)
sw s3, $002C(sp)
sw s4, $0030(sp)
sw s5, $0034(sp)
sw s6, $0038(sp)
sw s7, $003C(sp)


// default index
setreg s1, :__option_index
// max index
setreg s2, :__max_option_index
lw s2, $0000(s2)
// get current index id
lw s3, $0000(s1)


// get __menu_start_X_offset
setreg s4, :__menu_start_X_offset
lw s4, $0000(s4)
// get __menu_start_Y_offset
setreg s6, :__menu_start_Y_offset
lwc1 $f4, $0000(s6)

// distance between menu items
setreg s5, $41C80000

// set options font size
setreg s7, :__menu_option_font_size
lw s7, $0000(s7)

// check if menu is open, if not then do not render menu or enable controls
setreg t3, :__menu_open_bool
lw t4, $0000(t3)
beq t4, zero, :__no_render_options
nop


// check if player is using PCSX2, if not skip function.
// NOTE: Drawing boxes will randomly freeze ps2.
/*
setreg t0, :pcsx2_BOOL
lw t0, $0000(t0)
beq t0, zero, :__options_continue_text_render
nop
*/


// check if patch menu background is enabled
setreg t0, :patchMenuEnable_BOOL
lbu t0, $0000(t0)
beq t0, zero, :__options_continue_text_render
nop

// ------------- create background border box
setreg a0, :__backgroundbox_border_a0
setreg a1, :__backgroundbox_border_a1
addiu a2, zero, $1f6
setreg a3, :__backgroundbox_border_rgba
jal :__draw_box
nop

// ------------- create background box
setreg a0, :__backgroundbox_a0
setreg a1, :__backgroundbox_a1
addiu a2, zero, $1e4
setreg a3, :__backgroundbox_rgba
jal :__draw_box
nop

// ------------- create title box
setreg a0, :__titlebox_a0
setreg a1, :__titlebox_a1
addiu a2, zero, $48
setreg a3, :__titlebox_rgba
jal :__draw_box
nop

/*
// ------------- create stats box
setreg a0, :__statsbox_a0
setreg a1, :__statsbox_a1
addiu a2, zero, $2a
setreg a3, :__statsbox_rgba
jal :__draw_box
nop
*/

__options_continue_text_render:


// ------------------------------- OPTIONS TITLE
// print text

setreg a0, :__option_OPTION_title
setreg a1, $43870000
setreg a2, $42820000
setreg a3, $3FC00000
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
setreg t3, $42B40000
daddu t4, s3, zero
addiu t5, zero, $0
jal :__print_text_options
nop

// -------------------------------




// ------------------------------- r0005 revision
// print text

setreg a0, :__r0005_version
setreg a1, $43E10000
setreg a2, $43880000 //43680000 
setreg a3, $3F4CCCCD
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
setreg t3, $42480000
daddu t4, s3, zero
addiu t5, zero, $0
jal :__print_text_options
nop

// -------------------------------

// ----------------------------------KDR and FPS

// get kills and deaths, check if either are zero
lui t0, $000F
lw t1, $0FF0(t0) //kills
lw t2, $0FF4(t0) //deaths

//check if kills > 0 and deaths = 0
beq t1, zero, :OPTIONS__zero_deaths
nop
bne t2, zero, :OPTIONS__continue
nop

//player has >0 kills and <=0 deaths
//force deaths = 1 so KDR shows
beq zero, zero, :OPTIONS__continue
lui t2, $3f80


//check if deaths = 0 to avoid dividing by 0
bne t2, zero, :OPTIONS__continue
nop

// zero deaths
OPTIONS__zero_deaths:
daddu v0, zero, zero
beq zero, zero, :OPTIONS__create_string
nop

OPTIONS__continue:
mtc1 t1, $f1
mtc1 t2, $f2
div.s $f12, $f1, $f2

// convert floating point
jal $001A0720
nop

// create string
OPTIONS__create_string:
setreg a0, :__options_calc_KDR //addiu a0, sp, $30 //destination
setreg a1, :__options_KDR //source
daddu a2, v0, zero
// move FPS into a3
lui a3, $004A
lhu a3, $4498(a3)
addiu t1, zero, $1e // 30
subu t1, t1, a3 // t1 = 30 - current fps
bgez t1, :__KDRandFPS_continue
nop

// else, fps > 30, set fps display to 30
addiu a3, zero, $1e

__KDRandFPS_continue:
// sprintf
jal $001988D0
nop

// print text
setreg a0, :__options_calc_KDR
setreg a1, $43340000
setreg a2, $43880000 //43680000
setreg a3, $3F4CCCCD
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
setreg t3, $42480000
daddu t4, s3, zero
addiu t5, zero, $0
jal :__print_text_options
nop

// -------------------------------


// ------------------------------- LOOKSPEED

// get look speed
lui t0, $0045
lwc1 $f12, $C290(t0)
// convert floating point
jal $001A0720
nop
// create string
setreg a0, :__option_calc_lookspeed
setreg a1, :__option_OPTION_1
daddu a2, v0, zero
jal $001988D0 //sprintf
nop


// print text
setreg a0, :__option_calc_lookspeed
setreg a1, $43820000
daddu a2, s4, zero
daddu a3, s7, zero //setreg a3, $3F800000
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
setreg t3, $42B40000
daddu t4, s3, zero
addiu t5, zero, $1
jal :__print_text_options
nop
// -------------------------------








// ------------------------------- CROSSHAIR COLOR
// increment vertical starting position
mtc1 $f0, s4
mtc1 $f1, s5
add.s $f0, $f0, $f1
mfc1 s4, $f0


// determine xhair color
setreg t0, :__xhair_color_id
lw t0, $0000(t0)

// check if red
addiu t1, zero, $1
beq t0, t1, :xhairIS_red
nop

// check if blue
addiu t1, zero, $2
beq t0, t1, :xhairIS_blue
nop

// check if green
addiu t1, zero, $3
beq t0, t1, :xhairIS_green
nop

// check if pink
addiu t1, zero, $4
beq t0, t1, :xhairIS_pink
nop

// ELSE is yellow
beq zero, zero, :xhairIS_yellow
nop

xhairIS_yellow:
setreg v0, :__xhair_color_yellow
beq zero, zero, :__xhair_create_string
nop

xhairIS_red:
setreg v0, :__xhair_color_red
beq zero, zero, :__xhair_create_string
nop

xhairIS_blue:
setreg v0, :__xhair_color_blue
beq zero, zero, :__xhair_create_string
nop

xhairIS_green:
setreg v0, :__xhair_color_green
beq zero, zero, :__xhair_create_string
nop

xhairIS_pink:
setreg v0, :__xhair_color_pink
beq zero, zero, :__xhair_create_string
nop 

// create string
__xhair_create_string:
setreg a0, :__option_calc_xhair
setreg a1, :__option_OPTION_2
daddu a2, v0, zero
jal $001988D0 //sprintf
nop

// print text
setreg a0, :__option_calc_xhair
setreg a1, $43814000
daddu a2, s4, zero
daddu a3, s7, zero //setreg a3, $3F800000
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
setreg t3, $42B40000
daddu t4, s3, zero
addiu t5, zero, $2
jal :__print_text_options
nop
// -------------------------------









// -------------------------------BRIGHTNESS LEVEL
// increment vertical starting position
mtc1 $f0, s4
mtc1 $f1, s5
add.s $f0, $f0, $f1
mfc1 s4, $f0

// get current brightness, 0.5 = default
// get brightness from 00726044
lui t0, $0072
lwc1 $f12, $6044(t0)
// multiply by 100 so it's easier to view
lui t1, $42c8
mtc1 $f0, t1
mul.s $f12, $f12, $f0
// convert floating point
jal $001A0720
nop
// create string
setreg a0, :__option_calc_brightness
setreg a1, :__option_OPTION_3
daddu a2, v0, zero
jal $001988D0 //sprintf
nop


// print text
setreg a0, :__option_calc_brightness
setreg a1, $43810000
daddu a2, s4, zero
daddu a3, s7, zero //setreg a3, $3F800000
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
setreg t3, $42B40000
daddu t4, s3, zero
addiu t5, zero, $3
jal :__print_text_options
nop
// -------------------------------









// -------------------------------ROUND START
// increment vertical starting position
mtc1 $f0, s4
mtc1 $f1, s5
add.s $f0, $f0, $f1
mfc1 s4, $f0

// get current round start player stance
setreg t0, $00597FBC
lb t0, $0000(t0)
beq t0, zero, :__option_roundstart_set_stand
nop

// else, is CROUCH
setreg v0, :__option_roundstart_crouch
beq zero, zero, :__option_roundstart_string_create
nop

// set STAND
__option_roundstart_set_stand:
setreg v0, :__option_roundstart_stand

// create string
__option_roundstart_string_create:
setreg a0, :__option_calc_roundstart
setreg a1, :__option_OPTION_4
daddu a2, v0, zero
jal $001988D0 //sprintf
nop


// print text
setreg a0, :__option_calc_roundstart
setreg a1, $43828000
daddu a2, s4, zero
daddu a3, s7, zero //setreg a3, $3F800000
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
setreg t3, $42B40000
daddu t4, s3, zero
addiu t5, zero, $4
jal :__print_text_options
nop
// -------------------------------


// -------------------------------ASPECT RATIO
// increment vertical starting position
mtc1 $f0, s4
mtc1 $f1, s5
add.s $f0, $f0, $f1
mfc1 s4, $f0

// check if normal 4:3
setreg t0, $0049E9F0
lw t0, $0000(t0)
lui t1, $3f80
bne t0, t1, :__option_aspectratio_set_169
nop

// set 4:3
setreg v0, :__option_aspectratio_43
beq zero, zero, :__option_aspectratio_string_create
nop

// set 16:9
__option_aspectratio_set_169:
setreg v0, :__option_aspectratio_169

// create string
__option_aspectratio_string_create:
setreg a0, :__option_calc_aspectratio
setreg a1, :__option_OPTION_5
daddu a2, v0, zero
jal $001988D0 //sprintf
nop


// print text
setreg a0, :__option_calc_aspectratio
setreg a1, $43820000
daddu a2, s4, zero
daddu a3, s7, zero //setreg a3, $3F800000
// set text to normal
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
// check if player is using PCSX2
/*
setreg t3, :pcsx2_BOOL
lw t3, $0000(t3)
bne t3, zero, :__option_aspectratio_continue_render
nop
// set text to grey
setreg t0, $42800000
setreg t1, $42800000
setreg t2, $42800000
*/

__option_aspectratio_continue_render:
setreg t3, $42B40000
daddu t4, s3, zero
addiu t5, zero, $5
jal :__print_text_options
nop
// -------------------------------



// -------------------------------CLEAR BANNED PLAYERS
// increment vertical starting position
mtc1 $f0, s4
mtc1 $f1, s5
add.s $f0, $f0, $f1
mfc1 s4, $f0

// print text
setreg a0, :__option_OPTION_6
setreg a1, $43810000 // 43818000
daddu a2, s4, zero
daddu a3, s7, zero //setreg a3, $3F800000
// check if any banned players exist, if not set option to grey
// set grey color by default and change after bannedPlayers check
setreg t0, $42800000
setreg t1, $42800000
setreg t2, $42800000
setreg t3, :__hostScanner_bannedPlayers
lw t3, $0000(t3)
beq t3, zero, :clearBannedPlayers_stringPrintContinue
nop
// else, normal text color
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
clearBannedPlayers_stringPrintContinue:
setreg t3, $42B40000
daddu t4, s3, zero
addiu t5, zero, $6
jal :__print_text_options
nop
// -------------------------------




// -------------------------------CLOSE MENU
// increment vertical starting position
mtc1 $f0, s4
mtc1 $f1, s5
add.s $f0, $f0, $f1
mfc1 s4, $f0

// print text
setreg a0, :__option_OPTION_7
setreg a1, $43A50000 //43820000
daddu a2, s4, zero
daddu a3, s7, zero //setreg a3, $3F800000
setreg t0, $43000000
setreg t1, $43000000
setreg t2, $43000000
setreg t3, $42B40000
daddu t4, s3, zero
addiu t5, zero, $7
jal :__print_text_options
nop
// -------------------------------



// end options
beq zero, zero, :__options_end
nop

__no_render_options:
// reset index when not rendering
addiu t0, zero, $1
sw t0, $0000(s1)


__options_end:
lw ra, $0000(sp)
lw t9, $0004(sp)
lw s0, $0008(sp)
lw v0, $000c(sp)
lw v1, $0010(sp)
lw a0, $0014(sp)
lw a1, $0018(sp)
lw a2, $001c(sp)
lw a3, $0020(sp)
lw s1, $0024(sp)
lw s2, $0028(sp)
lw s3, $002C(sp)
lw s4, $0030(sp)
lw s5, $0034(sp)
lw s6, $0038(sp)
lw s7, $003C(sp)
jr ra
addiu sp, sp, $80
nop













__draw_box:
/*
a0 = starting position X & Y - point A
a1 = starting position X & Y - point B
a2 = height - from top to bottom
a3 = color RGBA 
t0 = index position

Note: Length of box is determined by a0 and a1. A single line is drawn between those args.
*/
addiu sp, sp, $ff70
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)
sw s2, $0010(sp)


// move index to s2
daddu s2, t0, zero

//------------------------------- create box
// set black box starting point
ld t1, $0000(a0)
sd t1, $0020(sp) // point A
ld t1, $0000(a1)
sd t1, $0030(sp) // point B


// zero counter
daddu s0, zero, zero
// set max count
daddu s1, a2, zero //-- BAR HEIGHT
// move color RGBA to sp
sq a3, $0040(sp)

__drawbox_loop:
// set color every loop
lq a2, $0040(sp) // colors for a2
lq a3, $0040(sp) // colors for a3
// render box
jal $0035FCE0
nop

// increment counter
addiu s0, s0, $1

// increment horizontal position 1
lwc1 $f0, $0024(sp)
lui t0, $3F00 // 1/2 pixel. adding just 1 leaves space between lines
mtc1 $f1, t0
add.s $f0, $f0, $f1
swc1 $f0, $0024(sp) // save incremented vertical position
swc1 $f0, $0034(sp) // --
addiu a0, sp, $20 // set a0 to new position
addiu a1, sp, $30 // --

// check if max count and loop if not
bne s0, s1, :__drawbox_loop
nop
//------------------------------ end create box


__drawblackbars_end:

lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $0010(sp)
jr ra
addiu sp, sp, $90






//----------------------------------------------
// print text fnc
/*
args:
a0: ptr to text to render
a1: X offset
a2: Y offset
a3: text size
t0: text color RED
t1: text color GREEN
t2: text color BLUE
t3: text color ALPHA
t4: current menu index id
t5: string index id
*/

// this fnc was wrote by Antix
__print_text_options:

addiu sp, sp, $FFE0
sw ra, $0000(sp)
sw s0, $0004(sp)


setreg s0, :__s0_register_patch_options
setreg v0, $00406DF0
sw v0, $000c(s0)
setreg v0, $3F8000CD
sw v0, $0014(s0)

sw a0, $001c(s0)

addiu v0, zero, $000F
sw v0, $0020(s0)
addiu v0, zero, $0006
sw v0, $0024(s0)
// X and Y offsets
setreg v0, $414ED2E3
sw v0, $0038(s0)
setreg v0, $42740000
sw v0, $003c(s0)
// set text size
sw a3, $0040(s0)

// check if option is highlighted
bne t4, t5, :__render_string_continue
nop

// else is highlighted
setreg t0, $42C80000
setreg t1, $42C80000
setreg t2, $40000000
setreg t3, $42C80000

__render_string_continue:
sw t0, $0048(s0)
sw t1, $004c(s0)
sw t2, $0050(s0)
sw t3, $0054(s0)

setreg v0, $80800051
sw v0, $005c(s0)

setreg v0, $0040D57C //--game    
lw v0, $0000(v0)
sw v0, $0018(s0)

setreg v0, $004067B0
sw v0, $0060(s0)
addiu v0, zero, $0100
sw v0, $0068(s0)
addiu v0, zero, $015e
sw v0, $0070(s0)
setreg v0, $3F800000
sw v0, $0078(s0)
sw a1, $0090(s0) // X offset
sw a2, $0094(s0) // Y offset
setreg v0, $0000EC60
sw v0, $0098(s0)
setreg v0, $3F801B00
//
setreg v0, $00488DF8

setreg v0, $00406C10
sw v0, $0100(s0)

setreg v0, $00488DF8
lw v0, $0000(v0)
sw v0, $0104(s0)

addiu a1, s0, $0100
daddu a0, s0, zero
jal $003635C0 // print text fnc
nop

lw s0, $0004(sp)
lw ra, $0000(sp)
jr ra
addiu sp, sp, $20


__s0_register_patch_options:
// the below nops are needed as a blank area to output the string stack
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop


