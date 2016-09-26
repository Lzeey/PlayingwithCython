# -*- coding: utf-8 -*-
"""
Created on Mon Sep 26 23:19:03 2016

Module for clustering

@author: Zeyi
"""
from __future__ import division
import numpy as np

DTYPE = np.int # For ensuring that input is of type int
ctypedef np.int_t DTYPE_t #For efficient indexing
cdef extern from "math.h": #More speed
    double sqrt(double m)

def batch_cluster(np.ndarray[DTYPE_t, ndim=1] t_array, double sigma=0.01):
    assert t_array == DTYPE #Check that list is all ints
    
    cdef int total_len = len(t_array)
    cdef int count = 0
    cdef long sum = 0
    cdef double var = 0.0
    cdef double std_dev = 0.0
    cdef double prev_mean, mean
    cluster = [] #TODO: Find a way to write this faster
    for i in xrange(total_len):
        if count == 0: #First point in cluster
            count, var = 1, 0.0
            sum = t_array[i]
            mean = sum * 1.0
            continue
        #Update equations
        count += 1
        sum += t_array[i]
        prev_mean = mean
        mean += 1.0/count * (t_array[i] - mean)
        var = 1.0/count * (sum**2) - mean**2
        std_dev = sqrt(var)
        #Check for clustering
        if std_dev/mean > 0.01:
            #DO SOMETHING
            
        
        #
        #Add point in
    
    
    