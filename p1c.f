
	program p1c


	real :: t(2001), w_vec(500), s(500)
	real*8 :: corr(2001), f(2001), integ(2000)
	real, parameter :: dt = 0.0005
	integer :: i, w

	open(11,file='corr.dat')

	do i = 1, 2001, 1
	  read(11,*) t(i), corr(i)
	enddo

C TRAPEZOIDAL
	do w = 1, 500, 1
	  w_vec(i) = w
	  f = corr*cos(w*t)
	  integ = dt*0.5*(f(1:2000)+f(2:2001))
	  s(w) = sum(integ)
	enddo

	
	


	end program
