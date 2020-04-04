

Files:

functions_write.cds: Contains all imports, variables, and hooks to various functions. 
r0005 crypto.cds: Contains all kernel functions and imports functions_write.cds.

Compiling the patch:
1. Function hooks must be compiled using "Code Stack Encryptor.exe" and inserted in to the "r0005 crypto.cds". (hooks come from functions_write.cds)
2. Paste compiled hooks to label "kernal__data" in the "r0005 crypto.cds" and compile.
3. Paste compiled "r0005 crypto" code in to "MIPStoC" program and convert.
4. Paste converted code in to "C_source/065/asm.c" function PasteASM().
5. Compile the ELF using the "make" command in msys.



r0005v65 Changelog: 

CHANGE: Disabled dead players from rotating camera. [PATCH GAMES ONLY]
CHANGE: Added FPS counter to patch menu. [Thanks to 1UP for finding this]
CHANGE: Updated SCOREBOARD to provide a better game mode description [ex: REGULAR GAME, PATCH NORMAL, PATCH LEGACY, etc]
CHANGE: The button combo to open the patch menu is now based on the controller config. 
- Precision = L1 + X. Sureshot = L1 + DPAD Down
CHANGE: Added control for spectators to highlight players in game. This can only be toggled using 1UPs Streaming app. [PATCH GAMES ONLY]
CHANGE: Corrected respawn glitch where the round would start and end instantly requiring a restart.
CHANGE: Corrected glitch where the camera would misalign due to explosions.
CHANGE: Added SGL Patch mode.
- Create game where the password starts with "%" [ex: %123456]
- Players joining must enter full password [ex: %123456] 
- The following weapons have no ammo: IW-80-A2, M14, M60E3, M63A, PMN Mines, Claymores, AT-4, RPG, M203/Grenade Launchers. If you choose a weapon with M203 attachments the gun will still have ammo but will not have M203 ammo.
CHANGE: Patch menu option "clear banned players" is grey if no banned players exist in your banned players list.



To do list:
- Enable dlc maps in map listing if they are working.


---Game Modes---
Regular Game: No password or a password that does not begin with !, @, #, $, or %
Patch Game: Password starts with !
Halo Game: Password starts with @
Legacy Password Patch Game: Password starts with # [user enters pass]
Legacy Patch Game: Password starts with $
SGL Patch Game: Password starts with % [user enters pass]


Game modes by password character:
! - Regular patch game. Most secure.
@ - Halo patch game.
# - Legacy patch game with password. Similar to v62.
$ - Legacy patch game. Similar to v62.
% - SGL patch game with password. Similar to v62 with custom rules for SGL.


************** NOTES ***************

Weapons Pointer START: 004B5214
Weapons Pointer END: 004B5218
START Offsets:
0: next index
4: previous index
8: weapon pointer
Weapon pointer offsets:
7C: Weapon ID

Tracers:
003CADA0 - grenade check
003CADB4 - secondary check
003CADE0 - tracer ON = nop

Death camera lock -- constant write
20416208 00000000
20416210 00000000

Death Camera --locked
20297B30 AC206208
20297B40 AC206210
Death Camera --normal
20297B30 E4226208
20297B40 E4206210

"SelectedControllerConfig" 00694F14: 1 = precision, 4 = sureshot

explosion offset camera fix [does not work as expected]
202915E0 AC800480 
20291590 AC800484

cam pointer[00415FF0] + offset to camera[b4]
offsets:
480: camera horizontal offset
484: camera vertical offset
Note: Set both offsets to zero on player death.

--ammo counts--
IW-80-A2
M14
M60E3
M631
PMN Mines
Claymores
AT-4
RPG
M203/Other Grenade Launchers

***********************************


Patch Variables:
CLANTAG: original player name: 000f7100 
CLANTAG: clan tag: 000f7140
CLANTAG: modified player name: 000f7180 
DLC Maps BOOL: 000f7400 [0 = disabled, 1 = enabled]


__patchgame_codes:
disable wall sliding new (r0004 style)
0057E348 0000102D
disable multiplayer join game failure
003039E4 10000004
disable voice mod
003DF1A8 00000000
disable encryption and decryption
0062A79C 00000000
0062A838 00000000
password key create game
0030D278 3C036524
0030D27C 346301D2
password key initial join game
0030D43C 3C036524
0030D440 346301D2
password key join game
002BC7C0 3C036524
002BC7C8 346401D2
552SD distance indicator mimics m4a1sd
00C85504 461C4000
death camera disabled
002981D0 24030007
death camera vertical look down
00297EF0 3C02Bf80
00297EF4 34420000
team tags opacity 50%
00226EF4 3C024248
Death Camera --locked
00297B30 AC206208
00297B40 AC206210
thermal bool
004B4A68 00000000
player model color.
004B4CD0 3EA8F5C3
004B4CD4 3EA8F5C3
004B4CD8 3EA8F5C3
player model light.
003E1480 3f800000


__sgl_patchgame_codes
disable wall sliding new (r0004 style)
0057E348 0000102D
disable multiplayer join game failure
003039E4 10000004
disable voice mod
003DF1A8 00000000
disable encryption and decryption
0062A79C 00000000
0062A838 00000000
password key create game
0030D278 3C036524
0030D27C 346301D2
password key initial join game
0030D43C 3C036524
0030D440 346301D2
password key join game
002BC7C0 3C036524
002BC7C8 346401D2
552SD distance indicator mimics m4a1sd
00C85504 461C4000
death camera disabled
002981D0 24030007
death camera vertical look down
00297EF0 3C02Bf80
00297EF4 34420000
team tags opacity 50%
00226EF4 3C024248
Death Camera --locked
00297B30 AC206208
00297B40 AC206210
thermal bool
004B4A68 00000000
player model color.
004B4CD0 3EA8F5C3
004B4CD4 3EA8F5C3
004B4CD8 3EA8F5C3
player model light.
003E1480 3f800000


__prepatchgame_codes:
enable wall sliding new
0057E348 8E2210AC
disable multiplayer join game failure check(keep disabled)
003039E4 10000004
disable voice mod(keep disabled)
003DF1A8 00000000
enable encryption and decryption
0062A79C 00C53026
0062A838 00832026
password key create game
0030D278 3C037F00
0030D27C 346300FE
password key initial join game
0030D43C 3C037F00
0030D440 346300FE
password key join game
002BC7C0 3C037F00
002BC7C8 346400FE
552SD distance indicator normal
00C85504 481C4000
death camera normal
002981D0 24030003
death camera vertical normal
00297EF0 3C02BE4C
00297EF4 3442CCCD
team tags opacity 100%
00226EF4 3C0242C8
Death Camera --normal
00297B30 E4226208
00297B40 E4206210
thermal bool
004B4A68 00000000
player model color.
004B4CD0 3EA8F5C3
004B4CD4 3EA8F5C3
004B4CD8 3EA8F5C3
player model light.
003E1480 3f800000





