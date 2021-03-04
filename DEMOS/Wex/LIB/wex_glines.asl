//%*********************************************** 
//*  @script wex_glines.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sat Dec 29 09:04:43 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%


///////////////////// GLINES & SYMBOLS ///////////////////////////////


//<<[_DB]"\n%(10,, ,\n)$DVEC \n"

   pwt_gl = -1
   pwt_gl  = cGl(@wid,gwo,@TXY,DVEC,PWTVEC,@color,GREEN_,@ltype,"line")



   ext_gl  = cGl(extwo,@TXY,DVEC,EXTV,@color,GREEN_,@ltype,SYMBOLS_,TRI_);
   cardio_gl  = cGl(extwo,@TXY,DVEC,CARDIO,@color,BLUE_,@ltype,SYMBOLS_,DIAMOND_);
   strength_gl  = cGl(extwo,@TXY,DVEC,STRENGTH,@color,RED_,@ltype,SYMBOLS_,STAR5_);
   


  sGl(ext_gl,@symsize,3,@symhue,GREEN_)

  wt_gl    = cGl(gwo,@TXY,DVEC,WTVEC,@color,RED_,@ltype,SYMBOLS_,DIAMOND_)


  sGl(wt_gl,@symbol,TRI_,1.2, @fill_symbol,1,@symsize,0.75,@symhue,RED_)

  if ((wt_gl == -1)  || (ext_gl == -1)) {
    exit()
  }



 gw_gl   = cGl(gwo,@TXY,WDVEC,GVEC,@color,BLUE_)
// gw_gl   = cGl(gwo,@TXY,WDVEC,GVEC,@color,RED_)

 bp_gl   = cGl(swo,@TXY,DVEC,BPVEC,@color,RED_,@ltype,SYMBOLS_,@name,"benchpress")



if ( gw_gl == -1 || bp_gl == -1) {
   exit_si()
 }

 calb_gl = cGl(calwo,@TXY,DVEC,CALBURN,@color,RED_,@ltype,SYMBOLS_,DIAMOND_,@symhue, RED_)

// calc_gl = cGl(calwo,@TXY,DFVEC,CALCON,@color,RED_,@ltype,SYMBOLS_,"triangle",@symhue, BLUE_)

 calc_gl = cGl(calwo,@TXY,CCDV,CALSCON,@color,RED_,@ltype,SYMBOLS_,STAR_,@symhue, RED_)

 carb_gl = cGl(carbwo,@TXY,CCDV,CARBSCON,@color,BLUE_,@ltype,SYMBOLS_,TRI_,@symhue, BROWN_)

 ave_ext_gl  = cGl(extwo,@TXY,DVEC,AVE_EXTV,@color,RED_,@ltype,LINE_)

 se_gl   = cGl(extwo,@TXY,DVEC,SEVEC,@color,GREEN_,@ltype,SYMBOLS_,DIAMOND_)


  int allgl[] = {wt_gl, gw_gl,bp_gl,ext_gl, se_gl, calb_gl, calc_gl, carb_gl, pwt_gl, cardio_gl, strength_gl}

  int wedgl[] = {wt_gl, gw_gl, ext_gl, calb_gl, se_gl, calc_gl, carb_gl, pwt_gl , cardio_gl, strength_gl}

  int exgls[] = {ext_gl, cardio_gl,strength_gl}

//<<[_DB]"%V$allgl \n"

  sGl(allgl,@missing,0,@symbol,"diamond",5)

  Symsz= 5.0;
  
  sGl(ext_gl,@symbol,TRI_,Symsz, @symfill,)
  sGl(cardio_gl,@symbol,DIAMOND_,Symsz, @symfill)
  sGl(strength_gl,@symbol,STAR5_,Symsz, @symfill)  

  sGl(wt_gl,@symbol,TRI_,Symsz, @symfill,@symhue,RED_)

  sGl(se_gl,@symbol,DIAMOND_,Symsz)

  sGl(calb_gl,@symbol,DIAMOND_,Symsz,@symfill,@symhue,RED_)
  sGl(calc_gl,@symbol,TRI_,Symsz,@symfill,@symhue,BLUE_)
//  sGl(carb_gl,@symbol,"circle",Symsz,@symfill,@symhue,BLUE_)
  sGl(carb_gl,@symbol,ITRI_,Symsz,@symfill,@symhue,BROWN_)
  sGl(bp_gl,@symbol,ITRI_,Symsz,@missing,0)



//  CURSORS
 // TBC cursor opt?
  lc_gl   = cGl(gwo,@type,"XY",@color,"orange",@ltype,"cursor")

  rc_gl   = cGl(gwo,@type,"XY",@color,BLUE_,@ltype,"cursor")


//===========================================//