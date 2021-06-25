module mymodule

use omp_lib

contains

!~ function eikR(a,k,n) result(M)
!~     implicit none

!~     integer,            intent(in)  :: n
!~     real(kind=8),       intent(in)  :: a(n)
!~     complex(kind=8),    intent(in)  :: k
!~     complex(kind=8)  :: M(n,n)

!~     ! Local
!~     integer                         :: i, j
!~     real(kind=8)  :: rtmp(n), sinp(n), cosp(n), tmp_exp(n)
!~     real(kind=8)  :: itmp(n), a_pow_2(n)

!~     complex(kind=8) :: imk
!~     real(kind=8) :: rimk
!~     real(kind=8) :: iimk, tmp

!~     imk = (0,1) * k
!~     rimk = real(imk)
!~     iimk = imag(imk)

!~     a_pow_2 = a * a
  
!~     !$OMP PARALLEL DO DEFAULT(private) SHARED(a_pow_2, M, n, rimk,iimk)
!~     do j=1,n
    
!~     rtmp = a_pow_2 + a_pow_2(j)
!~     call vdsqrt(n, rtmp, rtmp)

!~     ! real part
!~     call vdexp(n, rimk * rtmp, tmp_exp)

!~     ! imag part
!~     call vdsincos(n, iimk * rtmp, sinp, cosp)

!~     ! assemble output
!~     M(:, j) = cmplx(tmp_exp * cosp, tmp_exp * sinp)
!~     end do
!~     !$OMP END PARALLEL DO

!~ end function eikR

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
