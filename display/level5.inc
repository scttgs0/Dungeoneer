
level5_map      .namespace

intro           .byte $FF,$04,$66,$FF,$0A,$00,$98,$99,$8A,$8B,$AC,$AD,$8A,$8B,$98,$99
                .byte $00,$00,$F6,$F7,$FF,$08,$00,$FF,$08,$66,$FF,$04,$00,$28,$29,$10
                .byte $11,$0A,$0B,$00,$00,$2E,$2F,$1E,$1F,$24,$25,$18,$19,$08,$09,$00
                .byte $00,$02,$03,$28,$29,$FF,$04,$00,$FF,$08,$66,$FF,$0B,$00,$18,$19
                .byte $02,$03,$24,$25,$0E,$0F,$0A,$0B,$24,$25,$FF,$09,$00,$FF,$07,$66
                .byte $00,$62,$63,$FF,$0E,$00,$62,$63,$FF,$0C,$00,$62,$63,$00,$FF,$05
                .byte $66,$00,$00,$38,$38,$FF,$0E,$00,$38,$38,$FF,$0C,$00,$38,$38,$00
                .byte $00,$66,$66,$FE,$14,$36,$37,$00,$00,$FE,$03,$36,$37,$FF,$18,$00
                .byte $FE,$03,$36,$37,$FF,$04,$00,$6A,$FE,$02,$37,$36,$6B,$FF,$18,$00
                .byte $6A,$FE,$02,$37,$36,$6B,$FF,$05,$00,$6A,$36,$37,$6B,$FF,$1A,$00
                .byte $6A,$36,$37,$6B,$FF,$07,$00,$36,$37,$FF,$1C,$00,$36,$37,$FF,$08
                .byte $00,$36,$37,$FF,$1C,$00,$36,$37,$FF,$08,$00,$36,$37,$FF,$1C,$00
                .byte $36,$37,$FF,$04,$00

map             .byte $FF,$06,$00,$FE,$05,$10,$11,$10,$FF,$04,$5C,$FE,$05,$11,$10,$11
                .byte $08,$0B,$FF,$0C,$00,$10,$11,$02,$03,$FE,$03,$04,$05,$04,$FF,$03
                .byte $30,$37,$0A,$FE,$03,$04,$05,$0F,$05,$10,$11,$06,$07,$FF,$06,$00
                .byte $90,$91,$FE,$03,$10,$11,$06,$07,$00,$FF,$06,$31,$FF,$04,$30,$FF
                .byte $08,$31,$00,$FE,$04,$10,$11,$08,$0B,$90,$91,$06,$07,$04,$FF,$03
                .byte $9E,$08,$09,$31,$FF,$06,$92,$FF,$04,$30,$FF,$08,$92,$31,$0A,$0B
                .byte $04,$FF,$03,$9E,$10,$11,$06,$07,$90,$91,$06,$07,$FF,$0D,$92,$FF
                .byte $04,$30,$FF,$0F,$92,$10,$11,$06,$07,$5F,$FF,$24,$30,$5E,$00,$00
                .byte $5F,$FF,$0B,$30,$37,$FF,$18,$30,$5E,$00,$00,$90,$91,$08,$0B,$FF
                .byte $0D,$92,$FF,$04,$30,$FF,$0F,$92,$10,$11,$06,$07,$90,$91,$FE,$03
                .byte $10,$11,$08,$0B,$31,$FF,$06,$92,$FF,$03,$30,$37,$FF,$08,$92,$31
                .byte $FE,$04,$10,$11,$06,$07,$13,$0B,$FE,$02,$04,$05,$32,$33,$06,$07
                .byte $00,$FF,$06,$31,$FF,$04,$30,$FF,$08,$31,$00,$10,$11,$02,$03,$FE
                .byte $02,$04,$05,$08,$09,$13,$00,$2A,$2B,$00,$00,$FE,$05,$10,$11,$10
                .byte $FF,$04,$5D,$FE,$05,$11,$10,$11,$06,$07,$FF,$06,$00,$FF,$06,$13
                .byte $0A,$0B,$FE,$04,$04,$05,$00,$08,$09,$00,$00,$0A,$0B,$FE,$04,$04
                .byte $05,$00,$08,$09,$FF,$06,$00

attrs           .byte $07,$02,$FF,$FF,$01,$80,$40,$02,$81,$22,$03,$09,$22,$04,$B9,$21
                .byte $05,$31,$22,$06,$E1,$21,$09,$00,$00,$00

mape1           .byte $FF,$19,$13,$FF,$0F,$00,$13,$FF,$09,$00,$FE,$03,$2A,$2B,$FF,$08
                .byte $13,$FE,$04,$10,$11,$0A,$0B,$FF,$06,$00,$13,$FF,$03,$01,$FF,$0D
                .byte $13,$FF,$05,$01,$32,$33,$02,$03,$0F,$05,$04,$05,$0F,$05,$10,$11
                .byte $0A,$0B,$00,$01,$00,$00,$13,$FF,$12,$00,$01,$10,$11,$02,$03,$08
                .byte $09,$00,$01,$FF,$04,$00,$08,$09,$10,$11,$0A,$0B,$00,$00,$90,$91
                .byte $FE,$09,$10,$11,$02,$03,$08,$09,$FF,$03,$00,$FF,$03,$3F,$FF,$04
                .byte $00,$0A,$0B,$10,$11,$0C,$0D,$5F,$FE,$09,$05,$04,$05,$08,$09,$FF
                .byte $03,$00,$3F,$FF,$09,$00,$31,$10,$11,$06,$07,$5F,$FF,$0A,$30,$37
                .byte $FF,$08,$30,$36,$FF,$04,$00,$3F,$00,$20,$21,$00,$00,$3F,$00,$00
                .byte $31,$92,$10,$11,$06,$07,$90,$91,$FE,$09,$10,$11,$FF,$07,$00,$FF
                .byte $03,$3F,$FF,$03,$00,$31,$31,$92,$10,$11,$06,$07,$0A,$0B,$FE,$09
                .byte $04,$05,$10,$11,$FF,$09,$00,$31,$31,$92,$10,$11,$04,$05,$0A,$0B
                .byte $FF,$14,$31,$0A,$0B,$10,$11,$FE,$02,$00,$01,$00,$00,$31,$92,$10
                .byte $11,$04,$05,$0A,$0B,$31,$FF,$16,$92,$31,$0A,$0B,$FE,$04,$10,$11
                .byte $04,$05,$0A,$0B,$31,$FF,$1A,$92,$31,$0A,$0B,$FE,$03,$04,$05,$0A
                .byte $0B,$31,$31,$FF,$04,$92

mape1_attrs     .byte $07,$06,$FF,$FF,$FF,$FF,$FF,$FF,$06,$91,$21,$08,$1B,$06,$09,$00
                .byte $00,$00

mapw1           .byte $00,$00,$FE,$06,$10,$11,$0A,$FF,$0B,$13,$FE,$06,$10,$11,$0C,$0D
                .byte $00,$00,$10,$11,$3E,$03,$FE,$03,$04,$05,$32,$33,$06,$07,$FE,$05
                .byte $2A,$2B,$10,$11,$02,$03,$FE,$03,$04,$05,$10,$11,$06,$07,$00,$00
                .byte $10,$11,$3E,$FF,$07,$00,$FE,$08,$10,$11,$06,$07,$FF,$06,$00,$10
                .byte $11,$06,$07,$00,$00,$10,$11,$3E,$FF,$03,$00,$3E,$FF,$03,$00,$08
                .byte $3E,$FE,$02,$04,$05,$3F,$FE,$04,$05,$04,$05,$08,$09,$00,$00,$3F
                .byte $FF,$03,$00,$10,$11,$06,$07,$00,$00,$10,$11,$3E,$FF,$03,$00,$3E
                .byte $00,$2A,$2B,$00,$3E,$FF,$12,$00,$3F,$FF,$03,$00,$10,$11,$06,$07
                .byte $00,$00,$10,$11,$3E,$FF,$03,$00,$FF,$06,$3E,$FF,$08,$00,$FF,$06
                .byte $3E,$FF,$04,$00,$3F,$00,$00,$36,$30,$5E,$00,$07,$00,$00,$10,$11
                .byte $FF,$04,$00,$3E,$FF,$09,$00,$3F,$FF,$08,$00,$3E,$FF,$04,$00,$3F
                .byte $00,$00,$36,$30,$5E,$FF,$04,$00,$10,$11,$FF,$03,$00,$3E,$3E,$FF
                .byte $09,$00,$3F,$FF,$06,$00,$2A,$2B,$3E,$FF,$04,$00,$3F,$FF,$03,$00
                .byte $10,$11,$06,$07,$00,$00,$10,$11,$FF,$08,$00,$FE,$05,$10,$11,$11
                .byte $33,$32,$33,$10,$11,$FF,$07,$00,$31,$10,$11,$06,$07,$00,$00,$10
                .byte $11,$FF,$08,$00,$10,$11,$02,$03,$FE,$05,$04,$05,$10,$11,$FF,$06
                .byte $00,$31,$92,$10,$11,$06,$07,$00,$00,$FE,$06,$10,$11,$06,$07,$FE
                .byte $05,$2A,$2B,$FE,$06,$10,$11,$06,$07,$00,$00,$0A,$0B,$FE,$05,$04
                .byte $05,$08,$FF,$0B,$13,$0A,$0B,$FE,$04,$04,$05,$04,$05,$08,$09

mapw1_attrs     .byte $07,$18,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$04,$91,$21,$09,$4E,$52
                .byte $00

mapn1           .byte $FF,$06,$13,$FE,$0D,$10,$11,$0A,$FF,$08,$13,$00,$FE,$02,$2A,$2B
                .byte $32,$33,$02,$03,$FE,$0A,$04,$05,$32,$33,$06,$07,$FE,$02,$2A,$2B
                .byte $13,$13,$90,$91,$FE,$03,$10,$11,$06,$07,$FF,$04,$00,$FE,$02,$1C
                .byte $1D,$FF,$0C,$00,$FE,$04,$10,$11,$08,$0B,$90,$91,$06,$07,$04,$05
                .byte $0F,$05,$08,$09,$FF,$14,$31,$0A,$0B,$04,$05,$0F,$05,$10,$11,$06
                .byte $07,$90,$91,$06,$07,$2A,$2B,$36,$FF,$03,$30,$3F,$3F,$37,$FF,$06
                .byte $30,$37,$FF,$0D,$30,$36,$00,$00,$10,$11,$06,$07,$10,$11,$06,$07
                .byte $2A,$2B,$36,$FF,$0B,$30,$FF,$03,$3F,$FF,$07,$30,$37,$FF,$04,$30
                .byte $36,$00,$00,$10,$11,$06,$07,$10,$11,$06,$07,$2A,$2B,$36,$30,$30
                .byte $FF,$12,$92,$FF,$03,$31,$37,$30,$30,$36,$00,$00,$10,$11,$06,$07
                .byte $90,$91,$06,$07,$2A,$2B,$36,$37,$30,$92,$92,$FF,$13,$31,$FF,$03
                .byte $30,$36,$00,$00,$10,$11,$06,$07,$90,$91,$FE,$03,$10,$11,$08,$0B
                .byte $31,$FF,$13,$00,$FE,$04,$10,$11,$06,$07,$0A,$0B,$FE,$02,$04,$05
                .byte $10,$11,$06,$07,$FF,$06,$00,$31,$FF,$04,$30,$31,$FF,$08,$00,$10
                .byte $11,$02,$03,$FE,$02,$04,$05,$08,$09,$FF,$06,$00,$FE,$05,$10,$11
                .byte $10,$FF,$04,$5D,$FE,$05,$11,$10,$11,$06,$07,$FF,$0C,$00,$0A,$0B
                .byte $FE,$04,$04,$05,$00,$08,$09,$00,$00,$0A,$0B,$FE,$04,$04,$05,$00
                .byte $08,$09,$FF,$06,$00

mapn1_attrs     .byte $07,$10,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$05,$91,$21,$09,$68,$2E,$00

maps1           .byte $00,$01,$FF,$0D,$00,$10,$11,$FF,$04,$5C,$10,$11,$06,$07,$00,$00
                .byte $FE,$04,$10,$11,$0C,$0D,$FF,$04,$00,$FE,$08,$10,$11,$FF,$04,$30
                .byte $10,$11,$06,$07,$10,$11,$02,$03,$04,$05,$0F,$05,$04,$05,$10,$11
                .byte $0C,$0D,$00,$00,$10,$11,$02,$03,$FE,$02,$04,$05,$0F,$FE,$03,$05
                .byte $04,$05,$08,$09,$00,$00,$10,$11,$06,$07,$10,$11,$06,$07,$00,$50
                .byte $51,$FF,$03,$00,$10,$11,$06,$07,$00,$00,$10,$11,$06,$07,$FF,$10
                .byte $00,$10,$11,$06,$07,$0A,$0B,$10,$11,$0C,$0D,$00,$00,$10,$11,$02
                .byte $03,$08,$09,$00,$00,$10,$11,$06,$07,$00,$00,$FE,$08,$10,$11,$06
                .byte $07,$92,$92,$10,$11,$06,$07,$00,$00,$10,$11,$06,$07,$FF,$04,$00
                .byte $10,$11,$06,$07,$00,$00,$10,$11,$02,$03,$FE,$02,$04,$05,$FF,$03
                .byte $9E,$FE,$02,$05,$04,$05,$08,$09,$92,$92,$10,$11,$06,$07,$00,$00
                .byte $10,$11,$06,$07,$FF,$03,$00,$5F,$32,$33,$06,$07,$00,$00,$10,$11
                .byte $06,$07,$FF,$10,$92,$10,$11,$06,$07,$00,$00,$10,$11,$06,$07,$FF
                .byte $03,$00,$5F,$32,$33,$06,$07,$00,$00,$FE,$0B,$10,$11,$FE,$02,$34
                .byte $35,$10,$11,$06,$07,$FF,$04,$00,$10,$11,$06,$07,$00,$00,$0A,$0B
                .byte $FE,$0A,$04,$05,$14,$15,$16,$17,$10,$11,$06,$07,$FF,$04,$00,$10
                .byte $11,$06,$07,$FF,$1C,$00,$10,$11,$06,$07,$FF,$04,$00,$FE,$11,$10
                .byte $11,$06,$07,$FF,$04,$00,$0A,$0B,$FE,$10,$04,$05,$08,$09,$00,$00
                .byte $00

maps1_attrs     .byte $03,$91,$21,$06,$59,$22,$09,$00,$00,$00

maps1w1         .byte $FF,$0F,$92,$FF,$16,$31,$92,$10,$11,$FF,$0E,$92,$31,$FE,$0B,$1C
                .byte $1D,$31,$10,$11,$FF,$03,$92,$FF,$0C,$31,$FF,$0F,$00,$FE,$03,$28
                .byte $29,$18,$19,$10,$11,$92,$92,$FF,$03,$31,$FE,$02,$1B,$00,$00,$00
                .byte $31,$31,$92,$31,$FE,$0B,$1C,$1D,$31,$10,$11,$92,$18,$19,$FF,$06
                .byte $31,$FF,$03,$00,$31,$92,$92,$FF,$16,$31,$92,$10,$11,$92,$18,$19
                .byte $2A,$2B,$00,$00,$2A,$2B,$31,$FF,$03,$00,$31,$FF,$16,$92,$FE,$02
                .byte $10,$11,$92,$18,$19,$2A,$2B,$00,$00,$2A,$2B,$31,$FF,$04,$00,$FF
                .byte $16,$31,$0A,$0B,$04,$5E,$92,$18,$19,$2A,$2B,$00,$00,$2A,$2B,$31
                .byte $FF,$08,$00,$36,$FF,$14,$30,$5E,$92,$18,$19,$FF,$06,$31,$FF,$0A
                .byte $00,$FF,$11,$31,$00,$00,$10,$11,$92,$92,$FF,$03,$31,$FE,$02,$1B
                .byte $00,$FF,$06,$00,$FF,$04,$31,$FF,$10,$92,$31,$FE,$02,$10,$11,$FF
                .byte $03,$92,$FF,$0C,$31,$FF,$14,$92,$31,$0A,$0B,$9E,$9E,$FF,$24,$92
                .byte $31,$31,$92,$92

maps1w1_attrs   .byte $07,$12,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                .byte $FF,$FF,$FF,$FF,$04,$31,$22,$09,$9C,$28,$00

                .endnamespace
