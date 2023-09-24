
;======================================
; sets up the interrupt chain
;======================================
enable_interrupts
                ldy #<vvblkd_interrupt
                ldx #>vvblkd_interrupt
                lda #$07
                jsr SETVBV


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; setup VVBLKD interrupt chain
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vvblkd_interrupt .proc
                .mwx vvblkd_init,VVBLKD
                rts
                .endproc


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; first vblank initialization
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vvblkd_init     .proc
                pha
                txa
                pha

                .mvx #$01,VBLANK_LOADED
                .mwx vvblkd_chain,VVBLKD

                pla
                tax
                pla
                jmp XITVBV

                .endproc


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; method chains for VVBLKD interupts
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vvblkd_chain    .proc
                pha
                txa
                pha
                tya
                pha

                ldx SCREEN_LOADED
                cpx #$01
                bne _XIT

                ldx VBLANK_SKIP
                cpx #$01
                beq _XIT

                .mvx #$00,SKIP_FRAME

                jsr exit_level

                ldx SKIP_FRAME
                cpx #$01
                beq _XIT

                jsr read_game_joystick
                jsr read_mainmenu_joystick

                jsr animate_tilesprite

                jsr render_mainmenu
                jsr render_intro
                jsr render_gameover
                jsr render_player_death
                jsr render_enemy

_XIT            pla
                tay
                pla
                tax
                pla
                jmp XITVBV

                .endproc
