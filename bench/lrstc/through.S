.abiversion 2

.include "../../include/asm/macros.S"

.section ".toc"

.align 4
incpp: .quad incp

.data

.align 4
incp: .quad 0xDEADBEEF

.text

.tfunc ld_ref
  mtctr %r3 
  ld %r4, incpp@toc(%rtoc)
  mfpmc6 %r5
.nopalign 4
ldl:
  ld %r3, 0(%r4)
  addi %r3, %r3, 1
  std %r3, 0(%r4)
  bdnz ldl
.nopalign 4
  mfpmc6 %r6
  sub %r3, %r6, %r5
  blr

.macro lrstc_inc_eh eh
  .tfunc lrstc_inc_eh_\eh
    mtctr %r3 
	ld %r4, incpp@toc(%rtoc)
	mfpmc6 %r5
  .nopalign 4
  leh\eh:
    ldarx %r3, 0, %r4, \eh
    addi %r3, %r3, 1
    stdcx. %r3, 0, %r4
    bne leh\eh
    bdnz leh\eh
  .nopalign 4
    mfpmc6 %r6
	sub %r3, %r6, %r5
    blr
.endm

lrstc_inc_eh 0
lrstc_inc_eh 1

.tfunc latom_inc
  mtctr %r3 
  ld %r6, incpp@toc(%rtoc)
  li %r4, 1
  mfpmc6 %r5
.nopalign 4
latom:
  ldat %r3, %r6, 0
  bdnz latom
.nopalign 4
  mfpmc6 %r6
  sub %r3, %r6, %r5
  blr

