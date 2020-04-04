



//------ Reset timer on round start/end
__hostScanner_resetVariables_FNC:
// reset firstScanPass -- needed so first scan doesnt boot everyone
setreg t0, :__hostScanner_firstScanPass
sw zero, $0000(t0)

// reset timer
setreg t0, :__hostScanner__timer
jr ra
sw zero, $0000(t0)
//---------------------------------



//--------------- Host scanner setup
//
// Checks timer so function does not flood network with packets.
//
// Once timer resets scan the current function from the stack and generate a hash.
//
// Send function to scan and key to clients. Clients will send a hash back in a different function.
//
// Compare the client and host hash. If client is different remove client.
//
// Retrieve client IDs from a stack that is created by the hostScanner client response function.
// -- The clients in this list responded with the correct checksum. Remove those not present 
//    in the list.
// -- Clear this client response list at end of function.
// -- Do not check list on round complete.
//
// If host kicks all players then host is cheating.

__hostScanner__timer:
nop
nop
__hostScanner__function_to_checksum:
nop
nop
__hostScanner_main_ID_debug:
nop
nop
__hostScanner__defaultKey:
hexcode $0AF4943E
nop
__hostScanner__editedKey:
nop
nop
__hostScanner__checksumResult:
nop
nop
__hostScanner_firstScanPass:
nop
nop
__hostScanner_kickMessageComplete:
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

__hostScanner_kickMessage:
print "%s removed from game"
nop



__hostScanner_strcpy:
// a0 - string to copy
// a1 - destination
hostScanner_strcpy_next:
// get string byte
lbu t6, $0000(a0)
beq t6, zero, :hostScanner_strcpy_end
nop
// copy string byte
sb t6, $0000(a1)
// increment string and destination
addiu a0, a0, $1
beq zero, zero, :hostScanner_strcpy_next
addiu a1, a1, $1

hostScanner_strcpy_end:
jr ra
nop


__hostScanner_strcmp:
// v0 = 1 if strings are the same, 0 if different
// a0 = string 
// a1 = string to be compared

__hostScanner_strcmp_nextByte:
// get by from first string
lbu t6, $0000(a0)
// check if end of string
beq t6, zero, :__hostScanner_strcmp_endOfString
nop
// get byte from 2nd string
lbu t7, $0000(a1)

// increment 1st string
addiu a0, a0, $1
beq t6, t7, :__hostScanner_strcmp_nextByte
// increment 2nd string
addiu a1, a1, $1

// ELSE string is not the same, return v0 = 0
beq zero, zero, :__hostScanner_strcmp_end
daddu v0, zero, zero

__hostScanner_strcmp_endOfString:
// string matches second string, return v0 = 1
addiu v0, zero, $1
__hostScanner_strcmp_end:
jr ra
nop



// hook: 002BC6DC
__hostScanner_checkPlayerJoining_FNC:
addiu sp, sp, $ffc0
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)
sw s2, $000c(sp)
sw s3, $0010(sp)
sw s4, $0014(sp)
sw s5, $0018(sp)
sw s6, $001c(sp)
sw s7, $0020(sp)
sw a0, $0024(sp)
sw a1, $0028(sp)
sw a2, $002c(sp)
sw a3, $0030(sp)
sw t0, $0034(sp)

// t0 = player IP string pointer, move to s0
daddu s0, t0, zero
// check if player IP is on banned list, if so jump to: 002BCFE8
setreg s1, :__hostScanner_bannedPlayers

checkPlayerJoining_nextIP:
// check if IP is empty, if so end of stack and player is not banned
lw s2, $0000(s1)
beq s2, zero, :__hostScanner_checkPlayerJoining_continue
nop

// compare player IP joining against banned players
daddu a0, s0, zero
jal :__hostScanner_strcmp
daddu a1, s1, zero
// if v0 = 0 then check next banned IP. if v0 = 1 then reject player
beq v0, zero, :checkPlayerJoining_nextIP
// increase banned IP stack
addiu s1, s1, $10 // 16 bytes or 4 lines

__hostScanner_checkPlayerJoining_playerIsBanned:
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $000c(sp)
lw s3, $0010(sp)
lw s4, $0014(sp)
lw s5, $0018(sp)
lw s6, $001c(sp)
lw s7, $0020(sp)
lw a0, $0024(sp)
lw a1, $0028(sp)
lw a2, $002c(sp)
lw a3, $0030(sp)
lw t0, $0034(sp)
j $002BCFE8
addiu sp, sp, $40

__hostScanner_checkPlayerJoining_continue:
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $000c(sp)
lw s3, $0010(sp)
lw s4, $0014(sp)
lw s5, $0018(sp)
lw s6, $001c(sp)
lw s7, $0020(sp)
lw a0, $0024(sp)
lw a1, $0028(sp)
lw a2, $002c(sp)
lw a3, $0030(sp)
lw t0, $0034(sp)
addiu sp, sp, $40

// original code check
beq s1, zero, :checkPlayerJoining_s1_equalZero
nop
// s1 != 0
j $002BC6E4
nop
// s1 = 0
checkPlayerJoining_s1_equalZero:
j $002BCFE8
nop



// leave 20 slots for banned IPs -- will most likely never use more than 1 slot
__hostScanner_bannedPlayers:
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
nop
nop
nop
nop
nop
nop
nop
nop

__hostScanner_bannedPlayers_end:
nop
nop
nop
nop


__hostScanner_main_FNC:
addiu sp, sp, $ffc0
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)
sw s2, $000c(sp)
sw s3, $0010(sp)
sw s4, $0014(sp)
sw s5, $0018(sp)
sw s6, $001c(sp)
sw s7, $0020(sp)


// write packet pointers
lui t0, $00E3
setreg t1, :__hostScanner__packetRecieve_FNC
sw t1, $9FC0(t0)
setreg t1, :__hostScanner__checksumPacketRecieve_FNC
sw t1, $9FC4(t0)
setreg t1, :__hostScanner__removePlayerPacketReceive_FNC
sw t1, $9FC8(t0)

//----------------------------------- Initial check to see if player should run function
// -- check if legacy patch game, if true skip function
setreg t0, :legacyPatch_BOOL
lbu t0, $0000(t0)
bne t0, zero, :__hostScanner__clearPlayerIDs
nop
// -- check if patch game
setreg t0, :patched_game_BOOL
lbu t0, $0000(t0)
beq t0, zero, :__hostScanner__clearPlayerIDs
nop
// check if player is loaded in game
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__hostScanner__clearPlayerIDs
nop
// check if end of round
lui t0, $0069
lhu t1, $4d48(t0)
bne t1, zero, :__hostScanner__clearPlayerIDs
nop
lhu t1, $4d70(t0)
bne t1, zero, :__hostScanner__clearPlayerIDs
nop
// check if player is host, if not SKIP function
// If player is NOT host go to client section of function and check if there is a function
// to scan.
lui t0, $0046
lbu t0, $A0C0(t0)
beq t0, zero, :__hostScanner__clientSetup
nop

// Timer
setreg s0, :__hostScanner__timer
// get time
lw t0, $0000(s0)

// check if first scan
setreg t1, :__hostScanner_firstScanPass
lbu t1, $0000(t1)
beq t1, zero, :__hostScanner_firstScanPass_false
// max timer for first scan, set it higher to let all players load in
addiu t1, zero $1A0 // 15 seconds
// max timer
addiu t1, zero $A0 // 5 seconds
__hostScanner_firstScanPass_false:
bne t0, t1, :__hostScanner__timer_increment
nop
// ELSE, reset timer
sw zero, $0000(s0)
//-----------------------------------




//----------------------------------- Check if client stack is populated
// check firstScanPass -- Needed for first scan. first scan can boot all players as no IDs exist
//                        at this point.
setreg s1, :__hostScanner_firstScanPass
lbu t0, $0000(s1)
beq t0, zero, :__hostScanner_playerID_listCheckEnd
nop

// -- player join count -- get seal and terr player count
// seal count
lui t0, $0044
lbu t1, $1448(t0)
// terr count
lbu t2, $1450(t0)
// add player counts
addu t2, t2, t1

// var t1 = 1
addiu t1, zero, $1
// sub 1 from player count, if result = 0 then host is alone
subu t0, t2, t1
beq t0, zero, :__hostScanner_playerID_listCheckEnd
nop


// -- check if white list stack is 0, if so host may be lagging, end check to avoid room boot
// -- doing this means the host can cheat
setreg t0, :__hostScanner__playerIDs
// get whitelist playerID
lhu t0, $0000(t0)
// check if zero, if zero then it is the end of the activePlayerID stack
beq t0, zero, :__hostScanner_playerID_listCheckEnd
nop


// activePlayer stack
setreg t0, :__hostScanner__activePlayerIDs

__hostScanner__activePlayerID_nextID:
// get activePlayerID
lhu t1, $0000(t0)
// check if zero, if zero then it is the end of the activePlayerID stack
beq t1, zero, :__hostScanner_playerID_listCheckEnd
nop

// compare activePlayer ID against white listed IDs
// whitelist player IDS
setreg t2, :__hostScanner__playerIDs

__hostScanner__whiteListPlayerID_nextID:
// get ID from whiteList
lhu t3, $0000(t2)
// if ID from whitelist = 0 then a matching ID was not found, remove player
beq t3, zero, :__hostScanner_playerID_removePlayerSession
nop
// check if activePlayerID = whiteListID. If so continue to next active player
beq t1, t3, :__hostScanner_playerID_listCheck_playerIsLegit
nop
// else, get next whiteListPlayerID and continue check
beq zero, zero, :__hostScanner__whiteListPlayerID_nextID
// increment whiteListPlayerID
addiu t2, t2, $4



// ---------------- REMOVE PLAYER FROM GAME

__hostScanner_playerID_removePlayerSession:
// store registers
sw t0, $0024(sp)
sw t1, $0028(sp)
sw t2, $002c(sp)
sw t3, $0030(sp)
sw t4, $0034(sp)


// debug output for player ID if caught
setreg t5, :__hostScanner_main_ID_debug
sh t1, $0000(t5)

// get player pointer, return pptr in v0
jal $002BD4D0
daddu a0, t1, zero
beq v0, zero, :removePlayer_restoreRegisters
nop
// move result to stack
sw v0, $0038(sp)




//--------------- GET IP ADDRESS FROM SUSPECT PLAYER
// get IP from suspect player -- v0 = pptr
// persona ptr stack
setreg t2, $004414C4
// set end of persona stack
setreg t3, $0044157C
// IP stack -- count by 4s to go to next pointer
setreg t5, $00E45AF0

// check if end of stack
personaStack_nextPosition:
// restore result from stack
lw v0, $0038(sp)
beq t2, t3, :___bannedPlayersList_continue // if unable to find player then continue to remove them
nop
// load persona ptr
lw t4, $0000(t2)
// increment persona stack
addiu t2, t2, $8
// check if pointer exists
bne t4, zero, :personaStack_checkPersona
nop
// ELSE, loop
beq zero, zero, :personaStack_nextPosition
// increment counter
addiu t5, t5, $4

personaStack_checkPersona:
// check if persona name matches pptr name -- if so copy
// persona name string
addiu a0, t4, $e
jal :__hostScanner_strcmp
// get pptr name string
lw a1, $0014(v0)
// if v0 = 1 then persona name equals pptr name
bne v0, zero, :personaStack_personaDoesMatch
nop
// ELSE, loop
beq zero, zero, :personaStack_nextPosition
// increment counter
addiu t5, t5, $4

personaStack_personaDoesMatch:
// load IP pointer from IP stack position based on persona stack position
lw t5, $0000(t5)
// check IP exists
beq t5, zero, :___bannedPlayersList_continue
nop



//--------------- COPY PLAYER IP TO BANNED PLAYER IP LIST
// find open spot in list
setreg t0, :__hostScanner_bannedPlayers
__bannedPlayersList_checkNextSlot:
// check if slot is empty
lw t2, $0000(t0)
beq t2, zero, :__addPlayer_bannedPlayersList
nop

// ELSE, next slot
beq zero, zero, :__bannedPlayersList_checkNextSlot
addiu t0, t0, $10 // 16 bytes or 4 lines

__addPlayer_bannedPlayersList:
// player IP -- t5 contains IP pointer
daddu a0, t5, zero
jal :__hostScanner_strcpy
// destination
daddu a1, t0, zero

___bannedPlayersList_continue:
// restore result from stack
lw v0, $0038(sp)

// create string with player name: " player_name removed from game "
setreg a0, :__hostScanner_kickMessageComplete
// clear complete message
sq zero, $0000(a0)
sq zero, $0010(a0)
sq zero, $0020(a0)
sq zero, $0030(a0)
sq zero, $0040(a0)

setreg a1, :__hostScanner_kickMessage
lw a2, $0014(v0) // get player name pointer
jal $001988D0 //sprintf
nop
// PRINT message for client if player is kicked
mtc1 zero, $f12
setreg a0, $004366A0
setreg a1, :__hostScanner_kickMessageComplete // message pointer
addiu a2, zero, $1 // message color
daddu a3, zero, zero
jal $002b6530
daddu t0, zero, zero









//---------------------------------------------------- REMOVE PLAYER pt.1
// Tell all active players to remove suspect
// restore player ID
lhu t1, $0028(sp) // player ID

// get active client list
setreg t0, :__hostScanner__activePlayerIDs

removePlayer_nextPlayerID:
// get activePlayerID
lhu t2, $0000(t0)
// check if activePlayer is player being removed -- disable so detected player removes theirself via session removal
//beq t2, t1, :removePlayer_incrementActiveID
//nop
// check if activePlayerID is zero
beq t2, zero, :removePlayer_end
nop

// player ID to send packet to 
daddu a1, t2, zero
// player ID to remove
daddu a2, t1, zero
jal :__hostScanner__removePlayerPacket_FNC
nop

removePlayer_incrementActiveID:
beq zero, zero, :removePlayer_nextPlayerID
//increment activePlayerID
addiu t0, t0, $4

removePlayer_end:
// restore registers
lw t1, $0028(sp) // player ID


//---------------------------------------------------- REMOVE PLAYER pt.2
// Send boot packet to suspect player

// my player ID
lui a0, $0044
lw a0, $0C38(a0)
lhu a0, $0004(a0)
// suspect player ID
daddu a1, t1, zero
jal :__hostScanner__bootPlayerPacket_FNC // -- disable for test
nop

// get player ID
lw a0, $0028(sp) // player ID
// remove player from session
jal $006161D0
nop

removePlayer_restoreRegisters:
// restore registers
lw t0, $0024(sp)
lw t1, $0028(sp)
lw t2, $002c(sp)
lw t3, $0030(sp)
lw t4, $0034(sp)

// ---------------------------------------



__hostScanner_playerID_listCheck_playerIsLegit:
// increment activePlayerIDs stack
addiu t0, t0, $4
beq zero, zero, :__hostScanner__activePlayerID_nextID
nop

__hostScanner_playerID_listCheckEnd:
// clear player IDs 
setreg t0, :__hostScanner__playerIDs
sq zero, $0000(t0)
sq zero, $0010(t0)
sq zero, $0020(t0)
sq zero, $0030(t0)
sq zero, $0040(t0)
sq zero, $0050(t0)
sq zero, $0060(t0)
sq zero, $0070(t0)
sq zero, $0080(t0)
sq zero, $0090(t0)
sq zero, $00a0(t0)
// enable firstScanPass
addiu t0, zero, $1
sb t0, $0000(s1)

//-----------------------------------



//----------------------------------- Create activePlayerIDs Stack

// activePlayer stack
setreg t0, :__hostScanner__activePlayerIDs
// clear old activePlayer stack
sq zero, $0000(t0)
sq zero, $0010(t0)
sq zero, $0020(t0)
sq zero, $0030(t0)
sq zero, $0040(t0)
sq zero, $0050(t0)
sq zero, $0060(t0)
sq zero, $0070(t0)
sq zero, $0080(t0)
sq zero, $0090(t0)
sq zero, $00a0(t0)

// get ppointers stack (there will always be at least 1 pptr if in game)
setreg t1, $004362E4
// get first stack position
lw t2, $0000(t1)

__hostScanner_activePlayers_nextPptrID:
// get pptr from ppointer stack
lw t3, $0008(t2)

// store registers
sw t0, $0024(sp)
sw t1, $0028(sp)
sw t2, $002c(sp)
sw t3, $0030(sp)
sw t4, $0034(sp)

// get player pointer based on player ID, return pptr in v0
jal $002BD4D0
lhu a0, $0004(t3) // get player ID off offset 0x4

// store registers
lw t0, $0024(sp)
lw t1, $0028(sp)
lw t2, $002c(sp)
lw t3, $0030(sp)
lw t4, $0034(sp)
// if v0 = 0 then function did not return player pointer
beq v0, zero, :__hostScanner_activePlayers_nextStackID
nop

// ELSE, v0 = player pointer
// Check if player is VIP or Hostage
// 40000001 = seal
// 80000100 = terr
// c0020000 = hostage
// 40020000 = vip
// 40000020 = offline terrorists
// 00010000 = spectator
// get team ID
lw t4, $00c8(t3)
setreg t5, $c0020000 
// check if hostage
beq t4, t5, :__hostScanner_activePlayers_nextStackID
nop
setreg t5, $40020000
// check if VIP
beq t4, t5, :__hostScanner_activePlayers_nextStackID
nop

__hostScanner_activePlayers_getID:
// get ID from pptr
lhu t4, $0004(t3)
// check if host ID, if so skip to next pptr
lui t5, $0044
lw t5, $0C38(t5)
lhu t5, $0004(t5)
beq t4, t5, :__hostScanner_activePlayers_nextStackID
nop

// store player ID to stack
sh t4, $0000(t0)
// increment activePlayerIDs stack
addiu t0, t0, $4


__hostScanner_activePlayers_nextStackID:
// get next ppointer from stack
lw t2, $0000(t2)
bne t2, t1, :__hostScanner_activePlayers_nextPptrID
nop

//-----------------------------------




//---------------------------------- SETUP function to checksum
// get function to checksum
setreg s1, :__hostScanner_currentFunction
// check if function stack exists, if not reset to first position
lw s2, $0000(s1)
bne s2, zero, :__hostScanner_continue_to_function_load
nop

// ELSE, reset currentFunction stack position
setreg s2, :__hostScanner_functionStack
sw s2, $0000(s1) // store first position in stack to currentFunction variable
// load currentFunction
lw s2, $0000(s1)

__hostScanner_continue_to_function_load:
beq s2, zero, :__hostScanner_functionStack_RESET
nop

// load function out of function stack
lw s3, $0000(s2)
// check if end of function stack
bne s3, zero, :__hostScanner_continue_to_checksum
nop

__hostScanner_functionStack_RESET:
// end of function stack, reset stack
setreg s2, :__hostScanner_functionStack
sw s2, $0000(s1) // store first position in stack to currentFunction variable
// load function out of function stack position
lw s3, $0000(s1)
// load function out of function stack
lw s3, $0000(s3)


__hostScanner_continue_to_checksum:
// increment function stack to next position
addiu s2, s2, $4
sw s2, $0000(s1)
//-----------------------------------


// ---------------------------------- Generate key based on client name and room name
// --- 1 byte from each as each must be 1 byte long
// get client name from pptr
lui t0, $0044
lw t0, $0C38(t0)
lw t0, $0014(t0) // pointer to client name
lbu a0, $0000(t0) // get first byte from player name
// get room name byte
lui t0, $0045
lbu a1, $FE6C(t0) // get first byte from room name
// get default key location
setreg t0, :__hostScanner__defaultKey
// get edited key location
setreg t1, :__hostScanner__editedKey
// first byte from defaultKey, then xor against playerName byte
lbu t3, $0000(t0)
xor t3, t3, a0
sb t3, $0000(t1)
// second byte from defaultKey, then xor against playerName byte
lbu t3, $0001(t0)
xor t3, t3, a0
sb t3, $0001(t1)
// third byte from defaultKey, then xor against roomName byte
lbu t3, $0002(t0)
xor t3, t3, a1
sb t3, $0002(t1)
// fourth byte from defaultKey, then xor against gameTime byte
lui t0, $00C5
lbu t3, $979C(t0)
xor t3, t3, a1
sb t3, $0003(t1)
// get editedKey and save it to the packetData
setreg t0, :__hostScanner__editedKey
lw t0, $0000(t0)
setreg t1, :__hostScanner_packetData
sw t0, $0008(t1)
//-----------------------------------


//----------------------------------- Get checksum from function
// a0 = function to scan
// a1 = key
// v0 = checksum
daddu a0, s3, zero
setreg a1, :__hostScanner__editedKey
lw a1, $0000(a1)
jal :__hostScanner__checksum
nop
// move result of checksum to storage
setreg t0, :__hostScanner__checksumResult
sw v0, $0000(t0)

// save function to __hostScanner__function_to_checksum
setreg t0, :__hostScanner__function_to_checksum
sw s3, $0000(t0)

//----------------------------------- 


//----------------------------------- Send packet to clients
// set packetData location
setreg s4, :__hostScanner_packetData
// get ppointers stack (there will always be at least 1 pptr)
setreg s5, $004362E4
// get first stack position
lw s6, $0000(s5)

__hostScanner_getPlayerPointer:
// get pptr
lw t0, $0008(s6)
// get my pptr
lui t1, $0044
lw t1, $0C38(t1)
// check if this is my pptr
beq t0, t1, :__hostScanner_nextPlayerPointerStack_position
nop

// check if pptr is actually a pptr by checking for a team ID
lw t3, $00C8(t0)
setreg t4, $80000100 // TERR
beq t3, t4, :__hostScanner_PpointerTeamID_continue
nop
setreg t4, $40000001 // SEAL
beq t3, t4, :__hostScanner_PpointerTeamID_continue
nop
setreg t4, $00010000 // SPEC
beq t3, t4, :__hostScanner_PpointerTeamID_continue
nop
// no team ID, not a player
beq zero, zero, :__hostScanner_nextPlayerPointerStack_position
nop

__hostScanner_PpointerTeamID_continue:
// store funciton to checksum into packetData stack
sw s3, $0004(s4)
// a0 = my id
// a1 = receiver id
// get my pptr id and store it in the packetData stack
lui a0, $0044
lw a0, $0C38(a0)
lhu a0, $0004(a0)
sh a0, $0000(s4) // store my ID into the 
// get player ID
lhu a1, $0004(t0)

// send packet to client
jal :__hostScanner__packetSend_FNC
nop


__hostScanner_nextPlayerPointerStack_position:
// get next stack position
lw s6, $0000(s6)
bne s6, s5, :__hostScanner_getPlayerPointer
nop

__hostScanner_endPacketSender:
//-----------------------------------


beq zero, zero, :__hostScanner__end
nop
__hostScanner__timer_increment:
// increment timer by 1 -- timer++;
addiu t0, t0, $1
sw t0, $0000(s0)
beq zero, zero, :__hostScanner__end
nop

__hostScanner__clearPlayerIDs:
// clear player IDs on round end to prevent random removal of players
setreg t0, :__hostScanner__playerIDs
sq zero, $0000(t0)
sq zero, $0010(t0)
sq zero, $0020(t0)
sq zero, $0030(t0)
sq zero, $0040(t0)
sq zero, $0050(t0)
sq zero, $0060(t0)
sq zero, $0070(t0)
sq zero, $0080(t0)
sq zero, $0090(t0)
sq zero, $00a0(t0)
setreg t0, :__hostScanner__activePlayerIDs
sq zero, $0000(t0)
sq zero, $0010(t0)
sq zero, $0020(t0)
sq zero, $0030(t0)
sq zero, $0040(t0)
sq zero, $0050(t0)
sq zero, $0060(t0)
sq zero, $0070(t0)
sq zero, $0080(t0)
sq zero, $0090(t0)
sq zero, $00a0(t0)
// reset timer
setreg s0, :__hostScanner__timer
sw zero, $0000(s0)
// reset firstScanPass
setreg s0, :__hostScanner_firstScanPass
sw zero, $0000(s0)
// jump to end
beq zero, zero, :__hostScanner__end
nop


__hostScanner__clientSetup:
// Client code goes here. Currently unused.


__hostScanner__end:
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $000c(sp)
lw s3, $0010(sp)
lw s4, $0014(sp)
lw s5, $0018(sp)
lw s6, $001c(sp)
lw s7, $0020(sp)
jr ra
addiu sp, sp, $40
nop
nop
nop
nop


// added several extra ID slots as random map assets may make it to this stack
__hostScanner__playerIDs:
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
// added several extra ID slots as random map assets may make it to this stack
__hostScanner__activePlayerIDs:
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


//--------------- Send host scanner packet
__hostScanner__packetSend_FNC:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sh a0, $001C(sp)
sb a2, $001E(sp)
// check if pptr exists based on player ID
jal $002BD4D0
daddu a0, a1, zero
beq v0, zero, :__hostScanner__packetSend__END
nop

lui at, $0044
lui a0, $0046
addiu a0, a0, $A0C0
// packet ID -- 1C is first unused packet ID
addiu t0, zero, $1C 

lw a3, $0FC8(v0)
addiu a1, zero, $0040
addiu t1, zero, $C

// data in packet
setreg t2, :__hostScanner_packetData

lui at, $0046
lw a2, $A1B4(at)
// send packet
jal $0030CEF0
addiu t3, zero, $0001
nop

__hostScanner__packetSend__END:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $20
//----------------







//--------------- Send boot player packet
__hostScanner__bootPlayerPacket_FNC:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sh a0, $001C(sp)
sb a2, $001E(sp)

// check if pptr exists based on player ID
jal $002BD4D0
daddu a0, a1, zero
beq v0, zero, :__hostScanner__bootPlayerPacket__END
nop


lui at, $0044
lui a0, $0046
addiu a0, a0, $A0C0
// packet ID
addiu t0, zero, $ff
lw a3, $0FC8(v0)
addiu a1, zero, $40
// packet size
addiu t1, zero, $1
// data in packet
setreg t2, :__hostScanner_bootPlayerPacket_data
lui at, $0046
lw a2, $A1B4(at)
// send packet
jal $0030CEF0
daddu t3, zero, zero
nop

__hostScanner__bootPlayerPacket__END:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $20

__hostScanner_bootPlayerPacket_data:
hexcode $01010101
nop
// --------------------------------



//--------------- Send host scanner packet
// a1 = id to send to
// a2 = id to kick
__hostScanner__removePlayerPacket_FNC:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sh a0, $001C(sp)
sb a2, $001E(sp)
// xor player ID to kick and store to __hostScanner_removePlayerPacket_data
setreg t0, :__hostScanner_removePlayerPacket_data
addiu t1, zero, $6A14
xor t1, a2, t1 // should be a2
sh t1, $0000(t0)
// check if pptr exists based on player ID
jal $002BD4D0
daddu a0, a1, zero
beq v0, zero, :__hostScanner__removePlayerPacket__END
nop
lui at, $0044
lui a0, $0046
addiu a0, a0, $A0C0
// packet ID 
addiu t0, zero, $1E
lw a3, $0FC8(v0)
addiu a1, zero, $0040
addiu t1, zero, $4
// data in packet
setreg t2, :__hostScanner_removePlayerPacket_data
lui at, $0046
lw a2, $A1B4(at)
// send packet
jal $0030CEF0
addiu t3, zero, $0001
nop
__hostScanner__removePlayerPacket__END:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $20

__hostScanner_removePlayerPacket_data:
nop
nop




__hostScanner__removePlayerPacketReceive_FNC:
addiu sp, sp, $fff0
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)

// check if player is loaded in game
lui s0, $0044
lw s0, $0C38(s0)
beq s0, zero, :__hostScanner__removePlayerPacketReceive_end
nop
// check if player is host, if player is HOST SKIP function
lui t0, $0046
lbu t0, $A0C0(t0)
bne t0, zero, :__hostScanner__removePlayerPacketReceive_end
nop

// packet data address
setreg t0, $00E2AF54
// get encoded player ID and xor it
lhu t1, $0000(t0)
addiu t2, zero, $6A14
xor s1, t1, t2
// move ID to a0
daddu a0, s1, zero
// remove player from session
jal $006161D0
nop

// my player ID
lhu a0, $0004(s0)
// player ID to boot
daddu a1, s1, zero
// check if IDs match, if so force player to abort
bne a0, a1, :removePlayerPacketReceive_bootPlayer
nop

// else, force player abort game
lui t0, $0069
addiu t1, zero, $1
sb, t1, $4DAC(t0)

removePlayerPacketReceive_bootPlayer:
// call bootPlayerPacket
jal :__hostScanner__bootPlayerPacket_FNC
nop

__hostScanner__removePlayerPacketReceive_end:
// packet size
addiu v0, zero, $4
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
jr ra
addiu sp, sp, $10

// --------------------------------




__hostScanner___checksum:
/////////////////////////////////////////////////////////////////
//
// CHECK SUM FNC
//
// a0 = function to scan
// a1 = key
// v0 = checksum

__hostScanner__checksum:

// move args in to temp registers
addu t0, a0, zero // function to check
addu t1, a1, zero // key
setreg t2, $03e00008 // data for JR RA
addu t3, zero, zero // zero calculated checksum register

__hostScanner__next_address:
lw t4, $0000(t0) // get current address data
// xor current address data against key
xor t4, t4, t1

addu t3, t3, t4 // add to checksum
addiu t0, t0, $4 //increment function position
// reload this to get normal data instead of encoded data
lw t4, $0000(t0) // get current address data
beq t4, t2 :__hostScanner__last_address
nop
beq zero, zero :__hostScanner__next_address
nop

__hostScanner__last_address:
// this is needed to grab the address below the jr ra
lw t4, $0000(t0) // get current address data
addu t3, t3, t4 // add to checksum

// move calculated checksum to v1
daddu v0, t3, zero

__hostScanner___end_checksum:
jr ra
nop







//---------------- host packet receiver for client
// This function receives the function to checksum along with the key and host ID
// It will send the client checksum based on the host key
__hostScanner__packetRecieve_FNC:
addiu sp, sp, $ffc0
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)
sw s2, $000c(sp)
sw s3, $0010(sp)
sw s4, $0014(sp)
sw s5, $0018(sp)
sw s6, $001c(sp)
sw s7, $0020(sp)

// check if player is loaded in game
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__hostScanner__checksumPacketSend_end
nop
// check if player is host, if not SKIP function
lui t0, $0046
lbu t0, $A0C0(t0)
bne t0, zero, :__hostScanner__checksumPacketSend_end
nop

// packet data address
setreg s0, $00E2AF54
// save data from packet
setreg t0, :__hostScanner__packetRecieve_DATA
lw t1, $0000(s0)
sw t1, $0000(t0)
lw t1, $0004(s0)
sw t1, $0004(t0)
lw t1, $0008(s0)
sw t1, $0008(t0)

// move host ID to s1
lhu s1, $0000(s0)

// checksum function against host key
lw a0, $0004(s0) // get function
jal :__hostScanner___checksum
lw a1, $0008(s0) // get key

// --- send checksum to host
// store checksum result to checksumPacketSendData
setreg t0, :__hostScanner_checksumPacketSendData
sw v0, $0004(t0)
// store to DEBUG data address
//setreg t1, :__hostScanner_checksumPacketSendDEBUG
//sw v0, $0000(t1)

// get my pptr
lui a0, $0044
lw a0, $0C38(a0)
lhu a0, $0004(a0)
// save my plr ID to checksumPacketSendData
sh a0, $0000(t0)
// get pptr of host
lhu a1, $0000(s0)
jal :__hostScanner__checksumPacketSend_FNC
nop


__hostScanner__checksumPacketSend_end:
// packet size
addiu v0, zero, $C
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $000c(sp)
lw s3, $0010(sp)
lw s4, $0014(sp)
lw s5, $0018(sp)
lw s6, $001c(sp)
lw s7, $0020(sp)
jr ra
addiu sp, sp, $40


__hostScanner__packetRecieve_DATA:
nop
nop
nop
nop

//---------------- client check packet receiver for HOST
// This function receives the checksum result from the client.
// -- Host determines if checksum is correct and removes the player if it is not.
// -- If checksum is correct the player ID is added to a stack to check later.
//    If player ID is not added to the stack in time the player is removed by the host for
//    not responding.

__hostScanner__checksumPacketRecieve_FNC:
addiu sp, sp, $ffc0
sw ra, $0000(sp)
sw s0, $0004(sp)
sw s1, $0008(sp)
sw s2, $000c(sp)
sw s3, $0010(sp)
sw s4, $0014(sp)
sw s5, $0018(sp)
sw s6, $001c(sp)
sw s7, $0020(sp)

// check if player is loaded in game
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__hostScanner__checksumPacketRecieve_end
nop
// check if player is host, if not SKIP function
lui t0, $0046
lbu t0, $A0C0(t0)
beq t0, zero, :__hostScanner__checksumPacketRecieve_end
nop
// check if end of round
lui t0, $0069
lhu t1, $4d48(t0)
bne t1, zero, :__hostScanner__checksumPacketRecieve_end
nop
lhu t1, $4d70(t0)
bne t1, zero, :__hostScanner__checksumPacketRecieve_end
nop

//-------------------- Check client checksum against host checksum
// packet data address
setreg s0, $00E2AF54
lw s2, $0004(s0) // get client checksumResult
// get checksum
setreg s1, :__hostScanner__checksumResult
lw s1, $0000(s1) // get host checksumResult 
// branch if host and client checksums match
beq s2, s1, :__hostScanner__checksumPacketRecieve_addPlayerToStack
nop

beq zero, zero, :__hostScanner__checksumPacketRecieve_end
nop
//---------------------------------------------

//-------------------- add player to ID stack
__hostScanner__checksumPacketRecieve_addPlayerToStack:
// get ID stack
setreg t0, :__hostScanner__playerIDs
__hostScanner__checksumPacketRecieve_nextID:
// get ID
lhu t1, $0000(t0)
// check if stack position already has an ID
beq t1, zero, :__hostScanner__checksumPacketRecieve_saveID
nop

// ELSE, increment stack to next position
beq zero, zero, :__hostScanner__checksumPacketRecieve_nextID
addiu t0, t0, $4

__hostScanner__checksumPacketRecieve_saveID:
// get player ID
lhu t2, $0000(s0) // get ID
sh t2, $0000(t0) // store ID in stack
//---------------------------------------------

__hostScanner__checksumPacketRecieve_end:
// packet size
addiu v0, zero, $8
lw ra, $0000(sp)
lw s0, $0004(sp)
lw s1, $0008(sp)
lw s2, $000c(sp)
lw s3, $0010(sp)
lw s4, $0014(sp)
lw s5, $0018(sp)
lw s6, $001c(sp)
lw s7, $0020(sp)
jr ra
addiu sp, sp, $40


//-------------------------------------------------------

__hostScanner_checksumPacketSendDEBUG:
nop
nop
nop


//--------------- Send client checksum packet
__hostScanner__checksumPacketSend_FNC:
addiu sp, sp, $ffe0
sw ra, $0000(sp)
sh a0, $001C(sp)
sb a2, $001E(sp)
// check if pptr exists based on player ID
jal $002BD4D0
daddu a0, a1, zero
beq v0, zero, :__hostScanner__checksumPacketSend__END
nop

lui at, $0044
lui a0, $0046
addiu a0, a0, $A0C0
// packet ID
addiu t0, zero, $1d 

lw a3, $0FC8(v0)
addiu a1, zero, $0040
addiu t1, zero, $0008 // packet size

// data in packet
setreg t2, :__hostScanner_checksumPacketSendData

lui at, $0046
lw a2, $A1B4(at)
// send packet
jal $0030CEF0
addiu t3, zero, $0001
nop

__hostScanner__checksumPacketSend__END:
lw ra, $0000(sp)
jr ra
addiu sp, sp, $20

//------------------------------------------


__hostScanner_checksumPacketSendData:
nop
nop
nop
nop


__hostScanner_functionStack:
// Functions to scan
// NOTE: 
//   - Can add any function to this stack.
//   - Host scans the function and generates a checksum against a rotating key.
// Add the same function multiple times to check most vulnerable points
hexcode $002CE9E0 // refresh screen
hexcode $001E70D0 // main loop
hexcode :__hostScanner_main_FNC
hexcode $005A1B70 // update health
hexcode :__hostScanner__packetRecieve_FNC
hexcode $002CE9E0 // refresh screen
hexcode :__hostScanner__checksum
hexcode $002CEF00 // refresh fnc 1
hexcode $001F4640 // refresh fnc 5
hexcode :__custom_function_stack
hexcode :__memory_scanner__MAIN_FNC
hexcode $001E70D0 // main loop
hexcode $003C5950 // one shot kill
hexcode :__hostScanner__packetRecieve_FNC
hexcode :__code_scanner2
hexcode $002CF690 // refresh fnc 2
hexcode $002CE9E0 // refresh screen
hexcode $003D2810 // ammo
hexcode $001F4640 // refresh fnc 5
hexcode :__hostScanner_main_FNC
hexcode $005A1B80 // update health fnc
hexcode $0030DA00 // refresh fnc 3
hexcode $001E70D0 // main loop
hexcode $002CE9E0 // refresh screen
hexcode $0029DFA0 // refresh fnc 4
hexcode :__hostScanner_main_FNC

// end stack
nop
nop

// current function to scan
__hostScanner_currentFunction:
nop
nop

// packet data
__hostScanner_packetData:
nop // player ID to vote
nop // function to checksum
nop // key
nop


// print data
__hostScanner_printDEBUG:
nop


















