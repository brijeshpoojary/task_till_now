#!/usr/bin/python
# -*- coding: utf-8 -*-

import psycopg2
import csv
import sys
import re

con = None
try:

    def rm_spc_char(value):
	text=''
	for c in value:
		if c!='\'':
			text=text+c
	return text

    con = psycopg2.connect(database='semis',user='postgres',host='localhost',password='hello') 
    cur = con.cursor()     
    
    fp=csv.reader(open('/home/brijesh/klp/Semis_Data/sslc_data/sslc.csv','r'),delimiter='|',quotechar='\'')
    i=0
    for row in fp:
	if(i!=0):	
		cur.execute("insert into sslc_data values('"+row[0]+"','"+row[1]+"','" + rm_spc_char(row[2]) + "')")
	i=i+1
    con.commit()
except psycopg2.DatabaseError, e:
    print 'Error %s' % e    
    sys.exit(1)
    
    
finally:
    
    if con:
        con.close()
