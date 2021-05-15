import numpy as np
import time

for N in [int(i*1000) for i in range(1,11)]:
    a = np.linspace(0, 2*np.pi, N)
    k = 100

    start_time = time.time()
    M = np.exp(1j*k*(np.tile(a,(N,1))**2 + np.tile(a.reshape(N,1),(1,N))**2))
    print('N=' + str(N) + ', time in Numpy: ', str(time.time() - start_time) + " seconds")



