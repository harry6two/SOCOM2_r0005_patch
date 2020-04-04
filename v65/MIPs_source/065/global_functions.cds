

// global functions







//---------------------------------- WRITE CODE STACK
// NOTE: This function writes a code stack. a0 = code stack start.
/*
Example:
000A0000
00000001
*/
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
//---------------------------------------------------




//---------------------------------- FLAG Checks - Non-Gameplay(for create/join game functions)
__check_flags_fnc:

setreg t0, :__kernel_FLAG_1
lw t1, $0000(t0)
beq t1, zero, :__check_flags_fnc__checkFAIL
nop
lw t1, $0004(t0)
beq t1, zero, :__check_flags_fnc__checkFAIL
nop
lw t1, $0008(t0)
beq t1, zero, :__check_flags_fnc__checkFAIL
nop
lw t1, $000c(t0)
beq t1, zero, :__check_flags_fnc__checkFAIL
nop
lw t1, $0010(t0)
beq t1, zero, :__check_flags_fnc__checkFAIL
nop
lw t1, $0014(t0)
beq t1, zero, :__check_flags_fnc__checkFAIL
nop

// all flags checked out, return 0
beq zero, zero, :__check_flags_fnc__end
daddu v0, zero, zero

__check_flags_fnc__checkFAIL:
// return 1 if failed flag check
addiu v0, zero, $1
__check_flags_fnc__end:
jr ra
nop

//----------------------------------------------



//---------------------------------- FLAG Checks - Gameplay Kernel only
__check_flags_gameplay_kernelOnly_fnc:

// check player pointer to confirm player is in game
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__check_flags_gameplay_kernelOnly_fnc__end
nop

setreg t0, :__kernel_FLAG_1
lw t1, $0000(t0)
beq t1, zero, :__check_flags_gameplay_kernelOnly_fnc__checkFAIL
nop
lw t1, $0004(t0)
beq t1, zero, :__check_flags_gameplay_kernelOnly_fnc__checkFAIL
nop
lw t1, $0008(t0)
beq t1, zero, :__check_flags_gameplay_kernelOnly_fnc__checkFAIL
nop
lw t1, $000c(t0)
beq t1, zero, :__check_flags_gameplay_kernelOnly_fnc__checkFAIL
nop

// all flags checked out, return 0
beq zero, zero, :__check_flags_gameplay_kernelOnly_fnc__end
nop

__check_flags_gameplay_kernelOnly_fnc__checkFAIL:
// disable master packet sender so cheater believes they are still playing
setreg t0, $0063C098
sw zero, $0000(t0)
// set damage receive packet so player is booted when shot in case player can return
setreg t0, $002BBD80
addiu t1, zero, $4
sb, t1, $0000(t0)
// set vote packet receive so player is booted in case player can return
setreg t0, $002BA128
addiu t1, zero, $2
sb, t1, $0000(t0)
// reset checksum bool to avoid inf loop
setreg t0, :__checksum_BOOL
addiu t1, zero, $1
sw t1, $0000(t0)
// set "abort game screen" to "player kicked screen"
//setreg t0, $002A9BFC
//addiu t1, zero, $26A0
//sh, t1, $0000(t0)
// force player to abort game
//setreg t0, $00694DAC
//addiu t1, zero, $1
//sb, t1, $0000(t0)
// The player will abort the game without the ability to send packets

__check_flags_gameplay_kernelOnly_fnc__end:
jr ra
nop
//----------------------------------------------


//---------------------------------- FLAG Checks - Gameplay code/memory scanner
__check_flags_gameplay_codeAndMemoryScanners_fnc:

// check player pointer to confirm player is in game
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__check_flags_gameplay_fnc__end
nop

setreg t0, :__codescanner2_FLAG_1
lw t1, $0000(t0)
beq t1, zero, :__check_flags_gameplay_fnc__checkFAIL
nop
lw t1, $0004(t0)
beq t1, zero, :__check_flags_gameplay_fnc__checkFAIL
nop

// all flags checked out, return 0
beq zero, zero, :__check_flags_gameplay_fnc__end
nop

__check_flags_gameplay_fnc__checkFAIL:
// disable master packet sender so cheater believes they are still playing
setreg t0, $0063C098
sw zero, $0000(t0)
// set damage receive packet so player is booted when shot in case player can return
setreg t0, $002BBD80
addiu t1, zero, $4
sb, t1, $0000(t0)
// set vote packet receive so player is booted in case player can return
setreg t0, $002BA128
addiu t1, zero, $2
sb, t1, $0000(t0)
// reset checksum bool to avoid inf loop
setreg t0, :__checksum_BOOL
addiu t1, zero, $1
sw t1, $0000(t0)
// set "abort game screen" to "player kicked screen"
//setreg t0, $002A9BFC
//addiu t1, zero, $26A0
//sh, t1, $0000(t0)
// force player to abort game
//setreg t0, $00694DAC
//addiu t1, zero, $1
//sb, t1, $0000(t0)
// The player will abort the game without the ability to send packets

__check_flags_gameplay_fnc__end:
jr ra
nop
//----------------------------------------------


//---------------------------------- Check if online and disable encryption
//
// May be used for a real server at some point.
// 

__ONLINE_packet_encryption_check_FNC:

// check if socom lan is loaded
setreg t0, $0069507C
setreg t1, $00010001
lw t0, $0000(t0) // get "ComeFromLAN" BOOL
bne t0, t1, :__ONLINE_packet_encryption_check_FNC___is_on_LAN
nop

// disable encryption and decryption
setreg t0, $0062A79C
sw zero, $0000(t0)
setreg t0, $0062A838
sw zero, $0000(t0)

__ONLINE_packet_encryption_check_FNC___is_on_LAN:
jr ra
nop


//----------------------------------------------



//---------------------------------- Check if code scanners return 0 or 1
//
// a0 = result. if a0 = 0 code scanner failed or was not called, remove player
// 

__scannerResults_FNC:
bne a0, zero, :__scannerResults_FNC_end
nop

// disable master packet sender so cheater believes they are still playing
setreg t0, $0063C098
sw zero, $0000(t0)
// set damage receive packet so player is booted when shot in case player can return
setreg t0, $002BBD80
addiu t1, zero, $4
sb, t1, $0000(t0)
// set vote packet receive so player is booted in case player can return
setreg t0, $002BA128
addiu t1, zero, $2
sb, t1, $0000(t0)
// reset checksum bool to avoid inf loop
setreg t0, :__checksum_BOOL
addiu t1, zero, $1
sw t1, $0000(t0)

__scannerResults_FNC_end:
jr ra
nop

//----------------------------------------------






//---------------------------------- Spectator: Highlight players

spectator_highlightPlayers_FNC:
// thermal bool: 004B4A68

/*
thermal bool
204B4A68 00000001
player model light
203E1480 40400000
player model color
204B4CD0 00000000
204B4CD4 3F000000
204B4CD8 00000000
*/


// check if player is in patch game
setreg t0, :patched_game_BOOL
lbu t0, $0000(t0)
beq t0, zero, :spectator_highlightPlayers_end
nop
// check if spectator
lui t0, $0069
lbu t0, $54A0(t0)
beq t0, zero, :spectator_highlightPlayers_end
nop
// check if highlightPlayers BOOL is enabled
setreg t0, :spectator_highlightPlayers_BOOL
lbu t0, $0000(t0)
beq t0, zero, :spectator_noHighlightPlayers
nop

//--------------------- highlight players
// thermal bool
lui t0, $004B
addiu t1, zero, $1
sb t1, $4A68(t0)
// player model color
lui t1, $3E98
sw t1, $4CD0(t0) //R
lui t1, $3DCA
sw t1, $4CD4(t0) //G
sw zero, $4CD8(t0) //B
setreg t1, $43C1F07C
sw t1, $4CDC(t0) //A
// player model brightness
//lui t0, $003E
//lui t1, $4040
//sw t1, $1480(t0)
// end
beq zero, zero, :spectator_highlightPlayers_end
nop

spectator_noHighlightPlayers:
// thermal bool
lui t0, $004B
sb zero, $4A68(t0)
// player model color
setreg t1, $3EA8F5C3
sw t1, $4CD0(t0)
sw t1, $4CD4(t0)
sw t1, $4CD8(t0)
sw zero, $4CDC(t0)
// player model brightness
//lui t0, $003E
//lui t1, $3f80
//sw t1, $1480(t0)

spectator_highlightPlayers_end:
jr ra
nop



//---------------------------------- 























