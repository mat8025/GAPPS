#/* -*- c -*- */
# "$Id: pulseIO.g,v 1.1 2003/06/25 07:08:30 mark Exp mark $"


int Bdf    // data file out

lstem = ""

normalize = 0

proc ReadPulseFile( pfname)

{

<<" $_cproc $pfname \n"

  A= ofr(pfname)

  read_ascii = 0 

  binf = Spat(pfname,".bin")

  fstem = Spat(pfname,".","<","<")

  lstem = Spat(fstem,"/",">","<")

  <<" $pfname $fstem $lstem \n"

  if (lstem @= "") 
     lstem = fstem


  binname = Scat(lstem,".bin")

  Bdf = ofw("pleth.df")

  // pulse-rate o2 and motion par files

  //  ::Pdf = ofw("${lstem}.ppr")

  // ::Odf = ofw("${lstem}.po2")

  //  ::Mdf = ofw("${lstem}.pme")

  ::Oxd = ofw("${lstem}.oxp")

       <<" %v $Oxd \n""

  if (binf @= "")
  read_ascii = 1 

  if (read_ascii) {

  // Reading Pulse ascii data
  // how many cols  (14) ??

  R = r_ascii(A,"int",0,24,14)

  maxpts = Caz(R)

  dmn = Cab(R)

<<" ascii read  R array  %v $maxpts  $dmn\n"

  B = ofw(binname)

  nbw =w_data(B,R[*][11,12],"int")

  <<" converted to bin  $nbw  $(typeof(R)) \n"

  // either 0 or 1 indicating gain of 1 or 4
 PG = R[*][8]

 PG = 4^PG


  // either 0 ,1,2, or 3 indicating gain of 1 ,4 , 16 or 64

 RD = R[*][6]

 RD = 4^RD

 IRD = R[*][7]

 IRD = 4^IRD

 Red = R[*][11]

 rsz = Caz(Red)

 dmn = Cab(Red)

 <<" %v $rsz $dmn\n"



  // apply normalization ?
  if (normalize) {
  Red = Red / PG 
  Red = Red / RD
  }

 Redimn(Red)

 dmn = Cab(Red)

 <<" after Redimn $dmn \n"

 maxpts = Caz(Red)

 <<" %v $maxpts in Red array \n"

 IR = R[*][12]

 <<" $dmn $(typeof(IR))\n"

  Redimn(IR)

  if (normalize) {
   IR = IR /PG
   IR = IR/ IRD
  }



 maxirpts = Caz(IR)

 <<" %v $maxirpts  \n"
    }
 else {
   // read as binary int
   // just two ints per row
  R = r_data(A,"int")

  dmn = Cab(R)

  maxpts = Caz(R)

  <<"bin data R array  $dmn  %v $maxpts \n"

  <<" ${R[0]} \n"

   rows = maxpts/2

<<" $rows \n"

   Redimn (R, rows,2)

  dmn = Cab(R)
  maxpts = Caz(R)

  <<"bin data R array  $dmn  %v $maxpts \n"


   Red = R[*][0]   

  <<" ${Red[0]} \n"

 dmn = Cab(Red)

 <<" $dmn \n"

 maxpts = Caz(Red)

 <<" %v $maxpts in Red array \n"

   IR = R[*][1]   

 <<" $dmn $(typeof(IR))\n"

  Redimn(IR)

 maxirpts = Caz(IR)

 <<" %v $maxirpts  \n"

 <<" ${IR[0]} \n"
 <<" ${IR[maxirpts-1]} \n"
    }

   return maxpts

}




int NA[]

proc ReadNoiseFile(pfname)

{

  afh= ofr(pfname)

  NA = r_ascii(afh,"float")

  nspts = Caz(NA)

   dmn = Cab(NA)

  nspts = dmn[0]

<<" ascii reading NoiseFIle  NA array  %v $nspts  $dmn\n"

<<" $NA[0;10][*] \n"


 NRed = NA[*][0]
 NIR = NA[*][1]

 NIR = NIR * IRNscale
 NRed = NRed * RedNscale

  c_file(afh)
  return nspts
}

proc ScaleRIR()
 {
<<" Scaling input %V $Redscale  $IRscale \n"

   sz = Caz(IR)

<<" prescale %v $sz \n"
<<" $IR[0;32] \n"
<<" $IR[sz-32;sz] \n"
<<" $Red[0;32] \n"
<<" $Red[sz-32;sz] \n"

   IR  *= IRscale
   Red *= Redscale
    :pbw = 16
<<" postscale %v $sz \n"
<<" $IR[0;pbw] \n"
<<" $IR[sz-pbw;sz-1] \n"
<<" Red \n"
<<" $Red[0;pbw] \n"
<<" $Red[sz-pbw;sz-1] \n"

 }


proc AddNoiseF()
  {

set_debug(0)
#{

  //  adds noise from file
  //  scaling done in read

#}


      Noisepts = ReadNoiseFile(noisef)
      jb= 0
      je = jb + Noisepts-1

   sz = Caz(IR)

             noisz = Caz(NIR)

	     while (1) {
	       // want this to add NRed[0;noisz] into Red[jb;je]

	     Red[jb;je] += NRed
	       //	     IR[jb;je] = IR[jb;je]+NIR
             IR[jb;je] += NIR
       <<" added noise in $jb $je \n"

      jb += Noisepts
      je = jb + Noisepts-1
             if (jb >= maxpts)
               break
      if (je >= sz) 
            je = sz-1

	     }


	:pbw = 16
<<" postnoise %v $sz \n"
<<" $IR[0;pbw] \n"
<<" $IR[sz-pbw;sz-1] \n"
<<" Red \n"
<<" $Red[0;pbw] \n"
<<" $Red[sz-pbw;sz-1] \n"

}


// Fake Pleth

proc SigInject(npts, bpm)

{
     // nsecs worth
     // starting at r bpm finish at q bpm
  // use simulated Pleth signal

  dt = 1/Sfreq
 
  dw = (2.0 * PI * bpm / 60 * dt)
  yv = Fgen(npts,0,dw)

    // ramp it
  yv = Pow(yv,1.2)


  Red = (Saw(yv,0.3) * 2000.0  + 5000)
  IR  = (Saw(yv,0.3) * 3000.0  + 7000)
   //  Red[start; send] = (sv * 2000.0 + 5000) + (sqv * mamp)

 <<" made Sawtooth Red and IR input vecs \n"

}


proc CloseIO()
{

   c_file(Bdf)

   c_file(Pdf)


// c_file(Odf)


   c_file(Mdf)

}


// monitor memory usage

int mblksML0 =0 
int mblksML1 =0 

proc MemWatch( routn)

{
   mblksML1 = CountMemBlocks()
   dmb = mblksML1-mblksML0
   if (dmb > 0)
   <<"\nMW %v $nloop $dmb  $routn\n"

    mblksML0 = mblksML1
}





# End
