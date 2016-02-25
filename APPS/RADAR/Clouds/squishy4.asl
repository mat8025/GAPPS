
/////////////////////////////////////


float RS[]
float RL[]

float NRZ[]

float SRVEC[]
float LRVEC[]
float Lrip[]
uchar ULI[]
uchar UBDC[]

double Bm[] 

double R[]   // recovered signal
double Op[]

float Inpat[]
float Spat[]
float Dpat[]
float XV[]


//////////////////////////////////////

double pwr

proc bm_despread()
{
///  now run the deconvolution  until beam RH edge runs upto end of smeared signal - 


<<"input \n"

<<"%(10,, ,\n)$Op\n"

//i_read()

<<"beam \n"
<<"%(10,, ,\n)$Bm\n"

//i_read()


  R = dconvolve(Op,Bm)

  sz = Cab(R)

  <<"$sz \n"

<<"Output \n"
<<"%(10,, ,\n)6.1f$R\n"

  pwr = rms(R)

 <<"%V$pwr \n"
//i_read()

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


<<"%V$new_bm \n"

    Bm = new_bm[1:-2]

<<"$(Caz(Bm)) \n"


<<"%V$Bm \n"

//i_read()

}





//  show original ?? from eaglesim



//  read in a cloud at range x nmiles - that has been through the eaglesim and has the beam spread built in

///////////////////////////////////////  CL_ARGS /////////////////////////////////////////////////////

fn = _clarg[1]

<<"$fn \n"

  A= ofr(fn)



  RL= readRecord(A,@del,',',@nrecords,120)

  b = Cab(RL)

  <<"bounds $b \n"

  RL->limit(0,75)

  for (alt = 20; alt < 100; alt++) {
   LRVEC_1 = RL[alt][::]
   <<"%6.1f$LRVEC_1\n"
  }




i_read()



  NRL = colZoom(RL,240,1)

  NRL->limit(0,75)


   b = Cab(NRL)
  <<"bounds $b \n"

   b = Cab(LRVEC_1)
  <<"bounds LRVEC_1 $b \n"

LRVEC = NRL[0][::]

   b = Cab(LRVEC)
  <<"bounds LRVEC $b \n"



  for (alt = 20; alt < 60; alt++) {
   LRVEC_1 = RL[alt][::]
   <<"%(10,, ,\n)6.1f$LRVEC_1\n"
   LRVEC = NRL[alt*2][::]
   <<"%(10,, ,\n)6.1f$LRVEC\n"
//i_read()   
  }

<<"check NRL \n"

//i_read()


   ULI = NRL

  b = Cab(ULI)

  <<"bounds $b \n"


   UBDC = RL





// apply the range dependent squish --- via triangular window deconvolver ( crude representation of the antenna)
// first floor the reflectivity values to zero

 


// make the crude antenna pattern

   make_beam(2)

<<"made beam \n"

   RBF = RL
   RBD = RL
// deconvolve with the beam at the specified range
// for each alt col - deconvolve


   Inpat = RBF[::][20] 
   Redimn(Inpat)

   Op = Inpat
<<"Input \n"
<<"%(10,, ,\n)$Op\n"

   Op *= 100

<<"%(10,, ,\n)$Op\n"

//i_read()

   bm_despread()





int xi = 0
int yi = 0

// for each nmile do the despread

   bw = 2

   start_nm = 10


/{
include "bdc_graphic.asl"


//  plot image

  plotPixRect(lri_wo,ULI,mapi,0,240,1)

  setgwob(lri_wo,@clear,@border,@showpixmap)

/}


//  setgwob(lri_wo,@clear,@border,@showpixmap)

// measure cloud top & bottom




   for (i = start_nm ; i < 180 ; i++) {

      //<<"%V$i smear-desmear \n"

   Inpat = RBF[::][i] 

//<<"$(Caz(Inpat)) \n"

/{
   if (i == start_nm) {
     sigi_gl=CreateGline(@woid,sigi_wo,@type,"XY",@xvec, XV, @yvec, Inpat, @color, "blue" ,@usescales,0)
     setGwob(sigi_wo,@clipborder,@border)
   }

/}

// show Ip

   Redimn(Inpat)

/{
   setGwob(sigi_wo,@clearpixmap)
   setGline(sigi_gl,@draw)
   setGwob(sigi_wo,@showpixmap)


   if (i == start_nm) {
    setGline(sigs_gl,@type,"Y", @yvec, Spat, @color, "red" ,@usescales,0)
    setGwob(sigs_wo,@clipborder,@border)
   }




   setGwob(sigs_wo,@clearpixmap)
   setGline(sigs_gl,@draw)
   setGwob(sigs_wo,@showpixmap)

/}

/////////////////////////////////////// ATTEMPT DESPREAD /////////////////////////////////////////////////////

   Op = Inpat
<<"Input \n"
<<"%(10,, ,\n)$Op\n"

<<"//////////////////////////////////////\n"
i_read()

   Op *= 200

<<"%(10,, ,\n)$Op\n"

i_read()

   bm_despread()


<<"$(Cab(R)) \n"
<<"$(typeof(R)) \n"
<<"output \n"
<<"%(10,, ,\n)$R\n"
<<"//////////////////////////////////////\n"

//i_read()


   RBD[::][i] = R[0:119]

// show Dc

   Dpat = R[0:119]

   UBDC[::][0] = R[0:119]

/{
  if (i == start_nm) {
   sigd_gl=CreateGline(@woid,sigd_wo,@type,"Y", @yvec, Dpat, @color, "green" ,@usescales,0)
   setGwob(sigd_wo,@clipborder,@border)
  }
/}

//   setGwob(sigd_wo,@clearpixmap,@clipborder,@border)
/{
   setGwob(sigd_wo,@clearpixmap)
   setGline(sigd_gl,@draw)
   setGwob(sigd_wo,@showpixmap)

  plotPixRect(lrds_wo,UBDC,mapi,xi,120-yi,1)
/}
  xi++

//  setgwob(lrds_wo,@border,@showpixmap,@drawon)


  }






/{

  setgwob(lrrb_wo,@BORDER,@drawoff,@clearpixmap)

  plotPixRect(lrrb_wo,UBDC,mapi,0,240,1)
 
  setgwob(lrrb_wo,@clear,@border,@showpixmap)

/}

  si_pause(3)

// measure cloud top & bottom

// plot


//  compare raw and squished ---- top and bottom in right place






stop!