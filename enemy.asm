
;======================================
; combining 4 missiles into player 5
;======================================
draw_enemy      .proc
;   load animation offset and set limit
                ldx ENEMANIM_OFFSET
                txa
                clc
                adc #$08
                sta _limit

                ldy ENEMY_POSY
_next1          lda enemy_data,X
                sta PMG+$180,Y

                iny
                inx

;   verify offset limit
                txa
                cmp _limit
                bne _next1

                rts

;--------------------------------------

_limit          .byte $00

                .endproc


;======================================
; animate enemy
;======================================
animate_enemy   .proc
                lda ENEMY_SPRITE
                clc
                adc #$01
                sta ENEMY_SPRITE

                cmp #$05
                bne _XIT

                .mvx #$00,ENEMY_SPRITE
                jsr draw_enemy

                lda ENEMANIM_OFFSET
                clc
                adc #$08
                sta ENEMANIM_OFFSET

                cmp #$10
                bne _XIT

                .mvx #$00,ENEMANIM_OFFSET

_XIT            rts
                .endproc


;======================================
; resets enemy chosen direction
;======================================
reset_enemy     .proc
                ldx #$00
                stx ENEMY_DIR_X
                stx ENEMY_DIR_Y

                rts
                .endproc


;======================================
; render enemy
;======================================
render_enemy    .proc
;   render only on game screen
                ldx DISPLAY_TYPE
                cpx #$02
                bne _hide_enemy

;   hide enemy if off playing field
                ldx ENEMY_POSX
                cpx #$00
                beq _hide_enemy

;   show spider initially
                lda ENEMY_DIR_X
                ora ENEMY_DIR_Y
                cmp #$00
                beq _init

;   check for currently in motion
_setup          ldx ENEMY_MOVE_INDEX
                cpx #$00
                bne _dir_chosen

                jsr enemy_choose_direction
                jmp _dir_chosen

_init           ldx #$00
                stx ENEMANIM_OFFSET
                stx ENEMY_MOVE_INDEX
                jsr draw_enemy

                jmp _setup

_hide_enemy     jsr clear_enemy_pmg

                ldx #$00
                stx ENEMY_POSX
                stx ENEMY_POSY

                jsr update_enemy_posx

                rts

;   wait until enemy speed resistance has elapsed
_dir_chosen     ldx ENEMY_SPEED_RES
                cpx #$00
                beq _move

;   normal check
                inc ENEMY_MOVE_INDEX
                lda ENEMY_MOVE_INDEX
                cmp ENEMY_SPEED_RES
                beq _move

                jmp _XIT

_move           .mvx #$00,ENEMY_MOVE_INDEX
                jsr enemy_move_blocked

                cmp #$01
                beq _reset

                jsr animate_enemy

                lda ENEMY_POSX
                clc
                adc ENEMY_DIR_X
                sta ENEMY_POSX

                lda ENEMY_POSY
                clc
                adc ENEMY_DIR_Y
                sta ENEMY_POSY

                jsr update_enemy_posx
                jsr clear_enemy_vertical
                jsr draw_enemy
                jmp _XIT

_reset          ldx #$00
                stx ENEMY_MOVE_INDEX
                stx ENEMY_DIR_X
                stx ENEMY_DIR_Y

_XIT            rts
                .endproc


;======================================
; enemy choose direction
;======================================
enemy_choose_direction .proc
                lda ENEMY_DIR_X
                ora ENEMY_DIR_Y
                cmp #$00
                bne _XIT

                lda RANDOM
                lsr A                   ; /64
                lsr A
                lsr A
                lsr A
                lsr A
                lsr A

_move_north     cmp #$00
                bne _move_east

                .mvx #$00,ENEMY_DIR_X
                .mvx #$FF,ENEMY_DIR_Y

                jmp _XIT

_move_east      cmp #$01
                bne _move_south

                .mvx #$01,ENEMY_DIR_X
                .mvx #$00,ENEMY_DIR_Y

                jmp _XIT

_move_south     cmp #$02
                bne _move_west

                .mvx #$00,ENEMY_DIR_X
                .mvx #$01,ENEMY_DIR_Y

                jmp _XIT

_move_west      .mvx #$FF,ENEMY_DIR_X
                .mvx #$00,ENEMY_DIR_Y

_XIT            rts
                .endproc


;======================================
; on exit:
; acc == 1 if true, else acc == 0
;======================================
enemy_move_blocked .proc
                jmp _north

_XIT1           rts

_north          ldx ENEMY_DIR_Y
                cpx #$FF
                bne _south

                .mva #$00,peek_enemy_position._setDX+1
                .mva #$FF,peek_enemy_position._setDY+1
                jsr peek_enemy_position
                jsr tile_is_enemy_block

                cmp #$01
                beq _XIT1

                .mva #$07,peek_enemy_position._setDX+1
                .mva #$FF,peek_enemy_position._setDY+1
                jsr peek_enemy_position
                jsr tile_is_enemy_block

                cmp #$01
                beq _XIT1

_south          cpx #$01
                bne _east

                .mva #$00,peek_enemy_position._setDX+1
                .mva #$08,peek_enemy_position._setDY+1
                jsr peek_enemy_position
                jsr tile_is_enemy_block

                cmp #$01
                beq _XIT1

                .mva #$07,peek_enemy_position._setDX+1
                .mva #$08,peek_enemy_position._setDY+1
                jsr peek_enemy_position
                jsr tile_is_enemy_block

                cmp #$01
                beq _XIT1

_east           ldx ENEMY_DIR_X
                cpx #$01
                bne _west

                .mva #$08,peek_enemy_position._setDX+1
                .mva #$00,peek_enemy_position._setDY+1
                jsr peek_enemy_position
                jsr tile_is_enemy_block

                cmp #$01
                beq _XIT

                .mva #$08,peek_enemy_position._setDX+1
                .mva #$07,peek_enemy_position._setDY+1
                jsr peek_enemy_position
                jsr tile_is_enemy_block

                cmp #$01
                beq _XIT

_west           cpx #$FF
                bne _XIT

                .mva #$FF,peek_enemy_position._setDX+1
                .mva #$00,peek_enemy_position._setDY+1
                jsr peek_enemy_position
                jsr tile_is_enemy_block

                cmp #$01
                beq _XIT

                .mva #$FF,peek_enemy_position._setDX+1
                .mva #$07,peek_enemy_position._setDY+1
                jsr peek_enemy_position
                jsr tile_is_enemy_block

                cmp #$01
                beq _XIT

                lda #$00

_XIT            rts
                .endproc


;======================================
; sets the enemy position
;======================================
update_enemy_posx .proc
                .mva ENEMY_POSX,HPOSM3

                clc
                adc #$02
                sta HPOSM2

                clc
                adc #$02
                sta HPOSM1

                clc
                adc #$02
                sta HPOSM0

                rts
                .endproc


;======================================
; check enemy player collision
;======================================
check_enemy_player_collision .proc
                ldx PLAYER_DEATH
                cpx #$00
                bne _reset

                ldx M0PL
                cpx #$00
                bne _dead

                ldx M1PL
                cpx #$00
                bne _dead

                ldx M2PL
                cpx #$00
                bne _dead

                ldx M3PL
                cpx #$00
                bne _dead

                jmp _reset

_dead           jsr player_died

_reset          .mvx #$00,HITCLR

                rts
                .endproc
