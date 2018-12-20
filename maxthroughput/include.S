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
	\name:
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
