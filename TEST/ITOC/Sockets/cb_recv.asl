#! /usr/local/GASP/gasp/bin/asl 
#/* -*- c -*- */

spawn_it = 1;

Graphic = CheckGwm()

<<" %v $Graphic \n"

 if (Graphic) {
   spawn_it = 0;
 }

<<" %v $spawn_it \n"

     if (spawn_it) {
     X=spawngwm()
     spawn_it  = 0;
     }

SetDebug(0)
stype = "XX"

char CW[64] = { "linux reading" }

<<" %s $CW \n"

int last_sent = 0
int last_rec = 0
int ds
int dr
int sec = 5
int last_sec = 55
int dsec

kickoff =0

int gwo = -1
int hwo = -1

  //int max_gl
  //int min_gl
  //int hw_gl

int CBSZ = 100
float XVEC[CBSZ]
float MAXVEC[CBSZ]
float MINVEC[CBSZ]

float rx
float rX
float max 
float min


Graphic = CheckGwm()
  if (Graphic) 
{
  // setup windows

   xmin = 0
   xmax = 60
   ymin = 0
   ymax = 15

    aw= CreateGwindow(@title,"PLOT_TMM",@scales,xmin,ymin,xmax,ymax,@savescales,0))
    gwo=CreateGWOB(aw,"GRAPH",@resize_fr,0.15,0.7,0.99,0.95,@name,"LP",@color,"white")
    hwo=CreateGWOB(aw,"GRAPH",@resize_fr,0.15,0.3,0.99,0.65,@name,"XX",@color,"white")
    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

  setgwob(gwo,@clip,cx,cy,cX,cY)
  setgwob(gwo,@scales,0,-1,500,1, @save,@redraw,@drawoff,@pixmapon)
  setgwob(hwo,@clip,cx,cy,cX,cY)
  setgwob(hwo,@scales,0,-1,500,1, @save,@redraw,@drawoff,@pixmapon)

  max_gl = CreateGline(@wid,gwo,@type,"XY","xvec",XVEC,"yvec",MAXVEC,@color,"red",@mode,"blind")

  min_gl = CreateGline(@wid,gwo,@type,"XY","xvec",XVEC,"yvec",MINVEC,@color,"blue",@mode,"blind",@symbols,"star6")

  hw_gl = CreateGline(@wid,hwo,@type,"XY","xvec",XVEC,"yvec",MINVEC,@color,"blue",@mode,"blind",@symbols,"star5")

}


float orX = 120;
float orx = 0;


float tm
proc StrCli( cfd)
{
int kw =0
 // 
<<" Listening \n"


  while (1) {

    //<<" Listening from socket $kw \n"

   CR=GsockRecv(A,200)


//<<" recv $CR \n"

   sv = split(CR)

   ts = slower(sv[1])

   fw = sv[0]
   ip = sv[0]
//<<"$ts \n"
   fp = 8
   tm = sv[1]
   min = sv[2]
   max = sv[3]


   if (ts @= "t:") {

   ds = sv[7]
   ds = ds - last_sent

   dr = sv[9]
   dr = dr - last_rec


   last_sent = sv[7]
   last_rec = sv[9]

   day = sv[2]
   HR = sv[3]
   min = sv[4]
   sec = sv[5]

   dsec = abs(sec - last_sec)

//<<" %V $sec $last_sec $sec \n"
//<<"%v $dsec \n"

   if (dsec != 0) {
   dr /= dsec
   ds /= dsec
   }

   last_sec = sec

//   rv = sv[6:18:2]
   msf = sv[15]
   mpk = sv[17]

 <<"\r ${day} ${HR}:${min}:${sec}\t:${ip}: PKS $ds PKR $dr /s $msf $mpk  "
   fflush(1)
  }
  elif (fw @= "#Err") {


   skpe = sv[1]
   cswe = sv[5]
   terr = sv[3]
   msr = sv[7]



  }
  else {

    //<<"%s $CR \n"

  }

//<<"\r %s $CR "
    fflush(1)
//   <<" $ds $dr per sec \n"

      sleep(0.5)



      XVEC[kw] = tm;
      MAXVEC[kw] = max;
      MINVEC[kw] = min;


	if (gwo != -1) {

	  SetGwob({gwo,hwo},@clearpixmap)
	     //SetGwob(hwo,@clearpixmap)

           rX = tm
           rx = tm
           rX += 10.0
           rx -= 10.0

	     setgwob({gwo,hwo},@scales,rx,-2,rX,2,@savescales,0)
	     //setgwob(hwo,@scales,rx,-2,rX,2,@savescales,0)

	    //	    DrawGline(min_gl,@ltype,"line",@yi,kw)
	    //DrawGline(max_gl,@ltype,"line",@yi,kw)

	    DrawGline(max_gl,@ltype,"symbol",@yi,kw)
            DrawGline(min_gl,@ltype,"symbol",@yi,kw)
            DrawGline(hw_gl,@ltype,"symbol",@yi,kw)

	    //  <<"%V $tm $kw $max $rx $rX \n"

            text(gwo,"curr max $max  curr min $min",0.1,0.9,1)
	     SetGwob({gwo,hwo}, @showpixmap,@save)
	     //    SetGwob(hwo,@showpixmap,@save)

           kw++

           if (kw >= CBSZ) { 
            <<"BUFFER WRAP $kw \n"
            kw = 0
            setgwob(gwo,@scales,rx-3,-2,rX+4,2,@savescales,0)
            setgwob(hwo,@scales,rx-3,-2,rX+4,2,@savescales,0)
           }
	}
     }
}
// we want to create socket on our local machine
// on the port that the other side is sending

 port = 9871
 port2 = 9877
 port3 = 9879
 Ipa = "any"

 if (AnotherArg()) {
  Ipa = GetArgStr()

 }

 if (Ipa @= "") {
  Ipa = "any"
 }

// port = GetArgI(9871)



<<"%V  $Ipa $port \n"


      A = GsockCreate(Ipa, port, "UDP")

<<" created UDP type socket index $A $port\n"

//      GsockConnect(A)



      errnum = CheckError()

<<"%v $errnum \n"

<<" now reading from it \n"


      StrCli()


      STOP!

