
;======================================
; level 1 loading
;======================================
Level1          .proc
                .mwx level1_map.intro,LEVEL_INTRO
                .mwx intro_music,BGM_ADDR
                .mwx level1_map.map,LEVEL_MAP
                .mwx level1_map.attrs,LEVEL_ATTRS

                ldx #$00
                stx ITEMS
                stx DOOR_OPENED

                .mvx #$01,LEVEL_HAS_KEY

                jsr display_game_intro

                rts
                .endproc


;======================================
; level 2 loading
;======================================
Level2          .proc
                .mwx level2_map.intro,LEVEL_INTRO
                .mwx intro_music,BGM_ADDR
                .mwx level2_map.map,LEVEL_MAP
                .mwx level2_map.attrs,LEVEL_ATTRS

                ldx #$00
                stx ITEMS
                stx DOOR_OPENED

                .mvx #$01,LEVEL_HAS_KEY

                jsr display_game_intro

                rts
                .endproc


;======================================
; level 2 loading
;======================================
Level3          .proc
                .mwx level3_map.intro,LEVEL_INTRO
                .mwx intro_music,BGM_ADDR
                .mwx level3_map.map,LEVEL_MAP
                .mwx level3_map.attrs,LEVEL_ATTRS

                ldx #$00
                stx ITEMS
                stx DOOR_OPENED

                ldx #$01
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                lda #<level3_map.maps1_attrs
                sta reset_coin_state._setValue1+1
                lda #>level3_map.maps1_attrs
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                jsr display_game_intro

                rts
                .endproc


;======================================
; level 3 transition loading
;======================================
Level3_main     .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level3_map.map,LEVEL_MAP
                .mwx level3_map.attrs,LEVEL_ATTRS

                .mvx LEVEL_MAP,LEVEL_TRANS_MAP
                .mvx LEVEL_MAP+1,LEVEL_TRANS_MAP+1

                ldx #$01
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                rts
                .endproc


;======================================
; level 3 south 1 transition loading
;======================================
Level3_maps1    .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level3_map.maps1,LEVEL_MAP
                .mwx level3_map.maps1_attrs,LEVEL_ATTRS

                .mvx LEVEL_MAP,LEVEL_TRANS_MAP
                .mvx LEVEL_MAP+1,LEVEL_TRANS_MAP+1

                ldx #$00
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                rts
                .endproc


;======================================
; level 4 loading
;======================================
Level4          .proc
                .mwx level4_map.intro,LEVEL_INTRO
                .mwx intro_music,BGM_ADDR
                .mwx level4_map.map,LEVEL_MAP
                .mwx level4_map.attrs,LEVEL_ATTRS

                .mvx #$00,ITEMS
                .mvx #$00,LEVEL_HAS_KEY

                jsr display_game_intro

                rts
                .endproc


;======================================
; level 5 loading
;======================================
Level5          .proc
                .mwx level5_map.intro,LEVEL_INTRO
                .mwx intro_music,BGM_ADDR
                .mwx level5_map.map,LEVEL_MAP
                .mwx level5_map.attrs,LEVEL_ATTRS

                ldx #$00
                stx ITEMS
                stx DOOR_OPENED

                ldx #$00
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                lda #<$7649
                sta reset_coin_state._setValue1+1
                lda #>$7649
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                lda #<$7759
                sta reset_coin_state._setValue1+1
                lda #>$7759
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                lda #<$789A
                sta reset_coin_state._setValue1+1
                lda #>$789A
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                lda #<$79D0
                sta reset_coin_state._setValue1+1
                lda #>$79D0
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                lda #<$7BD8
                sta reset_coin_state._setValue1+1
                lda #>$7BD8
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                jsr display_game_intro

                rts
                .endproc


;======================================
; level 5 transition loading
;======================================
Level5_main     .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level5_map.map,LEVEL_MAP

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                .mwx level5_map.attrs,LEVEL_ATTRS

                ldx #$00
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                rts
                .endproc


;======================================
; level 5 map east 1 loading
;======================================
Level5_mape1    .proc
                ldx #$01
                stx DISABLE_JOYSTICK
                stx LEVEL_HAS_KEY

                .mwx level5_map.mape1,LEVEL_MAP
                .mwx level5_map.mape1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                .mvx #$00,LEVEL_HAS_DOOR

                rts
                .endproc


;======================================
; level 5 map west 1 loading
;======================================
Level5_mapw1    .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level5_map.mapw1,LEVEL_MAP
                .mwx level5_map.mapw1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                ldx #$00
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                rts
                .endproc


;======================================
; level map 5 north 1 loading
;======================================
Level5_mapn1    .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level5_map.mapn1,LEVEL_MAP
                .mwx level5_map.mapn1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                ldx #$00
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                rts
                .endproc


;======================================
; level 5 map south 1 loading
;======================================
Level5_maps1    .proc
                ldx #$01
                stx DISABLE_JOYSTICK
                stx LEVEL_HAS_DOOR

                .mwx level5_map.maps1,LEVEL_MAP
                .mwx level5_map.maps1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                .mvx #$00,LEVEL_HAS_KEY

                rts
                .endproc


;======================================
; level map 5 south 1 west 1 loading
;======================================
level5_maps1w1  .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level5_map.maps1w1,LEVEL_MAP
                .mwx level5_map.maps1w1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                ldx #$00
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                rts
                .endproc


;======================================
; level 6 loading
;======================================
Level6          .proc
                .mwx level6_map.intro,LEVEL_INTRO
                .mwx intro_music,BGM_ADDR
                .mwx level6_map.map,LEVEL_MAP
                .mwx level6_map.attrs,LEVEL_ATTRS

                ldx #$00
                stx ITEMS
                stx DOOR_OPENED

                ldx #$01
                stx LEVEL_HAS_KEY
                stx LEVEL_HAS_DOOR

                lda #<level6_map.attrs
                sta reset_coin_state._setValue1+1
                lda #>level6_map.attrs
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                lda #<level6_map.mapn1_attrs
                sta reset_coin_state._setValue1+1
                lda #>level6_map.mapn1_attrs
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                lda #<level6_map.maps1_attrs
                sta reset_coin_state._setValue1+1
                lda #>level6_map.maps1_attrs
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                lda #<level6_map.maps1e1_attrs
                sta reset_coin_state._setValue1+1
                lda #>level6_map.maps1e1_attrs
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                lda #<level6_map.maps1w1_attrs
                sta reset_coin_state._setValue1+1
                lda #>level6_map.maps1w1_attrs
                sta reset_coin_state._setValue2+1
                jsr reset_coin_state

                jsr display_game_intro

                rts
                .endproc


;======================================
; level 6 transition loading
;======================================
Level6_main     .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level6_map.map,LEVEL_MAP
                .mwx level6_map.attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                .mvx #$01,LEVEL_HAS_KEY

                rts
                .endproc


;======================================
; level map 6 north 1 loading
;======================================
Level6_mapn1    .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level6_map.mapn1,LEVEL_MAP
                .mwx level6_map.mapn1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                .mvx #$00,LEVEL_HAS_KEY

                rts
                .endproc


;======================================
; level map 6 south 1 loading
;======================================
Level6_maps1    .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level6_map.maps1,LEVEL_MAP
                .mwx level6_map.maps1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                .mvx #$00,LEVEL_HAS_KEY

                rts
                .endproc


;======================================
; level map 6 south 1 west 1 loading
;======================================
Level6_maps1w1  .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level6_map.maps1w1,LEVEL_MAP
                .mwx level6_map.maps1w1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                .mvx #$00,LEVEL_HAS_KEY

                rts
                .endproc


;======================================
; level map 6 south 1 east 1 loading
;======================================
Level6_maps1e1  .proc
                .mvx #$01,DISABLE_JOYSTICK

                .mwx level6_map.maps1e1,LEVEL_MAP
                .mwx level6_map.maps1e1_attrs,LEVEL_ATTRS

                ldx LEVEL_MAP
                stx LEVEL_TRANS_MAP
                ldx LEVEL_MAP+1
                stx LEVEL_TRANS_MAP+1

                .mvx #$00,LEVEL_HAS_KEY

                rts
                .endproc


;======================================
; congratulations level loading
;======================================
congratulations .proc
                .mwx congrats_map.intro,LEVEL_INTRO
                .mwx wingame_music,BGM_ADDR

                .mvx #$00,LEVEL_MAP

                .mvx #$00,ITEMS
                .mvx #$00,LEVEL_HAS_KEY

                ldx WIN_COUNT
                cpx #$04
                bne _1

                jmp _2

_1              inc WIN_COUNT

_2              ldx ENEMY_SPEED_RES
                cpx #$00
                bne _3

                jmp _4

_3              dec ENEMY_SPEED_RES

_4              jsr display_game_intro

                rts
                .endproc


;======================================
; exit level
;======================================
exit_level      .proc
                lda #$00
                sta peek_position._setDX+1
                lda #$00
                sta peek_position._setDY+1

                jsr peek_position
                jsr tile_is_exit

                cmp #$01
                beq _1

                lda #$07
                sta peek_position._setDX+1
                lda #$01
                sta peek_position._setDY+1

                jsr peek_position
                jsr tile_is_exit

                cmp #$01
                beq _1

                lda #$07
                sta peek_position._setDX+1
                lda #$07
                sta peek_position._setDY+1

                jsr peek_position
                jsr tile_is_exit

                cmp #$01
                beq _1

                lda #$00
                sta peek_position._setDX+1
                lda #$07
                sta peek_position._setDY+1

                jsr peek_position
                jsr tile_is_exit

                cmp #$01
                beq _1

                jmp _XIT

_1              jsr play_exit_level_sound
                jsr L24D8
                jmp (NEXT_LEVEL)

_XIT            rts
                .endproc


;======================================
; resets current coin state for a map
;======================================
reset_coin_state .proc
_setValue1      .mvx #$00,TMP0

_setValue2      .mvx #$00,TMP1

                ldy #$00
                iny                     ; count
                lda (TMP0),Y
                iny

                tax
                lda #$FF
_next1          sta (TMP0),Y

                iny
                dex
                bne _next1

                rts
                .endproc
