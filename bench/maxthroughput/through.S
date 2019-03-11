.abiversion 2

.include "../../include/asm/macros.S"

#ifndef NUM_INSTR
#define NUM_INSTR 5
#endif

.function through_xsadddp, 1
  mtctr %r3 
  li %r4, 1
  init_vsx_r_r %vs1, %r4
  hwsync
  isync
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

.function through_fused, 1
  mtctr %r3 
  mfspr %r5, 776
.nopalign 4
fused_loop:
.rept NUM_INSTR
//  oris %r7, 0, 1
//  ori %r7, %r7, 1
  lis %r7, 1
  addi %r7, %r7, 1
.endr
  bdnz fused_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, 2*NUM_INSTR
  double_cast_div %vs1, %r5, %r3, %vs2  
  blr

.function through_ld, 1
  mtctr %r3 
  mfspr %r5, 776
.nopalign 4
ld_loop:
.rept NUM_INSTR
  ld %r6, -16(%sp)
  ld %r6, -24(%sp)
  ld %r6, -32(%sp)
  ld %r6, -40(%sp)
.endr
  bdnz ld_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, 4*NUM_INSTR
  double_cast_div %vs1, %r5, %r3, %vs2  
  blr

.function through_lddr, 1
  mtctr %r3 
  std %r13, -8(%sp)
  mfspr %r5, 776
.nopalign 4
lddr_loop:
.rept NUM_INSTR
  ld %r6, -16(%sp)
  ld %r7, -24(%sp)
  ld %r8, -32(%sp)
  ld %r9, -40(%sp)
  ld %r10, -48(%sp)
  ld %r11, -56(%sp)
  ld %r12, -64(%sp)
  ld %r13, -72(%sp)
.endr
  bdnz lddr_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, 8*NUM_INSTR
  double_cast_div %vs1, %r5, %r3, %vs2  
  ld %r13, -8(%sp)
  blr

.function through_li, 1
  mtctr %r3 
  mfspr %r5, 776
.nopalign 4
li_loop:
.rept NUM_INSTR
  addi %r6, 0, 1
.endr
  bdnz li_loop
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
	.set i,i+1
  .endr

  li %r4, 1
  init_vsx_r_r %vs0, %r4

  mfspr %r5, 776
.nopalign 4
xsadddp_dr_loop:
  .set i, 1
  .rept pipel*4-1
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
	.set i, i+1
  .endr
  blr

.function through_fused2, 1
  mtctr %r3 
  li %r9, 0
  mfspr %r5, 776
.nopalign 4
fused2_loop:
.rept NUM_INSTR
  addi %r8, %sp, -8
  ldx %r8, %r8, %r9
  addi %r8, %sp, -16
  ldx %r8, %r8, %r9
  addi %r8, %sp, -24
  ldx %r8, %r8, %r9
  addi %r8, %sp, -32
  ldx %r8, %r8, %r9
.endr
  bdnz fused2_loop
.nopalign 4
  mfspr %r6, 776
  sub %r5, %r6, %r5
  mulli %r3, %r3, 8*NUM_INSTR
  double_cast_div %vs1, %r5, %r3, %vs2  
  blr
