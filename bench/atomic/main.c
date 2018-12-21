
#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>

#define NUM (10000000)

#if defined(LD)
#define	WORK ld_work	
#elif defined(ATOMIC)
#define	WORK atomic_work
#elif defined(LR_STC)
#define WORK lrstc_work
#else
#error "Specify the kind of task you wish to run: LD, ATOMIC or LR_STC"
#endif

int fetch_add_atomic(volatile uint64_t *, int);

uint64_t load_reserve(volatile uint64_t *);
int store_conditional(volatile uint64_t *, uint64_t);

volatile uint64_t res __attribute__((aligned(8)));
volatile uint64_t errs __attribute__((aligned(8)));

void
atomic_work(void) {
	int i;
	for (i = 0; i < NUM; i++)
		fetch_add_atomic(&res, 1);
}

void
lrstc_work(void) {
	int i, temp;
	for (i = 0; i < NUM; i++) {
		do {
			temp = load_reserve(&res);
			temp++;
		} while(store_conditional(&res, temp));
	}
}


void
lrstc_work_ec(void) {
	int i, temp, sr;
	for (i = 0; i < NUM; i++) {
		while(1) {
			temp = load_reserve(&res);
			temp++;
			sr = store_conditional(&res, temp);
			if (sr)
				fetch_add_atomic(&errs, 1);
			else
				break;
		}
	}
}

void
ld_work(void) {
	int i, temp, sr;
	for (i = 0; i < NUM; i++) {
		temp = res;
		temp++;
		res = temp;
	}
}

int
main(int argc, char **argv) {
	res = 0;
	errs = 0;
#pragma omp parallel
	{
	  WORK();
	}
	
	printf("%ld:%ld\n", res, errs);
	return 0;
}


