# -*- coding: utf-8 -*-
"""
Created on Mon Sep 26 23:19:03 2016

Module for burst calculation

@author: Zeyi
"""
cimport cython
cimport numpy as np
import numpy as np
import pandas as pd


DTYPE = np.int # For ensuring that input is of type int
ctypedef np.int_t DTYPE_t #For efficient indexing

@cython.boundscheck(False) # turn off bounds-checking for entire function
@cython.wraparound(False)  # turn off negative index wrapping for entire function
def extract_burst(x):
    """
    Extract maximum length of burst. Use this if the iterable has already been converted into integer minutes
    Inputs:
        x: Iterable of burst timings
    """
    cdef int total_t = len(x)
    cdef np.ndarray[long long, ndim=1] x_sorted = x.sort_values().values
    cdef int previous_t = -1
    cdef int longest_n = 1
    cdef int curr_n = 1
    cdef int diff_t
    cdef Py_ssize_t i
    for i in xrange(total_t):
        diff_t = x_sorted[i] - previous_t
        if diff_t == 1: #Extend the burst
            curr_n += 1
        elif diff_t > 1: #Burst break
            if longest_n < curr_n: #Update longest 
                longest_n = curr_n
            #Reset state
            curr_n = 1
        else: #Error. Hour-minute should be unique
            raise Exception('DuplicateError')
        previous_t = x_sorted[i]
    #TODO: Include start and end hour
    return longest_n
    
    