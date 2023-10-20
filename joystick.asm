
;======================================
; can move left
;======================================
can_move_left   .proc
; bounding box check
; top left
                .mva #$FF,peek_position._setDX+1
                .mva #$01,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_locked_proxy

                cmp #$01
                beq _XIT

                jsr tile_is_block

                cmp #$01
                beq _XIT

; bottom left
                .mva #$FF,peek_position._setDX+1
                .mva #$07,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_locked_proxy

                cmp #$01
                beq _XIT

                jsr tile_is_block

                cmp #$01
                beq _XIT

; move player
                dec POSX

                jsr tile_is_wall_pasthrough

_XIT            rts
                .endproc


;======================================
; can move right
;======================================
can_move_right  .proc
; bounding box check
; top right
                .mva #$09,peek_position._setDX+1
                .mva #$01,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_locked_proxy

                cmp #$01
                beq _XIT

                jsr tile_is_block

                cmp #$01
                beq _XIT

;bottom right
                .mva #$09,peek_position._setDX+1
                .mva #$07,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_locked_proxy

                cmp #$01
                beq _XIT

                jsr tile_is_block

                cmp #$01
                beq _XIT

; move player
                inc POSX

                jsr tile_is_wall_pasthrough

_XIT            rts
                .endproc


;======================================
; can move up
;======================================
can_move_up     .proc
; bounding box check
; top left
                .mva #$00,peek_position._setDX+1
                .mva #$FF,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_locked_proxy

                cmp #$01
                beq _XIT

                jsr tile_is_block

                cmp #$01
                beq _XIT

; top right
                .mva #$08,peek_position._setDX+1
                .mva #$FF,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_locked_proxy

                cmp #$01
                beq _XIT

                jsr tile_is_block

                cmp #$01
                beq _XIT

; move player
                dec POSY

                ;;obsolete jsr clear_player_vertical
                jsr tile_is_wall_pasthrough

_XIT            rts
                .endproc


;======================================
; can move down
;======================================
can_move_down   .proc
; bounding box check
; bottom left
                .mva #$00,peek_position._setDX+1
                .mva #$08,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_locked_proxy

                cmp #$01
                beq _XIT

                jsr tile_is_block

                cmp #$01
                beq _XIT

; bottom right
                .mva #$08,peek_position._setDX+1
                .mva #$08,peek_position._setDY+1
                jsr peek_position
                jsr tile_is_locked_proxy

                cmp #$01
                beq _XIT

                jsr tile_is_block

                cmp #$01
                beq _XIT

; move player
                inc POSY

                ;;obsolete jsr clear_player_vertical
                jsr tile_is_wall_pasthrough

_XIT            rts
                .endproc


;======================================
; handle player movement
;======================================
read_game_joystick .proc
                ldx DISABLE_JOYSTICK
                cpx #$01
                beq _XIT

                ldx DISPLAY_TYPE
                cpx #$02
                bne _XIT

                ldx PLAYER_DEATH
                cpx #$01
                beq _XIT

                ldx STICK0
                cpx #$0F
                beq _move_none

                cpx #$0B
                beq _move_left

                cpx #$07
                beq _move_right

                cpx #$0E
                beq _move_up

                cpx #$0D
                beq _move_down

                rts

_move_left      jsr can_move_left
                jsr animate_player_left
                jmp _store_posx

_move_right     jsr can_move_right
                jsr animate_player_right
                jmp _store_posx

_move_up        jsr can_move_up
                jsr draw_player
                jsr animate_player_left
                jmp _post_move

_move_down      jsr can_move_down
                jsr draw_player
                jsr animate_player_right
                jmp _post_move

_move_none      jsr animate_player_reset

                rts

_post_move      jsr pickup_item
                jsr open_door
                jsr check_transition
                jmp _XIT

_store_posx     ldx POSX
                stx SPR(sprite_t.X,0)
                stx SPR(sprite_t.X,1)
                stx SPR(sprite_t.X,2)
                stx SPR(sprite_t.X,3)
                jmp _post_move

_XIT            rts
                .endproc


;======================================
; handle menu selection
;======================================
read_mainmenu_joystick .proc
                ldx DISPLAY_TYPE
                cpx #$00
                bne _XIT1

                ldx MENU_BTN_COUNT
                cpx #$00
                bne _delay_button

                ldx STRIG0
                cpx #$00
                beq _button_pressed

                ldx STICK0
                cpx #$0F
                beq _XIT1

                cpx #$0E
                beq _move_up

                cpx #$0D
                beq _move_down

                jmp _XIT1

_XIT1           rts

_move_up        ldx MENU_SELECTION
                cpx #$00
                beq _XIT1

                cpx #$03
                beq _XIT1

                cpx PREV_MENU_SELECT
                beq _1

                jsr play_mainmenu_item_sound

_1              .mvx MENU_SELECTION,PREV_MENU_SELECT

                dec MENU_SELECTION

                .mvx #$0A,MENU_BTN_COUNT

                jmp _XIT1

_move_down      ldx MENU_SELECTION
                cpx #$02
                beq _XIT1

                cpx #$03
                beq _XIT1

                cpx PREV_MENU_SELECT
                beq _2

                jsr play_mainmenu_item_sound

_2              .mvx MENU_SELECTION,PREV_MENU_SELECT

                inc MENU_SELECTION

                .mvx #$0A,MENU_BTN_COUNT

                jmp _XIT1

_delay_button   dec MENU_BTN_COUNT

                jmp _XIT1

_button_pressed ldx MENU_SELECTION
                cpx #$00
                beq _newgame

                cpx #$01
                beq _howtoplay

                cpx #$02
                beq _credits

                cpx #$03
                beq _mainmenu

                jmp _XIT1

_howtoplay      jsr display_howtoplay

                .mvx #$0A,MENU_BTN_COUNT
                jmp _XIT1

_newgame        jsr new_game

                .mvx #$0A,MENU_BTN_COUNT
                jmp _XIT1

_mainmenu       jsr display_mainmenu

                .mvx #$0A,MENU_BTN_COUNT
                jmp _XIT1

_credits        jsr display_credits

                .mvx #$0A,MENU_BTN_COUNT

                jmp _XIT1

                .endproc


;======================================
;
;======================================
reset_player    .proc
                .mvx PLAYER_RESET_POSY,POSY

                ldx PLAYER_RESET_POSX
                stx POSX

                stx SPR(sprite_t.X,0)
                stx SPR(sprite_t.X,1)
                stx SPR(sprite_t.X,2)

                ;;obsolete jsr clear_player_pmg

                rts
                .endproc
