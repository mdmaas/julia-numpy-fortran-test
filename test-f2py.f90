module mymodule

contains

function eikR(a,k,n) result(M)
    implicit none

    integer,            intent(in)  :: n
    real(kind=8),       intent(in)  :: a(n), k
    complex(kind=8)                 :: M(n,n)

    ! Local
    integer                         :: i, j
  
    do i=1,n
    do j=1,n
    
        M(i,j) = exp((0,1)*k*(a(i)**2 + a(j)**2))
        
    end do
    end do

end function eikR

    
end module
