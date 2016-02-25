#! /usr/local/GASP/gasp/bin/asl 
#/* -*- c -*- */

spawn_it = 1;

Graphic = CheckGwm()

<<" %v $Graphic \n"

 if (Graphic) {
   spawn_it = 0;
 }

# use arg to set

//   spawn_it = 0;
<<" %v $spawn_it \n"

     if (spawn_it) {
     X=spawngwm()
     spawn_it  = 0;
     }

SetDebug(1)
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
int mpk

kickoff =0

int CBUFSZ = 500

float XVEC[CBUFSZ]
float MAXVEC[CBUFSZ]
float MINVEC[CBUFSZ]
float PKSVEC[CBUFSZ]
float PKRVEC[CBUFSZ]
float MISSPKTV[CBUFSZ]

  float rx = 0;
  float rX = 800;

  float orX = rX;

  float orx = 0;

<<"%V $rx $rX $orx $orX \n"


if (CheckGwm()) 
  {
  // setup windows
   xmin = 0
   xmax = 60
   ymin = 0
   ymax = 15

     //////////////// WINDOW /////////////////////
    aw= CreateGwindow(@title,"PLOT_TMM",@scales,xmin,ymin,xmax,ymax,@savescales,0))

     //////////////// WINDOW OBJECTS /////////////////////
    gwo=CreateGWOB(aw,"GRAPH",@resize_fr,0.15,0.7,0.99,0.95,@name,"PTIMES",@color,"white")
    pkwo=CreateGWOB(aw,"GRAPH",@resize_fr,0.15,0.4,0.99,0.65,@name,"PKSR",@color,"white")
    mpkwo=CreateGWOB(aw,"GRAPH",@resize_fr,0.15,0.1,0.99,0.35,@name,"MPK",@color,"white")


    cx = 0.1
    cX = 0.9
    cy = 0.2
    cY = 0.95

  setgwob(gwo,@clip,cx,cy,cX,cY)
  setgwob(gwo,@scales,rx,0,rX,2000000, @save,@redraw,@drawoff,@pixmapon)

  setgwob(pkwo,@clip,cx,cy,cX,cY)
  setgwob(pkwo,@scales,rx,-1,rX,5000, @save,@redraw,@drawoff,@pixmapon)

  setgwob(mpkwo,@clip,cx,cy,cX,cY)
  setgwob(mpkwo,@scales,rx,0,rX,100, @save,@redraw,@drawoff,@pixmapon)

    //////////////////////////////  GLINES //////////////////////////////////////////

      max_gl = CreateGline(@wid,gwo,@type,"XY","xvec",XVEC,"yvec",MAXVEC,@color,"red",@mode,"blind")

     min_gl = CreateGline(@wid,gwo,@type,"XY","xvec",XVEC,"yvec",MINVEC,@color,"blue",@mode,"blind")

      pks_gl = CreateGline(@wid,pkwo,@type,"XY","xvec",XVEC,"yvec",PKSVEC,@color,"blue",@mode,"blind")

      pkr_gl = CreateGline(@wid,pkwo,@type,"XY","xvec",XVEC,"yvec",PKRVEC,@color,"red",@mode,"blind")

    mpt_gl = CreateGline(@wid,mpkwo,@type,"XY","xvec",XVEC,"yvec",MISSPKTV,@color,"green",@mode,"blind")

  <<" MADE WIN $max_gl $min_gl $mpt_gl\n"
}



ip = ""
fw = ""
mins = ""
HR = ""
day = ""






proc StrCli( cfd)
{

tm = 0.1;
dtx = 0.9;

kw =0
tw =0
 // 
<<" Listening \n"
       first = 1


  while (1) {

<<" Listening $kw \n"

   kw++
   sleep(0.5)
   if (kw > 3)
   break
  }

    Stat = "c"
    <<" Stat $Stat \n"
   n=GsockSendTo(B,Stat)



  kw = 0

  while (1) {
    //<<" Listening from socket $kw \n"

    if ( (kw % 2)  ==0) {
    Stat = "u"
    //    <<" Stat $Stat \n"
   n=GsockSendTo(B,Stat)
    }
    else {

    Stat = "t"
    //<<" Stat $Stat \n"
    n=GsockSendTo(B,Stat)
    }

    #{

    Stat = "a"
    <<" Stat $Stat \n"
   n=GsockSendTo(B,Stat)
    #}

   CR=GsockRecv(A,200)


<<"$kw recv  %s $CR \n"

   sv = split(CR)
   sz = Caz(sv)


   if (sz > 2) {
   

     //     <<"IN $sz $sv \n"

   ts = slower(sv[1])

   fw = sv[0]
   ip = sv[0]

     //   <<"$ts $sv[1]\n"

   fp = 8
   //   tm = sv[1]
   min = sv[2]
   max = sv[3]
   

   if (ip @= "#TOVR:") {

     mt = Atof(sv[5])
     st = Atof(sv[3])

     <<"$kw $tm t--> $ip $sz   :: $st $mt  $ds $dr $mpk \n"
     //<<"SKPT %V $st $mt \n"
   }

   else if (sz == 20) {

     //<<"%v $sv \n"
   ds = sv[7]
   ds = ds - last_sent

   dr = sv[9]
   dr = dr - last_rec


   last_sent = sv[7]
   last_rec = sv[9]

   day = sv[2]
   HR = sv[3]
   mins = sv[4]
   sec = sv[5]
   dt = (sec - last_sec)

   //   dsec = abs(sec - last_sec)
   dsec = abs(dt)

   <<"$kw %V $sec $last_sec $dt \n"
   //<<"%v $dsec \n"

   if (dsec != 0) {
   dr /= dsec
   ds /= dsec
   }

   last_sec = sec

//   rv = sv[6:18:2]
   msf = sv[15]
   mpk = sv[17]

   <<"\r ${day} ${HR}:${mins}:${sec}\t:${ip}: PKS $ds PKR $dr /s $msf $mpk $st \n"

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

   // fix tm

      tm += 5
   //<<"%i $tm  \n"

	if (gwo != -1) {



	  //         SetGwob({mpkwo,gwo,pkwo},@clearpixmap)      

          SetGwob(pkwo,@clearpixmap)      
	  SetGwob(gwo,@clearpixmap)      
          SetGwob(mpkwo,@clearpixmap)      

           rX = tm
           rx = tm
           rX += 10.0
           rx -= 500

    if (rX > orX) {
    <<" UPDATE X SCALES \n"
          orX = rX 
          orx = rx 
          setgwob(gwo,@scales,orx,0,orX,2000000,@savescales,0)
          setgwob(pkwo,@scales,orx,-1,orX,5000,@savescales,0)
          setgwob(mpkwo,@scales,orx,0,orX,100,@savescales,0)
    }




      if (kw >= CBUFSZ) { 

  <<"%V $kw $tm   $min $max \n"
  <<"%V $tm $rx $rX \n"

         kw = 0
 #{
 <<" $XVEC[0:10] \n"
 <<" $MAXVEC[0:10] \n"
 <<" $MINVEC[0:10] \n"

 <<" $XVEC[CBUFSZ-20:CBUFSZ-1] \n"
 <<" $MAXVEC[CBUFSZ-20:CBUFSZ-1] \n"
 <<" $MINVEC[CBUFSZ-20:CBUFSZ-1] \n"
 #}
       first = 0
	   }


      XVEC[kw] = tm;
      MAXVEC[kw] = mt;
      MINVEC[kw] = st;
      PKSVEC[kw] = ds;
      PKRVEC[kw] = dr;
	  MISSPKTV[kw] = (mpk * 2);


#{
	  if ( (kw %10) == 0) {
<<" $MISSPKTV[0:kw] \n"

          }
#}


        DrawGline(min_gl,@ltype,"line",@yi,kw)
	DrawGline(max_gl,@ltype,"line",@yi,kw)
	DrawGline(pks_gl,@ltype,"line",@yi,kw)
	DrawGline(pkr_gl,@ltype,"line",@yi,kw)
	DrawGline(mpt_gl,@ltype,"line",@yi,kw)


	  text(mpkwo,"$kw ${day} ${HR}:${mins}:${sec}  MISSED $mpk",0.1,0.9,1)

	  text(pkwo," PKR $dr  PKS $ds  TS $last_sent TR $last_rec ",0.1,0.9,1)

	  text(gwo," Max $mt  min $st ",0.1,0.9,1)


	  // Check use of parameter array {mpkwo,pkwo,gwo}
	  //          SetGwob({mpkwo,gwo,pkwo},@showpixmap,@save)

          SetGwob(mpkwo,@showpixmap,@save)
	           SetGwob(gwo,@showpixmap,@save)
          SetGwob(pkwo,@showpixmap,@save)

          kw++
        }

     }

//<<"\r %s $CR "
    fflush(1)
//   <<" $ds $dr per sec \n"

      sleep(1)
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




C=ofr("/usr/people/user/softbench_sbc_ip")

SBCIpa = rword(C)
<<" %v $SBCIpa \n"
cfile(C)



      B = GsockCreate(SBCIpa, port, "UDP")

<<" created UDP type send socket index $B $port\n"

       GsockConnect(B)

      errnum = CheckError()

<<"%v $errnum \n"

<<" now reading from it \n"


      StrCli()


      STOP!

