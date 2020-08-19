
N = 100
<<"N $N \n"



  R =Rand(N,N/2,1,0)

<<"R $R \n"





///////////////////////  



//F =  vgen(FLOAT_,N,1,1)
F1 =  vgen(FLOAT_,N/2,1,1)

F =  F1 @+ F1

<<"$F \n"

G =  vgen(FLOAT_,N,0,-0.3)




/////////////////////////////  SCREEN --- WOB ////////////////////////////////////////////////////////////
OpenDll("plot")
OpenDll("stat")

Graphic = CheckGwm()

<<"%v$Graphic \n"

     if (!Graphic) {
        X=spawngwm()
     }



    vp = CreateGwindow(@title,"XYPLOT",@resize,0.05,0.01,0.99,0.95,0)

    SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"white")

    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

    gwo=CreateGWOB(vp,@GRAPH,@resize,0.15,0.3,0.99,0.95,@name,"LP",@color,"white")

    setgwob(gwo,@clip,cx,cy,cX,cY)

    setgwob(gwo,@scales,-1, -1 , N/2 + 4, N+2, @save,@redraw,@drawon,@pixmapon)


////////////////////////////// GLINE ////////////////////////////////////////




  xn_gl = CreateGline(@wid,gwo,@type,"XY",@xvec,F,@yvec,G,@color,"red")

  setGline(xn_gl,@ltype,"symbol",2,@symhue,"blue")

  SetGwob(gwo,@hue,"green",@refresh)

  SetGwob(gwo,@showpixmap)

  SetGwob(gwo,@clearpixmap,@clipborder)

  DrawGline(xn_gl)

  SetGwob(gwo,@showpixmap)


<<"%6.2f$F\n"

<<"%6.2f$G\n"

// G[3] = 60
// G[18] = 20

 C= RPC(F,G)

<<"%6.2f$C\n"

G = Urand(N,N/2,1,0)
<<"%6.2f$G\n"

//i_read(":>")

 n =0

 sym_n = 1

//i_read()

////////////// event struct
include "event"

Event E


 lwo=createGWOB(vp,"BV",@name,"SYMBOL",@VALUE,"1",@color,"red",@resize,0.1,0.9,0.2,0.95)
 setgwob(lwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"blue", @STYLE,"SVL", @redraw)
 setgwob(lwo,@fhue,"teal",@clipbhue,"violet",@VALUE,sym_n)

 r2wo=createGWOB(vp,"BV",@name,"R^2",@VALUE,"1",@color,"red",@resize,0.1,0.8,0.2,0.85)
 setgwob(r2wo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"blue", @STYLE,"SVR", @redraw)
 setgwob(r2wo,@fhue,"cyan",@clipbhue,"violet",@VALUE,0)

 hue = 1
 ssize = 3.0

 rn = 6

 while (1) {
 

   E->readMsg()

   if (! (E->keyw @= "NO_MSG")) {
      <<"$E->woname $E->keyc\n"

    if (E->woname @= "SYMBOL" ) {
         sym_n++   

      if (sym_n > 10) {
          sym_n = 1
      }
         if (sym_n == 8)
             sym_n = 9

         setgwob(lwo,@fhue,"cyan",@clipbhue,"violet",@VALUE,"$sym_n",@redraw)
    }

     if (E->etype @= "KEYPRESS") {

       switch (E->keyc) {

       case 'R':
       {
/{
             sym_n++;
             if (sym_n > 15) {
               sym_n = 1
             }
             setgwob(lwo,@fhue,"teal",@clipbhue,"violet",@VALUE,"$sym_n",@redraw)
/}
             rn++
             if (rn > N/2) {
                 rn = N/2
             }             
       }
       break;

       case 'T':
       {
          hue++

          if (hue > 10) {
             hue = 1
          }

         setGline(xn_gl,@symhue,hue)       
         rn--
         if (rn < 1) {
             rn = 1
         }
       }
       break;

       case 'S':
       {
          ssize += 0.05
          setGline(xn_gl,@symsize,ssize)       
        
       }
       break;
      }       
   }
  }

  n++

//  G = Grand(N,0)


 // R =Rand(N,N/2,1,0)

//<<"R $R\n" 

  G = Rand(N,N/2,1,0)

//  G = R * 1.0

  for (i= 0; i < N/2 ; i++) {
   G[i] = Rand(1,rn) + (i+1) + (grand(1,0)  * rn)
  }

  for (i= 0; i < N/2 ; i++) {
   G[i+N/2] = Rand(1,rn) + i  + (grand(1,0)  * rn)
  }

   if (G[i] < 0)    G[i] = 0
   if (G[i] > N/2)  G[i] = N/2

//<<"%6.2f$F\n"
//<<"%6.2f$G\n"

  C= RPC(F,G)



<<"$n  %6.2f$C\n"

 setgwob(r2wo,@fhue,"cyan",@clipbhue,"violet",@VALUE,C[1],@redraw)

  SetGwob(gwo,@clearpixmap,@clipborder)

  //SetGwob(gwo,@clearpixmap)
   LF = Lfit(F,G)

   slp = LF[1] 
   lc = LF[0]

   x0 = 0
   y0 = lc
   x1 =  N
   y1 = lc + slp * N
   plotline(gwo,x0,y0,x1,y1)

  //sym_n++
  
  setGline(xn_gl,@ltype,"symbol",sym_n)

  DrawGline(xn_gl)

  SetGwob(gwo,@showpixmap,@clipborder)

   if (C[1] == 1.0) 
      break

   si_pause(0.1) 

 }


<<"%6.2f$F\n"
<<"%6.2f$G\n"

<<"$n\n"
