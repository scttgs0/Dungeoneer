
;======================================
; render background music
;======================================
render_background_music
                ldx BGM_ENABLE
                cpx #$01
                bne _XIT

                inc BGM_COUNTER
                ldx BGM_COUNTER
                cpx BGM_NOTE_SUSTAIN
                bcc _still_playing

                lda #$00
                sta AUDC4

_still_playing  cpx BGM_NOTE_SILENCE
                bcs _play_note

                jmp _XIT

_play_note      .mvx #$00,BGM_COUNTER

                ldy BGM_DATA_INDEX
                lda (BGM_ADDR),Y
                sta AUDF4

                iny
                lda (BGM_ADDR),Y
                sta AUDC4

                iny
                lda (BGM_ADDR),Y
                sta BGM_NOTE_SUSTAIN

                iny
                lda (BGM_ADDR),Y
                sta BGM_NOTE_SILENCE

                iny
                sty BGM_DATA_INDEX
                lda (BGM_ADDR),Y

                cmp #$00
                bne _XIT

                .mvx #$00,BGM_DATA_INDEX

_XIT            rts


;======================================
; stop background music
;======================================
stop_background_music
                ldx #$00
                stx BGM_ENABLE
                stx AUDC4

                rts


;======================================
; enable background music
;======================================
play_background_music
                .mvx #$00,BGM_COUNTER

                .mvx #$00,BGM_DATA_INDEX

                .mvx #$01,BGM_ENABLE

                rts


;======================================
; play key pickup sound
;======================================
play_key_sound  ldx #$00
                stx SFX1_COUNTER
                stx SFX1_DATA_INDEX

                .mwx key_pickup_sfx,SFX1_ADDR
                .mvx #$01,SFX1

                rts


;======================================
; play chest pickup sound
;======================================
play_chest_sound
                ldx #$00
                stx SFX1_COUNTER
                stx SFX1_DATA_INDEX

                .mwx chest_pickup_sfx,SFX1_ADDR
                .mvx #$01,SFX1

                rts


;======================================
; play coin pickup sound
;======================================
play_coin_sound ldx #$00
                stx SFX1_COUNTER
                stx SFX1_DATA_INDEX

                .mwx coin_pickup_sfx,SFX1_ADDR
                .mvx #$01,SFX1

                rts


;======================================
; play door open sound
;======================================
play_door_open_sound
                ldx #$00
                stx SFX1_COUNTER
                stx SFX1_DATA_INDEX

                .mwx door_open_sfx,SFX1_ADDR
                .mvx #$01,SFX1

                rts


;======================================
; play exit level sound
;======================================
play_exit_level_sound
                ldx #$00
                stx SFX2_COUNTER
                stx SFX2_DATA_INDEX

                .mwx exit_level_sfx,SFX2_ADDR
                .mvx #$01,SFX2

                rts


;======================================
; play game over sound
;======================================
play_gameover_sound
                ldx #$00
                stx SFX1_COUNTER
                stx SFX1_DATA_INDEX

                .mwx gameover_sfx,SFX1_ADDR
                .mvx #$01,SFX1

                rts


;======================================
; play menu item sound
;======================================
play_mainmenu_item_sound
                ldx #$00
                stx SFX1_COUNTER
                stx SFX1_DATA_INDEX

                .mwx mainmenu_item_sfx,SFX1_ADDR
                .mvx #$01,SFX1

                rts


;======================================
; play gain life sound
;======================================
play_gain_life_sound
                ldx #$00
                stx SFX2_COUNTER
                stx SFX2_DATA_INDEX

                .mwx gain_life_sfx,SFX2_ADDR
                .mvx #$01,SFX2

                rts


;======================================
; render sound effects
;======================================
render_sfx
                .mvx #$00,TMP0

L32F6           .mvx #$00,TMP1

L32FA           .mvx #$00,TMP2

L32FE           .mvx #$00,TMP3

                .mvx TMP0,SOUND
                .mvx TMP1,SOUND+1

                .mvx TMP0,COUNTER
                .mvx TMP1,COUNTER+1

                .mvx TMP0,INDEX
                .mvx TMP1,INDEX+1

                .mvx TMP0,SUSTAIN
                .mvx TMP1,SUSTAIN+1

                .mvx TMP0,SILENCE
                .mvx TMP1,SILENCE+1

                .mvx TMP2,CHANNEL
                .mvx TMP3,CHANNEL+1

                clc
                lda SOUND
                adc #$01
                sta SOUND
                bcc _1

                inc SOUND+1

_1              clc
                lda COUNTER
                adc #$03
                sta COUNTER
                bcc _2

                inc COUNTER+1

_2              clc
                lda INDEX
                adc #$04
                sta INDEX
                bcc _3

                inc INDEX+1

_3              clc
                lda SUSTAIN
                adc #$05
                sta SUSTAIN
                bcc _4

                inc SUSTAIN+1

_4              clc
                lda SILENCE
                adc #$06
                sta SILENCE
                bcc _5

                inc SILENCE+1

_5              clc
                lda CHANNEL
                adc #$01
                sta CHANNEL
                bcc _6

                inc CHANNEL+1

_6              ldy #$00
                lda (SOUND),Y
                tax
                iny
                lda (SOUND),Y
                sta SOUND+1
                txa
                sta SOUND
                ldy #$00
                lda (TMP0),Y
                cmp #$01
                bne _XIT1

                jmp _7

_XIT1           rts

_7              lda (INDEX),Y
                cmp #$00
                beq _play_note

                lda (COUNTER),Y
                clc
                adc #$01
                sta (COUNTER),Y
                cmp (SUSTAIN),Y
                bcc _still_playing

                lda #$00
                sta (CHANNEL),Y

_still_playing  lda (COUNTER),Y
                cmp (SILENCE),Y
                bcs _play_note

                jmp _XIT

_play_note      lda #$00
                sta (COUNTER),Y

                lda (INDEX),Y
                tay
                lda (SOUND),Y
                cmp #$00
                beq _complete

                cmp #$01
                bne _continue_play

                ldy #$00
                lda #$00
                sta (CHANNEL),Y
                lda (INDEX),Y
                clc
                adc #$01
                sta (INDEX),Y
                jmp _sustain

_continue_play  ldy #$00
                lda (INDEX),Y
                tay
                lda (SOUND),Y
                ldy #$00
                sta (TMP2),Y
                lda (INDEX),Y
                clc
                adc #$01
                sta (INDEX),Y
                tay
                lda (SOUND),Y
                ldy #$00
                sta (CHANNEL),Y

_sustain        lda (INDEX),Y
                clc
                adc #$01
                sta (INDEX),Y
                tay
                lda (SOUND),Y
                ldy #$00
                sta (SUSTAIN),Y
                lda (INDEX),Y
                clc
                adc #$01
                sta (INDEX),Y
                lda (INDEX),Y
                tay
                lda (SOUND),Y
                ldy #$00
                sta (SILENCE),Y
                lda (INDEX),Y
                clc
                adc #$01
                sta (INDEX),Y
                jmp _XIT

_complete       ldy #$00
                lda #$00
                sta (CHANNEL),Y
                lda #$00
                sta (COUNTER),Y
                lda #$00
                sta (INDEX),Y
                lda #$00
                sta (TMP0),Y

_XIT            rts


;======================================
;
;======================================
sequence_sound_handler
                ldx RTCLOK+2
                cpx CLOCK_PREV
                beq _XIT

                stx CLOCK_PREV

                jsr render_background_music

                lda #$E7
                sta render_sfx+1
                lda #$00
                sta L32F6+1
                lda #$00
                sta L32FA+1
                lda #$D2
                sta L32FE+1

                jsr render_sfx

                lda #$EE
                sta render_sfx+1
                lda #$00
                sta L32F6+1
                lda #$02
                sta L32FA+1
                lda #$D2
                sta L32FE+1

                jsr render_sfx

_XIT            rts
