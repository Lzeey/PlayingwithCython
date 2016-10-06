# -*- coding: utf-8 -*-
"""
Created on Thu Oct 06 20:18:58 2016

@author: Zeyi
"""

import pandas as pd
import numpy as np
import burst

def extract_burst(x):
    """
    Extract maximum length of burst. Use this if the iterable has already been converted into integer minutes
    Inputs:
        x: Iterable of burst timings
    """
    total_t = len(x)
    x_sorted = x.sort_values().values
    previous_t = -1
    longest_n = 1
    curr_n = 1
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

if __name__ == "__main__":
    test_length = 10000000
    df = pd.DataFrame(np.random.randint(0,3000,test_length*2).reshape((test_length,2)), columns=['user','dummy'])
    df = pd.concat([df, pd.DataFrame(np.random.randint(0,24,test_length), columns=['hour'])], axis=1)
    df = pd.concat([df, pd.DataFrame(np.random.randint(0,60,test_length), columns=['minute'])], axis=1)
    agg = df.groupby(['user','hour','minute']).count().reset_index()
    agg['totalmins'] = agg['hour']*60 + agg['minute']
    
    grouped = agg.groupby('user')
    agg_b = grouped['totalmins'].agg(extract_burst)
    agg_c = grouped['totalmins'].agg(burst.extract_burst)
    #agg_b = grouped['totalmins'].agg(extract_burst)
    