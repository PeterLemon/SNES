// SNES MSU1 Touhou - Bad Apple! 30 Frames Per Second 4 Color Interlace Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "Touhou-BadApple!30FPS4ColInterlace.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

Loop:
  jmp Loop