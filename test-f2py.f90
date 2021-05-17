module mymodule

use omp_lib

contains

function eikR(a,k,n) result(M)
    implicit none

    integer,            intent(in)  :: n
    real(kind=8),       intent(in)  :: a(n)
    complex(kind=8),    intent(in)  :: k
    complex(kind=8)                 :: M(n,n)

    ! Local
    integer                         :: i, j
  
    !$OMP PARALLEL DO PRIVATE(J)
    do j=1,n
    do i=1,n
    
        M(i,j) = exp((0,1)*k*sqrt(a(i)**2 + a(j)**2))
        
    end do
    end do
    !$OMP END PARALLEL DO

end function eikR

    
end module
