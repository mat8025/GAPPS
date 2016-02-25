#/* -*- c -*- */
# "$Id: pic.g,v 1.1 2001/09/27 03:35:53 mark Exp mark $"

set_debug(0)

    //OpenDll("imagelab")

 if (! CheckGwm() ) {
     X=spawngwm()
  }

aslw = asl_w ("PXC_") 


proc showface(pn)
{

  PlotPixRect(n,CH)
  w_showpixmap(n)
  gsync()

   if (pn > 1) {

  NCH = ReflectCol(NCH)
  PlotPixRect(n,NCH)
  w_showpixmap(n)
    }

  if( pn > 2 ) {
  NCH = ReflectCol(CH)
  PlotPixRect(n,NCH)
  w_showpixmap(n)
    }
  if (pn > 3) {
  NCH = ReflectCol(CH)
  PlotPixRect(n,NCH)
  w_showpixmap(n)
    }
  if (pn >=4) {
  NCH = Transpose(CH)
  PlotPixRect(n,NCH)
  w_showpixmap(n)
  gsync()
    }
}


proc colorface()
{
  SetRGB(10,RGB)
  PlotPixRect(n,NCH)
  w_showpixmap(n)
  }


proc showpic(uchar PIC[])
{
 si = 0
 y = 512
 for (k = 0 ; k < 511 ; k++) {
#  se = si + 511
#  CH = (PX[si;se] +127) * gs + 16
# <<" $CH\n"
  v_pc(n,1,y,2,PIC[si],512)
  si += 512

  gsync()
 w_showpixmap(n)
 y -= 1
#  <<" $k $x $y $hue\n"
 }

}

fp =  ofr("../SIGNALS/woman.pic")

npx = 512*512
uchar PX[npx+]

// read in file

 nc=v_read(fp,PX,(512*512),"uchar")

<<" $nc \n"
si = 0
rowsz  = 128

for (i = 0 ; i < 2 ; i++) {
 se = si + rowsz -1
<<" $si $se \n"
 PS = PX[si:se]
 si += rowsz
   // <<" $(typeof(PS)) $PS \n"
 ssz = Caz(PS)
 <<" $(typeof(PS)) $ssz  \n"

}

//<<" $(typeof(PS))\n $PS \n"

uchar CH[10+]
// <<"$(typeof(CH)) CH $CH\n"

#name_debug("EXP",0)

CH = PS

// <<"$(typeof(CH)) CH $CH\n"

// create a window
// then a Wob -- with a clip area that has 512,512 pixels
// set pixmap on

   n= W_Create(0,0)
   W_title(n,"Pic") 
   W_Map(n)
   ws=GetScreen()


<<" CurrentScreen is $ws \n"

   w_resize(n,10,10,522,522, ws,1)

   w_setrs(n,0,0,511,511)
   w_setclip(n,1,1,1,1,1,1)

   w_redraw(n)
   w_move(n,1,1,1)
   w_clearclip(n)
   w_clear(n)

 
 w_drawOFF(n)
 w_pixmapdrawON(n)
 w_store(n)
 w_redraw(n)

  w_clear(n)

     gsync()

      <<" Done Window Create!! "

     sleep(2)


 //   RS=w_GetRS(n)
 //<<" $RS \n"

 y = 512
 x = 100

int hue = 0

  plotpoint(n,x,y,hue)

int j = 0


int PH[10+]
si = 0
# color map index - 16 start of default 64 grey scale

ngl = 256
cmi = 64

set_gsmap(ngl,cmi)

si_pause(3)

gs = (ngl*1.0)/256

char SCH[10+]
#SCH = (((PX  * gs) -64) * -1) + 16

CH = (((PX  * gs) - ngl) * -1) + cmi

#SCH *= -1
#SCH += 16
#CH = SCH

     NCH =CH[0:32]
//<<" $NCH \n"


float RGB[256][3]

  uchar CGR[512][512]
  uchar Gr[256]

  Gr=Igen(256,0,1)

  Gr = Gr @+ Reflect(Mdimn(Gr,1,256))

  for (i = 0 ; i < 512 ; i++)
  CGR[i][*] = Gr

#  showpic(CH)

  dc = 1.0/256
  A= Fgen(256,0,dc)
    RGB[::][0] = A
    RGB[::][1] = A * 0.5
    RGB[::][2] = A * 0.25


  Redimn(CH,512,512)
  PlotPixRect(n,CH)
  w_showpixmap(n)
  gsync()

  si_pause(0.2)

  showface(4)

  SetRGB(10,RGB) 

  showface(1)

  RGB[*][2] = A
  RGB[*][1] = A * 0.5
  RGB[*][0] = A * 0.25

  SetRGB(10,RGB) 


  showface(1)

  RGB[*][0] = Sin(A)
  RGB[*][1] = Cos(A)
  RGB[*][2] = Sin(A) * Cos(A)

  SetRGB(10,RGB) 
  showface(0)


  RGB[*][0] = 0
  RGB[*][1] = 0
  RGB[*][2] = 0
  
  Pi = 4.0*Atan(1.0)

     //  dPi = Pi/128.0
  dPi = Pi/256.0

  B= Fgen(256,0,dPi)

     //  B = Sin(B)
     //  B = Cos(B)

 pic = 2.0

 for ( i = 0 ; i < 2 ; i++ ) {

  j = (i % 3)
  RGB[*][j] =  Fabs(Sin(B))
  j = (i + 1) % 3
  RGB[*][j] =  Fabs(Sin(B + Pi/pic))
  j = (i + 2) % 3
  RGB[*][j] =  Fabs(Sin(B - Pi/pic))

  SetRGB(10,RGB) 

  PlotPixRect(n,CGR)
  w_showpixmap(n)
    //  gsync()
#{
  j = (i % 3)
  RGB[*][j] =  Fabs(Cos(B))
  j = (i + 1) % 3
  RGB[*][j] =  Fabs(Cos(B + Pi/pic))
  j = (i + 2) % 3
  RGB[*][j] =  Fabs(Cos(B - Pi/pic))

  SetRGB(10,RGB) 

  PlotPixRect(n,CGR)
  w_showpixmap(n)
  gsync()
    //  ttyin("return to proceed:")
#}

    pic += 0.005
    //    CGR[0;20][*] += 10
    //    CGR[0;511;2][*] = CGR[0;511;2][*] + (Grand(512*256) * i)

    }


  RGB[*][0] = 0
  RGB[*][1] = 0
  RGB[*][2] = 0

  RGB[0;127][1] = B
  RGB[64;191][2] = B
  RGB[128;255][0] = B

  SetRGB(10,RGB) 
  showface(0)

  PlotPixRect(n,CGR)
  w_showpixmap(n)
  gsync()

     //  ttyin("return to proceed:")

  RGB[*][0] = 0
  RGB[*][1] = 0
  RGB[*][2] = 0

  RGB[0:127][2] = B
  RGB[64:191][1] = B
  RGB[128:255][0] = B

  SetRGB(10,RGB) 
  showface()

  PlotPixRect(n,CGR)
  w_showpixmap(n)
  si_pause(1)
 
     //  ttyin("return to exit:")
 gsync()
     //  stop()

     for (i = 0 ; i < 10 ; i++) {
  k = i % 3
  RGB[*][k] = Urand(256)
  colorface()
    }

     // restore CMAP
   SetColorMap()


  NCH = Imop(CH,"sobel")
  PlotPixRect(n,NCH)
  w_showpixmap(n)

  NCH = Imop(CH,"laplace")
  PlotPixRect(n,NCH)
  w_showpixmap(n)

  NCH = Imop(CH,"point")
  PlotPixRect(n,NCH)
  w_showpixmap(n)

  NCH = Imop(CH,"bilaplace")
  PlotPixRect(n,NCH)
  w_showpixmap(n)

int T[10]
           	T[0] = 1;
		T[1] = 2;
		T[2] = 1;
		T[3] = 0;
		T[4] = 0;		
		T[5] = 0;		
		T[6] = -1;
		T[7] = -2;
		T[8] = -1;

int T2[10]




  NCH = Imop(CH,T)
  PlotPixRect(n,NCH)
  gsync()
  w_showpixmap(n)

  
  NCH = Imop(CH,"sobel")
  PlotPixRect(n,NCH)

           	T[0] = 1;
		T[1] = 0;
		T[2] = -1;
		T[3] = 1;
		T[4] = 0;		
		T[5] = -1;		
		T[6] = 1;
		T[7] = 0;
		T[8] = -1;
    T2= T
  NCH = Imop(CH,T)
  PlotPixRect(n,NCH)

           	T[0] = 2;
		T[1] = 0;
		T[2] = 0;
		T[3] = 0;
		T[4] = 2;		
		T[5] = 0
		T[6] = 0
		T[7] = 0;
		T[8] = 2;
  NCH = Imop(CH,T)
  PlotPixRect(n,NCH)
  w_showpixmap(n)


 a=Rand(5,6)
<<" $a \n"

 RandSeed()
int T3[10]

  T3 = Rand(9,3) - 2
  <<" $T3\n"

  T3 = Rand(9,3) - 2
  <<" $T3\n"

  <<" $T2\n"

k = 0


while (1) {
 T6 = Rand(9,3) - 2
  <<" $k T6: $T6\n"
k++
if (k > 10) break
}

 k = 0
 while (1) {
  NCH = Imop(CH,T2) 
  w_clearpixmap(n)
  PlotPixRect(n,NCH)
  w_showpixmap(n)
//  gsync()
  Shuffle(T2,9,10)
  <<" $k T2: $T2\n"
  T3 = Rand(9,3) - 2
  <<" $k T3: $T3\n"
  NCH = Imop(CH,T3) 
// fatal error to use nonexistent array?
  w_clearpixmap(n)
  PlotPixRect(n,NCH)
  w_showpixmap(n)
  si_pause(0.2)
  T6 = Rand(9,5) - 3
  <<" $k T6: $T6\n"
  NCH = Imop(CH,T6) 
  w_clearpixmap(n)
  PlotPixRect(n,NCH)
  w_showpixmap(n)
  k++
}


// plot points

 STOP!
