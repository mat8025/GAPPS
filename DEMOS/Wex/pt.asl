// pt walk

opendll("plot")

gsday = julday("10/15/2012")



float TM[]
float MPH[]
float MPM[]
int jday[]

float DIST[]

int k = 0


A=ofr("pt.dat")

 // header
 C= readline(A)
 <<"$C "
 maxday = 0
 while (1) {

  C= readline(A)

  V= split(C,',')

  <<"--> $V "
  if (Caz(V) < 3) {
<<"incomplete record \n"
   break
  }

  




  wday = julday(V[0]) 
  wday -= gsday


  jday[k]   = wday 

  if (wday > maxday) {
    maxday = wday
  }

<<"$V[0] $wday $jday[k]\n"

 if (f_error(A) == EOF_ERROR) {
     break
  }

  W= split(V[1],':')

  TM[k] = atoi(W[0]) + (atoi(W[1]) /60.0 )
  DIST[k] = atof(V[2])
  MPM[k] = TM[k] / DIST[k]


  k++
}


 
 for (i= 0; i < k; i++) {

<<"$i $jday[i] $TM[i] $MPM[i]\n"

 }





 Graphic = CheckGwm()

 if (!Graphic) {
     X=spawngwm()
  }


      vp = CreateGwindow(@title,"PT",@resize,0.1,0.1,0.8,0.9,0)

      gwo=createGWOB(vp,@GRAPH,@name,"WTLB",@clipborder,"black",@resize,0.1,0.1,0.7,0.9,@redraw)

      setgwob(gwo,@scales,0,0,maxday+1,45,@drawon,@pixmapon,@save)       
      setgwob(gwo,@savepixmap)       
/////////////////////////////////////////////////////////
float ox = -1
float oy
float x
float y

      hue =RED
      sym_size = 1.2
      setgwob(gwo,@clearpixmap)

      for (i= 0; i < k ; i++) {
         x = jday[i]
         y = MPM[i]
      hue =RED
         if (x == ox) {
            hue = BLUE
         }

         setgwob(gwo,@symbol,x, y,"diamond",sym_size,hue,1);
         if (ox != -1) {
           plot(gwo,@line,ox,oy,x,y,BLUE)
         }
         ox = x
         oy = y
      }
      setgwob(gwo,@showpixmap)
      axnum(gwo,2)
      axnum(gwo,1)

// second set of scales  ?
      setgwob(gwo,@scales,0,0,maxday+1,4,@drawon,@pixmapon,@save)       

      hue = GREEN
      for (i= 0; i < k ; i++) {
         x = jday[i]
         y = DIST[i]
         hue = GREEN
         if (x == ox) {
            hue = RED
         }
         setgwob(gwo,@symbol,x, y,"triangle",sym_size,hue,1);
         if (i != 0) {
           plot(gwo,@line,ox,oy,x,y,GREEN)
         }
         ox = x
         oy = y
      }
      setgwob(gwo,@showpixmap)


setgwob(gwo,@clipborder,BLACK)