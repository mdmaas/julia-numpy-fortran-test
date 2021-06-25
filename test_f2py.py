import numpy as np
import time
from mytest import mymodule

for N in [int(i*1000) for i in range(10,11)]:
    a = np.linspace(0, 2*np.pi, N)
    k = complex(100,1)
    
    start_time = time.time()
    M = mymodule.eikr(a,k,N)
    print(str(time.time() - start_time))
    # ~ print('N=' + str(N) + ', time in f2py: ',  + " seconds")
