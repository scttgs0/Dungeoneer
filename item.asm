
;======================================
; shows picked up items at the top of
; the screen
;======================================
display_screen_items .proc
                jsr clear_screen_items

                .mva #$01,display_screen_key._setItem+1
                .mva #$20,display_screen_key._setCharset+1
                .mva #$00,display_screen_key._setScreen+1
                jsr display_screen_key

                rts
                .endproc


;======================================
; clear screen items
;======================================
clear_screen_items .proc
                lda #$00
                ldy #$00
_next1          sta ITEM_SCREEN,Y

                iny
                cpy #$04
                bne _next1

                rts
                .endproc


;======================================
; clear player lives
;======================================
clear_player_lives .proc
                ldx #$27
                ldy #$06
                lda #$00
_next1          sta ITEM_SCREEN,X
                dex
                sta ITEM_SCREEN,X
                dex

                dey
                bne _next1

                rts
                .endproc


;======================================
; displays player lives
;======================================
display_player_lives .proc
                jsr clear_player_lives

                ldx #$27
                ldy PLAYER_LIVES
                cpy #$00
                beq _XIT

_next1          lda #$2F
                sta ITEM_SCREEN,X
                dex

                sec
                sbc #$01
                sta ITEM_SCREEN,X
                dex

                dey
                bne _next1

_XIT            rts
                .endproc


;======================================
; removes crowns from the item screen
;======================================
clear_win_count .proc
                lda #$00
                ldx #$04
                ldy #$04

_next1          sta ITEM_SCREEN,X
                inx
                sta ITEM_SCREEN,X
                inx

                dey
                bne _next1

                rts
                .endproc


;======================================
; displays a crown for each win up to 4
;======================================
display_win_count .proc
                ldy WIN_COUNT
                cpy #$00
                beq _XIT

                ldx #$04
_next1          lda #$74
                sta ITEM_SCREEN,X
                inx

                lda #$75
                sta ITEM_SCREEN,X
                inx

                dey
                bne _next1

_XIT            rts
                .endproc


;======================================
; displays keys at the top of the screen
; charset_idx, index of the character to use
; item_idx, the bit index in ITEMS
; screen_idx, left to right position in ITEM_SCREEN
;======================================
display_screen_key .proc
_setItem        .mva #$00,l_item_idx

_setCharset     .mva #$00,l_charset_idx

_setScreen      .mva #$00,l_screen_idx

                lda ITEMS
                and l_item_idx
                cmp l_item_idx
                bne _XIT

                lda l_charset_idx
                ldy l_screen_idx
                sta ITEM_SCREEN,Y
                iny

                clc
                adc #$01
                sta ITEM_SCREEN,Y

_XIT            rts

;--------------------------------------

l_item_idx      .byte $00
l_charset_idx   .byte $00
l_screen_idx    .byte $00

                .endproc


;======================================
; display player score
;======================================
display_player_score .proc
;   score is kept in 4 byte (nibble) per memory location
                ldy #$16
                ldx #$00

;   get lower nibble (XN)
L2F11           lda PLAYER_SCORE,X
                and #$0F
                jsr display_number

;   get upper nibble (NX)
                lda PLAYER_SCORE,X
                and #$F0
                lsr                     ; /16
                lsr
                lsr
                lsr
                jsr display_number

                inx
                cpx #$02
                bne L2F11

                rts
                .endproc


;======================================
;
;======================================
display_number  .proc
                asl                     ; *2
                clc
                adc #$61               ; add display number offset
                sta ITEM_SCREEN,Y
                dey

                sec
                sbc #$01
                sta ITEM_SCREEN,Y
                dey

                rts
                .endproc


;======================================
; add to player score
;--------------------------------------
; score is stored in nibbles
; (ie. 0050 lbyte: 50, hbyte: 00)
;======================================
add_score       .proc
_setLoByte      .mvx #$00,item_lbyte

_setHiByte      .mvx #$00,item_hbyte

                ldy #$00
                .mvx #$00,item_carry

_next1          jsr add_lower_nibble
                jsr add_upper_nibble

                iny
                cpy #$02
                bne _next1

                jsr display_player_score
                jsr check_extra_life

                rts
                .endproc


;======================================
; add lower nibble with overflow
;======================================
add_lower_nibble .proc
; store lower nibble (XN)
                lda item_lbyte,Y
                and #$0F
                sta item_nibble

; load score lower nibble (XN)
                lda PLAYER_SCORE,Y
                and #$0F

; add to score nibble with carry (XN)
                clc
                adc item_nibble

                clc
                adc item_carry

; check for overflow (XN)
                cmp #$0A
                bcc _no_carry

                jmp _with_carry

_no_carry       sta item_nibble

                .mvx #$00,item_carry
                jmp _done

; sub 10, then set the carry into next nibble (ON)
_with_carry     sec
                sbc #$0A
                sta item_nibble

                .mvx #$01,item_carry
                jmp _done

; done with (XN), store in player score
_done           lda PLAYER_SCORE,Y
                and #$F0
                ora item_nibble
                sta PLAYER_SCORE,Y

                rts
                .endproc


;======================================
; add upper nibble with overflow
;======================================
add_upper_nibble .proc
; store higher nibble of score (NX)
                and #$F0
                lsr                     ; /16
                lsr
                lsr
                lsr
                sta item_nibble

; check high nibble for overflow (ONX)
                lda item_lbyte,Y
                and #$F0
                lsr                     ; /16
                lsr
                lsr
                lsr

                clc
                adc item_carry
                clc
                adc item_nibble

                cmp #$0A
                bcc _no_carry

                jmp _with_carry

; no carry, just store and move on (NX)
_no_carry       sta item_nibble

                .mvx #$00,item_carry
                jmp _done

; sub 10, then set the carry into the next nibble (ONX)
_with_carry     sec
                sbc #$0A
                sta item_nibble

                .mvx #$01,item_carry
                jmp _done

; done with lower byte, store (NN)
_done           lda PLAYER_SCORE,Y
                and #$0F
                sta item_temp

                lda item_nibble
                asl                     ; *16
                asl
                asl
                asl
                ora item_temp
                sta PLAYER_SCORE,Y

                rts
                .endproc


;--------------------------------------
;--------------------------------------
                rts


;--------------------------------------
;--------------------------------------

item_lbyte      .byte $00
item_hbyte      .byte $00
item_carry      .byte $00
item_nibble     .byte $00
item_temp       .byte $00


;======================================
; determines if collision is with a
; pickup item
;======================================
pickup_item     .proc
; bounding box for pickup
; top left
                .mva #$01,peek_position._setDX+1
                .mva #$01,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_item

                cmp #$01
                beq _1

                jsr check_player_death

; top right
                .mva #$07,peek_position._setDX+1
                .mva #$01,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_item

                cmp #$01
                beq _1

                jsr check_player_death

; bottom right
                .mva #$07,peek_position._setDX+1
                .mva #$07,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_item

                cmp #$01
                beq _1

                jsr check_player_death

; bottom left
                .mva #$01,peek_position._setDX+1
                .mva #$07,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_item

                cmp #$01
                beq _1

                jsr check_player_death

                rts

_1              jsr remove_playfield_item
                jsr display_screen_items

                rts
                .endproc


;======================================
; has key
;--------------------------------------
; acc == 0 if false, else acc > 0
;======================================
has_key         .proc
_setKey         .mva #$00,hk_key
                and ITEMS

                rts

;--------------------------------------

hk_key          .byte $00

                .endproc


;======================================
; open door
;======================================
open_door       .proc
; bounding box for contact
; top left
                .mva #$00,peek_position._setDX+1
                .mva #$00,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_proxy

                cmp #$01
                beq _XIT

; top right
                .mva #$07,peek_position._setDX+1
                .mva #$01,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_proxy

                cmp #$01
                beq _XIT

; bottom right
                .mva #$07,peek_position._setDX+1
                .mva #$07,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_proxy

                cmp #$01
                beq _XIT

; bottom left
                .mva #$00,peek_position._setDX+1
                .mva #$07,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_proxy

                cmp #$01
                beq _XIT

_XIT            rts
                .endproc


;======================================
; remove playfield item
;======================================
remove_playfield_item .proc
; remember first encountered tile
                ldy TILEX
                lda (TILEPTR),Y

; clear encountered tile
                tax
                lda #$00
                sta (TILEPTR),Y

                txa
                lsr                     ; /2
                bcc _1

; determine which direction the other tile is in
; if odd clear right
                dey
                jmp _2

; if even clear left
_1              iny

; clear other tile
_2              lda #$00
                sta (TILEPTR),Y

                rts
                .endproc


;======================================
; get item bit
;--------------------------------------
; retrives the item bit mask for an ONTILE item
; stores bit in acc
;======================================
get_item_bit    ;.proc
; stort inital address and bit values
                .mvx #$01,gib_bit
                .mvx #$20,gib_item_tile_LO
                .mvx #$22,gib_item_tile_HI
                .mvx #$08,gib_counter

; check to see if item exists
_next1          .mva gib_item_tile_LO,between._setLow+1
                .mva ONTILE,between._setValue+1
                .mva gib_item_tile_HI,between._setHigh+1
                jsr between

                cmp #$01
                beq _1

; if not, shift left increase address and continue
                lda gib_bit
                asl
                sta gib_bit

                lda gib_item_tile_LO
                clc
                adc #$02
                sta gib_item_tile_LO

                lda gib_item_tile_HI
                clc
                adc #$02
                sta gib_item_tile_HI

                dec gib_counter
                bne _next1

_1              lda gib_bit
                rts

;--------------------------------------

gib_bit             .byte $00
gib_counter         .byte $00
gib_item_tile_LO    .byte $00
gib_item_tile_HI    .byte $00

                ;.endproc


;======================================
; checks for player death state
;======================================
check_player_death .proc
                jsr tile_is_death

                cmp #$01
                bne _XIT

                jsr player_died

_XIT            rts
                .endproc


;======================================
; player died
;======================================
player_died     .proc
                .mwx death_sfx,SFX1_ADDR
                .mvx #$01,SFX1

                ldx PLAYER_DEATH
                cpx #$01
                beq _XIT

                .mvx #$01,PLAYER_DEATH

                dec PLAYER_LIVES
                jsr display_player_lives

                .mvx #$00,ITEMS
                jsr display_screen_items

_XIT            rts
                .endproc


;======================================
; checks for game over state
;======================================
check_game_over .proc
                ldx PLAYER_LIVES
                cpx #$00
                bne _1

                jsr display_gameover
                jmp _XIT

_1              .mvx #$01,RESTORE_KEY

_XIT            rts
                .endproc


;======================================
; checks score and life gain to add
; extra lives
;======================================
check_extra_life .proc
                ldx PLAYER_SCORE+1
                ldy LIFE_GAIN
                cpy #$00
                bne _1

                cpx #$04
                bcc _XIT

                jmp _3

_1              cpy #$01
                bne _2

                cpx #$08
                bcc _XIT

                jmp _3

_2              cpy #$02
                bne _XIT

                cpx #$10
                bcc _XIT

                jmp _3

_3              inc PLAYER_LIVES
                inc LIFE_GAIN
                jsr play_gain_life_sound
                jsr display_player_lives

                rts

_XIT            rts
                .endproc
