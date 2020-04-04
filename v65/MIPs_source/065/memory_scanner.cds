

// memory scanner

// scans memory from a starting address to an ending address. returns checksum

//address $002CED04
//j :__memory_scanner__MAIN_FNC

//address $000d1000
__memory_scanner__MAIN_FNC:
addiu sp, sp, $fff0
sw ra, $0000(sp)

// set v0=1 by default
addiu v0, zero, $1

// skip for now
beq zero, zero, :__memory_scanner_MAIN_end
nop

// check if LAN is loaded. do this to make sure functions and hooks exist to scan
lui t0, $0069
lbu t0, $507C(t0)
beq t0, zero, :__memory_scanner_MAIN_end
nop

// check if patch menu is open
setreg t0, :__menu_open_bool
lw t0, $0000(t0)
bne t0, zero, :__memory_scanner_MAIN_end
nop


// check if player has team ID. do this to make sure functions and hooks exist to scan
lui t0, $0044
lw t0, $1470(t0)
beq t0, zero, :__memory_scanner_MAIN_end
nop

// check if spectator, skip
lui t0, $0069
lbu t0, $54A0(t0)
bne t0, zero :__memory_scanner_MAIN_end
nop

// check if player has pptr
lui t0, $0044
lw t0, $0C38(t0)
beq t0, zero, :__memory_scanner_MAIN_end
nop

// check if stack position exists
setreg t0, :__memory_scanner__stackPosition
lw t1, $0000(t0)
bne t1, zero, :__memory_scanner__skipStackInit
nop

// else stack position is not set, set stack to stack start
__memory_scanner__memoryStack_RESET:
setreg t2, :__memory_scanner__memoryStack
sw t2, $0000(t0) // save address of stack start
// reload stack position
lw t1, $0000(t0)

__memory_scanner__skipStackInit:
// check if end of stack, load data from stack and check if zero
lw t3, $0000(t1)
beq t3, zero, :__memory_scanner__memoryStack_RESET
nop

// if t3 = 0 initialize stack again

__memory_scanner__start_checksum:
// load start, end, and checksum values
lw a0, $0000(t1)
lw a1, $0004(t1)
lw a2, $0008(t1)
// increment stack position
addiu t1, t1, $c
sw t1, $0000(t0)

// call checksum function
jal :__memory_scanner___checksum
nop
// check returned checksum, if 0 continue. if 1 remove player
bne v0, zero, :__memory_scanner_MAIN_end
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

// set "abort game screen" to "player kicked screen"
setreg t0, $002A9BFC
addiu t1, zero, $26A0
sh, t1, $0000(t0)

// force player to abort game
setreg t0, $00694DAC
addiu t1, zero, $1
sb, t1, $0000(t0)


__memory_scanner_MAIN_end:
// memoryscanner FLAG 1
setreg t0, :__memoryscanner_FLAG_1
addiu t1, zero, $1
sw t1, $0000(t0)

lw ra, $0000(sp)
jr ra
addiu sp, sp, $0010



__memory_scanner___checksum:
/////////////////////////////////////////////////////////////////
//
// CHECK SUM FNC
//
// a0 = memory section start
// a1 = memory section end
// a2 = checksum to compare to
// return v0 = zero if checksums are identical, 1 if they are different

// set v0 to 1 by default
addiu v0, zero, $1

// start address to checksum
daddu t0, a0, zero
// end address to checksum
daddu t2, a1, zero
// zero calculated checksum register
addu t3, zero, zero 


__memory_scanner__next_address:
lw t4, $0000(t0) // get current address data
addu t3, t3, t4 // add to checksum
addiu t0, t0, $4 //increment function position
beq t0, t2, :__memory_scanner___end_checksum
nop
beq zero, zero :__memory_scanner__next_address
nop

__memory_scanner___end_checksum:
beq t3, a2, :__memory_scanner__checksum_pass
nop

// else checksum failed
daddu v0, zero, zero

//debug failed address and checksum
setreg t0, :__memory_scanner__stackFail
sw a0, $0000(t0)
sw t3, $0004(t0)

__memory_scanner__checksum_pass:
jr ra
nop



__memory_scanner__memoryStack:
/* 
1st: start address
2nd: end address
3rd: checksum address
then repeat
*/
// player tags and various hooks
//hexcode $004055A0
//hexcode $00405FCC
//hexcode $5AD94148
// unused memory
//hexcode $000a0000 
//hexcode $000b0000
//hexcode $00000000
// unused memory
//hexcode $000b0000 
//hexcode $000c0ff8
//hexcode $00000000
// packet hooks
//hexcode $00E29F50
//hexcode $00E29FBC
//hexcode $04AA5410
// player control/dynamics/update
//hexcode $00669120
//hexcode $00669FAC
//hexcode $266FB8F8
// code after patch 1
//hexcode :__end_of_all_code
//hexcode $000d0000
//hexcode $00000000
// code after patch 2
//hexcode $000d0000
//hexcode $000e0000
//hexcode $00000000
// code after patch 3
//hexcode $000e0000
//hexcode $000f0000
//hexcode $00000000
// player tags
hexcode $002269A0  
hexcode $00226EEC
hexcode $39C1E799

nop // END STACK

__memory_scanner__stackPosition:
nop
nop
__memory_scanner__stackFail:
nop
nop
nop







