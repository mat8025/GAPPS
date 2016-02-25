//  test beam deconvolution of cloud reflectivity arrays

setdebug(0)
/////////////////////////////////////////////////////////////

double pwr

range_nm = 256

uchar DCL[]
uchar UBS[]
uchar RBL[]
uchar UL[120][range_nm]
uchar ULI[]

uchar DC[240][1]
uchar BS[240][1]

float RL[]
float RBF[]
float RBS[]

double Bm[] 

double RS[]   // recovered signal
double Op[]

float Inpat[]
float Spat[]
float Dpat[]

XV = vgen(FLOAT,300,0,1)

RS = 0.0


proc bm_despread()
{
///  now run the deconvolution  until beam RH edge runs upto end of smeared signal - 
<<"input \n"
<<"%(10,, ,\n)$Op\n"

<<"beam \n"
<<"%(10,, ,\n)$Bm\n"



  RS = dconvolve(Op,Bm)
//  T = dconvolve(Op,Bm)

//  R[30:32] = 0

<<"Output \n"
<<"%(10,, ,\n)6.1f$R\n"

//i_read()
  sz = Cab(RS)

  <<"$sz \n"

  pwr = rms(RS)

 <<"%V$pwr \n"


}


proc make_clouds()
{

// make a series of down-range clouds
// space 10 nmiles apart -- 5 nmiles wide
// 240 levels -- 250' each
// 256 range bins

   kv = 0

rf_val = 40

for (jr = 10; jr < (range_nm-40) ; jr += 30) {

   for (ic = 0; ic < 25; ic++) {

      wc = jr + ic

    for (i = 0; i < 20; i++) {
      UL[i][wc] = 0 
    }
 
    rf_val = 18
    for (i = 20; i < 40; i++) {
       kr = rand()
       rdbz = kr % 10
      UL[i][wc] = rdbz + rf_val++ 
    }

    for (i = 40; i < 80; i++) {
      kr = rand()
       rdbz = kr % 10
      UL[i][wc] = rdbz + rf_val-- 
    }

    for (i = 80; i < 90; i++) {
      UL[i][wc] = rf_val++ 
    }


    for (i = 90; i < 100; i++) {
       kr = rand()
       rdbz = kr % 30

       UL[i][wc] = rdbz
    }

    for (i = 100; i < 120; i++) {
      UL[i][wc] = rf_val
      rf_val -= 3 
    }

   }

  }

}




proc make_beam( wide)
{


// beam smear
nb = 37 + wide
float new_bm[nb]

//  what does the beam antenna gain look like ---- symmetrical
//  3 1/2 deg beam-width -- where gain is at 1/2 (3 db down) so 1.75 deg either side 
//  but we have sparse samples --
//  so do we interpolate then despread 

int half_bw = nb/2
int mp = half_bw

//float Bm[nb] = { 0.125, 0.25, 0.5, 0.75, 1.0, 0.75, 0.5, 0.25, 0.125 }

  <<"%V$nb $half_bw $mp \n"


  float dy = 1.0/(half_bw + 1)

//  triangle _/\_   convolver
/{
      new_bm[mp] = 1.0;  // mid_point is 1.0!
       wt = dy
       //wt = 0 // initial not zero
      for (i = 0; i < half_bw; i++) {
         new_bm[i] = wt;
         new_bm[nb-1-i] = wt;
         wt += dy;
         if (new_bm[i] < 0) {
<<"bad beam \n"
             stop!
         }

      }
/}


//  N.B. - has to be all positive

  new_bm = swindow("triangular",nb+2)


//<<"%V$new_bm \n"

    Bm = new_bm[1:-2]

//<<"$(Caz(Bm)) \n"
//<<"%V$Bm \n"

//i_read()
}

///////////////////////////////////////////////////////////////////////////////////////////////////////


////////   Reflectivity Array /////////



int rf_val = 10

UL = 0

/////////////////////////////////////////////////////////////////////////////

   make_clouds()


//<<"%($range_nm,, ,\n)$UL \n"



  make_beam(2)

<<"$Bm \n"

<<"%V$mapi \n"



// convert to float
   RL = UL

// double the pix

   NRL = colZoom(RL,240,1)

   ULI = NRL

<<"mat sz $(Caz(ULI))\n"

include "bdc_graphic"

// plotpixrect -- will convert float to uchar --- no alert for lack of precision

  plotPixRect(lri_wo,ULI,mapi,0,240,1)

  setgwob(lri_wo,@clear,@border,@showpixmap)






Ibeam = 1.0/Bm

   RBF = NRL
   RBS = NRL
   RBD = NRL


//   RBF[::][10] = 50
//   RBF[::][11] = 50

//   Inpat = RBF[::][50] 

//   Redimn(Inpat)
//<<"%(10,, ,\n)$Inpat \n"

//   Op = lconvolve( Bm, Inpat)

//<<"Op sz $(Caz(Op)) \n"
  
//<<"%(10,, ,\n)$Op \n"



int xi = 0
int yi = 0

// for each nmile do the despread

   bw = 2

   start_nm = 10

   for (i = start_nm ; i < 256 ; i++) {

      //<<"%V$i smear-desmear \n"

   Inpat = RBF[::][i] 

//<<"$(Caz(Inpat)) \n"

   if (i == start_nm) {
     sigi_gl=CreateGline(@woid,sigi_wo,@type,"XY",@xvec, XV, @yvec, Inpat, @color, "blue" ,@usescales,0)
     setGwob(sigi_wo,@clipborder,@border)
   }

// show Ip

   Redimn(Inpat)


//Inpat = Inpat + 1
//<<"$i\n"
//<<"$Inpat \n"

   setGwob(sigi_wo,@clearpixmap)
   setGline(sigi_gl,@draw)
   setGwob(sigi_wo,@showpixmap)




/////////////  CONVOLVE BEAM /////////////////////////

   make_beam(bw)

   if ((i%20) ==0) {

        bw +=2
   }


   Op = lconvolve( Bm, Inpat)

   RBS[::][i] = Op

// show Op

  
  Spat = Op

  BS[::][0] = Op/10

  plotPixRect(lrrb_wo,BS,mapi,xi,(260+bw/2)-yi,1)

  setgwob(lrrb_wo,@border,@showpixmap)


  if (i == start_nm) {
    setGline(sigs_gl,@type,"Y", @yvec, Spat, @color, "red" ,@usescales,0)
    setGwob(sigs_wo,@clipborder,@border)
  }

   setGwob(sigs_wo,@clearpixmap)
   setGline(sigs_gl,@draw)
   setGwob(sigs_wo,@showpixmap)

   //plotline(sigs_wo,0,0,120,50,"blue")
  // drawY(sigs_wo,Spat)


/////////////////////////////////////// ATTEMPT DESPREAD /////////////////////////////////////////////////////


   bm_despread()

<<"$(Cab(RS)) \n"
<<"$(typeof(RS)) \n"

/{
for (jj = 0; jj < 240; jj++) {

<<"$jj $R[jj] \n"
  ask=i_read(":-->> $ic")

}
/}

   RBD[::][i] = RS[0:239]

// show Dc

   Dpat = RS[0:239]

   DC[::][0] = RS[0:239]

  if (i == start_nm) {
   sigd_gl=CreateGline(@woid,sigd_wo,@type,"Y", @yvec, Dpat, @color, "green" ,@usescales,0)
   setGwob(sigd_wo,@clipborder,@border)
  }


//   setGwob(sigd_wo,@clearpixmap,@clipborder,@border)

   setGwob(sigd_wo,@clearpixmap)
   setGline(sigd_gl,@draw)
   setGwob(sigd_wo,@showpixmap)

  plotPixRect(lrds_wo,DC,mapi,xi,240-yi,1)

  xi++

  setgwob(lrds_wo,@border,@showpixmap,@drawon)


  }



<<"RBS $(Cab(RBS))\n"

   DCL = RBD

<<"DCL $(Cab(DCL))\n"

  setgwob(lrds_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lrds_wo,DCL,mapi,0,240,1)
 
  setgwob(lrds_wo,@clear,@border,@showpixmap)




   RBS /= 50


stop!

<<"UBS $(Cab(UBS))\n"

   UBS = RBS

<<"UBS $(Cab(UBS))\n"

<<"RBD $(Cab(RBD))\n"



//
//  read in cloud sweep image

    redraw_vs()


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




