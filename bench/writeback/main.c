#include<stdio.h>
#include<stdlib.h>

#include"through.h"

#ifndef NS
#define NS 15
#endif

#define N (1<<NS)

double through_rel(long);

int
main(int argc, char **argv)
{
  double d1;
  d1 = through_rel(N);
  d1 = through_rel(N);
  printf("%d %f\n", NUM_INSTR, d1);
  return 0;
}
