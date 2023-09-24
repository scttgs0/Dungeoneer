
;======================================
; setup display list for screen
;======================================
setup_game_screen .proc
                .mwx game_dlist,SDLSTL

                rts

;--------------------------------------

game_dlist      .byte AEMPTY8,AEMPTY8,AEMPTY7
                .byte ALMS+ADLI+5
                    .addr ITEM_SCREEN
                .byte ALMS+ADLI+5
                    .addr GAME_SCREEN
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5
                .byte AVB+AJMP
                    .addr game_dlist

                .endproc


;======================================
; setup game over / menu screen
;======================================
setup_menu_screen .proc
                .mwx menu_dlist,SDLSTL

                rts

;--------------------------------------

menu_dlist      .byte AEMPTY8,AEMPTY8,AEMPTY8
                .byte ALMS+5
                    .addr MENU_SCREEN
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5
                .byte AVB+AJMP
                    .addr menu_dlist

                .endproc


;======================================
; setup game over / menu screen
;======================================
setup_mainmenu_screen .proc
                .mwx mainmenu_dlist,SDLSTL

                rts

;--------------------------------------

mainmenu_dlist  .byte AEMPTY8,AEMPTY8,AEMPTY8
                .byte ALMS+5
                    .addr MENU_SCREEN
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5,ADLI+5
                .byte ADLI+5,ADLI+5
                .byte AVB+AJMP
                    .addr mainmenu_dlist

                .endproc
