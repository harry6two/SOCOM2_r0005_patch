




// SCOREBOARD: LAN game hook
//address $0022C4A4
//jal :SCOREBOARD_LanGame_FNC

// SCOREBOARD: game details hook
//address $0022CE4C
//jal :SCOREBOARD_GameDetails_FNC








//address $000A0000
LanGame_string_setup:
print "KDR: %.1f     v65"
nop
LanGame_string_output:
nop
nop
nop
nop
nop
nop
nop
nop
GameDetails_sgl_string:
print "PATCH: SGL"
nop
GameDetails_legacy_string:
print "PATCH: LEGACY"
nop
GameDetails_patch_string:
print "PATCH: NORMAL"
nop
GameDetails_halo_string:
print "PATCH: HALO"
nop
GameDetails_regular_string:
print "REGULAR GAME"
nop

// SCOREBOARD: LAN game string swap function
SCOREBOARD_LanGame_FNC:
addiu sp, sp, $ffc0
sw t0, $0000(sp)
sw t1, $0004(sp)
sw t2, $0008(sp)
sw t3, $000c(sp)
sw t4, $0010(sp)
sw t5, $0014(sp)
sw a0, $0018(sp)
sw a2, $0020(sp)
sw a3, $0024(sp)
swc1 $f0, $0028(sp)
swc1 $f1, $002c(sp)
swc1 $f12, $0030(sp)
sw ra, $0034(sp)
// get kills and deaths, check if either are zero
lui t0, $000F
lw t1, $0FF0(t0) //kills
lw t2, $0FF4(t0) //deaths
//check if kills > 0 and deaths = 0
beq t1, zero, :scoreboard__zero_deaths
nop
bne t2, zero, :scoreboard__continue
nop
//player has >0 kills and <=0 deaths
//force deaths = 1 so KDR shows
beq zero, zero, :scoreboard__continue
lui t2, $3f80
//check if deaths = 0 to avoid dividing by 0
bne t2, zero, :scoreboard__continue
nop
// zero deaths
scoreboard__zero_deaths:
daddu v0, zero, zero
beq zero, zero, :scoreboard__create_string
nop
scoreboard__continue:
// convert kills and deaths to decimal and divide to get KDR
mtc1 t1, $f1
mtc1 t2, $f2
div.s $f12, $f1, $f2
// convert floating point
jal $001A0720
nop
// create string
scoreboard__create_string:
setreg a0, :LanGame_string_output
setreg a1, :LanGame_string_setup
daddu a2, v0, zero
jal $001988D0 //sprintf
nop
// replace string
setreg a1, :LanGame_string_output
// restore registers
lw t0, $0000(sp)
lw t1, $0004(sp)
lw t2, $0008(sp)
lw t3, $000c(sp)
lw t4, $0010(sp)
lw t5, $0014(sp)
lw a0, $0018(sp)
lw a2, $0020(sp)
lw a3, $0024(sp)
lwc1 $f0, $0028(sp)
lwc1 $f1, $002c(sp)
lwc1 $f12, $0030(sp)
lw ra, $0034(sp)
j $003631C0
addiu sp, sp, $40







// SCOREBOARD: game details string swap function
SCOREBOARD_GameDetails_FNC:
addiu sp, sp, $fff0
sw t0, $0000(sp)
sw ra, $0004(sp)


// check if patch game
setreg t0, :patched_game_BOOL
lbu t0, $0000(t0)
bne t0, zero, :GameDetails_check_sgl
nop
// REGULAR GAME
setreg a1, :GameDetails_regular_string
beq zero, zero, :GameDetails_end
nop

GameDetails_check_sgl:
setreg t0, :sgl_game_BOOL
lbu t0, $0000(t0)
beq t0, zero, :GameDetails_check_legacy
nop
// SGL GAME
setreg a1, :GameDetails_sgl_string
beq zero, zero, :GameDetails_end
nop

GameDetails_check_legacy:
setreg t0, :legacyPatch_BOOL
lbu t0, $0000(t0)
beq t0, zero, :GameDetails_check_halo
nop
// LEGACY GAME
setreg a1, :GameDetails_legacy_string
beq zero, zero, :GameDetails_end
nop


GameDetails_check_halo:
setreg t0, :halo_game_BOOL
lbu t0, $0000(t0)
beq t0, zero, :GameDetails_patchNormal
nop
// HALO GAME
setreg a1, :GameDetails_halo_string
beq zero, zero, :GameDetails_end
nop

GameDetails_patchNormal:
// PATCH GAME
setreg a1, :GameDetails_patch_string

// restore registers
GameDetails_end:
lw t0, $0000(sp)
lw ra, $0004(sp)
j $003631C0
addiu sp, sp, $10









/*

// patched_game_BOOL
address $000f71B0
patched_game_BOOL:
// custom_game_BOOL
address $000f71B4
custom_game_BOOL:
// halo_game_BOOL
address $000f71B8
halo_game_BOOL:
// widescreen_game_BOOL
address $000f71BC
widescreen_game_BOOL:
// PATCH MENU BACKGROUND ENABLED BOOL
address $000f71C0
patchMenuEnable_BOOL:
hexcode $0
// legacy patch BOOL
address $000f71C4
legacyPatch_BOOL:
*/





