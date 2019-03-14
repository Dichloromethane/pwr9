#include<stdio.h>

long ref(void);
long blr_malign(void);
long blr_malign_dispatch_interlock(void);

int
main(int argc, char **argv)
{
  long m1, m2, m3;
  ref(); // load L1I$
  m1 = ref();
  blr_malign(); // load L1I$
  m2 = blr_malign();
  blr_malign_dispatch_interlock(); // load L1I$
  m3 = blr_malign_dispatch_interlock();
  printf("%ld %ld %ld\n", m1, m2, m3);
}
