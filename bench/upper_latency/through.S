.abiversion 2

#ifndef NUM_INSTR
#define NUM_INSTR 12
#endif

.include "../../include/asm/macros.S"

.function latency_upper, 1
  mtctr %r3
  li %r4, 1
  init_vsx_r_r %vs1, %r4
.rept 6*10
  nop
.endr
  mfspr %r4, 776
loop:
.rept NUM_INSTR
  xsadddp %vs1, %vs1, %vs1
  mfvsrd %r5, %vs1
  mtvsrd %vs1, %r5
.endr
  bdnz loop
  mfspr %r5, 776
  sub %r4, %r5, %r4
  mulli %r3, %r3, NUM_INSTR
  double_cast_div %vs1, %r3, %r4, %vs2
  blr
  

