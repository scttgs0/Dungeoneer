
;======================================
; sets up the initial screen removing
; garble display
;======================================
init_screen     .proc
                lda #$00                ; value
                ldy #$FF                ; count

                ldx #$00
                stx DINDEX
                stx SAVMSC

_next1          dey
                sta (SAVMSC),Y
                bne _next1

                rts

                .endproc


;======================================
; setup colors
;======================================
setup_colors    .proc
; 	character set colors
                .mvx #$06,COLOR0
                .mvx #$0A,COLOR1
                .mvx #$24,COLOR2
                .mvx #$C4,COLOR3
                .mvx #$00,COLOR4

; 	player-PMG+$180 colors
                .mvx #$80,PCOLR0
                .mvx #$F2,PCOLR1
                .mvx #$3C,PCOLR2

                rts
                .endproc


;======================================
; changes tile colors
;======================================
bump_colors     lda COLOR0
                clc
                adc #$01
                sta COLOR0

                lda COLOR1
                clc
                adc #$01
                sta COLOR1

                lda COLOR3
                clc
                adc #$01
                sta COLOR3

                lda COLOR4
                clc
                adc #$01
                sta COLOR4

                rts


;======================================
; clear player pmg
;======================================
clear_player_pmg
                ldx #$80
                lda #$00

_next1          dex
                sta PMG+$200,X
                sta PMG+$280,X
                sta PMG+$300,X
                bne _next1

                rts


;======================================
; clear enemy pmg
;======================================
clear_enemy_pmg ldx #$80
                lda #$00

_next1          dex
                sta PMG+$180,X
                bne _next1

                rts


;======================================
; clears the current screen
;======================================
L24D8           lda #$00
                ldy #$F0

_next1          dey
                sta GAME_SCREEN,Y
                sta GAME_SCREEN+$F0,Y
                bne _next1

                rts


;======================================
; clear enemy vertical repaint
;======================================
clear_enemy_vertical
;   clear top and bottom enemy row
                lda ENEMY_POSY
                tay
                dey
                clc
                adc #$08

                tax
                lda #$00
                sta PMG+$180,X
                sta PMG+$180,Y

                rts


;======================================
; clear player vertical repaint
;======================================
clear_player_vertical
;   clear top and bottom player row
                lda POSY
                tay
                dey
                clc
                adc #$08

                tax
                lda #$00
                sta PMG+$200,X
                sta PMG+$280,X
                sta PMG+$300,X

                sta PMG+$200,Y
                sta PMG+$280,Y
                sta PMG+$300,Y

                rts


;======================================
; draw player
;======================================
draw_player     ldx PLAYANIM_OFFSET
                txa
                clc
                adc #$08
                sta _limit

                ldy POSY
_next1          lda player_data,X
                sta PMG+$200,Y
                lda player_data+8,X
                sta PMG+$280,Y
                lda player_data+16,X
                sta PMG+$300,Y

                iny
                inx
                txa
                cmp _limit
                bne _next1

                rts

;--------------------------------------

_limit          .byte $00


;======================================
; setup pmg
;======================================
setup_pmg       .mvx #$44,PMBASE

                .mvx #$2E,SDMCTL        ; double line resolution
                .mvx #$03,GRACTL        ; enable PMG
                .mvx #$11,GPRIOR        ; give players priority
                .mvx #$00,SIZEM

                rts


;======================================
; animate player right
;======================================
animate_player_right
                jmp _check

_reset          .mvx #$00,PLAYANIM_OFFSET
                jsr draw_player

_check          lda #$00
                sta between._setLow+1

                lda PLAYANIM_OFFSET
                sta between._setValue+1

                lda #$30
                sta between._setHigh+1

                jsr between

                cmp #$01
                bne _reset

                lda PLAYER_SPRITE
                clc
                adc #$01
                sta PLAYER_SPRITE

                cmp #$05
                bne _XIT

                .mvx #$00,PLAYER_SPRITE

                jsr draw_player

                lda PLAYANIM_OFFSET
                clc
                adc #$18
                sta PLAYANIM_OFFSET

                cmp #$30
                bne _XIT

                .mvx #$00,PLAYANIM_OFFSET

_XIT            rts


;======================================
; animate player left
;======================================
animate_player_left
                jmp _check

_reset          .mvx #$30,PLAYANIM_OFFSET
                jsr draw_player

_check          lda #$30
                sta between._setLow+1

                lda PLAYANIM_OFFSET
                sta between._setValue+1

                lda #$60
                sta between._setHigh+1

                jsr between

                cmp #$01
                bne _reset

                lda PLAYER_SPRITE
                clc
                adc #$01
                sta PLAYER_SPRITE

                cmp #$05
                bne _XIT

                .mvx #$00,PLAYER_SPRITE

                jsr draw_player

                lda PLAYANIM_OFFSET
                clc
                adc #$18
                sta PLAYANIM_OFFSET

                cmp #$60
                bne _XIT

                .mvx #$30,PLAYANIM_OFFSET

_XIT            rts


;======================================
; resets the player back to the first
; animation frame
;======================================
animate_player_reset
                .mvx #$00,PLAYER_SPRITE

                lda #$00
                sta between._setLow+1

                lda PLAYANIM_OFFSET
                sta between._setValue+1

                lda #$30
                sta between._setHigh+1

                jsr between

                cmp #$01
                bne _left

                .mvx #$00,PLAYANIM_OFFSET

                jmp _draw

_left           .mvx #$30,PLAYANIM_OFFSET

_draw           jsr draw_player

                rts


;======================================
; displays the main menu screen
;======================================
display_mainmenu
                jsr stop_background_music

                .mwx mainmenu_music,BGM_ADDR

                .mvx #$01,AUDCTL

                jsr play_background_music
                jsr setup_pmg
                jsr setup_mainmenu_screen
                jsr setup_menu_tileset
                jsr display_mainmenu_map

                .mvx #$03,GRACTL

                ldx #$00
                stx DISPLAY_TYPE
                stx MENU_SELECTION
                stx PLAYANIM_OFFSET

                .mvx #$FF,PREV_MENU_SELECT

                rts


;======================================
; displays the how to play screen
;======================================
display_howtoplay
                jsr stop_background_music
                jsr setup_pmg
                jsr setup_menu_screen
                jsr setup_menu_tileset
                jsr display_howtoplay_map

                ldx #$03
                stx GRACTL
                stx MENU_SELECTION

                ldx #$00
                stx DISPLAY_TYPE
                stx PLAYANIM_OFFSET

                rts


;======================================
; displays the credits screen
;======================================
display_credits jsr stop_background_music
                jsr setup_pmg
                jsr setup_menu_screen
                jsr setup_menu_tileset
                jsr display_credits_map

                ldx #$03
                stx GRACTL
                stx MENU_SELECTION

                ldx #$00
                stx DISPLAY_TYPE
                stx PLAYANIM_OFFSET

                rts


;======================================
; displays the game intro screen
;======================================
display_game_intro
                jsr stop_background_music

                .mvx #$00,AUDCTL

                jsr play_background_music
                jsr setup_menu_screen
                jsr setup_menu_tileset
                jsr display_game_intro_map

                .mvx #$01,DISPLAY_TYPE
                .mvx #$32,INTRO_POSITION
                .mvx #$30,POSY

                jsr clear_player_pmg

                rts


;======================================
; sets up game reset
;======================================
new_game        ldx #$00
                stx PLAYER_SCORE
                stx PLAYER_SCORE+1
                stx ITEMS
                stx WIN_COUNT
                stx LIFE_GAIN

                .mvx #$03,PLAYER_LIVES
                .mvx #$04,ENEMY_SPEED_RES

                jsr clear_win_count
                jsr Level1

                rts


;======================================
; displays the game screen
;======================================
display_game    jsr stop_background_music

                .mvx #$00,AUDCTL

                .mwx background_music,BGM_ADDR
                jsr play_background_music

                jsr setup_game_screen
                jsr setup_tileset
                jsr setup_pmg

                jsr display_screen_items
                jsr display_win_count
                jsr display_player_score
                jsr display_player_lives

                jsr enable_tilesprite_animation

                jsr display_game_map

                jsr reset_player
                jsr reset_enemy
                jsr draw_player

                jsr store_tilex
                jsr store_tiley

                .mvx #$02,DISPLAY_TYPE

                rts


;======================================
; displays the game over screen
;======================================
display_gameover
                jsr setup_colors
                jsr clear_player_pmg
                jsr setup_menu_screen
                jsr setup_menu_tileset

                jsr enable_tilesprite_animation

                jsr display_gameover_map

                jsr stop_background_music
                jsr play_gameover_sound

                .mvx #$03,DISPLAY_TYPE

                rts


;======================================
; selection / animation of main menu
;======================================
render_mainmenu ldx DISPLAY_TYPE
                cpx #$00
                bne _XIT1

                ldx SCREEN_LOADED
                cpx #$01
                bne _XIT1

                lda #$AE
                sta restore_menu_item._setValue1+1
                lda #$40
                sta restore_menu_item._setValue2+1

                jsr restore_menu_item

                lda #$FE
                sta restore_menu_item._setValue1+1
                lda #$40
                sta restore_menu_item._setValue2+1

                jsr restore_menu_item

                lda #$4E
                sta restore_menu_item._setValue1+1
                lda #$41
                sta restore_menu_item._setValue2+1

                jsr restore_menu_item

                ldx MENU_SELECTION
                cpx #$00
                beq selection_newgame

                cpx #$01
                beq selection_howtoplay

                cpx #$02
                beq selection_credits

                cpx #$03
                beq selection_mainmenu

                jmp _done

_done           .mvx #$5A,POSX

                ldx POSX
                stx HPOSP0
                stx HPOSP1
                stx HPOSP2
                stx HPOSP3

                jsr clear_player_pmg
                jsr draw_player

_XIT1           rts


;--------------------------------------
;
;--------------------------------------
selection_newgame
                lda #$AE
                sta highlight_menu_item._setValue1+1
                lda #$40
                sta highlight_menu_item._setValue2+1

                jsr highlight_menu_item

                .mvx #$30,POSY

                jmp render_mainmenu._done


;--------------------------------------
;
;--------------------------------------
selection_howtoplay
                lda #$FE
                sta highlight_menu_item._setValue1+1
                lda #$40
                sta highlight_menu_item._setValue2+1

                jsr highlight_menu_item

                .mvx #$40,POSY

                jmp render_mainmenu._done


;--------------------------------------
;
;--------------------------------------
selection_credits
                lda #$4E
                sta highlight_menu_item._setValue1+1
                lda #$41
                sta highlight_menu_item._setValue2+1

                jsr highlight_menu_item

                .mvx #$50,POSY

                jmp render_mainmenu._done


;--------------------------------------
;
;--------------------------------------
selection_mainmenu
                .mvx #$68,POSY

                jmp render_mainmenu._done


;======================================
; render intro
;======================================
render_intro    ldx DISPLAY_TYPE
                cpx #$01
                bne _XIT

                ldx SCREEN_LOADED
                cpx #$01
                bne _XIT

                ldx INTRO_POSITION
                stx POSX
                stx HPOSP0
                stx HPOSP1
                stx HPOSP2
                stx HPOSP3

                inc INTRO_POSITION

                jsr clear_player_pmg
                jsr draw_player
                jsr animate_player_right

                ldx INTRO_POSITION
                cpx #$C8
                bne _XIT

                .mvx #$00,INTRO_POSITION

                ldx LEVEL_MAP
                cpx #$00
                bne _start_game

                jsr bump_colors
                jsr Level1

                jmp _XIT

_start_game     jsr display_game

_XIT            rts


;======================================
; render gameover
;======================================
render_gameover ldx DISPLAY_TYPE
                cpx #$03
                bne _XIT

                inc GAMEOVER_POSITION
                ldx GAMEOVER_POSITION
                cpx #$FF
                bne _XIT

                .mvx #$00,GAMEOVER_POSITION

                jsr display_mainmenu

_XIT            rts


;======================================
; render player death
;======================================
render_player_death
                ldx PLAYER_DEATH
                cpx #$01
                bne _XIT

                jmp _check

_reset          .mvx #$60,PLAYANIM_OFFSET

                jsr draw_player

_check          lda #$60
                sta between._setLow+1

                lda PLAYANIM_OFFSET
                sta between._setValue+1

                lda #$C0
                sta between._setHigh+1
                jsr between

                cmp #$01
                bne _reset

                lda PLAYER_SPRITE
                clc
                adc #$01
                sta PLAYER_SPRITE

                cmp #$1E
                bne _XIT

                .mvx #$00,PLAYER_SPRITE
                jsr draw_player

                lda PLAYANIM_OFFSET
                clc
                adc #$18
                sta PLAYANIM_OFFSET

                cmp #$C0
                bne _XIT

;   complete player death
                jsr check_game_over
                jsr reset_player
                jsr clear_player_pmg

                .mvx #$00,PLAYER_DEATH

                .mvx #$01,RESTORE_COIN

_XIT            rts


;======================================
; highlight a menu item
;======================================
highlight_menu_item
_setValue1      .mvx #$00,TMP0

_setValue2      .mvx #$00,TMP1

                ldy #$00
_next1          lda (TMP0),Y
                cmp #$80
                bcc _lessthan

                jmp _1

_lessthan       lda (TMP0),Y
                clc
                adc #$80
                sta (TMP0),Y

_1              iny
                cpy #$16
                bne _next1

                rts


;======================================
; restore menu item
;======================================
restore_menu_item
_setValue1      .mvx #$00,TMP0

_setValue2      .mvx #$00,TMP1

                ldy #$00
_next1          lda (TMP0),Y
                cmp #$80
                bcs _greaterthan

                jmp _1

_greaterthan    lda (TMP0),Y
                sec
                sbc #$80
                sta (TMP0),Y

_1              iny
                cpy #$16
                bne _next1

                rts
