

// get bullet damage hook
//address $202BBD38
//jal :FNC_oneShotKillCheck


//address $200a2000

// DEBUG output of damage given to player
// t0 = weapon ID
//-- add checks to exclude high powered weapons: AT4, RPG, snipers

oneShotKillCheck__damagePrint_remote:
nop
// remote client check
FNC_oneShotKillCheck_remotePlayer:
addiu sp, sp, $fff0
sw ra, $0000(sp)

// debug output of damage given to player
setreg t3, :oneShotKillCheck__damagePrint_remote
swc1 $f21, $0000(t3)

// check if AT4 = B9 [AT4 and RPG rounds hitting player = 255 damage]
addiu t4, zero, $B9
beq t0, t4, :oneShotKillCheck_remote_end
nop
// check if RPG = 92, BA
addiu t4, zero, $92
beq t0, t4, :oneShotKillCheck_remote_end
nop
addiu t4, zero, $BA
beq t0, t4, :oneShotKillCheck_remote_end
nop

// $f21 = damage given to the client by the shooter
// a0 = damage recipient pptr, a3 = shooter pptr

// --- Set max value allowed for damage
// 150.0 damage (126.0 seems to be the most a sniper can do, use 150 in case of unknown value.
lui t3, $4316
mtc1 $f2, t3
// check if damage < max damage
c.le.s $f21, $f2
// if damage >= 150.0 then jump to label
bc1f :oneShotKillCheck__boot_player
nop

oneShotKillCheck_remote_end:
// original code
lw ra, $0000(sp)
j $005A1B70
addiu sp, sp, $10









// DEBUG output of damage given to player
oneShotKillCheck__damagePrint:
nop
// client check
FNC_oneShotKillCheck:
addiu sp, sp, $fff0
sw ra, $0000(sp)
// debug output of damage given to player
setreg t3, :oneShotKillCheck__damagePrint
swc1 $f12, $0000(t3)

// check if AT4 = B9
addiu t4, zero, $B9
beq t0, t4, :oneShotKillCheck_client_end
nop
// check if RPG = 92, BA
addiu t4, zero, $92
beq t0, t4, :oneShotKillCheck_client_end
nop
addiu t4, zero, $BA
beq t0, t4, :oneShotKillCheck_client_end
nop

// $f12 = damage given to the client by the shooter
// a0 = damage recipient pptr, a3 = shooter pptr

// --- Set max value allowed for damage
// 150.0 damage (126.0 seems to be the most a sniper can do, use 150 in case of unknown value.
lui t3, $4316
mtc1 $f2, t3
// check if damage < max damage
c.le.s $f12, $f2
// if damage >= 150.0 then jump to label
bc1f :oneShotKillCheck__boot_player
nop

oneShotKillCheck_client_end:
// original code
lw ra, $0000(sp)
j $005A1B80
addiu sp, sp, $10












// KICK PLAYER for one shot kill and do not count damage against client  [ will still kill remote players ]
oneShotKillCheck__boot_player:
// get my player ID
//lhu a0, $0004(a0)
//jal :oneShotKillCheck__kick_player_packet_FNC
// get player ID of player using 1 shot kill
//lhu a1, $0004(a3)

// create string with player name: " player_name removed for cheating "
setreg a0, :oneShotKillCheck__kickMessageComplete
// zero oneShotKillCheck__kickMessageComplete
sq zero, $0000(a0)
sq zero, $0010(a0)
sq zero, $0020(a0)
sq zero, $0030(a0)
// continue to create string
setreg a1, :oneShotKillCheck__kickMessage
lw a2, $0014(a3) // get player name pointer
jal $001988D0 //sprintf
nop
// PRINT message for client if player is kicked
mtc1 zero, $f12
setreg a0, $004366A0
setreg a1, :oneShotKillCheck__kickMessageComplete // message pointer
addiu a2, zero, $1 // message color
daddu a3, zero, zero
jal $002b6530
daddu t0, zero, zero

lw ra, $0000(sp)
jr ra
addiu sp, sp, $10


// player kicked message
oneShotKillCheck__kickMessage:
print "%s detected using 1 shot kill"
nop
// player kicked message combined with player name -- allow space below for string
oneShotKillCheck__kickMessageComplete:
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

// copied vote packet
oneShotKillCheck__kick_player_packet_FNC:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sw a1, $0004(sp)
sw a3, $0008(sp)
sh a0, $001C(sp)
sb a2, $001E(sp)
jal $002BD4D0
daddu a0, a1, zero
beq v0, zero, :oneShotKillCheck__kick_player__END
nop

lui at, $0044
lui a0, $0046
addiu t0, zero, $1 // packet type to boot
addiu a0, a0, $A0C0
lw a3, $0FC8(v0)
addiu a1, zero, $0040
addiu t1, zero, $0004
addiu t2, sp, $001C
lui at, $0046
lw a2, $A1B4(at)
jal $0030CEF0
addiu t3, zero, $0001
nop

oneShotKillCheck__kick_player__END:
lw ra, $0000(sp)
lw a1, $0004(sp)
lw a3, $0008(sp)
lh a0, $001C(sp)
lb a2, $001E(sp)
jr ra
addiu sp, sp, $20




