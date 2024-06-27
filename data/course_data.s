.include	"../inc/engine/course_flags.i"

.if	.defined(VS)
	.segment	"COURSEDATA"
.endif
	.export	courses_actor_castle_1, courses_actor_castle_2
	.export courses_actor_castle_3, courses_actor_castle_4
	.export courses_actor_castle_5, courses_actor_castle_6
.if	.defined(VS_SMB)
	.export courses_actor_castle_7, courses_actor_castle_8
.endif
courses_actor_castle_1:
	.if	.defined(SMB)
		.byte	$76, $DD, $BB, $4C, $EA, $1D, $1B, $CC, $56, $5D
		.byte	$16, $9D, $C6, $1D, $36, $9D, $C9, $1D, $04, $DB
		.byte	$49, $1D, $84, $1B, $C9, $5D, $88, $95, $0F, $08
		.byte	$30, $4C
	.elseif	.defined(VS_SMB)
		.byte	$2A, $A9, $6B, $0C, $CB, $0C, $15, $9C, $89, $1C
		.byte	$CC, $1D, $09, $9D, $6B, $0C, $F5, $1C, $6B, $A9
		.byte	$AB, $0C, $DB, $29, $48, $9D, $9B, $0C, $5B, $8C
		.byte	$A5, $1C, $49, $9D, $79, $1D, $09, $9D, $6B, $0C
		.byte	$C9, $1F, $3B, $8C, $4B, $8C, $88, $15, $B9, $1C
		.byte	$19, $9D, $30, $CC
	.endif
	.byte	$78, $2D, $A6, $28, $90, $B5
	.byte	COURSE_ACTORS_END

courses_actor_castle_2:
	.byte	$0F, $03
	.byte	$56, $1B
	.byte	$C9, $1B
	.byte	$0F, $07
	.byte	$36, $1B
	.byte	$AA, $1B
	.byte	$48, $95

	.if	.defined(VS_SMB)
		.byte	$1B, $8C
	.endif

	.byte	$0F, $0A, $2A, $1B, $5B, $0C, $78, $2D, $90, $B5
	.byte	COURSE_ACTORS_END

courses_actor_castle_3:
	.if	.defined(SMB)
		.byte	$0B, $8C, $4B, $4C, $77, $5F, $EB, $0C, $BD, $DB
		.byte	$19, $9D, $75, $1D, $7D, $5B, $D9, $1D, $3D, $DD
		.byte	$99, $1D, $26, $9D, $5A, $2B, $8A, $2C, $CA, $1B
		.byte	$20, $95, $7B, $5C, $DB, $4C, $1B, $CC, $3B, $CC
		.byte	$78, $2D, $A6, $28
	.elseif	.defined(VS_SMB)
		.byte	$76, $DD, $BB, $4C, $EA, $1D, $1B, $CC, $56, $5D
		.byte	$16, $9D, $C6, $1D, $36, $9D, $C9, $1D, $04, $DB
		.byte	$49, $1D, $84, $1B, $C9, $5D, $88, $95, $2B, $80
		.byte	$78, $AD
	.endif
	.byte	$90, $B5
	.byte	COURSE_ACTORS_END

courses_actor_castle_4:
	.byte	$0B, $8C
	.if	.defined(SMB)
		.word	$1D3B
		.word	$1D8B
	.elseif	.defined(VS_SMB)
		.word	$1D3A
		.word	$1D8A
	.endif
	.byte	$AB, $0C
	.if	.defined(SMB)
		.byte	$DB, $1D
	.elseif	.defined(VS_SMB)
		.byte	$DA, $1B
	.endif
	.if	.defined(SMB)
		.byte	$0F, $03
	.elseif	.defined(VS_SMB)
		.byte	$3B, $8C, $55, $1B, $FB, $0C
	.endif
	.if	.defined(SMB)
		.word	$1D65
	.elseif	.defined(VS_SMB)
		.word	$9D65
	.endif

	.byte	$6B, $1B, $05, $9D, $0B, $1B, $05, $9B, $0B
	.byte	$1D, $8B, $0C

	.if	.defined(VS_SMB)
		.byte	$E8, $03
	.endif

	.byte	$1B, $8C, $70, $15, $7B, $0C, $DB, $0C
	.if	.defined(SMB)
		.word	$080F
	.elseif	.defined(VS_SMB)
		.word	$070F
	.endif

	.if	.defined(VS_SMB)
		.byte	$18, $03, $30, $8C
	.endif

	.byte	$78, $2D, $A6, $28, $90, $B5
	.byte	COURSE_ACTORS_END

courses_actor_castle_5:
	.byte	$27, $A9, $4B, $0C, $68, $29, $0F, $06, $77, $1B
	.byte	$0F, $0B, $60, $15, $4B, $8C, $78, $2D, $90, $B5
	.byte	COURSE_ACTORS_END

courses_actor_castle_6:
	.byte	$0F, $03, $8E, $65, $E1, $BB, $38, $6D, $A8, $3E
	.byte	$E5, $E7, $0F, $08, $0B, $02, $2B, $02, $5E, $65
	.byte	$E1, $BB, $0E, $DB, $0E, $BB, $8E, $DB, $0E, $FE
	.byte	$65, $EC, $0F, $0D, $4E, $65, $E1, $0F, $0E, $4E
	.byte	$02, $E0, $0F, $10, $FE, $E5, $E1, $1B, $85, $7B
	.byte	$0C, $5B, $95, $78, $2D, $90, $B5
	.byte	COURSE_ACTORS_END

.if	.defined(VS_SMB)
courses_actor_castle_7:
	.byte	$35, $9D, $55, $9B, $C9, $1B, $59, $9D, $45, $9B
	.byte	$C5, $1B, $45, $9B, $89, $1D, $F0, $15, $59, $9D
	.byte	$0F, $08, $78, $2D, $96, $28, $90, $B5
	.byte	COURSE_ACTORS_END

courses_actor_castle_8:
	.byte	$0B, $8C, $4B, $0C, $77, $1F, $EB, $0C, $BD, $9B
	.byte	$19, $9D, $75, $1D, $7D, $5B, $D9, $1D, $3D, $DD
	.byte	$99, $1D, $26, $9D, $5A, $2B, $8A, $2C, $CA, $1B
	.byte	$20, $95, $7B, $5C, $DB, $0C, $1B, $CC, $3B, $CC
	.byte	$78, $2D, $A6, $28, $90, $B5
	.byte	COURSE_ACTORS_END

.endif

	.export courses_actor_overworld_1, courses_actor_overworld_2
	.export courses_actor_overworld_3, courses_actor_overworld_4
	.export courses_actor_overworld_5, courses_actor_overworld_6
	.export courses_actor_overworld_7, courses_actor_overworld_8
	.export courses_actor_overworld_9, courses_actor_overworld_10
	.export courses_actor_overworld_11, courses_actor_overworld_12
	.export courses_actor_overworld_13, courses_actor_overworld_14
	.export courses_actor_overworld_15, courses_actor_overworld_16
	.export courses_actor_overworld_17, courses_actor_overworld_18
	.export courses_actor_overworld_19, courses_actor_overworld_20
	.export courses_actor_overworld_21, courses_actor_overworld_22
.if	.defined(VS_SMB)
	.export courses_actor_overworld_23, courses_actor_overworld_24
.endif
courses_actor_overworld_1:
	.if	.defined(SMB)
		.byte	$A5, $86
	.elseif	.defined(VS_SMB)
		.byte	$A2, $90
	.endif
	.byte	$E4, $28, $18, $A8, $45, $83, $69, $03

	.if	.defined(VS_SMB)
		.byte	$A1, $0E
	.endif

	.byte	$C6, $29

	.if	.defined(VS_SMB)
		.byte	$04, $8F
	.endif

	.if	.defined(SMB)
		.word	$839B
	.elseif	.defined(VS_SMB)
		.word	$039B
	.endif

	.if	.defined(VS_SMB)
		.word	$0EF1
	.endif

	.byte	$16, $A4, $88, $24, $E9, $28, $05, $A8, $7B, $28
	.if	.defined(SMB)
		.byte	$24, $8F, $C8, $03, $E8, $03, $46, $A8
	.elseif	.defined(VS_SMB)
		.byte	$D9, $03, $24, $8F, $64, $0F, $E8, $0E
		.byte	$18, $8E, $46, $28
	.endif
	.byte	$85, $24, $C8, $24
	.byte	COURSE_ACTORS_END

courses_actor_overworld_2:
	.byte	$EB, $8E, $0F, $03, $FB, $05, $17, $85, $DB, $8E
	.byte	$0F, $07, $57, $05, $7B, $05, $9B, $80, $2B, $85
	.byte	$FB, $05, $0F, $0B, $1B, $05, $9B, $05
	.byte	COURSE_ACTORS_END

courses_actor_overworld_3:
	.byte	$2E, $C2, $66, $E2, $11, $0F, $07, $02, $11, $0F

	.if	.defined(SMB)
		.byte	$0C, $12
	.elseif	.defined(VS_SMB)
		.byte	$0B, $17, $10, $72
	.endif

	.byte	$11
	.byte	COURSE_ACTORS_END

courses_actor_overworld_4:
	.byte	$0E, $C2, $A8, $AB, $00, $BB, $8E, $6B, $82, $DE
	.byte	$00, $A0, $33, $86, $43, $06, $3E, $B4, $A0

	.if	.defined(VS_SMB)
		.byte	$3B, $00
	.endif

	.byte	$CB, $02, $0F, $07, $7E, $42, $A6, $83, $02, $0F
	.byte	$0A, $3B, $02, $CB, $37, $0F, $0C
	.if	.defined(SMB)
		.byte	$E3, $0E
	.elseif	.defined(VS_SMB)
		.byte	$A6, $06, $C4, $06, $E2, $06
	.endif
	.byte	COURSE_ACTORS_END

courses_actor_overworld_5:
	.if	.defined(SMB)
		.byte	$9B
	.elseif	.defined(VS_SMB)
		.byte	$9A
	.endif
	.byte	$8E
	.if	.defined(SMB)
		.byte	$CA
	.elseif	.defined(VS_SMB)
		.byte	$BA
	.endif
	.byte	$0E, $EE, $42, $44, $5B
	.if	.defined(SMB)
		.byte	$86
	.elseif	.defined(VS_SMB)
		.byte	$80
	.endif
	.byte	$80, $B8, $1B, $80, $50, $BA
	.if	.defined(SMB)
		.byte	$10, $B7
	.elseif	.defined(VS_SMB)
		.byte	$3B, $83
	.endif
	.byte	$5B
	.if	.defined(SMB)
		.byte	$00
	.elseif	.defined(VS_SMB)
		.byte	$0E
	.endif
	.byte	$17, $85, $4B, $05, $FE, $34, $40
	.if	.defined(SMB)
		.byte	$B7
	.elseif	.defined(VS_SMB)
		.byte	$79
	.endif
	.byte	$86
	.if	.defined(SMB)
		.byte	$C6
	.elseif	.defined(VS_SMB)
		.byte	$C4
	.endif
	.byte	$06, $5B, $80, $83, $00, $D0, $38

	.if	.defined(VS_SMB)
		.byte	$EB, $0E
	.endif

	.byte	$5B, $8E, $8A, $0E, $A6, $00, $BB, $0E, $C5
	.if	.defined(SMB)
		.byte	$80, $F3, $00
	.elseif	.defined(VS_SMB)
		.byte	$86, $D4, $06, $F2, $06
	.endif
	.byte	COURSE_ACTORS_END

courses_actor_overworld_6:
	.byte	$1E, $C2, $00, $6B, $06, $8B, $86, $63, $B7
	.if	.defined(SMB)
		.byte	$0F, $05
	.elseif	.defined(VS_SMB)
		.byte	$2B, $B7
	.endif
	.byte	$03
	.if	.defined(SMB)
		.byte	$06
	.elseif	.defined(VS_SMB)
		.byte	$86
	.endif
	.byte	$23, $06, $4B, $B7, $BB, $00, $5B, $B7, $FB, $37
	.byte	$3B, $B7, $0F
	.if	.defined(SMB)
		.byte	$0B, $1B
	.elseif	.defined(VS_SMB)
		.byte	$0A, $8B
	.endif
	.byte	$37

	.if	.defined(VS_SMB)
		.byte	$1B, $B7
	.endif

	.byte	COURSE_ACTORS_END

courses_actor_overworld_7:
	.if	.defined(SMB)
		.byte	$2B, $D7, $E3, $03, $C2, $86, $E2, $06, $76, $A5
		.byte	$A3, $8F, $03, $86, $2B, $57, $68, $28, $E9, $28
		.byte	$E5, $83, $24, $8F, $36, $A8, $5B, $03
	.elseif	.defined(VS_SMB)
		.byte	$E6, $A9, $57, $A8, $B5, $24, $19, $A4, $66, $28
		.byte	$A2, $0F, $95, $8F, $9D, $A8, $0B, $97, $09, $A9
		.byte	$55, $24, $A9, $24, $BB, $17, $DB, $83, $16, $A9
		.byte	$24, $8F, $65, $0F
	.endif
	.byte	COURSE_ACTORS_END

courses_actor_overworld_8:
	.byte	$0F, $02
	.if	.defined(SMB)
		.byte	$78, $40, $48, $CE, $F8, $C3, $F8, $C3, $0F, $07
		.byte	$7B, $43, $C6, $D0, $0F, $8A, $C8, $50
	.elseif	.defined(VS_SMB)
		.byte	$28, $10, $E6, $03, $D8, $90, $0F, $05, $85, $0F
		.byte	$78, $83, $C8, $10, $18, $83, $58, $83, $F7, $90
		.byte	$0F, $0C, $76, $0E, $B6, $8E, $0F, $10, $73, $0F
	.endif
	.byte	COURSE_ACTORS_END

courses_actor_overworld_9:
	.if	.defined(SMB)
		.byte	$85
	.elseif	.defined(VS_SMB)
		.byte	$95
	.endif
	.byte	$86, $0B, $80, $1B, $00, $DB, $37, $77
	.if	.defined(SMB)
		.byte	$80
	.elseif	.defined(VS_SMB)
		.byte	$8E
	.endif
	.byte	$EB, $37, $FE, $2B, $20, $2B, $80, $7B, $38, $AB, $B8
	.byte	$77, $86, $FE, $42, $20, $49, $86, $8B, $06, $9B, $80
	.byte	$7B, $8E, $5B, $B7, $9B, $0E, $BB, $0E, $9B, $80

courses_actor_overworld_10:
	.byte	COURSE_ACTORS_END

courses_actor_overworld_11:
	.byte	$0B, $80
	.if	.defined(SMB)
		.byte	$60, $38
	.elseif	.defined(VS_SMB)
		.byte	$6B, $06
	.endif
	.byte	$10, $B8, $C0, $3B, $DB, $8E
	.if	.defined(SMB)
		.byte	$40, $B8, $F0, $38
	.elseif	.defined(VS_SMB)
		.byte	$1B, $82, $3B, $02, $5B, $02, $CB, $02, $EB, $02
	.endif
	.byte	$7B, $8E
	.if	.defined(SMB)
		.byte	$A0, $B8
	.elseif	.defined(VS_SMB)
		.byte	$AB, $82, $BB, $02, $CB, $02
	.endif
	.byte	$C0, $B8, $FB, $00, $A0, $B8, $30, $BB, $EE, $42
	.byte	$88, $0F, $0B, $2B, $0E, $67, $0E
	.byte	COURSE_ACTORS_END

courses_actor_overworld_12:
	.byte	$0A, $AA, $0E, $28, $2A, $0E, $31, $88
	.byte	COURSE_ACTORS_END

courses_actor_overworld_13:
	.byte	$C7, $83, $D7, $03, $42, $8F, $7A, $03, $05, $A4
	.byte	$78, $24, $A6, $25, $E4, $25, $4B, $83, $E3, $03
	.byte	$05, $A4, $89, $24, $B5, $24, $09, $A4, $65, $24
	.byte	$C9, $24, $0F, $08, $85, $25
	.byte	COURSE_ACTORS_END

courses_actor_overworld_14:
	.byte	$CD, $A5, $B5, $A8, $07, $A8, $76, $28, $CC, $25
	.byte	$65, $A4, $A9, $24, $E5, $24, $19, $A4, $0F, $07
	.byte	$95, $28, $E6, $24, $19, $A4, $D7, $29, $16, $A9
	.byte	$58, $29, $97, $29
	.byte	COURSE_ACTORS_END

courses_actor_overworld_15:
	.byte	$0F, $02, $02, $11, $0F, $07, $02, $11

	.if	.defined(VS_SMB)
		.byte	$0F, $09, $92, $0F, $B8, $86, $C7, $06, $E2, $0F
	.endif
	.byte	COURSE_ACTORS_END

courses_actor_overworld_16:
	.byte	COURSE_ACTORS_END

courses_actor_overworld_17:
	.byte	$2B, $82, $AB, $38, $DE, $42, $E2, $1B, $B8, $EB
	.byte	$3B, $DB, $80, $8B, $B8, $1B, $82, $FB, $B8, $7B
	.byte	$80, $FB, $3C, $5B, $BC, $7B, $B8, $1B, $8E, $CB
	.byte	$0E, $1B, $8E, $0F, $0D, $2B, $3B, $BB, $B8, $EB
	.byte	$82, $4B, $B8, $BB, $38, $3B, $B7, $BB, $02, $0F
	.byte	$13, $1B, $00, $CB, $80, $6B, $BC
	.byte	COURSE_ACTORS_END

courses_actor_overworld_18:
	.byte	$7B, $80, $AE, $00, $80, $8B, $8E, $E8, $05, $F9 
	.byte	$86, $17, $86, $16, $85, $4E, $2B, $80, $AB, $8E
	.byte	$87, $85, $C3, $05, $8B, $82, $9B, $02, $AB
	.if	.defined(SMB)
		.byte	$02
	.elseif	.defined(VS_SMB)
		.byte	$0E
	.endif
	.byte	$BB, $86, $CB, $06, $D3, $03, $3B, $8E, $6B, $0E
	.byte	$A7, $8E
	.byte	COURSE_ACTORS_END

courses_actor_overworld_19:
	.byte	$29, $8E, $52, $11, $83, $0E, $0F, $03
	.if	.defined(SMB)
		.byte	$9B
	.elseif	.defined(VS_SMB)
		.byte	$3B
	.endif
	.byte	$0E

	.if	.defined(VS_SMB)
		.byte	$9B, $0E, $DB, $06, $EB, $06
	.endif

	.byte	$2B, $8E, $5B, $0E, $CB, $8E, $FB, $0E, $FB, $82
	.byte	$9B, $82, $BB, $02, $FE, $42, $E8, $BB, $8E, $0F
	.byte	$0A, $AB, $0E, $CB, $0E, $F9, $0E, $88, $86, $A6
	.byte	$06, $DB, $02, $B6, $8E
	.byte	COURSE_ACTORS_END

courses_actor_overworld_20:
	.byte	$AB, $CE, $DE, $42, $C0, $CB, $CE, $5B, $8E, $1B
	.byte	$CE, $4B, $85, $67, $45, $0F, $07, $2B, $00, $7B
	.byte	$85, $97, $05, $0F, $0A

	.if	.defined(VS_SMB)
		.byte	$74, $06, $82, $06
	.endif

	.byte	$92
	.if	.defined(SMB)
		.byte	$02
	.elseif	.defined(VS_SMB)
		.byte	$06
	.endif
	.byte	COURSE_ACTORS_END

courses_actor_overworld_21:
	.byte	$0A, $AA, $0E, $24, $4A, $1E, $23, $AA
	.byte	COURSE_ACTORS_END

courses_actor_overworld_22:
	.if	.defined(SMB)
		.byte	$1B, $80, $BB, $38, $4B, $BC, $EB, $3B, $0F, $04
		.byte	$2B, $00, $AB, $38, $EB, $00, $CB, $8E, $FB, $80
		.byte	$AB, $B8, $6B, $80, $FB, $3C, $9B, $BB, $5B, $BC
		.byte	$FB, $00, $6B, $B8, $FB, $38
	.elseif	.defined(VS_SMB)
		.byte	$15, $8E, $9B, $06, $8B, $83, $0F, $04, $2B, $3B
		.byte	$AB, $0E, $EB, $0E, $99, $8E, $DB, $B7, $4B, $8E
		.byte	$6B, $80, $BB, $3C, $4B, $BB, $1B, $BC, $CB, $00
		.byte	$AB, $83, $EB, $BB, $A6, $8E, $1B, $83, $9B, $37
		.byte	$F4, $0E, $87, $86, $94, $06, $B2, $06
	.endif
	.byte	COURSE_ACTORS_END

.if	.defined(VS_SMB)
courses_actor_overworld_23:
	.byte	$E3, $83, $C2, $86, $E2, $06, $76, $A5, $FB, $03
	.byte	$A3, $8F, $03, $86, $68, $28, $E9, $28, $E5, $83
	.byte	$24, $8F, $36, $A8
	.byte	COURSE_ACTORS_END

courses_actor_overworld_24:
	.byte	$0F, $02, $78, $40, $48, $CE, $F8, $C3, $F8, $C3
	.byte	$0F, $07, $7B, $43, $C6, $D0, $0F, $8A, $C8, $50
	.byte	COURSE_ACTORS_END
.endif

	.export	courses_actor_underground_1
	.export courses_actor_underground_2
	.export courses_actor_underground_3
courses_actor_underground_1:
	.byte	$0B, $86, $1A, $06, $DB
	.if	.defined(SMB)
		.byte	$06
	.elseif	.defined(VS_SMB)
		.byte	$00
	.endif
	.byte	$DE, $C2, $02, $F0, $3B, $BB, $80, $EB, $06, $0B
	.byte	$86, $93, $06, $F0, $39
	.if	.defined(SMB)
		.byte	$0F, $06
	.elseif	.defined(VS_SMB)
		.byte	$9B, $B7
	.endif
	.byte	$60, $B8, $1B, $86, $A0, $B9, $B7, $27, $BD, $27
	.byte	$2B, $83, $A1, $26, $A9, $26, $EE, $25, $0B, $27
	.byte	$B4
	.byte	COURSE_ACTORS_END

courses_actor_underground_2:
	.byte	$0F, $02, $1E, $2F, $60

	.if	.defined(VS_SMB)
		.byte	$26, $00
	.endif

	.byte	$E0, $3A, $A5, $A7, $DB, $80, $3B, $82, $8B, $02
	.byte	$FE, $42, $68, $70, $BB, $25, $A7, $2C, $27, $B2
	.byte	$26, $B9, $26, $9B, $80, $A8
	.if	.defined(SMB)
		.byte	$82
	.elseif .defined(VS_SMB)
		.byte	$86
	.endif
	.byte	$B5, $27, $BC, $27
	.if	.defined(SMB)
		.byte	$B0
	.elseif	.defined(VS_SMB)
		.byte	$9B, $83
	.endif
	.byte	$BB

	.if	.defined(VS_SMB)
		.byte	$03
	.endif

	.byte	$3B, $82, $87, $34, $EE, $25, $6B
	.byte	COURSE_ACTORS_END

courses_actor_underground_3:
	.byte	$1E, $A5, $0A, $2E, $28, $27, $2E, $33, $C7, $0F
	.byte	$03, $1E, $40, $07, $2E, $30, $E7, $0F, $05, $1E
	.byte	$24, $44, $0F, $07, $1E, $22, $6A, $2E, $23, $AB
	.byte	$0F, $09, $1E, $41, $68, $1E, $2A, $8A, $2E, $23
	.byte	$A2, $2E, $32, $EA
	.byte	COURSE_ACTORS_END

	.export courses_actor_water_1
	.export courses_actor_water_2
	.export courses_actor_water_3
.if	.defined(VS_SMB)
	.export courses_actor_water_4
.endif
courses_actor_water_1:
	.byte	$3B, $87, $66, $27, $CC, $27, $EE, $31, $87, $EE
	.byte	$23, $A7, $3B, $87, $DB, $07
	.byte	COURSE_ACTORS_END

courses_actor_water_2:
	.byte	$0F, $01, $2E, $25
	.if	.defined(SMB)
		.byte	$2B
	.elseif	.defined(VS_SMB)
		.byte	$0B
	.endif
	.byte	$2E, $25
	.if	.defined(SMB)
		.byte	$4B, $4E, $25, $CB, $6B, $07, $97, $47, $E9, $87
		.byte	$47, $C7, $7A, $07, $D6, $C7, $78, $07, $38, $87
		.byte	$AB, $47, $E3, $07, $9B, $87, $0F, $09, $68, $47
	.elseif	.defined(VS_SMB)
		.byte	$CB, $5B, $07, $AB, $07, $C9, $87, $69, $87, $BA
		.byte	$07, $FB, $87, $65, $A7, $6A, $27, $A6, $A7, $AC
		.byte	$27, $1B, $87, $88, $07, $7B, $87, $0F, $0B, $14
		.byte	$27, $19, $27, $77, $07, $F8, $07
	.endif
	.byte	$DB
	.if	.defined(SMB)
		.byte	$C7, $3B, $C7
	.elseif	.defined(VS_SMB)
		.byte	$87, $B9, $87
	.endif
	.byte	COURSE_ACTORS_END

courses_actor_water_3:
	.byte	$47, $9B, $CB, $07, $FA, $1D, $86, $9B, $3A, $87
	.byte	$56, $07, $88, $1B, $07, $9D, $2E, $65, $F0
	.byte	COURSE_ACTORS_END

.if	.defined(VS_SMB)
courses_actor_water_4:
	.byte	$0F, $01, $2E, $25, $2B, $2E, $25, $4B, $4E, $25
	.byte	$CB, $6B, $07, $97, $47, $E9, $87, $47, $C7, $7A
	.byte	$07, $D6, $C7, $78, $07, $38, $87, $AB, $47, $E3
	.byte	$07, $9B, $87, $0F, $09, $68, $47, $DB, $C7, $3B
	.byte	$C7
	.byte	COURSE_ACTORS_END
.endif
; ----------------
	.export	courses_data_castle_1, courses_data_castle_2
	.export courses_data_castle_3, courses_data_castle_4
	.export courses_data_castle_5, courses_data_castle_6
.if	.defined(VS_SMB)
	.export courses_data_castle_7, courses_data_castle_8
.endif
courses_data_castle_1:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.word	$3205
	.word	$3306
	.if	.defined(SMB)
		.word	$3407
		.word	$03CE
		.word	$51DC
		.word	$07EE
		.word	$E073
		.word	$0A74
		.word	$067E
		.word	$0A9E
		.word	$06CE
		.word	$00E4
		.word	$0AE8
		.word	$0AFE
		.word	$892E
		.word	$0B4E
		.word	$0A54
		.word	$8A14
		.word	$0AC4
		.word	$8A34
		.word	$067E
		.word	$0AC7
		.word	$E001
		.word	$0A02
		.word	$0A47
		.word	$6081
		.word	$0A82
		.word	$0AC7
		.word	$870E
		.word	$027E
		.word	$02A7
		.word	$02B3
		.word	$02D7
		.word	$02E3
		.word	$8207
		.word	$0213
		.word	$063E
		.word	$027E
		.word	$07AE
	.elseif	.defined(VS_SMB)
		.word	$3307
		.word	$033E
		.word	$504C
		.word	$074E
		.word	$3157
		.word	$036E
		.word	$527C
		.word	$079E
		.word	$0AFE
		.word	$897E
		.word	$0A9E
		.word	$07EE
		.word	$34F7
		.word	$8A13
		.word	$0A3E
		.word	$096E
		.word	$0A87
		.word	$029E
		.word	$04C6
		.word	$0ACA
		.word	$62F7
		.word	$8A07
		.word	$6108
		.word	$6217
		.word	$0A1E
		.word	$064E
		.word	$0A5E
		.word	$067E
		.word	$0A8E
		.word	$06AE
		.word	$07BE
		.word	$0AF3
		.word	$861E
		.word	$0A2E
		.word	$3784
		.word	$3693
		.word	$45A2
		.word	$891E
		.word	$0A46
		.word	$0A6E
		.word	$60B7
		.word	$60DB
		.word	$60F7
		.word	$E01B
		.word	$6037
		.word	$097E
		.word	$0B8E
		.word	$0AA3
		.word	$04FE
		.word	$BB17
		.word	$0A47
		.word	$0A77
		.word	$02BE
		.word	$0ACE
		.word	$8A07
		.word	$3117
		.word	$3163
		.word	$34A7
		.word	$0AC7
		.word	$B113
		.word	$094E
		.word	$8A1E
		.word	$027E
		.word	$3497
		.word	$0AB7
		.word	$0ACE
		.word	$02DE
		.word	$61D8
		.word	$62F7
		.word	$03FE
		.word	$B407
		.word	$0A17
		.word	$6247
		.word	$0A4E
		.word	$035E
		.word	$6151
		.word	$6267
		.word	$3477
		.word	$62B7
		.word	$61C1
		.word	$60DA
		.word	$61E9
		.word	$62F8
	.endif

	.word	$0AFE
	.word	$C40D

	.if	.defined(VS_SMB)
		.word	$5201
		.word	$5211
		.word	$5221
		.word	$5231
		.word	$5241
		.word	$5251
		.word	$5261
	.endif

	.word	$43CD
	.word	$09CE
	.word	$0BDE
	.word	$42DD
	.word	$02FE
	.word	$C75D
	.byte	COURSE_DATA_END

courses_data_castle_2:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.word	$3205
	.word	$3306
	.word	$3407
	.word	$0A5E
	.word	$6468
	.word	$6498
	.word	$64A8
	.word	$06CE
	.word	$02FE
	.word	$010D
	.word	$0E1E
	.word	$027E
	.word	$6394
	.word	$63B4
	.word	$63D4
	.word	$63F4
	.word	$E314
	.word	$0E2E
	.word	$025E
	.word	$3564
	.word	$7288
	.word	$0EBE
	.word	$040D
	.word	$02AE
	.word	$08CE
	.word	$4BCD
	.word	$02FE
	.word	$050D
	.word	$3168
	.word	$0A7E
	.word	$3196
	.word	$63A9
	.word	$33A8
	.word	$30D5
	.word	$02EE
	.word	$62E6
	.word	$61F4
	.word	$B104
	.word	$3F08
	.word	$3344
	.word	$6394
	.word	$31A4
	.word	$31E4
	.word	$BF04
	.word	$3F08
	.word	$BF04
	.word	$3F08
	.word	$4BCD
	.word	$E403
	.word	$030E

	.if	.defined(VS_SMB)
		.word	$011C
	.endif

	.word	$012E

	.if	.defined(VS_SMB)
		.word	$014C
		.word	$007C
	.endif

	.word	$067E
	.word	$02BE
	.word	$06DE
	.word	$0AFE
	.word	$C40D
	.word	$43CD
	.word	$09CE
	.word	$0BDE
	.word	$42DD
	.word	$02FE
	.word	$C75D
	.byte	COURSE_DATA_END

courses_data_castle_3:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.word	$3205
	.word	$3306
	.word	$3407
	.if	.defined(SMB)
		.word	$00FE
		.word	$B127
		.word	$3265
		.word	$0A75
		.word	$0071
		.word	$31B7
		.word	$E408
		.word	$6418
		.word	$041E
		.word	$3B57
		.word	$0ABB
		.word	$8A17
		.word	$3A27
		.word	$0A73
		.word	$0A7B
		.word	$0AD7
		.word	$3AE7
		.word	$8A3B
		.word	$0A97
		.word	$08FE
		.word	$8A24
		.word	$002E
		.word	$403E
		.word	$6438
		.word	$006F
		.word	$009F
		.word	$43BE
		.word	$0AC8
		.word	$63C9
		.word	$07CE
		.word	$07FE
		.word	$812E
		.word	$4266
		.word	$426A
		.word	$0A79
		.word	$00BE
		.word	$64C8
		.word	$64F8
		.word	$E408
		.word	$072E
		.word	$037E
		.word	$079E
		.word	$03BE
		.word	$07DE
		.word	$0AFE
		.word	$A503
		.word	$440D
	.elseif	.defined(VS_SMB)
		.word	$03CE
		.word	$51DC
		.word	$07EE
		.word	$E073
		.word	$0A74
		.word	$067E
		.word	$0A9E
		.word	$06CE
		.word	$00E4
		.word	$0AE8
		.word	$0AFE
		.word	$892E
		.word	$0B4E
		.word	$0A54
		.word	$8A14
		.word	$0AC4
		.word	$8A34
		.word	$067E
		.word	$0AC7
		.word	$E001
		.word	$0A02
		.word	$0A47
		.word	$6081
		.word	$0A82
		.word	$0AC7
		.word	$870E
		.word	$027E
		.word	$02A7
		.word	$02B3
		.word	$02D7
		.word	$02E3
		.word	$8207
		.word	$0213
		.word	$063E
		.word	$0A4E
		.word	$066E
		.word	$027E
		.word	$07AE
		.word	$0ADE
		.word	$61E1
		.word	$07EE
		.word	$0AFE
		.word	$C40D
	.endif
	.word	$43CD
	.word	$09CE

	.if	.defined(VS_SMB)
		.word	$0BDE
	.endif

	.word	$42DD

	.if	.defined(SMB)
		.word	$0BDE
	.endif

	.word	$02FE
	.word	$C75D
	.byte	COURSE_DATA_END

courses_data_castle_4:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.word	$3205
	.word	$3306
	.word	$3407

	.if	.defined(VS_SMB)
		.word	$03BE
		.word	$01CC
		.word	$07DE
	.endif

	.word	$06FE
	.word	$810C
	.if	.defined(SMB)
		.word	$0A39
	.elseif	.defined(VS_SMB)
		.word	$0A38
	.endif
	.word	$015C
	.if	.defined(SMB)
		.word	$0A89
	.elseif	.defined(VS_SMB)
		.word	$0A88
	.endif
	.word	$01AC
	.if	.defined(SMB)
		.word	$0AD9
		.word	$01FC
		.word	$832E
	.elseif	.defined(VS_SMB)
		.word	$0AD8
		.word	$0AEE
		.word	$860E
	.endif

	.if	.defined(VS_SMB)
		.word	$0A2E
		.word	$034E
		.word	$0A53
		.word	$0A6E
		.word	$038E
	.endif

	.word	$01A7
	.if	.defined(SMB)
		.word	$00B7
		.word	$01C7
	.elseif	.defined(VS_SMB)
		.word	$01B7
		.word	$00C7
	.endif
	.word	$0ADE
	.word	$02FE
	.word	$834E
	.word	$325A
	.word	$0A63
	.word	$0A69
	.word	$027E

	.if	.defined(VS_SMB)
		.word	$0A8E
		.word	$029E
		.word	$0ACE
		.word	$02DE
	.endif
	
	.word	$03EE
	.word	$32FA
	.word	$8A03
	.word	$0A09
	.word	$021E

	.if	.defined(VS_SMB)
		.word	$0A2E
		.word	$023E
		.word	$0ACE
		.word	$02DE
	.endif

	.word	$03EE
	.word	$32FA
	.word	$8A03
	.word	$0A09
	.word	$4214
	.word	$021E

	.if	.defined(VS_SMB)
		.word	$0A2E
		.word	$023E
	.endif

	.word	$0A7E
	.word	$079E
	.word	$0AFE
	.word	$862E
	.word	$0A5E
	.word	$068E
	.word	$0ABE
	.word	$07EE
	.word	$833E
	.word	$075E

	.if	.defined(VS_SMB)
		.word	$037E
		.word	$018C
		.word	$079E
		.word	$03AE
		.word	$00BC
		.word	$07BE
		.word	$03CE
		.word	$00DC
		.word	$07DE
	.endif

	.word	$0AFE
	.word	$C40D
	.word	$5241
	.word	$5251
	.word	$43CD
	.word	$09CE
	.word	$0BDE
	.word	$42DD
	.word	$02FE
	.word	$C75D
	.byte	COURSE_DATA_END

courses_data_castle_5:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.word	$3205
	.word	$3306
	.word	$3407
	.word	$0AFE
	.word	$86AE
	.word	$07BE
	.word	$02FE
	.word	$020D
	.word	$3227
	.word	$6146
	.word	$6255
	.word	$0E5E
	.word	$821E
	.word	$3C68
	.word	$3A74
	.word	$4B7D
	.word	$8E5E
	.word	$4B7D
	.word	$827E
	.word	$6284
	.word	$6194
	.word	$31A4
	.word	$4BBD
	.word	$06CE
	.word	$02FE
	.word	$060D
	.word	$3134
	.word	$0A3E
	.word	$3264
	.word	$0A75
	.word	$617B
	.word	$33A4
	.word	$02AE
	.word	$0EDE
	.word	$823E
	.word	$3264
	.word	$3278
	.word	$36B4
	.word	$36C8
	.word	$4BDD
	.word	$B244
	.word	$3258
	.word	$6394
	.word	$3EA4
	.word	$30BA
	.word	$61C9
	.word	$06CE
	.word	$4BDD
	.word	$86CE
	.word	$4BDD
	.if	.defined(SMB)
		.word	$02FE
	.elseif	.defined(VS_SMB)
		.word	$0AFE
	.endif
	.word	$862E
	.if	.defined(SMB)
		.word	$025E
	.elseif	.defined(VS_SMB)
		.word	$0A5E
	.endif
	.word	$067E
	.if	.defined(SMB)
		.word	$02FE
	.elseif	.defined(VS_SMB)
		.word	$0AFE
	.endif
	.word	$861E
	.if	.defined(SMB)
		.word	$023E
	.elseif	.defined(VS_SMB)
		.word	$0A3E
	.endif
	.word	$065E
	.if	.defined(SMB)
		.word	$027E
	.elseif	.defined(VS_SMB)
		.word	$0A6E
	.endif
	.word	$069E

	.if	.defined(VS_SMB)
		.word	$0ABE
		.word	$06DE
	.endif

	.word	$0AFE
	.word	$C40D
	.word	$43CD
	.word	$09CE
	.word	$0BDE
	.word	$42DD
	.word	$02FE
	.word	$C75D
	.byte	COURSE_DATA_END

courses_data_castle_6:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_6|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.word	$3205
	.word	$3306
	.word	$3407
	.word	$0A5E
	.word	$02AE
	.word	$010D
	.word	$7339
	.word	$030D
	.word	$7B39
	.word	$4B4D
	.word	$06DE
	.word	$8A1E
	.word	$06AE
	.word	$33C4
	.word	$FE16
	.word	$77A5
	.word	$02FE
	.word	$82FE
	.word	$070D
	.word	$7339
	.word	$74A8
	.word	$4BED
	.word	$FB49
	.word	$74E8
	.word	$0AFE
	.word	$822E
	.if	.defined(SMB)
		.word	$0267
	.elseif	.defined(VS_SMB)
		.word	$0266
	.endif
	.word	$7A84
	.word	$3187
	.word	$0B0D
	.word	$02FE
	.word	$0C0D
	.word	$7339
	.word	$065E
	.word	$76C6
	.word	$FF45
	.word	$0ABE
	.word	$48DD
	.word	$06FE
	.word	$CB3D
	.word	$7E46
	.word	$4AAD
	.word	$82FE
	.word	$F339
	.word	$7BA9
	.word	$8A4E
	.word	$079E
	.word	$0AFE
	.word	$C40D

	.if	.defined(VS_SMB)
		.word	$5201
		.word	$5211
		.word	$5221
		.word	$5231
		.word	$5241
		.word	$5251
		.word	$5261
		.word	$5271
		.word	$5281
		.word	$5291
		.word	$52A1
		.word	$52B1
	.endif

	.word	$43CD
	.word	$09CE
	.word	$0BDE
	.word	$42DD
	.word	$02FE
	.word	$C75D
	.byte	COURSE_DATA_END

.if	.defined(VS_SMB)
courses_data_castle_7:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.word	$3205
	.word	$3306
	.word	$3407
	.word	$8A33
	.word	$063E
	.word	$0A4E
	.word	$067E
	.word	$0A9E
	.word	$06CE
	.word	$00D3
	.word	$0AEE
	.word	$861E
	.word	$072E
	.word	$0A53
	.word	$067E
	.word	$0A8E
	.word	$029E
	.word	$0AC7
	.word	$37D7
	.word	$8A5E
	.word	$0A57
	.word	$02BE
	.word	$60DA
	.word	$61E9
	.word	$62F8
	.word	$07FE
	.word	$BF07
	.word	$0A43
	.word	$0AC3
	.word	$B707
	.word	$0A43
	.word	$0A87
	.word	$3197
	.word	$0AAE
	.word	$06FE
	.word	$8A2E
	.word	$063E
	.word	$0A57
	.word	$0A6E
	.word	$067E
	.word	$0AAE
	.word	$02BE
	.word	$E307
	.word	$6347
	.word	$6387
	.word	$07AE
	.word	$0AFE
	.word	$C40D
	.word	$43CD
	.word	$09CE
	.word	$0BDE
	.word	$42DD
	.word	$02FE
	.word	$C75D
	.byte	COURSE_DATA_END

courses_data_castle_8:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.word	$3205
	.word	$3306
	.word	$3407
	.word	$00FE
	.word	$B127
	.word	$3265
	.word	$0A75
	.word	$0071
	.word	$31B7
	.word	$E408
	.word	$6418
	.word	$041E
	.word	$3B57
	.word	$0ABB
	.word	$00DC
	.word	$8A17
	.word	$3127
	.word	$3757
	.word	$0A73
	.word	$0A7B
	.word	$0AD7
	.word	$3AE7
	.word	$800C
	.word	$0A3B
	.word	$0A97
	.word	$08FE
	.word	$8A24
	.word	$002E
	.word	$403E
	.word	$6438
	.word	$006F
	.word	$009F
	.word	$43BE
	.word	$0AC8
	.word	$63C9
	.word	$07CE
	.word	$07FE
	.word	$802E
	.word	$014E
	.word	$4266
	.word	$426A
	.word	$0A79
	.word	$009E
	.word	$0ABE
	.word	$64C8
	.word	$64F8
	.word	$E408
	.word	$0A0E
	.word	$062E
	.word	$0A7E
	.word	$068E
	.word	$0A9E
	.word	$06BE
	.word	$0ACE
	.word	$06EE
	.word	$0AFE
	.word	$A503
	.word	$440D
	.word	$43CD
	.word	$09CE
	.word	$42DD
	.word	$0BDE
	.word	$02FE
	.word	$C75D
	.byte	COURSE_DATA_END
.endif

	.export courses_data_overworld_1, courses_data_overworld_2
	.export courses_data_overworld_3, courses_data_overworld_4
	.export courses_data_overworld_5, courses_data_overworld_6
	.export courses_data_overworld_7, courses_data_overworld_8
	.export courses_data_overworld_9, courses_data_overworld_10
	.export courses_data_overworld_11, courses_data_overworld_12
	.export courses_data_overworld_13, courses_data_overworld_14
	.export courses_data_overworld_15, courses_data_overworld_16
	.export courses_data_overworld_17, courses_data_overworld_18
	.export courses_data_overworld_19, courses_data_overworld_20
	.export courses_data_overworld_21, courses_data_overworld_22
.if	.defined(VS_SMB)
	.export courses_data_overworld_23, courses_data_overworld_24
.endif
courses_data_overworld_1:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_NONE)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_F|(COURSE_BG_CLOUD_VAL<<12)|(COURSE_FG_MASK_0_VAL<<8))

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_6|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_6)
	.word	(COURSE_DATA_POS_Y_B|COURSE_DATA_POS_X_E|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_F|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_2)

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_7)
		.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_5|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_5|COURSE_DATA_NEW_PAGE|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_6|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.endif
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_A|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_3)
	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_B|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_4)
		.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_E|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_10)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_B|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
		.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_F|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_9)
	.endif
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_F|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_6)

	.word	(COURSE_DATA_POS_Y_1|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_A)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_4|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_3)
	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_1|COURSE_DATA_POS_X_7|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_4)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_1|COURSE_DATA_POS_X_8|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.endif
	.word	(COURSE_DATA_POS_Y_0|COURSE_DATA_POS_X_8|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_B|COURSE_DATA_POS_X_1|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_16)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_B|COURSE_DATA_POS_X_1|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_15)
	.endif
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_2|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_5|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_6|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_9|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_A|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_2|COURSE_DATA_POS_X_D|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_1|COURSE_DATA_POS_X_E|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)

	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_2|COURSE_OBJ_A_PULLEY|COURSE_OBJ_DIM_8)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_2|COURSE_OBJ_B_ROPE_PLAT|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_4|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_8|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_9|COURSE_OBJ_B_ROPE_PLAT|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_A|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_8|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_2|COURSE_DATA_POS_X_9|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_B|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_C|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_C|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_D|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_B|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
		.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_7|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_12)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_7|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_6)
		.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_E|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_5)
	.endif

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_9|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PULLEY|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_9|COURSE_OBJ_B_ROPE_PLAT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_D|COURSE_OBJ_B_ROPE_PLAT|COURSE_OBJ_DIM_5)

	.if	.defined(SMB)
		.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_F|(COURSE_BG_CLOUD_VAL<<12)|(COURSE_FG_MASK_1_VAL<<8))
		.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_7|COURSE_DATA_NEW_PAGE|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_POLE)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|(COURSE_BG_CLOUD_VAL<<12)|(COURSE_FG_MASK_1_VAL<<8))
		.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_8|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_POLE)
	.endif
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_9|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL)<<8)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_C|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_1)

	.byte	COURSE_DATA_END

courses_data_overworld_2:
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_7|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL<<8))
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_F|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_NONE_VAL<<8))

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_4|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL<<8))

	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_NONE_VAL<<8))
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_5|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)
	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_C|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_6)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_C|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_8)
	.endif
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_8)

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_ITEM_A)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_3|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.endif

	.if	.defined(SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_5|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_5|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.endif
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_8|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_9|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_A|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_B|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_E|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL<<8))

	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_NONE_VAL<<8))
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_6|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_7|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL<<8))
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_D|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_NONE_VAL<<8))
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_F|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL<<8))
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_A|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_NONE_VAL<<8))
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_8)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_3|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_8)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_4|COURSE_OBJ_C_BLOCK_ITEM_A)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_C|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_3|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL<<8))

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_0|COURSE_PAGE_D_A)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_5|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_NONE_VAL<<8))
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_8|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_B|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL<<8))

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_COIN)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_F|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_NONE_VAL<<8))

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_4|(COURSE_BG_NONE_VAL<<12)|(COURSE_FG_MASK_0_VAL<<8))
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_6|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_8|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_A|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_1)
	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_C|COURSE_OBJ_FLOORROW|COURSE_OBJ_DIM_2)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORROW|COURSE_OBJ_DIM_1)
	.endif
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_F|(COURSE_BG_TREE_FENCE_VAL<<12)|(COURSE_FG_MASK_1_VAL<<8))

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_POLE)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_B|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_WALLS_VAL<<8))
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_E|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_1)

	.byte	COURSE_DATA_END

courses_data_overworld_3:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.endif

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_6|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_FG_NONE_VAL<<8))

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_5|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_9|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_9|COURSE_OBJ_C_BLOCK_Q_A)

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_9|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_A|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_1)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_D|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_DATA_NEW_PAGE|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.endif

	.if	.defined(SMB)
		.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_0|COURSE_PAGE_D_4)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_0|COURSE_OBJ_C_BLOCK_Q_B)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_B)
	.endif
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_0|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_2|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_2|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_E|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_A|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_BLOCK_QLO|COURSE_OBJ_DIM_4)

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_C|COURSE_OBJ_C_HIDDEN_ONE_UP)
	.endif

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_7|COURSE_DATA_NEW_PAGE|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_9|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_7|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_A|COURSE_DOWNPIPE_MASK|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_7|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_BLOCK_QLO|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_4|COURSE_OBJ_A_BLOCK_QHI|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_4|COURSE_OBJ_C_BLOCK_Q_A)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_5|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_5|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_7|COURSE_OBJ_A_BLOCK_QLO|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_E|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_9|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.endif

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_E|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_0|COURSE_PAGE_D_D)
	.if	.defined(SMB)
		.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_9)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_6)
	.endif

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_6|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_8|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_8)
	.endif

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_C_BLOCK_COIN)
	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_E|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_SWARM_C)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_POLE)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_5|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)

	.byte	COURSE_DATA_END

courses_data_overworld_4:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_NONE)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_A|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_A|COURSE_DOWNPIPE_MASK|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_7|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_8|COURSE_OBJ_C_BLOCK_COIN)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_8|COURSE_OBJ_C_BLOCK_Q_C)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_9|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_E|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.endif

	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_0|COURSE_OBJ_FLOORROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_5|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_4|COURSE_OBJ_C_BLOCK_ITEM_A)
	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_8|COURSE_OBJ_PIPE_VERT_A|COURSE_DOWNPIPE_MASK|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_E|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_FLOORROW|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_5|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.endif

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_A|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_D|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_4)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_E|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.endif

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_1|COURSE_OBJ_C_BLOCK_ITEM_B)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_2|COURSE_OBJ_C_BLOCK_Q_C)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_4|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_6|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
	.endif

	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_7|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_6)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_E|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3) 

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_9|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_F|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_F|COURSE_OBJ_FLOORROW|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_3|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_7|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_9)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_B|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_6)

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_7|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_A|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_C|COURSE_OBJ_C_BLOCK_ITEM_C)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_D|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_D|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_F|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_1|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_5|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_8|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_9|COURSE_OBJ_PIPE_VERT_A|COURSE_DOWNPIPE_MASK|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_0|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_7|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_OBJ_FLOORROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)
	.endif

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.endif
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_5|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_D|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_7|COURSE_DATA_NEW_PAGE|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_9|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_B|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_C|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_6)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_7)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_E|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_8)

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_F|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_8)
	.endif

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_8|COURSE_DATA_NEW_PAGE|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_POLE)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_C|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)

	.byte	COURSE_DATA_END

courses_data_overworld_5:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_6|COURSE_OBJ_E_FG_MASK|(COURSE_DATA_BG_COL_OVERWORLD_VAL+(COURSE_DATA_FG_MAX+1))<<8|($2)<<12)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_3|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_6|COURSE_OBJ_C_BLOCK_Q_A)
	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_A|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_A|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.endif

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_C|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_D|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)
	.endif

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_6|COURSE_OBJ_PIPE_VERT_A|COURSE_DOWNPIPE_MASK|COURSE_OBJ_DIM_4)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_A|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
	.endif

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_D|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
		.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_0|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_3|COURSE_OBJ_C_BLOCK_COIN)
		.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.endif

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_9|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_9|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_5)
	.endif
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_D|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
	.endif

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.endif
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_9|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_D|COURSE_OBJ_A_BRIDGE_HI|COURSE_OBJ_DIM_8)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_D|COURSE_OBJ_A_WATERHOLE|COURSE_OBJ_DIM_8)

	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_HIDDEN_ONE_UP)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_5|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_6|COURSE_OBJ_A_WATERHOLE|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_8|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_9|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_A|COURSE_OBJ_C_BLOCK_ITEM_C)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_B|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_C|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_E|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
	.endif

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)

	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_9|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
	.endif

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_F|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_F|COURSE_OBJ_C_BLOCK_Q_B)
	.endif
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_F|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_11)

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_2|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_5|COURSE_OBJ_C_BLOCK_Q_A)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_6|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_1|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_2|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_3|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_4|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_5|COURSE_OBJ_C_BLOCK_Q_A)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_6|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_7|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_8|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_9|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_A|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_C|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.endif
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_E|COURSE_OBJ_C_SPRING)

	.if	.defined(SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_4)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_1|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_F|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_6)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.endif
	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_1|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_3|COURSE_OBJ_C_BLOCK_ITEM_B)
	.if	.defined(SMB)
		.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_8|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_6)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_E|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)

		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_6|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_7|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_8|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_8|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_B|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_B|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_C|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_C_BLOCK_Q_A)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_D|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_D|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)

		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_OBJ_C_BLOCK_COIN)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_8|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_7|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_6)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_D|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)

		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_6|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_7|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_8|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_8|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_B|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_B|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_C|COURSE_OBJ_C_BLOCK_Q_A)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_D|COURSE_OBJ_C_BLOCK_Q_B)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_D|COURSE_OBJ_C_BLOCK_Q_B)

		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_5)
		.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_9|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_1)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_A|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)
	.endif

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_E|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_F|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_6)

	.if	.defined(SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_5)
	.endif
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_7|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_9)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_8|COURSE_DATA_NEW_PAGE|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_POLE)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_C|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)

	.byte	COURSE_DATA_END

courses_data_overworld_6:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_4|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_5|COURSE_OBJ_C_BLOCK_Q_A)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_6|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_7|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_C|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_9|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_A|COURSE_DOWNPIPE_MASK|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_POS_Y_6|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_HIDDEN_ONE_UP)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_5|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_D|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)

	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_C_BLOCK_Q_A)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_8)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_A)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_1|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_7)
	.endif
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_6|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_B|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_E|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_E|COURSE_OBJ_C_BLOCK_COIN)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_5|COURSE_OBJ_C_BLOCK_ITEM_C)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_A|COURSE_OBJ_C_BLOCK_Q_B)
	.if	.defined(SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_D|COURSE_OBJ_C_BLOCK_Q_A)
	.elseif	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_D|COURSE_OBJ_C_BLOCK_Q_B)
	.endif
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_D|COURSE_OBJ_C_BLOCK_Q_B)

	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_6|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_9|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_0|COURSE_DATA_NEW_PAGE|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_1|COURSE_OBJ_A_BLOCK_QHI|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_1|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_6|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_E|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_F|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_1)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_8|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_9|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_B|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_C|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_E|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_1)

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_8|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_A|COURSE_OBJ_C_BLOCK_Q_B)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_B|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_5|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_9)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_POLE)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_A|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)
	.byte	COURSE_DATA_END

courses_data_overworld_7:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_UNDERGROUND)
.endif
	.word	$260F
	.word	$10FE
	.if	.defined(SMB)
		.word	$932A
		.word	$1787
		.word	$14A3
		.word	$42B2
		.word	$920A
		.word	$4019
		.word	$1436
		.word	$4150
		.word	$1682
		.word	$932B
		.word	$4124
		.word	$14BB
		.word	$00B8
		.word	$43C2
		.word	$13C3
		.word	$941B
		.word	$1267
		.word	$15C4
		.word	$C153
		.word	$41D2
		.word	$C112
		.word	$1329
		.word	$1785
		.word	$921B
		.word	$421A
		.word	$1347
		.word	$4183
		.word	$13A7
		.word	$910E
		.word	$63A7
		.word	$63B7
		.word	$65C5
		.word	$65D5
		.word	$4ADD
		.word	$67E3
		.word	$67F3
		.word	$C18D
		.word	$42AE
		.word	$20DF
	.elseif	.defined(VS_SMB)
		.word	$938B
		.word	$0BA9
		.word	$921B
		.word	$4114
		.word	$128B
		.word	$40B6
		.word	$16CC
		.word	$11CF
		.word	$40D6
		.word	$12EB
		.word	$952F
		.word	$14B7
		.word	$97B7
		.word	$45C6
		.word	$922B
		.word	$0B39
		.word	$4172
		.word	$00A7
		.word	$42D7
		.word	$951B
		.word	$1397
		.word	$956C
		.word	$116F
		.word	$40A2
		.word	$15BF
		.word	$40C2
		.word	$9F0B
		.word	$4462
		.word	$1463
		.word	$C047
		.word	$4256
		.word	$4087
		.word	$1D9B
		.word	$12D7
		.word	$E0B7
		.word	$4AED
		.word	$E003
		.word	$118E
		.word	$419D
		.word	$42BE
		.word	$20EF
	.endif

	.byte	COURSE_DATA_END

courses_data_overworld_8:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.word	$260F
	.if	.defined(SMB)
		.word	$106E
		.word	$178B
		.word	$32AF
		.word	$62D8
		.word	$62E8
		.word	$3FFC
		.word	$C8AD
		.word	$64F8
		.word	$BE0C
		.word	$4343
		.word	$64F8
		.word	$BF0C
		.word	$4073
		.word	$4084
		.word	$4093
		.word	$40A4
		.word	$40B3
		.word	$64F8
		.word	$E448
		.word	$395C
		.word	$4083
		.word	$4192
		.word	$40B3
		.word	$64F8
		.word	$E448
		.word	$395C
		.word	$64F8
		.word	$C213
		.word	$6537
		.word	$244C
		.word	$0063
		.word	$6597
		.word	$42C3
		.word	$970B
		.word	$32AC
		.word	$64F8
		.word	$BE0C
		.word	$4553
		.word	$489D
		.word	$64F8
		.word	$E22A
		.word	$473C
		.word	$4356
		.word	$62BA
		.word	$64F8
		.word	$B70C
		.word	$6488
		.word	$31BC
		.word	$45D4
		.word	$31FC
		.word	$B13C
		.word	$6478
		.word	$388C
		.word	$9C0B
		.word	$331A
		.word	$6118
		.word	$6128
		.word	$6039
		.word	$4A5D
		.word	$11EE
		.word	$B80F
		.word	$C11D
		.word	$423E
		.word	$206F
	.elseif	.defined(VS_SMB)
		.word	$32AF
		.word	$62D8
		.word	$10DE
		.word	$E408
		.word	$625A
		.word	$4C6C
		.word	$4386
		.word	$48AD
		.word	$E23A
		.word	$4253
		.word	$6488
		.word	$369C
		.word	$E408
		.word	$624A
		.word	$4D5C
		.word	$E23A
		.word	$329C
		.word	$41FC
		.word	$B13C
		.word	$0083
		.word	$42AC
		.word	$E22A
		.word	$463C
		.word	$62AA
		.word	$4EBC
		.word	$43C6
		.word	$C346
		.word	$62AA
		.word	$48BD
		.word	$960B
		.word	$12C7
		.word	$C14C
		.word	$419C
		.word	$48CD
		.word	$31DC
		.word	$C24C
		.word	$31BC
		.word	$B11C
		.word	$625A
		.word	$446C
		.word	$4376
		.word	$62BA
		.word	$32DC
		.word	$C41C
		.word	$316C
		.word	$438C
		.word	$E428
		.word	$363C
		.word	$4063
		.word	$4172
		.word	$4093
		.word	$31BC
		.word	$31EC
		.word	$C31C
		.word	$625A
		.word	$1297
		.word	$12F6
		.word	$CA5D
		.word	$1273
		.word	$12E3
		.word	$918E
		.word	$419D
		.word	$42BE
		.word	$20EF
	.endif
	.byte	COURSE_DATA_END

courses_data_overworld_9:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
	.word	$200F
	.word	$406E
	.word	$20F7
	.word	$8407
	.word	$2017

	.if	.defined(VS_SMB)
		.word	$003C
	.endif

	.if	.defined(SMB)
		.word	$344F
		.word	$03C3
	.elseif	.defined(VS_SMB)
		.word	$345F
		.word	$07C3
	.endif
	.word	$02C7
	.word	$22D3
	.if	.defined(SMB)
		.word	$E327
	.elseif	.defined(VS_SMB)
		.word	$E426
	.endif
	.word	$6139
	.word	$73E7
	.word	$E45C
	.word	$0057
	.word	$736C
	.word	$A047
	.word	$0653
	.word	$2263
	.word	$73A7
	.word	$73FC
	.word	$A113
	.word	$0533
	.word	$2143
	.word	$725C
	.if	.defined(SMB)
		.word	$23C3
		.word	$03CC
	.elseif	.defined(VS_SMB)
		.word	$22D3
		.word	$05FC
	.endif
	.word	$FB77
	.word	$02AC
	.word	$F139
	.word	$73A7
	.word	$04D3
	.word	$72E8
	.word	$22E3
	.word	$F426
	.word	$02BC

	.if	.defined(VS_SMB)
		.word	$802C
	.endif

	.if	.defined(SMB)
		.word	$818C
	.elseif	.defined(VS_SMB)
		.word	$018C
	.endif
	.word	$62A8

	.if	.defined(VS_SMB)
		.word	$01BC
		.word	$62D8
	.endif

	.word	$8717
	.word	$2443
	.word	$01A7
	.word	$04C3
	.word	$F208
	.word	$2197
	.word	$02A3
	.word	$0BC9

	.if	.defined(SMB)
		.word	$69E1
	.endif

	.word	$69F1
	.word	$C18D
	.word	$26CF
	.byte	COURSE_DATA_END

courses_data_overworld_10:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_0|COURSE_DATA_ENTER_POS_B0_C|COURSE_DATA_FG_NONE)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)
	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_A|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_PIPE_INTRO)
	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_3|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_LOCK_START|COURSE_DATA_NEW_PAGE)

	.byte	COURSE_DATA_END

courses_data_overworld_11:
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_WATER)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_0|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_0|COURSE_PAGE_D_2)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_C|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_1|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_3|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_0|COURSE_PAGE_D_5)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_9|COURSE_OBJ_FLOORROW|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_9|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_A|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_B|COURSE_OBJ_C_BLOCK_ITEM_C)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_C|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_TYPE_C |COURSE_DATA_POS_X_C|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_4)

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_F|COURSE_DATA_NEW_PAGE|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_TYPE_C |COURSE_DATA_POS_X_2|COURSE_DATA_NEW_PAGE|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_8|COURSE_DATA_POS_X_4|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_0|COURSE_PAGE_D_9)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_3|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_4|COURSE_OBJ_C_BLOCK_Q_A|COURSE_OBJ_DIM_4)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_5|COURSE_OBJ_BRICKROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_8|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_5|COURSE_DATA_POS_X_C|COURSE_OBJ_PIPE_VERT_A|COURSE_DOWNPIPE_MASK|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_7|COURSE_DATA_POS_X_C|COURSE_OBJ_FLOORROW|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_F|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_3|COURSE_DATA_NEW_PAGE|COURSE_OBJ_PIPE_VERT_B|COURSE_OBJ_DIM_2)
	.word	(COURSE_DATA_POS_Y_9|COURSE_DATA_POS_X_A|COURSE_OBJ_LEDGE|COURSE_OBJ_DIM_2)

	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_6|COURSE_DATA_NEW_PAGE|COURSE_OBJ_B_STAIRS|COURSE_OBJ_DIM_5)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_D|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_6)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_E|COURSE_OBJ_FLOORCOL|COURSE_OBJ_DIM_6)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_7|COURSE_DATA_NEW_PAGE|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_POLE)
	.word	(COURSE_DATA_TYPE_F|COURSE_DATA_POS_X_B|COURSE_OBJ_B_CASTLE|COURSE_OBJ_DIM_7)
	.byte	COURSE_DATA_END

courses_data_overworld_12:
	.word	(COURSE_AREA_LEDGE_CLOUD|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_0|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_FG_NONE)

	.word	(COURSE_DATA_TYPE_C|COURSE_DATA_POS_X_4|COURSE_OBJ_A_PIT|COURSE_OBJ_DIM_1)
	.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_F|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_16)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_0|COURSE_PAGE_D_2)
	.word	(COURSE_DATA_POS_Y_2|COURSE_DATA_POS_X_0|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_POS_Y_3|COURSE_DATA_POS_X_4|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_16)

	.word	(COURSE_DATA_POS_Y_2|COURSE_DATA_POS_X_5|COURSE_DATA_NEW_PAGE|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_3)
	.word	(COURSE_DATA_TYPE_E|COURSE_DATA_POS_X_D|(COURSE_BG_NONE_VAL<<12)|(COURSE_FG_MASK_0_VAL<<8))

	.word	(COURSE_DATA_POS_Y_A|COURSE_DATA_POS_X_5|COURSE_DATA_NEW_PAGE|COURSE_OBJ_COINROW|COURSE_OBJ_DIM_3)

	.word	(COURSE_DATA_TYPE_D|COURSE_DATA_POS_X_4|COURSE_DATA_NEW_PAGE|COURSE_DATA_TYPE_D_MASK|COURSE_OBJ_D_LOCK_START)

	.byte	COURSE_DATA_END

courses_data_overworld_13:
	.word	(COURSE_AREA_LEDGE_MUSHROOM|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.word	$260F
	.word	$10EE
	.word	$940B
	.word	$1433
	.word	$4242
	.word	$1677
	.word	$4486
	.word	$9202
	.word	$164A
	.word	$4269
	.word	$1473
	.word	$00B0
	.word	$12C7
	.word	$C005
	.word	$171C
	.word	$111F
	.word	$1236
	.word	$148F
	.word	$4091
	.word	$941B
	.word	$1235
	.word	$4234
	.word	$4260
	.word	$1261
	.word	$1287
	.word	$4096
	.word	$14A3
	.word	$981C
	.word	$111F
	.word	$1247
	.word	$159F
	.word	$15CC
	.word	$11CF
	.word	$C005
	.word	$151F

	.if	.defined(SMB)
		.word	$1239
	.endif

	.word	$167C
	.word	$117F
	.word	$4082

	.if	.defined(SMB)
		.word	$1298
	.endif

	.word	$15DF
	.word	$C416
	.word	$1417
	.word	$1254
	.word	$169B
	.word	$9428
	.if	.defined(SMB)
		.word	$01CE
	.elseif	.defined(VS_SMB)
		.word	$11EE
	.endif
	.word	$C13D
	.word	$425E
	.word	$208F
	.byte	COURSE_DATA_END

courses_data_overworld_14:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_UNDERGROUND)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
.endif
	.word	$260F
	.word	$10FE
	.word	$922B
	.word	$1257
	.word	$128B
	.word	$41C0
	.word	$13F7
	.word	$925B
	.word	$0B69
	.word	$12BB
	.word	$46B2
	.word	$9319
	.word	$0071
	.word	$9417
	.word	$147C
	.word	$117F
	.word	$4193
	.word	$15BF
	.word	$13FC
	.word	$11FF
	.word	$952F
	.word	$4250
	.word	$1251
	.word	$1458
	.word	$12A6
	.word	$12DB
	.word	$931B
	.word	$4346
	.word	$127B
	.word	$498D
	.word	$14B7
	.word	$941B
	.word	$0B49
	.word	$12BB
	.word	$13FC
	.word	$12FF
	.word	$C103
	.word	$152F
	.word	$1243
	.word	$134B
	.word	$1377
	.word	$4A9D
	.word	$C115
	.word	$41A1
	.word	$12C3
	.word	$01FE
	.word	$C17D
	.word	$429E
	.word	$20CF
	.byte	COURSE_DATA_END

courses_data_overworld_15:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.endif
	.word	$200F
	.word	$446E
	.word	$F10C
	.word	$014C
	.word	$35AA
	.word	$34D9
	.word	$20EE
	.word	$B308
	.word	$3237

	.if	.defined(SMB)
		.word	$0443
	.endif

	.word	$214E

	.if	.defined(SMB)
		.word	$2053
	.endif

	.word	$017C
	.word	$2197
	.word	$07B7
	.word	$819C
	.word	$42E7
	.word	$B35F

	.if	.defined(VS_SMB)
		.word	$0283
	.endif

	.word	$6397
	.word	$02AC
	.word	$41C5
	.word	$E049
	.word	$6158
	.word	$6476
	.word	$6585
	.word	$6694
	.word	$22A4

	.if	.defined(SMB)
		.word	$03A6
	.endif

	.word	$22C8
	.word	$02DC
	.word	$F268
	.word	$4296
	.word	$8213
	.word	$0217
	.word	$34AF
	.word	$21F6
	.word	$06FC
	.word	$8026
	.word	$242A
	.word	$0136
	.word	$008C
	.word	$35FF
	.word	$A04E
	.word	$2155
	.word	$2077
	.word	$0787
	.word	$2289
	.word	$21AE
	.word	$824C
	.word	$349F
	.if	.defined(SMB)
		.word	$01EC
	.elseif	.defined(VS_SMB)
		.word	$02EC
	.endif

	.if	.defined(SMB)
		.word	$E703
	.endif

	.if	.defined(SMB)
		.word	$6713
	.elseif	.defined(VS_SMB)
		.word	$E713
	.endif
	.word	$4A8D
	.word	$41AD
	.word	$A60F
	.byte	COURSE_DATA_END

courses_data_overworld_16:
	.word	(COURSE_AREA_LEDGE_MUSHROOM|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_0|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.word	$004C
	.word	$12C7
	.word	$42C6
	.word	$9203
	.word	$4202
	.word	$1229
	.word	$1263
	.word	$4262
	.word	$1469
	.word	$12A5
	.word	$42A4
	.word	$14E2
	.word	$44E1
	.word	$16F8
	.word	$C137
	.word	$388F
	.word	$BB02

	.if	.defined(SMB)
		.word	$7A28
	.endif

	.word	$7A68

	.if	.defined(SMB)
		.word	$7AA8
	.endif

	.word	$6AE0
	.word	$6AF0
	.word	$C56D
	.byte	COURSE_DATA_END

.if	.defined(VS_SMB)
	.res	4, $EA
.endif

courses_data_overworld_17:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.endif
	.word	$200F
	.word	$406E
	.word	$020D
	.word	$7337
	.word	$00EC
	.word	$800C
	.word	$003C
	.word	$006C
	.word	$009C
	.word	$C006
	.word	$73C7
	.word	$8306
	.word	$7228
	.word	$4096
	.word	$73E7
	.word	$C026
	.word	$7B87
	.word	$41D2
	.word	$F139
	.word	$F2C8
	.word	$E397
	.word	$23A3
	.word	$02E7
	.word	$07E3
	.word	$22F3
	.word	$E337
	.word	$009C
	.word	$00BC
	.word	$00EC
	.word	$800C
	.word	$003C
	.word	$2186
	.word	$06A6
	.word	$24B6
	.word	$805C
	.word	$007C
	.word	$009C
	.word	$E129
	.word	$05DC
	.word	$41F6
	.word	$80DC
	.word	$72E8
	.word	$810C
	.word	$7327
	.word	$014C
	.word	$7466
	.word	$110D
	.word	$353F
	.word	$41B6
	.word	$822C
	.word	$4036
	.if	.defined(SMB)
		.word	$027C
	.elseif	.defined(VS_SMB)
		.word	$037C
	.endif
	.word	$4086
	.word	$61F9
	.word	$E139
	.word	$04AC
	.word	$41C6
	.word	$830C
	.word	$4116
	.word	$F288
	.word	$F139
	.word	$007C
	.word	$6189
	.word	$009C
	.word	$63A7
	.word	$00BC
	.word	$65C5
	.if	.defined(SMB)
		.word	$00DC
	.elseif	.defined(VS_SMB)
		.word	$01DC
	.endif

	.if	.defined(SMB)
		.word	$67E3
	.endif

	.word	$67F3
	.word	$C18D
	.word	$26CF
	.byte	COURSE_DATA_END

courses_data_overworld_18:
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_WATER)
	.word	$260F
	.word	$33CF
	.word	$B207
	.word	$1115
	.word	$4252
	.word	$0B99
	.word	$02AC
	.if	.defined(SMB)
		.word	$24D3
	.elseif	.defined(VS_SMB)
		.word	$25D3
	.endif
	.word	$42D6
	.word	$25D7
	.if	.defined(SMB)
		.word	$8423
	.elseif	.defined(VS_SMB)
		.word	$904A
	.endif
	.word	$33CF
	.word	$E307
	.word	$6119

	.if	.defined(VS_SMB)
		.word	$014C
	.endif

	.word	$7A78

	.if	.defined(VS_SMB)
		.word	$009C
	.endif

	.word	$33EF
	.word	$812C
	.word	$6446
	.word	$6555
	.word	$6565
	.word	$74EC

	.if	.defined(VS_SMB)
		.word	$813C
	.endif

	.if	.defined(SMB)
		.word	$8247
		.word	$0553
	.elseif	.defined(VS_SMB)
		.word	$0246
		.word	$0453
	.endif
	.word	$2163
	.word	$4162
	.word	$2296
	.word	$419A
	.word	$03CC

	.if	.defined(VS_SMB)
		.word	$A033
		.word	$015C
		.word	$2083
	.endif

	.if	.defined(SMB)
		.word	$91B9
	.elseif	.defined(VS_SMB)
		.word	$11B9
	.endif

	.if	.defined(VS_SMB)
		.word	$05D3
		.word	$02E6
	.endif

	.word	$F139
	.word	$2663
	.word	$2767
	.word	$06D3
	.word	$01FC
	.word	$E218
	.word	$07D9
	.word	$04E9
	.word	$860C
	.word	$2237
	.word	$2493
	.if	.defined(SMB)
		.word	$8487
	.elseif	.defined(VS_SMB)
		.word	$8287
	.endif
	.word	$02AC
	.word	$41C2
	.word	$23C3
	.word	$71D9
	.word	$01FC
	.word	$B17F
	.word	$009C
	.word	$63A7
	.word	$64B6
	.word	$00CC
	.word	$66D4
	.word	$67E3
	.word	$67F3
	.word	$C18D
	.word	$26CF
	.byte	COURSE_DATA_END

courses_data_overworld_19:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
.endif
	.word	$260F
	.word	$00FC
	.word	$B31F
	.word	$005C
	.word	$6565
	.word	$6674
	.word	$6783
	.word	$6793
	.word	$73DC
	.word	$804C
	.word	$20B3
	.word	$0BC9
	.if	.defined(SMB)
		.word	$08C3
	.elseif	.defined(VS_SMB)
		.word	$04C3
	.endif
	.word	$2FD3
	.word	$00DC
	.word	$802C
	.word	$004C
	.word	$008C
	.word	$2ED3
	.word	$4AED
	.word	$00FC

	.if	.defined(SMB)
		.word	$A1D7
	.endif

	.if	.defined(SMB)
		.word	$01EC
	.elseif	.defined(VS_SMB)
		.word	$82EC
	.endif
	.word	$804C
	.word	$1159
	.word	$11D8
	.word	$10DA
	.word	$A037
	.word	$0447
	.word	$1199
	.word	$21E7
	.word	$903A
	.word	$2067
	.word	$1076
	.word	$6077
	.word	$0787
	.word	$12D8
	.word	$F139
	.word	$00AC
	.word	$71E9
	.word	$800C
	.word	$002C
	.word	$054C
	.word	$7BC7
	.word	$F139
	.word	$00EC
	.word	$11F9
	.word	$820C
	.word	$346F
	.word	$11F8
	.word	$10FA
	.word	$B27F
	.word	$00AC
	.word	$64B6
	.if	.defined(SMB)
		.word	$01CC
	.elseif	.defined(VS_SMB)
		.word	$02CC
	.endif

	.if	.defined(SMB)
		.word	$67E3
	.endif

	.word	$67F3
	.word	$C18D
	.word	$26CF
	.byte	COURSE_DATA_END

courses_data_overworld_20:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.endif
	.word	$200F
	.word	$456E
	.word	$9139
	.word	$04B3
	.word	$21C3
	.word	$11C8
	.word	$10CA

	.if	.defined(VS_SMB)
		.word	$810C
	.endif

	.if	.defined(SMB)
		.word	$9149
	.elseif	.defined(VS_SMB)
		.word	$1149
	.endif
	.word	$737C
	.word	$12E8
	.word	$9188
	.word	$108A
	.word	$21E7
	.word	$9105
	.word	$3007
	.word	$0717
	.word	$2027
	.word	$1149
	.word	$019C
	.word	$72C8
	.if	.defined(SMB)
		.word	$A623
		.word	$2627
	.elseif	.defined(VS_SMB)
		.word	$8123
		.word	$0127
		.word	$0133
		.word	$0137
		.word	$0143
		.word	$0147
		.word	$0153
		.word	$0157
		.word	$0163
		.word	$0167
		.word	$0173
		.word	$0177
		.word	$0183
		.word	$0187
	.endif

	.word	$03D3
	.word	$7AD8
	.word	$9189
	.word	$72D8
	.word	$F139
	.word	$11A9

	.if	.defined(VS_SMB)
		.word	$01EC
	.endif

	.word	$F109
	.word	$2463
	.word	$2467
	.word	$62D8
	.word	$9128
	.word	$102A

	.if	.defined(VS_SMB)
		.word	$033C
	.endif

	.word	$2156
	.word	$0470
	.word	$0B79
	.word	$008C
	.word	$2194
	.word	$359F

	.if	.defined(VS_SMB)
		.word	$52FC
	.endif

	.word	$B82F
	.word	$C13D
	.word	$267F
	.byte	COURSE_DATA_END

courses_data_overworld_21:
	.word	(COURSE_AREA_LEDGE_CLOUD|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_0|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_BG_COL_OVERWORLD)
	.word	$004C
	.word	$4FF4
	.word	$020D
	.word	$2006
	.word	$4F24
	.word	$A035
	.word	$2036
	.word	$4653
	.word	$20D5
	.word	$20D6
	.word	$A134
	.word	$4973
	.word	$2074
	.word	$2094
	.word	$20B4
	.word	$20D4
	.word	$20F4
	.word	$802E
	.word	$4259
	.word	$C74D
	.byte	COURSE_DATA_END

courses_data_overworld_22:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_OVERWORLD)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_OVERWORLD)
.endif
	.word	$260F
	.if	.defined(SMB)
		.word	$030D
		.word	$601A
		.word	$4277
		.word	$00C4
		.word	$62C8
		.word	$E1B9
		.word	$06D3
		.word	$07D7
		.word	$61F9
		.word	$810C
		.word	$B14E
		.word	$B18E
		.word	$01BC
		.word	$50E4
		.word	$61E9
		.word	$810C
		.word	$0A0D
		.word	$4384
		.word	$7298
		.word	$0C0D
		.word	$380F
		.word	$C11D
		.word	$265F
	.elseif	.defined(VS_SMB)
		.word	$F238
		.word	$009E
		.word	$72AA
		.word	$F20A
		.word	$013E
		.word	$4296
		.word	$00CE
		.word	$811E
		.word	$6129
		.word	$603A
		.word	$004E
		.word	$7488
		.word	$019E
		.word	$C306
		.word	$E00A
		.word	$000E
		.word	$014E
		.word	$6357
		.word	$6367
		.word	$6278
		.word	$6189
		.word	$609A
		.word	$00AE
		.word	$72FA
		.word	$C115
		.word	$7349
		.word	$018E
		.word	$609A
		.word	$E09A
		.word	$02AC
		.word	$61D9
		.word	$06D4
		.word	$01EC
		.word	$C105
		.word	$42D6
		.word	$C384
		.word	$F298
		.word	$04D3
		.word	$07D7
		.word	$61E9
		.word	$00EE
		.word	$813E
		.word	$02A3
		.word	$02B7
		.word	$00CE
		.word	$71E1
		.word	$31E3
		.word	$816E
		.word	$607A
		.word	$41E6
		.word	$802E
		.word	$6228
		.word	$013E
		.word	$7199
		.word	$00AE
		.word	$01CE
		.word	$80BE
		.word	$60D6
		.word	$60F6
		.word	$811E
		.word	$003C
		.word	$375F
		.word	$C15D
		.word	$269F
	.endif
	.byte	COURSE_DATA_END

.if	.defined(VS_SMB)
courses_data_overworld_23:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.word	$260F
	.word	$10FE
	.word	$932A
	.word	$1787
	.word	$14A3
	.word	$42B2
	.word	$920A
	.word	$4019
	.word	$1436
	.word	$4150
	.word	$1682
	.word	$932B
	.word	$4124
	.word	$14BB
	.word	$00B8
	.word	$43C2
	.word	$13C3
	.word	$941B
	.word	$1267
	.word	$15C4
	.word	$C153
	.word	$41D2
	.word	$C112
	.word	$1329
	.word	$1785
	.word	$921B
	.word	$421A
	.word	$1347
	.word	$4183
	.word	$13A7
	.word	$919E
	.word	$63A7
	.word	$63B7
	.word	$65C5
	.word	$65D5
	.word	$4ADD
	.word	$67E3
	.word	$67F3
	.word	$C18D
	.word	$42AE
	.word	$20DF
	.byte	COURSE_DATA_END

courses_data_overworld_24:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.word	$260F
	.word	$106E
	.word	$178B
	.word	$32AF
	.word	$62D8
	.word	$62E8
	.word	$3FFC
	.word	$C8AD
	.word	$64F8
	.word	$BE0C
	.word	$4343
	.word	$64F8
	.word	$BF0C
	.word	$4073
	.word	$4084
	.word	$4093
	.word	$40A4
	.word	$40B3
	.word	$64F8
	.word	$E448
	.word	$395C
	.word	$4083
	.word	$4192
	.word	$40B3
	.word	$64F8
	.word	$E448
	.word	$395C
	.word	$64F8
	.word	$C213
	.word	$6537
	.word	$244C
	.word	$0063
	.word	$6597
	.word	$42C3
	.word	$970B
	.word	$32AC
	.word	$64F8
	.word	$BE0C
	.word	$4553
	.word	$489D
	.word	$64F8
	.word	$E22A
	.word	$473C
	.word	$4356
	.word	$62BA
	.word	$64F8
	.word	$B70C
	.word	$6488
	.word	$31BC
	.word	$45D4
	.word	$31FC
	.word	$B13C
	.word	$6478
	.word	$388C
	.word	$9C0B
	.word	$331A
	.word	$6118
	.word	$6128
	.word	$6039
	.word	$4A5D
	.word	$11EE
	.word	$B80F
	.word	$C11D
	.word	$423E
	.word	$206F
	.byte	COURSE_DATA_END
.endif

	.export courses_data_underground_1
	.export courses_data_underground_2
	.export courses_data_underground_3
courses_data_underground_1:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_15|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_20|COURSE_DATA_FG_NONE)
	.word	$010E
	.word	$025E
	.word	$00A7
	.word	$73BC
	.word	$E01A
	.word	$6139
	.word	$6258
	.word	$6377
	.word	$6397
	.word	$62B8
	.word	$07D6
	.word	$62F8
	.word	$E119
	.word	$5275
	.word	$4086
	.word	$5087
	.word	$5295
	.word	$4393
	.word	$21A5
	.word	$52C5
	.word	$40D6
	.word	$20D7
	.word	$06E5
	.word	$51E6
	.word	$8D3E
	.word	$035E
	.word	$5267
	.word	$5277
	.word	$027E
	.word	$039E
	.if	.defined(SMB)
		.word	$43A6
		.word	$23A7
	.elseif	.defined(VS_SMB)
		.word	$42B6
		.word	$22B7
	.endif
	.word	$05DE
	.word	$02FE
	.word	$831E
	.word	$5433
	.word	$4046
	.word	$2147
	.if	.defined(SMB)
		.word	$0456
	.elseif	.defined(VS_SMB)
		.word	$5056
	.endif
	.word	$025E
	.word	$5483
	.word	$5293
	.word	$0796
	.word	$5097
	.word	$03BE
	.word	$23C7
	.word	$02FE
	.word	$820C
	.word	$4543
	.word	$2445
	.word	$2446
	.if	.defined(SMB)
		.word	$0890
	.elseif	.defined(VS_SMB)
		.word	$0490
	.endif
	.word	$5195
	.word	$FA78
	.word	$73D7
	.word	$F139
	.word	$018C
	.word	$52A8
	.word	$52B8
	.word	$01CC
	.word	$B35F
	.word	$6397
	.word	$009E
	.word	$810E
	.word	$2416
	.word	$0466
	.if	.defined(SMB)
		.word	$008E
	.elseif	.defined(VS_SMB)
		.word	$006E
	.endif
	.word	$01FE
	.word	$D208

	.if	.defined(VS_SMB)
		.word	$5218
	.endif

	.if	.defined(SMB)
		.word	$060E
	.elseif	.defined(VS_SMB)
		.word	$061E
	.endif

	.if	.defined(VS_SMB)
		.word	$015E
		.word	$5268
	.endif

	.word	$476F

	.if	.defined(VS_SMB)
		.word	$5278
		.word	$067E
	.endif

	.word	$0F9E
	.word	$820E
	.word	$472D
	.word	$7A28
	.word	$7A68
	.word	$7AA8
	.word	$01AE
	.word	$0FDE
	.word	$C56D
	.byte	COURSE_DATA_END

courses_data_underground_2:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_15|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_20|COURSE_DATA_FG_NONE)
	.word	$010E
	.word	$025E
	.word	$01BC
	.word	$01FC
	.word	$822C
	.word	$5241
	.word	$044E
	.if	.defined(SMB)
		.word	$2567
		.word	$2468
		.word	$2469
	.elseif	.defined(VS_SMB)
		.word	$5267
		.word	$5277
		.word	$5187
		.word	$0789
		.word	$5297
		.word	$52A7
		.word	$50B7
	.endif
	.word	$42BA
	.word	$04C7
	.word	$0BDE
	.word	$87B2
	.word	$02FE
	.word	$E12C
	.word	$712C
	.if	.defined(SMB)
		.word	$0167
	.word	$0077
	.word	$0187
	.elseif	.defined(VS_SMB)
		.word	$726C
	.endif
	.word	$008E
	.word	$01EE
	.word	$02F6
	.word	$8503
	.word	$0205
	.word	$2113
	.word	$0216
	.word	$0227
	.word	$022E
	.word	$7288
	.word	$20C7
	.word	$07D7
	.word	$76E4
	.word	$A007
	.word	$0617
	.if	.defined(SMB)
		.word	$7A48
	.elseif	.defined(VS_SMB)
		.word	$7248
	.endif
	.word	$2076
	.if	.defined(SMB)
		.word	$7298
	.elseif	.defined(VS_SMB)
		.word	$7A98
	.endif
	.word	$E179
	.word	$6288
	.word	$019C
	.word	$73B7
	.word	$01DC
	.word	$62F8
	.word	$01FE
	.word	$E208
	.word	$000E
	.word	$026E
	.word	$2073
	.word	$2377
	.word	$0483
	.if	.defined(SMB)
		.word	$2093
	.elseif	.defined(VS_SMB)
		.word	$2193
	.endif
	.word	$00AE

	.if	.defined(SMB)
		.word	$0AFE
	.endif

	.if	.defined(SMB)
		.word	$820E
	.elseif	.defined(VS_SMB)
		.word	$810E
	.endif
	.word	$7139

	.if	.defined(VS_SMB)
		.word	$025E
	.endif

	.word	$72A8
	.word	$73E7
	.word	$810C
	.word	$328F
	.word	$00AE
	.word	$04FE
	.if	.defined(SMB)
		.word	$D104
		.word	$0417
	.elseif	.defined(VS_SMB)
		.word	$D304
		.word	$2A17
	.endif
	.word	$4926

	.if	.defined(SMB)
		.word	$2927
	.endif

	.word	$33DF
	.word	$02FE
	.word	$F644
	.word	$017C
	.word	$068E

	.if	.defined(VS_SMB)
		.word	$01AE
	.endif

	.word	$47BF

	.if	.defined(VS_SMB)
		.word	$52B8
		.word	$52C8
		.word	$52D8
		.word	$52E8
	.endif

	.word	$0FEE
	.word	$C74D
	.word	$820E
	.word	$7A68
	.word	$01AE
	.word	$0FDE
	.word	$C56D
	.byte	COURSE_DATA_END

courses_data_underground_3:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_20|COURSE_DATA_FG_NONE)
	.word	$010E
	.word	$5A00
	.word	$063E
	.word	$4645
	.word	$4647
	.word	$4453
	.word	$01AE
	.word	$4ADF
	.word	$C74D
	.word	$810E
	.word	$5A00
	.word	$042E
	.word	$2837
	.word	$483A
	.word	$4746
	.word	$07C7
	.word	$0FCE
	.word	$4ADF
	.word	$C74D
	.word	$810E
	.word	$5A00
	.word	$5333
	.word	$5143
	.word	$4046
	.word	$5047
	.word	$0453
	.word	$4055
	.word	$5056
	.word	$4362
	.word	$4064
	.word	$5065
	.word	$4171
	.word	$5173
	.word	$5183
	.word	$4094
	.word	$5095
	.word	$50A3
	.word	$40A5
	.word	$50A6
	.word	$51B3
	.word	$40B6
	.word	$50B7
	.word	$53C3
	.word	$4ADF
	.word	$C74D
	.word	$810E
	.word	$5A00
	.word	$022E
	.word	$4736
	.word	$5237
	.word	$493A
	.word	$2547
	.word	$52A7
	.word	$04D7
	.word	$4ADF
	.word	$C74D
	.word	$810E
	.word	$5A00
	.word	$023E
	.word	$5144
	.word	$4453
	.word	$4454
	.word	$2455
	.word	$54A1
	.word	$01AE
	.word	$21B4
	.word	$4ADF
	.word	$07E5
	.word	$C74D
	.byte	COURSE_DATA_END

	.export courses_data_water_1
	.export courses_data_water_2
	.export courses_data_water_3
.if	.defined(VS_SMB)
	.export courses_data_water_4
.endif
courses_data_water_1:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_FG_WATER)
	.word	$34B4
	.word	$52C8
	.word	$51F2
	.word	$D347
	.word	$036C
	.word	$4965
	.word	$079E
	.word	$01BE
	.word	$03CC
	.word	$07FE
	.word	$C90D
	.word	$011E
	.word	$016C
	.word	$3562
	.word	$5363
	.word	$418A
	.word	$01AC
	.word	$53B3
	.word	$51E9
	.word	$C326
	.word	$3327
	.word	$4363
	.word	$3364
	.word	$60BA
	.word	$61C9
	.word	$0BCE
	
	.if	.defined(VS_SMB)
		.word	(COURSE_DATA_POS_Y_4|COURSE_DATA_POS_X_E|COURSE_OBJ_FLOORCOL|(%0000)<<8)
	.endif

	.word	$09E5
	.word	$0FEE
	.word	$CA7D
	.word	$477D
	.byte	COURSE_DATA_END

courses_data_water_2:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_FG_WATER)
	.if	.defined(SMB)
		.word	$52B8
		.word	$41EA
		.word	$B227
		.word	$42B3
		.word	$D416
		.word	$424A
		.word	$51A5
		.word	$31A7
		.word	$D327
		.word	$E208
		.word	$6416
		.word	$042C
		.word	$4238
		.word	$6476
		.word	$6288
		.word	$07DE
		.word	$01FE
		.word	$C90D
		.word	$3223
		.word	$5131
		.word	$5298
		.word	$C90D
		.word	$4259
		.word	$5363
		.word	$3167
		.word	$C214
		.word	$3136
		.word	$5387
		.word	$E317
		.word	$6129
		.word	$6230
		.word	$083C
		.word	$3742
		.word	$4059
		.word	$426A
		.word	$4099
		.word	$61C9
		.word	$63D7
		.word	$D139
		.word	$5258
		.word	$67C3
		.word	$31D3
		.word	$06DC
		.word	$42F7
		.word	$42FA
		.word	$B123
		.word	$6743
		.word	$34C3
		.word	$34C7
		.word	$51D1
		.word	$B343
		.word	$3347
	.elseif	.defined(VS_SMB)
		.word	$D327
		.word	$5179
		.word	$56C4
		.word	$8E0C
		.word	$491D
		.word	$4039
		.word	$424A
		.word	$4079
		.word	$57A5
		.word	$0FFC
		.word	$E200
		.word	$5303
		.word	$3B12
		.word	$421A
		.word	$5443
		.word	$5383
		.word	$5399
		.word	$54C3
		.word	$52DA
		.word	$05FC
		.word	$D309
		.word	$6453
		.word	$3163
		.word	$3467
		.word	$4186
		.word	$018C
		.word	$30A3
		.word	$64B3
		.word	$03CC
		.word	$42D9
		.word	$845C
		.word	$62A0
		.word	$62A8
		.word	$62B0
		.word	$62B8
		.word	$62C0
		.word	$62C8
		.word	$62D0
		.word	$62D8
		.word	$62E0
		.word	$62E8
		.word	$C216
		.word	$5258
		.word	$048C
		.word	$55A7
		.word	$63D0
		.word	$65D7
		.word	$61E2
		.word	$65E7
		.word	$61F2
		.word	$65F7
		.word	$B813
		.word	$3817
		.word	$038C
		.word	$C91D
		.word	$6250
		.word	$0B5C
		.word	$3E62
		.word	$5263
		.word	$528A
		.word	$5493
		.word	$42AA
		.word	$51D3
		.word	$41EA
		.word	$D303
		.word	$041C
		.word	$521A
		.word	$5533
		.word	$4473
		.word	$4477
		.word	$D216
		.word	$3119
		.word	$321A
		.word	$0F5C
		.word	$479A
		.word	$6495
		.word	$64A5
		.word	$64B5
		.word	$64C5
		.word	$64D5
		.word	$64E5
		.word	$64F5
		.word	$E405
		.word	$6140
		.word	$3542
		.word	$3456
		.word	$095C
		.word	$61A2
		.word	$61A6
		.word	$34B3
		.word	$34B7
		.word	$0BFC
		.word	$C20A
		.word	$414A
		.word	$523A
		.word	$5468
		.word	$51C9
		.word	$870C
		.word	$5428
		.word	$5359
	.endif

	.word	$309A
	.word	$61A9
	.word	$62B8
	.word	$0BBE

	.if	.defined(VS_SMB)
		.word	$60D4
	.endif

	.word	$09D5
	.word	$0FDE
	.word	$CA0D
	.word	$477D
	.byte	COURSE_DATA_END

courses_data_water_3:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_15|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_20|COURSE_DATA_FG_WATER)
	.word	$011E
	.word	$7339
	.word	$075E
	.word	$0BAE
	.word	$821E
	.word	$886E
	.word	$029E
	.word	$040D
	.word	$0B2E

	.if	.defined(VS_SMB)
		.word	$5044
	.endif

	.word	$0945
	.word	$0F4E
	.word	$47ED
	.byte	COURSE_DATA_END

.if	.defined(VS_SMB)
courses_data_water_4:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_FG_WATER)
	.word	$52B8
	.word	$41EA
	.word	$B227
	.word	$42B3
	.word	$D416
	.word	$424A
	.word	$51A5
	.word	$31A7
	.word	$D327
	.word	$E208
	.word	$6416
	.word	$042C
	.word	$4238
	.word	$6476
	.word	$6288
	.word	$07DE
	.word	$01FE
	.word	$C90D
	.word	$3223
	.word	$5131
	.word	$5298
	.word	$C90D
	.word	$4259
	.word	$5363
	.word	$3167
	.word	$C214
	.word	$3136
	.word	$5387
	.word	$E317
	.word	$6129
	.word	$6230
	.word	$083C
	.word	$3742
	.word	$4059
	.word	$426A
	.word	$4099
	.word	$61C9
	.word	$63D7
	.word	$D139
	.word	$5258
	.word	$67C3
	.word	$31D3
	.word	$06DC
	.word	$42F7
	.word	$42FA
	.word	$B123
	.word	$6743
	.word	$34C3
	.word	$34C7
	.word	$51D1
	.word	$B343
	.word	$3347
	.word	$309A
	.word	$61A9
	.word	$62B8
	.word	$0BBE
	.word	$60D4
	.word	$09D5
	.word	$0FDE
	.word	$CA0D
	.word	$477D
	.byte	COURSE_DATA_END
.endif
