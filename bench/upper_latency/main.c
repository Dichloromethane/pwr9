#include<stdio.h>
#include<stdint.h>

double latency_upper(uint64_t);

#define N 1<<13

int
main(int argc, char **argv)
{
  double d;
  latency_upper(4);
  d = latency_upper(N);
  printf("%f\n", d);
}
