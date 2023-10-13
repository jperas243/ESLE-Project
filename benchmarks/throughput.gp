set terminal pdf
set output 'throughput.pdf'
#use the first and second columns from the file throughput.dat

set xlabel 'Size of System (N)'
set ylabel 'Throughput (op/s)'
set title 'Increasing Size Performance over Increasing Workloud'

plot 'throughput-4.dat' using 1:2 title "throughput"
