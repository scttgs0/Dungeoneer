
;======================================
; sets up the player transition position
;======================================
setup_player_trans
                jmp _direction

_north          ldx LEVEL_TRANS_X
                stx POSX
                stx PLAYER_RESET_POSX

                .mvx LEVEL_TRANS_TX,TILEX

                lda TILEX
                sta find_tiley._setTileX+1

                lda #$5D
                sta find_tiley._setFindTile+1

                jsr find_tiley

                sec
                sbc #$01
                sta TILEY

                jsr tiley_to_posy

                sta PLAYER_RESET_POSY

                jmp _XIT

_east           ldx LEVEL_TRANS_Y
                stx POSY
                stx PLAYER_RESET_POSY

                .mvx LEVEL_TRANS_TY,TILEY

                lda TILEY
                sta find_tilex._setTileY+1

                lda #$5F
                sta find_tilex._setFindTile+1

                jsr find_tilex

                clc
                adc #$02
                sta TILEX
                jsr tilex_to_posx

                sta PLAYER_RESET_POSX
                jmp _XIT

_direction      ldx LEVEL_TRANS_TYPE
                cpx #$03
                beq _north

                cpx #$04
                beq _east

                cpx #$05
                beq _south

                cpx #$06
                beq _west

                jmp _XIT

_south          ldx LEVEL_TRANS_X
                stx POSX
                stx PLAYER_RESET_POSX

                .mvx LEVEL_TRANS_TX,TILEX

                lda TILEX
                sta find_tiley._setTileX+1

                lda #$5C
                sta find_tiley._setFindTile+1

                jsr find_tiley

                clc
                adc #$01
                sta TILEY

                jsr tiley_to_posy

                sta PLAYER_RESET_POSY

                jmp _XIT

_west           ldx LEVEL_TRANS_Y
                stx POSY
                stx PLAYER_RESET_POSY

                .mvx LEVEL_TRANS_TY,TILEY

                lda TILEY
                sta find_tilex._setTileY+1

                lda #$5E
                sta find_tilex._setFindTile+1

                jsr find_tilex

                sec
                sbc #$02
                sta TILEX

                jsr tilex_to_posx

                sta PLAYER_RESET_POSX

_XIT            rts


;======================================
; checks for transition interactions
;======================================
check_transition
                lda #$07
                sta peek_position._setDX+1
                lda #$04
                sta peek_position._setDY+1

                jsr peek_position
                jsr tile_is_transition_e

                cpx #$01
                beq _trans_e

                lda #$00
                sta peek_position._setDX+1
                lda #$04
                sta peek_position._setDY+1

                jsr peek_position
                jsr tile_is_transition_w

                cpx #$01
                beq _trans_w

                lda #$04
                sta peek_position._setDX+1
                lda #$00
                sta peek_position._setDY+1

                jsr peek_position
                jsr tile_is_transition_n

                cpx #$01
                beq _trans_n

                lda #$04
                sta peek_position._setDX+1
                lda #$07
                sta peek_position._setDY+1

                jsr peek_position
                jsr tile_is_transition_s

                cpx #$01
                beq _trans_s

                jmp _XIT

_trans_n        .mvx POSX,LEVEL_TRANS_X
                .mvx POSY,LEVEL_TRANS_Y

                .mvx TILEX,LEVEL_TRANS_TX
                .mvx TILEY,LEVEL_TRANS_TY

                .mvx #$03,LEVEL_TRANS_TYPE

                jmp (LEVEL_TRANS_N)

_trans_e        .mvx POSX,LEVEL_TRANS_X
                .mvx POSY,LEVEL_TRANS_Y

                .mvx TILEX,LEVEL_TRANS_TX
                .mvx TILEY,LEVEL_TRANS_TY

                .mvx #$04,LEVEL_TRANS_TYPE

                jmp (LEVEL_TRANS_E)

_trans_w        .mvx POSX,LEVEL_TRANS_X
                .mvx POSY,LEVEL_TRANS_Y

                .mvx TILEX,LEVEL_TRANS_TX
                .mvx TILEY,LEVEL_TRANS_TY

                .mvx #$06,LEVEL_TRANS_TYPE

                jmp (LEVEL_TRANS_W)

_trans_s        .mvx POSX,LEVEL_TRANS_X
                .mvx POSY,LEVEL_TRANS_Y

                .mvx TILEX,LEVEL_TRANS_TX
                .mvx TILEY,LEVEL_TRANS_TY

                .mvx #$05,LEVEL_TRANS_TYPE

                jmp (LEVEL_TRANS_S)

_XIT            rts


;======================================
; handles map transition
;======================================
transition_map_handler
                ldx LEVEL_TRANS_MAP
                cpx #$00
                beq _XIT

                .mvx #$01,VBLANK_SKIP

                ldx #$00
                stx ENEMY_POSX
                stx ENEMY_POSY
                stx SCREEN_LOADED

                ;;obsolete jsr clear_enemy_pmg
                jsr display_game_map
                jsr setup_player_trans
                jsr reset_player

                ldx #$01
                stx RESTORE_DOOR
                stx RESTORE_KEY
                stx RESTORE_COIN
                stx SCREEN_LOADED

                ldx #$00
                stx LEVEL_TRANS_MAP
                stx DISABLE_JOYSTICK

_XIT            rts


;======================================
; restore key state
;--------------------------------------
; restore key item state after screen
; transitions
; uses current acc to compare
;======================================
restore_key_state
                ldx RESTORE_KEY
                cpx #$01
                bne L39C1

                ldx LEVEL_HAS_KEY
                cpx #$01
                bne L39BC

                ldx DOOR_OPENED
                cpx #$01
                beq L3963

                lda ITEMS
                and #$01
                cmp #$01
                bne L39A2

L3963           ldy #$00
                sty L39C2

                ldx #<$4000             ; GAME_SCREEN
                stx TILEPTR
                ldx #>$4000
                stx TILEPTR+1

L3970           lda (TILEPTR),Y
                iny
                cmp #$20
                beq L3997

                cpy #$F0
                bne L3970

                ldx L39C2
                cpx #$01
                beq L39BC

                .mvx #$01,L39C2

                clc
                lda TILEPTR
                adc #$F0
                sta TILEPTR
                bcc L3992

                inc TILEPTR+1

L3992           ldy #$00
                jmp L3970

L3997           dey
                lda #$00
                sta (TILEPTR),Y
                iny
                sta (TILEPTR),Y

                jmp L39BC

L39A2           lda KEY_POSX
                sta tile_to_tileptr._setTileX+1
                lda KEY_POSY
                sta tile_to_tileptr._setTileY+1

                jsr tile_to_tileptr

                ldy #$00
                lda #$20
                sta (TILEPTR),Y

                iny
                lda #$21
                sta (TILEPTR),Y

L39BC           .mvx #$00,RESTORE_KEY

L39C1           rts

;--------------------------------------

L39C2           .byte $00


;======================================
; restore coin state
;======================================
restore_coin_state
                ldx RESTORE_COIN
                cpx #$01
                bne L3A27

                .mvx LEVEL_ATTRS,TMP0
                .mvx LEVEL_ATTRS+1,TMP1

                ldy #$00
                lda (TMP0),Y
                cmp #$07
                bne L3A1F

                iny
                lda (TMP0),Y
                sta L3A2A

                lda #$02
                clc
                adc L3A2A
                sta L3A2A

                iny
L39EA           lda (TMP0),Y
                iny
                cmp #$FF
                beq L3A1F

                dey
                lda (TMP0),Y
                iny
                sta L3A28

                lda (TMP0),Y
                iny
                sta L3A29

                lda L3A28
                sta tile_to_tileptr._setTileX+1
                lda L3A29
                sta tile_to_tileptr._setTileY+1

                jsr tile_to_tileptr

                tya
                tax

                ldy #$00
                lda #$00
                sta (TILEPTR),Y
                iny
                sta (TILEPTR),Y

                txa
                tay
                cpy L3A2A
                bne L39EA

L3A1F           ldx #$00
                stx RESTORE_COIN
                stx VBLANK_SKIP

L3A27           rts

;--------------------------------------

L3A28           .byte $00
L3A29           .byte $00
L3A2A           .byte $00


;======================================
; restore door state
;======================================
restore_door_state
                ldx RESTORE_DOOR
                cpx #$01
                bne L3A8D

                ldx LEVEL_HAS_DOOR
                cpx #$01
                bne L3A88

                ldx DOOR_OPENED
                cpx #$01
                bne L3A88

                ldy #$00
                sty L3A8E

                ldx #<$4000             ; GAME_SCREEN
                stx TILEPTR
                ldx #>$4000
                stx TILEPTR+1

L3A4D           lda (TILEPTR),Y
                iny
                cmp #$14
                beq L3A74

                cpy #$F0
                bne L3A4D

                ldx L3A8E
                cpx #$01
                beq L3A88

                clc
                lda TILEPTR
                adc #$F0
                sta TILEPTR
                bcc L3A6A

                inc TILEPTR+1
L3A6A           .mvx #$01,L3A8E
                ldy #$00
                jmp L3A4D

L3A74           dey
                lda #$44
                sta (TILEPTR),Y

                iny
                lda #$45
                sta (TILEPTR),Y

                iny
                lda #$46
                sta (TILEPTR),Y

                iny
                lda #$47
                sta (TILEPTR),Y

L3A88           .mvx #$00,RESTORE_DOOR

L3A8D           rts

;--------------------------------------

L3A8E           .byte $00
