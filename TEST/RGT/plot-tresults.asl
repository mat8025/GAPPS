///
///
///



include "debug.asl"
include "hv.asl"



A = 0  // read on stdio

ncols = 2

int YCOL[>10]

 YCOL[0] = 0
 int ac =2
 int i = 0


i = 1
ncols = i
pars = i

  //<<" $YCOL \n"

ycol = 1


  // R = ReadRecord(A,@type,FLOAT,@NCOLS,ncols)
 R = ReadRecord(A,@type,FLOAT_,@pickcond,">",7,100)

     sz = Caz(R)

     dmn = Cab(R)

nrows = dmn[0]

<<"%V$nrows \n"

<<"%V$sz $dmn\n"

ncols = dmn[1]


<<" $R[0][15] $R[0][17] \n"

for (i = 0; i <nrows ;i++) {
<<" $R[i][7] $R[i][15] $R[i][17] \n"
}


///    Data results  in record  float type

  FV = R[::][15]

  Redimn(FV)

  sz = Caz(FV)


<<"$FV\n"

  CV = R[::][17]

  Redimn(CV)

  sz = Caz(CV)




<<"$CV\n"

 NM = R[::][7]

  Redimn(NM)

  sz = Caz(NM)

  NM *= 0.1



  PCV = R[::][13]

  Redimn(PCV)

  sz = Caz(PCV)


  XV= vgen(FLOAT_,nrows,0,1)

<<"$XV\n"

include "graphic"
include "gevent"


  aslw = asl_w("PLOT_ASL_RESULTS")

// Window
    aw= cWi(@title,"RES",@scales,0,0,nrows,100,@savescales,0)



    sWi(aw,@resize,0.1,0.02,0.9,0.9,0)
    sWi(aw,@drawon)
    sWi(aw,@clip,0.1,0.12,0.8,0.9)


  // GraphWo
   maxFC = 100

   grwo=cWo(aw,@GRAPH,@resize,0.1,0.1,0.95,0.95,@name,"PXY",@color,WHITE_)
  <<"%V $aw $grwo \n"
   sWo(grwo,@drawon,@pixmapon,@clip,0.1,0.1,0.9,0.9,@scales,0,0,nrows,maxFC,@savescales,0)

   sWo(grwo,@clearclip)

   sWo(grwo,@clearpixmap,@save,@savepixmap)

   titleButtonsQRD(aw)
   ///   Gline


   sWi(aw,@redraw)
 
  fgl=cGl(grwo,@TXY,XV, FV, @color, BLUE_,@ltype,SYMBOLS_,TRI_);

<<"%V $fgl \n"
  Symsz= 1.0;

  sGl(fgl,@symbol,TRI_,Symsz, @symfill,@symhue,BLUE_)

  dGl(fgl)
//ans=query("?")

//sGl(fgl,@draw)


  cgl=cGl(grwo,@TXY,XV, CV, @color, RED_,@ltype,SYMBOLS_,DIAMOND_);

  sGl(cgl,@symbol,DIAMOND_,Symsz, @symfill,@symhue,RED_)

  dGl(cgl)


  pcgl=cGl(grwo,@TXY,XV, PCV, @color, GREEN_,@ltype,SYMBOLS_,DIAMOND_);

  sGl(pcgl,@symbol,CIRCLE_,Symsz, @symfill,@symhue,GREEN_)

  dGl(pcgl)

 nmgl=cGl(grwo,@TXY,XV, NM, @color, BLACK_,@ltype,SYMBOLS_,DIAMOND_);

  sGl(nmgl,@symbol,SQUARE_,Symsz, @symfill,@symhue,BLACK_)

  dGl(nmgl)


  sWo(grwo,@showpixmap)
//ans=query("?")
<<"%V $cgl \n"
while (1) {

     sleep(1)
     sWo(grwo,@clearpixmap)     
     dGl(pcgl)
     dGl(cgl)
     dGl(fgl)
     dGl(nmgl)     
     sWo(grwo,@showpixmap)
       
}
 

exitgs()