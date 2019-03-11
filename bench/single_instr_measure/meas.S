.abiversion 2

.include "../../include/asm/macros.S"

.text

.function ref, 1
  mfspr %r3, 776
  mfspr %r4, 776
  sub %r3, %r4, %r3
  blr


start_misalign_far_away:
  b start_misalign
.rept 32
  nop // actually make it far away
.endr

.function blr_malign, 1
  mflr %r0
  std %r0, -8(%sp)
  bl start_misalign_far_away // Push start_misalign_far_away on top 
  							 // of the link stack
  nop
start_misalign:
  lnia %r3
  addi %r3, %r3, mispredict-.
  mtlr %r3
  blr // cause a pipline flush by forcing a misprediction
      // top(linkstack) = start_misalign_far_away 
	  // lr = mispredict
mispredict:
  mfspr %r3, 776
  mfspr %r4, 776
  sub %r3, %r4, %r3
  ld %r0, -8(%sp)
  mtlr %r0
  blr


     


