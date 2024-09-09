.include	"engine/mem.i"

tbljmp_tbl_ptr		= zp_addr_04
tbljmp_target_ptr	= zp_addr_06

	.export tbljmp
tbljmp:
	asl	a
	tay
	pla
	sta	tbljmp_tbl_ptr
	pla
	sta	tbljmp_tbl_ptr+1
	iny
	lda	(tbljmp_tbl_ptr), y
	sta	tbljmp_target_ptr
	iny
	lda	(tbljmp_tbl_ptr), y
	sta	tbljmp_target_ptr+1
	jmp	(tbljmp_target_ptr)
