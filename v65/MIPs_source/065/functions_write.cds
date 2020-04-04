


///////////////// FUNCTION HOOKS and Misc Code ////////////////////

// custom functions hook
address $002CED04
j :__custom_function_stack 


// main loop hook -- for refresh FNC flag check **DISABLED FOR TEST**
address $001E70EC
j :__mainLoop_refreshFLAG_check_FNC

// return from kernel hook -- check refresh FNC flag **DISABLED FOR TEST**
address $001A6DC4
j :_returnFromKernel_check_FNC

// anti boot hook -- check for boot packets **DISABLED FOR TEST**
address $0063CAC4
jal :__anti_boot_FNC

// check if joining player IP is banned
address $002BC6DC
j :__hostScanner_checkPlayerJoining_FNC

// main packet sender hook -- check if kernel flags are set **DISABLED FOR TEST**
address $0063C130
j :__check_flags_gameplay_kernelOnly_fnc



// get bullet damage -- client -- hook
address $002BBD38
jal :FNC_oneShotKillCheck
// get bullet damage -- remote player -- hook
address $002BBD5C
jal :FNC_oneShotKillCheck_remotePlayer



// Flags hook
address $001A6DBC
jal :__kernel_FLAGS_Reset


// round start/end
address $00599498
j :__round_START_or_END_function


// all maps respawn
address $002749E8 
hexcode $24100000
// all maps respawn
address $00274b00 
hexcode $24020005
// all maps respawn hook
address $003B04B8 
j :__all_maps_respawn


// CLAN TAG refresh hook 
address $00333B20
j :__clan_tag_fnc
// CLAN TAGS initnetwork hook
address $00276ECC
j :__CLAN_TAGS_initnetwork_hook
// This fnc clears all the name pointers that were created in earlier functions when logging off.
address $0027E600
j :__CLAN_TAG_clear



// DAY MAPS --- FOG_FNC hook
address $00339E38
jal :__DAYMAPS__Fog_check
// disabled in FOG_FNC so the fog isn't loaded by default
address $00339E40
nop
// disabled in FOG_FNC so the fog isn't loaded by default
address $00339E48
nop
// DAY MAPS --- get original maps
address $00276DB4 // DMEInit HOOK
j :__DAYMAPS__get_original_maps
// DAY MAPS --- load map hook
address $002AF09C
jal :__LOAD_MAP

// DAY MAPS --- join game hook
address $002B96FC
jal :__JOIN_GAME

// DAY MAPS --- join game already in progress hook
address $002B9428
jal :__JOIN_GAME_ALREADY_IN_PROGRESS

// DAY MAPS --- end game hook (disable if host) original jal: 0027F810
address $002C08A8
jal :__END_GAME



// HOST --- determine host of game
address $0022A374
jal :__determine_host
nop



// PATCHED GAME --- prepatch
address $0027E4B8
j :__PREPATCHEDGAME
// PATCHED GAME --- End game results hook to reset
address $0027FF18
j :__END_GAME_RESULTS
// PATCHED GAME --- __create_game_fnc hook
address $00304250
j :__create_game_fnc
// PATCHED GAME --- keyboard close/enter hook
address $00367940
j :__close_keyboard
// PATCHED GAME --- hook from "does game have password" fnc
address $0027D438
j :__join_game_check
// join game patch password check
address $0030D434 // join game  // create game -- 0030D23C
jal :__join_game_patchPASSWORD_check_FNC



// LAN RANKS --- RECORD KILL HOOK
address $005452D4
jal :__LANRanks__record_kill
nop
// LAN RANKS --- RECORD DEATH HOOK
address $00545D54
jal :__LANRanks__record_death
nop
// LAN RANKS --- lobby hook
address $0029E04C
j :__get_rank



// SELECT MENU --- print select menu hook
//address $002AAB18
//j :__FNC_display


// version menu
address $0030DBA8
j :version__FNC_display


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
// SPECTATOR TAGS HOOKs
// in game hook to check for halo mode
address $005B0B9C
j :SPECTAGS__spectator_tags_check
address $00226F00
jal :SPECTAGS__tags_fnc
// SPECTATOR -- highlight players check
address $003B757C
j :spectator_highlightPlayers_FNC


// SCOREBOARD: LAN game hook
address $0022C4A4
jal :SCOREBOARD_LanGame_FNC
// SCOREBOARD: game details hook
address $0022CE4C
jal :SCOREBOARD_GameDetails_FNC

// explosion camera offset save hook -- horizontal
address $002915E8
j :cameraOffset_fnc
// explosion camera offset save hook -- vertical
address $00291598
j :cameraOffset_fnc



// load weapon ammo capacity 
address $003D2810
j :weaponStats_FNC
nop




//////////////////////// Various Codes that require write on LAN LOAD /////////////////////////
// no text limit
address $0039A100 
hexcode $00000000

// all characters unlocked
address $00695630 
hexcode $00030001
address $00695644 
hexcode $00030001
address $00695658 
hexcode $00030001
address $0069566c 
hexcode $00030001
address $00695680 
hexcode $00030001
address $00695694 
hexcode $00030001
address $006956a8 
hexcode $00030001
address $006956bc 
hexcode $00030001

// force game display details
address $002E2080
nop






//------------------------------------------------------------------------------------------------
//////////////// Variables and Misc /////////////////////



// TEXT BOX --- pointer (used for patched games to check password)
address $000f6000
__text_box_pointer:



// FLAGS
address $000F6A00 
__kernel_FLAG_1:
nop
__kernel_FLAG_2:
nop
__kernel_FLAG_3:
nop
__kernel_FLAG_4:
nop
__codescanner2_FLAG_1:
nop
__memoryscanner_FLAG_1:
nop

// FLAGS part 2
address $000F6B00 
__refreshHook_FLAG:
nop
__kernelCheck_FLAG:
nop


// KERNAL -- decrypted code output
address $000f7000 
kernal__output:


// CLANTAG: original player name
address $000f7100 
__CLANTAG_original_player_name:
// CLANTAG: clan tag
address $000f7140
__CLANTAG_clan_tag:
// CLANTAG: modified player name
address $000f7180 
__CLANTAG_modified_player_name:


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
// spectator: highlight players BOOL
address $000f71C8
spectator_highlightPlayers_BOOL:
// patch write code bool -- use this bool to determine if patch should be disabled
address $000f71CC
patch_write_BOOL:
// Select Menu - output text
address $000f71D0 
__output_text:
// Select Menu - s0 variable
address $000f71F0
__s0_register:
// DLC Maps BOOL
address $000f7400
DLC_MAPS_BOOL:
// sgl_game_BOOL
address $000f7404
sgl_game_BOOL:


// CODE CHECK - Stored data location (4 bytes)
address $000f75B0
CODECHECK__store_data_stack:

address $000f75D0
decryption__output:


// CUSTOM MAPS info stack --moved to dayMaps.cds
// check: DLC_MAPS_BOOL
address $000f7600
/*
__custom_maps_start_DLC:
//hexcode :__afterhours_DLC
hexcode :__liberation_DLC
hexcode :__lastbastion_DLC
// non-DLC maps start
__custom_maps_start:
hexcode :__abandoned_day
hexcode :__shadowfalls_day
hexcode :__sandstorm_day
hexcode :__fishhook_day
hexcode :__crossroads_day
hexcode :__mixer_day
hexcode :__blizzard_day
hexcode :__frostfire_day
hexcode :__desertglory_day
hexcode :__nightstalker_day
hexcode :__ratsnest_day
hexcode :__bitterjungle_day
hexcode :__bloodlake_day
hexcode :__deathtrap_day
hexcode :__ruins_day
// start original map listings
___custom_maps_stack_start:
*/


// PATCH VERSION
address $000F8EE0
__patchVersion:
hexcode $41

//CHECK SUM BOOL --- Needed for the code scanner.
address $000F8FF0
__checksum_BOOL:

// kernel code write timer
address $000f8ff8
__kernel_timerVar:

// kernel codes write BOOL
address $000F8FFC
__kernel_codesWrite_BOOL:


//------------------------------------------------------------------------------------------------






///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////// CUSTOM FUNCTIONS START //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////





// Master Functions Start
address $000D0000



// random text 1 -- not printed in game
print "Charlie Murphy is god"
nop

// deceased socom players
print "RIP SOCOM players of the past"
nop
print "DNAS!"
nop
print "JoKeR"
nop
print "Yo5hi"
nop
print "WhO sHoT yA?"
nop


// all maps respawn
import "C:\r0005\MIPs_source\065\all maps respawn.cds"
nop

// clan tags
import "C:\r0005\MIPs_source\065\clan tag.cds"
nop

// code check
import "C:\r0005\MIPs_source\065\code check.cds"
nop

// day maps
import "C:\r0005\MIPs_source\065\day maps.cds"
nop

// select menu spectators
import "C:\r0005\MIPs_source\065\select_menu_spectator.cds
nop

// host
import "C:\r0005\MIPs_source\065\host.cds"
nop

//spectator tags
import "C:\r0005\MIPs_source\065\spectator_tags.cds"
nop

// LAN Ranks
import "C:\r0005\MIPs_source\065\LAN Ranks.cds"
nop

// Join patched games
import "C:\r0005\MIPs_source\065\join patched games.cds"
nop

// Version menu
import "C:\r0005\MIPs_source\065\version_display.cds"
nop

// widescreen fix
import "C:\r0005\MIPs_source\065\widescreen_fix.cds"
nop

// custom functions stack
import "C:\r0005\MIPs_source\065\custom_functions_stack.cds"
nop

// patch_menu
import "C:\r0005\MIPs_source\065\patch_menu.cds"
nop

// global functions
import "C:\r0005\MIPs_source\065\global_functions.cds"
nop

// round start and end functions
import "C:\r0005\MIPs_source\065\round_STARTorEND_functions.cds"
nop

// flags 1
import "C:\r0005\MIPs_source\065\flags.cds"
nop

// flags 2
import "C:\r0005\MIPs_source\065\flags_part2.cds"
nop

// get bullet damage
import "C:\r0005\MIPs_source\065\get_bullet_damage.cds"
nop

// scoreboard
import "C:\r0005\MIPs_source\065\scoreboard.cds"
nop

// memory scanner
import "C:\r0005\MIPs_source\065\memory_scanner.cds"
nop

// host memory scanner
import "C:\r0005\MIPs_source\065\host_memory_scanner_v3.cds"
nop

// anti boot
import "C:\r0005\MIPs_source\065\anti_boot.cds"
nop

// camera offset
import "C:\r0005\MIPs_source\065\camera_offset.cds"
nop

// weapon stats for SGL games
import "C:\r0005\MIPs_source\065\weaponStats.cds"
nop

__end_of_all_code:
nop






