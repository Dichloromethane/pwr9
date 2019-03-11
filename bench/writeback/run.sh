#! /usr/bin/env bash

for i in {0..10}; do
  echo > "out$i.dat";
done

for i in {0..200}; do
  echo "Doing NUM_INSTR=$i" >&2
  gcc -DNS=12 -DNUM_XSADDDP=8 -DNUM_INSTR=$i main.c through.S
  for j in {0..10}; do
    ./a.out >> "out$j.dat"
  done
done

gnuplot -p -e 'plot for [i=0:10] sprintf("out%d.dat", i) w lp title sprintf("Run %d", i)'
