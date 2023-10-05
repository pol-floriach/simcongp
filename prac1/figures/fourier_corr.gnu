set terminal pngcairo enhanced font "Verdana, 12"
set terminal png size 1024,768

set output 'fourier_corr.png'

#TICS i BORDERS
set tics nomirror
set tics scale 0.7
set border 3 lw 1.3

set grid

#LABELS

set xlabel '{/Symbol w}'
set ylabel 'S({/Symbol w})'    

unset key

#PLOT EN SI
plot 's_file.dat' w lines lc 3 lw 2
