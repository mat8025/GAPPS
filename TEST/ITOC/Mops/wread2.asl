#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
// test declare word read

Svar W  // string object
A = 0 // stdin
 
//  we want 
//  nwr = W->Read(A)
//   C=W->Count()  --- C[0] number of fields C[1] total number of chars in W 

// for now
 nlines=1
 total = 0
 nwr = 0
      // FIX
      while ((nwr = W->Read(A)) != -1) {

       <<" $nwr \n"
         total += nwr

         <<"[${nlines}] $W \n"
          nlines++
      }

nlines--
STOP("DONE %V $nlines $total")
