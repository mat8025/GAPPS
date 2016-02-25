#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
// test declare implied conversion


the_ang = "48,58.17,N"
<<" %v $the_ang \n"
the_parts = Split(the_ang,",")
<<" %v $the_parts \n"

<<" $the_parts[0] \n"
<<" $the_parts[1] \n"
<<" $the_parts[2] \n"

j = 0

<<" $the_parts[j] \n"

//    float the_deg = the_parts[0]
    float the_deg 

   the_deg = the_parts[0]

//    float the_min = the_parts[1]
    float the_min;
   the_min = the_parts[1]

    the_dir = the_parts[2]

    <<"%V $the_deg $the_min  $the_dir\n"

the_ang = "105,33.29,W"
<<" %v $the_ang \n"
sz =Caz(the_parts)
<<" $sz \n"

the_parts = Split(the_ang,",")

sz =Caz(the_parts)
<<" $sz \n"

//the_otherparts = Split(the_ang,",")

<<" %v $the_parts \n"
//<<" %v $the_otherparts \n"

   the_deg = the_parts[0]
   the_min = the_parts[1]

    the_dir = the_parts[2]

    <<"%V $the_deg $the_min  $the_dir\n"


<<" DONE ! \n"
STOP!
