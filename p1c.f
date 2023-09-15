		program integral
		real*8 :: t(2001), s, corr(2001), f(2001), integ
		real*8, parameter :: dt = 0.0005
		integer :: k, w
		
C		Obrir fitxer de dades i per guardar dades	
		open(11,file='corr.dat')
		open(12,file='s_file.dat')
		
C		Llegir dades de t i correlació(t)
		do i = 1, 2001
			read(11,*) t(i), corr(i)
		enddo
C		Calcular la integral
		do w = 1, 500
	  	f = corr*cos(w*t)
		s = simpson38(f)
	  	write(12,*) w, s
		enddo

		close(11)
		close(12)
		end program integral
	
		function simpson38(f)
			integer :: k
			real*8 :: f(2001), integ
			integ = 0.0
			do k = 1, (2001-1)/3
			integ = integ +  f(3*k-2) + 3*f(3*k-1) + 3*f(3*k) + f(3*k+1)
			enddo
			simpson38 = 3.0/8.0*dt*integ
		end function simpson38

