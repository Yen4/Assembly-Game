DrawingModeSet MACRO
               mov AH,0
               mov AL,12h
               int 10h
               endm

BackGroundSet MACRO
              mov AH,0Bh
              mov BH,0
              mov BL,0  ;color black
              int 10h
              endm

GetKeyShowOff MACRO
              mov AH,06h
              mov DL,0FFh
              int 21h
              endm

GetKeyShowON MACRO
             mov AH,01h
             int 21h
             endm

WritePixelGreen MACRO row,line
                mov AH,0Ch
                mov BH,0
                mov AL,10  ;color light green
                mov DX,row
                mov CX,line
                int 10h
                endm

WritePixelBlack MACRO row,line
                mov AH,0Ch
                mov BH,0
                mov AL,0  ;color black
                mov DX,row
                mov CX,line
                int 10h
                endm

GetTime MACRO
        mov AH,2Ch
        int 21h
        endm

.model small
.data

ballax dw 2
ballay dw 2
ballx dw 180
bally dw 240
location1 dw 220
location2 dw 220
direction1 db 0
direction2 db 0
ball db 1
time db ?

.code
.startup

DrawingModeSet
BackGroundSet
mov DX,120
CALL SetLine
mov DX,119
CALL SetLine
mov DX,360
CALL SetLine
mov DX,361
CALL SetLine
mov CX,160
CALL SetRow
mov CX,159
CALL SetRow
mov CX,480
CALL SetRow
mov CX,481
CALL SetRow


mov DX,location1
mov CX,470
call SetStick
mov DX,location2
mov CX,170
call SetStick


GetTime
mov DH,0
ADD DX,DX
ADD DX,140
mov bally,DX

;--------------------------------------------

again:
GetKeyShowOff
CMP AL,'w'
JE direct1
CMP AL,'s'
JE direct1
CMP AL,'q'
JE direct2
CMP AL,'a'
JE direct2
CMP AL,27
JE over
timer:
GetTime
CMP DL,time
JE again
mov time,DL
CMP direction1,0
JE here1
CMP direction1,'w'
JE up1
JNE down1
here1:
CMP direction2,0
JE here2
CMP direction2,'q'
JE up2
JNE down2
here2:



CMP bally,122
JE wallup
abc1:
CMP bally,358
JE walldown
abc2:
;-------------------------------------------

CMP ballx,170
JE touchleft
abc3:
CMP ballx,470
JAE touchright
abc4:

;CMP ballx,476
;JA over
;CMP ballx,164
;JB over

mov CX,ballx
mov DX,bally
call ClearBall
ADD CX,ballax
ADD DX,ballay
mov ballx,CX
mov bally,DX
call SetBall

JMP again

touchleft:
mov AX,bally
CMP location2,AX
JA over
SUB AX,40
CMP location2,AX
JB over
NOT ballax
INC ballax
INC ballax
JMP abc4

touchright:
mov AX,bally
CMP location1,AX
JA over
SUB AX,40
CMP location1,AX
JB over
NOT ballax
INC ballax
JMP abc4

wallup:
NOT ballay
INC ballay
JMP abc1

walldown:
NOT ballay
INC ballay
JMP abc2

direct1:
mov direction1,AL
JMP timer
direct2:
mov direction2,AL
JMP timer

up1:
CMP location1,122
JBE here1
mov CX,470
mov DX,location1
call ClearStick
DEC location1
DEC location1
mov DX,location1
call SetStick
JMP here1

down1:
CMP location1,320
JAE here1
mov CX,470
mov DX,location1
call ClearStick
INC location1
INC location1
mov DX,location1
call SetStick
JMP here1

up2:
CMP location2,122
JBE here2
mov CX,170
mov DX,location2
call ClearStick
DEC location2
DEC location2
mov DX,location2
call SetStick
JMP here2

down2:
CMP location2,320
JAE here2
mov CX,170
mov DX,location2
call ClearStick
INC location2
INC location2
mov DX,location2
call SetStick
JMP here2


over:
.exit

SetLine PROC NEAR
        mov AH,0Ch
        mov BH,0
        mov AL,10  ;color light green
        mov CX,158
        abc:
        INC CX
        int 10h
        CMP CX,481
        jne abc
        RET
SetLine endp

SetRow PROC NEAR
       mov AH,0Ch
       mov BH,0
       mov AL,10  ;color light green
       mov DX,119
       abc:
       INC DX
       int 10h
       CMP DX,360
       jne abc
       RET
SetRow endp

SetStick PROC NEAR
         mov AH,0Ch
         mov BH,0
         mov AL,10
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         RET
SetStick endp

ClearStick PROC NEAR
         mov AH,0Ch
         mov BH,0
         mov AL,0
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         INC DX
         int 10h
         RET
ClearStick endp

SetBall PROC NEAR
        mov AH,0Ch
        mov BH,0
        mov AL,10
        int 10h
        INC DX
        int 10h
        SUB DX,2
        int 10h
        INC DX
        INC CX
        int 10h
        SUB CX,2
        int 10h
        RET
SetBall endp

ClearBall PROC NEAR
        mov AH,0Ch
        mov BH,0
        mov AL,0
        int 10h
        INC DX
        int 10h
        SUB DX,2
        int 10h
        INC DX
        INC CX
        int 10h
        SUB CX,2
        int 10h
        RET
ClearBall endp

end