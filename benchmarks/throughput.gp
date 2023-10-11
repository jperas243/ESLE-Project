set terminal pdf
set output 'throughput.pdf'
#use the first and second columns from the file throughput.dat


set xlabel 'Concurrency'
set ylabel 'Throughput (op/s)'
set title 'Application Throughput'

plot 'throughput-1.dat' using 1:2 title "throughput"
plot 'throughput-2.dat' using 1:2 title "throughput"
plot 'throughput-3.dat' using 1:2 title "throughput"
plot 'throughput-4.dat' using 1:2 title "throughput"
plot 'throughput-5.dat' using 1:2 title "throughput"
