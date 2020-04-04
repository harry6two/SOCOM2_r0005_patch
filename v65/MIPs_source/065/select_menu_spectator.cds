

/*
// KDR hook
address $0022A6E8
jal :__setup_KDR
nop
nop
nop
nop

// KDR string hook
address $00229EDC
jal :__setup_KDR_string


// HEALTH string
//address $003E5790
//print "HEALTH"
address $00229F58
jal :__setup_HEALTH_string

// health hook
address $0022A7A8
jal :__set_health
nop
nop
nop
*/



// address $000DBC00

__setup_KDR:
// create stack to store a3 for later
addiu sp, sp, $ffe0
// original code
addu a3, s2, a2
addu a2, v1, v0
sw a3, $0000(sp)
sw ra, $0004(sp)

// check if patch game
setreg t5,:patched_game_BOOL
lw t5, $0000(t5)
// branch if not patched
beq t5, zero, :__select_isNOTpatchGAME_KDR
nop

// check if plr is spectator
lui t5, $0069
lbu t5, $54A0(t5)
// branch if not spectator
beq t5, zero, :__select_isNOTpatchGAME_KDR
nop


__select_isPATCHgame_KDR:
// set KDR string "%d / %d"
setreg a1, :__KDR_string
// add total deaths and current deaths together
lhu v0, $0012(s4)
lhu v1, $005A(s4)
beq zero, zero, :__select_KDR_sprintf
addu a3, v1, v0 // add deaths together
// s4: offset 5A contains # deaths
//lbu a3, $005A(s4)


__select_isNOTpatchGAME_KDR:
setreg a1, :__KILLS_string


__select_KDR_sprintf:
jal $001988D0 // sprintf
nop

lw a3, $0000(sp)
lw ra, $0004(sp)
// original code
addiu s0, a3, $0080
// pop stack
jr ra
addiu sp, sp, $20


__setup_KDR_string:
// check if patch game
setreg t5,:patched_game_BOOL
lw t5, $0000(t5)
// branch if not patched
beq t5, zero, :__select_isNOTpatchGAME_KDRtext
nop

// check if plr is spectator
lui t5, $0069
lbu t5, $54A0(t5)
// branch if not spectator
beq t5, zero, :__select_isNOTpatchGAME_KDRtext
nop

// set KDR text
setreg a1, :__KDR_string_text
beq zero, zero, :__select_KDRtext_end
nop

__select_isNOTpatchGAME_KDRtext:
setreg a1, :__KILLS_string_text

__select_KDRtext_end:
jr ra
nop




__setup_HEALTH_string:
// check if patch game
setreg t5,:patched_game_BOOL
lw t5, $0000(t5)
// branch if not patched
beq t5, zero, :__select_isNOTpatchGAME_HEALTHtext
nop

// check if plr is spectator
lui t5, $0069
lbu t5, $54A0(t5)
// branch if not spectator
beq t5, zero, :__select_isNOTpatchGAME_HEALTHtext
nop

// set HEALTH text
setreg a1, :__HEALTH_string_text
beq zero, zero, :__select_HEALTHtext_end
nop

__select_isNOTpatchGAME_HEALTHtext:
setreg a1, :__DEATHS_string_text

__select_HEALTHtext_end:
jr ra
nop




__set_health:
// create stack to store a3 for later
addiu sp, sp, $ffe0
// original code
addu a3, s2, a2
addu a2, v1, v0
sw a3, $0000(sp)
sw ra, $0004(sp)

// check if patch game
setreg t5,:patched_game_BOOL
lw t5, $0000(t5)
// branch if not patched
beq t5, zero, :__select_isNOTpatchGAME_HEALTH
nop

// check if plr is spectator
lui t5, $0069
lbu t5, $54A0(t5)
// branch if not spectator
beq t5, zero, :__select_isNOTpatchGAME_HEALTH
nop

__select_isPATCHgame_HEALTH:

// set HEALTH ptr
setreg a1, :__health_string
// get player health
lwc1 $f0, $0B00(s4)
lui t0, $42C8
mtc1 $f1, t0
mul.s $f0, $f0, $f1
cvt.w.s $f0, $f0
mfc1 a2, $f0
beq zero, zero, :__select_HEALTH_sprintf
nop

__select_isNOTpatchGAME_HEALTH:
setreg a1, :__DEATHS_string

__select_HEALTH_sprintf:

jal $001988D0 // sprintf
nop

lw a3, $0000(sp)
lw ra, $0004(sp)
// original code
addiu s0, a3, $0080
// pop stack
jr ra
addiu sp, sp, $20


__health_string:
print "%d%%"
nop

__KDR_string:
print "%d / %d"
nop

__KDR_string_text:
print "KDR"
nop

__KILLS_string:
print "%d"
nop

__KILLS_string_text:
print "KILLS"
nop

__DEATHS_string:
print "%d"
nop

__DEATHS_string_text:
print "DEATHS"
nop

__HEALTH_string_text:
print "HEALTH"
nop

// testing only

//address $000f71B0
//patched_game_BOOL:










