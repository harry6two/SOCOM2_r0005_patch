


// s4 = Receiving packet size + 2
// example: vote packet size = 4, so s4 should = 6





// hook: 0063CAC4
//address $0063CAC4
//jal :__anti_boot_FNC


//address $000A0200

antiBoot_voteDEBUG:
nop
antiBoot_damageDEBUG:
nop

__anti_boot_FNC:
addiu sp, sp, $ffd0
sw ra, $0000(sp)
sw t0, $0004(sp)
sw t1, $0008(sp)
sw t2, $000c(sp)
sw t3, $0010(sp)
sw a0, $0014(sp)
sw a1, $0018(sp)
sw a2, $001c(sp)
sw a3, $0020(sp)



//------------------- GET VOTE = 6
setreg t0, $002BA040
// check if vote packet
bne v0, t0, :__anti_boot_end
nop
// store packet size
setreg t0, :antiBoot_voteDEBUG
sw s4, $0000(t0)
// compare size
addiu t1, zero, $6
// if packet size != to t1 kick player
bne s4, t1, :__anti_boot_kickPlayer
nop
// else, end
beq zero, zero, :__anti_boot_end
nop




__anti_boot_kickPlayer:
// check if player has pptr -- needed in case packet is sent in lobby
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__antiBoot_kickPlayer_end
nop

// move (s4 - 2) into v0 so packet receiver doesn't fail
addiu v0, s4, $fffe
sw v0, $0024(sp) // put v0 on stack

// get player pointer, return pptr in v0
lui a0, $00E3
jal $002BD4D0
lhu a0, $AF54(a0)
beq v0, zero, :__antiBoot_kickPlayer_end
nop

// print message of player being kicked
// create string with player name: " player_name removed for cheating "
setreg a0, :__antiBoot_kickMessageComplete
setreg a1, :__antiBoot_kickMessage
lw a2, $0014(v0) // get player name pointer
jal $001988D0 //sprintf
nop
// PRINT message for client if player is kicked
mtc1 zero, $f12
setreg a0, $004366A0
setreg a1, :__antiBoot_kickMessageComplete // message pointer
addiu a2, zero, $1 // message color
daddu a3, zero, zero
jal $002b6530
daddu t0, zero, zero

// percentage of voters > 50%, kick player
// get my ID
lui a0, $0044
lw a0, $0C38(a0)
lhu a0, $0004(a0)
// get player to vote ID
lui a1, $00E3
lhu a1, $AF54(a1)
jal :anti_boot_kickPlayer_packet_FNC // disabled for testing
// 1 = remove, 0 retain (probably doesn't matter)
addiu a2, zero, $1

__antiBoot_kickPlayer_end:
// restore v0
lw v0, $0024(sp)
// return without running packet to avoid freeze
lw ra, $0000(sp)
lw t0, $0004(sp)
lw t1, $0008(sp)
lw t2, $000c(sp)
lw t3, $0010(sp)
lw a0, $0014(sp)
lw a1, $0018(sp)
lw a2, $001c(sp)
lw a3, $0020(sp)
jr ra
addiu sp, sp, $30

__anti_boot_end:
lw ra, $0000(sp)
lw t0, $0004(sp)
lw t1, $0008(sp)
lw t2, $000c(sp)
lw t3, $0010(sp)
lw a0, $0014(sp)
lw a1, $0018(sp)
lw a2, $001c(sp)
lw a3, $0020(sp)
// original code
jr v0
addiu sp, sp, $30





// copied vote packet
anti_boot_kickPlayer_packet_FNC:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sh a0, $001C(sp)
sb a2, $001E(sp)
jal $002BD4D0
daddu a0, a1, zero
beq v0, zero, :anti_boot_kickPlayer_packet_FNC__END
nop

lui at, $0044
lui a0, $0046
// packet ID
addiu t0, zero, $ff // packet type to boot
addiu a0, a0, $A0C0
lw a3, $0FC8(v0)
addiu a1, zero, $0040
// packet size
addiu t1, zero, $0002
addiu t2, sp, $001C
lui at, $0046
lw a2, $A1B4(at)
jal $0030CEF0
addiu t3, zero, $0001
nop

anti_boot_kickPlayer_packet_FNC__END:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $20

__antiBoot_kickMessage:
print "%s attempted to boot you"
nop

__antiBoot_kickMessageComplete:
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
























