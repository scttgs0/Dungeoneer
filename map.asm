
;======================================
; display main menu map
;======================================
display_mainmenu_map .proc
                jsr enable_tilesprite_animation

                .mvx #$00,SCREEN_LOADED

                .mva #$33,render_map._setMapLO+1
                .mva #$6A,render_map._setMapHI+1
                .mva #$00,render_map._setScreenLO+1
                .mva #$40,render_map._setScreenHI+1
                jsr render_map

                .mvx #$01,SCREEN_LOADED

                rts
                .endproc


;======================================
; display how to play map
;======================================
display_howtoplay_map .proc
                jsr enable_tilesprite_animation

                .mvx #$00,SCREEN_LOADED

                .mva #$90,render_map._setMapLO+1
                .mva #$6A,render_map._setMapHI+1
                .mva #$00,render_map._setScreenLO+1
                .mva #$40,render_map._setScreenHI+1
                jsr render_map

                .mvx #$01,SCREEN_LOADED

                rts
                .endproc


;======================================
; display credits map
;======================================
display_credits_map .proc
                jsr enable_tilesprite_animation

                .mvx #$00,SCREEN_LOADED

                .mva #$3E,render_map._setMapLO+1
                .mva #$6B,render_map._setMapHI+1
                .mva #$00,render_map._setScreenLO+1
                .mva #$40,render_map._setScreenHI+1
                jsr render_map

                .mvx #$01,SCREEN_LOADED

                rts
                .endproc


;======================================
; display game intro map
;======================================
display_game_intro_map .proc
                lda #$14
                ;!!sta GPRIOR

                .mvx #$00,SCREEN_LOADED

                .mva LEVEL_INTRO,render_map._setMapLO+1
                .mva LEVEL_INTRO+1,render_map._setMapHI+1
                .mva #$00,render_map._setScreenLO+1
                .mva #$40,render_map._setScreenHI+1
                jsr render_map

                .mvx #$01,SCREEN_LOADED

                rts
                .endproc


;======================================
; display game map
;======================================
display_game_map .proc
                .mvx #$00,SCREEN_LOADED

                .mva LEVEL_MAP,render_map._setMapLO+1
                .mva LEVEL_MAP+1,render_map._setMapHI+1
                .mva #$00,render_map._setScreenLO+1
                .mva #$40,render_map._setScreenHI+1
                jsr render_map

                .mva LEVEL_ATTRS,load_map_attributes._setAttrLO+1
                .mva LEVEL_ATTRS+1,load_map_attributes._setAttrHI+1
                jsr load_map_attributes

                .mvx #$01,SCREEN_LOADED

                rts
                .endproc


;======================================
; display game over map
;======================================
display_gameover_map .proc
                .mvx #$00,SCREEN_LOADED

                .mva #$E5,render_map._setMapLO+1
                .mva #$69,render_map._setMapHI+1
                .mva #$00,render_map._setScreenLO+1
                .mva #$40,render_map._setScreenHI+1
                jsr render_map

                .mvx #$01,SCREEN_LOADED

                rts
                .endproc


;======================================
; render map
;--------------------------------------
; renders map data to destination
; screen using RLE if available
;======================================
render_map      .proc
_setMapLO       .mvx #$00,TMP0
_setMapHI       .mvx #$00,TMP1
_setScreenLO    .mvx #$00,TMP2
_setScreenHI    .mvx #$00,TMP3

                ldx #$00
                stx rle_count
                stx rle_count+1

                ldy #$00
L355D           lda (TMP0),Y
                jsr decode_rle

                cpx #$01
                bne L3569

                jmp L3599

L3569           jsr decode_rle_2

                cpx #$01
                bne L3573

                jmp L3599

L3573           sta (TMP2),Y
                clc
                lda rle_count
                adc #$01
                sta rle_count
                bcc L3583

                inc rle_count+1
L3583           clc
                lda TMP0
                adc #$01
                sta TMP0
                bcc L358E

                inc TMP1
L358E           clc
                lda TMP2
                adc #$01
                sta TMP2
                bcc L3599

                inc TMP3
L3599           lda rle_count+1
                cmp #$01
                bne L35A5

                lda rle_count
                cmp #$E0
L35A5           bne L355D

                rts
                .endproc


;======================================
; decode rle 1 byte
;--------------------------------------
; uses acc as type byte
;======================================
decode_rle      .proc
                jmp L35AE

L35AB           ldx #$00
                rts

L35AE           cmp #$FF
                bne L35AB

                clc
                lda TMP0
                adc #$01
                sta TMP0
                bcc L35BD

                inc TMP1
L35BD           lda (TMP0),Y
                tax
                clc
                lda TMP0
                adc #$01
                sta TMP0
                bcc L35CB

                inc TMP1
L35CB           lda (TMP0),Y
                dex
L35CE           sta (TMP2),Y
                tay
                clc
                lda TMP2
                adc #$01
                sta TMP2
                bcc L35DC

                inc TMP3
L35DC           clc
                lda rle_count
                adc #$01
                sta rle_count
                bcc L35EA

                inc rle_count+1
L35EA           tya
                ldy #$00
                dex
                bne L35CE

                ldx #$01

                rts
                .endproc


;======================================
; decode rle 2 byte
;--------------------------------------
; uses x as rle length
;======================================
decode_rle_2    .proc
                jmp L35F9

L35F6           ldx #$00
                rts

L35F9           cmp #$FE
                bne L35F6

                clc
                lda TMP0
                adc #$01
                sta TMP0
                bcc L3608

                inc TMP1
L3608           lda (TMP0),Y
                tax
                clc
                lda TMP0
                adc #$01
                sta TMP0
                bcc L3616

                inc TMP1
L3616           lda (TMP0),Y
                sta L3664
                clc
                lda TMP0
                adc #$01
                sta TMP0
                bcc L3626

                inc TMP1
L3626           lda (TMP0),Y
                sta L3665
L362B           lda L3664
                sta (TMP2),Y
                iny
                lda L3665
                sta (TMP2),Y
                ldy #$00
                clc
                lda TMP2
                adc #$02
                sta TMP2
                bcc L3643

                inc TMP3
L3643           clc
                lda rle_count
                adc #$02
                sta rle_count
                bcc L3651

                inc rle_count+1
L3651           dex
                bne L362B

                clc
                lda TMP0
                adc #$01
                sta TMP0
                bcc L365F

                inc TMP1
L365F           ldx #$01

                rts
                .endproc

;--------------------------------------
;--------------------------------------

rle_count       .word $0000
L3664           .byte $00
L3665           .byte $00


;======================================
; load map attributes
;======================================
load_map_attributes .proc
_setAttrLO      .mvx #$00,TMP0
_setAttrHI      .mvx #$00,TMP1

                ldy #$00
_next1          lda (TMP0),Y
                iny
                cmp #$00
                bne _player_pos

                jmp _XIT

_player_pos     cmp #$01
                bne _next_level

                lda LEVEL_TRANS_MAP
                cmp #$00
                bne _trans_attr

                lda (TMP0),Y
                iny
                sta PLAYER_RESET_POSX
                lda (TMP0),Y
                iny
                sta PLAYER_RESET_POSY
                jmp _next1

_trans_attr     iny
                iny
                jmp _next1

_next_level     cmp #$02
                bne _north_trans

                lda (TMP0),Y
                iny
                sta NEXT_LEVEL
                lda (TMP0),Y
                iny
                sta NEXT_LEVEL+1
                jmp _next1

_north_trans    cmp #$03
                bne _east_trans

                lda (TMP0),Y
                iny
                sta LEVEL_TRANS_N
                lda (TMP0),Y
                iny
                sta LEVEL_TRANS_N+1
                jmp _next1

_east_trans     cmp #$04
                bne _south_trans

                lda (TMP0),Y
                iny
                sta LEVEL_TRANS_E
                lda (TMP0),Y
                iny
                sta LEVEL_TRANS_E+1
                jmp _next1

_south_trans    cmp #$05
                bne _west_trans

                lda (TMP0),Y
                iny
                sta LEVEL_TRANS_S
                lda (TMP0),Y
                iny
                sta LEVEL_TRANS_S+1
                jmp _next1

_west_trans     cmp #$06
                bne _coin_state

                lda (TMP0),Y
                iny
                sta LEVEL_TRANS_W
                lda (TMP0),Y
                iny
                sta LEVEL_TRANS_W+1
                jmp _next1

_coin_state     cmp #$07
                bne _key_pos

                lda (TMP0),Y
                iny
_next2          iny
                sec
                sbc #$01
                bne _next2

                jmp _next1

_key_pos        cmp #$08
                bne _enemy_pos

                lda (TMP0),Y
                iny
                sta KEY_POSX
                lda (TMP0),Y
                iny
                sta KEY_POSY
                jmp _next1

_enemy_pos      cmp #$09
                bne _XIT

                lda (TMP0),Y
                iny
                sta ENEMY_POSX
                lda (TMP0),Y
                iny
                sta ENEMY_POSY
                jmp _next1

_XIT            rts
                .endproc


;======================================
; update coin state
;======================================
update_coin_state .proc
_setTileX       ldx #$00
                stx _tilex

_setTileY       ldx #$00
                stx _tiley

; find level in memory location
                ldy #$00

                .mvx LEVEL_ATTRS,TMP0
                .mvx LEVEL_ATTRS+1,TMP1

; store only left most tilex position of item
                lda ONTILE
                and #$01
                cmp #$01
                bne _1

                lda _tilex
                sec
                sbc #$01
                sta _tilex

_1              lda (TMP0),Y
                cmp #$07
                bne _XIT

                iny
                iny

_next1          lda (TMP0),Y
                iny
                cmp #$FF
                bne _next1

                dey
                lda _tilex
                sta (TMP0),Y
                iny
                lda _tiley
                sta (TMP0),Y

_XIT            rts

;--------------------------------------

_tilex          .byte $00
_tiley          .byte $00

                .endproc
