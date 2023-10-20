
;======================================
; between
;--------------------------------------
; compares low <= value < high
; result stored in acc
;======================================
between         .proc
_setLow         ldx #$00
                stx _low

_setValue       ldx #$00
                stx _value

_setHigh        ldx #$00
                stx _high

;   compare value to low end
                ldx _value
                cpx _low
                bcc _fail

;   compare value to high end
                cpx _high
                bcs _fail

                lda #$01
                jmp _XIT

_fail           lda #$00

_XIT            rts

;--------------------------------------

_low            .byte $00
_value          .byte $00
_high           .byte $00,$00

                .endproc


;======================================
; sets acc to absolute TILEX position
; in pixels
;======================================
tilex_to_posx   lda TILEX
                asl                     ; *4
                asl
                clc
                adc #$30

                rts


;======================================
; pixel to tilex
;======================================
posx_to_tilex   lda POSX
                sec
                sbc #$30
                lsr                     ; /4
                lsr

                rts


;======================================
; sets acc to absolute TILEY position
; in pixels
;======================================
tiley_to_posy   lda TILEY
                asl                     ; *8
                asl
                asl
                clc
                adc #$18

                rts


;======================================
; pixel to tiley
;======================================
posy_to_tiley   lda POSY
                sec
                sbc #$18
                lsr                     ; /8
                lsr
                lsr

                rts


;======================================
; finds the first matching TILEX using
; POSY for tile row
;======================================
find_tilex
_setTileY       ldx #$00
                stx _tiley

_setFindTile    ldx #$00
                stx _find_tile

                ldx #$00                ; GAME_SCREEN
                stx TILEPTR

                .mvx #$40,TILEPTR+1

                ldx _tiley
                cpx #$00
                beq _continue

;   set initial tile pointer pos to row offset
                ldx L00FF
_offset         clc
                lda TILEPTR
                adc #$28
                sta TILEPTR
                bcc _1

                inc TILEPTR+1

_1              inx
                cpx _tiley
                bne _offset

_continue       ldy #$28
_next1          dey
                lda (TILEPTR),Y
                cmp _find_tile
                bne _verify

                tya
                jmp _XIT

_verify         cpy #$00
                bne _next1

                lda #$FF

_XIT            rts

;--------------------------------------

_tiley          .byte $00
_find_tile      .byte $00


;======================================
; finds the first matching TILEY using
; POSX for tile row
;======================================
find_tiley
_setTileX       ldx #$00
                stx _tilex

_setFindTile    ldx #$00
                stx _find_tile

                ldx #$00                ; GAME_SCREEN
                stx TILEPTR

                .mvx #$40,TILEPTR+1

                ldy _tilex

;   set initial tile pointer pos to row offset
                ldx #$00
_next1          lda (TILEPTR),Y
                cmp _find_tile
                beq _found

                clc
                lda TILEPTR
                adc #$28
                sta TILEPTR
                bcc _1

                inc TILEPTR+1

_1              inx
                cpx #$0C
                bne _next1

                lda #$FF
                jmp _XIT

_found          txa
_XIT            rts

;--------------------------------------

_tilex          .byte $00
_find_tile      .byte $00


;======================================
; updates TILEPTR to the coordinates
; of args tilex, tiley
;======================================
tile_to_tileptr
_setTileX       lda #$00
                sta _tilex

_setTileY       lda #$00
                sta _tiley

                lda #$00                ; GAME_SCREEN
                sta TILEPTR

                lda #$40
                sta TILEPTR+1

;   advance to row
                ldx _tiley
                cpx #$00
                beq _continue

_nextRow        clc
                lda TILEPTR
                adc #$28
                sta TILEPTR
                bcc _1

                inc TILEPTR+1

_1              dex
                bne _nextRow

_continue       ldx _tilex
                cpx #$00
                beq _XIT

_nextColumn     clc
                lda TILEPTR
                adc #$01
                sta TILEPTR
                bcc _2

                inc TILEPTR+1

_2              dex
                bne _nextColumn

_XIT            rts

;--------------------------------------

_tilex          .byte $00
_tiley          .byte $00


;======================================
;
;======================================
initialize_zeropage ;.proc
                lda #$00
                tax
_next1          sta TILEPTR,X
                sta L0100,X

                inx
                cpx #$40
                bne _next1

                rts
