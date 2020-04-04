


// explosion camera offset save hook -- horizontal
//address $002915E8
//j :cameraOffset_fnc
// explosion camera offset save hook -- vertical
//address $00291598
//j :cameraOffset_fnc

//address $000a4000
cameraOffset_fnc:
// get player pointer and check if health <= 0
lui t0, $0044
lw t0, $0c38(t0)
// check if ppointer exists
beq t0, zero, :cameraOffset_end
nop
// get health float value
lwc1 $f0, $1044(t0)
mtc1 zero, $f1
c.le.s $f0, $f1
bc1f :cameraOffset_end
nop

// else, reset camera offsets
sw zero, $0480(a0)
sw zero, $0484(a0)

cameraOffset_end:
jr ra
nop