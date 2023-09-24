
;======================================
; setup tileset
;======================================
setup_tileset   .mvx #$50,TILESET_ADDRESS

                .mvx TILESET_ADDRESS,CHBAS

                rts


;======================================
; setup menu tileset
;======================================
setup_menu_tileset
                .mvx #$5C,TILESET_ADDRESS

                .mvx TILESET_ADDRESS,CHBAS

                rts


;======================================
; animate tilesprite
;======================================
animate_tilesprite
                inc TILESPRITE
                ldx TILESPRITE
                ldy TILESPRITE_INDEX

                lda TILESPRITE_ENABLE
                cmp #$01
                bne _XIT

                cpx #$0A
                bne _XIT

                .mvx #$FF,TILESPRITE

                iny
                sty TILESPRITE_INDEX

                lda CHBAS
                clc
                adc #$04
                sta CHBAS

                cpy #$03
                beq _1

                sta CHBAS

                jmp _XIT

_1              lda TILESET_ADDRESS
                sta CHBAS

                lda #$00
                sta TILESPRITE_INDEX

_XIT            rts


;======================================
; store on tile
;======================================
store_ontile    ldx #<$4000             ; GAME_SCREEN
                stx TILEPTR
                ldx #>$4000
                stx TILEPTR+1

                ldx TILEY
                cpx #$00
                beq _2

                ldx #$00
_next1          clc
                lda TILEPTR
                adc #$28
                sta TILEPTR
                bcc _1

                inc TILEPTR+1

_1              inx
                cpx TILEY
                bne _next1

_2              ldy TILEX
                lda (TILEPTR),Y
                sta ONTILE

                rts


;======================================
; store tile x
;======================================
store_tilex     lda POSX
                sec
                sbc #$30
                lsr A
                lsr A
                sta TILEX

                rts


;======================================
; store tile y
;======================================
store_tiley     lda POSY
                sec
                sbc #$18
                lsr A
                lsr A
                lsr A
                sta TILEY

                rts


;======================================
; store enemy tile y
;======================================
store_enemy_tilex
                lda ENEMY_POSX
                sec
                sbc #$30
                lsr A
                lsr A
                sta TILEX

                rts


;======================================
; store enemy tiley
;======================================
store_enemy_tiley
                lda ENEMY_POSY
                sec
                sbc #$18
                lsr A
                lsr A
                lsr A
                sta TILEY

                rts


;======================================
; tile is block
;--------------------------------------
; if true, acc == 1, else acc == 0
;======================================
tile_is_block   lda #$10
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$20
                sta between._setHigh+1

                jsr between

                cmp #$01
                beq _XIT

                lda #$90
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$A0
                sta between._setHigh+1

                jsr between

_XIT            rts


;======================================
; tile is enemy block
;--------------------------------------
; if true, acc == 1, else acc == 0
;======================================
tile_is_enemy_block
                lda #$10
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$20
                sta between._setHigh+1

                jsr between

                cmp #$01
                beq _XIT

                lda #$90
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$A0
                sta between._setHigh+1

                jsr between

                cmp #$01
                beq _XIT

                lda #$34
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$36
                sta between._setHigh+1

                jsr between

                cmp #$01
                beq _XIT

                lda #$3E
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$40
                sta between._setHigh+1

                jsr between

                cmp #$01
                beq _XIT

                lda #$5C
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$60
                sta between._setHigh+1

                jsr between

_XIT            rts


;======================================
; tile is key
;--------------------------------------
; if true, acc == 1, else acc == 0
;======================================
tile_is_key     lda #$20
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$28
                sta between._setHigh+1

                jsr between

                rts


;======================================
; tile is chest
;--------------------------------------
; if true, acc == 1, else acc == 0
;======================================
tile_is_chest   lda #$28
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$2A
                sta between._setHigh+1

                jsr between

                rts


;======================================
; tile is coin
;--------------------------------------
; if true, acc == 1, else acc == 0
;======================================
tile_is_coin    lda #$2A
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$2C
                sta between._setHigh+1

                jsr between

                rts


;======================================
; tile is an item
;--------------------------------------
; if true, acc == 1, else acc == 0
;======================================
tile_is_item    jsr tile_is_key

                cmp #$01
                bne _1

                lda #$05
                sta add_score._setLoByte+1
                lda #$00
                sta add_score._setHiByte+1

                jsr add_score

                lda #$01
                sta ITEMS

                jsr play_key_sound

                jmp _XIT

_1              jsr tile_is_chest

                cmp #$01
                bne _2

                lda #$20
                sta add_score._setLoByte+1
                lda #$00
                sta add_score._setHiByte+1

                jsr add_score

                lda TILEX
                sta update_coin_state._setTileX+1
                lda TILEY
                sta update_coin_state._setTileY+1

                jsr update_coin_state

                lda #$01
                jsr play_chest_sound

                jmp _XIT

_2              jsr tile_is_coin

                cmp #$01
                bne _XIT

                lda #$05
                sta add_score._setLoByte+1
                lda #$00
                sta add_score._setHiByte+1
                jsr add_score

                lda TILEX
                sta update_coin_state._setTileX+1
                lda TILEY
                sta update_coin_state._setTileY+1

                jsr update_coin_state

                lda #$01
                jsr play_coin_sound

                jmp _XIT

_XIT            rts


;======================================
; tile is death
;--------------------------------------
; if true, acc == 1, else acc == 0
;======================================
tile_is_death   lda #$3E
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$40
                sta between._setHigh+1

                jsr between

                rts


;======================================
; tile is proxy
;======================================
tile_is_proxy   lda #$34
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$36
                sta between._setHigh+1

                jsr between

                cmp #$01
                bne _XIT

_XIT            rts


;======================================
; tile is wall passthrough
;======================================
tile_is_wall_pasthrough
                lda #$32
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$34
                sta between._setHigh+1

                jsr between

                cmp #$01
                beq _1

                jsr tile_is_proxy

                cmp #$01
                beq _1
                bne _2

_1              .mvx #$18,GPRIOR
                jmp _XIT

_2              .mvx #$11,GPRIOR
                jmp _XIT

_XIT            rts


;======================================
; tile is transition north
;--------------------------------------
; if true, x == 1, else x == 0
;======================================
tile_is_transition_n
                ldx ONTILE
                cpx #$5C
                bne _1

                ldx #$01
                rts

_1              ldx #$00
                rts


;======================================
; tile is transition east
;--------------------------------------
; if true, x == 1, else x == 0
;======================================
tile_is_transition_e
                ldx ONTILE
                cpx #$5E
                bne _1

                ldx #$01
                rts

_1              ldx #$00
                rts


;======================================
; tile is transition south
;--------------------------------------
; if true, x == 1, else x == 0
;======================================
tile_is_transition_s
                ldx ONTILE
                cpx #$5D
                bne _1

                ldx #$01
                rts

_1              ldx #$00
                rts


;======================================
; tile is transition west
;--------------------------------------
; if true, x == 1, else x == 0
;======================================
tile_is_transition_w
                ldx ONTILE
                cpx #$5F
                bne _1

                ldx #$01
                rts

_1              ldx #$00
                rts


;======================================
; tile is locked door
;--------------------------------------
; if true, acc == 1, else acc == 0
;======================================
tile_is_locked_door
                lda #$14
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$18
                sta between._setHigh+1

                jsr between

                rts


;======================================
; tile is exit
;======================================
tile_is_exit    lda #$50
                sta between._setLow+1
                lda ONTILE
                sta between._setValue+1
                lda #$52
                sta between._setHigh+1

                jsr between

                rts


;======================================
; tile is locked proxy
;======================================
tile_is_locked_proxy
                jsr tile_is_locked_door

                cmp #$01
                bne _1

                jmp _2

_1              jsr tile_is_proxy

                cmp #$01
                bne _XIT

                jsr find_locked_door

                cmp #$01
                bne _XIT

_2              .mva #$01,has_key._setKey+1
                jsr has_key

                cmp #$00
                beq _3

                jsr unlock_door
                jmp _XIT

_3              lda #$01
                rts

_XIT            lda #$00
                rts


;======================================
; unlock door
;======================================
unlock_door     .mvx #$01,DOOR_OPENED

                ldy TILEX
_next1          lda (TILEPTR),Y
                dey
                cmp #$14
                bne _next1

                iny
                lda #$44
                sta (TILEPTR),Y

                iny
                clc
                adc #$01
                sta (TILEPTR),Y

                iny
                clc
                adc #$01
                sta (TILEPTR),Y

                iny
                clc
                adc #$01
                sta (TILEPTR),Y

                iny
                jsr play_door_open_sound

                .mvx #$00,ITEMS

                jsr display_screen_items

                rts


;======================================
;; find locked door
;--------------------------------------
; updates tilex, tiley with location
; if found acc == 1, else acc == 0
;======================================
find_locked_door
                inc TILEY

                jsr store_ontile
                jsr tile_is_locked_door

                cmp #$01
                beq _XIT

                dec TILEY
                jsr store_ontile

                dec TILEX
                jsr store_ontile
                jsr tile_is_locked_door

                cmp #$01
                beq _XIT

                inc TILEX
                jsr store_ontile

                dec TILEY
                jsr store_ontile
                jsr tile_is_locked_door

                cmp #$01
                beq _XIT

                inc TILEY
                jsr store_ontile

                inc TILEX
                jsr store_ontile
                jsr tile_is_locked_door

                cmp #$01
                beq _XIT

                dec TILEX
                jsr store_ontile

_XIT            rts


;======================================
; peek position
;--------------------------------------
; temporarily advances POSX, POSY and
; stores TILEX, TILEY and ONTILE
; uses TMP2 (x), TMP3 (y)
;======================================
peek_position
_setDX          ldx #$00
                stx _dx

_setDY          ldx #$00
                stx _dy

                lda POSX
                clc
                adc _dx
                sta POSX

                lda POSY
                clc
                adc _dy
                sta POSY

                jsr store_tilex
                jsr store_tiley
                jsr store_ontile

                lda POSX
                sec
                sbc _dx
                sta POSX

                lda POSY
                sec
                sbc _dy
                sta POSY

                rts

;--------------------------------------

_dx             .byte $00
_dy             .byte $00


;======================================
; peek enemy position
;--------------------------------------
; temporarily advances ENEMY_POSX,
; ENEMY_POSY and stores TILEX, TILEY
; and ONTILE
; uses TMP2 (x), TMP3 (y)
;======================================
peek_enemy_position
_setDX          .mvx #$00,peek_enemy_dx
_setDY          .mvx #$00,peek_enemy_dy

                lda ENEMY_POSX
                clc
                adc peek_enemy_dx
                sta ENEMY_POSX

                lda ENEMY_POSY
                clc
                adc peek_enemy_dy
                sta ENEMY_POSY

                jsr store_enemy_tilex
                jsr store_enemy_tiley
                jsr store_ontile

                lda ENEMY_POSX
                sec
                sbc peek_enemy_dx
                sta ENEMY_POSX

                lda ENEMY_POSY
                sec
                sbc peek_enemy_dy
                sta ENEMY_POSY

                rts

;--------------------------------------

peek_enemy_dx   .byte $00
peek_enemy_dy   .byte $00


;======================================
; enable tile sprite animation
;======================================
enable_tilesprite_animation
                .mvx #$FF,TILESPRITE

                .mvx #$00,TILESPRITE_INDEX

                .mvx #$01,TILESPRITE_ENABLE

                rts


;======================================
;
;======================================
disable_tilesprite_animation
                .mvx #$00,TILESPRITE_ENABLE

                rts
