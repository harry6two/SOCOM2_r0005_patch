


// main fnc
__all_maps_respawn:

// mp allow respawn 00695450

//check if game is respawn
setreg t0, $00695450
lh t0, $0000(t0)
beq t0, zero :RESPAWN__normal_game
nop

// GAME IS RESPAWN

// game type respawn
setreg t3, $002c8ab0
setreg t4, $24100005
sw t4, $0000(t3)

// check if in game
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :RESPAWN__end
nop

// mission complete & mission failure
setreg t1, $00694d48
setreg t2, $00694D70
sh zero, $0000(t1)
sh zero, $0000(t2)

// check if game time = 0
lui t0, $0043
// game stats pointer
lw t0, $7CE8(t0)
// offset to game time address
lw t0, $00EC(t0)
bne t0, zero :RESPAWN__end
nop

// stored in to mission complete to end the game
addiu t0, zero, $1

// end game
sh t0, $0000(t1)
sh t0, $0000(t2)
beq zero, zero :RESPAWN__end
nop

RESPAWN__normal_game:
// game type normal
setreg t3, $002c8ab0
setreg t4, $81100014
sw t4, $0000(t3)

// GAME IS NOT RESPAWN
RESPAWN__end:
jr ra
nop