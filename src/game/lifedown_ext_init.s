.segment	"DATA4"

; ----------------------------------------------------------------------
lifedown_ext_starts:
	.byte	$76, $50
.if	.defined(SMB2)
	.byte	$65, $50
.elseif	.defined(ANN)
	.byte	$D5, $70
.endif
	.byte	$75, $B0
	.byte	$00, $00
lifedown_ext_starts_end:
; ----------------------------------
	.export	lifedown_ext_init
lifedown_ext_init:
        ldy     #(lifedown_ext_starts_end-lifedown_ext_starts)-1
        : ; for (start of starts) {
                lda     lifedown_ext_starts, y
                sta     lifedown_starts, y

                dey
                bpl     :-
        ; }

        rts
