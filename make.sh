f2py3 -c -m mytest test-f2py.f90 --f90flags='-lmkl -O3 -march=native -funroll-loops -fopenmp -ffast-math -floop-nest-optimize' -lgomp
