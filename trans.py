#!/usr/bin/python

import sys
import re 
import time

Nodedata=[]

class Node:
	nodecounter=0
	def __init__(self,coords=["0","0","0"]):
		self.coords=coords[:]
		Node.nodecounter=Node.nodecounter+1


# Read data
filename='T9_3_iter0.vtk'

fin=file(filename,'r')

info_version=fin.readline()
info_format=fin.readline()
info_encoding=fin.readline()
info_title=fin.readline()

while True:
	line=fin.readline()

	if re.search("^POINTS",line):
		continue
	if re.search("^LINES",line):
		break
	if re.search("^POLYGONS",line):
		break

	coorddata=re.split(" +",line)
	newnode=Node(coorddata[0:3])
	Nodedata.append(newnode)

fin.close()


# Output Data

fout=file("out.xyz",'w')

# head info
fout.write(str(Node.nodecounter)+"\n")
fout.write("Atoms\n")

# coord info
ID=0
while ID<Node.nodecounter :
	ID=ID+1
	fout.write('1'+'\t')
	fout.write(Nodedata[ID-1].coords[0]+'\t')
	fout.write(Nodedata[ID-1].coords[1]+'\t')
	fout.write(Nodedata[ID-1].coords[2])	
fout.close()


