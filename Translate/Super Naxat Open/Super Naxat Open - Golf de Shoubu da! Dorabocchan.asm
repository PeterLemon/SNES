// SNES "Super Naxat Open - Golf de Shoubu da! Dorabocchan" Japanese To English Translation by krom (Peter Lemon):

output "Super Naxat Open - Golf Challenge!.sfc", create
origin $00000; insert "Super Naxat Open - Golf de Shoubu da! Dorabocchan (J).sfc" // Include Japanese Super Naxat Open - Golf de Shoubu da! Dorabocchan SNES ROM

// Char Table 1
map ' ', $00
map '0', $01, 10
map 'A', $0B, 26
map '+', $81
map '-', $82
map '<', $83
map '>', $84
map '!', $85
map '?', $86
map '/', $87
map '.', $88

macro TextStyle1(OFFSET, TEXT) {
  origin {OFFSET}
  db {TEXT}
}

// Hi Score
TextStyle1($0CBA2, "BASSX")
TextStyle1($0CBAA, "YOROI")
TextStyle1($0CBB2, "MGORA")
TextStyle1($0CBBA, "YETI ")
TextStyle1($0CBC2, "TIANA")
TextStyle1($0CBCA, "YUSAF")
TextStyle1($0CBD2, "SKULL")
TextStyle1($0CBDA, "GETOR")
TextStyle1($0CBE2, "YANDU")
TextStyle1($0CBEA, "CDASS")
TextStyle1($0CC10, "MDORA")
TextStyle1($0CC18, "REPEL")
TextStyle1($0CC20, "TOYOU")
TextStyle1($0CC28, "YUKIR")
TextStyle1($0CC30, "RGORA")
TextStyle1($0CC38, "KARIN")
TextStyle1($0CC40, "TOSHI")
TextStyle1($0CC48, "AZUSA")
TextStyle1($0CC50, "GOUDO")
TextStyle1($0CC58, "NIKKI")

// Title Screen
TextStyle1($7EDC4, "MASTERS OPEN")
TextStyle1($7ED46, "1994 RED 2013 KROM")

// Config
TextStyle1($7E8F4, "CONFIGURE CONTROL PAD")

// Continue
TextStyle1($7EB01, "CHOOSE SLOT TO LOAD ")

TextStyle1($7EC1C, "THERE")
TextStyle1($7EC24, "IS NO DATA")

TextStyle1($7F995, "STROK")
TextStyle1($7F99B, "MATCH")

TextStyle1($7EBD8, "TEXT")
TextStyle1($7EBDF, " SPD")
TextStyle1($7F9A7, "FST")
TextStyle1($7F9AB, "NOR")
TextStyle1($7F9AF, "SLW")

// Naxat/Masters Open Stroke/Match Play
TextStyle1($7FBC3, "MASTERS OPEN")

TextStyle1($7E804, "PLAYERS?")
TextStyle1($7B3E8, "SETS UP PLAYERS!...")
TextStyle1($7B3FF, "MATCHPLAY IS 2PLAYER")

TextStyle1($7E81D, "NO.HOLES?")
TextStyle1($7B416, "PICK HOLES TO PLAY")

TextStyle1($7E835, "SET")
TextStyle1($7F946, "AMATEUR")
TextStyle1($7B42B, "SET GAME MODE!")
TextStyle1($7B43D, "TRY PRO CHALLENGE!")

TextStyle1($7E83D, "TEXTS?")
TextStyle1($7F95C, "FAST ")
TextStyle1($7F962, "NORM ")
TextStyle1($7F968, "SLOW ")
TextStyle1($7B452, "SET MESSAGE SPEED")

TextStyle1($7E848, "BGM.SET")
TextStyle1($7F972, "STEREO ")
TextStyle1($7F97A, "MONO   ")
TextStyle1($7B466, "SOUND OUTPUT!")

// Player Select
TextStyle1($7F3E9, "SPIKE  ")
TextStyle1($7F3F1, "CAMELIA")
TextStyle1($7F3F9, "HYDRA  ")
TextStyle1($7F401, "K.CLOVE")
TextStyle1($7F409, "P.STEAM")
TextStyle1($7F411, "FELINA ")

TextStyle1($7E5EE, "HIT")
TextStyle1($7E601, "SKILL")
TextStyle1($7E614, "POSE")
TextStyle1($7E627, "SPN")
TextStyle1($7E63C, "POWER")

TextStyle1($7F7DD, "GRASS DRIVES")
TextStyle1($7B477, "HE IS EVENLY SKILLED")
TextStyle1($7B48F, "BEGINNERS CHOICE!")

TextStyle1($7F7A9, "ROUGH SHOTS ")
TextStyle1($7B4A3, "NOT TOO MUCH POWER")
TextStyle1($7B4B9, "BUT PLENTY OF SKILL")

TextStyle1($7F79C, "NONE SPECIAL")
TextStyle1($7B4CF, "HAS THE STRONGEST HIT")
TextStyle1($7B4E8, "CAN BE A BIT CLUMSY!!")

TextStyle1($7F7C3, "WEDGE STRIKE")
TextStyle1($7B500, "SMALL IN STATURE BUT")
TextStyle1($7B518, "HAS A GOOD STANCE")

TextStyle1($7F7B6, "BUNKER SHOTS")
TextStyle1($7B52C, "SPINS THE BALL WHEN")
TextStyle1($7B543, "OUT OF A BUNKER")

TextStyle1($7F7D0, "WINDY STRIKE")
TextStyle1($7B555, "MANIPULATES A WINDY")
TextStyle1($7B56C, "SHOT VERY WELL")

// Caddy Select
TextStyle1($7E66B, "CADDYSELECT")

TextStyle1($7F429, "VHESLER")
TextStyle1($7F431, "CLARENC")
TextStyle1($7F439, "ENDORA ")
TextStyle1($7F441, "YUNI   ")
TextStyle1($7F449, "FREEZER")
TextStyle1($7F451, "CROC   ")

TextStyle1($7E709, "CARD")

TextStyle1($7F8EA, ".HEIGHT")
TextStyle1($7B57D, "CADDY POSSESS A CLUB")
TextStyle1($7B595, "THAT HAS ATTACK POWER")

TextStyle1($7F92A, ".OKAY  ")
TextStyle1($7B5AD, "HIS GREAT GRANDFATHER")
TextStyle1($7B5C6, "WAS THE CLUBS FOUNDER")

TextStyle1($7F90A, ".DASH  ")
TextStyle1($7B5DE, "THIS CADDY HAS A")
TextStyle1($7B5F2, "TECHNICAL CLUB")

TextStyle1($7F91A, ".HOMING")
TextStyle1($7B603, "HAS DECENT CLUBS AND")
TextStyle1($7B61B, "GIVES FRIENDLY ADVICE")

TextStyle1($7F8E2, "TOPSPIN")
TextStyle1($7B633, "MAKES STEADY CHOICES")
TextStyle1($7B64B, "FOR SHOTS")

TextStyle1($7F912, "REPLACE")
TextStyle1($7B657, "EXPERIENCED BRINGS")
TextStyle1($7B66D, "A STRONG SET OF CLUBS")

// Stroke Play Rules
TextStyle1($7EE42, "GAME RULES")

TextStyle1($7D008, ".STROKE PLAY MODE")
TextStyle1($7D01D, "LEAST NUMBER OF SHOTS WILL")
TextStyle1($7D03B, "WIN THE GAME")

TextStyle1($7D051, ".PRO MODE - DIFFERENCES")
TextStyle1($7D06C, "BETWEEN AMATEUR MODE..")
TextStyle1($7D086, "WIND DIRECTION/SPEED MUCH")
TextStyle1($7D0A3, "MORE SEVERE THAN NORMAL..")
TextStyle1($7D0C0, "IF YOU LIKE THRILLS THERE")
TextStyle1($7D0DD, "IS PLENTY IN THIS MODE!")

// Match Play Rules
TextStyle1($7D0F8, ".MATCH PLAY MODE")
TextStyle1($7D10C, "2 PLAYERS EARN POINTS FOR")
TextStyle1($7D129, "EVERY HOLE WON A HIGH SCORE")
TextStyle1($7D148, "WINS THE GAME")

TextStyle1($7D15A, ".PRO MODE - DIFFERENCES")
TextStyle1($7D175, "BETWEEN AMATEUR MODE..")
TextStyle1($7D18F, "WIND DIRECTION/SPEED MUCH")
TextStyle1($7D1AC, "MORE SEVERE THAN NORMAL..")
TextStyle1($7D1C9, "IF YOU LIKE THRILLS THERE")
TextStyle1($7D1E6, "IS PLENTY IN THIS MODE!")

// Course Select
TextStyle1($7BBA9, "CHOOSE A COURSE TYPE!")
TextStyle1($7BBC2, "SIX HOLES PER COURSE")

TextStyle1($7B758, "DESERT COURSE. TRY")
TextStyle1($7B76E, "NOT TO GET STUCK!")

TextStyle1($7B782, "JUNGLE COURSE.ITS")
TextStyle1($7B797, "EASY TO LAND IN ROUGH")

TextStyle1($7B7AF, "LAKE COURSE.TAKE CARE")
TextStyle1($7B7C8, "NOT TO LAND IN WATER!")








// Player Text
TextStyle1($78007, "TRY TODO MY")
TextStyle1($78016, "BEST!")

TextStyle1($7801F, "I TRY MUCH")
TextStyle1($7802D, "MORE!")

TextStyle1($78036, "WONT GIVE UP!")

TextStyle1($78061, "BECOME STRONG!")
TextStyle1($78073, "I AIM TO BE A PRO!!")

TextStyle1($7808A, "TRY FOR A NEW RECORD!")

TextStyle1($780A3, "TRY MY LUCK! THIS")
TextStyle1($780B8, "HOLE IS MINE")

TextStyle1($780E4, "SEE GENIUS AS I PLAY")
TextStyle1($780FC, "PROFESSIONAL GOLF!")

TextStyle1($78112, "HA...MY TURN...")

TextStyle1($78125, "HERE I COME... I WILL")
TextStyle1($7813E, "SHOW REAL POWER!")

TextStyle1($7818A, "LOOKIE!")

TextStyle1($78195, "LOOK ON!")

TextStyle1($781A1, "SEE ME!")

TextStyle1($781BF, "COULD IT BE AN EAGLE?")

TextStyle1($781D8, "ITS TIME FOR THE TRUE")
TextStyle1($781F1, "POWER OF THE EAGLE")

TextStyle1($78207, "I THINK I CAN CONVERT")
TextStyle1($78220, "IT INTO AN EAGLE!")

TextStyle1($78251, "I THINK IVE")
TextStyle1($78260, "GOT HANG OF IT!!")

TextStyle1($78274, "CAN I MANAGE")
TextStyle1($78284, "A GREAT SCORE?")

TextStyle1($78296, "I AM GONNA")
TextStyle1($782A4, "SHOW YOU MY POWER")

// Caddy Text
TextStyle1($78340, "I AM THE EVIL EMPEROR")
TextStyle1($78359, "ILL GIVE ADVICE!")
TextStyle1($7836E, "NOT MUCH TO SAY FOR")
TextStyle1($78385, "THIS HOLE... I SHOOT")
TextStyle1($7839E, "BLIND AT FULL POWER!")

TextStyle1($78E3D, "LISTEN UP...")
TextStyle1($78E4D, "FOR THIS HOLE YOU")
TextStyle1($78E63, "CAN SLICE TO KEEP")
TextStyle1($78E78, "ON THE FAIRWAY. NEED")
TextStyle1($78E91, "BACKSPIN TO HELP TO")
TextStyle1($78EA8, "AVOID ENDING IN")
TextStyle1($78EBC, "THE BUNKER.")

TextStyle1($7A258, "YOU CALLED? YES")
TextStyle1($7A26B, "IT IS A LONG DRIVE ON")
TextStyle1($7A285, "THIS HOLE TRY TO STAY")
TextStyle1($7A29E, "IN THE CENTER OF")
TextStyle1($7A2B3, "A NARROW FAIRWAY")

// Start Hole
TextStyle1($7DC57, "PTS")

// Ball Control
TextStyle1($7FB59, "TOP SPIN")
TextStyle1($7FB62, "NORMAL  ")
TextStyle1($7FB6B, "BACKSPIN")

TextStyle1($7FB7A, "STRIKE ")
TextStyle1($7FB82, "HOOK   ")
TextStyle1($7FB8A, "SLICE  ")

// Card Select
TextStyle1($7D8EC, "TO USE ")
TextStyle1($7D8FB, " PRESS Y")
TextStyle1($7D90B, "TO SKIP")
TextStyle1($7D91A, " PRESS A")

TextStyle1($7D92A, "LEFT")
TextStyle1($7D936, "+ RIGHT")
TextStyle1($7D945, " SELECT")

TextStyle1($7FB0D, "GLUETUBE")
TextStyle1($7BC7E, ".GLUE BALL TO")
TextStyle1($7BC8F, "THE GROUND.")

TextStyle1($7FB16, "PSYCHO")
TextStyle1($7BCA2, ".USE DPAD TO")
TextStyle1($7BCB2, "CONTROL BALL.")

TextStyle1($7FB1D, "DASHING")
TextStyle1($7BCC7, ".2XPOWER AIR")
TextStyle1($7BCD7, "DISTANCE++")

TextStyle1($7FB2C, "HOMING")
TextStyle1($7BD0A, ". ATTRACTION")
TextStyle1($7BD1A, "TO THE HOLE.")

TextStyle1($7FB45, "STRAIGHT")
TextStyle1($7BEFF, ".AS AN ARROW")
TextStyle1($7BF0F, "BALL HIT.")

// End Hole
TextStyle1($7DB7B, "OVERALL")
TextStyle1($7DB8F, "PRIZE")
TextStyle1($7DB9D, "PTS")
TextStyle1($7F67D, "   BOGEY")
TextStyle1($7F686, "DOUBLE BOGEY")
TextStyle1($7F693, "TRIPLE BOGEY")

// Select Screen
TextStyle1($7E3BA, "SCR")
TextStyle1($7E303, "PRIZE")

TextStyle1($78B5E, "THE BATTLE HAS NOW")
TextStyle1($78B74, "STARTED!AIM FOR TOP!")

TextStyle1($7A65D, "THIS IS THE START OF")
TextStyle1($7A675, "THE ROUND.GOOD LUCK!")