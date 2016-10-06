# -*- coding: utf-8 -*-
"""
Created on Mon Sep 26 19:58:56 2016

@author: Zeyi
"""
try:
    from setuptools import setup
    from setuptools import Extension
except ImportError:
    from distutils.core import setup
    from distutils.extension import Extension

from Cython.Build import cythonize
import numpy

setup(
    name = 'burst',
    ext_modules = cythonize("burst.pyx"),
    include_dirs=[numpy.get_include()]
)

