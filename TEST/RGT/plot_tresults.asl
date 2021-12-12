/* 
 *  @script plot_tresults.asl  
 * 
 *  @comment show ASL test results 
 *  @release  
 *  @vers 1.3 Li Lithium [asl 6.3.66 C-Li-Dy] 
 *  @date 12/10/2021 22:38:16          
 *  @cdate  
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


#include "debug"
#include "hv"

  if (_dblevel >0) {

  debugON();

  }

  allowErrors(-1);

  void useage()
  {

  <<" cat Scores/score_0x-*202x | grep Modules | asl plot-tresults\n";

  <<"plot scores (when number of modules tested > 100) \n";

  }

  A = 0  ; // read on stdio;

  ncols = 2;

  int YCOL[>10];

  YCOL[0] = 0;

  int ac =2;

  int i = 0;

  i = 1;

  ncols = i;

  pars = i;
  //<<" $YCOL \n"

  ycol = 1;
 //A= ofr("junk")

  <<"%V $A\n";

  R = ReadRecord(A,@type,FLOAT_,@del,-1,@pickcond,">",6,100);

  sz = Caz(R);
////<<"%V$sz\n"
//<<"$R\n"

  dmn = Cab(R);

  nrows = dmn[0];
//<<"%V$nrows \n"
//<<"%V$sz $dmn\n"

  ncols = dmn[1];
//<<"%V$ncols \n"
//<<" $R[0][15] $R[0][17] \n"
//<<" $R[50][::] \n"
//for (i = 0; i <ncols ;i++) {
//<<"$i $R[1][i]  \n"
//}
/*
  for (i = 0; i <nrows ;i++) {
  <<"$i $R[i][6] $R[i][8] $R[i][14] \n"
  }
*/

///    Data results  in record  float type

  FV = R[::][14] ; // mods failed;

  Redimn(FV);

  sz = Caz(FV);
//<<"$FV\n"

  CV = R[::][16] ; //  mods crashed;

  Redimn(CV);

  sz = Caz(CV);
//<<"$CV\n"

  NM = R[::][6] ;   // mods tested;

  Redimn(NM);

  sz = Caz(NM);
 // NM *= 0.1

  NT = R[::][8] ;  //  num of tests;

  Redimn(NT);

  sz = Caz(NT);

  PCV = R[::][12]  ;  // overall % score;

  Redimn(PCV);

  sz = Caz(PCV);

  XV= vgen(FLOAT_,nrows,0,1);
//<<"$XV\n"
//<<"R:\n "
//<<"%6.2f$R\n"
#include "graphic"
#include "gevent"

  aslw = asl_w("PLOT_ASL_RESULTS");
// Window

  aw= cWi(@title,"TEST RESULTS",@scales,0,0,nrows,100,@savescales,0);

  sWi(aw,@resize,0.1,0.02,0.9,0.9,0);

  sWi(aw,@drawon);

  sWi(aw,@clip,0.1,0.12,0.8,0.9);
  // GraphWo

  maxFC = 110;

  grwo=cWo(aw,@GRAPH,@resize,0.1,0.1,0.95,0.95,@name,"PXY",@color,WHITE_);

  <<"%V $aw $grwo \n";

  sWo(grwo,@drawon,@pixmapon,@clip,0.1,0.1,0.9,0.9,@scales,0,0,nrows,maxFC,@savescales,0);

  sWo(grwo,@rhtscales,0,0,nrows,5000,@savescales,1);

  sWo(grwo,@clearclip);

  sWo(grwo,@clearpixmap,@save,@savepixmap);

  titleButtonsQRD(aw);
   ///   Gline

  sWi(aw,@redraw);

  fgl=cGl(grwo,@TXY,XV, FV, @color, BLUE_,@ltype,SYMBOLS_,TRI_);
//<<"%V $fgl \n"

  Symsz= 1.5;

  sGl(fgl,@symbol,TRI_,Symsz, @symfill,@symhue,BLUE_);

  dGl(fgl);
//ans=query("?")
//sGl(fgl,@draw)

  cgl=cGl(grwo,@TXY,XV, CV, @color, YELLOW_,@ltype,SYMBOLS_,DIAMOND_);

  sGl(cgl,@symbol,DIAMOND_,Symsz, @symfill,@symhue,ORANGE_);

  dGl(cgl);

  pcgl=cGl(grwo,@TXY,XV, PCV, @color, GREEN_,@ltype,SYMBOLS_,DIAMOND_);

  sGl(pcgl,@symbol,CIRCLE_,Symsz, @symfill,@symhue,GREEN_);

  dGl(pcgl);

  nmgl=cGl(grwo,@TXY,XV, NM, @color, BLACK_,@ltype,SYMBOLS_,DIAMOND_);

  sGl(nmgl,@symbol,DIAMOND_,Symsz, @symfill,@symhue,BLACK_,@usescales,1);

  dGl(nmgl);

  ntgl=cGl(grwo,@TXY,XV, NT, @color, BROWN_,@ltype,SYMBOLS_,);

  sGl(ntgl,@symbol,CIRCLE_,Symsz, @symfill,@symhue,PINK_,@usescales,1);

  titleVers();

  sWo(grwo,@showpixmap);
//ans=query("?")

  <<"%V $cgl \n";

  sWi(aw,@redraw);

  float yt = NT[1];

  float ym = NM[1];

  float yp = PCV[nrows-1];

  float yc = CV[1];

  while (1) {

  sleep(1);

  sWo(grwo,@clearpixmap);
     //sWo(grwo,@usescales,1)     

  sWo(grwo,@usescales,1,@axnum,  AXIS_LEFT_);

  sWo (grwo, @textr, "ntests", 1,yt, 2, 0, PINK_);

  dGl(nmgl);

  dGl(ntgl);

  sWo (grwo, @textr, "nmods", 1,ym, 2, 0, BLACK_);

  sWo(grwo,@usescales,0,@axnum,  AXIS_RIGHT_);

  sWo (grwo, @textr, "%% score", nrows-1,yp-5, 2, 0, GREEN_);

  sWo (grwo, @textr, "crash", 1,yc, 2, 0, BLACK_);

  dGl(pcgl);

  dGl(cgl);

  dGl(fgl);
   // AxText(grwo, 1, 0, maxFC, 1.0, BLUE_);

  sWo(grwo,@showpixmap);

  }

  exitgs();

//==============\_(^-^)_/==================//
