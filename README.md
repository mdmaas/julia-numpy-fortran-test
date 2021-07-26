# julia-numpy-fortran-test
Comparing Julia vs Numpy vs Fortran for performance and code simplicity

[Julia vs Numpy vs Fortran performance tests](https://www.matecdev.com/posts/numpy-julia-fortran.html).

## Usage
```
sh make.sh
./f_standalone
./f_mkl
sh run_julia.sh
python3 test_f2py.py
python3 test.py
```

### Download and install MKL:
```
cd /tmp
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo sh -c 'echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list'
sudo apt-get update
sudo apt-get install intel-mkl-64bit-2018.2-046
```
### Link to MKL
```
export MKLROOT=/opt/intel/mkl
export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/opt/intel/mkl/lib/intel64
```
