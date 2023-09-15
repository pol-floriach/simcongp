set terminal pngcairo enhanced font 'Verdana,12'
set terminal png size 1024,768

set output 'fourier_corr.png'


set xlabel '($\omega)'
set ylabel '$S(\omega)'

plot 's_file.dat' with lines
