
// force join as spectator
// 006954A0 00010001

/*

// in game hook to check for halo mode
address $005B0B9C
j :SPECTAGS__spectator_tags_check

address $00226F00
jal :SPECTAGS__tags_fnc
*/

//address $000AB000
SPECTAGS__spectator_tags_check:

// check if patched game
setreg t1, :patched_game_BOOL
lw t1, $0000(t1)
beq t1, zero, :SPECTAGS__regular_game
nop

// check if spectator
// get player team
// 00441470
lui t0, $0044
lw t0, $1470(t0)
setreg t1, $00010000
beq t0, t1, :SPECTAGS__patched_game
nop
// get spec bool
lui t0, $0069
lh t0, $54A0(t0)
bne t0, zero, :SPECTAGS__patched_game
nop

// ELSE REGULAR GAME

SPECTAGS__regular_game:
// set player tags to normal

// main tags
lui t0, $0022
setreg t1, $10400146
sw t1, $6B34(t0)

// enemy tags
lui t0, $0022
setreg t1, $10600137
sw t1, $6B70(t0)

// enable camera shake for spectators
lui t0, $002A
setreg t1, $10600034
sw t1, $9614(t0)


beq zero, zero, :SPECTAGS__end
nop

SPECTAGS__patched_game:
// main tags
lui t0, $0022
sw zero, $6B34(t0)

// enemy tags
lui t0, $0022
sw zero, $6B70(t0)

// disable camera shake for spectators
lui t0, $002A
setreg t1, $10000034
sw t1, $9614(t0)




SPECTAGS__end:
jr ra
nop

SPECTAGS__tags_fnc:

addiu sp, sp, $ff30
sd ra, $0000(sp)
sq t0, $0010(sp)
sq t1, $0020(sp)
sq t2, $0030(sp)
// s0 = text stack start
// ---- 60 = start RGBA
// s3 = player pointer
// ---- C8 = team ID

// 40000001 = seal
// 80000100 = terr
// c0020000 = hostage
// 40020000 = vip
// 40000020 = offline terrorists
// 00010000 = spectator

// check if patched game
setreg t1, :patched_game_BOOL
lw t1, $0000(t1)
beq t1, zero, :SPECTAGS__skip
nop

// ---- check if spectator
// get player team
lui t0, $0044
lw t0, $1470(t0)
setreg t1, $00010000
bne t0, t1, :SPECTAGS__skip
nop
// get spec bool
lui t0, $0069
lh t0, $54A0(t0)
beq t0, zero, :SPECTAGS__skip
nop

// ------------------- is spectator in patched game
// check team ID if SEAL
lw t0, $00C8(s3)
setreg t1, $40000001
beq t0, t1, :END
nop

// check team ID if TERRORIST
lw t0, $00C8(s3)
setreg t1, $80000100
bne t0, t1, :END
nop

// IS TERRORIST [ RED ]
// Red
lui t0, $4364
sw t0, $0060(s0)
// Green
lui t0, $41C8
sw t0, $0064(s0)
// Blue
lui t0, $41C8
sw t0, $0068(s0)
// Opacity
lui t0, $42C8
sw t0, $006C(s0)
beq zero, zero, :SPECTAGS__skip
nop

END:
// IS SEAL or hostage [ WHITE ]
// Red
lui t0, $437F
sw t0, $0060(s0)
// Green
lui t0, $437F
sw t0, $0064(s0)
// Blue
lui t0, $437F
sw t0, $0068(s0)
// Opacity
lui t0, $42C8
sw t0, $006C(s0)

SPECTAGS__skip:
lq t0, $0010(sp)
lq t1, $0020(sp)
lq t2, $0030(sp)

// original code
jalr t9
nop

ld ra, $0000(sp)
jr ra
addiu sp, sp, $00d0




// testing

// patched_game_BOOL
//address $000f71B0
//patched_game_BOOL:












