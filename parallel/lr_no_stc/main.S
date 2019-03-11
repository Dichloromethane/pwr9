.abiversion 2

.include "../../include/asm/macros.S"

.section ".toc"
.align 4

fmtstrp:
	.quad fmtstr

.rodata
.align 4

fmtstr:
	.asciz "%lx\n"

.text
.align 4

.tfunc main
    mflr %r0
	std %r0, 16(%sp)
	stdu %sp, -32(%sp)
    li %r3, 0
	lis %r5, (1<<10)
    ldarx %r4, %r3, %sp, 0
	mfpmc6 %r6
    mtctr %r5
loop:
    addi %r4, %r4, 1
	bdnz loop
	mfpmc6 %r7
	sub %r4, %r7, %r6
	ld %r3, fmtstrp@toc(%rtoc)
	bl printf
	nop
	ld %sp, 0(%sp)
	ld %r0, 16(%sp)
	mtlr %r0
	blr

