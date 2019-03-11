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

#ifndef NS
#define NS 15
#endif


#define N (1<<NS)

int
main(int argc, char **argv)
{
  double d1, d2, d3, d4, d5, d6, d7, d8, d9, d10;
  d1 = through_xsadddp(N);
  d2 = through_xvadddp(N);
  d3 = through_addi(N);
  d4 = through_clzd(N);
  d5 = through_xsadddp_dr(N);
  d6 = through_fused(N);
  d7 = through_li(N);
  d8 = through_fused2(N);
  d9 = through_ld(N);
  d10 = through_lddr(N);
  printf("%8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f\n", d1, d2, d3, d4, d5, d6, d7, d8, d9, d10);
  return 0;
}
