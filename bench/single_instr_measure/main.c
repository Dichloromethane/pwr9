#include<stdio.h>

long ref(void);
long blr_malign(void);

int
main(int argc, char **argv)
{
  long m1, m2;
  m1 = ref();
  m2 = blr_malign();
  printf("%ld, %ld\n", m1, m2);
}
