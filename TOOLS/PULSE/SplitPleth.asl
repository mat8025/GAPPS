#! /usr/local/GASP/bin/spi 
#/* -*- c -*- */
# 


include tools/PULSE/SeeLib

// shift args

// input a SatTrend 50 hz file 
int Red[]


lstem = ""

normalize = 1

x = sin(1.0)

float rs[]

t1 = 0
t2 = 10

proc DrawAxis(ww)
{

  // should be in mins

      rs = w_getRS(ww)
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      //<<" $rs \n"

      if ((Fabs(rX -rx)) > 60)
           minx = 5
      else
           minx = 1


            dy = (rY - ry )

            ix = minx

            iy = get_incr ( dy)

            int irx = rx/minx
            rx = irx * minx
      //<<" $rx a$ry $rX $rY \n"
            int iry = ry/iy
            ry = iry * iy

            W_SetRS(ww,rx,ry,rX,rY)            


            W_SetPen(ww,"black")

            
            ticks(ww,1,rx,rX,ix,0.02)
            ticks(ww,2,ry,rY,iy,0.02)

            axnum(ww,1,rx+ix,rX-ix,ix,-2.0,"3.0f")
		     // axnum title

            axnum(ww,2,ry+iy,rY,iy,0.0,"g")

//		     text(ww,"SPO2",rx,ry,0,0)

        w_clipborder(ww)
        gsync()
 }


proc Xaxis2time(ww)
{

      rs = w_getRS(ww)
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

// set rx and rX in mins

            rx /= (50*60)
            rX /= (50*60)

	if (Fabs(rX-rx) > 5) {
            int irx = rx/5
            rx = irx * 5
        }

       W_SetRS(ww,rx,ry,rX,rY)
	 gsync()
}



proc Xaxis2pts(ww)
{
      rs = w_getRS(ww)
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      rx *= (50*60)
      rX *= (50*60)

     W_SetRS(ww,rx,ry,rX,rY)
	 gsync()
}


proc  DrawLabels(ww)
{

  Text(ww,"Time (mins)", 0.1, -0.05,1)

  Text(ww,"PLETH ", -0.15, 0.2,1, 90)

}



int R[]

proc ReadPulseFile(fname)

{

  R = ReadAscii(A,"int",0,24)

  maxpts = Caz(R)

   dmn = Cab(R)

    // <<" ascii read  R array  %v $maxpts  $dmn\n"

    rsz = Caz(R)


    // <<" %v $rsz $dmn\n"
  // apply normalization ?
}


 fname = $2

 //<<" looking for $fname \n"

 A= ofr(fname)

 do_IR = 1
 do_Red = 1

 narg = argc()
 ac = 3
 wo2 =""


 int wrc = 1


 if ( ! ($3 @= "")) {
     smin = $3
     startf = 60 * 50 * smin

 }


 if ( !($4 @= "")) {
     emin = $4
     endf = 60 * 50 * emin

 }
     

  maxpts = ReadPulseFile(fname)


     // writeout section

     //<<" %V $startf $endf \n"


     NP = R[startf;endf][*]

  //<<" /////////////////////// \n"

    pmat(NP)

     //     <<" $NP \n"



  stop()
