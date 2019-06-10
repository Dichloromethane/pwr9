#! /usr/bin/env bash

printf "%8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s\n" "num" "xsadddp" "xvadddp" "addi" "clzd" "xsad3pdr" "fused" "li" "fused2" "ld" "lddr" "mr" "mtvsr"> out.dat

for i in `seq 32`; do 
  printf "%8d " $i >> out.dat
  gcc -DNUM_INSTR=$i main.c through.S && ./a.out >> out.dat; 
done

#rm -f a.out

# gnuplot -p -e 'plot for [col=2:13] "out.dat" using 1:col w lp t columnheader(col)'
