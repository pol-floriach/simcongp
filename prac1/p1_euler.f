		program harmonic_euler
		real(8), parameter :: m = 0.2, k = 2.0, w2 = k/m
		real(8), parameter :: dt = 0.001, t_end = 10.0
		integer, parameter :: N = Int(t_end/dt)
		real(8) :: x = 5e-2, v = 0.0, t = 0.0, kin = 0.0, pot = 0.0, a
		
		kin = 0.5 * m * v**2
		pot = 0.5 * k * x**2
		
		a = -w2 * x 

		open(11, file = "harmonic_euler_001.dat")
		write(11,*) t, x, v, kin, pot

		do i = 2, N
			call euler(t,x,v,kin,pot,a)
			write(11,*) t, x, v, kin, pot 
		enddo

		close(11)
		
		contains  
		subroutine euler(t, x, v, kin, pot,a)
			real(8) :: t, x, v, kin, pot, a 
			t = t + dt
			x = x + v*dt + 0.5*a*dt*dt ! - 0.5*w2*x*dt*dt
			v = v  +a*dt ! -w2*x*dt
			a = -w2*x
			pot = 0.5 * k * x**2
			kin = 0.5 * m * v**2
			return
		end subroutine
		
		end program


