// SNES SPC700 Speech Synthesis Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "SpeechSynth.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

// Consonants Sample Index
constant BB(0)
constant DD(1)
constant FF(2)
constant GG(3)
constant HH(4)
constant CK(5)
constant LL(6)
constant MM(7)
constant NN(8)
constant PP(9)
constant RR(10)
constant SS(11)
constant TT(12)
constant VV(13)
constant WW(14)
constant ZZ(15)
constant SI(16)
constant SH(17)
constant TH(18)
constant THV(19)
constant NG(20)
constant JY(21)

// Vowels Sample Index
constant EA(22)
constant EE(23)
constant IE(24)
constant AU(25)
constant OO(26)
constant OU(27)
constant UE(28)
constant ER(29)
constant AA(30)
constant AW(31)

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_DIR,sampleDIR >> 8) // Sample Directory Offset

  WDSP(DSP_KOFF,$00) // Reset Key Off Flags
  WDSP(DSP_MVOLL,127) // Master Volume Left
  WDSP(DSP_MVOLR,127) // Master Volume Right

  WDSP(DSP_ESA,$00)    // Echo Source Address
  WDSP(DSP_EDL,0)      // Echo Delay
  WDSP(DSP_EON,%00000000) // Echo On Flags
  WDSP(DSP_FLG,%00100000) // Disable Echo Buffer Writes
  WDSP(DSP_EFB,0)  // Echo Feedback
  WDSP(DSP_FIR0,127) // Echo FIR Filter Coefficient 0
  WDSP(DSP_FIR1,0)   // Echo FIR Filter Coefficient 1
  WDSP(DSP_FIR2,0)   // Echo FIR Filter Coefficient 2
  WDSP(DSP_FIR3,0)   // Echo FIR Filter Coefficient 3
  WDSP(DSP_FIR4,0)   // Echo FIR Filter Coefficient 4
  WDSP(DSP_FIR5,0)   // Echo FIR Filter Coefficient 5
  WDSP(DSP_FIR6,0)   // Echo FIR Filter Coefficient 6
  WDSP(DSP_FIR7,0)   // Echo FIR Filter Coefficient 7
  WDSP(DSP_EVOLL,0) // Echo Volume Left
  WDSP(DSP_EVOLR,0) // Echo Volume Right

  WDSP(DSP_V0VOLL,127)        // Voice 0; Volume Left
  WDSP(DSP_V0VOLR,127)        // Voice 0; Volume Right
  WDSP(DSP_V0GAIN,127)        // Voice 0: Gain

SongStart:
  WDSP(DSP_V0PITCHL,$00)      // Voice 0: Pitch (Lower Byte)
  WDSP(DSP_V0PITCHH,$10)      // Voice 0: Pitch (Upper Byte)
  WDSP(DSP_V0ADSR1,%11111111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11100000) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,PP)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(32) // Wait 256 ms

  WDSP(DSP_V0ADSR1,%11110111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111100) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,EE)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  WDSP(DSP_V0ADSR1,%11111111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11100000) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,TT)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(32) // Wait 256 ms

  WDSP(DSP_V0ADSR1,%11110111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111100) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,AA)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms


  WDSP(DSP_V0PITCHL,$00)      // Voice 0: Pitch (Lower Byte)
  WDSP(DSP_V0PITCHH,$15)      // Voice 0: Pitch (Upper Byte)
  WDSP(DSP_V0ADSR1,%11110111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111100) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,LL)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(32) // Wait 256 ms

  WDSP(DSP_V0PITCHL,$00)      // Voice 0: Pitch (Lower Byte)
  WDSP(DSP_V0PITCHH,$10)      // Voice 0: Pitch (Upper Byte)
  WDSP(DSP_V0ADSR1,%11110111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111100) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,EA)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  WDSP(DSP_V0PITCHL,$00)      // Voice 0: Pitch (Lower Byte)
  WDSP(DSP_V0PITCHH,$15)      // Voice 0: Pitch (Upper Byte)
  WDSP(DSP_V0ADSR1,%11110111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111100) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,MM)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(32) // Wait 256 ms

  WDSP(DSP_V0PITCHL,$00)      // Voice 0: Pitch (Lower Byte)
  WDSP(DSP_V0PITCHH,$10)      // Voice 0: Pitch (Upper Byte)
  WDSP(DSP_V0ADSR1,%11110111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111100) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,AA)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(32) // Wait 256 ms

  WDSP(DSP_V0PITCHL,$00)      // Voice 0: Pitch (Lower Byte)
  WDSP(DSP_V0PITCHH,$15)      // Voice 0: Pitch (Upper Byte)
  WDSP(DSP_V0ADSR1,%11110111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111100) // Voice 0: ADSR2
  WDSP(DSP_V0SRCN,NN)     // Voice 0: Sample
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SPCWaitMS(256) // Wait 256 ms
Loop:
  jmp SongStart

seek($8000); sampleDIR:
  // Consonants
  dw ConBB, ConBB + 468 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConDD, ConDD + 468 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConFF, 0 // BRR Sample Offset, No Loop Point
  dw ConGG, 0 // BRR Sample Offset, No Loop Point
  dw ConHH, 0 // BRR Sample Offset, No Loop Point
  dw ConCK, 0 // BRR Sample Offset, No Loop Point
  dw ConLL, ConLL + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConMM, ConMM + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConNN, ConNN + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConPP, 0 // BRR Sample Offset, No Loop Point
  dw ConRR, ConRR + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConSS, 0 // BRR Sample Offset, No Loop Point
  dw ConTT, 0 // BRR Sample Offset, No Loop Point
  dw ConVV, ConVV + 468 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConWW, ConWW + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConZZ, ConZZ + 468 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConSI, 0 // BRR Sample Offset, No Loop Point
  dw ConSH, 0 // BRR Sample Offset, No Loop Point
  dw ConTH, 0 // BRR Sample Offset, No Loop Point
  dw ConTHV, ConTHV + 468 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConNG, ConNG + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw ConJY, ConJY + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)

  // Vowels
  dw VowEA, VowEA + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowEE, VowEE + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowIE, VowIE + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowAU, VowAU + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowOO, VowOO + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowOU, VowOU + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowUE, VowUE + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowER, VowER + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowAA, VowAA + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)
  dw VowAW, VowAW + 9 // BRR Sample Offset, Loop Point (BRR Loop Sample Offset)

seek($8100) // Sample Data
  // Consonants
  insert ConBB, "BRR/01. b (Loop=468,AD=$FF,SR=$E0).brr"
  insert ConDD, "BRR/02. d (Loop=468,AD=$FF,SR=$E0).brr"
  insert ConFF, "BRR/03. f (AD=$FF,SR=$E0).brr"
  insert ConGG, "BRR/04. g (AD=$FF,SR=$E0).brr"
  insert ConHH, "BRR/05. h (AD=$FF,SR=$E0).brr"
  insert ConCK, "BRR/07. k (AD=$FF,SR=$E0).brr"
  insert ConLL, "BRR/08. l (Loop=9,AD=$FF,SR=$E0).brr"
  insert ConMM, "BRR/09. m (Loop=9,AD=$FF,SR=$E0).brr"
  insert ConNN, "BRR/10. n (Loop=9,AD=$FF,SR=$E0).brr"
  insert ConPP, "BRR/11. p (AD=$FF,SR=$E0).brr"
  insert ConRR, "BRR/12. r (Loop=9,AD=$FF,SR=$E0).brr"
  insert ConSS, "BRR/13. s (AD=$FF,SR=$E0).brr"
  insert ConTT, "BRR/14. t (AD=$FF,SR=$E0).brr"
  insert ConVV, "BRR/15. v (Loop=468,AD=$FF,SR=$E0).brr"
  insert ConWW, "BRR/16. w (Loop=9,AD=$FF,SR=$E0).brr"
  insert ConZZ, "BRR/17. z (Loop=468,AD=$FF,SR=$E0).brr"
  insert ConSI, "BRR/18. si (AD=$FF,SR=$E0).brr"
  insert ConSH, "BRR/20. sh (AD=$FF,SR=$E0).brr"
  insert ConTH, "BRR/21. th (AD=$FF,SR=$E0).brr"
  insert ConTHV, "BRR/22. thv (Loop=468,AD=$FF,SR=$E0).brr"
  insert ConNG, "BRR/23. ng (Loop=9,AD=$FF,SR=$E0).brr"
  insert ConJY, "BRR/24. j (Loop=9,AD=$FF,SR=$E0).brr"

  // Vowels
  insert VowEA, "BRR/27. e (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowEE, "BRR/28. i (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowIE, "BRR/29. ie (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowAU, "BRR/31. au (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowOO, "BRR/33. o (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowOU, "BRR/34. ou (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowUE, "BRR/35. u (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowER, "BRR/38. er (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowAA, "BRR/40. a (Loop=9,AD=$FF,SR=$E0).brr"
  insert VowAW, "BRR/42. aw (Loop=9,AD=$FF,SR=$E0).brr"