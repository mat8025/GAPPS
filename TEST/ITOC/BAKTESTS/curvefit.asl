#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

//  

opendll("math","plot", "stat")
 SW = 3
 N= 20
 R= Fgen(N, 1, 0.5)


 <<"%v $(Cab(R)) \n"
 <<" $R \n"


 SR = Msmooth(R,1)

 <<" $SR \n"


// Redimn(R,1,N)

 <<"%v $(Cab(R)) \n"
 <<" $R \n"

 T= Fgen(N, 0, -0.3)

 <<" $(Cab(T)) \n"
 <<" $T \n"


 Z = R * T

 <<"%v $(Cab(Z)) \n"
 <<"%v $Z \n"

 N= 1000
 R= Fgen(N, 0, 0.05)


 YV = Sin(R)

<<"%v $YV[0:20] \n"

 // fit points via ??
// Redimn(R,10,1000)

 CYV = Cos(R)
 SYV = Sin(R)

//  which op


 RYV = CYV * SYV

 CYV->AddGrand(0.1)
 SYV->AddGrand(0.1)

 <<" $(Cab(CYV)) \n"

 MYV  = CYV * SYV

 <<" $(Cab(MYV)) \n"

<<"%v $CYV[0:20] \n"

 ACYV = Msmooth(CYV,SW)
 ASYV = Msmooth(SYV,SW)

 NYV = ACYV * ASYV


 AMYV = Msmooth(MYV,SW)




 <<"%v $(Cab(ACYV)) \n"
 <<"%v $(Cab(MYV)) \n"

//<<"%v $ACYV[0:20] \n"


  DA1 = RYV - AMYV

<<"%v $(Cab(DA1)) \n"

<<" $DA1[0:20] \n"

  DA2 = RYV - NYV

//  PLOT ORIG & FIT 


int aw[7+]

 <<" $(Cab(aw)) \n"
    aw = -1

  <<" $(Cab(aw)) \n"

 

  <<" $(Cab(aw)) \n"
<<" $aw \n"

Graphic = CheckGwm()

mm = minmax(R)
<<" %v $mm \n"
n = Caz(R)

     if (Graphic) {


      xmin = mm[0]
      xmax = mm[1]

      ymin = -2
      ymax = 2



      for (j = 0; j < 4; j++) { 

       aw[j]= CreateGwindow("title","PLOTCFIT","scales",xmin,ymin,xmax,ymax,"savescales",0)
      
       SetGwindow(aw[j],"drawon")
       SetGwindow(aw[j],"resize",0.1,0.41,0.9,0.99,j)
       SetGwindow(aw[j],"clip",0.1,0.1,0.8,0.9)

     }

       col = 2
     j = 0
//
// should we create line in all windows
// can we reassing line from one window

  orig=CreateGline("wid",aw[j++],"type","XY","xvec",R,"yvec",YV,"color", col++,"usescales",0)
  cfit=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",CYV,"color", col++,"usescales",0)
  cfit=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",MYV,"color", col++,"usescales",0)
  snv=CreateGline("wid",aw[j++],"type","XY","xvec",R,"yvec",SYV,"color", col++,"usescales",0)
  
  cave=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",ACYV,"color", "blue","usescales",0)
  cave=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",ASYV,"color", "green","usescales",0)
  cave=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",AMYV,"color", "red","usescales",0)
  cave=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",NYV,"color", "orange","usescales",0)
  cave=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",RYV,"color", "black","usescales",0)

  j++
  cave=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",DA1,"color", "red","usescales",0)
  cave=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",DA2,"color", "blue","usescales",0)



 // cave=CreateGline("wid",aw[j],"type","XY","xvec",R,"yvec",DA1,"color", "red","usescales",0)


   RedrawGlines(aw)

      while (1) {


        w_activate(aw[0])

        msg = MessageWait(Minfo)


         if ( ! (msg @= "NO_MSG")) {

<<"X ---> $msg \n"

      if ( (msg @= "REDRAW") || (msg @= "RESIZE") || (msg @= "SWITCHSCREEN") || (msg @= "PRINT")) {

             RedrawGlines(aw)

           }

         }

      }

}










STOP("DONE \n")
