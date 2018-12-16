#include<stdio.h>
#include<stdlib.h>

double through_xsadddp(long);
double through_xsadddp_dr(long);
double through_xvadddp(long);
double through_addi(long);
double through_clzd(long);

#ifndef NS
#define NS 15
#endif


#define N (1<<NS)

int
main(int argc, char **argv)
{
  double d1, d2, d3, d4, d5;
  d1 = through_xsadddp(N);
  d5 = through_xsadddp_dr(N);
  d2 = through_xvadddp(N);
  d3 = through_addi(N);
  d4 = through_clzd(N);
  printf("%8.3f %8.3f %8.3f %8.3f %8.3f\n", d1, d2, d3, d4, d5);
  return 0;
}
