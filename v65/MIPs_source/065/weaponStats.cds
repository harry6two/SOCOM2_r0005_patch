


// load weapon ammo capacity 
//address $003D2810
//j :weaponStats_FNC
//nop





//address $000A0000

weaponStats_FNC:
// check if SGL game
setreg t0, :sgl_game_BOOL
lbu t0, $0000(t0)
beq t0, zero, :weaponStats_nonSGLgame
nop

// get weapon ID
lbu v1, $007C(a0)

// iw80a2 
addiu t0, zero, $40 // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// m14
addiu t0, zero, $3c // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// m60e3
addiu t0, zero, $5b // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// m63a:
addiu t0, zero, $5c // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// pmn:
addiu t0, zero, $9E // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// claymore:
addiu t0, zero, $99 // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// at4: 
addiu t0, zero, $91 // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// at4 heat
addiu t0, zero, $b9 // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// rpg: 
addiu t0, zero, $92 // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// rpg round:
addiu t0, zero, $ba // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// M79 frag
addiu t0, zero, $8f // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// M79 HE
addiu t0, zero, $b0 // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// MGL frag
addiu t0, zero, $8e // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// M203 frag
addiu t0, zero, $af // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero
// M203 he
addiu t0, zero, $ab // weapon ID
beq v1, t0, :weaponStats_end
daddu v0, zero, zero

// ELSE, load regular ammo count


// NON SGL GAME, LOAD NORMAL AMMO COUNT
weaponStats_nonSGLgame:
// original code
lw v0, $0028(a0)
weaponStats_end:
jr ra
nop

//sgl_game_BOOL:
//hexcode $1