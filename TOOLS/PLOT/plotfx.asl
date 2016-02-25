// plot function of x
// root finder -- 

//  show the y= f(x)

//  gui input the range , sampling intervals

//  gui input the equation ?

// some examples  x^2

do_symbols = 0



 Graphic = CheckGwm()

 if (!Graphic) {
     Xw=spawngwm()
  }

      vp = CreateGwindow(@title,"PT",@resize,0.1,0.1,0.8,0.9,0)

      gwo=createGWOB(vp,@GRAPH,@name,"WTLB",@clipborder,"black",@resize,0.1,0.1,0.7,0.9,@redraw)


//////////////////////////////////////////////////////////////////////////////

proc fox ( x)
{

  y = x * x * x 

  return y

}

float X[]
float Y[]



int N

float start_x = -3
float end_x  = 3
float dx
float xv

 N = 80

  dx = (end_x - start_x) / (1.0 * N)

  xv = start_x

  for (i = 0 ; i <= N ; i++) {

    X[i] = xv

    Y[i] = fox(xv)

    xv += dx

<<"$i $X[i] $Y[i] \n"

  }
 

  mm = minmax(Y)


<<"$X \n"

<<"$mm \m"

      for (i= 0; i <= N ; i++) {

         px = X[i]
         py = Y[i]

        <<"$i $X[i] $Y[i] $px $py \n"

    }


<<"$X \n"


//  WINDOW


<<"$mm \n"

      setgwob(gwo,@scales,start_x,mm[0]-10,end_x,mm[1]+10,@drawon,@pixmapon,@save)       
      setgwob(gwo,@savepixmap)       

//  WOB

     



float ox = 0
float oy



      hue =RED
      sym_size = 1.2
      setgwob(gwo,@clearpixmap)

//<<"$X \n"

      for (i= 0; i <= N ; i++) {

         px = X[i]
         py = Y[i]

//<<"$i $X[i] $Y[i] \n"

         if (do_symbols) {       
            setgwob(gwo,@symbol,px, py,"diamond",sym_size,hue,1);
         }

         if (i != 0) {
           plot(gwo,@line,ox,oy,px,py,BLUE)
//<<"$i $ox $oy $px $py \n"
         }

         ox = px
         oy = py

     


      setgwob(gwo,@showpixmap)
      axnum(gwo,2)
      axnum(gwo,1)
      setgwob(gwo,@clipborder,BLACK)

      si_pause(5)





// ZOOM
