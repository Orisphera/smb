.segment	"SAVDATA"

	.export	save
save:
	.include	"./save.fds.data.s"

	.assert	save = save_b, warning, "save and save_b misaligned, fix link.ld"