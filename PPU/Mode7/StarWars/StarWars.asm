// SNES Star Wars demo by krom (Peter Lemon):
arch snes.cpu
output "StarWars.sfc", create

macro TextMap(OFFSET, SIZE, TEXT) {
  variable offset({OFFSET})

  // Map Font HI
  map ' ', $00
  map 'W', $030201
  map 'A', $0504
  map 'B', $0706
  map 'C', $0908
  map 'D', $0B0A
  map 'E', $0D0C
  map 'F', $0F0E
  map 'G', $2120
  map 'H', $2322
  map 'I', $24
  map 'J', $25
  map 'K', $2726
  map 'L', $2928
  map 'M', $2B2A
  map 'N', $2D2C
  map 'O', $2F2E
  map 'P', $4140
  map 'R', $4342
  map 'S', $4544
  map 'T', $4746
  map 'U', $4948
  map 'V', $4B4A
  map 'X', $4D4C
  map 'Y', $4F4E
  map 'Z', $6160
  map 'a', $6362
  map 'b', $6564
  map 'c', $6766
  map 'd', $6968
  map 'e', $6B6A
  map 'f', $6C
  map 'h', $6E6D
  map 'i', $6F
  map 'k', $8180
  map 'l', $82
  map 'm', $8483
  map 'n', $8685
  map 'o', $8887
  map 'r', $89
  map 's', $8B8A
  map 't', $8C
  map 'u', $8E8D
  map $2C, $00 // map ','
  map 'v', $A1A0
  map 'w', $A3A2
  map 'x', $A5A4
  map 'g', $A7A6
  map 'p', $A9A8
  map 'q', $ABAA
  map 'y', $ADAC
  map 'Q', $AFAE
  map '@', $CAC9
  map '.', $00
  map ':', $CE // Combine 2 Full Stops
  map $3B, $CE // Combine Full Stop & Comma (map ';')
  map 'z', $C1C0
  map '!', $C2
  map '?', $C4C3
  map '-', $00
  map '_', $0000
  map '&', $E1E0
  map '*', $E3E2
  map '`', $E4
  map '+', $E6E5
  map 'j', $D7
  map '\s', $F8 // map "'"
  map '\', $00D8
  map '/', $DB00
  map '\d', $FB // map '"'
  map '(', $DC
  map ')', $DD
  map '[', $DE
  map ']', $DF

  origin offset // Offset
  {SIZE} {TEXT}

  // Map Font MID
  map ' ', $00
  map 'W', $131211
  map 'A', $1514
  map 'B', $1716
  map 'C', $1918
  map 'D', $1B1A
  map 'E', $1D1C
  map 'F', $1F1E
  map 'G', $3130
  map 'H', $3332
  map 'I', $34
  map 'J', $35
  map 'K', $3736
  map 'L', $3938
  map 'M', $3B3A
  map 'N', $3D3C
  map 'O', $3F3E
  map 'P', $5150
  map 'R', $5352
  map 'S', $5554
  map 'T', $5756
  map 'U', $5958
  map 'V', $5B5A
  map 'X', $5D5C
  map 'Y', $5F5E
  map 'Z', $7170
  map 'a', $7372
  map 'b', $7574
  map 'c', $7776
  map 'd', $7978
  map 'e', $7B7A
  map 'f', $7C
  map 'h', $7E7D
  map 'i', $7F
  map 'k', $9190
  map 'l', $92
  map 'm', $9493
  map 'n', $9695
  map 'o', $9897
  map 'r', $99
  map 's', $9B9A
  map 't', $9C
  map 'u', $9E9D
  map $2C, $8F // map ','
  map 'v', $B1B0
  map 'w', $B3B2
  map 'x', $B5B4
  map 'g', $B7B6
  map 'p', $B9B8
  map 'q', $BBBA
  map 'y', $BDBC
  map 'Q', $BFBE
  map '@', $DAD9
  map '.', $CE
  map ':', $CE // Combine 2 Full Stops
  map $3B, $8F // Combine Full Stop & Comma (map ';')
  map 'z', $D1D0
  map '!', $D2
  map '?', $D4D3
  map '-', $C5
  map '_', $0000
  map '&', $F1F0
  map '*', $F3F2
  map '`', $F4
  map '+', $F6F5
  map 'j', $E7
  map '\s', $00 // map "'"
  map '\', $E9E8
  map '/', $EBEA
  map '\d', $00 // map '"'
  map '(', $EC
  map ')', $ED
  map '[', $EE
  map ']', $EF

  origin offset+128 // Offset
  {SIZE} {TEXT}

  // Map Font LO
  map ' ', $00
  map 'W', $000000
  map 'A', $0000
  map 'B', $0000
  map 'C', $0000
  map 'D', $0000
  map 'E', $0000
  map 'F', $0000
  map 'G', $0000
  map 'H', $0000
  map 'I', $00
  map 'J', $00
  map 'K', $0000
  map 'L', $0000
  map 'M', $0000
  map 'N', $0000
  map 'O', $0000
  map 'P', $0000
  map 'R', $0000
  map 'S', $0000
  map 'T', $0000
  map 'U', $0000
  map 'V', $0000
  map 'X', $0000
  map 'Y', $0000
  map 'Z', $0000
  map 'a', $0000
  map 'b', $0000
  map 'c', $0000
  map 'd', $0000
  map 'e', $0000
  map 'f', $00
  map 'h', $0000
  map 'i', $00
  map 'k', $0000
  map 'l', $00
  map 'm', $0000
  map 'n', $0000
  map 'o', $0000
  map 'r', $00
  map 's', $0000
  map 't', $00
  map 'u', $0000
  map $2C, $9F // map ','
  map 'v', $0000
  map 'w', $0000
  map 'x', $0000
  map 'g', $C7C6
  map 'p', $00C8
  map 'q', $CB00
  map 'y', $CDCC
  map 'Q', $CF00
  map '@', $0000
  map '.', $00
  map ':', $00 // Combine 2 Full Stops
  map $3B, $9F // Combine Full Stop & Comma (map ';')
  map 'z', $0000
  map '!', $00
  map '?', $0000
  map '-', $00 // C5
  map '_', $D6D5
  map '&', $0000
  map '*', $0000
  map '`', $00
  map '+', $0000
  map 'j', $F7
  map '\s', $00 // map "'"
  map '\', $F900
  map '/', $00FA
  map '\d', $00 // map '"'
  map '(', $FC
  map ')', $FD
  map '[', $FE
  map ']', $FF

  origin offset+256 // Offset
  {SIZE} {TEXT}
}

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $20000 // Fill Upto $1FFFF (Bank 4) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

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
StageMapOffset:
  dw 0 // Stage Map Offset Word

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  //-------
  // Intro
  //-------
  include "Intro.asm" // Include Intro Routine

  //------
  // Logo
  //------
  include "Logo.asm" // Include Logo Routine

  //----------
  // Scroller
  //----------
  include "Scroller.asm" // Include Scroller Routine

Loop:
  jmp Loop

// Palette Data
// BANK 0
insert LogoPal, "GFX/StarWarsLogo.pal" // Include BG Palette Data (6 Bytes)
insert FontBluePal,   "GFX/StarWarsFontBlue.pal"   // Include BG Palette Data (64 Bytes)
insert FontYellowPal, "GFX/StarWarsFontYellow.pal" // Include BG Palette Data (64 Bytes)

// Character Data
// BANK 1
seek($18000)
insert LogoTiles, "GFX/StarWarsLogo.pic" // Include BG Tile Data (16384 Bytes)
insert LogoMap, "GFX/StarWarsLogo.map" // Include BG Map Data (16384 Bytes)

// Character Data
// BANK 2
seek($28000)
insert FontTiles, "GFX/StarWarsFont.pic" // Include BG Tile Data (16384 Bytes)

ScrollerFontMap:
  TextMap(origin()+42, db, "It i")
  TextMap(origin()-256, dw, "s")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "pe")
  TextMap(origin()-256, db, "ri")
  TextMap(origin()-256, dw, "od")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, "f  ")
  TextMap(origin()-256, dw, "c")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "v")
  TextMap(origin()-256, db, "il  ")
  TextMap(origin()-256, dw, "wa")
  TextMap(origin()-256, db, "r.")

  TextMap(origin()+212, dw, "Rebe")
  TextMap(origin()-256, db, "l  ")
  TextMap(origin()-256, dw, "spacesh")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "ps")
  TextMap(origin()-256, db, ", ")
  TextMap(origin()-256, dw, "s")
  TextMap(origin()-256, db, "tri")
  TextMap(origin()-256, dw, "k")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "ng")

  TextMap(origin()+212, db, "fr")
  TextMap(origin()-256, dw, "om")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "h")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "dden")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "base")
  TextMap(origin()-256, db, ",  ")
  TextMap(origin()-256, dw, "have")

  TextMap(origin()+212, dw, "won")
  TextMap(origin()-256, db, "    t")
  TextMap(origin()-256, dw, "he")
  TextMap(origin()-256, db, "ir")
  TextMap(origin()-256, db, "     fir")
  TextMap(origin()-256, dw, "s")
  TextMap(origin()-256, db, "t     ")
  TextMap(origin()-256, dw, "v")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "c")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "y")

  TextMap(origin()+212, dw, "aga")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "ns")
  TextMap(origin()-256, db, "t   t")
  TextMap(origin()-256, dw, "he")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "ev")
  TextMap(origin()-256, db, "il   ")
  TextMap(origin()-256, dw, "Ga")
  TextMap(origin()-256, db, "l")
  TextMap(origin()-256, dw, "ac")
  TextMap(origin()-256, db, "ti")
  TextMap(origin()-256, dw, "c")

  TextMap(origin()+212, dw, "Emp")
  TextMap(origin()-256, db, "ir")
  TextMap(origin()-256, dw, "e")
  TextMap(origin()-256, db, ".")

  TextMap(origin()+757, dw, "Du")
  TextMap(origin()-256, db, "ri")
  TextMap(origin()-256, dw, "ng")
  TextMap(origin()-256, db, "    t")
  TextMap(origin()-256, dw, "he")
  TextMap(origin()-256, db, "    ")
  TextMap(origin()-256, dw, "ba")
  TextMap(origin()-256, db, "ttl")
  TextMap(origin()-256, dw, "e")
  TextMap(origin()-256, db, ",   ")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "ebe")
  TextMap(origin()-256, db, "l")

  TextMap(origin()+212, dw, "sp")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "es")
  TextMap(origin()-256, db, "    ")
  TextMap(origin()-256, dw, "managed")
  TextMap(origin()-256, db, "   t")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, "   ")
  TextMap(origin()-256, dw, "s")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "ea")
  TextMap(origin()-256, db, "l")

  TextMap(origin()+212, dw, "sec")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "e")
  TextMap(origin()-256, db, "t ")
  TextMap(origin()-256, dw, "p")
  TextMap(origin()-256, db, "l")
  TextMap(origin()-256, dw, "ans")
  TextMap(origin()-256, db, " t")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, " t")
  TextMap(origin()-256, dw, "he")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "Emp")
  TextMap(origin()-256, db, "ir")
  TextMap(origin()-256, dw, "e")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "s")

  TextMap(origin()-515, db, ",")

  TextMap(origin()+470, dw, "u")
  TextMap(origin()-256, db, " l t i ")
  TextMap(origin()-256, dw, "m")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, " t ")
  TextMap(origin()-256, dw, "e")
  TextMap(origin()-256, db, "    ")
  TextMap(origin()-256, dw, "weapon")
  TextMap(origin()-256, db, ",   t")
  TextMap(origin()-256, dw, "he")

  TextMap(origin()+212, dw, "DEATH")
  TextMap(origin()-256, db, "   ")
  TextMap(origin()-256, dw, "STAR")
  TextMap(origin()-256, db, ",   ")
  TextMap(origin()-256, dw, "an")
  TextMap(origin()-256, db, "   ")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "mo")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "ed")

  TextMap(origin()+212, dw, "space")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "s")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, "ti")
  TextMap(origin()-256, dw, "on")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "w")
  TextMap(origin()-256, db, "it")
  TextMap(origin()-256, dw, "h")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "enough")

  TextMap(origin()+212, dw, "powe")
  TextMap(origin()-256, db, "r  t")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "des")
  TextMap(origin()-256, db, "tr")
  TextMap(origin()-256, dw, "oy")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "an")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "en")
  TextMap(origin()-256, db, "tir")
  TextMap(origin()-256, dw, "e")

  TextMap(origin()+212, dw, "p")
  TextMap(origin()-256, db, "l")
  TextMap(origin()-256, dw, "ane")
  TextMap(origin()-256, db, "t.")

  TextMap(origin()+757, dw, "Pu")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "sued")
  TextMap(origin()-256, db, "   ")
  TextMap(origin()-256, dw, "by")
  TextMap(origin()-256, db, "   t")
  TextMap(origin()-256, dw, "he")
  TextMap(origin()-256, db, "   ")
  TextMap(origin()-256, dw, "Emp")
  TextMap(origin()-256, db, "ir")
  TextMap(origin()-256, dw, "e")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "s")

  TextMap(origin()-515, db, ",")

  TextMap(origin()+470, dw, "s")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "n")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "s")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "e")  
  TextMap(origin()-256, db, "r   ")
  TextMap(origin()-256, dw, "agen")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "s")
  TextMap(origin()-256, db, ",   ")
  TextMap(origin()-256, dw, "P")
  TextMap(origin()-256, db, "ri")
  TextMap(origin()-256, dw, "ncess")

  TextMap(origin()+212, dw, "Le")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, " r")
  TextMap(origin()-256, dw, "aces")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "home")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "aboa")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "d")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "he")
  TextMap(origin()-256, db, "r")

  TextMap(origin()+212, dw, "s")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "sh")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "p")
  TextMap(origin()-256, db, ",  ")
  TextMap(origin()-256, dw, "cus")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "od")
  TextMap(origin()-256, db, "i")
  TextMap(origin()-256, dw, "an")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, "f  t")
  TextMap(origin()-256, dw, "he")

  TextMap(origin()+212, dw, "s")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, "l")
  TextMap(origin()-256, dw, "en")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "p")
  TextMap(origin()-256, db, "l")
  TextMap(origin()-256, dw, "ans")
  TextMap(origin()-256, db, "  t")
  TextMap(origin()-256, dw, "ha")
  TextMap(origin()-256, db, "t ")
  TextMap(origin()-256, dw, "can")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "save")

  TextMap(origin()+212, dw, "he")
  TextMap(origin()-256, db, "r   ")
  TextMap(origin()-256, dw, "peop")
  TextMap(origin()-256, db, "l")
  TextMap(origin()-256, dw, "e")
  TextMap(origin()-256, db, "    ")
  TextMap(origin()-256, dw, "and")
  TextMap(origin()-256, db, "    r")
  TextMap(origin()-256, dw, "es")
  TextMap(origin()-256, db, "t")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, "r")
  TextMap(origin()-256, dw, "e")

  TextMap(origin()+212, db, "fr")
  TextMap(origin()-256, dw, "eedom")
  TextMap(origin()-256, db, "  t")
  TextMap(origin()-256, dw, "o")
  TextMap(origin()-256, db, "  t")
  TextMap(origin()-256, dw, "he")
  TextMap(origin()-256, db, "  ")
  TextMap(origin()-256, dw, "ga")
  TextMap(origin()-256, db, "l")
  TextMap(origin()-256, dw, "axy")
  TextMap(origin()-256, db, "....")

// BANK 3
seek($38000)
insert StarsPal,   "GFX/StarWarsStars.pal" // Include BG Palette Data (32 Bytes)
insert StarsTiles, "GFX/StarWarsStars.pic" // Include BG Tile Data (28672 Bytes)

IntroFontMap:
  TextMap(origin()+39, dw, "A")
  TextMap(origin()-256, db, " l")
  TextMap(origin()-256, dw, "ong")
  TextMap(origin()-256, db, " ti")
  TextMap(origin()-256, dw, "me")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "ago")
  TextMap(origin()-256, db, " i")
  TextMap(origin()-256, dw, "n")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, " ")
  TextMap(origin()-256, dw, "ga")
  TextMap(origin()-256, db, "l")
  TextMap(origin()-256, dw, "axy")
  TextMap(origin()-256, db, " f")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, "r,")

  TextMap(origin()+207, db, "f")
  TextMap(origin()-256, dw, "a")
  TextMap(origin()-256, db, "r ")
  TextMap(origin()-256, dw, "away")
  TextMap(origin()-256, db, "....")