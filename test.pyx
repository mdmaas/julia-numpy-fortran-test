#distutils:language =c++
import numpy as np
cimport numpy as np
from libc.math cimport exp, sqrt
from cython.parallel cimport parallel, prange, threadid
import time

cdef complex[:, ::1] compute(size_t n):
    cdef double[::1] a = np.linspace(0, 2 * np.pi, n)
    cdef complex[:, ::1] m = np.empty((a.size, a.size)).astype(np.complex_)
    cdef double k = 100
    cdef size_t idx, jdx
    cdef size_t N = a.size
    for idx in prange(N, nogil = True, num_threads = 16, schedule = 'static'):
        for jdx in range(N):
            m[idx, jdx] = exp(k * sqrt(a[idx]**2 + a[jdx]**2))
    return m

cdef size_t[::1] tests = np.arange(1, 11, dtype = np.uintp) * 1000
cdef double[::1] timings = np.zeros(tests.size)


cdef size_t idx, n
cdef double[::1] a
cdef size_t start_time

for idx in range(tests.size):
    start_time = time.time()
    compute(tests[idx])
    timings[idx] = time.time() - start_time
print(timings.base)
