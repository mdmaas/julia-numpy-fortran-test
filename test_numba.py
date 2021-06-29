import time
import numpy as np
from numba import njit, prange

@njit(fastmath=True, parallel=True)
def get_M_nb_parallel(k, a):
    M = np.zeros((len(a), len(a)), dtype=np.complex128)
    for i in prange(len(a)):
        ais = np.square(a[i])
        for j in range(len(a)):
            M[i, j] = np.exp(1j * k * np.sqrt(ais + a[j] ** 2))

    return M

tests = np.arange(1, 11) * 1000
timings = np.zeros(tests.size)
a = np.linspace(0, 2 * np.pi, 1)
M = get_M_nb_parallel(100, a)

for idx, N in enumerate(tests):
    a = np.linspace(0, 2 * np.pi, N)
    k = 100

    start_time = time.time()
    M = get_M_nb_parallel(k, a)
    timings[idx] = time.time() - start_time
print(timings)