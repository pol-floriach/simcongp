set terminal pngcairo enhanced font "Verdana, 12"
set terminal png size 1024,768
set encoding utf8

set output 'euler_dt_02_pp.png'

#TICS i BORDERS
set tics nomirror
set tics scale 0.7
set border 3 lw 1.3

set grid

#LABELS

set xlabel 't (s)'
set ylabel 'x (cm)'    

#unset key

#PLOT EN SI

k = 2
m = 0.2
x0 = 5e-2
w = sqrt(k/m)
harm(t) = x0*cos(w*t)
pot(t) = 0.5 * k * (x0 * cos(w * t))**2
kin(t) = 0.5 * m * (-x0 * w * sin(w * t))**2

set xrange [0:50]
set yrange [-x0-1e-2:x0+1e-2]
set samples 2000

set multiplot layout 3,1
plot harm(x) w l lc 3 lw 1 ti "Analytical", 'harmonic_euler_pp_02.dat'  using 1:2 w lines dt 2 ti "dt = 0.001"

set yrange [0:0.003]
set xrange [0:50]
plot kin(x) w l lc 3 lw 1 ti "Analytical", 'harmonic_euler_pp_02.dat' using 1:4 w lines dt 2 ti "Kinetic Energy"

plot pot(x) w l lc 3 lw 1 ti "Analytical 2", 'harmonic_euler_pp_02.dat'  using 1:5 w lines dt 2 ti "Potential Energy"
unset multiplot
