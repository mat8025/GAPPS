//  test beam deconvolution of cloud reflectivity arrays



/////////////////////////////////////////////////////////////


proc make_beam ( nbp)
{
//  triangle _/\_   convolver

half_bw = nbp/2
dy = 1.0/(half_bw+1)

      Bm[half_bw] = 1.0
      wt = dy

      for (i = 0; i < half_bw; i++) {
         Bm[i] = wt;
         Bm[nb-1-i] = wt;
         wt += dy;
      }

      <<"$Bm \n"
}





double pwr


//float R[]   // recovered signal
double R[]   // recovered signal
//float Op[]
double Op[]

//float Inpat[]
double Inpat[]
double Spat[]

float Sfpat[]

float Dpat[240]
float Sinput[240]



// change the beam_width with range
// beam smear
nb = 7
int half_bw = nb/2


//  what does the beam antenna gain look like ---- symmetrical
//  3 1/2 deg beam-width -- where gain is at 1/2 (3 db down) so 1.75 deg either side 
//  but we have sparse samples --
//  so do we interpolate then despread 


int mp = half_bw

//float Bm[nb] = { 0.125, 0.25, 0.5, 0.75, 1.0, 0.75, 0.5, 0.25, 0.125 }
//float Bm[nb] = 1.0

double Bm[nb] = 1.0

float dy = 1.0/(half_bw+1)


make_beam (nb)


// OK
/////////////////////////////////////////////////////

XV = vgen(FLOAT,300,0,1)

R = 0.0


proc bm_despread()
{
///  now run the deconvolution until beam RH edge runs upto end of smeared signal - 

  R = Op

  R = dconvolve(Op,Bm)


  sz = Cab(R)

  <<"Rsz $sz \n"

  pwr = rms(R)

 // R = 10

  <<"%V$pwr \n"

}

///////////////////////////////////////////////////////////////////////////////////////////////////////


////////   Reflectivity Array /////////

uchar DCL[]
uchar UBS[]
uchar RBL[]
uchar UL[120][256]

uchar DC[240][1]
uchar BS[240][1]

float RL[][]
float RBF[]
float RBS[]

int rf_val = 10

// make test cloud
// 240 levels -- 250' each
// 256 range bins

kv = 0

for (j = 50; j < 200; j++) {

   for (i = 0; i < 90; i++) {

      if ( i < 20) {
      rf_val = i
      }
      else if (i < 40) {
//         rf_val = 25 - kv/2 
       if (j <100) {
         rf_val = 25
       }
       else { 
        rf_val = 45
       }
      }

      else if (i < 60) {
 //        rf_val = 35 + (sin(kv/0.1) * 20) 
       if (j <100) {
         rf_val = 35
       }
       else {
        rf_val = 15
       }
      }

      else if (i < 80) {
//         rf_val = 45 +kv/2
       if (j < 100) {
         rf_val = 45
       }
       else {
         rf_val = 25
       }
      }
      

      UL[i][j] = rf_val 

//           if ( (j % 20) == 0) {
//             kv++
//           }

//<<"$i $j  $rf_val  $UL[i][j] \n"
   }

          kv++

        if (kv > 30) {
          kv = 0
        }

}

/////////////////////////////////////////////////////////////////////////////

   for (i = 0; i < 120; i++) {

    <<"$i $UL[i][50] \n"

   }




// convert to float
   RL = UL

sz = cab(RL)

<<"$sz \n"

/{
   for (i = 0; i < 120; i++) {

    <<"$i %6.1f$RL[i][50] \n"

   }
/}


<<"B4 mat sz $(Caz(UL))\n"


// double the pix
   NRL = colZoom(RL,240,1)

   UL = NRL


<<"mat sz $(Caz(UL))\n"



include "bdc_graphic"

  setgwob(lri_wo,@clear,@border,@showpixmap,@save)
  plotPixRect(lri_wo,UL,mapi)
  setgwob(lri_wo,@showpixmap,@save)


   Ibeam = 1.0/Bm

   RBF = NRL
   RBS = NRL
   RBD = NRL


//   RBF[::][10] = 50
//   RBF[::][11] = 50
//   Inpat = RBF[::][50] 
//   Redimn(Inpat)
//   <<"%(10,, ,\n)$Inpat \n"
//   Op = lconvolve( Bm, Inpat)
//   <<"Op sz $(Caz(Op)) \n"
//   <<"%(10,, ,\n)$Op \n"
//  RBF[::][50] = Op[half_bw:239]

float scale_convolve = 0.5

int xi = 0
int yi = 0





   for (i = 51 ; i < 200 ; i++) {

      //<<"%V$i smear-desmear \n"

    resize(Bm,nb)

    make_beam (nb)


       Inpat = RBF[::][i] 

<<"$(Caz(Inpat)) \n"

// show Ip
   Redimn(Inpat)

   Sinput = Inpat * 2

   if (i == 51) {
     //sigi_gl=CreateGline(@woid,sigi_wo,@type,"XY",@xvec, XV, @yvec, Sinput, @color, "blue" ,@usescales,0)
     sigi_gl=CreateGline(@woid,sigi_wo,@type,"Y", @yvec, Sinput, @color, "blue" ,@usescales,0)
   
     setGwob(sigi_wo,@clipborder,@border)
   }






//Inpat = Inpat + 1
//<<"$i\n"
//<<"$Inpat \n"

 if (i >= 51) {
   setGwob(sigi_wo,@clearpixmap)
   setGline(sigi_gl,@draw,1)
//   drawY(sigi_wo,Sinput,1,0.9)
   setGwob(sigi_wo,@showpixmap,@save)
 }

// plotline(sigi_wo,0,0,120,50,"red")
// drawY(sigi_wo,Inpat)



/////////////  CONVOLVE BEAM /////////////////////////

// CHECK    Op = lconvolve( Bm, Inpat)




//     Op =  Inpat

       Op = lconvolve( Bm, Inpat)

//       Op /= 15.0
//if (i == 52) {
//<<"%(10,, ,\n)$Op \n"
//}
//    RBS[::][i] = Op[half_bw:239]



// show Op

  
  Spat = Op
// scale after the convolve
sz = Cab(Spat)
<<"Spatsz $sz \n"
  redimn(Spat)

sz = Cab(Spat)
<<"Spatsz $sz \n"

  mm = minmax(Spat)
sz = Cab(mm)
<<"mmsz $sz \n"

<<"minmax $mm \n"

  if (mm[1] != 0.0) 
  scale_convolve = 80.0/mm[1]
  else
  scale_convolve = 1.0

<<"%V$scale_convolve \n"

  Sop = Op  * scale_convolve


  BS[::][0] = Sop

  //RBS[::][i] = Op

 RBS[::][i] = Sop

  plotPixRect(lrrb_wo,BS,mapi,xi,yi)
  setgwob(lrrb_wo,@border,@showpixmap)

  Sfpat = Sop

  if (i == 51) {
//    setGline(sigs_gl,@type,"Y", @yvec, Spat, @color, "red" ,@usescales,0)
    sigs_gl=CreateGline(@woid,sigs_wo,@type,"Y", @yvec, Sfpat, @color, "blue" ,@usescales,0)
    setGwob(sigs_wo,@clipborder,@border)
  }

 if (i >= 51) {
   setGwob(sigs_wo,@clearpixmap)
   setGline(sigs_gl,@draw,1)
//   drawY(sigs_wo,Spat,1,0.9)
   setGwob(sigs_wo,@showpixmap)
 }
   //plotline(sigs_wo,0,0,120,50,"blue")
  // drawY(sigs_wo,Spat)



/////////////////////////////////////// ATTEMPT DESPREAD /////////////////////////////////////////////////////


   bm_despread()

   RBD[::][i] = R[0:239]

// show Dc

   Dpat = R[0:239]
   Dspat = Dpat * 1


//   DC[::][0] = R[0:239]

   DC[::][0] = Dpat

  if (i == 51) {
   sigd_gl=CreateGline(@woid,sigd_wo,@type,"Y", @yvec, Dspat, @color, "green" ,@usescales,0)
   setGwob(sigd_wo,@clipborder,@border)
  }


//   setGwob(sigd_wo,@clearpixmap,@clipborder,@border)
 if (i >= 51) {
   setGwob(sigd_wo,@clearpixmap)
//   drawY(sigd_wo,Dspat,1,0.9)
   setGline(sigd_gl,@draw,1)
   setGwob(sigd_wo,@showpixmap,@save)
 }


  plotPixRect(lrds_wo,DC,mapi,xi,yi)
  xi++

  setgwob(lrds_wo,@border,@showpixmap,@save)


 //  ask=i_read(":-->> $i  $xi")
 //  sleep(0.2)
     if ( (i % 4) == 0) {

       nb += 2

     } 

 }



<<"RBS $(Cab(RBS))\n"

   DCL = RBD

<<"DCL $(Cab(DCL))\n"


stop!
  setgwob(lrds_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lrds_wo,DCL,mapi)
 
  setgwob(lrds_wo,@clear,@border,@showpixmap)




   RBS /= 50




<<"UBS $(Cab(UBS))\n"

   UBS = RBS

<<"UBS $(Cab(UBS))\n"

<<"RBD $(Cab(RBD))\n"






//
//  read in cloud sweep image

    redraw_vs()

stop!
//////////////////////////  EVENT LOOP ////////////////////

include "event"

Event E

  setGwindow(aw,@pop,@redraw)
  
  redraw_vs()

  while (1) {

    E->waitForMsg()

    if ((E->keyw @= "REDRAW") || (E->keyw @= "RESIZE")) {
      redraw_vs()
    }

  }




