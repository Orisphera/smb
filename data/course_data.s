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
	.byte	$0F, $03, $56, $1B, $C9, $1B, $0F, $07, $36, $1B
	.byte	$AA, $1B, $48, $95

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
		.byte	$3B
	.elseif	.defined(VS_SMB)
		.byte	$3A
	.endif
	.byte	$1D
	.if	.defined(SMB)
		.byte	$8B
	.elseif	.defined(VS_SMB)
		.byte	$8A
	.endif
	.byte	$1D, $AB, $0C
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

	.byte	$65
	.if	.defined(SMB)
		.byte	$1D
	.elseif	.defined(VS_SMB)
		.byte	$9D
	.endif

	.byte	$6B, $1B, $05, $9D, $0B, $1B, $05, $9B, $0B
	.byte	$1D, $8B, $0C

	.if	.defined(VS_SMB)
		.byte	$E8, $03
	.endif

	.byte	$1B, $8C, $70, $15, $7B, $0C, $DB, $0C, $0F
	.if	.defined(SMB)
		.byte	$08
	.elseif	.defined(VS_SMB)
		.byte	$07
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

	.byte	$9B
	.if	.defined(SMB)
		.byte	$83
	.elseif	.defined(VS_SMB)
		.byte	$03, $F1, $0E
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
	.byte	$05, $32, $06, $33, $07
	.if	.defined(SMB)
		.byte	$34, $CE, $03, $DC, $51
		.byte	$EE, $07, $73, $E0, $74, $0A, $7E, $06, $9E, $0A
		.byte	$CE, $06, $E4, $00, $E8, $0A, $FE, $0A, $2E, $89
		.byte	$4E, $0B, $54, $0A, $14, $8A, $C4, $0A, $34, $8A
		.byte	$7E, $06, $C7, $0A, $01, $E0, $02, $0A, $47, $0A
		.byte	$81, $60, $82, $0A, $C7, $0A, $0E, $87, $7E, $02
		.byte	$A7, $02, $B3, $02, $D7, $02, $E3, $02, $07, $82
		.byte	$13, $02, $3E, $06, $7E, $02, $AE, $07
	.elseif	.defined(VS_SMB)
		.byte	$33, $3E, $03, $4C, $50, $4E
		.byte	$07, $57, $31, $6E, $03, $7C, $52, $9E, $07, $FE, $0A, $7E, $89, $9E, $0A, $EE
		.byte	$07, $F7, $34, $13, $8A, $3E, $0A, $6E, $09, $87, $0A, $9E, $02, $C6, $04, $CA
		.byte	$0A, $F7, $62, $07, $8A, $08, $61, $17, $62, $1E, $0A, $4E, $06, $5E, $0A, $7E
		.byte	$06, $8E, $0A, $AE, $06, $BE, $07, $F3, $0A, $1E, $86, $2E, $0A, $84, $37, $93
		.byte	$36, $A2, $45, $1E, $89, $46, $0A, $6E, $0A, $B7, $60, $DB, $60, $F7, $60, $1B
		.byte	$E0, $37, $60, $7E, $09, $8E, $0B, $A3, $0A, $FE, $04, $17, $BB, $47, $0A, $77
		.byte	$0A, $BE, $02, $CE, $0A, $07, $8A, $17, $31, $63, $31, $A7, $34, $C7, $0A, $13
		.byte	$B1, $4E, $09, $1E, $8A, $7E, $02, $97, $34, $B7, $0A, $CE, $0A, $DE, $02, $D8
		.byte	$61, $F7, $62, $FE, $03, $07, $B4, $17, $0A, $47, $62, $4E, $0A, $5E, $03, $51
		.byte	$61, $67, $62, $77, $34, $B7, $62, $C1, $61, $DA, $60, $E9, $61, $F8, $62
	.endif

	.byte	$FE, $0A, $0D, $C4

	.if	.defined(VS_SMB)
		.byte	$01, $52, $11, $52, $21, $52, $31, $52, $41, $52
		.byte	$51, $52, $61, $52
	.endif

	.byte	$CD, $43, $CE, $09, $DE, $0B, $DD, $42, $FE, $02
	.byte	$5D, $C7

	.byte	COURSE_DATA_END

courses_data_castle_2:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.byte	$05, $32, $06, $33, $07, $34, $5E, $0A, $68, $64
	.byte	$98, $64, $A8, $64, $CE, $06, $FE, $02, $0D, $01
	.byte	$1E, $0E, $7E, $02, $94, $63, $B4, $63, $D4, $63
	.byte	$F4, $63, $14, $E3, $2E, $0E, $5E, $02, $64, $35
	.byte	$88, $72, $BE, $0E, $0D, $04, $AE, $02, $CE, $08
	.byte	$CD, $4B, $FE, $02, $0D, $05, $68, $31, $7E, $0A
	.byte	$96, $31, $A9, $63, $A8, $33, $D5, $30, $EE, $02
	.byte	$E6, $62, $F4, $61, $04, $B1, $08, $3F, $44, $33
	.byte	$94, $63, $A4, $31, $E4, $31, $04, $BF, $08, $3F
	.byte	$04, $BF, $08, $3F, $CD, $4B, $03, $E4, $0E, $03

	.if	.defined(VS_SMB)
		.byte	$1C, $01
	.endif

	.byte	$2E, $01

	.if	.defined(VS_SMB)
		.byte	$4C, $01, $7C, $00
	.endif

	.byte	$7E, $06, $BE, $02, $DE, $06, $FE, $0A
	.byte	$0D, $C4, $CD, $43, $CE, $09, $DE, $0B, $DD, $42
	.byte	$FE, $02, $5D, $C7
	.byte	COURSE_DATA_END

courses_data_castle_3:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.byte	$05, $32, $06, $33, $07, $34
	.if	.defined(SMB)
		.byte	$FE, $00, $27, $B1
		.byte	$65, $32, $75, $0A, $71, $00, $B7, $31, $08, $E4
		.byte	$18, $64, $1E, $04, $57, $3B, $BB, $0A, $17, $8A
		.byte	$27, $3A, $73, $0A, $7B, $0A, $D7, $0A, $E7, $3A
		.byte	$3B, $8A, $97, $0A, $FE, $08, $24, $8A, $2E, $00
		.byte	$3E, $40, $38, $64, $6F, $00, $9F, $00, $BE, $43
		.byte	$C8, $0A, $C9, $63, $CE, $07, $FE, $07, $2E, $81
		.byte	$66, $42, $6A, $42, $79, $0A, $BE, $00, $C8, $64
		.byte	$F8, $64, $08, $E4, $2E, $07, $7E, $03, $9E, $07
		.byte	$BE, $03, $DE, $07, $FE, $0A, $03, $A5, $0D, $44
	.elseif	.defined(VS_SMB)
		.byte	$CE, $03, $DC
		.byte	$51, $EE, $07, $73, $E0, $74, $0A, $7E, $06, $9E, $0A, $CE, $06, $E4, $00, $E8
		.byte	$0A, $FE, $0A, $2E, $89, $4E, $0B, $54, $0A, $14, $8A, $C4, $0A, $34, $8A, $7E
		.byte	$06, $C7, $0A, $01, $E0, $02, $0A, $47, $0A, $81, $60, $82, $0A, $C7, $0A, $0E
		.byte	$87, $7E, $02, $A7, $02, $B3, $02, $D7, $02, $E3, $02, $07, $82, $13, $02, $3E
		.byte	$06, $4E, $0A, $6E, $06, $7E, $02, $AE, $07, $DE, $0A, $E1, $61, $EE, $07, $FE
		.byte	$0A, $0D, $C4
	.endif
	.byte	$CD, $43, $CE, $09

	.if	.defined(VS_SMB)
		.byte	$DE, $0B
	.endif

	.byte	$DD, $42

	.if	.defined(SMB)
		.byte	$DE, $0B
	.endif

	.byte	$FE, $02, $5D, $C7

	.byte	COURSE_DATA_END

courses_data_castle_4:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.byte	$05, $32, $06, $33, $07, $34

	.if	.defined(VS_SMB)
		.byte	$BE, $03, $CC, $01, $DE, $07
	.endif

	.byte	$FE, $06, $0C, $81
	.if	.defined(SMB)
		.byte	$39
	.elseif	.defined(VS_SMB)
		.byte	$38
	.endif
	.byte	$0A, $5C, $01
	.if	.defined(SMB)
		.byte	$89
	.elseif	.defined(VS_SMB)
		.byte	$88
	.endif
	.byte	$0A, $AC, $01
	.if	.defined(SMB)
		.byte	$D9, $0A, $FC, $01, $2E, $83
	.elseif	.defined(VS_SMB)
		.byte	$D8, $0A, $EE, $0A, $0E, $86, $2E, $0a, $4E, $03
		.byte	$53, $0A, $6E, $0A, $8E, $03
	.endif
	.byte	$A7, $01, $B7
	.if	.defined(SMB)
		.byte	$00
	.elseif	.defined(VS_SMB)
		.byte	$01
	.endif
	.byte	$C7
	.if	.defined(SMB)
		.byte	$01
	.elseif	.defined(VS_SMB)
		.byte	$00
	.endif
	.byte	$DE, $0A, $FE, $02, $4E, $83, $5A, $32, $63, $0A
	.byte	$69, $0A, $7E

	.if	.defined(VS_SMB)
		.byte	$02, $8E, $0A, $9E, $02, $CE, $0A, $DE
	.endif

	.byte	$02, $EE, $03, $FA, $32, $03, $8A, $09, $0A, $1E

	.if	.defined(VS_SMB)
		.byte	$02, $2E, $0A, $3E, $02, $CE, $0A, $DE
	.endif
	

	.byte	$02, $EE, $03, $FA, $32, $03, $8A, $09, $0A, $14
	.byte	$42, $1E

	.if	.defined(VS_SMB)
		.byte	$02, $2E, $0A, $3E
	.endif

	.byte	$02, $7E, $0A, $9E, $07, $FE, $0A, $2E, $86, $5E
	.byte	$0A, $8E, $06, $BE, $0A, $EE, $07, $3E, $83, $5E

	.if	.defined(VS_SMB)
		.byte	$07, $7E, $03, $8C, $01, $9E, $07, $AE, $03, $BC
		.byte	$00, $BE, $07, $CE, $03, $DC, $00, $DE
	.endif

	.byte	$07, $FE, $0A, $0D, $C4, $41, $52, $51, $52, $CD
	.byte	$43, $CE, $09, $DE, $0B, $DD, $42, $FE, $02, $5D
	.byte	$C7
	.byte	COURSE_DATA_END

courses_data_castle_5:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.byte	$05, $32, $06, $33, $07, $34, $FE, $0A, $AE, $86
	.byte	$BE, $07, $FE, $02, $0D, $02, $27, $32, $46, $61
	.byte	$55, $62, $5E, $0E, $1E, $82, $68, $3C, $74, $3A
	.byte	$7D, $4B, $5E, $8E, $7D, $4B, $7E, $82, $84, $62
	.byte	$94, $61, $A4, $31, $BD, $4B, $CE, $06, $FE, $02
	.byte	$0D, $06, $34, $31, $3E, $0A, $64, $32, $75, $0A
	.byte	$7B, $61, $A4, $33, $AE, $02, $DE, $0E, $3E, $82
	.byte	$64, $32, $78, $32, $B4, $36, $C8, $36, $DD, $4B
	.byte	$44, $B2, $58, $32, $94, $63, $A4, $3E, $BA, $30
	.byte	$C9, $61, $CE, $06, $DD, $4B, $CE, $86, $DD, $4B
	.byte	$FE
	.if	.defined(SMB)
		.byte	$02
	.elseif	.defined(VS_SMB)
		.byte	$0A
	.endif
	.byte	$2E, $86, $5E
	.if	.defined(SMB)
		.byte	$02
	.elseif	.defined(VS_SMB)
		.byte	$0A
	.endif
	.byte	$7E, $06, $FE
	.if	.defined(SMB)
		.byte	$02
	.elseif	.defined(VS_SMB)
		.byte	$0A
	.endif
	.byte	$1E, $86, $3E
	.if	.defined(SMB)
		.byte	$02
	.elseif	.defined(VS_SMB)
		.byte	$0A
	.endif
	.byte	$5E, $06
	.if	.defined(SMB)
		.byte	$7E, $02
	.elseif	.defined(VS_SMB)
		.byte	$6E, $0A
	.endif
	.byte	$9E, $06

	.if	.defined(VS_SMB)
		.byte	$BE, $0A, $DE, $06
	.endif

	.byte	$FE, $0A, $0D, $C4, $CD, $43, $CE, $09, $DE, $0B
	.byte	$DD, $42, $FE, $02, $5D, $C7
	.byte	COURSE_DATA_END

courses_data_castle_6:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_6|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.byte	$05, $32, $06, $33, $07, $34, $5E, $0A, $AE, $02
	.byte	$0D, $01, $39, $73, $0D, $03, $39, $7B, $4D, $4B
	.byte	$DE, $06, $1E, $8A, $AE, $06, $C4, $33, $16, $FE
	.byte	$A5, $77, $FE, $02, $FE, $82, $0D, $07, $39, $73
	.byte	$A8, $74, $ED, $4B, $49, $FB, $E8, $74, $FE, $0A
	.byte	$2E, $82
	.if	.defined(SMB)
		.byte	$67
	.elseif	.defined(VS_SMB)
		.byte	$66
	.endif
	.byte	$02, $84, $7A, $87, $31, $0D, $0B
	.byte	$FE, $02, $0D, $0C, $39, $73, $5E, $06, $C6, $76
	.byte	$45, $FF, $BE, $0A, $DD, $48, $FE, $06, $3D, $CB
	.byte	$46, $7E, $AD, $4A, $FE, $82, $39, $F3, $A9, $7B
	.byte	$4E, $8A, $9E, $07, $FE, $0A, $0D, $C4

	.if	.defined(VS_SMB)
		.byte	$01, $52, $11, $52, $21, $52, $31, $52, $41, $52
		.byte	$51, $52, $61, $52, $71, $52, $81, $52, $91, $52
		.byte	$A1, $52, $B1, $52
	.endif

	.byte	$CD, $43, $CE, $09, $DE, $0B, $DD, $42, $FE, $02
	.byte	$5D, $C7
	.byte	COURSE_DATA_END

.if	.defined(VS_SMB)
courses_data_castle_7:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.byte	$05, $32, $06, $33, $07, $34, $33, $8A, $3E, $06, $4E, $0A, $7E, $06, $9E, $0A
	.byte	$CE, $06, $D3, $00, $EE, $0A, $1E, $86, $2E, $07, $53, $0A, $7E, $06, $8E, $0A
	.byte	$9E, $02, $C7, $0A, $D7, $37, $5E, $8A, $57, $0A, $BE, $02, $DA, $60, $E9, $61
	.byte	$F8, $62, $FE, $07, $07, $BF, $43, $0A, $C3, $0A, $07, $B7, $43, $0A, $87, $0A
	.byte	$97, $31, $AE, $0A, $FE, $06, $2E, $8A, $3E, $06, $57, $0A, $6E, $0A, $7E, $06
	.byte	$AE, $0A, $BE, $02, $07, $E3, $47, $63, $87, $63, $AE, $07, $FE, $0A, $0D, $C4
	.byte	$CD, $43, $CE, $09, $DE, $0B, $DD, $42, $FE, $02, $5D, $C7
	.byte	COURSE_DATA_END

courses_data_castle_8:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_7|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_50|COURSE_DATA_FG_SURFACE)
	.byte	$05, $32, $06, $33, $07, $34, $FE, $00, $27, $B1, $65, $32, $75, $0A, $71, $00
	.byte	$B7, $31, $08, $E4, $18, $64, $1E, $04, $57, $3B, $BB, $0A, $DC, $00, $17, $8A
	.byte	$27, $31, $57, $37, $73, $0A, $7B, $0A, $D7, $0A, $E7, $3A, $0C, $80, $3B, $0A
	.byte	$97, $0A, $FE, $08, $24, $8A, $2E, $00, $3E, $40, $38, $64, $6F, $00, $9F, $00
	.byte	$BE, $43, $C8, $0A, $C9, $63, $CE, $07, $FE, $07, $2E, $80, $4E, $01, $66, $42
	.byte	$6A, $42, $79, $0A, $9E, $00, $BE, $0A, $C8, $64, $F8, $64, $08, $E4, $0E, $0A
	.byte	$2E, $06, $7E, $0A, $8E, $06, $9E, $0A, $BE, $06, $CE, $0A, $EE, $06, $FE, $0A
	.byte	$03, $A5, $0D, $44, $CD, $43, $CE, $09, $DD, $42, $DE, $0B, $FE, $02, $5D, $C7
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
	.byte	$0F, $26, $FE, $10, $28, $94, $65, $15, $EB, $12
	.byte	$FA, $41
	.if	.defined(SMB)
		.byte	$4A, $96, $54, $40
	.elseif	.defined(VS_SMB)
		.byte	$54, $C0, $6A, $12
	.endif
	.byte	$A4, $42, $B7
	.if	.defined(SMB)
		.byte	$13, $E9, $19
	.elseif	.defined(VS_SMB)
		.byte	$12, $F9, $18
	.endif
	.byte	$F5, $15, $11, $80, $47, $42
	.if	.defined(SMB)
		.byte	$71, $13
	.elseif	.defined(VS_SMB)
		.byte	$81, $12
	.endif
	.byte	$80, $41, $15, $92, $1B
	.if	.defined(SMB)
		.byte	$1F
	.elseif	.defined(VS_SMB)
		.byte	$1E
	.endif
	.byte	$24, $40, $55, $12
	.byte	$64, $40, $95, $12, $A4, $40, $D2, $12, $E1, $40
	.byte	$13, $C0, $2C, $17, $2F, $12, $49, $13, $83, $40
	.byte	$9F, $14, $A3, $40, $17, $92, $83, $13, $92, $41
	.byte	$B9, $14, $C5, $12, $C8, $40, $D4, $40
	.if	.defined(SMB)
		.byte	$4B, $92, $78, $1B
	.elseif	.defined(VS_SMB)
		.byte	$78, $95, $E8, $14
	.endif
	.byte	$9C, $94, $9F, $11, $DF, $14
	.if	.defined(SMB)
		.byte	$FE, $11, $7D, $C1
	.elseif	.defined(VS_SMB)
		.byte	$3E, $91, $8D, $41
	.endif
	.byte	$9E, $42, $CF, $20
	.byte	COURSE_DATA_END

courses_data_overworld_2:
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.byte	$0F, $26, $29, $91, $7E, $42, $FE, $40, $28, $92
	.byte	$4E, $42, $2E, $C0, $57, $73, $C3
	.if	.defined(SMB)
		.byte	$25
	.elseif	.defined(VS_SMB)
		.byte	$27
	.endif
	.byte	$C7, $27

	.if	.defined(SMB)
		.byte	$23, $84, $33, $20
	.endif

	.byte	$5C
	.if	.defined(SMB)
		.byte	$01
	.elseif	.defined(VS_SMB)
		.byte	$81
	.endif
	.byte	$77, $63, $88, $62
	.byte	$99, $61, $AA, $60, $BC, $01, $EE, $42, $4E, $C0
	.byte	$69, $11, $7E, $42, $DE, $40, $F8, $62, $0E, $C2
	.byte	$AE, $40, $D7, $63, $E7, $63, $33, $A7, $37, $27
	.byte	$43, $04, $CC, $01, $E7, $73, $0C, $81, $3E, $42
	.byte	$0D, $0A, $5E, $40, $88, $72, $BE, $42, $E7, $87
	.byte	$FE, $40, $39, $E1, $4E, $00, $69, $60, $87, $60
	.byte	$A5, $60
	.if	.defined(SMB)
		.byte	$C3, $31
	.elseif	.defined(VS_SMB)
		.byte	$D3, $30
	.endif
	.byte	$FE, $31, $6D, $C1, $BE, $42, $EF, $20
	.byte	COURSE_DATA_END

courses_data_overworld_3:
	.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
	.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
	.endif
	.byte	$0F, $20, $6E, $40, $58, $F2, $93, $01, $97, $00
	.byte	$0C, $81, $97, $40, $A6, $41, $C7, $40
	.if	.defined(SMB)
		.byte	$0D, $04, $03, $1
	.elseif	.defined(VS_SMB)
		.byte	$DC, $01, $77, $E3, $03, $81
	.endif
	.byte	$07, $01, $23, $01, $27, $01, $EC, $03, $AC, $F3

	.if	.defined(SMB)
		.byte	$C3, $03
	.endif

	.byte	$78, $E2, $94, $43, $47, $F3
	.byte	$74, $43, $47, $FB, $74, $43, $2C, $F1, $4C, $63
	.byte	$47, $00, $57, $21, $5C, $01, $7C, $72, $39, $F1
	.byte	$EC, $02, $4C, $81

	.if	.defined(VS_SMB)
		.byte	$97, $63
	.endif

	.byte	$D8, $62, $EC, $01, $0D, $0D, $0F
	.if	.defined(SMB)
		.byte	$38
	.elseif	.defined(VS_SMB)
		.byte	$35
	.endif

	.if	.defined(VS_SMB)
		.byte	$6C, $01, $83, $67
	.endif

	.byte	$C7, $07, $ED, $4A, $1D, $C1, $5F, $26
	.byte	COURSE_DATA_END

courses_data_overworld_4:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_NONE)
	.byte	$0F, $26, $A7, $22, $37, $FB, $73, $20, $83, $07
	.byte	$87, $02, $93, $20, $C7, $73

	.if	.defined(VS_SMB)
		.byte	$EC, $01
	.endif

	.byte	$04, $F1, $06, $31
	.byte	$39, $71, $59, $71, $E7, $73, $37, $A0, $47, $04
	.byte	$86, $7C, $E5, $71, $E7, $31, $33, $A4, $39, $71

	.if	.defined(VS_SMB)
		.byte	$5C, $01
	.endif

	.byte	$A9, $71, $D3, $23

	.if	.defined(VS_SMB)
		.byte	$EC, $01
	.endif

	.byte	$08, $F2, $13, $05, $27, $02, $49, $71

	.if	.defined(VS_SMB)
		.byte	$6C, $00
	.endif

	.byte	$75, $75, $E8, $72, $67, $F3, $99, $71
	.byte	$E7, $20, $F4, $72, $F7, $31, $17, $A0, $33, $20
	.byte	$39, $71, $73, $28, $BC, $05, $39, $F1, $79, $71
	.byte	$A6, $21, $C3, $06, $D3, $20, $DC, $00, $FC, $00
	.byte	$07, $A2, $13, $21, $5F, $32, $8C, $00, $98, $7A
	.byte	$C7, $63, $D9, $61, $03, $A2, $07, $22, $74, $72
	.byte	$77, $31, $E7, $73

	.if	.defined(VS_SMB)
		.byte	$0C, $82
	.endif

	.byte	$39
	.if	.defined(SMB)
		.byte	$F1
	.elseif	.defined(VS_SMB)
		.byte	$71
	.endif
	.byte	$58, $72, $77, $73
	.byte	$D8, $72, $7F, $B1, $97, $73, $B6, $64, $C5, $65
	.byte	$D4, $66, $E3

	.if	.defined(SMB)
		.byte	$67, $F3
	.endif

	.byte	$67, $8D, $C1, $CF, $26
	.byte	COURSE_DATA_END

courses_data_overworld_5:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
	.byte	$0F, $20, $6E, $66, $07, $81, $36, $01, $66, $00
	.byte	$A7
	.if	.defined(SMB)
		.byte	$22
	.elseif	.defined(VS_SMB)
		.byte	$21
	.endif

	.if	.defined(VS_SMB)
		.byte	$C9, $20, $DC, $02
	.endif

	.byte	$08, $F2, $67, $7B

	.if	.defined(VS_SMB)
		.byte	$AC, $00
	.endif

	.byte	$DC, $02
	.if	.defined(SMB)
		.byte	$98, $F2
	.elseif	.defined(VS_SMB)
		.byte	$07, $A2, $0A, $60, $37, $07, $39, $20, $96, $74
	.endif
	.byte	$D7, $20

	.if	.defined(VS_SMB)
		.byte	$2C, $80
	.endif

	.byte	$39
	.if	.defined(SMB)
		.byte	$F1
	.elseif	.defined(VS_SMB)
		.byte	$71
	.endif
	.byte	$9F, $33, $DC, $27, $DC, $57
	.byte	$23, $83, $57, $63, $6C, $51, $87, $63, $99, $61
	.byte	$A3, $06, $B3, $21

	.if	.defined(VS_SMB)
		.byte	$CC, $00, $D8, $62, $EC, $00
	.endif

	.byte	$77, $F3

	.if	.defined(VS_SMB)
		.byte	$9C, $00
	.endif

	.byte	$F3
	.if	.defined(SMB)
		.byte	$21
	.elseif	.defined(VS_SMB)
		.byte	$01
	.endif
	.byte	$F7, $2A
	.if	.defined(SMB)
		.byte	$13, $81, $23, $22, $53, $00, $63, $22, $E9, $0B
		.byte	$0C, $83, $13, $21, $16, $22, $33, $05, $8F, $35
		.byte	$EC, $01, $63, $A0, $67, $20, $73, $01, $77, $01
		.byte	$83, $20, $87, $20, $B3, $20, $B7, $20, $C3, $01
		.byte	$C7, $00, $D3, $20, $D7, $20, $67, $A0, $77, $07
		.byte	$87, $22
	.elseif	.defined(VS_SMB)
		.byte	$03, $81, $13, $01
		.byte	$23, $01, $33, $01, $43, $01, $53, $00, $63, $01, $73, $01, $83, $01, $93, $01
		.byte	$AC, $00, $CC, $01, $E9, $0B, $FC, $05, $13, $A1, $16, $22, $33, $05, $7F, $35
		.byte	$DC, $02, $63, $81, $67, $01, $73, $01, $77, $01, $83, $01, $87, $01, $B3, $01
		.byte	$B7, $01, $C3, $00, $C7, $01, $D3, $01, $D7, $01, $67, $A4, $9A, $60, $AC, $02
	.endif

	.byte	$E8, $62, $F5, $65, $1C
	.if	.defined(SMB)
		.byte	$82
	.elseif	.defined(VS_SMB)
		.byte	$84
	.endif
	.byte	$7F, $38, $8D, $C1, $CF, $26
	.byte	COURSE_DATA_END

courses_data_overworld_6:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.byte	$07, $81, $47, $24, $57, $00, $63, $01, $77, $01
	.byte	$C9, $71, $68, $F2, $E7, $73, $97, $FB, $06, $83
	.byte	$5C, $01, $D7, $22
	.if	.defined(SMB)
		.byte	$E7, $00, $03, $A7
	.elseif	.defined(VS_SMB)
		.byte	$03, $80, $13, $26
	.endif
	.byte	$6C, $02, $B3, $22, $E3, $01, $E7, $07, $47, $A0
	.byte	$57, $06, $A7, $01, $D3
	.if	.defined(SMB)
		.byte	$00
	.elseif	.defined(VS_SMB)
		.byte	$01
	.endif
	.byte	$D7, $01, $07, $81, $67, $20
	.byte	$93, $22, $03, $A3, $1C, $61, $17, $21, $6F, $33
	.byte	$C7, $63, $D8, $62, $E9, $61, $FA, $60, $4F, $B3
	.byte	$87, $63, $9C, $01, $B7, $63, $C8, $62, $D9, $61
	.byte	$EA, $60, $39, $F1, $87, $21, $A7, $01, $B7, $20
	.byte	$39, $F1, $5F, $38, $6D, $C1, $AF, $26
	.byte	COURSE_DATA_END

courses_data_overworld_7:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_UNDERGROUND)
.endif
	.byte	$0F, $26, $FE, $10

	.if	.defined(SMB)
		.byte	$2A, $93, $87, $17, $A3, $14
		.byte	$B2, $42, $0A, $92, $19, $40, $36, $14, $50, $41
		.byte	$82, $16, $2B, $93, $24, $41, $BB, $14, $B8, $00
		.byte	$C2, $43, $C3, $13, $1B, $94, $67, $12, $C4, $15
		.byte	$53, $C1, $D2, $41, $12, $C1, $29, $13, $85, $17
		.byte	$1B, $92, $1A, $42, $47, $13, $83, $41, $A7, $13
		.byte	$0E, $91, $A7, $63, $B7, $63, $C5, $65, $D5, $65
		.byte	$DD, $4A, $E3, $67, $F3, $67, $8D, $C1, $AE, $42
		.byte	$DF, $20
	.elseif	.defined(VS_SMB)
		.byte	$8B, $93, $A9, $0B, $1B, $92, $14, $41, $8B, $12
		.byte	$B6, $40, $CC, $16, $CF, $11, $D6, $40, $EB, $12, $2F, $95, $B7, $14, $B7, $97
		.byte	$C6, $45, $2B, $92, $39, $0B, $72, $41, $A7, $00, $D7, $42, $1B, $95, $97, $13
		.byte	$6C, $95, $6F, $11, $A2, $40, $BF, $15, $C2, $40, $0B, $9F, $62, $44, $63, $14
		.byte	$47, $C0, $56, $42, $87, $40, $9B, $1D, $D7, $12, $B7, $E0, $ED, $4A, $03, $E0
		.byte	$8E, $11, $9D, $41, $BE, $42, $EF, $20
	.endif

	.byte	COURSE_DATA_END

courses_data_overworld_8:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.byte	$0F, $26
	.if	.defined(SMB)
		.byte	$6E, $10, $8B, $17, $AF, $32, $D8, $62
		.byte	$E8, $62, $FC, $3F, $AD, $C8, $F8, $64, $0C, $BE
		.byte	$43, $43, $F8, $64, $0C, $BF, $73, $40, $84, $40
		.byte	$93, $40, $A4, $40, $B3, $40, $F8, $64, $48, $E4
		.byte	$5C, $39, $83, $40, $92, $41, $B3, $40, $F8, $64
		.byte	$48, $E4, $5C, $39, $F8, $64, $13, $C2, $37, $65
		.byte	$4C, $24, $63, $00, $97, $65, $C3, $42, $0B, $97
		.byte	$AC, $32, $F8, $64, $0C, $BE, $53, $45, $9D, $48
		.byte	$F8, $64, $2A, $E2, $3C, $47, $56, $43, $BA, $62
		.byte	$F8, $64, $0C, $B7, $88, $64, $BC, $31, $D4, $45
		.byte	$FC, $31, $3C, $B1, $78, $64, $8C, $38, $0B, $9C
		.byte	$1A, $33, $18, $61, $28, $61, $39, $60, $5D, $4A
		.byte	$EE, $11, $0F, $B8, $1D, $C1, $3E, $42, $6F, $20
	.elseif	.defined(VS_SMB)
		.byte	$AF, $32, $D8, $62, $DE, $10, $08, $E4, $5A, $62, $6C, $4C
		.byte	$86, $43, $AD, $48, $3A, $E2, $53, $42, $88, $64, $9C, $36, $08, $E4, $4A, $62
		.byte	$5C, $4D, $3A, $E2, $9C, $32, $FC, $41, $3C, $B1, $83, $00, $AC, $42, $2A, $E2
		.byte	$3C, $46, $AA, $62, $BC, $4E, $C6, $43, $46, $C3, $AA, $62, $BD, $48, $0B, $96
		.byte	$C7, $12, $4C, $C1, $9C, $41, $CD, $48, $DC, $31, $4C, $C2, $BC, $31, $1C, $B1
		.byte	$5A, $62, $6C, $44, $76, $43, $BA, $62, $DC, $32, $1C, $C4, $6C, $31, $8C, $43
		.byte	$28, $E4, $3C, $36, $63, $40, $72, $41, $93, $40, $BC, $31, $EC, $31, $1C, $C3
		.byte	$5A, $62, $97, $12, $F6, $12, $5D, $CA, $73, $12, $E3, $12, $8E, $91, $9D, $41
		.byte	$BE, $42, $EF, $20
	.endif
	.byte	COURSE_DATA_END

courses_data_overworld_9:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
	.byte	$0F, $20, $6E, $40, $F7, $20, $07, $84, $17, $20

	.if	.defined(VS_SMB)
		.byte	$3C, $00
	.endif

	.if	.defined(SMB)
		.byte	$4F
	.elseif	.defined(VS_SMB)
		.byte	$5F
	.endif
	.byte	$34, $C3
	.if	.defined(SMB)
		.byte	$03
	.elseif	.defined(VS_SMB)
		.byte	$07
	.endif
	.byte	$C7, $02, $D3, $22
	.if	.defined(SMB)
		.byte	$27, $E3
	.elseif	.defined(VS_SMB)
		.byte	$26, $E4
	.endif
	.byte	$39, $61, $E7, $73, $5C, $E4, $57, $00, $6C, $73
	.byte	$47, $A0, $53, $06, $63, $22, $A7, $73, $FC, $73
	.byte	$13, $A1, $33, $05, $43, $21, $5C, $72
	.if	.defined(SMB)
		.byte	$C3, $23, $CC, $03
	.elseif	.defined(VS_SMB)
		.byte	$D3, $22, $FC, $05
	.endif
	.byte	$77, $FB, $AC, $02, $39, $F1, $A7, $73
	.byte	$D3, $04, $E8, $72, $E3, $22, $26, $F4, $BC, $02

	.if	.defined(VS_SMB)
		.byte	$2C, $80
	.endif

	.byte	$8C
	.if	.defined(SMB)
		.byte	$81
	.elseif	.defined(VS_SMB)
		.byte	$01
	.endif
	.byte	$A8

	.if	.defined(VS_SMB)
		.byte	$62, $BC, $01, $D8
	.endif

	.byte	$62, $17, $87, $43, $24, $A7, $01
	.byte	$C3, $04, $08, $F2, $97, $21, $A3, $02, $C9, $0B

	.if	.defined(SMB)
		.byte	$E1, $69
	.endif

	.byte	$F1, $69, $8D, $C1, $CF, $26
	.byte	COURSE_DATA_END

courses_data_overworld_10:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_0|COURSE_DATA_ENTER_POS_B0_C|COURSE_DATA_FG_NONE)
	.byte	$0F, $26, $AD, $40, $3D, $C7
	.byte	COURSE_DATA_END

courses_data_overworld_11:
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_WATER)
	.byte	$0F, $26, $0D, $02, $C8, $72, $1C, $81, $38, $72
	.byte	$0D, $05, $97, $34, $98, $62, $A3, $20, $B3, $06
	.byte	$C3, $20, $CC, $03, $F9, $91, $2C, $81, $48, $62
	.byte	$0D, $09, $37, $63, $47, $03, $57, $21, $8C, $02
	.byte	$C5, $79, $C7, $31, $F9, $11, $39, $F1, $A9, $11
	.byte	$6F, $B4, $D3, $65, $E3, $65, $7D, $C1, $BF, $26
	.byte	COURSE_DATA_END

courses_data_overworld_12:
	.word	(COURSE_AREA_LEDGE_CLOUD|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_0|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_FG_NONE)
	.byte	$4C, $00, $F4, $4F, $0D, $02, $02, $42, $43, $4F
	.byte	$52, $C2, $DE, $00, $5A, $C2, $4D, $C7
	.byte	COURSE_DATA_END

courses_data_overworld_13:
	.word	(COURSE_AREA_LEDGE_MUSHROOM|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.byte	$0F, $26, $EE, $10, $0B, $94, $33, $14, $42, $42
	.byte	$77, $16, $86, $44, $02, $92, $4A, $16, $69, $42
	.byte	$73, $14, $B0, $00, $C7, $12, $05, $C0, $1C, $17
	.byte	$1F, $11, $36, $12, $8F, $14, $91, $40, $1B, $94
	.byte	$35, $12, $34, $42, $60, $42, $61, $12, $87, $12
	.byte	$96, $40, $A3, $14, $1C, $98, $1F, $11, $47, $12
	.byte	$9F, $15, $CC, $15, $CF, $11, $05, $C0, $1F, $15

	.if	.defined(SMB)
		.byte	$39, $12
	.endif

	.byte	$7C, $16, $7F, $11, $82, $40

	.if	.defined(SMB)
		.byte	$98, $12
	.endif

	.byte	$DF, $15, $16, $C4, $17, $14, $54, $12, $9B, $16
	.byte	$28, $94
	.if	.defined(SMB)
		.byte	$CE, $01
	.elseif	.defined(VS_SMB)
		.byte	$EE, $11
	.endif
	.byte	$3D, $C1, $5E, $42, $8F, $20
	.byte	COURSE_DATA_END

courses_data_overworld_14:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_UNDERGROUND)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
.endif
	.byte	$0F, $26, $FE, $10, $2B, $92, $57, $12, $8B, $12
	.byte	$C0, $41, $F7, $13, $5B, $92, $69, $0B, $BB, $12
	.byte	$B2, $46, $19, $93, $71, $00, $17, $94, $7C, $14
	.byte	$7F, $11, $93, $41, $BF, $15, $FC, $13, $FF, $11
	.byte	$2F, $95, $50, $42, $51, $12, $58, $14, $A6, $12
	.byte	$DB, $12, $1B, $93, $46, $43, $7B, $12, $8D, $49
	.byte	$B7, $14, $1B, $94, $49, $0B, $BB, $12, $FC, $13
	.byte	$FF, $12, $03, $C1, $2F, $15, $43, $12, $4B, $13
	.byte	$77, $13, $9D, $4A, $15, $C1, $A1, $41, $C3, $12
	.byte	$FE, $01, $7D, $C1, $9E, $42, $CF, $20
	.byte	COURSE_DATA_END

courses_data_overworld_15:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_MNT_BUSH|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.endif
	.byte	$0F, $20, $6E, $44, $0C, $F1, $4C, $01, $AA, $35
	.byte	$D9, $34, $EE, $20, $08, $B3, $37, $32

	.if	.defined(SMB)
		.byte	$43, $04
	.endif

	.byte	$4E, $21

	.if	.defined(SMB)
		.byte	$53, $20
	.endif

	.byte	$7C, $01, $97, $21, $B7, $07
	.byte	$9C, $81, $E7, $42, $5F, $B3

	.if	.defined(VS_SMB)
		.byte	$83, $02
	.endif

	.byte	$97, $63, $AC, $02
	.byte	$C5, $41, $49, $E0, $58, $61, $76, $64, $85, $65
	.byte	$94, $66, $A4, $22

	.if	.defined(SMB)
		.byte	$A6, $03
	.endif

	.byte	$C8, $22, $DC, $02
	.byte	$68, $F2, $96, $42, $13, $82, $17, $02, $AF, $34
	.byte	$F6, $21, $FC, $06, $26, $80, $2A, $24, $36, $01
	.byte	$8C, $00, $FF, $35, $4E, $A0, $55, $21, $77, $20
	.byte	$87, $07, $89, $22, $AE, $21, $4C, $82, $9F, $34
	.byte	$EC
	.if	.defined(SMB)
		.byte	$01
	.elseif	.defined(VS_SMB)
		.byte	$02
	.endif

	.if	.defined(SMB)
		.byte	$03, $E7
	.endif

	.byte	$13
	.if	.defined(SMB)
		.byte	$67
	.elseif	.defined(VS_SMB)
		.byte	$E7
	.endif
	.byte	$8D, $4A, $AD, $41, $0F, $A6
	.byte	COURSE_DATA_END

courses_data_overworld_16:
	.word	(COURSE_AREA_LEDGE_MUSHROOM|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_0|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.byte	$4C, $00, $C7, $12, $C6, $42, $03, $92, $02, $42
	.byte	$29, $12, $63, $12, $62, $42, $69, $14, $A5, $12
	.byte	$A4, $42, $E2, $14, $E1, $44, $F8, $16, $37, $C1
	.byte	$8F, $38, $02, $BB

	.if	.defined(SMB)
		.byte	$28, $7A
	.endif

	.byte	$68, $7A

	.if	.defined(SMB)
		.byte	$A8, $7A
	.endif

	.byte	$E0, $6A, $F0, $6A, $6D, $C5
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
	.byte	$0F, $20, $6E, $40, $0D, $02, $37, $73, $EC, $00
	.byte	$0C, $80, $3C, $00, $6C, $00, $9C, $00, $06, $C0
	.byte	$C7, $73, $06, $83, $28, $72, $96, $40, $E7, $73
	.byte	$26, $C0, $87, $7B, $D2, $41, $39, $F1, $C8, $F2
	.byte	$97, $E3, $A3, $23, $E7, $02, $E3, $07, $F3, $22
	.byte	$37, $E3, $9C, $00, $BC, $00, $EC, $00, $0C, $80
	.byte	$3C, $00, $86, $21, $A6, $06, $B6, $24, $5C, $80
	.byte	$7C, $00, $9C, $00, $29, $E1, $DC, $05, $F6, $41
	.byte	$DC, $80, $E8, $72, $0C, $81, $27, $73, $4C, $01
	.byte	$66, $74, $0D, $11, $3F, $35, $B6, $41, $2C, $82
	.byte	$36, $40, $7C
	.if	.defined(SMB)
		.byte	$02
	.elseif	.defined(VS_SMB)
		.byte	$03
	.endif
	.byte	$86, $40, $F9, $61, $39, $E1
	.byte	$AC, $04, $C6, $41, $0C, $83, $16, $41, $88, $F2
	.byte	$39, $F1, $7C, $00, $89, $61, $9C, $00, $A7, $63
	.byte	$BC, $00, $C5, $65, $DC
	.if	.defined(SMB)
		.byte	$00
	.elseif	.defined(VS_SMB)
		.byte	$01
	.endif

	.if	.defined(SMB)
		.byte	$E3, $67
	.endif

	.byte	$F3, $67, $8D, $C1, $CF, $26
	.byte	COURSE_DATA_END

courses_data_overworld_18:
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_WATER)
	.byte	$0F, $26, $CF, $33, $07, $B2, $15, $11, $52, $42
	.byte	$99, $0B, $AC, $02, $D3
	.if	.defined(SMB)
		.byte	$24
	.elseif	.defined(VS_SMB)
		.byte	$25
	.endif
	.byte	$D6, $42, $D7, $25
	.if	.defined(SMB)
		.byte	$23, $84
	.elseif	.defined(VS_SMB)
		.byte	$4A, $90
	.endif
	.byte	$CF, $33, $07, $E3, $19, $61

	.if	.defined(VS_SMB)
		.byte	$4C, $01
	.endif

	.byte	$78, $7A

	.if	.defined(VS_SMB)
		.byte	$9C, $00
	.endif

	.byte	$EF, $33, $2C, $81, $46, $64, $55, $65, $65, $65
	.byte	$EC, $74

	.if	.defined(VS_SMB)
		.byte	$3C, $81
	.endif

	.if	.defined(SMB)
		.byte	$47, $82, $53, $05
	.elseif	.defined(VS_SMB)
		.byte	$46, $02, $53, $04
	.endif
	.byte	$63, $21, $62, $41, $96, $22, $9A, $41, $CC, $03
	.if	.defined(SMB)
		.byte	$B9, $91
	.elseif	.defined(VS_SMB)
		.byte	$33, $A0, $5C, $01, $83, $20, $B9, $11, $D3, $05
		.byte	$E6, $02
	.endif
	.byte	$39, $F1
	.byte	$63, $26, $67, $27, $D3, $06, $FC, $01, $18, $E2
	.byte	$D9, $07, $E9, $04, $0C, $86, $37, $22, $93, $24
	.byte	$87
	.if	.defined(SMB)
		.byte	$84
	.elseif	.defined(VS_SMB)
		.byte	$82
	.endif
	.byte	$AC, $02, $C2, $41, $C3, $23, $D9, $71
	.byte	$FC, $01, $7F, $B1, $9C, $00, $A7, $63, $B6, $64
	.byte	$CC, $00, $D4, $66, $E3, $67, $F3, $67, $8D, $C1
	.byte	$CF, $26
	.byte	COURSE_DATA_END

courses_data_overworld_19:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
.endif
	.byte	$0F, $26, $FC, $00, $1F, $B3, $5C, $00, $65, $65
	.byte	$74, $66, $83, $67, $93, $67, $DC, $73, $4C, $80
	.byte	$B3, $20, $C9, $0B, $C3
	.if	.defined(SMB)
		.byte	$08
	.elseif	.defined(VS_SMB)
		.byte	$04
	.endif
	.byte	$D3, $2F, $DC, $00
	.byte	$2C, $80, $4C, $00, $8C, $00, $D3, $2E, $ED, $4A
	.byte	$FC, $00

	.if	.defined(SMB)
		.byte	$D7, $A1
	.endif

	.byte	$EC
	.if	.defined(SMB)
		.byte	$01
	.elseif	.defined(VS_SMB)
		.byte	$82
	.endif
	.byte	$4C, $80, $59, $11
	.byte	$D8, $11, $DA, $10, $37, $A0, $47, $04, $99, $11
	.byte	$E7, $21, $3A, $90, $67, $20, $76, $10, $77, $60
	.byte	$87, $07, $D8, $12, $39, $F1, $AC, $00, $E9, $71
	.byte	$0C, $80, $2C, $00, $4C, $05, $C7, $7B, $39, $F1
	.byte	$EC, $00, $F9, $11, $0C, $82, $6F, $34, $F8, $11
	.byte	$FA, $10, $7F, $B2, $AC, $00, $B6, $64, $CC
	.if	.defined(SMB)
		.byte	$01
	.elseif	.defined(VS_SMB)
		.byte	$02
	.endif

	.if	.defined(SMB)
		.byte	$E3, $67
	.endif

	.byte	$F3, $67, $8D, $C1, $CF, $26
	.byte	COURSE_DATA_END

courses_data_overworld_20:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_CANNON|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_WALLS)
.endif
	.byte	$0F, $20, $6E, $45, $39, $91, $B3, $04, $C3, $21
	.byte	$C8, $11, $CA, $10

	.if	.defined(VS_SMB)
		.byte	$0C, $81
	.endif

	.byte	$49
	.if	.defined(SMB)
		.byte	$91
	.elseif	.defined(VS_SMB)
		.byte	$11
	.endif
	.byte	$7C, $73, $E8, $12
	.byte	$88, $91, $8A, $10, $E7, $21, $05, $91, $07, $30
	.byte	$17, $07, $27, $20, $49, $11, $9C, $01, $C8, $72
	.byte	$23
	.if	.defined(SMB)
		.byte	$A6, $27, $26
	.elseif	.defined(VS_SMB)
		.byte	$81, $27, $01, $33, $01, $37, $01, $43, $01, $47
		.byte	$01, $53, $01, $57, $01, $63, $01, $67, $01, $73
		.byte	$01, $77, $01, $83, $01, $87, $01
	.endif
	.byte	$D3, $03, $D8, $7A, $89, $91
	.byte	$D8, $72, $39, $F1, $A9, $11

	.if	.defined(VS_SMB)
		.byte	$EC, $01
	.endif

	.byte	$09, $F1, $63, $24
	.byte	$67, $24, $D8, $62, $28, $91, $2A, $10

	.if	.defined(VS_SMB)
		.byte	$3C, $03
	.endif

	.byte	$56, $21, $70, $04, $79, $0B, $8C, $00, $94, $21
	.byte	$9F, $35

	.if	.defined(VS_SMB)
		.byte	$FC, $52
	.endif

	.byte	$2F, $B8, $3D, $C1, $7F, $26
	.byte	COURSE_DATA_END

courses_data_overworld_21:
	.word	(COURSE_AREA_LEDGE_CLOUD|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_0|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_BG_COL_OVERWORLD)
	.byte	$4C, $00, $F4, $4F, $0D, $02, $06, $20, $24, $4F
	.byte	$35, $A0, $36, $20, $53, $46, $D5, $20, $D6, $20
	.byte	$34, $A1, $73, $49, $74, $20, $94, $20, $B4, $20
	.byte	$D4, $20, $F4, $20, $2E, $80, $59, $42, $4D, $C7
	.byte	COURSE_DATA_END

courses_data_overworld_22:
.if	.defined(SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_OVERWORLD)
.elseif	.defined(VS_SMB)
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_TREE_FENCE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_BG_COL_OVERWORLD)
.endif
	.byte	$0F, $26
	.if	.defined(SMB)
		.byte	$0D, $03, $1A, $60, $77, $42, $C4, $00
		.byte	$C8, $62, $B9, $E1, $D3, $06, $D7, $07, $F9, $61
		.byte	$0C, $81, $4E, $B1, $8E, $B1, $BC, $01, $E4, $50
		.byte	$E9, $61, $0C, $81, $0D, $0A, $84, $43, $98, $72
		.byte	$0D, $0C, $0F, $38, $1D, $C1, $5F, $26
	.elseif	.defined(VS_SMB)
		.byte	$38, $F2, $9E, $00, $AA, $72, $0A, $F2, $3E, $01, $96, $42
		.byte	$CE, $00, $1E, $81, $29, $61, $3A, $60, $4E, $00, $88, $74, $9E, $01, $06, $C3
		.byte	$0A, $E0, $0E, $00, $4E, $01, $57, $63, $67, $63, $78, $62, $89, $61, $9A, $60
		.byte	$AE, $00, $FA, $72, $15, $C1, $49, $73, $8E, $01, $9A, $60, $9A, $E0, $AC, $02
		.byte	$D9, $61, $D4, $06, $EC, $01, $05, $C1, $D6, $42, $84, $C3, $98, $F2, $D3, $04
		.byte	$D7, $07, $E9, $61, $EE, $00, $3E, $81, $A3, $02, $B7, $02, $CE, $00, $E1, $71
		.byte	$E3, $31, $6E, $81, $7A, $60, $E6, $41, $2E, $80, $28, $62, $3E, $01, $99, $71
		.byte	$AE, $00, $CE, $01, $BE, $80, $D6, $60, $F6, $60, $1E, $81, $3C, $00, $5F, $37
		.byte	$5D, $C1, $9F, $26
	.endif
	.byte	COURSE_DATA_END

.if	.defined(VS_SMB)
courses_data_overworld_23:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.byte	$0F, $26, $FE, $10, $2A, $93, $87, $17, $A3, $14, $B2, $42, $0A, $92, $19, $40
	.byte	$36, $14, $50, $41, $82, $16, $2B, $93, $24, $41, $BB, $14, $B8, $00, $C2, $43
	.byte	$C3, $13, $1B, $94, $67, $12, $C4, $15, $53, $C1, $D2, $41, $12, $C1, $29, $13
	.byte	$85, $17, $1B, $92, $1A, $42, $47, $13, $83, $41, $A7, $13, $9E, $91, $A7, $63
	.byte	$B7, $63, $C5, $65, $D5, $65, $DD, $4A, $E3, $67, $F3, $67, $8D, $C1, $AE, $42
	.byte	$DF, $20
	.byte	COURSE_DATA_END

courses_data_overworld_24:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_CLOUD|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_2|COURSE_DATA_ENTER_POS_B0_A|COURSE_DATA_FG_NONE)
	.byte	$0F, $26, $6E, $10, $8B, $17, $AF, $32, $D8, $62, $E8, $62, $FC, $3F, $AD, $C8
	.byte	$F8, $64, $0C, $BE, $43, $43, $F8, $64, $0C, $BF, $73, $40, $84, $40, $93, $40
	.byte	$A4, $40, $B3, $40, $F8, $64, $48, $E4, $5C, $39, $83, $40, $92, $41, $B3, $40
	.byte	$F8, $64, $48, $E4, $5C, $39, $F8, $64, $13, $C2, $37, $65, $4C, $24, $63, $00
	.byte	$97, $65, $C3, $42, $0B, $97, $AC, $32, $F8, $64, $0C, $BE, $53, $45, $9D, $48
	.byte	$F8, $64, $2A, $E2, $3C, $47, $56, $43, $BA, $62, $F8, $64, $0C, $B7, $88, $64
	.byte	$BC, $31, $D4, $45, $FC, $31, $3C, $B1, $78, $64, $8C, $38, $0B, $9C, $1A, $33
	.byte	$18, $61, $28, $61, $39, $60, $5D, $4A, $EE, $11, $0F, $B8, $1D, $C1, $3E, $42
	.byte	$6F, $20
	.byte	COURSE_DATA_END
.endif

	.export courses_data_underground_1
	.export courses_data_underground_2
	.export courses_data_underground_3
courses_data_underground_1:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_15|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_20|COURSE_DATA_FG_NONE)
	.byte	$0E, $01, $5E, $02, $A7, $00, $BC, $73, $1A, $E0
	.byte	$39, $61, $58, $62, $77, $63, $97, $63, $B8, $62
	.byte	$D6, $07, $F8, $62, $19, $E1, $75, $52, $86, $40
	.byte	$87, $50, $95, $52, $93, $43, $A5, $21, $C5, $52
	.byte	$D6, $40, $D7, $20, $E5, $06, $E6, $51, $3E, $8D
	.byte	$5E, $03, $67, $52, $77, $52, $7E, $02, $9E, $03
	.if	.defined(SMB)
		.byte	$A6, $43, $A7, $23
	.elseif	.defined(VS_SMB)
		.byte	$B6, $42, $B7, $22
	.endif
	.byte	$DE, $05, $FE, $02, $1E, $83
	.byte	$33, $54, $46, $40, $47, $21, $56
	.if	.defined(SMB)
		.byte	$04
	.elseif	.defined(VS_SMB)
		.byte	$50
	.endif
	.byte	$5E, $02
	.byte	$83, $54, $93, $52, $96, $07, $97, $50, $BE, $03
	.byte	$C7, $23, $FE, $02, $0C, $82, $43, $45, $45, $24
	.byte	$46, $24, $90
	.if	.defined(SMB)
		.byte	$08
	.elseif	.defined(VS_SMB)
		.byte	$04
	.endif
	.byte	$95, $51, $78, $FA, $D7, $73
	.byte	$39, $F1, $8C, $01, $A8, $52, $B8, $52, $CC, $01
	.byte	$5F, $B3, $97, $63, $9E, $00, $0E, $81, $16, $24
	.byte	$66, $04
	.if	.defined(SMB)
		.byte	$8E
	.elseif	.defined(VS_SMB)
		.byte	$6E
	.endif
	.byte	$00, $FE, $01, $08, $D2

	.if	.defined(VS_SMB)
		.byte	$18, $52
	.endif

	.if	.defined(SMB)
		.byte	$0E
	.elseif	.defined(VS_SMB)
		.byte	$1E
	.endif
	.byte	$06

	.if	.defined(VS_SMB)
		.byte	$5E, $01, $68, $52
	.endif

	.byte	$6F, $47

	.if	.defined(VS_SMB)
		.byte	$78, $52, $7E, $06
	.endif

	.byte	$9E, $0F, $0E, $82, $2D, $47, $28, $7A
	.byte	$68, $7A, $A8, $7A, $AE, $01, $DE, $0F, $6D, $C5
	.byte	COURSE_DATA_END

courses_data_underground_2:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_15|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_20|COURSE_DATA_FG_NONE)
	.byte	$0E, $01, $5E, $02, $BC, $01, $FC, $01, $2C, $82
	.byte	$41, $52, $4E, $04, $67
	.if	.defined(SMB)
		.byte	$25, $68, $24, $69, $24
	.elseif	.defined(VS_SMB)
		.byte	$52, $77, $52, $87, $51, $89, $07, $97, $52, $A7
		.byte	$52, $B7, $50
	.endif
	.byte	$BA, $42, $C7, $04, $DE, $0B, $B2, $87, $FE, $02
	.byte	$2C, $E1, $2C, $71
	.if	.defined(SMB)
		.byte	$67, $01, $77, $00, $87, $01
	.elseif	.defined(VS_SMB)
		.byte	$6C, $72
	.endif
	.byte	$8E, $00, $EE, $01, $F6, $02, $03, $85, $05, $02
	.byte	$13, $21, $16, $02, $27, $02, $2E, $02, $88, $72
	.byte	$C7, $20, $D7, $07, $E4, $76, $07, $A0, $17, $06
	.byte	$48
	.if	.defined(SMB)
		.byte	$7A
	.elseif	.defined(VS_SMB)
		.byte	$72
	.endif
	.byte	$76, $20, $98
	.if	.defined(SMB)
		.byte	$72
	.elseif	.defined(VS_SMB)
		.byte	$7A
	.endif
	.byte	$79, $E1, $88, $62
	.byte	$9C, $01, $B7, $73, $DC, $01, $F8, $62, $FE, $01
	.byte	$08, $E2, $0E, $00, $6E, $02, $73, $20, $77, $23
	.byte	$83, $04, $93
	.if	.defined(SMB)
		.byte	$20
	.elseif	.defined(VS_SMB)
		.byte	$21
	.endif
	.byte	$AE, $00

	.if	.defined(SMB)
		.byte	$FE, $0A
	.endif

	.byte	$0E
	.if	.defined(SMB)
		.byte	$82
	.elseif	.defined(VS_SMB)
		.byte	$81
	.endif
	.byte	$39, $71

	.if	.defined(VS_SMB)
		.byte	$5E, $02
	.endif

	.byte	$A8, $72, $E7, $73, $0C, $81, $8F, $32
	.byte	$AE, $00, $FE, $04, $04
	.if	.defined(SMB)
		.byte	$D1
	.elseif	.defined(VS_SMB)
		.byte	$D3
	.endif
	.byte	$17
	.if	.defined(SMB)
		.byte	$04
	.elseif	.defined(VS_SMB)
		.byte	$2A
	.endif
	.byte	$26, $49

	.if	.defined(SMB)
		.byte	$27, $29
	.endif

	.byte	$DF, $33, $FE, $02, $44, $F6, $7C, $01
	.byte	$8E, $06

	.if	.defined(VS_SMB)
		.byte	$AE, $01
	.endif

	.byte	$BF, $47

	.if	.defined(VS_SMB)
		.byte	$B8, $52, $C8, $52, $D8, $52, $E8, $52
	.endif

	.byte	$EE, $0F, $4D, $C7, $0E, $82
	.byte	$68, $7A, $AE, $01, $DE, $0F, $6D, $C5
	.byte	COURSE_DATA_END

courses_data_underground_3:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_20|COURSE_DATA_FG_NONE)
	.byte	$0E, $01, $00, $5A, $3E, $06, $45, $46, $47, $46
	.byte	$53, $44, $AE, $01, $DF, $4A, $4D, $C7, $0E, $81
	.byte	$00, $5A, $2E, $04, $37, $28, $3A, $48, $46, $47
	.byte	$C7, $07, $CE, $0F, $DF, $4A, $4D, $C7, $0E, $81
	.byte	$00, $5A, $33, $53, $43, $51, $46, $40, $47, $50
	.byte	$53, $04, $55, $40, $56, $50, $62, $43, $64, $40
	.byte	$65, $50, $71, $41, $73, $51, $83, $51, $94, $40
	.byte	$95, $50, $A3, $50, $A5, $40, $A6, $50, $B3, $51
	.byte	$B6, $40, $B7, $50, $C3, $53, $DF, $4A, $4D, $C7
	.byte	$0E, $81, $00, $5A, $2E, $02, $36, $47, $37, $52
	.byte	$3A, $49, $47, $25, $A7, $52, $D7, $04, $DF, $4A
	.byte	$4D, $C7, $0E, $81, $00, $5A, $3E, $02, $44, $51
	.byte	$53, $44, $54, $44, $55, $24, $A1, $54, $AE, $01
	.byte	$B4, $21, $DF, $4A, $E5, $07, $4D, $C7
	.byte	COURSE_DATA_END

	.export courses_data_water_1
	.export courses_data_water_2
	.export courses_data_water_3
.if	.defined(VS_SMB)
	.export courses_data_water_4
.endif
courses_data_water_1:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_FG_WATER)
	.byte	$B4, $34, $C8, $52, $F2, $51, $47, $D3, $6C, $03
	.byte	$65, $49, $9E, $07, $BE, $01, $CC, $03, $FE, $07
	.byte	$0D, $C9, $1E, $01, $6C, $01, $62, $35, $63, $53
	.byte	$8A, $41, $AC, $01, $B3, $53, $E9, $51, $26, $C3
	.byte	$27, $33, $63, $43, $64, $33, $BA, $60, $C9, $61
	.byte	$CE, $0B
	
	.if	.defined(VS_SMB)
		.byte	$E4, $60
	.endif

	.byte	$E5, $09, $EE, $0F, $7D, $CA, $7D, $47
	.byte	COURSE_DATA_END

courses_data_water_2:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_FG_WATER)
	.if	.defined(SMB)
		.byte	$B8, $52, $EA, $41, $27, $B2, $B3, $42, $16, $D4
		.byte	$4A, $42, $A5, $51, $A7, $31, $27, $D3, $08, $E2
		.byte	$16, $64, $2C, $04, $38, $42, $76, $64, $88, $62
		.byte	$DE, $07, $FE, $01, $0D, $C9, $23, $32, $31, $51
		.byte	$98, $52, $0D, $C9, $59, $42, $63, $53, $67, $31
		.byte	$14, $C2, $36, $31, $87, $53, $17, $E3, $29, $61
		.byte	$30, $62, $3C, $08, $42, $37, $59, $40, $6A, $42
		.byte	$99, $40, $C9, $61, $D7, $63, $39, $D1, $58, $52
		.byte	$C3, $67, $D3, $31, $DC, $06, $F7, $42, $FA, $42
		.byte	$23, $B1, $43, $67, $C3, $34, $C7, $34, $D1, $51
		.byte	$43, $B3, $47, $33
	.elseif	.defined(VS_SMB)
		.byte	$27, $D3, $79, $51, $C4, $56, $0C, $8E, $1D, $49, $39, $40, $4A, $42, $79, $40
		.byte	$A5, $57, $FC, $0F, $00, $E2, $03, $53, $12, $3B, $1A, $42, $43, $54, $83, $53
		.byte	$99, $53, $C3, $54, $DA, $52, $FC, $05, $09, $D3, $53, $64, $63, $31, $67, $34
		.byte	$86, $41, $8C, $01, $A3, $30, $B3, $64, $CC, $03, $D9, $42, $5C, $84, $A0, $62
		.byte	$A8, $62, $B0, $62, $B8, $62, $C0, $62, $C8, $62, $D0, $62, $D8, $62, $E0, $62
		.byte	$E8, $62, $16, $C2, $58, $52, $8C, $04, $A7, $55, $D0, $63, $D7, $65, $E2, $61
		.byte	$E7, $65, $F2, $61, $F7, $65, $13, $B8, $17, $38, $8C, $03, $1D, $C9, $50, $62
		.byte	$5C, $0B, $62, $3E, $63, $52, $8A, $52, $93, $54, $AA, $42, $D3, $51, $EA, $41
		.byte	$03, $D3, $1C, $04, $1A, $52, $33, $55, $73, $44, $77, $44, $16, $D2, $19, $31
		.byte	$1A, $32, $5C, $0F, $9A, $47, $95, $64, $A5, $64, $B5, $64, $C5, $64, $D5, $64
		.byte	$E5, $64, $F5, $64, $05, $E4, $40, $61, $42, $35, $56, $34, $5C, $09, $A2, $61
		.byte	$A6, $61, $B3, $34, $B7, $34, $FC, $0B, $0A, $C2, $4A, $41, $3A, $52, $68, $54
		.byte	$C9, $51, $0C, $87, $28, $54, $59, $53
	.endif

	.byte	$9A, $30, $A9, $61, $B8, $62, $BE, $0B

	.if	.defined(VS_SMB)
		.byte	$D4, $60
	.endif

	.byte	$D5, $09, $DE, $0F, $0D, $CA, $7D, $47
	.byte	COURSE_DATA_END

courses_data_water_3:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_15|COURSE_TIMER_SETTING_1|COURSE_DATA_ENTER_POS_20|COURSE_DATA_FG_WATER)
	.byte	$1E, $01, $39, $73, $5E, $07, $AE, $0B, $1E, $82
	.byte	$6E, $88, $9E, $02, $0D, $04, $2E, $0B

	.if	.defined(VS_SMB)
		.byte	$44, $50
	.endif

	.byte	$45, $09, $4E, $0F, $ED, $47
	.byte	COURSE_DATA_END

.if	.defined(VS_SMB)
courses_data_water_4:
	.word	(COURSE_AREA_LEDGE_TREE|COURSE_BG_NONE|COURSE_FG_MASK_1|COURSE_TIMER_SETTING_3|COURSE_DATA_ENTER_POS_00_A|COURSE_DATA_FG_WATER)
        .byte   $B8, $52, $EA, $41, $27, $B2, $B3, $42, $16, $D4, $4A, $42, $A5, $51, $A7, $31
        .byte   $27, $D3, $08, $E2, $16, $64, $2C, $04, $38, $42, $76, $64, $88, $62, $DE, $07
        .byte   $FE, $01, $0D, $C9, $23, $32, $31, $51, $98, $52, $0D, $C9, $59, $42, $63, $53
        .byte   $67, $31, $14, $C2, $36, $31, $87, $53, $17, $E3, $29, $61, $30, $62, $3C, $08
        .byte   $42, $37, $59, $40, $6A, $42, $99, $40, $C9, $61, $D7, $63, $39, $D1, $58, $52
        .byte   $C3, $67, $D3, $31, $DC, $06, $F7, $42, $FA, $42, $23, $B1, $43, $67, $C3, $34
        .byte   $C7, $34, $D1, $51, $43, $B3, $47, $33, $9A, $30, $A9, $61, $B8, $62, $BE, $0B
        .byte   $D4, $60, $D5, $09, $DE, $0F, $0D, $CA, $7D, $47
	.byte	COURSE_DATA_END
.endif
