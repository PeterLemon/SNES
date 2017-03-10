// SNES "Super Mario Kart" 1500cc Hack by krom (Peter Lemon):
// Special thanks to Dirtbag for the SMK Mashup tool, for helping me get started

arch snes.cpu
output "Super Mario Kart 1500cc.sfc", create
origin $000000; insert "Super Mario Kart (U) [!].sfc" // Include USA Super Mario Kart SNES ROM
origin $00FFC0
db "SUPER MARIO KART 1500" // $00FFC0 - PROGRAM TITLE (21 Byte ASCII String, Use Spaces For Unused Bytes)

//-----------------
// Kart Properties
//-----------------

origin $018000

KartTopSpeed:
         // ROM       Kart Top Speed
dw 84<<4 // $018000 - Mario    (FP12.4) (57.0: $0390)
dw 84<<4 // $018002 - Luigi    (FP12.4) (57.0: $0390)
dw 86<<4 // $018004 - Bowser   (FP12.4) (59.0: $03B0)
dw 82<<4 // $018006 - Princess (FP12.4) (55.0: $0370)
dw 86<<4 // $018008 - D.K.Jr   (FP12.4) (59.0: $03B0)
dw 81<<4 // $01800A - Koopa    (FP12.4) (54.0: $0360)
dw 81<<4 // $01800C - Toad     (FP12.4) (54.0: $0360)
dw 82<<4 // $01800E - Yoshi    (FP12.4) (55.0: $0370)

KartAccelerationSpeed:
         // ROM       Kart Acceleration Speed
dw $8020 // $018010 - Mario    (????) ($8020)
dw $8020 // $018012 - Luigi    (????) ($8020)
dw $8050 // $018014 - Bowser   (????) ($8050)
dw $8030 // $018016 - Princess (????) ($8030)
dw $8050 // $018018 - D.K.Jr   (????) ($8050)
dw $8040 // $01801A - Koopa    (????) ($8040)
dw $8040 // $01801C - Toad     (????) ($8040)
dw $8030 // $01801E - Yoshi    (????) ($8030)

KartAccelerationCurve:
                                                               // ROM       Kart Acceleration Curve
db 128,192,160,255,255,255,255,255,255,192,192, 96,96,32,32,24 // $018020 - Mario/Luigi    (UINT8) (32, 96, 64,128,192,192,192,128,128, 64, 32, 24,16,8,4,4)
db 160,255,255,255,255,255,255,255,255,160,160,128,32,24,16,16 // $018030 - Princess/Yoshi (UINT8) (64,192,255,255,192,192,192,128,128, 64, 64, 32, 8,4,2,2)
db 160,160,192,255,255,255,255,255,255,160,160, 96,96,32,24,32 // $018040 - Koopa/Toad     (UINT8) (64, 64, 96,128,128,192,192,128,128, 64, 32, 24,16,8,4,8)
db 128,128,128,128,160,160,192,192,255,255,255,255,64,64,32,32 // $018050 - Bowser/D.K.Jr  (UINT8) (32, 32, 32, 32, 64, 64, 96, 96,128,128,160,160,16,8,8,8)

KartUnknown01:
         // ROM       Kart *Unknown*
dw $8070 // $018060 - Mario    (????) ($8070)
dw $8070 // $018062 - Luigi    (????) ($8070)
dw $8076 // $018064 - Bowser   (????) ($8076)
dw $807C // $018066 - Princess (????) ($807C)
dw $8076 // $018068 - D.K.Jr   (????) ($8076)
dw $8082 // $01806A - Koopa    (????) ($8082)
dw $8082 // $01806C - Toad     (????) ($8082)
dw $807C // $01806E - Yoshi    (????) ($807C)

KartOffRoadSpeed:
                     // ROM       Kart Off Road Speed (Dirt, Mud, Snow, Grass, Water, Mud Pool)
db 37,18,34,36,36,41 // $018070 - Mario/Luigi    (UINT8) (37,18,34,36,36,41)
db 38,20,33,35,39,42 // $018076 - Bowser/D.K.Jr  (UINT8) (38,20,33,35,39,42)
db 39,19,31,38,38,43 // $01807C - Princess/Yoshi (UINT8) (39,19,31,38,38,43)
db 40,21,32,37,37,44 // $018082 - Koopa/Toad     (UINT8) (40,21,32,37,37,44)

KartTurnInertia:
         // ROM       Kart Turn Inertia
dw $8098 // $018088 - Mario    (????) ($8098)
dw $8098 // $01808A - Luigi    (????) ($8098)
dw $80C5 // $01808C - Bowser   (????) ($80C5)
dw $80A7 // $01808E - Princess (????) ($80A7)
dw $80C5 // $018090 - D.K.Jr   (????) ($80C5)
dw $80B6 // $018092 - Koopa    (????) ($80B6)
dw $80B6 // $018094 - Toad     (????) ($80B6)
dw $80A7 // $018096 - Yoshi    (????) ($80A7)

KartHandlingNormalMarioLuigi:
        // ROM       Kart Handling Normal Mario/Luigi
dw 2653 // $018098 - Turn Rate (UINT16) (2453: $0995)
db  152 // $01809A - Control   (UINT8)  ( 152: $98)
db  104 // $01809B - Turning   (UINT8)  ( 104: $68)
db  112 // $01809C - Grip      (UINT8)  ( 112: $70)
KartHandlingUnknownMarioLuigi:
        // ROM       Kart Handling Unknown Mario/Luigi
dw 2888 // $01809D - Turn Rate (UINT16) (2688: $0A80)
db  160 // $01809F - Control   (UINT8)  ( 160: $A0)
db  120 // $0180A0 - Turning   (UINT8)  ( 120: $78)
db  128 // $0180A1 - Grip      (UINT8)  ( 128: $80)
KartHandlingSlidingMarioLuigi:
        // ROM       Kart Handling Sliding Mario/Luigi
dw 3016 // $0180A2 - Turn Rate (UINT16) (2816: $0B00)
db  176 // $0180A4 - Control   (UINT8)  ( 176: $B0)
db  136 // $0180A5 - Turning   (UINT8)  ( 136: $88)
db  144 // $0180A6 - Grip      (UINT8)  ( 144: $90)

KartHandlingNormalPrincessYoshi:
        // ROM       Kart Handling Normal Princess/Yoshi
dw 2653 // $0180A7 - Turn Rate (UINT16) (2453: $0995)
db  152 // $0180A9 - Control   (UINT8)  ( 152: $98)
db   88 // $0180AA - Turning   (UINT8)  (  88: $58)
db  128 // $0180AB - Grip      (UINT8)  ( 128: $80)
KartHandlingUnknownPrincessYoshi:
        // ROM       Kart Handling Unknown Princess/Yoshi
dw 2888 // $0180AC - Turn Rate (UINT16) (2688: $0A80)
db  160 // $0180AE - Control   (UINT8)  ( 160: $A0)
db  104 // $0180AF - Turning   (UINT8)  ( 104: $68)
db  112 // $0180B0 - Grip      (UINT8)  ( 112: $70)
KartHandlingSlidingPrincessYoshi:
        // ROM       Kart Handling Sliding Princess/Yoshi
dw 3016 // $0180B1 - Turn Rate (UINT16) (2816: $0B00)
db  176 // $0180B3 - Control   (UINT8)  ( 176: $B0)
db  112 // $0180B4 - Turning   (UINT8)  ( 112: $70)
db  128 // $0180B5 - Grip      (UINT8)  ( 128: $80)

KartHandlingNormalKoopaToad:
        // ROM       Kart Handling Normal Koopa/Toad
dw 2604 // $0180B6 - Turn Rate (UINT16) (2304: $0900)
db  160 // $0180B8 - Control   (UINT8)  ( 160: $A0)
db  112 // $0180B9 - Turning   (UINT8)  ( 112: $70)
db  144 // $0180BA - Grip      (UINT8)  ( 144: $90)
KartHandlingUnknownKoopaToad:
        // ROM       Kart Handling Unknown Koopa/Toad
dw 2824 // $0180BB - Turn Rate (UINT16) (2624: $0A40)
db  176 // $0180BD - Control   (UINT8)  ( 176: $B0)
db  128 // $0180BE - Turning   (UINT8)  ( 128: $80)
db  160 // $0180BF - Grip      (UINT8)  ( 160: $A0)
KartHandlingSlidingKoopaToad:
        // ROM       Kart Handling Sliding Koopa/Toad
dw 2952 // $0180C0 - Turn Rate (UINT16) (2752: $0AC0)
db  160 // $0180C2 - Control   (UINT8)  ( 160: $A0)
db  144 // $0180C3 - Turning   (UINT8)  ( 144: $90)
db  192 // $0180C4 - Grip      (UINT8)  ( 192: $C0)

KartHandlingNormalBowserDKJr:
        // ROM       Kart Handling Normal Bowser/D.K.Jr
dw 2504 // $0180C5 - Turn Rate (UINT16) (2304: $0900)
db  128 // $0180C7 - Control   (UINT8)  ( 128: $80)
db   88 // $0180C8 - Turning   (UINT8)  (  88: $58)
db  136 // $0180C9 - Grip      (UINT8)  ( 136: $88)
KartHandlingUnknownBowserDKJr:
        // ROM       Kart Handling Unknown Bowser/D.K.Jr
dw 2824 // $0180CA - Turn Rate (UINT16) (2624: $0A40)
db  144 // $0180CC - Control   (UINT8)  ( 144: $90)
db  104 // $0180CD - Turning   (UINT8)  ( 104: $68)
db  152 // $0180CE - Grip      (UINT8)  ( 152: $98)
KartHandlingSlidingBowserDKJr:
        // ROM       Kart Handling Sliding Bowser/D.K.Jr
dw 2952 // $0180CF - Turn Rate (UINT16) (2752: $0AC0)
db  160 // $0180D1 - Control   (UINT8)  ( 160: $A0)
db  120 // $0180D2 - Turning   (UINT8)  ( 120: $78)
db  168 // $0180D3 - Grip      (UINT8)  ( 168: $A8)