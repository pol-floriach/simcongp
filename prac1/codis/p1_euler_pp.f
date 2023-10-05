		program harmonic_euler_predictor_corrector
		real(8), parameter :: m = 0.2, k = 2.0, w2 = k/m
		real(8), parameter :: dt = 0.02, t_end = 10.0
		integer, parameter :: N = Int(t_end/dt)
		real(8) :: x = 0.05, v = 0.0, t = 0.0, kin, pot, a 
		
		kin = 0.5 * m * v**2
		pot = 0.5 * k * x**2
		a = -k/m*x
		
		open(11, file = "predcorr.dat")
		write(11,*) t, x, v, kin, pot

		do i = 2, N
			call euler_predictor_corrector(t,x,v,a,kin,pot)
			write(11,*) t, x, v, kin, pot 
		enddo

		close(11)
		contains 
	
		subroutine euler_predictor_corrector(t, x, v, a, kin, pot)
			real(8) :: t, x, v, a, kin, pot, x_pred, a_pred, a_star
			a =-k*x/m
			t = t + dt
			! predictor step
			x_pred = x + v*dt +0.5*a*dt**2
			a_pred = -k*x_pred/m
			a_star =  0.5*(a + a_pred)
			! corrector step
			x = x + v*dt + 0.5*a_star*dt**2
			v = v + a_star*dt
			! energies
			pot = 0.5 * k * x**2
			kin = 0.5 * m * v**2
			return
		end subroutine

		end program

