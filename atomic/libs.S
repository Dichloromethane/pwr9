
.abiversion 2

.text

.globl fetch_add_atomic
.type fetch_add_atomic,@function

.globl load_reserve
.type load_reserve,@function

.globl store_conditional
.type store_conditional,@function

fetch_add_atomic:
	lwat %r3, %r3, 0
	blr

load_reserve:
	ldarx %r3, 0, %r3, 0
	blr

store_conditional:
	stdcx. %r4, 0, %r3
	bne sterror
	li %r3, 0
	blr	
sterror:
	li %r3, 1
	blr


