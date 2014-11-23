// SNES "Super Soukoban" Japanese To English Translation by krom (Peter Lemon):

output "Super Soukoban.sfc", create
origin $00000; insert "Super Soukoban (J).sfc" // Include Japanese Super Soukoban SNES ROM

macro TextStyle1(OFFSET, TEXT) {
  origin {OFFSET}
  db {TEXT}
}

// Char Table 1
map ' ', $20
map '!', $21
map '(', $28
map ')', $29
map '-', $2D
map '.', $2E
map '/', $2F
map '0', $30, 10
map ':', $3A
map '<', $3C
map '=', $3D
map '>', $3E
map '?', $3F
map '@', $40
map 'A', $41, 26

// Editor
TextStyle1($01C65, "MAP EDIT")
TextStyle1($01CC5, " SET TILE ")

TextStyle1($01C6F, "PLAY MAP")
TextStyle1($01D61, "NO MAP TO PLAY.")

TextStyle1($01C79, "MAP LOAD")
TextStyle1($01D02, "LOAD LEVEL:")
TextStyle1($018D4, "TRIAL SET")
TextStyle1($018DD, "WARM  SET")
TextStyle1($018E6, "SUMO  SET")
TextStyle1($018EF, "EPIC  SET")
TextStyle1($018F8, "GRAND SET")
TextStyle1($01901, "TOUGH SET")
TextStyle1($01D36, "MAP:01 ")

TextStyle1($01C83, "DELETE")
TextStyle1($01D8E, "ERASE ALL")
TextStyle1($01D99, "MAP DATA?")
TextStyle1($01DA4, " YES/NO  ")

TextStyle1($01C8D, "EXIT")


// Char Table 2
map '*', $19

map '0', $55, 10
map ' ', $A0
map 'A', $A1, 26
map '[', $B1
map '$', $B2
map ']', $B3
map '/', $B4
map '.', $B5
map $2C, $B6 // map ',', $B6
map '-', $B8

// Start Screen
TextStyle1($01085, " *1*P* *S*O*K*O*B*A*N* *")
TextStyle1($010A1, " *2*P* *S*O*K*O*B*A*N* *")
TextStyle1($010BD, " * * * * * * * * * * * *")
TextStyle1($010D9, " *M*A*P* *E*D*I*T*O*R* *")