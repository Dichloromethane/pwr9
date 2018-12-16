#! /usr/bin/env bash

printf "%8s %8s %8s %8s %8s\n" "num" "xsadddp" "xvadddp" "addi" "clzd" > out.dat

for i in `seq 32`; do 
  printf "%8d " $i >> out.dat
  gcc -DNUM_INSTR=$i main.c through.S && ./a.out >> out.dat; 
done

rm -f a.out

gnuplot -p -e 'plot for [col=2:5] "out.dat" using 1:col with linespoints'
