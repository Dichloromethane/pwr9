
.macro mfpmc6 r
  mfspr \r, 776
.endm

.macro mfpmc5 r
  mfspr \r, 775
.endm

.macro double_cast_div vt, ra, rb, via
	mtvsrd \vt, \rb
	xscvsxddp \vt, \vt
	mtvsrd \via, \ra
	xscvsxddp \via, \via
	xsdivdp \vt, \vt, \via
.endm

.macro init_vsx_r_r v, r
	mtvsrd \v, \r
	xscvsxddp \v, \v
	xxspltd \v, \v, 0
.endm

.macro function name, globl=0
	.if \globl
  		.globl \name
 	.endif
    .type \name,@function
	.align 4
	\name:
.endm

.macro .tfunc name
  function \name, 1
0:  addis 2,12,.TOC.-\name@ha
    addi 2,2,.TOC.-\name@l
  .localentry \name,.-\name
.endm

.macro .function name, globl=0
  function \name, \globl
.endm

.macro nopalign length
  .p2alignl \length, 0x60000000
.endm

.macro .nopalign length
  nopalign \length
.endm
