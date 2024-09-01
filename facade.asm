
;======================================
;
;--------------------------------------
; preserve      A, X, Y
;======================================
CheckCollision  .proc
                pha
                phx
                phy

                ldx #1                  ; Given: SP02_Y=112
_nextBomb       lda zpBombDrop,X        ; A=112
                beq _nextPlayer

                cmp #132
                bcs _withinRange
                bra _nextPlayer

_withinRange    sec
                sbc #132                ; A=8
                lsr             ; /2    ; A=4
                lsr             ; /4    ; A=2
                lsr             ; /8    ; A=1
                sta zpTemp1             ; zpTemp1=1 (row)

                lda PlayerPosX,X
                lsr             ; /4
                lsr
                sta zpTemp2             ; (column)

                lda #<CANYON
                sta zpSource
                lda #>CANYON
                sta zpSource+1

                ldy zpTemp1
_nextRow        beq _checkRock

                lda zpSource
                clc
                adc #40
                sta zpSource
                bcc _1

                inc zpSource+1

_1              dey
                bra _nextRow

_checkRock      ldy zpTemp2
                lda (zpSource),Y
                beq _nextPlayer

                cmp #4
                bcs _nextPlayer

                sta P2PF,X

                stz zpTemp1
                txa
                asl                     ; *2
                rol zpTemp1
                tay

                lda zpSource
                stz zpTemp2+1
                clc
                adc zpTemp2
                sta P2PFaddr,Y          ; low-byte

                lda zpSource+1
                adc #$00
                sta P2PFaddr+1,Y        ; high-byte

_nextPlayer     dex
                bpl _nextBomb

                ply
                plx
                pla
                rts
                .endproc
