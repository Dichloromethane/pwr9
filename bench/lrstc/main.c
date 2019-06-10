#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include<omp.h>

#define N ((uint64_t) 1<<30)

#ifdef _OPENMP
#define NEFF (N*omp_get_max_threads())
#else
#define NEFF (N)
#endif

uint64_t ld_ref(long);
uint64_t lrstc_inc_eh_0(long);
uint64_t lrstc_inc_eh_1(long);
uint64_t lrstc_inc_lock_eh_0(long);
uint64_t lrstc_inc_lock_eh_1(long);
uint64_t latom_inc(long);

int
main(int argc, char **argv)
{
  uint64_t res, tmp;
  res = ld_ref(N);
  printf("Plain ld (ref): %ld\n", res/N);
  res = lrstc_inc_eh_1(N);
  printf("Atomic, no contention: %ld\n", res/N);
  res = lrstc_inc_eh_0(N);
  printf("EH=0, no contention: %ld\n", res/N);
  res = lrstc_inc_eh_1(N);
  printf("EH=1, no contention: %ld\n", res/N);
  res = lrstc_inc_lock_eh_0(N);
  printf("EH=0, locking, no contention: %ld\n", res/N);
  res = lrstc_inc_lock_eh_1(N);
  printf("EH=1, locking, no contention: %ld\n", res/N);
  res = 0;
#pragma omp parallel reduction(+:res)
  {
	tmp = latom_inc(N);
	res += tmp;
  }
  printf("Atomic, high contention: %ld\n", res/NEFF);
#pragma omp parallel reduction(+:res)
  {
	tmp = lrstc_inc_eh_0(N);
	res += tmp;
  }
  printf("EH=0, high contention: %ld\n", res/NEFF);
#pragma omp parallel reduction(+:res)
  {
	tmp = lrstc_inc_eh_1(N);
	res += tmp;
  }
  printf("EH=1, high contention: %ld\n", res/NEFF);
#pragma omp parallel reduction(+:res)
  {
	tmp = lrstc_inc_lock_eh_0(N);
	res += tmp;
  }
  printf("EH=0, locking, high contention: %ld\n", res/NEFF);
#pragma omp parallel reduction(+:res)
  {
	tmp = lrstc_inc_lock_eh_1(N);
	res += tmp;
  }
  printf("EH=1, locking, high contention: %ld\n", res/NEFF);
}
