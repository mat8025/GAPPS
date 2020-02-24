///
///
///



include "gevent.asl"
include "debug"
include "hv.asl"
include "gss.asl"  // import the main subroutines



debugON()
setdebug(1,@~pline,@~trace,@keep)

filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOWALL_,"yyy");


 fname = "bpp.tsv"


    A=ofr(fname)
    R= readRecord(A)
    cf(A);

    sz = Caz(R);
    rows = sz;
    Rn = rows;  //global count of rows


      R[0][4] = "JULDAY"

      cols = Caz(R,0);
<<"%V$cols \n"    
      WV=  R[1][3]

<<"%V$WV \n"

  //   R[2::1][4] = itoa(julian(R[2::1][3]))

<<"$R[::]\n"




int DATE[]
j=0;

     for (i =1; i < sz; i++) {
       di = julian(R[i][3]))
       <<"$j $di\n"
      R[i][4] = itoa(di)
      if (di != 0) {
      
      DATE[j++] = di;

       <<"$j $di $DATE[j-1]\n"
      }
//  <<" $(itoa(julian(R[i][3]),10))\n"
//  <<" $(itoa(julian(R[i][3]),2))\n"  
//      <<" $(Julian(R[i][3])) \n"
     // R[i][4] = "$(Julian(R[i][3]))"
      }

<<"$j $(Caz(DATE))\n"

nsamples = j;

<<"$DATE\n"

    cols = Caz(R,0);

    Ncols = Caz(R,0);

    tags_col = cols;


<<"1 %V num of records $sz  $rows $cols  $Ncols $tags_col\n"

<<"$R[::]\n"

////////////// Compute Stats ///////////////////////////////////


   A=ofr("bpp.tsv")
  // MF= readRecord(A,@type,FLOAT_,@del,' ')
   MF= readRecord(A,@type,FLOAT_,@skiplines,2)
   cf(A);

    nb = Cab(MF)
    <<"$nb \n"
    nm = nb[0]
<<"%V$nm \n"
<<"rec 0 $MF[0] \n"

<<"\n$MF \n"

//   S=stats(MF)
//<<"$S\n"

   V=colSum(MF)
   V->redimn()
<<"Sum $V\n"

    AV = V/ nm

<<"Average $AV\n"

   V=colAve(MF)
   V->redimn()

   nb = Cab(V)
<<"%V$nb\n"
<<"Ave $V\n"

    AV=V;


   SV=colStats(MF);
   nb = Cab(SV)
   SV->info(1)

<<"%V $nb $(Caz(SV))\n"

<<"$SV\n"

NSV=cyclerow(SV,2)

Record RSV[>3]
RSV=   NSV
<<"%V$RSV\n"


RSV->info(1);
//NRSV=mcyclerow(RSV,1)

<<"%V$RSV\n"
<<"0 $SV[0][::] \n"

<<"0:3:1\n $SV[::][0:3:1] \n"




<<"1 $SV[1][::] \n"
<<"1:3:2\n $SV[1][1:3:2] \n"

<<"2 $SV[2][::] \n"

<<"00 $SV[0][0] \n"

<<"01 $SV[0][1] \n"

// R[Rn] = Split("$AV")
// Rn++;
<<"%V $Rn\n"
 R->info(1) 

<<"$R[::] \n"


  WV = Split("$SV[1][::]")

<<"$WV\n"


// put Stats in separate Record

   Record RS[>3];

  Rsn = 0;

  RS[Rsn] = WV
  Rsn++;


<<"$RS[::] \n"


 WV = Split("$SV[2][::]")
 RS[Rsn] = WV
 Rsn++;

 WV = Split("$SV[0][::]")
 RS[Rsn] = WV
 Rsn++;

// RS[Rsn] = WV
// Rsn++;


<<"%V$RS\n"





///
///   gss screen
///
include "graphic" ; // Connect with Graphic server
    vp = cWi(@title,"BPP:$fname")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@resize,0.1,0.02,0.7,0.98,@clip,0.1,0.2,0.9,0.95)

    sWi(vp,@clipborder,RED_,@redraw)


    vp2 = cWi(@title,"BPP:Plot")

    sWi(vp2,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp2,@resize,0.71,0.1,0.99,0.98,@clip,0.1,0.1,0.8,0.95)

    sWi(vp2,@clipborder,RED_,@redraw)


    titleButtonsQRD(vp);

///    GSS  modify functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVEWEX",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);

      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      arwo = cWo(vp,@BN,@name,"ADDWEX",@color,ORANGE_,@bhue,"lightblue");

      pgdwo = cWo(vp,@BN,@name,"PGDWN",@color,ORANGE_,@bhue,"pink");

      pguwo = cWo(vp,@BN,@name,"PGUP",@color,ORANGE_,@bhue,"golden");

      pgnwo = cWo(vp,@BV,@name,"PGN",@color,ORANGE_,@bhue,"cyan",@value,0,@style,"SVR");
      
      sWo(pgnwo,@bhue,WHITE_,@clipbhue,RED_,@FUNC,"inputValue",@callback,"PGN",@MESSAGE,1)

      int ssmods[] = { readwo,savewo,sortwo,swprwo,delrwo,arwo,pguwo,pgdwo,pgnwo }

      wovtile(ssmods,0.05,0.1,0.1,0.9,0.01);


      cellwo=cWo(vp,"SHEET",@name,"Bpp",@color,GREEN_,@resize,0.12,0.3,0.9,0.95)
      // does value remain or reset by menu?
      sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO")
      sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)

      statswo=cWo(vp,"SHEET",@name,"Stats",@color,GREEN_,@resize,0.12,0.01,0.9,0.29)
      sWo(statswo,@border,@drawon,@clipborder,@fonthue,BLACK_,@value,"BPSS")
      sWo(statswo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)


      sWi(vp,@clipborder,@RED_,@redraw)

      sWo(ssmods,@redraw)

       sWo(cellwo,@redraw);
       sWo(statswo,@redraw);


//=======================

   page_rows = Rn;
   sWo(cellwo,@setrowscols,Rn+1,cols+1);
   sWo(cellwo,@selectrowscols,0,page_rows,0,cols);

   

   sWo(ssmods,@redraw)

   for (i= 1; i< rows; i++) {
      R[i][tags_col] = "x";
   }

<<"$R\n"
   R->info(1);

   sWo(cellwo,@cellval,R);
   titleVers();
   sWo(cellwo,@redraw);

   for (i= 0; i< Rsn; i++) {
      RS[i][tags_col] = " ";
   }


   sWo(statswo,@cellval,RSV);
   <<"$RS \n"
   <<"%V $Rsn $cols\n"
   sWo(statswo,@setrowscols,Rsn+1,cols+1);
   sWo(statswo,@selectrowscols,0,Rsn-1,0,cols);


   sWo(statswo,@redraw);

   sWi(vp,@redraw)

//// Plot DYSS v julian



  cx = 0.1;
  cX = 0.9;
  cy = 0.2;
  cY = 0.95;

    // drawing area within window
    // drawing area object - wob -- needs script level class definition
    // so we can set parameters easily

    daname = "PLOT_SCREEN"

    syswo= cWo(vp2,@GRAPH,@name,"GLines",@color,"white")

    sWo(syswo,@resize,0.15,0.75,0.95,0.95,@clip,cx,cy,cX,cY,\
     @border,GREEN_,@clipborder,BLUE_,@redraw)

    dysyswo= cWo(vp2,@GRAPH,@resize,0.15,0.5,0.95,0.70,0,@name,"GLines",@color,"white")

    sWo(dysyswo,@clip,cx,cy,cX,cY,@border,BLACK_,@clipborder,BLUE_,@redraw)

    pwo= cWo(vp2,@GRAPH,@resize,0.15,0.1,0.95,0.30,@name,"GLines",@color,"white")

    sWo(pwo,@clip,cx,cy,cX,cY,@border,RED_,@clipborder,BLUE_,@redraw)



    SYSVEC = MF[::][0]
    SYSVEC->redimn()

    DYSYSVEC = MF[::][1]
    DYSYSVEC->redimn()

    PVEC = MF[::][2]
    PVEC->redimn()


    mfsz = Caz(MF)
    mfnd = Cab(MF)

<<"$mfsz mfnd\n"

    float XVEC[]

<<"$DATE\n"

   XVEC= DATE;

<<"%V $XVEC\n"

<<"%V $SYSVEC\n"

<<"%V $DYSYSVEC\n"

<<"%V $PVEC\n"

   XVEC->resize(nsamples)

   sx= XVEC[0];
   //sX= XVEC[nsamples-1];
   sX= XVEC[-1];
   sy = 100.0
   sY = 160.0

<<"$(Csz(XVEC)) $(Caz(DYSYSVEC)) \n"
<<"$(typeof(XVEC)) $(typeof(DYSYSVEC)) \n"

<<"%V $sx $sy $sX $sY \n"

   //sWo({gwo,syswo,pwo},@scales, sx, sy, sX, sY, @save,@redraw,@drawon,@pixmapon);

   sWo(syswo,@scales, sx, sy, sX, sY, @save,@redraw,@drawon,@pixmapon);

   sWo(dysyswo,@scales, sx, 50, sX, 100, @save,@redraw,@drawon,@pixmapon);

   sWo(pwo,@scales, sx, 40, sX, 100, @save,@redraw,@drawon,@pixmapon);

  // draw vecs should be float!
  
    sys_gl = cGl(syswo,@TXY,XVEC,SYSVEC,@color,RED_);

    dysys_gl = cGl(dysyswo,@TXY,XVEC,DYSYSVEC,@color,GREEN_);

    p_gl = cGl(pwo,@TXY,XVEC,PVEC,@color,BLUE_);


  sWo({syswo,dysyswo,pwo},@savepixmap);
  //sWo(pwo,@savepixmap);

    dGl(sys_gl);
    dGl(dysys_gl);
    dGl(p_gl);        

sWo({syswo,dysyswo,pwo},@redraw,@showpixmap);

    axlabel(syswo,1,"SYSTOLIC",0.5,1)
    axlabel(dysyswo,1,"DYSYSTOLIC",0.5,1)
    axlabel(pwo,1,"PULSE",0.5,1)

bps = MF[::][0]

//<<"$bps\n"
bps->redimn()
<<"$bps\n"

S=stats(bps)
<<"$S\n"


   lastPGN ();
   int mwr =0;
   int mwc =0;
   
while (1) {

        eventWait();

  if ((_ewoid > 0) && (_ename @= "PRESS")) {
             if (!(_ewoname @= "")) {
	       ind = findProc(_ewoname) ;
               if (ind  > 0) {
              <<"calling script procedure %V $ind $_ewoid $cellwo $_ename $_ewoname !\n"
               $_ewoname()
	    }
	    else {
<<"script procedure %V $_ewoname $ind  $_ewoid does not exist!\n"
            }
	  //   sWo(ssmods,@redraw);
        }
     }

 sWi(vp2,@clipborder,RED_,@redraw)
 dGl(sys_gl);
 dGl(dysys_gl);
 dGl(p_gl);

    axlabel(syswo,1,"SYSTOLIC",0.5,1)
    axlabel(dysyswo,1,"DYSYSTOLIC",0.5,1)
    axlabel(pwo,1,"PULSE",0.5,1)

     //break;
}