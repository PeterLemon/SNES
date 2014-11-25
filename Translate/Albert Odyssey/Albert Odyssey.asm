// SNES "Albert Odyssey" Japanese To English Translation by krom (Peter Lemon):

output "Albert Odyssey.sfc", create
origin $00000; insert "Albert Odyssey (J).sfc" // Include Japanese Albert Odyssey SNES ROM

// Char Table 1
map '0', $00, 10
map 'A', $0A, 26
map '?', $24
map '!', $25
map '-', $26
map '/', $27
map ' ', $28
map '[', $C1
map ']', $C2
map '.', $C3
map $2C, $C4 // map ',', $C4
map ':', $D6
map '$', $F6

// Char Table 2
map '+', $18
map '>', $31
map '%', $35

// Text Type
constant TextType0(%00000000)
constant TextType1(%00100000)
constant TextType2(%01000000)
constant TextType3(%01100000)
constant TextType4(%10000000)
constant TextType5(%10100000)
constant TextType6(%11000000)
constant TextType7(%11100000)

macro TextStyle1(OFFSET, TEXT) {
  origin {OFFSET} // Offset
  variable labeloffset(+)
  db labeloffset - {OFFSET} - 2 // Length
  db {TEXT} // Text
  +
}

macro TextStyle2(OFFSET, TEXT, TYPE) {
  origin {OFFSET} // Offset
  variable labeloffset(+)
  db ((labeloffset - {OFFSET} - 2) / 2) | {TYPE} // Length (Bits 4:0 = Length, 7:5 = Text Type)
  db {TEXT} // Text (2 Bytes Per Character, Byte1 = Text Char, Byte2 = Char Table / Colour)
  +
}

macro TextStyle3(OFFSET, TEXT, TYPE, ASCIIOFFSET, LOWEROFFSET) {
  origin {OFFSET} // Upper Offset
  variable TEXTCHAR({TEXT} - {ASCIIOFFSET})
  TEXTCHAR = TEXTCHAR + ($10 * (TEXTCHAR / 16))
  db TEXTCHAR // Upper Text
  db {TYPE} // Upper Type

  origin {OFFSET} + {LOWEROFFSET} // Lower Offset
  db TEXTCHAR + $10 // Lower Text
  db {TYPE} // Lower Type
}

macro TextStyle4(OFFSET, TEXT, TYPE, ASCIIOFFSET) {
  origin {OFFSET} // Upper Offset
  variable TEXTCHAR({TEXT} - {ASCIIOFFSET})
  TEXTCHAR = TEXTCHAR + ($10 * (TEXTCHAR / 16))
  db TEXTCHAR // Upper Text
  db {TYPE} // Upper Type
}

macro TextStyle5(OFFSET, TEXT) {
  origin {OFFSET} // Offset
  db {TEXT} // Text
}

// Intro
TextStyle1($43ABC, "  ALBERT - ODYSSEY  ")

TextStyle1($43911, "THE MAGE OSWALD INVADED")
TextStyle1($43D09, "SEEKING THE CRYSTAL KEY,")

TextStyle1($43D22, "USING HIS POWERS AGAINST")
TextStyle1($43D3B, "THE BRAVE KNIGHTS.")

TextStyle1($4454F, "KNIGHTS OF GORT - LAST STAND.")

TextStyle2($41E3A, "K4N4I4G4H4T4:4	0O0H0 0N0O0.0.0.0 0I0M0P0O0S0S0I0B0L0E0!0", TextType7)

TextStyle1($43929, "KNIGHT1: CAPTAIN SLAY!")

TextStyle1($43946, "SLAY:WHY ARE YOU ALONE?")

TextStyle1($43965, "KNIGHT1:ALL OUR FORCES HAVE")
TextStyle1($4398C, "BEEN WIPED OUT!")

TextStyle1($43F8A, "SLAY: GENERAL!!")

TextStyle1($4399D, "GENERAL: HAS")
TextStyle1($439AA, "IT COME TO THIS?!")

TextStyle1($43D4E, "KNIGHT2:GENERAL! LET US GO!")

TextStyle1($43D73, "KNIGHT3: IN OUR NAME!")

TextStyle1($439BC, "GENERAL: OK! LETS GO!")

TextStyle1($439DF, "SOFIA: DADDY...")

TextStyle1($439F2, "MUM: MY DEAR...")

TextStyle1($43AA5, "GENERAL: DO NOT WORRY!")
TextStyle1($43A03, "LOOK AFTER SOFIA.")

TextStyle1($43A15, "SOFIA: NO! PLEASE DONT GO!")
TextStyle1($43A65, " DADDY!")

TextStyle2($43AD1, "SCLCACYC:C 0H0E0R0E0 0I0 0G0O0!0!0", TextType7)

TextStyle2($43AF4, "SCLCACYC:C 0W0E0R0E0 0L0O0S0I0N0G0 0T0H0E0 0B0A0T0T0L0E0.0.0.0", TextType7)

TextStyle2($43B33, "SCLCACYC:CG0E0N0E0R0A0L0!0W0E0 0C0A0N0T0 0G0O0 0O0N0!0", TextType7)

TextStyle2($43B6A, "G8E8N8E8R8A8L8:8 0Y0O0U0 0O0K0?0!0", TextType7)

TextStyle2($43B8D, "SCLCACYC:C 0W0E0 0M0U0S0T0 0R0E0T0R0E0A0T0 0N0O0W0!0", TextType7)

TextStyle2($43BC2, "SCLCACYC:C 0G0E0N0E0R0A0L0!0", TextType7)

TextStyle2($43BDF, "G8E8N8E8R8A8L8:8 0E0V0A0C0U0A0T0E0 0T0H0E0 0V0I0L0L0A0G0E0!0", TextType7)

TextStyle2($43C1C, "SCLCACYC:CC0O0M0E0 0B0A0C0K0,0F0O0R0 0S0O0F0I0A0!0", TextType7)

TextStyle2($43C4F, "SCLCACYC:CC0A0N0T0 0W0I0N0,0L0E0T0S0 0G0O0 0B0A0C0K0.0", TextType7)

TextStyle2($43C86, "K4N4I4G4H4T4:4M0U0S0T0 0E0V0A0C0U0A0T0E0 0V0I0L0L0A0G0E0R0S0!0", TextType7)

TextStyle1($43A3E, "SOFIA: WHERES MY DADDY?")

TextStyle2($43A90, "SCLCACYC:C 0.0.0.0.0", TextType7)

TextStyle1($43CC5, "SOFIA:WHERE ARE YOU...?")

TextStyle1($43D9A, "OSWALD:CRYSTAL?")

TextStyle1($43DB9, "OSWALD:YOU POSSESS MAGIC...")

TextStyle2($43CE8, "SCOCFCICAC:C 0M0U0M0-0-0-0M0Y0!0", TextType7)

TextStyle1($43E46, "SOFIA: GIVE BACK MY MUMMY!")

TextStyle1($438FC, "---10 YEARS LATER---")


// Intro Characters Names
TextStyle1($40CE6, "KNIGHT")
TextStyle1($40CF3, "SLAY")
TextStyle1($40F8E, "GN")

// Playable Characters Names
TextStyle1($40C6B, "ALBERT")
TextStyle1($413BD, "NEUMANN")
TextStyle1($40C82, "SOFIA")

// Boss Monster Names
TextStyle1($40CBA, "GOLM")
TextStyle1($418D0, "LO.DEMON")
TextStyle1($43A8B, "HARP")

// Normal Monster Names
TextStyle1($40C9E, "SKELT")
TextStyle1($40CAC, "ROPE")
TextStyle1($40CDB, "GARGO")
TextStyle1($40CE1, "GOBL")
TextStyle1($4189A, "FRUBAT")
TextStyle1($418A6, "LIZMAN")
TextStyle1($418AD, "DRAG")
TextStyle1($47A25, "REDROPE")
TextStyle1($47A33, "SKULLC")

// Location Names
TextStyle1($41983, "CHIB")
TextStyle1($41988, "GRT")
TextStyle1($41997, "NEURA")

// Equipment
TextStyle5($40FE5, "H0E0R0O0")
TextStyle5($416FD, "W0I0Z0A0R0D0")
TextStyle5($417B9, "V0I0C0A0R0")
TextStyle5($416E8, "CLOTH")
TextStyle5($416F2, "COPPER")
TextStyle5($4170E, "SPR")
TextStyle5($41716, "CLUB")
TextStyle5($41728, "SHORT  ")
TextStyle5($41734, "DAG")
TextStyle5($4173C, "LARGE  ")
TextStyle5($41748, "BUCKL")
origin $4174D ; db $49,$00,$01,$76,$77 ; TextStyle5($41752, "CHAIN   ")
TextStyle5($4175F, "LARGE")
TextStyle5($4178E, "HLM")
TextStyle5($417C8, "CAP")
TextStyle5($417D0, "LEATH")
TextStyle5($417DA, "RUBBER")
TextStyle5($41861, "LEATH")

// Items
TextStyle1($4100E, "EGG")
TextStyle1($412EA, "DAYLIGHT")
TextStyle1($416DB, "GRTWARP")
TextStyle1($41764, "GL.HEAD")
TextStyle1($4176C, "LETTR")
TextStyle1($41772, "NEURAWARP")
TextStyle1($417A2, "SHADOW")
TextStyle1($4183D, "HERB")
TextStyle1($41842, "A.GRASS")
TextStyle1($4184A, "CHIBWARP")
TextStyle1($41853, "ODDFRUIT")

TextStyle1($438A4, "TO:")
TextStyle1($438A8, "SELL?")
TextStyle1($438AE, "BUY?")


// Exit Town
TextStyle1($40DE5, "GO OUTSIDE?")
TextStyle2($40DF8, "YCECSC 0-0 0 CAC", TextType7)


// Battle Selection:
TextStyle1($410DF, "MOVE")
TextStyle1($40C5C, " HIT")
TextStyle1($40C61, "ENDGO")

// Albert Battle Selection
TextStyle1($479A7, "PSYK")

// Neumann & Sofia Battle Selection:
TextStyle1($40CBF, "CAST")

// Movement Text
TextStyle2($41950, "MOOOVOEO", TextType7)
TextStyle1($4106C, "PROCESSING")
TextStyle3($4E8AF, 'S', $20, $37, $6) ; TextStyle3($4E8BB, 'T', $20, $37, $6) ; TextStyle3($4E8C7, 'P', $20, $37, $6) ; TextStyle3($4E8D3, $D6, $21, $00, $6)

// Attack Text
TextStyle2($41962, " OHOIOTO", TextType7)
TextStyle1($41098, "NO ONE NEAR")
TextStyle1($413C5, "TO: TARGET")
TextStyle1($4108C, "EMPTY SPACE")

// Exit Action Text
TextStyle2($41959, "EONODOSO", TextType7)
TextStyle2($41035, "C8A8N8C8E8L8", TextType7)
TextStyle1($40CD0, "TURN ENDED")
TextStyle1($463CE, "ENDOF TURN?")
TextStyle1($40E35, "YES-A NO-B BUTTON")
TextStyle2($410A4, "V0I0E0W0", TextType7)


// Albert Transformations
TextStyle2($40C74, "T8A8R8G8", TextType7)
TextStyle2($41077, " 8S8E8T8S0E0L0E0C0T0", TextType7)
TextStyle2($410AD, "E8T8 0E0M0P0T0Y0", TextType7)

// Neumann Magic
TextStyle2($479C5, "WOMOAOGOIOCO", TextType7)
TextStyle1($479B9, "CURE")
TextStyle1($444E6, "WHO WILL YOU CURE?")
TextStyle1($479BE, "LIF")
TextStyle1($479C2, "HL")
TextStyle1($44693, "WHO?")

// Sofia Magic
TextStyle2($41347, "BOLO", TextType7)
TextStyle2($4196B, "BOLOCOKO", TextType7)
TextStyle1($479D8, "LIT")
TextStyle1($479DC, "FIRE")
TextStyle1($479E2, "WARP")
TextStyle1($4468E, "TO ?")


// Boss Monster Magic
TextStyle1($418E0, "SHOC") // Golem
TextStyle2($418E7, "SOHOOOCO", TextType7)


// Battle Messages
TextStyle3($14E62, 'H', $20, $37, $9) ; TextStyle3($14EAF, 'P', $20, $37, $9) ; TextStyle3($14EFC, $D6, $21, $00, $9)
TextStyle3($14DFE, 'A', $20, $37, $9) ; TextStyle3($14E17, 'R', $20, $37, $9) ; TextStyle3($14E30, 'E', $20, $37, $9) ; TextStyle3($14E49, 'A', $20, $37, $9)
TextStyle3($14F5B, 'F', $20, $37, $9) ; TextStyle3($14F74, 'O', $20, $37, $9) ; TextStyle3($14F8D, 'C', $20, $37, $9) ; TextStyle3($14FA6, 'U', $20, $37, $9) ; TextStyle3($14FBF, 'S', $20, $37, $9)

TextStyle2($444D4, "+1 0$8:0", TextType7)
TextStyle1($444DD, "RECEIVED")
TextStyle1($446B4, " :")
TextStyle1($446B7, "SEIZED!")
TextStyle1($44538, "HAS DIED.")
TextStyle1($446BF, "IS STONE...")
TextStyle1($446CB, "STONE..")
TextStyle1($47B19, "IS STONE")
TextStyle1($47F51, "STONE GONE!")


// Map Messages
TextStyle3($4E69E, 'X', $20, $37, $6)
TextStyle3($4E711, 'Y', $20, $37, $6)
TextStyle2($40E20, "M8A8P8 8V8I8E8W8", TextType7)

// Map Terrain Types
TextStyle4($4E605, 'T', $20, $37) ; TextStyle4($4E612, 'P', $20, $37) ; TextStyle4($4E61F, $D6, $21, $00)

TextStyle4($00A24, 'L', $24, $37) ; TextStyle4($00A26, 'A', $24, $37) ; TextStyle4($00A28, 'N', $24, $37) ; TextStyle4($00A2A, 'D', $24, $37)
TextStyle4($00A2C, 'W', $24, $37) ; TextStyle4($00A2E, 'O', $24, $37) ; TextStyle4($00A30, 'O', $24, $37) ; TextStyle4($00A32, 'D', $24, $37)
TextStyle4($00A34, 'S', $24, $37) ; TextStyle4($00A36, 'A', $24, $37) ; TextStyle4($00A38, 'N', $24, $37) ; TextStyle4($00A3A, 'D', $24, $37)
TextStyle4($00A44, 'R', $24, $37) ; TextStyle4($00A46, 'O', $24, $37) ; TextStyle4($00A48, 'A', $24, $37) ; TextStyle4($00A4A, 'D', $24, $37)
TextStyle4($00A4C, 'R', $24, $37) ; TextStyle4($00A4E, 'O', $24, $37) ; TextStyle4($00A50, 'C', $24, $37) ; TextStyle4($00A52, 'K', $24, $37)
TextStyle4($00A64, 'S', $24, $37) ; TextStyle4($00A66, 'E', $24, $37) ; TextStyle4($00A68, 'A', $24, $37)

TextStyle3($4E789, 'R', $28, $37, $6) ; TextStyle3($4E795, 'A', $28, $37, $6) ; TextStyle3($4E7A1, 'T', $28, $37, $6) ; TextStyle3($4E7AD, 'I', $28, $37, $6) ; TextStyle3($4E7B9, 'O', $28, $37, $6)

// Map Monster Status
TextStyle1($40E47, "ENEMY")


// Status - Messages
TextStyle3($27639, 'D', $28, $37, $6) ; TextStyle3($27645, 'E', $28, $37, $6) ; TextStyle3($27651, 'A', $28, $37, $6) ; TextStyle3($2765D, 'T', $28, $37, $6) ; TextStyle3($27669, 'H', $28, $37, $6)
TextStyle3($2767A, 'S', $28, $37, $6) ; TextStyle3($27686, 'T', $28, $37, $6) 

// Status - Item
TextStyle3($4EA49, 'E', $20, $37, $6) ; TextStyle3($4EA55, 'Q', $20, $37, $6) ; TextStyle3($4EA61, $18, $22, $00, $6)

// Status - Time
TextStyle4($249A5, 'P', $20, $37)
TextStyle4($249BC, 'A', $20, $37) ; TextStyle4($249C9, 'M', $20, $37) ; TextStyle4($249D6, $28, $20, $00)
TextStyle3($24A14, 'H', $20, $37, $6)


// Start Screen
TextStyle3($10EBB, $28, $20, $00, $6) ; TextStyle3($10EC7, 'H', $20, $37, $6) ; TextStyle3($10ED3, 'P', $20, $37, $6)
TextStyle3($17A39, 'O', $28, $37, $6) ; TextStyle3($17A45, 'K', $28, $37, $6)
TextStyle1($41699, "EQUI")
TextStyle2($416A0, "RCHC 0:0", TextType7)
TextStyle2($416A9, "LCHC 0:0", TextType7)
TextStyle2($416B2, "ACRCMC:0", TextType7)
TextStyle2($416BB, "LCECGC:0", TextType7)
TextStyle2($416C4, "BCDCYC:0", TextType7)
TextStyle2($416CD, "HCDC 0:0", TextType7)
TextStyle1($40C7D, "ATP:")
TextStyle1($416D6, "DFP:")
TextStyle3($17EA5, 'S', $20, $37, $6) ; TextStyle3($17EB1, 'T', $20, $37, $6) ; TextStyle3($17EBD, 'P', $20, $37, $6)


// Chiberus - Start Of Game
TextStyle2($44619, "MCUCMC:CW0A0N0T0 0T0O0 0H0E0A0R0 0T0H0E0 0S0T0O0R0Y0?0", TextType7)
TextStyle1($4379B, " OK")
TextStyle1($4379F, " NO")

TextStyle1($44674, "SEEKING TO REVIVE GLOBUS.")

TextStyle1($44650, "TOMORROW YOURE")
TextStyle1($4465F, "16,YOU MUST REST UP.")

TextStyle1($43E1F, "PRIEST:OH NO!WHOS THIS?")

TextStyle1($43EA9, "---THE NEXT DAY---")

TextStyle2($43E65, "MCUCMC:C 0W0A0K0E0 0U0P0.0.0.0", TextType7)

TextStyle2($41C7B, "MCUCMC:C 0N0O0W0 0Y0O0U0 0A0R0E0 01060", TextType7)

TextStyle1($41CA4, "YOU INHERIT THE HERO")
TextStyle1($43E99, "SWORD HEIRLOOM.")

TextStyle2($43DF0, "MCUCMC:C 0H0E0R0E0S0 0$010000000 0I0 0H0A0V0E0", TextType7)
TextStyle1($43E84, "BEEN SAVING FOR YOU.")

TextStyle1($43EBC, "I THINK YOU WILL")
TextStyle1($43ECD, "MAKE A FINE HERO!")

TextStyle1($43810, "WARM!!")

TextStyle1($43EDF, "NEUMANN:GOOD MORNING!ALBERT")
TextStyle1($43F0E, "A BARD IS IN THE PLAZA.")

TextStyle1($43F26, "WHAT?")
TextStyle1($43F2C, " SEEMS LIKE FUN")
TextStyle1($43F3C, " PASS")

TextStyle1($43F42, "ALBERT: OK LETS GO NEUMANN")

TextStyle1($43F63, "NEUMANN:OH ALBERT, COME ON!")

TextStyle1($41B59, "BRAVE HERO CLAD IN STEEL...")
TextStyle1($41B76, "WAR RULES THE LAND.")

TextStyle1($41B8A, "FOREVER NEVER ENDS...")

TextStyle1($41BA0, "IT WAS IN GORT THAT A")
TextStyle1($41BB6, "MAGICAL CRYSTAL WAS HELD")

TextStyle1($41BCF, "THAT POWER WAS USED")
TextStyle1($41BE3, "TO REVIVE GOLBUS")

TextStyle1($41BF4, "CURSE OF GORT SEALED IN")
TextStyle1($41C0C, "THE GROUND.")

TextStyle1($45F4A, "PEACE CAME,")
TextStyle1($41C18, "THE WORLD BECOMES ONE")

TextStyle1($41C2E, "THE PRIEST WANTED")
TextStyle1($41C40, "TO SEE YOU")

TextStyle1($41C4B, "ALBERT: ALL RIGHT")
TextStyle1($41C62, "NEUMANN: THANKS")

TextStyle2($41CB9, "PCRCICECSCTC:CP0L0E0A0S0E0 0L0I0S0T0E0N0", TextType7)
TextStyle1($41CE2, "TO MY STORY CLOSELY ALBERT")

TextStyle2($41F1A, "SCOCFCICAC:C 0I0M0 0A0 0M0A0G0E0 0F0R0O0M0 0G0O0R0T0", TextType7)

TextStyle1($41F4F, "ON THE WAY HERE, SUDDENLY")
TextStyle1($41F69, "A MONSTER APPEARED.")

TextStyle1($41F7D, "I ESCAPED,AFTER THE ATTACK")

TextStyle1($41F98, "OSWALD HAS REVIVED AFTER")
TextStyle1($41FB1, "10 YEARS OF PEACE.")

TextStyle1($41FC4, "I NEED TO TELL THE KING...")

TextStyle1($41FDF, "WILL YOU JOIN ME TO GORT?")
TextStyle1($41CFD, " YES ")
TextStyle1($41D03, " NO ")

TextStyle1($41FF9, "THANK YOU..")

TextStyle1($42005, "I WILL NEED YOUR HELP.")

TextStyle1($442B8, "ONE MORE THING TO SAY,")

TextStyle1($442CF, "THE LIGHT 10 YEARS AGO,")

TextStyle1($442E7, "I WITNESSED IT MYSELF.")

TextStyle1($442FE, "I SUMMONED IT.")

TextStyle1($4430D, "I LOST THAT STRANGE POWER")

TextStyle1($44327, "ITS INEVITABLE THAT OSWALD")
TextStyle1($44342, "WILL LOOK FOR ME")

TextStyle1($44353, "ILL ASK YOU TO KEEP THIS")
TextStyle1($4436C, "AS A SECRET")

TextStyle2($41DA8, "SCOCFCICAC:C 0I0 0A0M0 0W0E0L0L0 0N0O0W0", TextType7)

TextStyle2($41DD1, "PCRCICECSCTC:C 0T0A0K0E0 0C0A0R0E0 0O0F0 0S0O0F0I0A0", TextType7)
TextStyle1($41E06, "ALBERT,NEUMANN I THINK YOU")
TextStyle1($41E21, "WILL BECOME A GREAT MONK")


// Chiberus - Outside
TextStyle1($41D08, "MONSTERS ARE GETTING")
TextStyle1($41D1D, "TOUGH OUTSIDE.")

TextStyle1($41D2C, "I AM TAKING WEAPONS TO GORT")

TextStyle1($41EB5, "IT WAS GOOD TO HEAR THE")
TextStyle1($41ECD, "MUSIC")

TextStyle1($41D70, "GORT IS NORTHEAST OF HERE")

TextStyle1($41D8A, "EQUIP YOURSELF IF TRAVELING")

TextStyle1($41D48, "RECORD YOUR PROGRESS TO")
TextStyle1($41D60, "A SAVE DATA LOG")
TextStyle1($44453, "IF YOU STOP THE ADVENTURE")

TextStyle1($41E79, "A GHOST COMES OUT AT NIGHT")

TextStyle1($41E73, "CLUK!")

TextStyle1($4439A, "I WAS BEATEN BY OSWALD..")

TextStyle1($41E94, "FIND ME")

TextStyle1($443B3, "I GOT SICK BEFORE THE GREAT")
TextStyle1($443CF, "BATTLE WITH THE KNIGHTS.")


// Chiberus - Inn
TextStyle1($43781, "REST, IF YOU ARE TIRED...")
TextStyle1($47B80, " BED")
TextStyle1($47B85, " SAVE")

TextStyle1($437A4, "IT WILL BE")
TextStyle1($437AF, "$10 TO STAY.")

TextStyle1($47B8D, "RECORDING SAVE DATA...")

TextStyle1($4388D, "STAY")
TextStyle1($43892, "ANYTIME YOU WANT.")

TextStyle1($4443C, "RECORD A DATA LOG?")
TextStyle1($438E8, "OK")
TextStyle1($4444F, "NO")

TextStyle1($4407F, "L,R: CHANGES ORDER OF PARTY")

TextStyle1($4429E, "MY JOURNEY HERE WAS HARD.")

TextStyle1($440DF, "B: USED TO CANCEL COMMANDS!")

TextStyle1($4425B, "I WAS WORRIED FOR SOFIA")
TextStyle1($44273, "WHEN SHE CAME FROM GORT")


// Chiberus - Item Shop
TextStyle1($4375A, "HOW MAY I BE OF SERVICE?")
TextStyle1($43773, " BUY")
TextStyle1($4377A, " SELL")

TextStyle1($437D9, "WHAT WOULD YOU LIKE")
TextStyle1($437FF, "TO PURCHASE NOW?")

TextStyle1($437CC, "LETS LOOK AT")
TextStyle1($437ED, "YOUR ITEMS VALUES")

TextStyle1($4387C, "COME AGAIN SOON.")

TextStyle1($43FAD, "CHIBWARP TELEPORTS YOU BACK")

TextStyle1($4428B, "AN EGG IS TWICE AS")
TextStyle1($444AD, "STRONG AS A MEDICINAL HERB!")

TextStyle1($43FCB, "THE")
TextStyle1($43FCF, "KNIGHTS OF GORT HAD BATTLED")
TextStyle1($43FEB, "COURAGEOUSLY AGAINST")
TextStyle1($44000, "EVIL OSWALD")

TextStyle1($443E8, "BOO!ALWAYS BE READY.")


// Chiberus - Barn Above Inn
TextStyle1($440FD, "BUTTON")
TextStyle1($44104, "X:ZOOM OUT MAP TO SEE AHEAD")

TextStyle1($44124, "START: WILL SELECT")
TextStyle1($44137, "MEMBERS TO EQUIP!")


// Chiberus - Alberts House
TextStyle1($41E9C, "KEEP TRYING YOUR HARDEST")


// Chiberus - Middle House
TextStyle1($4409B, "BEAT ENEMIES TO")
TextStyle1($440AB, "OBTAIN CASH AND ITEMS")

TextStyle1($44199, "TERRAIN TYPES AFFECT DAMAGE")
TextStyle1($441B8, "STRENGTH")

TextStyle1($44899, "SHOPS BUY AT A FRACTION OF")
TextStyle1($448B4, "THE RETAIL PRICES FOR ITEMS")

TextStyle1($44149, "CIVILIZATION IMPROVED")
TextStyle1($4415F, "BUT PEOPLE HAD A HARD TIME.")

TextStyle1($44038, "THE CRYSTAL WAS")
TextStyle1($44048, "KEY TO OUR REVIVAL")
TextStyle1($4405B, "OUR CIVILIZATION IS")
TextStyle1($4406F, "IN AN EVIL GRIP")

TextStyle1($441E1, "10 YEARS AGO, AT THE BATTLE")
TextStyle1($441FD, "OSWALD WAS BLASTED AWAY")
TextStyle1($44215, "BY BRIGHT LIGHT FROM SOFIA.")
TextStyle1($44231, "SLAY OF GORT HAS TAKEN CARE")
TextStyle1($4424D, "OF HER SINCE.")


// Chiberus - Bottom House
TextStyle1($43F9D, "KNOW ODDFRUIT?")

TextStyle1($44751, "IF USED IN A TOWN IT")
TextStyle1($47A09, "MAKES IT NIGHT TIME")

TextStyle1($44766, "WHAT A LONG DAY IT IS!")

TextStyle1($4400C, "WHAT WAS THE LIGHT ABOUT")

TextStyle1($440C1, "AT NIGHT FOES ARE MORE")
TextStyle1($440D8, "STRONG")

TextStyle1($44025, "OSWALD HAS REVIVED")

TextStyle1($4417B, "REAR ATTACKS ARE EFFECTIVE.")

TextStyle1($44417, "I COULD NOT SLEEP..")
TextStyle1($4442B, "THINKING A LOT..")


// Chiberus - Priest
TextStyle1($44378, "HOW MAY I SERVE YOU?")

TextStyle1($4446D, " HEAL ALL")
TextStyle1($47F21, "MAY YOU EACH BE HEALED...")
TextStyle1($4438D, "I DO MY BEST")

TextStyle1($44477, " REVIVE ALL PARTY")
TextStyle1($47AAC, "GIVE $300 PLEASE")
TextStyle1($44489, "NOBODY SEEMS TO BE DEAD")


// Chiberus - Egg Shop
TextStyle2($41ED3, "HCACYC CGCICRCLC:CH0E0R0E0 0I0S0 0A0N0 0E0G0G0", TextType7)
TextStyle1($41F02, " OK")
TextStyle1($41F06, " NO")

TextStyle1($41F0C, "IM GLAD,HO HO")

TextStyle1($4201C, "MY EGGS ARE REALLY")
TextStyle1($44527, "VERY DELICIOUS")


// Gort - Outside
TextStyle1($42087, "WELCOME TO THE CITY OF GORT")

TextStyle1($420EA, "PLEASE VISIT")
TextStyle1($420F7, "CASTLE, TO SEE KING")

TextStyle1($420A3, "KNOW ABOUT NEURATH TOWN?")

TextStyle1($4518C, "IT IS BEING")
TextStyle1($420BC, "ATTACKED BY A DEMON NOW")

TextStyle1($420D4, "ITS IN THE NORTHWEST.")

TextStyle1($4202F, "MONSTERS APPEARING ALL OVER")

TextStyle1($4210B, "MONSTERS ARE HARD WORK")

TextStyle1($4206A, "ITS HARD ENOUGH, PROTECTING")
TextStyle1($4214F, "OUR TOWN")


// Gort - Bottom Left House
TextStyle1($44734, "SHOULD NOT CONTEMPLATE LOSS")


// Gort - Bottom Middle Left House
TextStyle1($4204D, "WHY WAS I BORN IN THIS ERA.")

TextStyle1($42122, "MY DAD WAS A KNIGHT.")

TextStyle1($42137, "WE NEED TO REGAIN POWER")
TextStyle1($42158, "USING SLAYS EXAMPLE.")

TextStyle1($443FD, "SLEEPY")


// Gort - Bottom Middle Right House
TextStyle1($44963, "WOMEN USED TO BE RECRUITED.")

TextStyle1($441C1, "OSWALD IS BECOMING")
TextStyle1($441D4, "MORE FAMOUS!")


// Gort - Bottom Right House
TextStyle1($448FF, "WE NEED TO FIND")
TextStyle1($4490F, "THE CRYSTAL OF GLOBUS")

TextStyle1($44925, "WE CAN DEPEND ON SLAY")

TextStyle1($4493B, "WONT STAND A CHANCE")
TextStyle1($4494F, "AGAINST OSWALD NOW.")


// Gort - Middle Right House
TextStyle1($4477D, "I CAME TO GORT 8 YEARS AGO.")

TextStyle1($44799, "WHEN I GROW,I WANT TO BE A")
TextStyle1($447B4, "GORT KNIGHT.")

TextStyle1($44404, "UP LATE THIS NIGHT")


// Gort - Bar
TextStyle1($446D3, "BUSINESS IS GOING SLOW,")
TextStyle1($446EB, "WINES THE BEST CURE.")

TextStyle1($44700, "AT LEAST I CAN SLEEP SAFE")
TextStyle1($4471A, "THANKS TO THE KNIGHTS AID")


// Gort - Middle Left House
TextStyle1($448D0, "GLOBUS IS SEALED IN THE")
TextStyle1($448E8, "GROUND.OSWALD IS THERE")


// Gort - Forge
TextStyle1($43817, "HI!I WORK METAL")

TextStyle1($43827, " BUY GOODS")
TextStyle1($43832, " NO TRADE")

TextStyle1($4383C, "TAKE YOUR TIME")
TextStyle1($4384B, "SEE MY GOODS")

TextStyle1($438C1, "WHAT!")
TextStyle1($43858, "I HAVE FINE GOODS")

TextStyle1($438C7, "COME ANY TIME")


// Gort - Shade Shop (Red Cap)
TextStyle2($4482E, "SCHCACDCEC:CD0O0 0Y0O0U0 0W0A0N0T0 0A0 0W0A0R0P0?0", TextType7)

TextStyle1($44861, "HERES WHAT I HAVE")

TextStyle1($4487D, "YOU CAN")
TextStyle1($44873, "WARP HERE")

// Gort - Hebe Shop (Blue Cap)
TextStyle2($447C1, "HCECBCEC:CS0E0E0 0M0Y0 0N0I0C0E08191?0", TextType7)

TextStyle1($447E8, "SEE MY AMAZINGLY FINE GOODS")

TextStyle1($44811, "COME AGAIN, IF")
TextStyle1($44804, "YOU WANT IT.")

TextStyle1($47F3C, "I CAN NOT WEAR THEM.")


// Gort - Castle
TextStyle1($4497F, "WERE PROTECTING THE KING.")

TextStyle2($449AC, "GCUCACRCDCSC:C 0N0E0E0D0 0T0H0E0 0K0I0N0G0?0", TextType7)

TextStyle1($44999, "SPEAK TO THE KING.")

TextStyle1($449D9, "DONT NEED TO VISIT,")
TextStyle1($449ED, "YOURE WASTING TIME!")

TextStyle1($4216D, "KINGS STRONGER THAN")
TextStyle1($42181, "EVER TO RESOLVE PROBLEMS")

TextStyle1($4219A, "IVE BEEN TOLD OSWALD")
TextStyle1($421AF, "IS REVIVED")

TextStyle1($421BA, "HIS EVIL GRIP IS TIGHTER")

TextStyle1($421D3, "WE ARE SITTING DUCKS HERE..")

TextStyle1($42206, "ARE YOU TO BRING US PEACE?")

TextStyle1($42221, "SORRY I MISUNDERSTOOD YOU.")

TextStyle1($4223C, "OH COURAGE!")
TextStyle1($42248, "YOU MUST MEET WITH SLAY.")

TextStyle1($42261, "HE ALSO FOUGHT OSWALD.")

TextStyle1($42278, "YOU NEED TO GAIN HIS TRUST")

TextStyle1($42293, "HE WILL HELP, IF YOU")
TextStyle1($422A8, "BRING ME GOLEMS HEAD.")

TextStyle1($422BE, "I ALSO NEED THE GOLEM HEAD.")

TextStyle1($422DC, "MAY I HAVE IT")

TextStyle1($422EA, "EXCHANGE LETTER FOR HEAD?")

TextStyle1($42304, "SLAY LIVES IN NEURATH")
TextStyle1($4231A, "HES A GREAT GORT KNIGHT.")

TextStyle1($42333, "YOU SHOULD GET THE LETTER")
TextStyle1($4234D, "TO SLAY QUICKLY.")

TextStyle1($44A0E, "SO BE IT.")

TextStyle1($44A18, "THATS ALL")
TextStyle1($44A22, "I HOPE THAT YOU RETURN SAFE")

TextStyle1($44A3E, "EXPECT YOU TO SUCCEED!")


// Neurath - Outside
TextStyle1($45E68, "KNOW ABOUT SAGE FILO?")

TextStyle1($45E7E, "I ALSO DONT KNOW.")

TextStyle1($45E90, "VERY RARE TO MEET HIM")


// Neurath - Bottom Left House
TextStyle1($45768, "GOING TO MIKEANA")

TextStyle1($45779, "SOUTHEAST FROM GORT")

TextStyle1($46ABD, "PASS IT TO REACH COURT ROAD")

TextStyle1($44AC5, "CONVERSE WITH ANOBA")

TextStyle1($44AD9, "PLEASE BEHAVE POLITELY")

TextStyle1($44AF0, "HMMM")

TextStyle1($44AF5, "WHERES THE CRYSTAL!")


// Neurath - Jennifer Shop (Green Head)
TextStyle2($44A55, "JCECNCYC:CN0E0E0D0 0N0E0U0R0A0T0H0 0W0A0R0P0?0", TextType7)

TextStyle1($44A84, "YAY,THANK YOU")

TextStyle1($44AA2, "PLEASE,")
TextStyle1($44A92, "I HAVE CHILDREN")