
	program Montecarlo

	integer :: punts_dintre = 0, punts_tot
	real*8 :: punt(2), area, mean_area, var_area
	real*8, parameter :: A_exact = 13.5916


	open(11,file="montecarlo_int.dat")

	punts_tot = 100
	mean_area = 0.0
	do while (punts_tot .le. Int(1e7))
		punts_dintre = 0
	! area 
		do i = 1, punts_tot
			! punt aleatori
			call random_number(punt)
			punt(2) = punt(2)*11
	
			! dins de la corba?
			if (punt(2) .lt. 1.0/punt(1)) then
				punts_dintre = punts_dintre + 1
			end if
		enddo

		area = 4.0*11.0*punts_dintre / punts_tot

		! mitjana i variança
		do j = 1, M
			mean_area = mean_area + area/punts_tot
		enddo
		var_area = sqrt( (area - A_exact)**2 / punts_tot)

	write(11,*) punts_tot, area, mean_area, var_area
	
	if (sims % 5 == 1)
		punts_tot = punts_tot*10
	end

	enddo


	close(11)

	end program