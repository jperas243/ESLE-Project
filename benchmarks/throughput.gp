set terminal pdf
set output 'throughput.pdf'
#use the first and second columns from the file throughput.dat

set xlabel 'Size of System (N)'
set ylabel 'Throughput (op/s)'
set title 'Increasing Size Performance over Increasing Workloud'

set style fill solid
set style line 1 lc rgb "blue"
set boxwidth 0.5

X(x) = 2598.5156 * x / (1 + 0.0224477 * (x - 1) + 0.0009067 * x * (x - 1))

set output 'law2.pdf'

set xrange [1:30]  # Adjust the range as needed

plot X(x) with lines lw 2 title "Universal Scalability Law", 'throughput-stage2.dat' title "throughput" with linespoints