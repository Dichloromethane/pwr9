.abiversion 2

.include "../../include/asm/macros.S"


.data
.align 4

.globl incp
incp: 
	.quad 0x0
	.quad 0x0


.section ".toc"
.align 4

incpp: 
	.quad incp


.text
.align 4

.tfunc double_inc
	mtctr %r3
	ld %r4, incpp@toc(%rtoc)
	li %r6, 8
.nopalign 4
dll:
	ldarx %r3, %r6, %r4, 0
	lwsync
	ld %r5, 0(%r4)
	addi %r3, %r3, 1
	addi %r5, %r5, 1 
	std %r5, 0(%r4)
	lwsync
	stdcx. %r3, %r6, %r4
	bne- dll
	bdnz dll
.nopalign 4
	blr

.tfunc get_count
   ld %r3, incpp@toc(%rtoc)
   ld %r3, 0(%r3)
   blr
