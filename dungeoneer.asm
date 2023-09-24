
; Dungeoneer - A simple game in Atari 8-bit assembly

                    .include "system_atari8.equ"
                    .include "zeropage.equ"
                    .include "game.equ"
                    .include "dungeoneer.mac"


;--------------------------------------
; Start of code
;--------------------------------------
                * = $0600
;--------------------------------------

START
;    main setup
                jsr initialize_zeropage
                jsr init_screen
                jsr setup_colors
                jsr enable_interrupts
                jsr setup_pmg

;   delay initialization until after first vblank
_delay1         ldx VBLANK_LOADED
                cpx #$01
                bne _delay1

                jsr display_mainmenu

;   main loop
_main           jsr sequence_sound_handler
                jsr transition_map_handler
                jsr restore_door_state
                jsr restore_coin_state
                jsr restore_key_state
                jsr check_enemy_player_collision

                .mvx #$00,ATRACT

                jmp _main


;--------------------------------------
;--------------------------------------

                .include "dlist.asm"


;--------------------------------------
;--------------------------------------
                * = $2000
;--------------------------------------

                .include "level.asm"
                .include "pmg.asm"
                .include "enemy.asm"
                .include "joystick.asm"
                .include "util.asm"
                .include "item.asm"
                .include "interrupt.asm"
                .include "sound.asm"
                .include "map.asm"
                .include "transition.asm"
                .include "tile.asm"

                .include "data/player.inc"
                .include "data/enemy.inc"


;--------------------------------------
;--------------------------------------
                *= $5000
;--------------------------------------

                .include "data/game_tilesetA.inc"
                .include "data/game_tilesetB.inc"
                .include "data/game_tilesetC.inc"

                .include "data/menu_tilesetA.inc"
                .include "data/menu_tilesetB.inc"
                .include "data/menu_tilesetC.inc"

                .include "data/sound.inc"

                .include "display/gameover.inc"
                .include "display/mainmenu.inc"
                .include "display/howtoplay.inc"
                .include "display/credits.inc"
                .include "display/level1.inc"
                .include "display/level2.inc"
                .include "display/level3.inc"
                .include "display/level4.inc"
                .include "display/level5.inc"
                .include "display/level6.inc"
                .include "display/congrats.inc"
