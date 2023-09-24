
; frequency,audio control,sustain,silence

mainmenu_music  .byte $79,$A4,$0A,$14
                .byte $79,$A3,$0A,$14
                .byte $79,$A2,$0A,$14
                .byte $79,$A1,$0A,$14
                .byte $80,$A4,$0A,$14
                .byte $80,$A3,$0A,$14
                .byte $80,$A2,$0A,$14
                .byte $80,$A1,$0A,$14
                .byte $00

mainmenu_item_sfx
                .byte $16,$A3,$05,$03
                .byte $0C,$A3,$05,$03
                .byte $02,$A3,$05,$03
                .byte $00

intro_music     .byte $79,$A2,$05,$0A
                .byte $72,$A2,$05,$0A
                .byte $79,$A2,$05,$0A
                .byte $66,$A2,$05,$0A
                .byte $00

wingame_music   .byte $A2,$A2,$08,$09
                .byte $A2,$A2,$05,$06
                .byte $A2,$A2,$05,$06
                .byte $A2,$A2,$0A,$0A
                .byte $90,$A2,$0A,$0A
                .byte $A2,$A2,$0A,$0A
                .byte $90,$A2,$0A,$0A
                .byte $80,$A2,$14,$1E
                .byte $01,$A2,$14,$31
                .byte $00

background_music
                .byte $F3,$A2,$05,$0A
                .byte $F3,$A1,$05,$0A
                .byte $F3,$A1,$05,$0A
                .byte $C1,$A2,$05,$0A
                .byte $C1,$A1,$05,$0A
                .byte $C1,$A1,$05,$0A
                .byte $A2,$A2,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $99,$A2,$05,$0A
                .byte $99,$A1,$05,$0A
                .byte $99,$A1,$05,$0A
                .byte $A2,$A2,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $C1,$A2,$05,$0A
                .byte $C1,$A1,$05,$0A
                .byte $C1,$A1,$05,$0A
                .byte $F3,$A2,$05,$0A
                .byte $F3,$A1,$05,$0A
                .byte $F3,$A1,$05,$0A
                .byte $C1,$A2,$05,$0A
                .byte $C1,$A1,$05,$0A
                .byte $C1,$A1,$05,$0A
                .byte $A2,$A2,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $99,$A2,$05,$0A
                .byte $99,$A1,$05,$0A
                .byte $99,$A1,$05,$0A
                .byte $A2,$A2,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $A2,$A1,$05,$32

                .byte $E6,$A2,$05,$0A
                .byte $E6,$A1,$05,$0A
                .byte $E6,$A1,$05,$0A
                .byte $C1,$A2,$05,$0A
                .byte $C1,$A1,$05,$0A
                .byte $C1,$A1,$05,$0A
                .byte $A2,$A2,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $99,$A2,$05,$0A
                .byte $99,$A1,$05,$0A
                .byte $99,$A1,$05,$0A
                .byte $A2,$A2,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $A2,$A1,$05,$0A
                .byte $88,$A2,$05,$0A
                .byte $88,$A1,$05,$0A
                .byte $88,$A1,$05,$0A
                .byte $00
                
key_pickup_sfx  .byte $23,$A3,$0A,$03
                .byte $19,$A3,$0A,$03
                .byte $0F,$A3,$0A,$03
                .byte $00
                
chest_pickup_sfx
                .byte $23,$A3,$0A,$03
                .byte $0F,$A3,$0A,$03
                .byte $23,$A3,$0A,$03
                .byte $0F,$A3,$0A,$03
                .byte $00
                
coin_pickup_sfx .byte $19,$A3,$0A,$03
                .byte $02,$A3,$0A,$03
                .byte $19,$A3,$0A,$03
                .byte $02,$A3,$0A,$03
                .byte $00

door_open_sfx   .byte $64,$84,$01,$01
                .byte $5A,$84,$01,$01
                .byte $50,$84,$01,$01
                .byte $46,$84,$01,$01
                .byte $3C,$84,$01,$01
                .byte $32,$84,$01,$01
                .byte $28,$84,$01,$01
                .byte $1E,$84,$01,$01
                .byte $14,$84,$01,$01
                .byte $0A,$84,$01,$01
                .byte $00
                
exit_level_sfx  .byte $79,$A4,$03,$03
                .byte $60,$A4,$03,$03
                .byte $51,$A4,$03,$03
                .byte $3C,$A4,$03,$03
                .byte $00
                
gameover_sfx    .byte $01,$A2,$0A,$1E
                .byte $9C,$A2,$0A,$1E
                .byte $A4,$A2,$0A,$1E
                .byte $C3,$A2,$0A,$1E
                .byte $F7,$84,$0F,$1E
                .byte $00
                
death_sfx       .byte $64,$83,$0A,$04
                .byte $96,$83,$0A,$04
                .byte $C8,$83,$0A,$04
                .byte $FA,$83,$0A,$04
                .byte $00

gain_life_sfx   .byte $79,$A2,$05,$05
                .byte $60,$A2,$05,$05
                .byte $51,$A2,$05,$05
                .byte $79,$A2,$05,$05
                .byte $60,$A2,$05,$05
                .byte $51,$A2,$05,$05
                .byte $79,$A2,$05,$05
                .byte $60,$A2,$05,$05
                .byte $51,$A2,$05,$05
                .byte $00
