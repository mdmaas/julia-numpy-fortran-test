program test
use omp_lib
complex(kind=8), allocatable :: A(:, :)
integer :: N
real(kind=8) :: time1, time2

do N = 1000, 10000, 1000
   time1 = omp_get_wtime()
   A = eval_exp(N)
   time2 = omp_get_wtime()
   print *, time2 - time1
enddo

contains

function eval_exp(n) result(M)
   implicit none

   integer, intent(in) :: n
   complex(kind=8) :: M(n, n)

   ! Local
   real(kind=8) :: a(n)
   complex(kind=8) :: k
   integer :: i, j

   k = (100., 1.)

   do i = 1, n
      a(i) = (i - 1)*2*3.14159/(n - 1)
   enddo

   !$omp PARALLEL DO PRIVATE(J)
   do j = 1, n
      do i = 1, n

         ! A[i,j] = exp((100+im)*im*sqrt(a[i]^2 + a[j]^2))
         M(i, j) = exp(k*(0., 1.)*sqrt(a(i)**2 + a(j)**2))

      enddo
   enddo
   !$omp END PARALLEL DO

endfunction eval_exp

endprogram
