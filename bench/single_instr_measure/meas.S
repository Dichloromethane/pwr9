.abiversion 2

.include "../../include/asm/macros.S"

#ifndef NUM_INSTR
#define NUM_INSTR 0
#endif

.text

.function ref, 1
  mfspr %r3, 776
.rept NUM_INSTR
  addi %r6, %r5, 1
.endr
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
.rept NUM_INSTR
  addi %r6, %r5, 1
.endr
  mfspr %r4, 776
  sub %r3, %r4, %r3
  ld %r0, -8(%sp)
  mtlr %r0
  blr

// Same setup at the previous one
start_misalign_far_away_2:
  b start_misalign_2
.rept 32
  nop 
.endr

.function blr_malign_dispatch_interlock, 1
  mflr %r0
  std %r0, -8(%sp)
  mfspr %r7, 800
  bl start_misalign_far_away_2 
  nop

start_misalign_2:
  lnia %r3
  addi %r3, %r3, mispredict_2-.
  mtlr %r3
  blr 

mispredict_2:
  mfspr %r3, 776
.rept NUM_INSTR
  addi %r6, %r5, 1
.endr
  mtspr 800, %r7 // assert dispatch interlock
   				 // this will prevent dispatch of the
				 // mfpmc6 instruction until this instruction
				 // is cleared from the ICT
				 // this makes sure that all instructions have
				 // executed before the time is measured
  mfspr %r4, 776
  sub %r3, %r4, %r3
  ld %r0, -8(%sp)
  mtlr %r0
  blr
