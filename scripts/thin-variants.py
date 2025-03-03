#!/usr/bin/env python

import pandas as pd
import numpy as np
import sys
import re
import csv

arguments = sys.argv
# arguments = ['thin-variants.py','angsd_chr/angsd_genolike_NC_037687.1.beagle.gz','100000','angsd_thinned/angsd_genolike_NC_037687.1_thinned.beagle.gz']

in_file = arguments[1]
prune_distance = int(arguments[2])
out_beagle = arguments[3]

beagle = pd.read_table(in_file,sep='\t',header=None)
beagle['pos'] = beagle[0].replace('.+?_([0-9]+)$','\\1',regex=True).astype('int')

out_index = []

this_position = 0
i = 0

print('Pruning variants within '+str(prune_distance)+' bp of one another.')

while this_position < beagle['pos'].max():
	print(str(i)+': '+str(this_position))
	# If first iteration, take the first position, else exclude anything within prune_distance
	if i == 0:
		this_position = beagle['pos'].min()
	else:
		this_position = beagle['pos'][beagle['pos'] >= (this_position + prune_distance)].min()
	
	if np.isnan(this_position):
		break
	else:
		out_index.append(beagle.index[beagle['pos'] == this_position].to_list()[0])
		i+=1

beagle_out = beagle.iloc[out_index,:-1]

# out_file = re.sub('\\.([A-z0-9]+\\.gz)','_pruned.\\1',in_file)

# Pandas wants unique column names. Force them back
# beagle_out.columns = [re.sub('\\.[0-9]$','',i) for i in beagle_out.columns.to_list()]

print('Writing '+str(beagle_out.shape[0])+' genotypes to "'+out_beagle+'".')

beagle_out.to_csv(out_beagle,sep='\t',index=False,header=False,float_format='%.6f',quoting=csv.QUOTE_NONE)
