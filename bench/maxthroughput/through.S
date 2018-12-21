.abiversion 2

.include "../../include/asm/macros.S"

#ifndef NUM_INSTR
#define NUM_INSTR 5
#endif

.function through_xsadddp, 1
  mtctr %r3 
  li %r4, 1
  init_vsx_r_r %vs1, %r4
  mfspr %r5, 776
.nopalign 4
xsadddp_loop:
.rept NUM_INSTR
  xsadddp %vs2, %vs1, %vs1
.endr
  bdnz xsadddp_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, NUM_INSTR
  double_cast_div %vs1, %r5, %r3, %vs2  
  blr

.function through_xvadddp, 1
  mtctr %r3 
  li %r4, 1
  init_vsx_r_r %vs1, %r4
  mfspr %r5, 776
.nopalign 4
xvadddp_loop:
.rept NUM_INSTR
  xvadddp %vs2, %vs1, %vs1
.endr
  bdnz xvadddp_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5

  mulli %r3, %r3, NUM_INSTR
  double_cast_div %vs1, %r5, %r3, %vs2  
  blr

.function through_addi, 1
  mtctr %r3 
  mfspr %r5, 776
.nopalign 4
addi_loop:
.rept NUM_INSTR
  addi %r4, %r3, 1
.endr
  bdnz addi_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, NUM_INSTR
  double_cast_div %vs1, %r5, %r3, %vs2  
  blr

.function through_clzd, 1
  mtctr %r3 
  mfspr %r5, 776
.nopalign 4
clz_loop:
.rept NUM_INSTR
  cntlzd %r4, %r3
.endr
  bdnz clz_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, NUM_INSTR
  double_cast_div %vs1, %r5, %r3, %vs2  
  blr

.set pipel, 8
.set svsx, 14
.function through_xsadddp_dr, 1
  mtctr %r3
  .set i, 0
  .rept pipel*4-svsx
    stxv i+svsx, -(i+1)*16(%sp)
  .endr

  li %r4, 1
  init_vsx_r_r %vs0, %r4

  mfspr %r5, 776
.nopalign 4
xsadddp_dr_loop:
  .set i, 1
  .rept pipel*4
    xsadddp i, %vs0, %vs0
	.set i, i+1
  .endr
  bdnz xsadddp_dr_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, pipel*4
  double_cast_div %vs1, %r5, %r3, %vs2  

  .set i, 0
  .rept pipel*4-svsx
    lxv i+svsx, -(i+1)*16(%sp)
  .endr
  blr
