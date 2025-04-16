#!/usr/bin/env python

import pandas as pd
import sys
import re
import csv

# stores command line arguments 
arguments = sys.argv
# arguments = ['bed_to_beagle.py','beagle_bed_rmrep/angsd_genolike_region_NC_037668.1_0001_rmrep.bed','angsd_single/angsd_genolike_region_NC_037668.1_0001.beagle.gz','rmrep/angsd_genolike_region_NC_037668.1_0001_rmrep.beagle.gz']

in_beagle_bed = arguments[1]
in_beagle = arguments[2]
out_beagle = arguments[3]

# read the bed file and store the positions to keep
beagle_bed = pd.read_table(in_beagle_bed,sep='\t',header=None,index_col=None,dtype='str')
beagle_keep = (beagle_bed[0] + '_' + beagle_bed[2]).to_list()

# read the beagle file and store the first column ad the index
beagle = pd.read_table(in_beagle,sep='\t',header=0,index_col=0)

# save only the columns that are in the beagle keep file 
beagle_out = beagle.loc[beagle_keep].copy()

# write to a new out file
beagle_out.to_csv(out_beagle,sep='\t',header=False,index=True,quoting=csv.QUOTE_NONE,float_format='%.6f')
