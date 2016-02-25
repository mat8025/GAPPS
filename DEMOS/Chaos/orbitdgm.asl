#! /usr/local/GASP/bin/asl
#/* -*- c -*- */
SetPCW("writepic")
SetPCW("writeexe")
x0 = 0.1
last_x = x0

float Y[400+]
OpenDll("plot","math")

SetDebug(0)

//  GWM options

// option 1 ---- this script is launched via GWM --- xasl
// option 2 ---- this script launched from commandline  -- asks/ broadcast to find existing
//               xasl graphic server -- socket comms -- sets up SHM if possible
//                 xasl can be on network -- remote server
// option3 ----- launches its own xasl graphic server


//  X or OpenGL option --- 

  Graphic = CheckGwm()
<<" are we %v $Graphic \n" 
  if (! Graphic) {

     SpawnGWM()

  }




aw = CreateGwindow("resize",0.1,0.1,0.9,0.9,0, "title"," OrbitDiag")
SetGwindow(aw,"scales",-2,-2,0.25,2)
SetGwindow(aw,"clip",0.1,0.1,0.95,0.95)
SetGwindow(aw,"pixmapon","drawon","clipborder","hue","blue","save","store")
 
   col = 2

 for (c = -2.0 ; c <= 0.25 ; c += 0.00625) {

       x = 0.0
       last_x = -1

       k=0
       col++
   for (i = 0 ; i < 200 ; i++) {

      
     x = x * x + c

     if (i >=50) {

       // n = 75 * (2-x)  
//<<"$i $x  \n"

     if (fabs(last_x - x) > 0.0001) {
        if ((x <= 2) && (x >= -2)) {
//<<"$k $last_x $x $c \n"

// FIX k++

//        Y[k] = c
//         k++
        Y[k] = x
         k++ 
       }

     }
        last_x = x

   //   PlotPoint(aw,c,x,col++)

      if (col > 16) {
         col = 1
      }
    }
 }

   // PlotPoint(aw,Y[0:k])
     Vpry(aw,Y[0:k-1],c)

//<<"%V $c $k $Y[0:10] $n \r"

   SetGwindow(aw,"showpixmap","hue",col)
   
   gsync() 
 }



 
 

 STOP!