// SNES "Soreyuke Ebisumaru Karakuri Meiro - Kieta Goemon no Nazo!!" Japanese To English Translation by krom (Peter Lemon):

output "Ebisumaru Puzzle Maze - Goemon is Missing!!.sfc", create
origin $00000; insert "Soreyuke Ebisumaru Karakuri Meiro - Kieta Goemon no Nazo!! (J).sfc" // Include Japanese Soreyuke Ebisumaru Karakuri Meiro - Kieta Goemon no Nazo!! SNES ROM

macro TextNormal(OFFSET, TEXT) {
  origin {OFFSET}
  db {TEXT}
}

macro TextTitleScreenUpper(OFFSET, TEXT) {
  // Char Table (Title Screen Top)
  map ' ', $00
  map 'A', $00, 16
  map 'Q', $20, 10

  map '<', $8C
  map '>', $8D
  map '!', $8E

  map 'b', $22 // Blue   Font color
  map 'y', $26 // Yellow Font color

  origin {OFFSET}
  db {TEXT}
}

macro TextTitleScreenLower(OFFSET, TEXT) {
  // Char Table (Title Screen Bottom)
  map ' ', $00
  map 'A', $10, 16
  map 'Q', $30, 10

  map '<', $9C
  map '>', $9D
  map '!', $9E

  map 'b', $22 // Blue   Font color
  map 'y', $26 // Yellow Font color

  origin {OFFSET}
  db {TEXT}
}

// Include English Font
origin $A46DE; insert "Font2BPPENG.rle" // 128x128 2BPP Konami RLE

// Include English Title Screen Font
origin $A502E; insert "TitleScreenFont4BPPENG.rle" // 128x88 4BPP Konami RLE


// TITLE SCREEN (Blue) 
TextTitleScreenUpper($0C629, "SbTbObRbYb  MbObDbEb            ")
TextTitleScreenLower($0C669, "SbTbObRbYb  MbObDbEb            ")

TextTitleScreenUpper($0C689, "MbUbLbTbIb  PbLbAbYbEbRb        ")
TextTitleScreenLower($0C6C9, "MbUbLbTbIb  PbLbAbYbEbRb        ")

TextTitleScreenUpper($0C6E9, "PbAbSbSbWbObRbDb  IbNbPbUbTb    ")
TextTitleScreenLower($0C729, "PbAbSbSbWbObRbDb  IbNbPbUbTb    ")

TextTitleScreenUpper($0C749, "CbObNbFbIbGbUbRbAbTbIbObNb      ")
TextTitleScreenLower($0C789, "CbObNbFbIbGbUbRbAbTbIbObNb      ")

// TITLE SCREEN (Yellow) 
TextTitleScreenUpper($0C7A9, "SyTyOyRyYy  MyOyDyEy            ")
TextTitleScreenLower($0C7E9, "SyTyOyRyYy  MyOyDyEy            ")

TextTitleScreenUpper($0C809, "MyUyLyTyIy  PyLyAyYyEyRy        ")
TextTitleScreenLower($0C849, "MyUyLyTyIy  PyLyAyYyEyRy        ")

TextTitleScreenUpper($0C869, "PyAySySyWyOyRyDy  IyNyPyUyTy    ")
TextTitleScreenLower($0C8A9, "PyAySySyWyOyRyDy  IyNyPyUyTy    ")

TextTitleScreenUpper($0C8C9, "CyOyNyFyIyGyUyRyAyTyIyOyNy      ")
TextTitleScreenLower($0C909, "CyOyNyFyIyGyUyRyAyTyIyOyNy      ")


// MULTI PLAYER
// Char Table (Multi Player)
  map 'A', $00, 16
  map 'Q', $20, 10
  map ' ', $2A

  map '<', $8C
  map '>', $8D
  map '!', $8E

TextNormal($0A6A4, "START!")
TextNormal($0A6B5, "EXIT!!")
TextNormal($0A6CE, "COURSE")
TextNormal($0A6D7, "SCORE TO WIN")
TextNormal($0A6EE, "CONFIGURATION ")


// NPC
// Char Table (NPC)
map ' ', $00
map '0', $01, 10
map 'A', $0B, 26
map 'a', $25, 20
map 'u', $67
map 'v', $39, 5
map '\s', $3E // Single Quote
map '<', $3F // Double Quote Left
map '>', $40 // Double Quote Right

map $2C, $70 // Comma ","
map '.', $71
map '_', $72
map '-', $73
map '!', $74
map '?', $75
map '$', $79
map '\n', $FE // newline

constant NEWPAGE($FD) // New Page Character
constant ENDTEXT($FF) // End Text Character

// NPC SHOP
TextNormal($0C9D6, "Welcome.\n")
                db "How may I help?", NEWPAGE
                db "You can hold 1 item", ENDTEXT

TextNormal($0CA03, "Armor. Price $300.\n")
                db "Takes 1 enemy hit.", ENDTEXT

TextNormal($0CA29, "Clock. Price $500.\n")
                db "Gives extra time.", ENDTEXT

TextNormal($0CA51, ". Price $800.\n")
                db "Add extra life.", ENDTEXT

TextNormal($0CA6F, "Is this OK?\n")
                db "      Yes    No ", ENDTEXT

TextNormal($0CA8C, "Thank you.  ") ; db ENDTEXT

TextNormal($0CA99, "Need more gold!") ; db ENDTEXT

TextNormal($0CAA9, "Visit anytime.") ; db ENDTEXT


TextNormal($0CC38, "Welcome. Slot machine\n")
                db "1 play $5.", NEWPAGE
                db "Rules are simple. Push\n"
                db "button stops drum.", NEWPAGE
                db "Match symbols to win.", NEWPAGE
                db "Play?\n"
                db "      Play   Quit", ENDTEXT

TextNormal($0CCB1, "No Win") ; db ENDTEXT

TextNormal($0CCB8, "777!!  You win $500.") ; db ENDTEXT

TextNormal($0CCCD, "Cherries! Win $10.") ; db ENDTEXT

TextNormal($0CCE0, "Bells! Win $15.") ; db ENDTEXT

TextNormal($0CCF0, "Cats!! Win $50.") ; db ENDTEXT

TextNormal($0CD00, "Orange! Win $15.") ; db ENDTEXT

TextNormal($0CD11, "Play again?\n")
                db "     Yes    No  ", ENDTEXT

TextNormal($0CD2F, "Please come again. ") ; db ENDTEXT

// NPC
TextNormal($0CE93, "Huh, who are you?\n")
                db "Why are you on", NEWPAGE
                db "<Karakuri Island>?\n"
                db "A guy in red clothes", NEWPAGE
                db "came by, but I was in\n"
                db "such a rush...", ENDTEXT

TextNormal($0CF01, "Eat a meal to keep\n")
                db "your energy high.", ENDTEXT

TextNormal($0CF26, "What? Goemon?!\n")
                db "Was that his name?!", NEWPAGE
                db "Asking me questions.\n"
                db "I hope he's OK?", ENDTEXT

TextNormal($0CF6E, "This island is nice.\n")
                db "It's all a maze.", ENDTEXT

TextNormal($0CF94, "To go a long way\n")
                db "use <Seesaw> to jump.", NEWPAGE
                db "You need a <Weight>\n"
                db "to make use of one.", ENDTEXT

TextNormal($0CFE3, "To change direction\n")
                db "press on the red floor.", ENDTEXT

TextNormal($0D00F, "Aim the <Human Cannon>\n")
                db "using timing on your", NEWPAGE
                db "button press!!", ENDTEXT

TextNormal($0D04A, "When entering a\n")
                db "<Light Hole>", NEWPAGE
                db "you can warp... Me? I\n"
                db "have not tried myself.", ENDTEXT

TextNormal($0D094, "Watchout for the bad\n")
                db "robot in the maze.", ENDTEXT


TextNormal($0D265, "Use the spring to\n")
                db "defeat enemies.", NEWPAGE
                db "However, it\n"
                db "accelerates your speed", NEWPAGE
                db "dangerously!\n"
                db "Take care with it!", ENDTEXT

TextNormal($0D2CA, "You're a real person!?\n")
                db "This is no place", NEWPAGE
                db "for you.\n"
                db "Why visit here?", ENDTEXT

TextNormal($0D30B, "What?? I'm hungry!?\n")
                db "I don't have food.", NEWPAGE
                db "There might be a shop.\n"
                db "But in <Karakuri>", NEWPAGE
                db "I've not seen any food.\n"
                db "I wonder why??", ENDTEXT

TextNormal($0D382, "The shop next door has\n")
                db "a big slot machine.", NEWPAGE
                db "I don't know myself,\n"
                db "but	I heard you win", NEWPAGE
                db "money by matching the\n"
                db "symbols. The jackpot", NEWPAGE
                db "can be won with 777.\n"
                db "Will you get lucky?...", ENDTEXT

TextNormal($0D432, "If you have any money,\n")
                db "try to go next door.", NEWPAGE
                db "He is now back after a\n"
                db "long time away.", ENDTEXT

// INTRO
// Char Table (INTRO)
map ' ', $00
map '0', $01, 10
map '$', $0B
map $2C, $0E // Comma ","
map '.', $0F
map 'A', $20, 16
map 'Q', $40, 10
map 'a', $4A, 6
map 'g', $60, 15
map 'v', $80, 5
map '\s', $85 // Single Quote
map '<', $86 // Double Quote Left
map '>', $87 // Double Quote Right

map '_', $EC
map '-', $ED
map '!', $EE
map '?', $EF

TextNormal($F0000, "Hi Goemon. Are you in?  ") ; db $00

TextNormal($F0019, "Huh? Where did you go?  ") ; db $00

TextNormal($F0032, "Well, I guess I'll have  ") ; db $00
                db "to eat this food alone!?", $00

TextNormal($F0065, "???????????????????????") ; db $00

TextNormal($F007D, "What is this letter...? ") ; db $00
                db "Hmm? What???           ", $00

TextNormal($F00AE, "I'm going to <Karakuri  ") ; db $00
                db "Island> take care_Goemon", $00

TextNormal($F00E0, "Do not worry Goemon...   ") ; db $00
                db "What am I going to do? ", $00

TextNormal($F0112, "Well, yeah. I could play  ") ; db $00
                db "a game to kill time.     ", $00

TextNormal($F0147, "At any rate, Goemon.    ") ; db $00
                db "I still feel hungry.   ", $00

TextNormal($F0178, "Are you in any trouble?") ; db $00

TextNormal($F0190, "After all, this does not ") ; db $00
                db "seem good for Goemon.  ", $00

TextNormal($F01C2, "I hope he is all right.   ") ; db $00

TextNormal($F01DD, "What if he is missing...") ; db $00
                db "Why didn't you say hi!!!", $00

TextNormal($F020E, "Now I'm the lead role... ") ; db $00