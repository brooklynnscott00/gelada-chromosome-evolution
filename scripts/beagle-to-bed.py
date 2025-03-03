#!/usr/bin/env python

import pandas as pd
import sys # command line arguments
import re # regular expressions 
import csv # for exporting bed file

# stores command line arguments 
arguments = sys.argv

# example command
# arguments = ['beagle_to_bed.py','angsd/angsd_genolike_region_NC_037668.1.0001_maf_0.01.beagle.gz','beagle_bed/angsd_genolike_region_NC_037668.1.0001_maf_0.01.beagle.bed']

in_beagle = arguments[1] # first argument is the input beagle
out_bed = arguments[2] # second argument is the output bed

beagle = pd.read_table(in_beagle,sep='\t',header=None,index_col=0,dtype='str')  # read the beagle file as a data frame

beagle_bed = beagle[[]].copy() # pd.DataFrame(beagle.apply('%'.join,axis=1),columns=['bed']) # create an empty data frame that only keeps the index columne from the input beagle 

# extract chromsomes and position using regex
beagle_bed['chrom'] = pd.Series(beagle_bed.index).replace('(.+?)_([0-9]+)$','\\1',regex=True).to_list()
beagle_bed['chromStart'] = (pd.Series(beagle_bed.index).replace('(.+?)_([0-9]+)$','\\2',regex=True).astype('int') - 1).to_list() # subtract one because bed files are 0 indexed and beagle files are 1 indexed
beagle_bed['chromEnd'] = (pd.Series(beagle_bed.index).replace('(.+?)_([0-9]+)$','\\2',regex=True).astype('int')).to_list()

# select relevant columns
beagle_bed_out = beagle_bed[['chrom','chromStart','chromEnd']].copy()

# save out
beagle_bed_out.to_csv(out_bed,sep='\t',header=False,index=False,quoting=csv.QUOTE_NONE)
