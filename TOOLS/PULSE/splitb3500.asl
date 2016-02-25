#! /usr/local/GASP/bin/spi
#/* -*- c -*- */

set_debug(-1)

A = 0
startf = 0
endf = -1

     if ( $2 @= "-" ) {

       //     <<[2]" using stdin \n"

        <<" using stdin \n"

     }
     else {
     
       A=ofr($2)

     <<[2]" opening file $2 \n"




 if ( $3 != "") {
     smin = $3
     startf = 60 * 50 * smin
 }

 if ( !($4 @= "")) {
     emin = $4
     endf = 60 * 50 * emin
 }

//<<" $startf $endf \n"

       }

// this is a user_added_code_function - need to open its libary

OpenDll("uac")

b3500(A,startf,endf) 

STOP!
