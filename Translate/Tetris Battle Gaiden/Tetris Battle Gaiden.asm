// SNES "Tetris Battle Gaiden" Japanese To English Translation by krom (Peter Lemon):

output "Tetris Battle Gaiden.sfc", create
origin $00000; insert "Tetris Battle Gaiden (J).sfc" // Include Japanese Tetris Battle Gaiden SNES ROM

//macro TextStyle1(OFFSET, TEXT) {
//  origin {OFFSET}
//  db {TEXT}
//  db $FF
//}

macro TextStyle2(OFFSET, TEXT) {
  // Map Font HI
  map ' ', $20, 16

  origin {OFFSET} // Offset
  variable labeloffset(+)
  variable length(labeloffset - {OFFSET} - 1)
  db length
  db {TEXT}
  +
  db $94, $00

  // Map Font LO
  map ' ', $30, 16

  origin {OFFSET} + (length + 3) // Offset
  db length
  db {TEXT}
  db $94, $00
}

// SETTING
// BACK GROUND
origin $00C87
dw SETTINGBACKGROUND + $8000

origin $00CA0
dw SETTINGSTEREOMONO + $8000

origin $01950
SETTINGBACKGROUND:
  dw TWOPLAYERBGText + $8000
  dw HALLOWEENText + $8000
  dw MIRURUNText + $8000
  dw SHAMANText + $8000
  dw ALADDINText + $8000
  dw PRINCESSText + $8000
  dw BITText + $8000
  dw NINJAText + $8000
  dw WOLFMANText + $8000
  dw DRAGONText + $8000
  dw QUEENText + $8000
TWOPLAYERBGText:
  db "2PLAYERBG", $FF
HALLOWEENText:
  db "HALLOWEEN", $FF
MIRURUNText:
  db "MIRURUN  ", $FF
SHAMANText:
  db "SHAMAN   ", $FF
ALADDINText:
  db "ALADDIN  ", $FF
PRINCESSText:
  db "PRINCESS ", $FF
BITText:
  db "BIT      ", $FF
NINJAText:
  db "NINJA    ", $FF
WOLFMANText:
  db "WOLFMAN  ", $FF
DRAGONText:
  db "DRAGON   ", $FF
QUEENText:
  db "QUEEN    ", $FF

// STEREO/MONO
SETTINGSTEREOMONO:
  dw STEREOText + $8000
  dw MONOText + $8000
STEREOText:
  db "STEREO", $FF
MONOText:
  db "MONO  ", $FF

// INTRO
origin $1B283
db "LIKES:    "
db " CHOCOLATE"
db "      CAKE"
db "HATES:    "
db "PUMPKINPIE"
db "BORN IN:  "
db " A PUMPKIN"
db "     FIELD"
db "      ", $00, $00, $00

origin $1B2ED
db "LIKES:    "
db "   FRIENDS"
db "HATES:    "
db " HALLOWEEN"
db "          "
db "BORN IN:  "
db "  A BAMBOO"
db "    GARDEN"
db "    ", $00, $00

origin $1B355
db "LIKES:    "
db "   DANCING"
db "HATES:    "
db "   THUNDER"
db "          "
db "BORN IN:  "
db "    YANBOO"
db "    FOREST"
db "  ", $00, $00

origin $1B3BB
db "LIKES:    "
db "   DREAMS,"
db " ADVENTURE"
db "HATES:    "
db " REAL LIFE"
db "          "
db "BORN IN:  "
db "   NAKADAT"
db "      ", $00, $00

origin $1B425
db "LIKES:    "
db "CHEESECAKE"
db "      DOGS"
db "HATES:    "
db "EARTHWORMS"
db "     SLUGS"
db "BORN IN:  "
db "    L-SHIP"
db "        ", $00, $00, $00

origin $1B491
db "LIKES:    "
db "FUN, JOKES"
db "HATES:    "
db "   SILENCE"
db "          "
db "BORN IN:  "
db "  SUNHOUSE"
db "     HILLS"
db "  ", $00, $00

origin $1B4F7
db "LIKES:    "
db " CHOCOLATE"
db "          "
db "HATES:    "
db " COCKROACH"
db "          "
db "BORN IN:  "
db "     GEKKO"
db "    ", $00

origin $1B55F
db "LIKES:    "
db "ONION SOUP"
db "HATES:    "
db "  TOMATOES"
db "          "
db "BORN IN:  "
db " DOWNTOWN,"
db "     TOKYO"
db "    "

//TextStyle2($849F2, "!!!!!!!!!!!!")