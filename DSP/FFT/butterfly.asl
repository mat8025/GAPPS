////
////  show  butterfly  for FFT radix 2  /////


proc sbitrev( ival, n)
{
int I[n]
int j;

     k = 1
     for (j = 0; j < n ; j++) {
        b = (ival & k);
        k = ( k << 1);
        I[j] = !(b ==0);
     }

     I->reverse()

     c = 0;
     k = 1;
     for (j = 0; j < n ; j++) {
       if (I[j] == 1) {
         c = c + k
       }
         k = (k << 1)
     }
     return c;
}
/////////////////////////////////////////

 na = argc()

//<<"%V$na  $_clarg \n"

 N = atoi (_clarg[1])

 if (N <= 0) {
 <<"no N specified setting to 16\n"
  N= 16
 // exitsi()

 }
// is it power of 2 ?

 int n = log2(N)

 M = 2^^n

<<"%V$N $n  $M\n"

 if (M != N) {

<<"not power of 2\n"

  exitsi()

 }
///////////////////////////////////////////////


// set up the complex Re Im vectors

float Re[N];
float Im[N];


 pi = 4.0*atan(1.0);
// Sf= 40.0;

 f = 10.0;
 Sf = N * f;
 dt = 1.0/Sf;

 sig  = fgen(N,0,2*pi*f*dt)

<<"Signal:- $sig\n"

 Re = sin(sig);
 Im = 0;
<<"In \n"

<<"$Re\n" 
<<"$Im\n"



int n_stages = n
int n_bflys = N/2


//  how many pairs
<<"pairs $n \n"

/// then how many stages

<<"%V$n_stages \n"
///  draw pairs

////////////// Window ///////////////////
Graphic = CheckGwm()


if (!Graphic) {
     X=spawngwm()
 }


 aw = cWi(@title,"BUTTERFLY_DEMO",@resize,0.01,0.01,0.99,0.99)
 sWi(aw,@hue,BLUE_,@bhue,WHITE_,@drawon,@pixmapon)


// wob

     bflywo = cWo(aw,@graph,@penhue,RED_,@name,"butterfly")

     sWo(bflywo,@resize,0.01,0.01,0.99,0.99)

     sWo(bflywo,@clip,0.1,0.1,0.9,0.95,@drawon,@save,@savepixmap)

     sWo(bflywo,@scales,0,0,1.0,1.0)

     sWi(aw,@redraw)

     naw=wkeep(aw)

     sWo(bflywo,@border,@redraw)
// lines

    gy = 0.96 // use this ratio of drawing area
    goy = (1-gy)/2



    float dy = 0.96/ N


    dx = 0.96 / n_stages 

///////////  label stages ///////////////////////
    x = dx/2
    for (i = 1; i <= n_stages ; i++ ) {
         Text(bflywo,"Stage_$i",x, 1.0,TEXT_AXIS_TOP_)
         x += dx
    }

///////////////////////////////////////////////////
///////////  label input /////////////////////////
/// label bit-reversed input  e.g for 4  0,1,2,3  bitrev 00,10,01,11  x(0),x(2),x(1),x(3)
/// for 8 0,1,2,3,4,5,6,7  000, 100, 010, 110, 001, 101, 011, 111 --
/// --- x(0), x(4),x(2),x(6),x(1),x(5),x(3),x(7)

    int bri = 0;
        y =  1-goy;
	
    for (i = 0; i < N ; i++ ) {
        bri = bitrev(i,n_stages)

        Text(bflywo,"Re[${bri}] $Re[bri]", y, 9.0,TEXT_AXIS_LEFT_)
        Text(bflywo,"Im[${bri}] $Im[bri]", y-dy/6, 9.0,TEXT_AXIS_LEFT_)	
        y -= dy
    }
/{
     y =  1-goy;

    for (i = 0; i < N ; i++ ) {
        bri = bitrev(i,n_stages)
        Text(bflywo,"x($bri)", y, 3.0,TEXT_AXIS_LEFT_)
        y -= dy
    }
/}
//////////////////////////////////////////////////////////

/// label Frequency output  0,1,2,3,4, ...
        y =  1-goy
    for (i = 0; i < N ; i++ ) {
        Text(bflywo,"Re[${i}] $Re[i]", y, 8.0,TEXT_AXIS_RIGHT_)
        Text(bflywo,"Im[${i}] $Im[i]", y-dy/6, 8.0,TEXT_AXIS_RIGHT_)	
        //Text(bflywo,"F($i)", y, 1.0,TEXT_AXIS_RIGHT)
             y -= dy
    }

    y =  1-goy

    for (i = 0; i < N ; i++ ) {

     plot(bflywo,@line,0,y,1,y,BLUE_)

     y -= dy
<<"$i $y \n"
    // sWo(bflywo,@showpixmap)
    }

//////////////////////////////////////////////////////////
float dxs
float dxsa
    y =  1-goy
    x = dx/4
    dxs = x * 3
    dxsa = x * 2.70
    dxsri = x * 2.71

/////////   BUTTERFLIES   ////////////////////////////////

// how many stage 1 butterflies ?



  for (j = 1 ; j <= n_stages ; j++) {

      nos = j

      p2 = 2^^nos
      nbfis = N / p2


      nlib = p2
      ntbl = nlib/2

<<"%V$j $nbfis $nlib $ntbl $x $n_stages\n"

      ty =  1 - goy

    for (i = 0; i < nbfis ; i++ ) {

      y = ty - (i * (nlib*dy)) 

      // top lines
      for (k = 0 ; k < ntbl ; k++) {
       plot(bflywo,@arrow,x,y,x+dxsa,y-(nlib/2*dy),1.0,BLUE_)
       y -= dy
      }

      // bottom lines
      y = ty - (i* (nlib*dy)) - (dy *ntbl)
      for (k = 0 ; k < ntbl ; k++) {
          plot(bflywo,@arrow,x,y,x+dxsa,y+(nlib/2*dy),1.0,RED_)
          Text(bflywo,"W$k/$p2",x+(-dxs/10),y)
          Text(bflywo,"-1",x+(3*dxs/4),y-dy/4)
          y -= dy
      }


      // compute 
      // each butterfly
      // two inputs
      // -- straight thru
      // -- mul by twiddle factor
      // top output  = top_input + Twf * bot_input
      // bot output  = top_input - Twf * bot_input








      // show Re,Im
     y =  1-goy
      for (k = 0; k < N ; k++ ) {
        Text(bflywo,"Re[${k}] $Re[k]",x+dxsri, y)
        Text(bflywo,"Im[${k}] $Im[k]",x+dxsri, y-dy/6)	
      y -= dy
      }


//<<"$i $y \n"
    }

          x += dx  

 }


<<"Out \n"

<<"$Re\n" 
<<"$Im\n"

/////////////////////////////////////
/// for each stage do the butterflies
/// now label the twiddle factors
/// finally  produce the eqn's

  gflush()
  sleep(3)