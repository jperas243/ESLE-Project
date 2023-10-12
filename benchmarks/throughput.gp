set terminal pdf
set output 'throughput.pdf'
#use the first and second columns from the file throughput.dat


set xlabel 'Test'
set ylabel 'Throughput (op/s)'
set title 'Single Node Performance (Concurrency=4)'

plot 'throughput-1.dat' using 1:2 title "throughput"

set xlabel 'Concurrency'
set ylabel 'Throughput (op/s)'
set title 'Single Node Performance for Increassing Workloud'

plot 'throughput-2.dat' using 1:2 title "throughput"

set xlabel 'Size of System (N)'
set ylabel 'Throughput (op/s)'
set title 'Increasing Size Performance over the Same Workloud'


plot 'throughput-3.dat' using 1:2 title "throughput"



plot 'throughput-4.dat' using 1:2 title "throughput"

set xlabel 'Concurrency'
set ylabel 'Throughput (op/s)'
set title 'Application Throughput'

plot 'throughput-5.dat' using 1:2 title "throughput"
