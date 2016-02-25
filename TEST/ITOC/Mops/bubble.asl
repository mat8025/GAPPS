#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
// test bubble sort

OpenDll("math")


     V = Rand(200,200)
<<" $V \n"


V->BubbleSort()


<<" $V \n"




STOP("DONE \n")
