#include<stdio.h>
#include<stdlib.h>

double through_xsadddp(long);
double through_xsadddp_dr(long);
double through_xvadddp(long);
double through_addi(long);
double through_clzd(long);
double through_fused(long);
double through_fused2(long);
double through_li(long);
double through_ld(long);
double through_lddr(long);
double through_mr(long);
double through_mtvsr(long);

#ifndef NS
#define NS 15
#endif

#define N (1<<NS)

int
main(int argc, char **argv)
{
  double d12;
  d12 = through_mtvsr(N);
  d12 = through_mtvsr(N);
  printf("%8.3f\n", d12);
  return 0;
}
