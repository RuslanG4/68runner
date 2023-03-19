*-----------------------------------------------------------
* Title      : Endless Runner FLAPPY BIRD
* Written by : RUSLAN GAVRILOV
* Date       : 25/02/2023
* Description: Endless Runner Project 
*-----------------------------------------------------------

    ORG    $1000
START:                  ; first instruction of program

*-----------------------------------------------------------
* Section       : Trap Codes
* Description   : Trap Codes used throughout StarterKit
*-----------------------------------------------------------
* Trap CODES
TC_SCREEN   EQU         33          ; Screen size information trap code
TC_S_SIZE   EQU         00          ; Places 0 in D1.L to retrieve Screen width and height in D1.L
                                    ; First 16 bit Word is screen Width and Second 16 bits is screen Height
TC_KEYCODE  EQU         19          ; Check for pressed keys
TC_DBL_BUF  EQU         92          ; Double Buffer Screen Trap Code
TC_CURSR_P  EQU         11          ; Trap code cursor position

TC_EXIT     EQU         09          ; Exit Trapcode

*-----------------------------------------------------------
* Section       : Charater Setup
* Description   : Size of Player and Enemy and properties
* of these characters e.g Starting Positions and Sizes
*-----------------------------------------------------------
PLYR_W_INIT EQU         12          ; Players initial Width
PLYR_H_INIT EQU         12          ; Players initial Height

PLYR_DFLT_V EQU         00          ; Default Player Velocity
PLYR_JUMP_V EQU        -10          ; Player Jump Velocity
PLYR_DFLT_G EQU         01          ; Player Default Gravity

ENMY_W_INIT EQU         640        ; Enemy initial Width
ENMY_H_INIT EQU         08          ; Enemy initial Height

WALL_W_INIT EQU         30
WALL_H_INIT EQU         100

WALL_MOVE_SPEED EQU     03



*-----------------------------------------------------------
* Section       : Game Stats
* Description   : Points
*-----------------------------------------------------------
POINTS      EQU         01          ; Points added

*-----------------------------------------------------------
* Section       : Keyboard Keys
* Description   : Spacebar and Escape or two functioning keys
* Spacebar to JUMP and Escape to Exit Game
*-----------------------------------------------------------
SPACEBAR    EQU         $20         ; Spacebar ASCII Keycode
ESCAPE      EQU         $1B         ; Escape ASCII Keycode

RIGHT       EQU        $44       ;
LEFT      EQU        $41       ;
UP       EQU        $57       ;
DOWN     EQU        $53       ;

*-----------------------------------------------------------
* Subroutine    : Initialise
* Description   : Initialise game data into memory such as 
* sounds and screen size
*-----------------------------------------------------------



INITIALISE:
;----------------------------------------------------------------------------
;----------------------|SCORE|---------------------------------------------
;---------------------------------------------------------------------------
    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    MOVE.L  #00,        D1          ; Init Score
    MOVE.L  D1,         PLAYER_SCORE

    CLR.L D1
    MOVE.B #WALL_MOVE_SPEED,D1
    MOVE.L D1,WALL_SPEED

;----------------------------------------------------------------------------
;----------------------|PLAYER|---------------------------------------------
;---------------------------------------------------------------------------
    ; Initialise Player Velocity
    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    MOVE.B  #PLYR_DFLT_V,D1         ; Init Player Velocity
    MOVE.L  D1,         PLYR_VELOCITY

    ; Initialise Player Gravity
    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    MOVE.L  #PLYR_DFLT_G,D1         ; Init Player Gravity
    MOVE.L  D1,         PLYR_GRAVITY

    ; PLAYER X
    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    MOVE.L #40,D1
    MOVE.L D1, PLAYER_X
    MOVE.L  PLAYER_X,   D1          ; X
    
        ; PLAYER Y
    CLR.L   D2  
    MOVE.L #102,D2
    MOVE.L D2, PLAYER_Y
    MOVE.L  PLAYER_Y,   D2          ; Y
;----------------------------------------------------------------------------
;----------------------|BOTTOM PLATFORM|---------------------------------------------
;---------------------------------------------------------------------------
    
        ; PLAT_1 X
     CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #0,D1
     MOVE.L D1, PLAT_1_X
     MOVE.L  PLAT_1_X,   D1          ; X
     

         ; PLAT_1 X
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #452,D2
     MOVE.L D2, PLAT_1_Y
     MOVE.L  PLAT_1_Y,   D2          ; Y
;----------------------------------------------------------------------------
;----------------------|TOP PLATFORM|---------------------------------------------
;---------------------------------------------------------------------------

          ; PLAT_2 X
     CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #0,D1
     MOVE.L D1, PLAT_2_X
     MOVE.L  PLAT_2_X,   D1          ; X
     

         ; PLAT_2 X
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #52,D2
     MOVE.L D2, PLAT_2_Y
     MOVE.L  PLAT_2_Y,   D2          ; Y
;----------------------------------------------------------------------------
;----------------------|WALL 1|---------------------------------------------
;---------------------------------------------------------------------------

    ; WALL_1 X
     CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #600,D1                  ; X POS
     MOVE.L D1, WALL_1_X            ;MOVE INTO WALL X
     MOVE.L  WALL_1_X,   D1          ; X
     

    ; WALL_1 Y
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #325,D2
     MOVE.L D2, WALL_1_Y
     MOVE.L  WALL_1_Y,   D2          ; Y

      ; WALL_1_UP X
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #600,D2
     MOVE.L D2, WALL_1_UP_X
     MOVE.L  WALL_1_UP_X,   D2          ; Y

      ; WALL_1_UP Y
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #65,D2
     MOVE.L D2, WALL_1_UP_Y
     MOVE.L  WALL_1_UP_Y,   D2          ; Y
;----------------------------------------------------------------------------
;----------------------|WALL 2|---------------------------------------------
;---------------------------------------------------------------------------
      ; WALL_2 X
     CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #350,D1
     MOVE.L D1, WALL_2_X
     MOVE.L  WALL_2_X,   D1          ; X
     

    ; WALL_2 Y
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #250,D2
     MOVE.L D2, WALL_2_Y
     MOVE.L  WALL_2_Y,   D2          ; Y

      ; WALL_2_UP X
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #350,D2
     MOVE.L D2, WALL_2_UP_X
     MOVE.L  WALL_2_UP_X,   D2          ; Y

      ; WALL_2_UP Y
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #65,D2
     MOVE.L D2, WALL_2_UP_Y
     MOVE.L  WALL_2_UP_Y,   D2          ; Y

;----------------------------------------------------------------------------
;----------------------|WALL 3|---------------------------------------------
;---------------------------------------------------------------------------
        ; WALL_3 X
     CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #850,D1
     MOVE.L D1, WALL_3_X
     MOVE.L  WALL_3_X,   D1          ; X
     
    ; WALL_3 Y
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #375,D2
     MOVE.L D2, WALL_3_Y
     MOVE.L  WALL_3_Y,   D2          ; Y

      ; WALL_3_UP X
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #850,D2
     MOVE.L D2, WALL_3_UP_X
     MOVE.L  WALL_3_UP_X,   D2          ; Y

      ; WALL_3_UP Y
     CLR.L   D2                      ; Clear contents of D1 (XOR is faster)
     MOVE.L #65,D2
     MOVE.L D2, WALL_3_UP_Y
     MOVE.L  WALL_3_UP_Y,   D2          ; Y


;----------------------------------------------------------------------------
;----------------------|SCREEN BUFFERS|---------------------------------------------
;---------------------------------------------------------------------------
      ; Enable the screen back buffer(see easy 68k help)
	MOVE.B  #TC_DBL_BUF,D0          ; 92 Enables Double Buffer
    MOVE.B  #17,        D1          ; Combine Tasks
	TRAP	#15                     ; Trap (Perform action)

    ; Clear the screen (see easy 68k help)
    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
	MOVE.W  #$FF00,     D1          ; Fill Screen Clear
	TRAP	#15                     ; Trap (Perform action)

;----------------------------------------------------------------------------
;----------------------|MAIN GAME LOOP|---------------------------------------------
;---------------------------------------------------------------------------
GAMELOOP:

    MOVE.B #8,D0
    TRAP #15
    MOVE.L D1,DELTA_TIME

    ;MOVE.L D1,-(sp)
    ; Main Gameloop
    ;BSR     TIME
    BSR     INPUT                   ; Check Keyboard Input
    BSR     DRAW                    ; Draw the Scene 
    BSR     UPDATE_SCORE            ;UPDATES PLAYER SCORE
    BSR     UPDATE                  ;UPDATES PLAYER WITH VELOCITY
    BSR     CHECK_GROUND            ;CHECKS IF PLAYER HITS THE GROUND
    BSR     CHECK_SKY               ;CHECKS IF PLAYER HITS THE TOP PLATFORM

    BSR     MOVE_WALL_1             ;MOVES FIRST SET OF WALLS
    BSR     MOVE_WALL_2             ;MOVES SECOND SET OF WALLS
    BSR     MOVE_WALL_3             ;MOVES THIRD SET OF WALLS

    

   
  
 ;----------------------------------------------------------------------------
;----------------------|SETS A DELTA TIME FOR UPDATES|---------------------------------------------
;---------------------------------------------------------------------------

TIME:
   MOVE.B #8,D0
   TRAP #15
   SUB.L DELTA_TIME,D1

   CMP.L #4,D1
   BMI.S TIME ;IF RESULT IS NEGATIVE
   BRA GAMELOOP
;----------------------------------------------------------------------------
;----------------------|CHECKS PLAYER INPUT|---------------------------------------------
;---------------------------------------------------------------------------
INPUT:
    
    CLR.L D1
    CLR.L D2
    
    MOVE.B #TC_KEYCODE, D0
    MOVE.L #$414420,D1
    TRAP #15
    CMP.L #$FF0000,D1
    ;BEQ MOVELEFT               ;FUNCTION TO MOVE REMOVED
    CMP.L #$00FF00,D1
    ;BEQ MOVERIGHT             ;FUNCTION TO MOVE REMOVED
    CMP.L #$0000FF,D1
    BEQ JUMP

    RTS
;----------------------------------------------------------------------------
;----------------------|UPDATES SCORE|---------------------------------------------
;---------------------------------------------------------------------------
UPDATE_SCORE:
    ADD.L   #01,     PLAYER_SCORE
    RTS

;-----------------------------------------------------------------------------------------------------------------
;----------------------|UPDATES PLAYER IN ACCORDANCE YO VELOCITY AND GRAITY|---------------------------------------------
;----------------------------------------------------------------------------------------------------------------------
UPDATE:
    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    MOVE.L  PLYR_VELOCITY, D1       ; Fetch Player Velocity
    MOVE.L  PLYR_GRAVITY, D2        ; Fetch Player Gravity
    ADD.L   D2,         D1          ; Add Gravity to Velocity
    MOVE.L  D1,         PLYR_VELOCITY ; Update Player Velocity
    ADD.L   PLAYER_Y,   D1          ; Add Velocity to Player
    MOVE.L  D1,         PLAYER_Y    ; Update Players Y Position 

 

    RTS
;----------------------------------------------------------------------------
;----------------------|MOVES WALL 1|---------------------------------------------
;---------------------------------------------------------------------------
MOVE_WALL_1:
    CLR.L D1
    MOVE.L WALL_SPEED,D1
    SUB.L   D1,     WALL_1_X    
    SUB.L   D1,     WALL_1_UP_X      
    CLR.L D1
    MOVE.L WALL_1_X , D1
    CLR.L D2
    SUB.L #40, D2
    CMP.L   D2,     D1
    BLT RESET_WALL_1_POSITION 
    BSR     CHECK_COLLISIONS        ;CHECKS COLL
    BSR     CHECK_UP_COLLISIONS
    BSR     CHECK_COLLISIONS_2
    BSR     CHECK_UP_COLLISIONS_2
    BSR     CHECK_COLLISIONS_3
    BSR     CHECK_UP_COLLISIONS_3
    RTS
 
;----------------------------------------------------------------------------
;----------------------|RESETS WALL 1 POS|---------------------------------------------
;---------------------------------------------------------------------------
RESET_WALL_1_POSITION:
    CLR.L D2                      ; Clear contents of D1 (XOR is faster)
    CLR.L D3
    MOVE.L #700,D2
    MOVE.L #700,D3
    MOVE.L D2, WALL_1_X 
    MOVE.L  WALL_1_X ,   D2          ; Y
    MOVE.L D3, WALL_1_UP_X 
    MOVE.L  WALL_1_UP_X ,   D3          ; Y
    RTS
;----------------------------------------------------------------------------
;----------------------|MOVES WALL 2|---------------------------------------------
;---------------------------------------------------------------------------
MOVE_WALL_2:
    CLR.L D1
    MOVE.L WALL_SPEED,D1
    SUB.L   D1,     WALL_2_X    
    SUB.L   D1,     WALL_2_UP_X        
    CLR.L D1
    MOVE.L WALL_2_X , D1
    CLR.L D2
    SUB.L #40, D2
    CMP.L   D2,     D1
    BLT RESET_WALL_2_POSITION 
    BSR     CHECK_COLLISIONS        ;CHECKS COLL
    BSR     CHECK_UP_COLLISIONS
    BSR     CHECK_COLLISIONS_2
    BSR     CHECK_UP_COLLISIONS_2
    BSR     CHECK_COLLISIONS_3
    BSR     CHECK_UP_COLLISIONS_3
    RTS
 
;----------------------------------------------------------------------------
;----------------------|RESETS WALL 2 POS|---------------------------------------------
;---------------------------------------------------------------------------
RESET_WALL_2_POSITION:
    CLR.L D2                      ; Clear contents of D1 (XOR is faster)
    CLR.L D3
    MOVE.L #700,D2
    MOVE.L #700,D3
    MOVE.L D2, WALL_2_X 
    MOVE.L  WALL_2_X ,   D2          ; Y
    MOVE.L D3, WALL_2_UP_X 
    MOVE.L  WALL_2_UP_X ,   D3          ; Y
    RTS    
;----------------------------------------------------------------------------
;----------------------|MOVES WALL 3|---------------------------------------------
;---------------------------------------------------------------------------
MOVE_WALL_3:
    CLR.L D1
    MOVE.L WALL_SPEED,D1
    SUB.L   D1,     WALL_3_X    
    SUB.L   D1,     WALL_3_UP_X       
    CLR.L D1
    MOVE.L WALL_3_X , D1
    CLR.L D2
    SUB.L #40, D2
    CMP.L   D2,     D1
    BLT RESET_WALL_3_POSITION 
    BSR     CHECK_COLLISIONS        ;CHECKS COLL
    BSR     CHECK_UP_COLLISIONS
    BSR     CHECK_COLLISIONS_2
    BSR     CHECK_UP_COLLISIONS_2
    BSR     CHECK_COLLISIONS_3
    BSR     CHECK_UP_COLLISIONS_3
    RTS
 
;----------------------------------------------------------------------------
;----------------------|RESETTS WALL 3 POS|---------------------------------------------
;---------------------------------------------------------------------------
RESET_WALL_3_POSITION:
    CLR.L D2                      ; Clear contents of D1 (XOR is faster)
    CLR.L D3
    MOVE.L #700,D2
    MOVE.L #700,D3
    MOVE.L D2, WALL_3_X 
    MOVE.L  WALL_3_X ,   D2          ; Y
    MOVE.L D3, WALL_3_UP_X 
    MOVE.L  WALL_3_UP_X ,   D3          ; Y
    BSR  INCREASE_SPEED
    RTS  
;----------------------------------------------------------------------------
;----------------------|INCREASES GAME SPEED|---------------------------------------------
;---------------------------------------------------------------------------
INCREASE_SPEED:
    CLR.L D1
    MOVE.L WALL_SPEED  ,D1
    ADD.L #01,D1
    MOVE.L D1,WALL_SPEED  
    RTS     
;----------------------------------------------------------------------------
;----------------------|PLAYER JUMP|---------------------------------------------
;--------------------------------------------------------------------------- 
JUMP:
    MOVE.L  #PLYR_JUMP_V,PLYR_VELOCITY

;----------------------------------------------------------------------------
;----------------------|CHECKS IF PLAYER HITS THE GROUND|---------------------------------------------
;---------------------------------------------------------------------------
CHECK_GROUND:
    CLR.L D1
    MOVE.L PLAYER_Y , D1
    MOVE.L #500,D2
    CMP.L   D2,      D1
    BGE DIE 
    RTS
 ;----------------------------------------------------------------------------
;----------------------|CHECKS IF PLAYER HITS CEILING|---------------------------------------------
;---------------------------------------------------------------------------   
CHECK_SKY:
    CLR.L D1
    MOVE.L PLAYER_Y , D1
    MOVE.L #50,D2
    CMP.L   D2,      D1
    BLE DIE 
    RTS
;----------------------------------------------------------------------------
;----------------------|END GAME |---------------------------------------------
;---------------------------------------------------------------------------
DIE:
    BRA INITIALISE

;----------------------------------------------------------------------------
;----------------------|DRAWS GAME|---------------------------------------------
;---------------------------------------------------------------------------
DRAW: 
    ; Enable back buffer
    MOVE.B  #94,        D0
    TRAP    #15

    ; Clear the screen
    MOVE.B	#TC_CURSR_P,D0          ; Set Cursor Position
	MOVE.W	#$FF00,     D1          ; Clear contents
	TRAP    #15                     ; Trap (Perform action)

    BSR     DRAW_PLYR_DATA          ; Draw Draw Score, HUD, Player X and Y
    BSR     DRAW_PLAYER             ; Draw Player
    BSR     DRAW_PLAT_1             ; bottom platform
    BSR     DRAW_PLAT_2              ;draw top platform
    BSR     DRAW_WALL_1             ;draw bottom pipe
    BSR     DRAW_WALL_1_UP          ;draw top pipe
    BSR     DRAW_WALL_2             ;DRAW BOTTOM WALL 2
    BSR     DRAW_WALL_2_UP          ;DRAW TOP WALL OF 2
    BSR     DRAW_WALL_3             ;BOTTOM OF WALL 3
    BSR     DRAW_WALL_3_UP          ;TOP OF WALL 3

   
    RTS                             ; Return to subroutine

;-----------------------------------------------------------------------------------
;----------------------|DRAWS PLAYER DATA|---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_PLYR_DATA:
    CLR.L D1
     
    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
    MOVE.W  #$0201,     D1          ; Col 02, Row 01
    TRAP    #15                     ; Trap (Perform action)
    LEA     SCORE_MSG,  A1          ; Score Message
    MOVE    #13,        D0          ; No Line feed
    TRAP    #15                     ; Trap (Perform action)

    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
    MOVE.W  #$0901,     D1          ; Col 09, Row 01
    TRAP    #15                     ; Trap (Perform action)
    MOVE.B  #03,        D0          ; Display number at D1.L
    MOVE.L  PLAYER_SCORE,D1         ; Move Score to D1.L
    TRAP    #15                     ; Trap (Perform action)
    RTS
;-----------------------------------------------------------------------------------
;----------------------|DRAWS PLAYER |---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_PLAYER:
    ; Set Pixel Colors
    MOVE.L  #WHITE,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)

    ; Set X, Y, Width and Height

    MOVE.L  PLAYER_X,   D1          ; X

    MOVE.L  PLAYER_Y,   D2          ; Y
    
    MOVE.L  PLAYER_X,   D3
    ADD.L   #PLYR_W_INIT,   D3      ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #PLYR_H_INIT,   D4      ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    RTS                             ; Return to subroutine

        


;-----------------------------------------------------------------------------------
;----------------------|DRAWS PLATFORM 1|---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_PLAT_1:
 ; Set Pixel Colors
    MOVE.L  #RED,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
    
    MOVE.L  PLAT_1_X,   D1          ; X

    MOVE.L  PLAT_1_Y,   D2          ; Y
    
    MOVE.L  PLAT_1_X,   D3
    ADD.L   #ENMY_W_INIT,   D3      ; Width
    MOVE.L  PLAT_1_Y,   D4 
    ADD.L   #ENMY_H_INIT,   D4      ; Height
    
    ; Draw plat 1
    MOVE.B  #87,        D0          ; Draw  plat 1
    TRAP    #15                     ; Trap (Perform action)
    RTS  

;-----------------------------------------------------------------------------------
;----------------------|DRAWS PLATFORM 2|---------------------------------------------
;------------------------------------------------------------------------------------     
DRAW_PLAT_2:
 ; Set Pixel Colors
    MOVE.L  #RED,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
    
    MOVE.L  PLAT_2_X,   D1          ; X

    MOVE.L  PLAT_2_Y,   D2          ; Y
    
    MOVE.L  PLAT_2_X,   D3
    ADD.L   #ENMY_W_INIT,   D3      ; Width
    MOVE.L  PLAT_2_Y,   D4 
    ADD.L   #ENMY_H_INIT,   D4      ; Height
    
    ; Draw  plat 1
    MOVE.B  #87,        D0          ; Draw  plat 1
    TRAP    #15                     ; Trap (Perform action)
    RTS 

;-----------------------------------------------------------------------------------
;----------------------|DRAWS BOTTOM WALL 1|---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_WALL_1:
; Set Pixel Colors
    MOVE.L  #YELLOW,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
    
    MOVE.L  WALL_1_X,   D1          ; X

    MOVE.L  WALL_1_Y,   D2          ; Y
    
    MOVE.L WALL_1_X,   D3
    ADD.L   #WALL_W_INIT,   D3      ; Width
    MOVE.L  WALL_1_Y,   D4 
    ADD.L   #125,   D4      ; Height
    
    ; Draw ENEMY
    MOVE.B  #87,        D0          ; Draw wall
    TRAP    #15                     ; Trap (Perform action)
    RTS                ; Return from the function with the random number in d0
;-----------------------------------------------------------------------------------
;----------------------|DRAWS TOP WALL 1|---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_WALL_1_UP:
; Set Pixel Colors
    MOVE.L  #YELLOW,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
    
    MOVE.L  WALL_1_UP_X,   D1          ; X

    MOVE.L  WALL_1_UP_Y,   D2          ; Y
    
    MOVE.L WALL_1_UP_X,   D3
    ADD.L   #WALL_W_INIT,   D3      ; Width
    MOVE.L  WALL_1_UP_Y,   D4 
    ADD.L   #125,   D4      ; Height
    
    ; Draw ENEMY
    MOVE.B  #87,        D0          ; Draw wall
    TRAP    #15                     ; Trap (Perform action)
    RTS                ; Return from the function with the random number in d0
;-----------------------------------------------------------------------------------
;----------------------|DRAWS BOTTOM WALL 2|---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_WALL_2:
    MOVE.L  #YELLOW,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
    
    MOVE.L  WALL_2_X,   D1          ; X

    MOVE.L  WALL_2_Y,   D2          ; Y
    
    MOVE.L WALL_2_X,   D3
    ADD.L   #WALL_W_INIT,   D3      ; Width
    MOVE.L  WALL_2_Y,   D4 
    ADD.L   #200,   D4      ; Height
    
    ; Draw ENEMY
    MOVE.B  #87,        D0          ; Draw wall
    TRAP    #15                     ; Trap (Perform action)
    RTS                ; Return from the function with the random number in d0
;-----------------------------------------------------------------------------------
;----------------------|DRAWS TOP WALL 2|---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_WALL_2_UP:
     MOVE.L  #YELLOW,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
    
    MOVE.L  WALL_2_UP_X,   D1          ; X

    MOVE.L  WALL_2_UP_Y,   D2          ; Y
    
    MOVE.L WALL_2_UP_X,   D3
    ADD.L   #WALL_W_INIT,   D3      ; Width
    MOVE.L  WALL_2_UP_Y,   D4 
    ADD.L   #WALL_H_INIT,   D4      ; Height
    
    ; Draw ENEMY
    MOVE.B  #87,        D0          ; Draw wall
    TRAP    #15                     ; Trap (Perform action)
    RTS                ; Return from the function with the random number in d0
;-----------------------------------------------------------------------------------
;----------------------|DRAWS BOTTOM WALL 3|---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_WALL_3:
    MOVE.L  #YELLOW,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
    
    MOVE.L  WALL_3_X,   D1          ; X

    MOVE.L  WALL_3_Y,   D2          ; Y
    
    MOVE.L WALL_3_X,   D3
    ADD.L   #WALL_W_INIT,   D3      ; Width
    MOVE.L  WALL_3_Y,   D4 
    ADD.L   #75,   D4      ; Height
    
    ; Draw ENEMY
    MOVE.B  #87,        D0          ; Draw wall
    TRAP    #15                     ; Trap (Perform action)
    RTS                ; Return from the function with the random number in d0
;-----------------------------------------------------------------------------------
;----------------------|DRAWS TOP WALL 3|---------------------------------------------
;------------------------------------------------------------------------------------
DRAW_WALL_3_UP:
     MOVE.L  #YELLOW,     D1          ; Set Background color
    MOVE.B  #80,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
    
    MOVE.L  WALL_3_UP_X,   D1          ; X

    MOVE.L  WALL_3_UP_Y,   D2          ; Y
    
    MOVE.L WALL_3_UP_X,   D3
    ADD.L   #WALL_W_INIT,   D3      ; Width
    MOVE.L  WALL_3_UP_Y,   D4 
    ADD.L   #200,   D4      ; Height
    
    ; Draw ENEMY
    MOVE.B  #87,        D0          ; Draw wall
    TRAP    #15                     ; Trap (Perform action)
    RTS                ; Return from the function with the random number in d0

    

;------------------------------------------------------------------------------------------------------
;----------------------|CEHCKS COLLISION WITH BOTTOM WALL 1|---------------------------------------------
;----------------------------------------------------------------------------------------------------
CHECK_COLLISIONS:
    ; Check collision for a single coin
    ; PLAYER_X <= COIN_X + COIN_W &&
    ; PLAYER_X + PLAYER_W >= COIN_X &&
    ; PLAYER_Y <= COIN_Y + COIN_H &&
    ; PLAYER_H + PLAYER_Y >= COIN_Y
    MOVE.L  PLAYER_X, D1          ; Move player X to D1
    MOVE.L  WALL_1_X,    D2          ; Move Enemy X to D2
    ADD.L   WALL_W_INIT,D2          ; Set Enemy width X + Width
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BLE     X_GREATER  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
X_GREATER:
    MOVE.L  PLAYER_X,   D1          ; Move Player X to D1
    ADD.L   PLYR_W_INIT,D1          ; Move Player Width to D1
    MOVE.L  WALL_1_X,   D2          ; Move Enemy X to D2
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BGE     Y_LESS  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_LESS:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    MOVE.L  WALL_1_Y,    D2         ; Move Enemy Y to D2
    ADD.L   #WALL_H_INIT,D2          ; Set Enemy Height to D2
    CMP.L   D2, D2                ; Check if there's overlap on Y axis
    BLE     Y_GREATER  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_GREATER:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    ADD.L   PLYR_H_INIT,D1          ; Add Player Height to D1
    MOVE.L  WALL_1_Y,    D2         ; Move Enemy Height to D2  
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BGE     COLLISION  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
;------------------------------------------------------------------------------------------------------
;----------------------|CEHCKS COLLISION WITH TOP WALL 1|---------------------------------------------
;----------------------------------------------------------------------------------------------------
CHECK_UP_COLLISIONS:
    MOVE.L  PLAYER_X, D1          ; Move player X to D1
    MOVE.L  WALL_1_UP_X,    D2          ; Move Enemy X to D2
    ADD.L   WALL_W_INIT,D2          ; Set Enemy width X + Width
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BLE     X_GREATER_Y  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
X_GREATER_Y:
    MOVE.L  PLAYER_X,   D1          ; Move Player X to D1
    ADD.L   PLYR_W_INIT,D1          ; Move Player Width to D1
    MOVE.L  WALL_1_UP_X,   D2          ; Move Enemy X to D2
    CMP.L   D2, D1                ; Check if there's overlap on X axis
    BGE     Y_LESS_Y  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_LESS_Y:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    MOVE.L  WALL_1_UP_Y,    D2         ; Move Enemy Y to D2
    ADD.L   #90,D2          ; Set Enemy Height to D2
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BLE     Y_GREATER_Y  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_GREATER_Y:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    ADD.L   PLYR_H_INIT,D1          ; Add Player Height to D1
    MOVE.L  WALL_1_UP_Y,    D2         ; Move Enemy Height to D2  
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BGE     COLLISION  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE

;------------------------------------------------------------------------------------------------------
;----------------------|CEHCKS COLLISION WITH BOTTOM WALL 2|---------------------------------------------
;----------------------------------------------------------------------------------------------------
CHECK_COLLISIONS_2:
    ; Check collision for a single coin
    ; PLAYER_X <= COIN_X + COIN_W &&
    ; PLAYER_X + PLAYER_W >= COIN_X &&
    ; PLAYER_Y <= COIN_Y + COIN_H &&
    ; PLAYER_H + PLAYER_Y >= COIN_Y
    MOVE.L  PLAYER_X, D1          ; Move player X to D1
    MOVE.L  WALL_2_X,    D2          ; Move Enemy X to D2
    ADD.L   WALL_W_INIT,D2          ; Set Enemy width X + Width
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BLE     X_GREATER_2  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
X_GREATER_2:
    MOVE.L  PLAYER_X,   D1          ; Move Player X to D1
    ADD.L   PLYR_W_INIT,D1          ; Move Player Width to D1
    MOVE.L  WALL_2_X,   D2          ; Move Enemy X to D2
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BGE     Y_LESS_2  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_LESS_2:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    MOVE.L  WALL_2_Y,    D2         ; Move Enemy Y to D2
    ADD.L   #200,D2          ; Set Enemy Height to D2
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BLE     Y_GREATER_2  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_GREATER_2:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    ADD.L   PLYR_H_INIT,D1          ; Add Player Height to D1
    MOVE.L  WALL_2_Y,    D2         ; Move Enemy Height to D2  
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BGE     COLLISION  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE

;------------------------------------------------------------------------------------------------------
;----------------------|CEHCKS COLLISION WITH TOP WALL 2|---------------------------------------------
;----------------------------------------------------------------------------------------------------
CHECK_UP_COLLISIONS_2:
    MOVE.L  PLAYER_X, D1          ; Move player X to D1
    MOVE.L  WALL_2_UP_X,    D2          ; Move Enemy X to D2
    ADD.L   WALL_W_INIT,D2          ; Set Enemy width X + Width
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BLE     X_GREATER_Y_2  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
X_GREATER_Y_2:
    MOVE.L  PLAYER_X,   D1          ; Move Player X to D1
    ADD.L   PLYR_W_INIT,D1          ; Move Player Width to D1
    MOVE.L  WALL_2_UP_X,   D2          ; Move Enemy X to D2
    CMP.L   D2, D1                ; Check if there's overlap on X axis
    BGE     Y_LESS_Y_2  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_LESS_Y_2:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    MOVE.L  WALL_2_UP_Y,    D2         ; Move Enemy Y to D2
    ADD.L   #80,D2          ; Set Enemy Height to D2
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BLE     Y_GREATER_Y_2  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_GREATER_Y_2:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    ADD.L   PLYR_H_INIT,D1          ; Add Player Height to D1
    MOVE.L  WALL_2_UP_Y,    D2         ; Move Enemy Height to D2  
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BGE     COLLISION  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE

;------------------------------------------------------------------------------------------------------
;----------------------|CEHCKS COLLISION WITH BOTTOM WALL 3|---------------------------------------------
;----------------------------------------------------------------------------------------------------
CHECK_COLLISIONS_3:
    ; Check collision for a single coin
    ; PLAYER_X <= COIN_X + COIN_W &&
    ; PLAYER_X + PLAYER_W >= COIN_X &&
    ; PLAYER_Y <= COIN_Y + COIN_H &&
    ; PLAYER_H + PLAYER_Y >= COIN_Y
    MOVE.L  PLAYER_X, D1          ; Move player X to D1
    MOVE.L  WALL_3_X,    D2          ; Move Enemy X to D2
    ADD.L   WALL_W_INIT,D2          ; Set Enemy width X + Width
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BLE     X_GREATER_3  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
X_GREATER_3:
    MOVE.L  PLAYER_X,   D1          ; Move Player X to D1
    ADD.L   PLYR_W_INIT,D1          ; Move Player Width to D1
    MOVE.L  WALL_3_X,   D2          ; Move Enemy X to D2
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BGE     Y_LESS_3  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_LESS_3:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    MOVE.L  WALL_3_Y,    D2         ; Move Enemy Y to D2
    ADD.L   #75,D2          ; Set Enemy Height to D2
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BLE     Y_GREATER_3  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_GREATER_3:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    ADD.L   PLYR_H_INIT,D1          ; Add Player Height to D1
    MOVE.L  WALL_3_Y,    D2         ; Move Enemy Height to D2  
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BGE     COLLISION  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
;------------------------------------------------------------------------------------------------------
;----------------------|CEHCKS COLLISION WITH TOP WALL 3|---------------------------------------------
;----------------------------------------------------------------------------------------------------
CHECK_UP_COLLISIONS_3:
    MOVE.L  PLAYER_X, D1          ; Move player X to D1
    MOVE.L  WALL_3_UP_X,    D2          ; Move Enemy X to D2
    ADD.L   WALL_W_INIT,D2          ; Set Enemy width X + Width
    CMP.L   D1, D2                ; Check if there's overlap on X axis
    BLE     X_GREATER_Y_3  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
X_GREATER_Y_3:
    MOVE.L  PLAYER_X,   D1          ; Move Player X to D1
    ADD.L   PLYR_W_INIT,D1          ; Move Player Width to D1
    MOVE.L  WALL_3_UP_X,   D2          ; Move Enemy X to D2
    CMP.L   D2, D1                ; Check if there's overlap on X axis
    BGE     Y_LESS_Y_3  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_LESS_Y_3:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    MOVE.L  WALL_3_UP_Y,    D2         ; Move Enemy Y to D2
    ADD.L   #190,D2          ; Set Enemy Height to D2
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BLE     Y_GREATER_Y_3  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE
Y_GREATER_Y_3:
    MOVE.L  PLAYER_Y,   D1          ; Move Player Y to D1
    ADD.L   PLYR_H_INIT,D1          ; Add Player Height to D1
    MOVE.L  WALL_3_UP_Y,    D2         ; Move Enemy Height to D2  
    CMP.L   D2, D1                ; Check if there's overlap on Y axis
    BGE     COLLISION  ; If no overlap, skip to next coin
    BRA     COLLISION_CHECK_DONE    
COLLISION_CHECK_DONE:               ; No Collision Update points
   
    RTS                             ; Return to subroutine

COLLISION:
   BRA INITIALISE







EXIT:
    ; Show if Exiting is Running
    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
    MOVE.W  #$4004,     D1          ; Col 40, Row 1
    TRAP    #15                     ; Trap (Perform action)
    LEA     EXIT_MSG,   A1          ; Exit
    MOVE    #13,        D0          ; No Line feed
    TRAP    #15                     ; Trap (Perform action)
    MOVE.B  #TC_EXIT,   D0          ; Exit Code
    TRAP    #15                     ; Trap (Perform action)
    SIMHALT

*-----------------------------------------------------------
* Section       : Messages
* Description   : Messages to Print on Console, names should be
* self documenting
*-----------------------------------------------------------
SCORE_MSG       DC.B    'METERS : ', 0       ; Score Message
KEYCODE_MSG     DC.B    'KeyCode : ', 0     ; Keycode Message
JUMP_MSG        DC.B    'Jump....', 0       ; Jump Message

IDLE_MSG        DC.B    'Idle....', 0       ; Idle Message
UPDATE_MSG      DC.B    'Update....', 0     ; Update Message
DRAW_MSG        DC.B    'Draw....', 0       ; Draw Message

X_MSG           DC.B    'X:', 0             ; X Position Message
Y_MSG           DC.B    'Y:', 0             ; Y Position Message
V_MSG           DC.B    'V:', 0             ; Velocity Position Message
G_MSG           DC.B    'G:', 0             ; Gravity Position Message
GND_MSG         DC.B    'GND:', 0           ; On Ground Position Message

EXIT_MSG        DC.B    'Exiting....', 0    ; Exit Message

*-----------------------------------------------------------
* Section       : Graphic Colors
* Description   : Screen Pixel Color
*-----------------------------------------------------------
WHITE           EQU     $00FFFFFF
RED             EQU     $000000FF
YELLOW          EQU     $0000FFFF
PINK            EQU     $00FF00FF
GREEN           EQU     $0000FF00


*--------------------------------------------------------------
* elapsed time 
*
*--------------------------------------------
ELAPSED_TIME    DS.L    01
DELTA_TIME      DS.L    01

*-----------------------------------------------------------
* Section       : Screen Size
* Description   : Screen Width and Height
*-----------------------------------------------------------
SCREEN_W        DS.W    01  ; Reserve Space for Screen Width
SCREEN_H        DS.W    01  ; Reserve Space for Screen Height

*-----------------------------------------------------------
* Section       : Keyboard Input
* Description   : Used for storing Keypresses
*-----------------------------------------------------------
CURRENT_KEY     DS.L    01  ; Reserve Space for Current Key Pressed

*-----------------------------------------------------------
* Section       : Character Positions
* Description   : Player and Enemy Position Memory Locations
*-----------------------------------------------------------
PLAYER_X        DS.L    01  ; Reserve Space for Player X Position
PLAYER_Y        DS.L    01  ; Reserve Space for Player Y Position
PLAYER_SCORE    DS.L    01  ; Reserve Space for Player Score
PLAYER_ANGLE    DS.L    01  ;

PLYR_VELOCITY   DS.L    01  ; Reserve Space for Player Velocity
PLYR_GRAVITY    DS.L    01  ; Reserve Space for Player Gravity
PLYR_ON_GND     DS.L    01  ; Reserve Space for Player on Ground
PLYR_Y_VEL      DS.L    01

PLAT_1_X        DS.L 01
PLAT_1_Y        DS.L 01

PLAT_2_X        DS.L 01
PLAT_2_Y        DS.L 01

WALL_1_X        DS.L 01
WALL_1_Y        DS.L 01

WALL_1_UP_X     DS.L 01
WALL_1_UP_Y     DS.L 01

WALL_2_X        DS.L 01
WALL_2_Y        DS.L 01

WALL_2_UP_X     DS.L 01
WALL_2_UP_Y     DS.L 01

WALL_3_X        DS.L 01
WALL_3_Y        DS.L 01

WALL_3_UP_X     DS.L 01
WALL_3_UP_Y     DS.L 01

WALL_SPEED      DS.L 01










*-----------------------------------------------------------
* Section       : Sounds
* Description   : Sound files, which are then loaded and given
* an address in memory, they take a longtime to process and play
* so keep the files small. Used https://voicemaker.in/ to 
* generate and Audacity to convert MP3 to WAV
*-----------------------------------------------------------
JUMP_WAV        DC.B    'jump.wav',0        ; Jump Sound
RUN_WAV         DC.B    'run.wav',0         ; Run Sound
OPPS_WAV        DC.B    'opps.wav',0        ; Collision Opps


    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
