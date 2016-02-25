#! /usr/local/GASP/bin/spi
#/* -*- c -*- */
# 

set_debug(-1)

//<<" starting convb50f ! $0 $1 $2 $3 \n"

cwd=<" pwd "

<<" $cwd \n"

// enter file spec

wcs = $2

<<" $wcs \n"

wcs = ssub(wcs,"\"","",0)

<<" $wcs \n"

start = 0

end = 0

 if ( $3 != "") {
     start = $3
 }


 if ( $4 != "") {
     end  = $4
 }

// output goes into array B

 <" pwd "

nwd=<" pwd "

<<" $nwd \n"


<<"ls $wcs "


B=<"ls $wcs "

 // list

<<" $B[*] \n"

 <<" %r $B[*] \n"


// is it Desat or Sattrend  type
// i.e. is USB in the file name?

Sattrend_type = 0

nf = Caz(B)

      b50f = B[0]


 for (i = 0; i < nf ; i++) {

   b50f = B[i]
   //   b50f=ssub(b50f,"\n","")

  df = spat(b50f,".",-1)

   df = scat(df,".dat")

//<<" %V $b50f $df \n"


 if (end > 0) {

 <<" splitb3500 $b50f $start $end > $df \n"

 <" splitb3500 $b50f $start $end > $df "

 }
 else {

  <<" splitb3500 $b50f $start > $df \n"

  <" splitb3500 $b50f $start > $df "

 }

}

STOP!
//////////////////////////////////////////////////////////////
// here is the mapping - change if necessary
  if (Sattrend_type ) {
    num = spat(df,"_",1)
  }
  else {
    num = spat(df,"USB",1)
  }

<<" %v $num \n"

chan = 0

 if (Sattrend_type ) {
   df = spat(df,"_",-1)
 }
 else {
  df = ssub(df,"-USB","_")
 }


 if (Sattrend_type ) {

 df = "${df}_${num}_C${chan}.dat"
 }
 else {

  df = "${df}_C${chan}.dat"
  }
if (num @= "1") {
      chan = 2
}

if (num @= "3") {
 chan = 3
}

if (num @= "5") {
 chan = 4
}

if (num @= "7") {
 chan = 5
}

if (num @= "9") {
 chan = 6
}


if (num @= "11") {
 chan = 7
}


if (num @= "13") {
 chan = 8
}


<<" mapping $num --> $chan \n"
