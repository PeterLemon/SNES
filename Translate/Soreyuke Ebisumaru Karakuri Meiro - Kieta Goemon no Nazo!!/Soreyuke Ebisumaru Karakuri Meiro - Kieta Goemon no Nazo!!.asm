// SNES "Soreyuke Ebisumaru Karakuri Meiro - Kieta Goemon no Nazo!!" Japanese To English Translation by krom (Peter Lemon):

output "Ebisumaru Puzzle Maze - Goemon is Missing!!.sfc", create
origin $00000; insert "Soreyuke Ebisumaru Karakuri Meiro - Kieta Goemon no Nazo!! (J).sfc" // Include Japanese Soreyuke Ebisumaru Karakuri Meiro - Kieta Goemon no Nazo!! SNES ROM

macro TextNormal(OFFSET, TEXT) {
  origin {OFFSET}
  db {TEXT}
}

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

// Include English Font
origin $A46DE; insert "FontENG.rle" // 128x128 2BPP Konami RLE

// NPC Text
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

// INTRO Text
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