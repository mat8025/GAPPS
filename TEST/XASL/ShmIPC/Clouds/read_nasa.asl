
//setdebug(1)



opendll("math","image","plot")

proc redraw()
{
  
   setgwob(lri_wo,@BORDER,@drawoff,@clearpixmap,@scales,0,0,1003,17000)

   NRZ=rowZoom(VS,nxp,1)

   NRZ = vrange(NRZ,0,100,0,100)

   UL =  Transpose(rowZoom(Transpose(NRZ),nyp,1))


   plotPixRect(lri_wo,UL,mapi)

   setgwob(lri_wo,@clear,@border,@showpixmap,@drawon,@clipborder)

    axnum(lri_wo,1,0,1000,100,1)
    axnum(lri_wo,2,0,17000,1000,1)
//  axnum(sri_wo,1,0,40,5,1)
    setgwob(x_wo,@VALUE,vs_i,@redraw)

}


//m2ft = 3.280839

proc redrawHS()
{
  
int ft 

   ft = hs_i * 100 * m2ft
<<"$hs_i $ft \n"

   setgwob(lri_wo,@BORDER,@drawoff,@clearpixmap,@scales,0,0,1003,1003)

   NRZ=rowZoom(HS,nxp,1)

   NRZ = vrange(NRZ,0,100,0,100)

   UL =  Transpose(rowZoom(Transpose(NRZ),nyp,1))


   plotPixRect(lri_wo,UL,mapi)

  setgwob(lri_wo,@clear,@border,@showpixmap,@drawon)

    axnum(lri_wo,1,0,1000,100,1)

    axnum(lri_wo,2,0,1000,100,1)

  
  setgwob(alt_wo,@VALUE, ft ,@redraw)

}


proc buildVS(si)
{

long ks = 0

 ks = 260 + (1003 * 2) * si

<<"$ks \n"


 fseek(A,ks,0)

ia = 170

// build a vertical slice at si index
// at 


for (j = 0; j < 171; j++) {


 fseek(A,ks,0)

 ks += (1003 * 1003 * 2) // go up another level
//<<"$ks \n"

 n=vread(A,VFR,ny,SHORT,0.01)

 VS[ia][::]=  VFR
 ia--
 
// <<"[ $j,$ia ]  %(10,, ,\n)$VS[0:9]\n"

//<<" alt $(j*100) \n"

}

}

proc buildHS(alti)
{

long ks = 0

 if (alti > 170)
     alti = 170

 ks = 260 + (1003 * 1003 * 2) * alti

<<"$ks \n"


 fseek(A,ks,0)



// get horizontal slice
// at 

ia = 0
 for (j = 0; j < 1003; j++) {


 n=vread(A,VFR,ny,SHORT,0.01)

 HS[ia][::]=  VFR
 ia++

 }

}

// FIX read 3D array -- set 2D into 3D
// the cloud

short TC[171][1003][1003]

proc readTC()
{

 nalt = 10

 ia = 0
 
 fseek(A,240,0)

 for (ia = 0; ia < nalt; ia++) {

   for (j = 0; j < 1003; j++) {

      n=vread(A,VFR,ny,SHORT,0.01)

      TC[ia][j][::] = VFR
<<"TC $ia , $j \n"
   }


 }

// Redimn(TC,nalt,1003,1003)
  b = Cab(TC)
<<"TC  $b\n"


}

include "event"
include "consts"

Event E


float VFR[]
float VS[171][1003]

float HS[1003][1003]



/////////////////////////////// Color Map ------- Cloud dbZ
///////////////////////////////

mapi = 100

mapki = mapi
// black



 rgb_v = getRGB("WHITE")
<<"$rgb_v WHITE\n"

// 0 - 5 dBZ
 for (i = 0; i < 10; i++) {

  setrgb(mapki,rgb_v[0],rgb_v[1], rgb_v[2])
  mapki++

 }



// 5-15

    pi = getColorIndexFromName("skyblue")

 rgb_v = getRGB("skyblue")
<<"$rgb_v SKYBLUE\n"

<<"%V$pi  Skyblue\n"


 for (i = 10; i < 15; i++) {

    //setrgb(mapki,0,0.9,0)

    setrgb(mapki,rgb_v)

    //setrgbfromIndex(mapki,pi)

    r_rgb_v = getRGB(mapki)

   <<"$mapki $r_rgb_v \n"

    mapki++

 }





// yellow

// 15 -25

 for (i = 15; i < 20; i++) {

//  setrgb(mapki,0.0,0.0,0.9)
  setrgbfromIndex(mapki,BLUE)
  mapki++

 }


    pi = getColorIndexFromName("green")

 for (i = 20; i < 30; i++) {

  //setrgb(mapki,0,0.9,0)


//<<"%V$pi\n"
  setrgbfromIndex(mapki,pi)
  mapki++

 }


 for (i = 30; i < 40; i++) {

  //setrgb(mapki,0.9,0.9,0)

  setrgbfromIndex(mapki,YELLOW)

  mapki++

 }



// red

// 25 -45

 pi = getColorIndexFromName("red")
<<"%V$pi  RED\n"

 for (i = 40; i < 50; i++) {

  // setrgb(mapki,0.9,0.0,0)
    setrgbfromIndex(mapki,RED)
    mapki++
 }



// white

// 45 ->>

  pi = getColorIndexFromName("red")
<<"%V$pi\n"

 for (i = 50; i < 65; i++) {
    setrgbfromIndex(mapki,pi)
    mapki++
 }

  pi = getColorIndexFromName("purple")
<<"%V$pi white\n"

 for (i = 65; i < 200; i++) {
    setrgbfromIndex(mapki,pi)
    mapki++
 }

/////////////////////////////////////////////////////////////////





//////////////////////  READ NASA ///////////////////////////




fn = _clarg[1])
<<"fn $fn \n"

A= ofr(fn)

<<"FH $A\n"

char C[]

C[0] = H

n = rcfile(A,&C[2],200)

<<"read $n \n"

<<"%s$C\n"

int N[4]


n=vread(A,N,4)

nx = N[0]
ny = N[1]
nz = N[2]

double Y[3]


n=vread(A,Y,3)

double S[3]

n=vread(A,S,3)


// fscanv(A,"I3,I3,I3",N,Y,S)


<<"  $N \n"

<<"  $Y \n"

<<"  $S \n"




short SV[1003]

float FV[1003][1003]

 //fscanv(A,"S10",SV)

//for (j = 0; j < 171; j++) {

//  build a layer

for (j = 0; j < 2; j++) {

 for (i = 0; i < nx; i++ ) {


 n=vread(A,SV,ny)
//<<"$j $i $n\n"
 FV[i][::]=SV 

// <<"[ $j,$i ]  %(10,, ,\n)$FV[0:9]\n"

 }
<<" alt $j \n"
}




// build a vertical slice

for (j = 0; j < 10; j++) {
    <<"$FV[0][0:9] \n"
}






float NRZ[]

uchar U[]

uchar UL[]

uchar N_UL[]


buildVS(500)


//   FV[::][::] /= 100;





//  OK now we have a vert slice  171 x 1003 of floats
//  for now get a pixrect 
//  but want really want  dimage matrix plot



//   readTC()






int CI[]



    aw= CreateGwindow(@title,"CLOUD_SWEEP")

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.01,0.11,0.99,0.95,0)
    SetGwindow(aw,@drawon,@pixmapon,@save)
    SetGwindow(aw,@clip,0.1,0.1,0.95,0.9)

   // GraphWo

   lri_wo=createGWOB(aw,@GRAPH,@resize,0.1,0.1,0.7,0.9,@name,"PY",@color,"white")

<<"%V$lri_wo \n"
   // lri image 185 units of 1200 meters  --- range is 120 nmiles

   setgwob(lri_wo,@drawon,@pixmapon,@save,@clip,0.1,0.1,0.8,0.9,@scales,0,0,1000,17000,@savescales,0)


   setgwob(lri_wo,@border,@redraw)

   int p_wos[3]
   int n_wos = 0
   alt_wo=createGWOB(aw,"BV",@name,"ALT",@color,"white",@resize,0.85,0.8,0.9,0.9)
   setgwob(alt_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,-1,@STYLE,"SVB")
   setgwob(alt_wo,@bhue,"red",@clipbhue,"blue")
   p_wos[0] = alt_wo
   n_wos++
   x_wo=createGWOB(aw,"BV",@name,"X_P",@color,"green",@resize,0.85,0.7,0.9,0.8)
   setgwob(x_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,-1,@STYLE,"SVB")
   setgwob(x_wo,@bhue,"red",@clipbhue,"blue")
   p_wos[1] = x_wo
   y_wo=createGWOB(aw,"BV",@name,"Y_P",@color,"blue",@resize,0.85,0.8,0.9,0.9)
   setgwob(y_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,-1,@STYLE,"SVB")
   setgwob(y_wo,@bhue,"red",@clipbhue,"blue")
   p_wos[2] = y_wo

  
   wo_vtile(p_wos,0.85,0.5,0.9,0.9,0.01)
   setgwin(aw,@redraw)


   by = 0.5
   bY = 0.59
   nxt_wo=createGWOB(aw,"BN",@name,"NEXT",@VALUE,"NEXT",@color,"orange",@resize_fr,0.02,by,0.09,bY)
   setgwob(nxt_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@redraw)
   by -= 0.1
   bY -= 0.1

   up_wo=createGWOB(aw,"BN",@name,"UP",@VALUE,"UP",@color,"orange",@resize_fr,0.02,by,0.09,bY)
   setgwob(up_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@redraw)
   by -= 0.1
   bY -= 0.1
   down_wo=createGWOB(aw,"BN",@name,"DOWN",@VALUE,"DOWN",@color,"orange",@resize_fr,0.02,by,0.09,bY)
   setgwob(down_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@redraw)
   by -= 0.1
   bY -= 0.1
   quit_wo=createGWOB(aw,"BN",@name,"QUIT",@VALUE,"QUIT",@color,"orange",@resize_fr,0.02,by,0.09,bY)
   setgwob(quit_wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK,@redraw)




   CI =getWoClip(lri_wo)


<<"CI is $CI\n"

   nxp = CI[3] - CI[1]

   nyp = CI[4] - CI[2]

<<"%V$nxp $CI[3] $CI[1]\n"

<<"%V$nyp $CI[4] $CI[2]\n"


  // setgwob(lri_wo,@scales,0,0,nxp,120,@savescales,0)

  // transform vert slice

   vs_i = 500
   hs_i = 5


   buildVS(vs_i)
   redraw()





   while (1) {

    E->waitForMsg()

//<<"keyw $E->keyw $E->woname $E->woval\n"

    if (! (E->keyw @= "NO_MSG")) {

    if (E->woname @= "QUIT") {
         break
    }


    if (E->woname @= "NEXT") {

      buildVS(vs_i)
      
   
       vs_i += 10

      if (vs_i > 1000) {
          vs_i = 0
      }


      redraw()
      

    }

    if (E->woname @= "DOWN") {

      hs_i -= 1

      if (hs_i <0) {
          hs_i = 0
      }

      buildHS(hs_i)

      redrawHS()

    }

    if (E->woname @= "UP") {

      hs_i += 1

      if (hs_i > 170) {
          hs_i = 170
      }

      buildHS(hs_i)

      redrawHS()

    }



 
    }

  }


   w_delete(aw)

