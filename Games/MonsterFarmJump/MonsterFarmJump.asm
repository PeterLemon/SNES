// SNES Monster Farm Jump Game by krom (Peter Lemon):
arch snes.cpu
output "MonsterFarmJump.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $80000 // Fill Upto $FFFF (Bank 15) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_INPUT.INC"  // Include Input Macros

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
CourseCharacterSelect:
  db %00000000 // Course Select (0=Easy, 1=Normal, 2=Hard, 3=Very Hard), Character Select (4=Roocho, 5=Beochi, 6=Chito, 7=Golem) Byte
Mode7PosX:
  dw 0 // Mode7 Center Position X Word
Mode7PosY:
  dw 0 // Mode7 Center Position Y Word
BG1ScrPosX:
  dw 0 // Mode7 BG1 Scroll Position X Word
BG1ScrPosY:
  dw 0 // Mode7 BG1 Scroll Position Y Word

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

  //---------------------
  // Course Easy Stage 01
  //---------------------
  include "CourseEasyStage01.asm" // Include Stage Routine

Loop:
  jmp Loop

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
insert TecmoCopyrightTiles, "GFX/TitleScreen/TecmoCopyright4BPP.pic" // Include Sprite Tile Data (1024 Bytes)

insert PressStartButtonPal,   "GFX/TitleScreen/PressStartButton4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert PressStartButtonTiles, "GFX/TitleScreen/PressStartButton4BPP.pic" // Include Sprite Tile Data (960 Bytes)

// BANK 2
seek($28000)
insert MonsterFarmJumpPal,   "GFX/TitleScreen/MonsterFarmJump8BPP.pal" // Include BG Palette Data (192 Bytes)
insert MonsterFarmJumpMap,   "GFX/TitleScreen/MonsterFarmJump8BPP.map" // Include BG Map Data (16384 Bytes)
insert MonsterFarmJumpTiles, "GFX/TitleScreen/MonsterFarmJump8BPP.pic" // Include BG Tile Data (15360 Bytes)

// BANK 3
seek($38000)
insert ComicAPal,   "GFX/TitleScreen/ComicA4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicATiles, "GFX/TitleScreen/ComicA4BPP.pic" // Include Sprite Tile Data (8192 Bytes)

insert ComicBPal,   "GFX/TitleScreen/ComicB4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicBTiles, "GFX/TitleScreen/ComicB4BPP.pic" // Include Sprite Tile Data (8192 Bytes)

insert ComicCPal,   "GFX/TitleScreen/ComicC4BPP.pal" // Include BG/Sprite Palette Data (32 Bytes)
insert ComicCTiles, "GFX/TitleScreen/ComicC4BPP.pic" // Include BG/Sprite Tile Data (6144 Bytes)

insert ComicDPal,   "GFX/TitleScreen/ComicD4BPP.pal" // Include BG/Sprite Palette Data (32 Bytes)
insert ComicDTiles, "GFX/TitleScreen/ComicD4BPP.pic" // Include BG/Sprite Tile Data (6144 Bytes)

ComicCDMap:
  include "GFX/TitleScreen/ComicCD4BPPMap.asm" // Include BG Map Data (768 Bytes)

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

// BANK 7
seek($78000)
insert HiScoreLifeHeartPal, "GFX/Course/HiScoreLifeHeart4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert HiScoreTiles,        "GFX/Course/HiScore4BPP.pic" // Include Sprite Tile Data (512 Bytes)
insert LifeHeartTiles,      "GFX/Course/LifeHeart4BPP.pic" // Include Sprite Tile Data (128 Bytes)

insert DistanceGoalLifeScoreTimePal,   "GFX/Course/DistanceGoalLifeScoreTime4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert DistanceGoalLifeScoreTimeTiles, "GFX/Course/DistanceGoalLifeScoreTime4BPP.pic" // Include Sprite Tile Data (2048 Bytes)

insert ScoreNumberPal,       "GFX/Course/ScoreNumber4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert TimeNumberPal,        "GFX/Course/TimeNumber4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ScoreTimeNumberTiles, "GFX/Course/ScoreTimeNumber4BPP.pic" // Include Sprite Tile Data (3584 Bytes)

insert DistanceMarkerRoochoPal,   "GFX/Course/DistanceMarkerRoocho4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert DistanceMarkerRoochoTiles, "GFX/Course/DistanceMarkerRoocho4BPP.pic" // Include Sprite Tile Data (256 Bytes)

insert DistanceMarkerBeochiPal,   "GFX/Course/DistanceMarkerBeochi4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert DistanceMarkerBeochiTiles, "GFX/Course/DistanceMarkerBeochi4BPP.pic" // Include Sprite Tile Data (256 Bytes)

insert DistanceMarkerChitoPal,   "GFX/Course/DistanceMarkerChito4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert DistanceMarkerChitoTiles, "GFX/Course/DistanceMarkerChito4BPP.pic" // Include Sprite Tile Data (256 Bytes)

insert DistanceMarkerGolemPal,   "GFX/Course/DistanceMarkerGolem4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert DistanceMarkerGolemTiles, "GFX/Course/DistanceMarkerGolem4BPP.pic" // Include Sprite Tile Data (256 Bytes)

insert CloudDayPal,   "GFX/Course/CloudDay4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert CloudDayTiles, "GFX/Course/CloudDay4BPP.pic" // Include Sprite Tile Data (6144 Bytes)

insert ShadowPal,   "GFX/Character/Shadow4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ShadowTiles, "GFX/Character/Shadow4BPP.pic" // Include Sprite Tile Data (512 Bytes)

// BANK 8
seek($88000)
insert CourseEasyStage01Pal,   "GFX/Course/Easy/CourseEasyStage01.pal" // Include BG Palette Data (256 Bytes)
insert CourseEasyStage01Map,   "GFX/Course/Easy/CourseEasyStage01.map" // Include BG Map Data (16384 Bytes)
insert CourseEasyStage01Tiles, "GFX/Course/Easy/CourseEasyStage01.pic" // Include BG Tile Data (13376 Bytes)

// BANK 9
seek($98000)
insert RoochoJumpUpPal,   "GFX/Character/Roocho/RoochoJumpUp4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert RoochoJumpUpTiles, "GFX/Character/Roocho/RoochoJumpUp4BPP.pic" // Include Sprite Tile Data (4096 Bytes)

insert BeochiJumpUpPal,   "GFX/Character/Beochi/BeochiJumpUp4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert BeochiJumpUpTiles, "GFX/Character/Beochi/BeochiJumpUp4BPP.pic" // Include Sprite Tile Data (4096 Bytes)

insert ChitoJumpUpPal,   "GFX/Character/Chito/ChitoJumpUp4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ChitoJumpUpTiles, "GFX/Character/Chito/ChitoJumpUp4BPP.pic" // Include Sprite Tile Data (4096 Bytes)

insert GolemJumpUpPal,   "GFX/Character/Golem/GolemJumpUp4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert GolemJumpUpTiles, "GFX/Character/Golem/GolemJumpUp4BPP.pic" // Include Sprite Tile Data (4096 Bytes)