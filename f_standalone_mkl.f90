! test.f90
module mymodule
use, intrinsic :: iso_fortran_env, only: real64
contains
subroutine eikR(a,k,n,M)
    implicit none

    integer,            intent(in)    :: n
    real(real64),       intent(in)    :: a(n)
    complex(real64),    intent(in)    :: k
    complex(real64),    intent(out)   :: M(n,n)

    ! Local
    integer                         :: i, j
    real(real64)  :: rtmp(n), sinp(n), cosp(n), tmp_exp(n)
    real(real64)  :: itmp(n), a_pow_2(n)

    complex(real64) :: imk
    real(real64) :: rimk
    real(real64) :: iimk, tmp

    imk = (0,1) * k
    rimk = real(imk)
    iimk = imag(imk)

    a_pow_2 = a * a
  
    !$OMP PARALLEL DO DEFAULT(private) SHARED(a_pow_2, M, n, rimk,iimk)
    do j=1,n
    
    rtmp = a_pow_2 + a_pow_2(j)
    call vdsqrt(n, rtmp, rtmp)

    ! real part
    call vdexp(n, rimk * rtmp, tmp_exp)

    ! imag part
    call vdsincos(n, iimk * rtmp, sinp, cosp)

    ! assemble output
    M(:, j) = cmplx(tmp_exp * cosp, tmp_exp * sinp)
    end do
    !$OMP END PARALLEL DO

end subroutine eikR
end module

program test
use, intrinsic :: iso_fortran_env, only: real64
use mymodule
use omp_lib
real(real64), parameter :: pi = 4*atan(1.0)
integer :: i, j, n
real(real64), allocatable :: a(:)
complex(real64) :: k
complex(real64), allocatable :: m(:, :)
real(real64) :: t1, t2
do i = 1, 10
   n = 1000*i
   if(allocated(m)) deallocate(m)
   allocate(m(n, n))
   t1 = omp_get_wtime()
   a = [(2*j*pi/(n - 1), j=0, n - 1)]
   k = cmplx(100.0, 1.0)
   call eikr(a, k, n, m)
   t2 = omp_get_wtime()
   print *, n, t2 - t1, 'seconds'
enddo
end program
