#include<stdio.h>
#include<stdint.h>
#include<omp.h>

#define N (1<<15)

#ifdef _OPENMP
#define EFF_N (N*omp_get_max_threads())
#else
#define EFF_N (N)
#endif

void double_inc(uint64_t);
uint64_t get_count();

int
main(int argc, char **argv)
{
#pragma omp parallel 
	double_inc(N);
  printf("%#lx, %f\n", get_count(), ((double) get_count())/EFF_N);
  return 0;
}
