// SNES Monster Farm Jump Game by krom (Peter Lemon):
arch snes.cpu
output "MonsterFarmJump.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $38000 // Fill Upto $FFFF (Bank 6) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_INPUT.INC"  // Include Input Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

  //-----------
  // Tecmo Logo
  //-----------
  include "TecmoLogo.asm" // Include Tecmo Logo Routine

  //-------------
  // Title Screen
  //-------------
  include "TitleScreen.asm" // Include Title Screen Routine

  //--------------
  // Course Select
  //--------------
  include "CourseSelect.asm" // Include Course Select Routine

  //-----------------
  // Character Select
  //-----------------
  include "CharacterSelect.asm" // Include Character Select Routine

Loop:
  jmp Loop

TitleScreenHDMATable:
  db 128, %01100011 // Repeat 128 Scanlines, Object Size = 16x16/32x32, Name = 0, Base = $C000
  db   1, %01100010 // Repeat   1 Scanlines, Object Size = 16x16/32x32, Name = 0, Base = $8000
  db 0 // End Of HDMA

CourseSelectHDMATable:
  db 128, %01100011 // Repeat 128 Scanlines, Object Size = 16x16/32x32, Name = 0, Base = $C000
  db  56, %01100011 // Repeat  56 Scanlines, Object Size = 16x16/32x32, Name = 0, Base = $C000
  db   1, %00000010 // Repeat   1 Scanlines, Object Size =   8x8/16x16, Name = 0, Base = $8000
  db 0 // End Of HDMA

CharacterSelectHDMATable:
  db 124, %01100011 // Repeat 124 Scanlines, Object Size = 16x16/32x32, Name = 0, Base = $C000
  db   1, %00000010 // Repeat   1 Scanlines, Object Size =   8x8/16x16, Name = 0, Base = $8000
  db 0 // End Of HDMA

TitleScreenOAM:
  include "TitleScreenOAM.asm" // Include OAM Table

CourseSelectOAM:
  include "CourseSelectOAM.asm" // Include OAM Table

CharacterSelectOAM:
  include "CharacterSelectOAM.asm" // Include OAM Table

// Character Data
// BANK 1
seek($18000)
insert TecmoPal,   "GFX/TecmoLogo/Tecmo2BPP.pal" // Include BG Palette Data (8 Bytes)
insert TecmoMap,   "GFX/TecmoLogo/Tecmo2BPP.map" // Include BG Map Data (3584 Bytes)
insert TecmoTiles, "GFX/TecmoLogo/Tecmo2BPP.pic" // Include BG Tile Data (3936 Bytes)

insert TecmoHiLightPal,   "GFX/TecmoLogo/TecmoHiLight4BPP.pal" // Include BG Palette Data (32 Bytes)
insert TecmoHiLightMap,   "GFX/TecmoLogo/TecmoHiLight4BPP.map" // Include BG Map Data (3584 Bytes)
insert TecmoHiLightTiles, "GFX/TecmoLogo/TecmoHiLight4BPP.pic" // Include BG Tile Data (6400 Bytes)

insert TecmoMiniPal,   "GFX/TitleScreen/TecmoMini4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert TecmoMiniTiles, "GFX/TitleScreen/TecmoMini4BPP.pic" // Include Sprite Tile Data (768 Bytes)

insert TecmoCopyrightPal,   "GFX/TitleScreen/TecmoCopyright4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert TecmoCopyrightTiles, "GFX/TitleScreen/TecmoCopyright4BPP.pic" // Include Sprite Tile Data (1056 Bytes)

insert PressStartButtonPal,   "GFX/TitleScreen/PressStartButton4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert PressStartButtonTiles, "GFX/TitleScreen/PressStartButton4BPP.pic" // Include Sprite Tile Data (960 Bytes)

// BANK 2
seek($28000)
insert MonsterFarmJumpPal,   "GFX/TitleScreen/MonsterFarmJump8BPP.pal" // Include BG Palette Data (256 Bytes)
insert MonsterFarmJumpMap,   "GFX/TitleScreen/MonsterFarmJump8BPP.map" // Include BG Map Data (16384 Bytes)
insert MonsterFarmJumpTiles, "GFX/TitleScreen/MonsterFarmJump8BPP.pic" // Include BG Tile Data (15360 Bytes)

// BANK 3
seek($38000)
insert ComicAPal,   "GFX/TitleScreen/ComicA4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicATiles, "GFX/TitleScreen/ComicA4BPP.pic" // Include Sprite Tile Data (8192 Bytes)

insert ComicBPal,   "GFX/TitleScreen/ComicB4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicBTiles, "GFX/TitleScreen/ComicB4BPP.pic" // Include Sprite Tile Data (8192 Bytes)

insert ComicCPal,   "GFX/TitleScreen/ComicC4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicCTiles, "GFX/TitleScreen/ComicC4BPP.pic" // Include Sprite Tile Data (6144 Bytes)

insert ComicDPal,   "GFX/TitleScreen/ComicD4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicDTiles, "GFX/TitleScreen/ComicD4BPP.pic" // Include Sprite Tile Data (6144 Bytes)

insert CourseSelectDarkBlendMap,   "GFX/CourseSelect/CourseSelectDarkBlend8BPP.map" // Include BG Map Data (2048 Bytes)
insert CourseSelectDarkBlendTiles, "GFX/CourseSelect/CourseSelectDarkBlend8BPP.pic" // Include BG Tile Data (576 Bytes)

// BANK 4
seek($48000)
insert ComicPal,   "GFX/Comic4BPP.pal" // Include BG Palette Data (256 Bytes)
insert ComicMap,   "GFX/Comic4BPP.map" // Include BG Map Data (1792 Bytes)
insert ComicTiles, "GFX/Comic4BPP.pic" // Include BG Tile Data (28672 Bytes)

// BANK 5
seek($58000)
insert CourseSelectPal,   "GFX/CourseSelect/CourseSelect4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseSelectTiles, "GFX/CourseSelect/CourseSelect4BPP.pic" // Include Sprite Tile Data (6144 Bytes)

insert CourseBorderTiles, "GFX/CourseSelect/CourseBorder4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert CourseEasyDarkPal, "GFX/CourseSelect/CourseEasyDark4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseEasyPal,     "GFX/CourseSelect/CourseEasy4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseEasyTiles,   "GFX/CourseSelect/CourseEasy4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert CourseHardDarkPal, "GFX/CourseSelect/CourseHardDark4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseHardPal,     "GFX/CourseSelect/CourseHard4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseHardTiles,   "GFX/CourseSelect/CourseHard4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert CourseNormalDarkPal, "GFX/CourseSelect/CourseNormalDark4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseNormalPal,     "GFX/CourseSelect/CourseNormal4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseNormalTiles,   "GFX/CourseSelect/CourseNormal4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert CourseVeryHardDarkPal, "GFX/CourseSelect/CourseVeryHardDark4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseVeryHardPal,     "GFX/CourseSelect/CourseVeryHard4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CourseVeryHardTiles,   "GFX/CourseSelect/CourseVeryHard4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert FontPal,   "GFX/Font4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert FontTiles, "GFX/Font4BPP.pic" // Include Sprite Tile Data (5632 Bytes)

insert CharacterSelectDarkBlendMap,   "GFX/CharacterSelect/CharacterSelectDarkBlend8BPP.map" // Include BG Map Data (2048 Bytes)
insert CharacterSelectDarkBlendTiles, "GFX/CharacterSelect/CharacterSelectDarkBlend8BPP.pic" // Include BG Tile Data (832 Bytes)

insert CharacterSelectPal,   "GFX/CharacterSelect/CharacterSelect4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterSelectTiles, "GFX/CharacterSelect/CharacterSelect4BPP.pic" // Include Sprite Tile Data (6144 Bytes)

// BANK 6
seek($68000)
insert CharacterRoochoDarkPal, "GFX/CharacterSelect/CharacterRoochoDark4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterRoochoPal,     "GFX/CharacterSelect/CharacterRoocho4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterRoochoTiles,   "GFX/CharacterSelect/CharacterRoocho4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert CharacterBeochiDarkPal, "GFX/CharacterSelect/CharacterBeochiDark4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterBeochiPal,     "GFX/CharacterSelect/CharacterBeochi4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterBeochiTiles,   "GFX/CharacterSelect/CharacterBeochi4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert CharacterChitoDarkPal, "GFX/CharacterSelect/CharacterChitoDark4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterChitoPal,     "GFX/CharacterSelect/CharacterChito4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterChitoTiles,   "GFX/CharacterSelect/CharacterChito4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert CharacterGolemDarkPal, "GFX/CharacterSelect/CharacterGolemDark4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterGolemPal,     "GFX/CharacterSelect/CharacterGolem4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterGolemTiles,   "GFX/CharacterSelect/CharacterGolem4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert CharacterArrowPal,     "GFX/CharacterSelect/CharacterArrow4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CharacterArrowTiles,   "GFX/CharacterSelect/CharacterArrow4BPP.pic" // Include Sprite Tile Data (1024 Bytes)