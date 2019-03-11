.abiversion 2

.include "../../include/asm/macros.S"

#include"through.h"

.function through_rel, 1
  mtctr %r3 
  li %r4, 1
  init_vsx_r_r %vs1, %r4
  eieio
  eieio
  mfspr %r5, 776
.nopalign 4
xsadddp_loop:
#if 1
.rept 8
  xsadddp %vs2, %vs1, %vs1
.endr
#else
  xsadddp %vs2, %vs1, %vs1
  xsadddp %vs3, %vs1, %vs1
  xsadddp %vs4, %vs1, %vs1
  xsadddp %vs5, %vs1, %vs1
  xsadddp %vs6, %vs1, %vs1
  xsadddp %vs7, %vs1, %vs1
  xsadddp %vs8, %vs1, %vs1
  xsadddp %vs9, %vs1, %vs1
#endif
.rept NUM_INSTR
  addi %r6, %r3, 1
.endr
  bdnz xsadddp_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, NUM_INSTR+8
  double_cast_div %vs1, %r5, %r3, %vs2  
  blr
