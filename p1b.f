       program elfreakingpi
       integer :: k_max = 1E5
       integer :: k = 0.0
       integer :: k_final
       real :: pi_sum = 0.0
       real :: pi_real = 3.141592
       
       open(11,file="pi_k.txt")
       
    	do while (abs(pi_real - 4*pi_sum) .ge. 1d-6)
    		pi_sum = pi_sum + ((-1.0)**dfloat(k) / (2.0*dfloat(k)+1.0))
			write(11,*) pi_sum*4
    		k = k+1
    	enddo
    		print *, "Número d'iteracions : ", k
    		print *, "Valor final: ", pi_sum*4

       stop
       end program elfreakingpi
       
