	program adding
	integer :: x
	real :: y, z
	
	open(12, file = "p1a.dat")
	print *, 'Enter an integer: x = '
	read(*,*) x
	print *, 'Enter a real number: y = '
	read(*,*) y
	
	z = x+y
	
	print *, 'x + y = ', z
	write(12,*) z
	end program
