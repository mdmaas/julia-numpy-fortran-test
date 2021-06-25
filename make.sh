# F2PY multithreaded
export OMP_NUM_THREADS=8
f2py3 -c -m mytest test-f2py.f90 --f90flags='-O3 -march=native -funroll-loops -fopenmp -ffast-math -floop-nest-optimize' -lgomp -DF2PY_REPORT_ATEXIT -DF2PY_REPORT_ON_ARRAY_COPY=1

# Fortran Standalone
export OMP_NUM_THREADS=8
gfortran f_standalone.f90 -o f_standalone -O3 -march=native -funroll-loops -fopenmp -ffast-math -floop-nest-optimize -lgomp

# Fortran Standalone MKL
#
export OMP_NUM_THREADS=8
gfortran f_standalone_mkl.f90 -o f_mkl -I$MKLROOT/include -L$MKLROOT/lib/intel64 -Wl,--no-as-needed -lmkl_gf_lp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl -O3 -march=native -funroll-loops -fopenmp -ffast-math -floop-nest-optimize -lgomp 
