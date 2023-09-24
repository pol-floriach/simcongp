		program harmonic_euler_predictor_corrector
		real(8), parameter :: m = 0.2, k = 2.0, w2 = k/m
		real(8), parameter :: dt = 0.02, t_end = 50.0
		integer, parameter :: N = Int(t_end/dt)
		real(8) :: x = 5e-2, v = 0.0, t = 0.0
		real(8) :: kin = 0.0, pot = 0.0, a = 0.0
		

		kin = 0.5 * m * v**2
		pot = 0.5 * k * x**2
		a = -w2*x
		
		open(11, file = "harmonic_euler_pp_02.dat")
		write(11,*) t, x, v, kin, pot

		do i = 2, N
			call euler_predictor_corrector(t,x,v,a,kin,pot)
			write(11,*) t, x, v, kin, pot 
		enddo

		close(11)
		
		contains  
		subroutine euler_predictor_corrector(t, x, v, a, kin, pot)
			real(8) :: t, x, v, a, kin, pot
			
			t = t + dt
			! predictor step
			x = x + dt*v - 0.5 * w2*x * dt**2 
			a = 0.5 * (a - w2*x)
			! corrector step
			v = v - w2*x * dt
			x = x + dt*v - 0.5 * a * dt**2 
			a = -w2*x
			! energies
			pot = 0.5 * k * x**2
			kin = 0.5 * m * v**2
			return
		end subroutine
		
		end program


