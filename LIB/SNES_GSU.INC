//==========
// SNES GSU
//==========
// GSU Memory Map (SNES)
// $00..$3F/$80..$BF:$6000..$7FFF: Mirror Of $70:$0000..$1FFF (1st 8KB Of Game PAK RAM)
// $70..$71:$0000..$FFFF: Game Pak RAM (128KB Max, Usually 32KB Or 64KB)
// $78..$79:$0000..$FFFF: Additional Backup RAM (128KB Max, Usually None)

// GSU Memory Map (GSU)
// $00..$3F:$0000..$7FFF: Mirror of LoROM at 00-3F:8000-FFFF (for "GETB R15" vectors)
// $00..$3F:$8000..$FFFF: Game PAK ROM In LoROM Mapping (2MB Max)
// $40..$5F:$0000..$FFFF: Game PAK ROM In HiROM Mapping (Mirror Of Above 2MB)
// $70..$71:$0000..$FFFF: Game PAK RAM (128KB Max, Usually 32KB Or 64KB)
//      PBR:$0000..$01FF: Code-Cache (Manually Stored Opcodes)
// PBR Can Be Set To ROM/RAM/Cache Regions, ROMBR Only To ROM Region ($00..$5F), RAMBR Only To RAM Region ($70..$71)

// GSU CPU Registers - Access From SNES CPU For R0..R15 (Read/Write, 2 Byte)
// (During GSU Operation, Only SFR, SCMR, & VCR May Be Accessed From SNES CPU)
constant GSU_R0($3000)  // GSU R0:  Default Source/Destination Register
constant GSU_R1($3002)  // GSU R1:  PLOT Instruction (X Coordinate)
constant GSU_R2($3004)  // GSU R2:  PLOT Instruction (Y Coordinate)
constant GSU_R3($3006)  // GSU R3:  General Purpose Register
constant GSU_R4($3008)  // GSU R4:  LMULT Instruction (Lower 16-Bit Result)
constant GSU_R5($300A)  // GSU R5:  General Purpose Register
constant GSU_R6($300C)  // GSU R6:  FMULT & LMULT Instructions, Multiplier
constant GSU_R7($300E)  // GSU R7:  MERGE Instruction (Source 1)
constant GSU_R8($3010)  // GSU R8:  MERGE Instruction (Source 2)
constant GSU_R9($3012)  // GSU R9:  General Purpose Register
constant GSU_R10($3014) // GSU R10: General Purpose Register (Conventionally Stack Pointer)
constant GSU_R11($3016) // GSU R11: LINK Instruction Destination Register (Used For Return Address)
constant GSU_R12($3018) // GSU R12: LOOP Instruction Counter Register
constant GSU_R13($301A) // GSU R13: LOOP Instruction Branch Address Register
constant GSU_R14($301C) // GSU R14: Gamepak ROM Address Pointer For GETXX Opcodes
constant GSU_R15($301E) // GSU R15: Program Counter (Write MSB To Start Operation)

// GSU Pixel Registers - SNES CPU Access Disabled For COLR & POR Registers (1 Byte)
constant GSU_COLR($0000) // GSU COLR: Color Register (%PPPPPPPP: P = Palette Entry Used By Plot Instruction) (GSU Access Uses COLOR & GETC Instructions)
constant GSU_POR($0000)  // GSU POR:  Plot Option Register (GSU Access Uses CMODE Instruction)
// GSU Plot Option Register Flags: (%---OFHDT: O = Sprite Mode, F = Freeze Upper 4-Bit, H = Upper 4-Bit Color, D = Dither, T = Transparency)
constant GSU_POR_OPAQUE($01)         // GSU Plot Option Bit 0: Transparency To Plot Color 0 (0 = Don't Plot Color 0 (Transparency On), 1 = Plot Color 0) 
constant GSU_POR_DITHER($02)         // GSU Plot Option Bit 1: Dither (0 = Off, 1 = On) (4BPP Only: IF (R1 & 1 == R2 & 1) Plot Lower 4-Bit Of Color Register, ELSE Plot Upper 4-Bit Of Color Register)
constant GSU_POR_COLOR_SRC_HIGH($04) // GSU Plot Option Bit 2: Upper 4-Bit Color (0 = Off, 1 = On) (4BPP, Or 8BPP With F Set) When Enabled, Upper 4-Bit In Source Register Stored To Lower 4-Bit, When Using COLOR & GETC (Allows Data For 2 Pixels, Stored In 1 Byte)
constant GSU_POR_FIX_HIGH_4BITS($08) // GSU Plot Option Bit 3: Freeze Upper 4-Bit (0 = Off, 1 = On) (8BPP Only) Locks Upper 4-Bit Color Register While Processing COLOR & GETC, & Change Lower 4-Bit Only
constant GSU_POR_OBJ($10)            // GSU Plot Option Bit 4: Sprite Mode To Specify Bitmap (0 = Off, 1 = Specify Bitmap In Sprite Mode)

// GSU Status/Flag Register - Access From SNES CPU (Read/Write, 2 Byte)
constant GSU_SFR($3030) // GSU Status/Flag Register
// GSU Status/Flag Register Flags: (%I--BHL21-RGVSCZ-: I = Interrupt, B = Prefix (MOVE/MOVES), H = Immediate Upper 8-Bit, L = Immediate Lower 8-Bit, 2 & 1 = Prefix (ALT1/ALT2/ALT3), R = ROM[R14] Read, G = GSU Running, V = Overflow, S = Sign, C = Carry, Z = Zero)
constant GSU_SFR_ZERO($0002)     // GSU Status/Flag Bit  1: Zero Flag
constant GSU_SFR_CARRY($0004)    // GSU Status/Flag Bit  2: Carry Flag
constant GSU_SFR_SIGN($0008)     // GSU Status/Flag Bit  3: Sign Flag
constant GSU_SFR_OVERFLOW($0010) // GSU Status/Flag Bit  4: Overflow Flag
constant GSU_SFR_GSU($0020)      // GSU Status/Flag Bit  5: GSU Running (Cleared On STOP) (Set 0 To Force GSU Stop)
constant GSU_SFR_ROM($0040)      // GSU Status/Flag Bit  6: ROM[R14] Read (0 = Off, 1 = Read ROM Via R14 Address)
constant GSU_SFR_PF1($0100)      // GSU Status/Flag Bit  8: Prefix Flag 1 For ALT1/ALT2/ALT3
constant GSU_SFR_PF2($0200)      // GSU Status/Flag Bit  9: Prefix Flag 2 For ALT1/ALT2/ALT3
constant GSU_SFR_LO($0400)       // GSU Status/Flag Bit 10: Immediate Lower 8-Bit Flag (Set/Reset Internally When Processing Opcodes With Immediate Operands)
constant GSU_SFR_HI($0800)       // GSU Status/Flag Bit 11: Immediate Upper 8-Bit Flag (Set/Reset Internally When Processing Opcodes With Immediate Operands)
constant GSU_SFR_PFB($1000)      // GSU Status/Flag Bit 12: Prefix Flag B For MOVE/MOVES (WITH Prefix)
constant GSU_SFR_INT($8000)      // GSU Status/Flag Bit 15: Interrupt Flag (Reset On READ, Set On STOP) (Also Set IF IRQ Masked In GSU_CFGR ($3037))

// GSU Backup (S)RAM Register - Access From SNES CPU (Write Only, 1 Byte)
constant GSU_BRAMR($3033) // GSU Backup (S)RAM Register (0 = Disable BRAM, 1 = Enable BRAM)
// GSU Backup (S)RAM Register Flags: (%-------B: B = Disable/Enable BRAM)
constant GSU_BRAMR_DISABLE($00) // GSU Backup (S)RAM Bit 0: Disable BRAM
constant GSU_BRAMR_ENABLE($01)  // GSU Backup (S)RAM Bit 0:  Enable BRAM

// GSU Program Bank Register - Access From SNES CPU (Read/Write, 1 Byte)
constant GSU_PBR($3034) // GSU Program Bank Register (%BBBBBBBB: B = Bank) (Works Like SNES CPU Program Bank Register)
// GSU Game PAK ROM Bank Register - Access From SNES CPU (Read)
constant GSU_ROMBR($3036) // GSU Game PAK ROM Bank Register For ROM Buffering (%BBBBBBBB: B = Bank) (Specifies Bank For Instructions Using ROM Buffer)

// GSU Config Register - Access From SNES CPU (Write Only, 1 Byte)
constant GSU_CFGR($3037) // GSU Config Register
// GSU Config Register Flags: (%I-M-----: I = IRQ Mask, M = Multiplier Speed Select)
constant GSU_CFGR_FASTMUL($20)  // GSU Config Bit 7: Multiplier Speed Select (0 = Standard Speed, 1 = High Speed)
constant GSU_CFGR_IRQ_MASK($80) // GSU Config Bit 5: IRQ Mask (0 = Off, 1 = On) (Mask GSU Triggered IRQ)

// GSU Screen Base Register - Access From SNES CPU (Write Only, 1 Byte)
constant GSU_SCBR($3038) // GSU Screen Base Register (%AAAAAAAA: A = Start Address (1KB Units) For Plot Area)

// GSU Clock Select Register - Access From SNES CPU (Write Only, 1 Byte)
constant GSU_CLSR($3039) // GSU Clock Select Register (0 = 10.7MHz, 1 = 21.4MHz)
// GSU Clock Select Register Flags (%-------S: S = Clock Speed)
constant GSU_CLSR_10MHz($00) // GSU Clock Select Bit 0: Clock Speed 10.7MHz
constant GSU_CLSR_21MHz($01) // GSU Clock Select Bit 0: Clock Speed 21.4MHz

// GSU Screen Mode Register - Access From SNES CPU (Write Only, 1 Byte)
constant GSU_SCMR($303A) // GSU Screen Mode Register
// GSU Screen Mode Register Flags (%--HOAHCC: O = RON, A = RAN, H = Screen Height, C = Color Depth Mode)
constant GSU_SCMR_2BPP($00) // GSU Screen Mode Bit 0..1: Color Depth Mode 0 (2BPP)
constant GSU_SCMR_4BPP($01) // GSU Screen Mode Bit 0..1: Color Depth Mode 1 (4BPP)
constant GSU_SCMR_8BPP($03) // GSU Screen Mode Bit 0..1: Color Depth Mode 3 (8BPP)
constant GSU_SCMR_H128($00) // GSU Screen Mode Bit 2 & 5: Screen Height 0 (128 Pixels)
constant GSU_SCMR_H160($04) // GSU Screen Mode Bit 2 & 5: Screen Height 1 (160 Pixels)
constant GSU_SCMR_H192($20) // GSU Screen Mode Bit 2 & 5: Screen Height 2 (192 Pixels)
constant GSU_SCMR_OBJ($24)  // GSU Screen Mode Bit 2 & 5: Screen Height 4 (Object Mode)
constant GSU_RAN($08) // GSU Screen Mode Bit 3: RAN (0 = RAM Enable To Put GSU In WAIT Mode, Allows SCPU Access To Game PAK RAM, 1 = Give Game PAK RAM Access Back To GSU & Resume Processing)
constant GSU_RON($10) // GSU Screen Mode Bit 4: RON (0 = ROM Enable To Put GSU In WAIT Mode, Allows SCPU Access To Game PAK ROM, 1 = Give Game PAK ROM Access Back To GSU & Resume Processing)

// GSU Version Code Register - Access From SNES CPU (Read Only, 1 Byte)
constant GSU_VCR($303B) // GSU Version Code Register (%VVVVVVVV: V = Version Code) (1 = MARIO, 2 = GSU-0, 3 = GSU-1, 4 = GSU-2)
constant GSU_VCR_MARIO($01) // GSU Version Code Bit 0..7: Version Code 1 (MARIO Chip)
constant GSU_VCR_GSU0($02)  // GSU Version Code Bit 0..7: Version Code 2 (GSU-0 Chip)
constant GSU_VCR_GSU1($03)  // GSU Version Code Bit 0..7: Version Code 3 (GSU-1 Chip)
constant GSU_VCR_GSU2($04)  // GSU Version Code Bit 0..7: Version Code 4 (GSU-2 Chip)

// GSU Game PAK RAM Bank Register - Access From SNES CPU (Read Only, 1 Byte)
constant GSU_RAMBR($303C) // GSU Game PAK RAM Bank Register (0 = $70, 1 = $71)
// GSU Game PAK RAM Bank Register Flags (%-------A: A = Bank Select)
constant GSU_RAMBR_70($00) // GSU Game PAK RAM Bank Bit 0: Bank Select ($70)
constant GSU_RAMBR_71($01) // GSU Game PAK RAM Bank Bit 0: Bank Select ($71)

// GSU Cache Base Register - Access From SNES CPU (Read Only, 2 Byte)
constant GSU_CBR($303E) // GSU Cache Base Register (%CCCCCCCCCCCC----: C = Cache Address Base) (Starting Address When Data Is Loaded From ROM Or Game PAK RAM To Cache RAM)

// GSU Cache Start Exposed To SCPU - Access From SNES CPU (Write Only, 1 Byte)
constant GSU_CACHE($3100) // GSU Cache Start Exposed To SCPU (%CCCCCCCC: C = Cache Start Exposed To SCPU)