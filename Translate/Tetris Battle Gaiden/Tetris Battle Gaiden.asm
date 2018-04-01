// SNES "Tetris Battle Gaiden" Japanese To English Translation by krom (Peter Lemon):

output "Tetris Battle Gaiden.sfc", create
origin $00000; insert "Tetris Battle Gaiden (J).sfc" // Include Japanese Tetris Battle Gaiden SNES ROM
origin $007FC0
db "TETRIS BATTLE GAIDENG" // $007FC0 - PROGRAM TITLE (21 Byte ASCII String, Use Spaces For Unused Bytes)

macro PC2LoROM(SIZE, OFFSET) {
    variable lorom({OFFSET} & $FFFF)
    if lorom < $8000 {
      lorom = lorom + $8000
    }
    variable bank({OFFSET} >> 15)
    bank = bank + $80
    lorom = lorom + (bank << 16)
    {SIZE} lorom
}

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
PC2LoROM(dw, SETTINGBACKGROUND)

origin $00CA0
PC2LoROM(dw, SETTINGSTEREOMONO)

// BACK GROUND
origin $01950
SETTINGBACKGROUND:
  PC2LoROM(dw, TWOPLAYERBGSetting)
  PC2LoROM(dw, HALLOWEENSetting)
  PC2LoROM(dw, MIRURUNSetting)
  PC2LoROM(dw, SHAMANSetting)
  PC2LoROM(dw, ALADDINSetting)
  PC2LoROM(dw, PRINCESSSetting)
  PC2LoROM(dw, BITSetting)
  PC2LoROM(dw, NINJASetting)
  PC2LoROM(dw, WOLFMANSetting)
  PC2LoROM(dw, DRAGONSetting)
  PC2LoROM(dw, QUEENSetting)
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
  PC2LoROM(dw, STEREOSetting)
  PC2LoROM(dw, MONOSetting)
STEREOSetting:
  db "STEREO", $FF
MONOSetting:
  db "MONO  ", $FF

TextMapPause() // Map Pause Font

// PAUSE SCREEN
origin $117DC
  PC2LoROM(dw, HALLOWEENPauseName)
  PC2LoROM(dw, MIRURUNPauseName)
  PC2LoROM(dw, SHAMANPauseName)
  PC2LoROM(dw, ALADDINPauseName)
  PC2LoROM(dw, PRINCESSPauseName)
  PC2LoROM(dw, BITPauseName)
  PC2LoROM(dw, NINJAPauseName)
  PC2LoROM(dw, WOLFMANPauseName)
  PC2LoROM(dw, DRAGONPauseName)
  PC2LoROM(dw, QUEENPauseName)
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

// PAUSE SCREEN PLAYER
origin $12A9B
ALLPausePlayer:
  db "-HOW TO USE MAGIC-  ", $FF

origin $11AED
  PC2LoROM(dw, HALLOWEENPausePlayer)
  PC2LoROM(dw, MIRURUNPausePlayer)
  PC2LoROM(dw, SHAMANPausePlayer)
  PC2LoROM(dw, ALADDINPausePlayer)
  PC2LoROM(dw, PRINCESSPausePlayer)
  PC2LoROM(dw, BITPausePlayer)
  PC2LoROM(dw, NINJAPausePlayer)
  PC2LoROM(dw, WOLFMANPausePlayer)
  PC2LoROM(dw, DRAGONPausePlayer)
  PC2LoROM(dw, QUEENPausePlayer)

origin $1231D
HALLOWEENPausePlayer:
  db "GET SOME CRYSTALS\n"
  db "TO USE MY SPELLS!\n"
  db "PRESS UP ON D-PAD.", $FF
MIRURUNPausePlayer:
  db "HI! GET CRYSTALS\n"
  db "TO CAST MY MAGIC!\n"
  db "PRESS UP ON D-PAD.", $FF
SHAMANPausePlayer:
  db "GET CRYSTALS FOR\n"
  db "MY SHAMAN MAGIC.\n"
  db "D-PAD UP TO CAST.", $FF
ALADDINPausePlayer:
  db "GATHER CRYSTALS TO"
  db "USE MY GREAT MAGIC"
  db "D-PAD UP TO CAST!", $FF
PRINCESSPausePlayer:
  db "GATHER CRYSTALS TO"
  db "USE MY SPELLS. UP\n"
  db "ON D-PAD TO CAST!", $FF
BITPausePlayer:
  db "WE NEED CRYSTALS\n"
  db "FOR OUR FUN MAGIC!"
  db "D-PAD UP TO CAST!", $FF
NINJAPausePlayer:
  db "MY NINJUTSU NEEDS\n"
  db "CRYSTALS FOR POWER"
  db "D-PAD UP TO USE IT", $FF
WOLFMANPausePlayer:
  db "MY TRUE STRENGTH\n"
  db "REQUIRES CRYSTALS."
  db "PRESS UP ON D-PAD.", $FF
DRAGONPausePlayer:
  db "HUFF-PUFF! BRING\n"
  db "ME CRYSTALS. PRESS"
  db "UP ON THE D-PAD!", $FF
QUEENPausePlayer:
  db "GIVE ME CRYSTALS\n"
  db "NOW FOR MY SPELLS!"
  db "THEN USE D-PAD UP!", $FF

// PAUSE SCREEN MAGIC
origin $12588
  PC2LoROM(dw, PAUSEMAGIC01) // Level 1 Mirurun
  PC2LoROM(dw, PAUSEMAGIC02) // Level 4 Princess
  PC2LoROM(dw, PAUSEMAGIC03) // Level 4 Ninja
  PC2LoROM(dw, PAUSEMAGIC04) // Level 4 Halloween
  PC2LoROM(dw, PAUSEMAGIC05) // Level 2 Ninja
  PC2LoROM(dw, PAUSEMAGIC06) // Level 3 Mirurun
  PC2LoROM(dw, PAUSEMAGIC07) // Level 3 Ninja
  PC2LoROM(dw, PAUSEMAGIC08) // Level 1 Halloween
  PC2LoROM(dw, PAUSEMAGIC09) // Level 3 Shaman
  PC2LoROM(dw, PAUSEMAGIC10) // Level 3 Halloween
  PC2LoROM(dw, PAUSEMAGIC11) // Level 4 Queen
  PC2LoROM(dw, PAUSEMAGIC12) // Level 1 Aladdin
  PC2LoROM(dw, PAUSEMAGIC12) // Level 1 Aladdin
  PC2LoROM(dw, PAUSEMAGIC12) // Level 1 Aladdin
  PC2LoROM(dw, PAUSEMAGIC13) // Level 1 Wolfman
  PC2LoROM(dw, PAUSEMAGIC14) // Level 1 Shaman
  PC2LoROM(dw, PAUSEMAGIC15) // Level 4 Bit
  PC2LoROM(dw, PAUSEMAGIC16) // Level 1 Bit
  PC2LoROM(dw, PAUSEMAGIC17) // Level 2 Queen
  PC2LoROM(dw, PAUSEMAGIC18) // Level 3 Princess
  PC2LoROM(dw, PAUSEMAGIC19) // Level 2 Shaman
  PC2LoROM(dw, PAUSEMAGIC20) // Level 1 Ninja
  PC2LoROM(dw, PAUSEMAGIC21) // Level 3 Bit
  PC2LoROM(dw, PAUSEMAGIC22) // Level 4 Wolfman
  PC2LoROM(dw, PAUSEMAGIC23) // Level 1 Dragon
  PC2LoROM(dw, PAUSEMAGIC24) // Level 1 Princess
  PC2LoROM(dw, PAUSEMAGIC25) // Level 4 Mirurun
  PC2LoROM(dw, PAUSEMAGIC26) // Level 3 Aladdin
  PC2LoROM(dw, PAUSEMAGIC27) // Level 2 Aladdin
  PC2LoROM(dw, PAUSEMAGIC28) // Level 2 Princess
  PC2LoROM(dw, PAUSEMAGIC29) // Level ? ????
  PC2LoROM(dw, PAUSEMAGIC30) // Level 2 Dragon
  PC2LoROM(dw, PAUSEMAGIC31) // Level 2 Wolfman
  PC2LoROM(dw, PAUSEMAGIC32) // Level 4 Aladdin
  PC2LoROM(dw, PAUSEMAGIC33) // Level 2 Mirurun
  PC2LoROM(dw, PAUSEMAGIC34) // Level 3 Wolfman
  PC2LoROM(dw, PAUSEMAGIC35) // Level 4 Shaman
  PC2LoROM(dw, PAUSEMAGIC36) // Level 3 Dragon
  PC2LoROM(dw, PAUSEMAGIC37) // Level 2 Bit
  PC2LoROM(dw, PAUSEMAGIC38) // Level 4 Dragon
  PC2LoROM(dw, PAUSEMAGIC39) // Level 3 Queen
  PC2LoROM(dw, PAUSEMAGIC40) // Level 2 Halloween
  PC2LoROM(dw, PAUSEMAGIC41) // Level 1 Queen

origin $125DE
PAUSEMAGIC01:
  db "MIRURUN ", $FF
PAUSEMAGIC02:
  db "  COPY  ", $FF
PAUSEMAGIC03:
  db " MEDUSA ", $FF
PAUSEMAGIC04:
  db "  BOMB  ", $FF
PAUSEMAGIC05:
  db "  FAKE  ", $FF
PAUSEMAGIC06:
  db "PENTRIS ", $FF
PAUSEMAGIC07:
  db "DESTROY ", $FF
PAUSEMAGIC08:
  db "  FRY   ", $FF
PAUSEMAGIC09:
  db " CURSE  ", $FF
PAUSEMAGIC10:
  db "VAMPIRE ", $FF
PAUSEMAGIC11:
  db " CLEAR  ", $FF
PAUSEMAGIC12:
  db " SEESAW ", $FF
PAUSEMAGIC13:
  db "  CUT   ", $FF
PAUSEMAGIC14:
  db " MOSES  ", $FF
PAUSEMAGIC15:
  db " MAMBO  ", $FF
PAUSEMAGIC16:
  db "STARDUST", $FF
PAUSEMAGIC17:
  db "REVERSE ", $FF
PAUSEMAGIC18:
  db "PARALYZE", $FF
PAUSEMAGIC19:
  db " ROTATE ", $FF
PAUSEMAGIC20:
  db "  YOSE  ", $FF
PAUSEMAGIC21:
  db "  GANG  ", $FF
PAUSEMAGIC22:
  db " EARTH  ", $FF
PAUSEMAGIC23:
  db " PRESS  ", $FF
PAUSEMAGIC24:
  db "  SOUL  ", $FF
PAUSEMAGIC25:
  db " SIRTET ", $FF
PAUSEMAGIC26:
  db "  FAX   ", $FF
PAUSEMAGIC27:
  db " SHIELD ", $FF
PAUSEMAGIC28:
  db " MIRROR ", $FF
PAUSEMAGIC29:
  db " HEAVY  ", $FF
PAUSEMAGIC30:
  db " SELECT ", $FF
PAUSEMAGIC31:
  db "  GNU   ", $FF
PAUSEMAGIC32:
  db " REMOTE ", $FF
PAUSEMAGIC33:
  db " INVERT ", $FF
PAUSEMAGIC34:
  db "  CHUM  ", $FF
PAUSEMAGIC35:
  db "  PRAY  ", $FF
PAUSEMAGIC36:
  db "ROULETTE", $FF
PAUSEMAGIC37:
  db " FEVER  ", $FF
PAUSEMAGIC38:
  db " CHANGE ", $FF
PAUSEMAGIC39:
  db "DOUBLES ", $FF
PAUSEMAGIC40:
  db "  DARK  ", $FF
PAUSEMAGIC41:
  db "HYPERFRY", $FF

// PAUSE SCREEN COMPUTER
origin $12A4A
  PC2LoROM(dw, HALLOWEENPauseComputer1)
  PC2LoROM(dw, HALLOWEENPauseComputer2)
  PC2LoROM(dw, HALLOWEENPauseComputer3)
  PC2LoROM(dw, MIRURUNPauseComputer1)
  PC2LoROM(dw, MIRURUNPauseComputer2)
  PC2LoROM(dw, MIRURUNPauseComputer3)
  PC2LoROM(dw, SHAMANPauseComputer1)
  PC2LoROM(dw, SHAMANPauseComputer2)
  PC2LoROM(dw, SHAMANPauseComputer3)
  PC2LoROM(dw, ALADDINPauseComputer1)
  PC2LoROM(dw, ALADDINPauseComputer2)
  PC2LoROM(dw, ALADDINPauseComputer3)
  PC2LoROM(dw, PRINCESSPauseComputer1)
  PC2LoROM(dw, PRINCESSPauseComputer2)
  PC2LoROM(dw, PRINCESSPauseComputer3)
  PC2LoROM(dw, BITPauseComputer1)
  PC2LoROM(dw, BITPauseComputer2)
  PC2LoROM(dw, BITPauseComputer3)
  PC2LoROM(dw, NINJAPauseComputer1)
  PC2LoROM(dw, NINJAPauseComputer2)
  PC2LoROM(dw, NINJAPauseComputer3)
  PC2LoROM(dw, WOLFMANPauseComputer1)
  PC2LoROM(dw, WOLFMANPauseComputer2)
  PC2LoROM(dw, WOLFMANPauseComputer3)
  PC2LoROM(dw, DRAGONPauseComputer1)
  PC2LoROM(dw, DRAGONPauseComputer2)
  PC2LoROM(dw, DRAGONPauseComputer3)
  PC2LoROM(dw, QUEENPauseComputer1)
  PC2LoROM(dw, QUEENPauseComputer2)
  PC2LoROM(dw, QUEENPauseComputer3)

origin $12AB0
HALLOWEENPauseComputer1:
  db "M-WAH-HA!\n"
  db "WE WILL HAVE FUN.\n"
  db "COME ON!", $FF
HALLOWEENPauseComputer2:
  db "M-WAH-HA!\n"
  db "KEEP TRYING!\n"
  db "I WILL DEFEAT YOU\n"
  db "SOON!", $FF
HALLOWEENPauseComputer3:
  db "SO MANY BLOCKS\n"
  db "I MUST NOT PANIC!\n"
  db "I WILL USE THEM!", $FF

MIRURUNPauseComputer1:
  db "HI!\n"
  db "I WILL DO MY BEST!", $FF
MIRURUNPauseComputer2:
  db "NOT TOO BAD!\n"
  db "I CAN NOT LOSE!", $FF
MIRURUNPauseComputer3:
  db "VERY BAD!\n"
  db "I WILL DO MY BEST!"
  db "BUT I TRIED THAT!!", $FF

SHAMANPauseComputer1:
  db "I PRAY TO THE GOD\n"
  db "OF TETRIS FOR MY\n"
  db "STRENGTH.", $FF
SHAMANPauseComputer2:
  db "I AM OBSESSED WITH"
  db "TETRIS.\n"
  db "I WILL NOT LOSE.", $FF
SHAMANPauseComputer3:
  db "MAYBE THIS IS A\n"
  db "SIGN.\n"
  db "I MUST WIN!", $FF

ALADDINPauseComputer1:
  db "HA-HA!\n"
  db "A VICTORY WILL\n"
  db "SURELY BE MINE.", $FF
ALADDINPauseComputer2:
  db "HA-HA!\n"
  db "A LITTLE TROUBLE.\n"
  db "I WILL STILL WIN!", $FF
ALADDINPauseComputer3:
  db "I CAN NOT LOSE.\n"
  db "I WILL TRY TO\n"
  db "RECOVER QUICKLY!", $FF

PRINCESSPauseComputer1:
  db "I WILL DO MY BEST!"
  db "BE GENTLE!", $FF
PRINCESSPauseComputer2:
  db "A LITTLE DANGER.\n"
  db "I WILL TRY HARDER!", $FF
PRINCESSPauseComputer3:
  db "AH!\n"
  db "I WILL LOSE IF I\n"
  db "PLAY LIKE THIS!\n"
  db "I MUST DO BETTER!", $FF

BITPauseComputer1:
  db "HOORAY!\n"
  db "THERE IS NO BLOCKS"
  db "WOW, YO!", $FF
BITPauseComputer2:
  db "HOORAY!\n"
  db "SOME MORE BLOCKS\n"
  db "HOORAY!", $FF
BITPauseComputer3:
  db "WAH! WAH!\n"
  db "BLOCKS TO THE TOP\n"
  db "WAH! WAH!", $FF

NINJAPauseComputer1:
  db "I HAVE GOT THIS.\n"
  db "I WILL WIN WITH MY"
  db "NINJUTSU, I CAN DO"
  db "IT!", $FF
NINJAPauseComputer2:
  db "DO NOT DO IT!\n"
  db "IT IS NOT POSSIBLE"
  db "TO BREAK NINJUTSU\n"
  db "TO THIS DEGREE!", $FF
NINJAPauseComputer3:
  db "GROWTH!\n"
  db "I MUST REVERSE IT!"
  db "PLEASE WAIT!", $FF

WOLFMANPauseComputer1:
  db "SEE MY TRUE\n"
  db "STRENGTH\n"
  db "I WILL BEAT YOU.", $FF
WOLFMANPauseComputer2:
  db "SADLY THIS ROUND\n"
  db "IS AWKWARD FOR ME."
  db "IT IS A PLEASURE\n"
  db "TO FIGHT YOU.", $FF
WOLFMANPauseComputer3:
  db "I MUST NOT THROW\n"
  db "THIS AWAY!\n"
  db "I CAN FEEL MY\n"
  db "POWER RETURNING!", $FF

DRAGONPauseComputer1:
  db "HUFF-PUFF\n"
  db "THINK YOU CAN WIN?"
  db "GIVE UP NOW, RUN\n"
  db "AWAY!", $FF
DRAGONPauseComputer2:
  db "IF YOU THINK YOU\n"
  db "CAN WIN, YOU ARE\n"
  db "WRONG!\n"
  db "I WILL BEAT YOU!", $FF
DRAGONPauseComputer3:
  db "YOU!\n"
  db "HMM WHAT TO DO!\n"
  db "BUT I STILL WILL\n"
  db "NOT LOSE!!", $FF

QUEENPauseComputer1:
  db "HO-HO!\n"
  db "PLEASE APPOLOGIZE!"
  db "THEN I WILL\n"
  db "FORGIVE YOU!", $FF
QUEENPauseComputer2:
  db "HO-HO!\n"
  db "IT IS QUITE EASY!\n"
  db "BUT I AM STILL NOT"
  db "TRYING HARD!", $FF
QUEENPauseComputer3:
  db "HO-HO!\n"
  db "YOU MADE ME ANGRY!"
  db "COME ON! KNEEL\n"
  db "DOWN BEFORE ME!", $FF

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

// CHARACTER DESCRIPTION
origin $27222
  PC2LoROM(dl, HALLOWEENCharacterDescription)
  PC2LoROM(dl, MIRURUNCharacterDescription)
  PC2LoROM(dl, SHAMANCharacterDescription)
  PC2LoROM(dl, ALADDINCharacterDescription)
  PC2LoROM(dl, PRINCESSCharacterDescription)
  PC2LoROM(dl, BITCharacterDescription)
  PC2LoROM(dl, NINJACharacterDescription)
  PC2LoROM(dl, WOLFMANCharacterDescription)

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