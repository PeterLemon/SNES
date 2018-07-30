// SNES MSU1 Video 15 Frames Per Second 15 Color 16 Palette Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "VIDEO15FPS15Col16Pal.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

Loop:
  jmp Loop