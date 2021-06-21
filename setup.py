from distutils.core import setup
from Cython.Build import cythonize
from setuptools.extension import Extension
import numpy as np

flags = (
    f"-Ofast -march=native -std=c++17 -flto "
    "-frename-registers -funroll-loops -fno-wrapv "
    "-fopenmp-simd -fopenmp -unused-variable -Wno-unused "
)

extensions = [
    Extension(
        "test_cy",
        sources=["test.pyx"],
        include_dirs=[np.get_include()],
        language="c++",
        extra_link_args=["-fopenmp"],
        extra_compile_args=flags.split(),
    )
]
setup(ext_modules=cythonize(extensions))
