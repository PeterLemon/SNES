// SNES "Tetris Battle Gaiden" Japanese To English Translation by krom (Peter Lemon):

output "Tetris Battle Gaiden.sfc", create
origin $00000; insert "Tetris Battle Gaiden (J).sfc" // Include Japanese Tetris Battle Gaiden SNES ROM
origin $007FC0
db "TETRIS BATTLE GAIDENG" // $007FC0 - PROGRAM TITLE (21 Byte ASCII String, Use Spaces For Unused Bytes)

macro TextMapLO(OFFSET, TEXT) {
  // Map Font HI
  map ' ', $00, 16
  map '0', $20, 16
  map '@', $40, 16
  map 'P', $60, 16

  origin {OFFSET} // Offset
  variable labeloffset(+)
  variable length(labeloffset - {OFFSET} - 1)
  db length, {TEXT}
  +
  db $94 + ($C - length), $00

  // Map Font LO
  map ' ', $10, 16
  map '0', $30, 16
  map '@', $50, 16
  map 'P', $70, 16

  db length, {TEXT}
  db $94 + ($C - length), $00
}

macro TextMapHI(OFFSET, LENGTH) {
  origin {OFFSET} // Offset
  db $80 + {LENGTH}, $27
  db $94 + ($C - {LENGTH}), $00

  db $80 + {LENGTH}, $27
  db $94 + ($C - {LENGTH}), $00
}

macro TextMapASCII() {
  map 0, 0, 256 // Map ASCII Font
}

macro TextMapPause() {
  // Map Pause Font
  map '\n', $25
  map '0', $30, 10
  map '!', $3A
  map '?', $3B
  map 'A', $41, 26
  map '.', $A1
  map '\s', $A2 // map "'", $A2
  map $2C, $A4  // map ',', $A4
  map '-', $B0
}

TextMapASCII() // Map ASCII Font

// SETTING
origin $00C87
dw SETTINGBACKGROUND + $8000

origin $00CA0
dw SETTINGSTEREOMONO + $8000

// BACK GROUND
origin $01950
SETTINGBACKGROUND:
  dw TWOPLAYERBGSetting + $8000
  dw HALLOWEENSetting + $8000
  dw MIRURUNSetting + $8000
  dw SHAMANSetting + $8000
  dw ALADDINSetting + $8000
  dw PRINCESSSetting + $8000
  dw BITSetting + $8000
  dw NINJASetting + $8000
  dw WOLFMANSetting + $8000
  dw DRAGONSetting + $8000
  dw QUEENSetting + $8000
TWOPLAYERBGSetting:
  db "2PLAYERBG", $FF
HALLOWEENSetting:
  db "HALLOWEEN", $FF
MIRURUNSetting:
  db "MIRURUN  ", $FF
SHAMANSetting:
  db "SHAMAN   ", $FF
ALADDINSetting:
  db "ALADDIN  ", $FF
PRINCESSSetting:
  db "PRINCESS ", $FF
BITSetting:
  db "BIT      ", $FF
NINJASetting:
  db "NINJA    ", $FF
WOLFMANSetting:
  db "WOLFMAN  ", $FF
DRAGONSetting:
  db "DRAGON   ", $FF
QUEENSetting:
  db "QUEEN    ", $FF

// STEREO/MONO
SETTINGSTEREOMONO:
  dw STEREOSetting + $8000
  dw MONOSetting + $8000
STEREOSetting:
  db "STEREO", $FF
MONOSetting:
  db "MONO  ", $FF

// PAUSE SCREEN
origin $117DC
  dw HALLOWEENPauseName + $8000
  dw MIRURUNPauseName + $8000
  dw SHAMANPauseName + $8000
  dw ALADDINPauseName + $8000
  dw PRINCESSPauseName + $8000
  dw BITPauseName + $8000
  dw NINJAPauseName + $8000
  dw WOLFMANPauseName + $8000
  dw DRAGONPauseName + $8000
  dw QUEENPauseName + $8000
HALLOWEENPauseName:
  db "HALLOWEN", $FF
MIRURUNPauseName:
  db "MIRURUN", $FF
SHAMANPauseName:
  db "SHAMAN", $FF
ALADDINPauseName:
  db "ALADDIN", $FF
PRINCESSPauseName:
  db "PRINCESS", $FF
BITPauseName:
  db "  BIT", $FF
NINJAPauseName:
  db " NINJA", $FF
WOLFMANPauseName:
  db "WOLFMAN", $FF
DRAGONPauseName:
  db "DRAGON", $FF
QUEENPauseName:
  db " QUEEN", $FF

TextMapPause() // Map Pause Font

// PAUSE SCREEN COM INFO
origin $12AB0
HALLOWEENPauseCOMInfo:
  db "HA-HA-HA!\n"
  db "LET'S HAVE FUN.\n"
  db "COME ON!", $FF

origin $12B37
MIRURUNPauseCOMInfo:
  db "HI!\n"
  db "I WILL DO MY BEST!", $FF

origin $12BAB
SHAMANPauseCOMInfo:
  db "I PRAY TO THE GOD\n"
  db "OF TETRIS FOR MY\n"
  db "STRENGTH.", $FF

origin $12C5A
ALADDINPauseCOMInfo:
  db "HA-HA-HA!\n"
  db "A VICTORY WILL\n"
  db "SURELY BE MINE.", $FF

origin $12CD5
PRINCESSPauseCOMInfo:
  db "I'LL DO MY BEST!\n"
  db "BE GENTLE TO ME!", $FF

origin $12D46
BITPauseCOMInfo:
  db "HOORAY!\n"
  db "THERE IS NO BLOCKS"
  db "WOW, YO!", $FF

origin $12DB0
NINJAPauseCOMInfo:
  db "I HAVE THIS.\n"
  db "I WILL WIN WITH MY"
  db "NINJUTSU\n"
  db "I WILL DO IT!", $FF

origin $12E41
WOLFMANPauseCOMInfo:
  db "SEE MY TRUE\n"
  db "STRENGTH\n"
  db "I WILL BEAT YOU.", $FF

TextMapASCII() // Map ASCII Font

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
db "    BANBOO"
db "   GARDENS"
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

// CHARACTER DESCRIPTIONS
origin $27222
  dw HALLOWEENCharacterDescription + $8000; db $90
  dw MIRURUNCharacterDescription + $8000; db $90
  dw SHAMANCharacterDescription + $8000; db $90
  dw ALADDINCharacterDescription; db $87
  dw PRINCESSCharacterDescription; db $85
  dw BITCharacterDescription + $8000; db $90
  dw NINJACharacterDescription + $8000; db $90
  dw WOLFMANCharacterDescription + $8000; db $9A

origin $2FA1B
PRINCESSCharacterDescription:
db $C3, $00 // Low Bytes
TextMapLO(origin(), "PRINCESS WAS") // Line 1: Origin, Text
TextMapLO(origin(), "IN L-SHIP")    // Line 2: Origin, Text
TextMapLO(origin(), "CASTLE WHEN")  // Line 3: Origin, Text
TextMapLO(origin(), "HER SISTER")   // Line 4: Origin, Text
TextMapLO(origin(), "IS KIDNAPPED") // Line 5: Origin, Text
TextMapLO(origin(), "BY A DRAGON.") // Line 6: Origin, Text
TextMapLO(origin(), "SHE SETS OUT") // Line 7: Origin, Text
TextMapLO(origin(), "TO FIND HER.") // Line 8: Origin, Text
TextMapLO(origin(), "\dHOLD ON SIS") // Line 9: Origin, Text
TextMapLO(origin(), " I WILL NOT") // Line 10: Origin, Text
TextMapLO(origin(), " FAIL YOU!!\d") // Line 11: Origin, Text
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End Low Bytes
db $C3, $00 // High Bytes
TextMapHI(origin(), $C) // Line 1: Origin, Length
TextMapHI(origin(), $9) // Line 2: Origin, Length
TextMapHI(origin(), $B) // Line 3: Origin, Length
TextMapHI(origin(), $A) // Line 4: Origin, Length
TextMapHI(origin(), $C) // Line 5: Origin, Length
TextMapHI(origin(), $C) // Line 6: Origin, Length
TextMapHI(origin(), $C) // Line 7: Origin, Length
TextMapHI(origin(), $C) // Line 8: Origin, Length
TextMapHI(origin(), $C) // Line 9: Origin, Length
TextMapHI(origin(), $B) // Line 10: Origin, Length
TextMapHI(origin(), $C) // Line 11: Origin, Length
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End High Bytes

origin $3FB9C
ALADDINCharacterDescription:
db $C3, $00 // Low Bytes
TextMapLO(origin(), "ALADDIN IS")   // Line 1: Origin, Text
TextMapLO(origin(), "DREAMING OF")  // Line 2: Origin, Text
TextMapLO(origin(), "ADVENTURE...") // Line 3: Origin, Text
TextMapLO(origin(), "FLYING ON A")  // Line 4: Origin, Text
TextMapLO(origin(), "MAGIC CARPET") // Line 5: Origin, Text
TextMapLO(origin(), "HE SPOTS AN")  // Line 6: Origin, Text
TextMapLO(origin(), "ISLAND...")    // Line 7: Origin, Text
TextMapLO(origin(), "\dTHERE IS A") // Line 8: Origin, Text
TextMapLO(origin(), " DRAGON DOWN") // Line 9: Origin, Text
TextMapLO(origin(), " THERE! I'LL") // Line 10: Origin, Text
TextMapLO(origin(), " LAND HERE!\d") // Line 11: Origin, Text
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End Low Bytes
db $C3, $00 // High Bytes
TextMapHI(origin(), $A) // Line 1: Origin, Length
TextMapHI(origin(), $B) // Line 2: Origin, Length
TextMapHI(origin(), $C) // Line 3: Origin, Length
TextMapHI(origin(), $B) // Line 4: Origin, Length
TextMapHI(origin(), $C) // Line 5: Origin, Length
TextMapHI(origin(), $B) // Line 6: Origin, Length
TextMapHI(origin(), $9) // Line 7: Origin, Length
TextMapHI(origin(), $B) // Line 8: Origin, Length
TextMapHI(origin(), $C) // Line 9: Origin, Length
TextMapHI(origin(), $C) // Line 10: Origin, Length
TextMapHI(origin(), $C) // Line 11: Origin, Length
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End High Bytes

origin $84800
BITCharacterDescription:
db $C3, $00 // Low Bytes
TextMapLO(origin(), "A GROUP OF 5") // Line 1: Origin, Text
TextMapLO(origin(), "LADS WHO ARE") // Line 2: Origin, Text
TextMapLO(origin(), "THE BEST OF")  // Line 3: Origin, Text
TextMapLO(origin(), "CHUMS, & ARE") // Line 4: Origin, Text
TextMapLO(origin(), "ALWAYS HAPPY") // Line 5: Origin, Text
TextMapLO(origin(), "WHEREVER")     // Line 6: Origin, Text
TextMapLO(origin(), "THEY ROAM...") // Line 7: Origin, Text
TextMapLO(origin(), "LOVE DANCING") // Line 8: Origin, Text
TextMapLO(origin(), "\dYIPPEE!!")   // Line 9: Origin, Text
TextMapLO(origin(), " WE HAVE SO")  // Line 10: Origin, Text
TextMapLO(origin(), " MUCH FUN!!\d") // Line 11: Origin, Text
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End Low Bytes
db $C3, $00 // High Bytes
TextMapHI(origin(), $C) // Line 1: Origin, Length
TextMapHI(origin(), $C) // Line 2: Origin, Length
TextMapHI(origin(), $B) // Line 3: Origin, Length
TextMapHI(origin(), $C) // Line 4: Origin, Length
TextMapHI(origin(), $C) // Line 5: Origin, Length
TextMapHI(origin(), $8) // Line 6: Origin, Length
TextMapHI(origin(), $C) // Line 7: Origin, Length
TextMapHI(origin(), $C) // Line 8: Origin, Length
TextMapHI(origin(), $9) // Line 9: Origin, Length
TextMapHI(origin(), $B) // Line 10: Origin, Length
TextMapHI(origin(), $C) // Line 11: Origin, Length
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End High Bytes

origin $849F0
HALLOWEENCharacterDescription:
db $C3, $00 // Low Bytes
TextMapLO(origin(), "HALLOWEEN")    // Line 1: Origin, Text
TextMapLO(origin(), "LOVES SWEETS") // Line 2: Origin, Text
TextMapLO(origin(), "& MISCHIEF.")  // Line 3: Origin, Text
TextMapLO(origin(), "HE IS ALWAYS") // Line 4: Origin, Text
TextMapLO(origin(), "THINKING OF")  // Line 5: Origin, Text
TextMapLO(origin(), "EATING CANDY") // Line 6: Origin, Text
TextMapLO(origin(), "& WANTS THE")  // Line 7: Origin, Text
TextMapLO(origin(), "DRAGON'S OWN") // Line 8: Origin, Text
TextMapLO(origin(), "SWEETS FOR")   // Line 9: Origin, Text
TextMapLO(origin(), "HIMSELF...")   // Line 10: Origin, Text
TextMapLO(origin(), "\dYUM YUM!!\d") // Line 11: Origin, Text
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End Low Bytes
db $C3, $00 // High Bytes
TextMapHI(origin(), $9) // Line 1: Origin, Length
TextMapHI(origin(), $C) // Line 2: Origin, Length
TextMapHI(origin(), $B) // Line 3: Origin, Length
TextMapHI(origin(), $C) // Line 4: Origin, Length
TextMapHI(origin(), $B) // Line 5: Origin, Length
TextMapHI(origin(), $C) // Line 6: Origin, Length
TextMapHI(origin(), $B) // Line 7: Origin, Length
TextMapHI(origin(), $C) // Line 8: Origin, Length
TextMapHI(origin(), $A) // Line 9: Origin, Length
TextMapHI(origin(), $A) // Line 10: Origin, Length
TextMapHI(origin(), $B) // Line 11: Origin, Length
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End High Bytes

origin $84BDE
SHAMANCharacterDescription:
db $C3, $00 // Low Bytes
TextMapLO(origin(), "SHAMAN IS IN") // Line 1: Origin, Text
TextMapLO(origin(), "SEARCH OF A")  // Line 2: Origin, Text
TextMapLO(origin(), "LEGENDARY")    // Line 3: Origin, Text
TextMapLO(origin(), "POTION THAT")  // Line 4: Origin, Text
TextMapLO(origin(), "CAN CURE ANY") // Line 5: Origin, Text
TextMapLO(origin(), "ILLNESS...")   // Line 6: Origin, Text
TextMapLO(origin(), "HE WILL NEED") // Line 7: Origin, Text
TextMapLO(origin(), "TO FIND THE")  // Line 8: Origin, Text
TextMapLO(origin(), "DRAGON SCALE") // Line 9: Origin, Text
TextMapLO(origin(), "TO SUCCEED.")  // Line 10: Origin, Text
TextMapLO(origin(), "\dHU-WA-YE!!\d") // Line 11: Origin, Text
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End Low Bytes
db $C3, $00 // High Bytes
TextMapHI(origin(), $C) // Line 1: Origin, Length
TextMapHI(origin(), $B) // Line 2: Origin, Length
TextMapHI(origin(), $9) // Line 3: Origin, Length
TextMapHI(origin(), $B) // Line 4: Origin, Length
TextMapHI(origin(), $C) // Line 5: Origin, Length
TextMapHI(origin(), $A) // Line 6: Origin, Length
TextMapHI(origin(), $C) // Line 7: Origin, Length
TextMapHI(origin(), $B) // Line 8: Origin, Length
TextMapHI(origin(), $C) // Line 9: Origin, Length
TextMapHI(origin(), $B) // Line 10: Origin, Length
TextMapHI(origin(), $C) // Line 11: Origin, Length
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End High Bytes

origin $855C7
NINJACharacterDescription:
db $C3, $00 // Low Bytes
TextMapLO(origin(), "AS NINJA WAS") // Line 1: Origin, Text
TextMapLO(origin(), "TRAINING, HE") // Line 2: Origin, Text
TextMapLO(origin(), "HEARD THAT")   // Line 3: Origin, Text
TextMapLO(origin(), "HIS FIANCEE")  // Line 4: Origin, Text
TextMapLO(origin(), "KYOUKO HAD")   // Line 5: Origin, Text
TextMapLO(origin(), "BEEN TURNED")  // Line 6: Origin, Text
TextMapLO(origin(), "INTO A FROG,") // Line 7: Origin, Text
TextMapLO(origin(), "BY THE HAND")  // Line 8: Origin, Text
TextMapLO(origin(), "OF AN EVIL")   // Line 9: Origin, Text
TextMapLO(origin(), "SORCERER...")  // Line 10: Origin, Text
TextMapLO(origin(), "\dSAVE HER!!\d") // Line 11: Origin, Text
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End Low Bytes
db $C3, $00 // High Bytes
TextMapHI(origin(), $C) // Line 1: Origin, Length
TextMapHI(origin(), $C) // Line 2: Origin, Length
TextMapHI(origin(), $A) // Line 3: Origin, Length
TextMapHI(origin(), $B) // Line 4: Origin, Length
TextMapHI(origin(), $A) // Line 5: Origin, Length
TextMapHI(origin(), $B) // Line 6: Origin, Length
TextMapHI(origin(), $C) // Line 7: Origin, Length
TextMapHI(origin(), $B) // Line 8: Origin, Length
TextMapHI(origin(), $A) // Line 9: Origin, Length
TextMapHI(origin(), $B) // Line 10: Origin, Length
TextMapHI(origin(), $C) // Line 11: Origin, Length
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End High Bytes

origin $85913
MIRURUNCharacterDescription:
db $C3, $00 // Low Bytes
TextMapLO(origin(), "MIRURUN IS A") // Line 1: Origin, Text
TextMapLO(origin(), "CREATURE WHO") // Line 2: Origin, Text
TextMapLO(origin(), "HAS A HEART")  // Line 3: Origin, Text
TextMapLO(origin(), "OF GOLD.")     // Line 4: Origin, Text
TextMapLO(origin(), "HE HAS BEEN")  // Line 5: Origin, Text
TextMapLO(origin(), "ON A JOURNEY") // Line 6: Origin, Text
TextMapLO(origin(), "TO FIND SOME") // Line 7: Origin, Text
TextMapLO(origin(), "FRIENDS.")     // Line 8: Origin, Text
TextMapLO(origin(), "\dWILL YOU")   // Line 9: Origin, Text
TextMapLO(origin(), " BE MY")       // Line 10: Origin, Text
TextMapLO(origin(), " FRIEND?\d...") // Line 11: Origin, Text
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End Low Bytes
db $C3, $00 // High Bytes
TextMapHI(origin(), $C) // Line 1: Origin, Length
TextMapHI(origin(), $C) // Line 2: Origin, Length
TextMapHI(origin(), $B) // Line 3: Origin, Length
TextMapHI(origin(), $8) // Line 4: Origin, Length
TextMapHI(origin(), $B) // Line 5: Origin, Length
TextMapHI(origin(), $C) // Line 6: Origin, Length
TextMapHI(origin(), $C) // Line 7: Origin, Length
TextMapHI(origin(), $8) // Line 8: Origin, Length
TextMapHI(origin(), $9) // Line 9: Origin, Length
TextMapHI(origin(), $6) // Line 10: Origin, Length
TextMapHI(origin(), $C) // Line 11: Origin, Length
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End High Bytes

origin $D7E13
WOLFMANCharacterDescription:
db $C3, $00 // Low Bytes
TextMapLO(origin(), "WOLFMAN") // Line 1: Origin, Text
TextMapLO(origin(), "WENT BACK TO") // Line 2: Origin, Text
TextMapLO(origin(), "HIS HOMELAND") // Line 3: Origin, Text
TextMapLO(origin(), "AFTER MANY")   // Line 4: Origin, Text
TextMapLO(origin(), "YEARS AWAY &") // Line 5: Origin, Text
TextMapLO(origin(), "FOUND IT WAS") // Line 6: Origin, Text
TextMapLO(origin(), "IN UPROAR!..") // Line 7: Origin, Text
TextMapLO(origin(), "THE PRINCESS") // Line 8: Origin, Text
TextMapLO(origin(), "IS KIDNAPPED") // Line 9: Origin, Text
TextMapLO(origin(), "\dI'LL FIGHT") // Line 10: Origin, Text
TextMapLO(origin(), "WITH HONOR!\d") // Line 11: Origin, Text
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End Low Bytes
db $C3, $00 // High Bytes
TextMapHI(origin(), $7) // Line 1: Origin, Length
TextMapHI(origin(), $C) // Line 2: Origin, Length
TextMapHI(origin(), $C) // Line 3: Origin, Length
TextMapHI(origin(), $A) // Line 4: Origin, Length
TextMapHI(origin(), $C) // Line 5: Origin, Length
TextMapHI(origin(), $C) // Line 6: Origin, Length
TextMapHI(origin(), $C) // Line 7: Origin, Length
TextMapHI(origin(), $C) // Line 8: Origin, Length
TextMapHI(origin(), $C) // Line 9: Origin, Length
TextMapHI(origin(), $B) // Line 10: Origin, Length
TextMapHI(origin(), $C) // Line 11: Origin, Length
db $FF, $00, $FF, $00, $B3, $00, $00, $FF // End High Bytes