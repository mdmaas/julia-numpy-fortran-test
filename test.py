import numpy as np
import time

tests = np.arange(1, 11) * 1000
timings = np.zeros(tests.size)
for idx, N in enumerate(tests):
    a = np.linspace(0, 2 * np.pi, N)
    k = 100

    A = a[:, np.newaxis]

    start_time = time.time()
    M = np.exp(1j * k * np.sqrt(A ** 2 + A.T ** 2))
    timings[idx] = time.time() - start_time
print(timings)
