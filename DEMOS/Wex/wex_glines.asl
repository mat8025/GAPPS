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


<<[_DB]"\n%(10,, ,\n)$DVEC \n"
//<<[_DB]"\n%V$PWTVEC[0:20] \n"

   pwt_gl = -1
   pwt_gl  = cGl(@wid,gwo,@TXY,DVEC,PWTVEC,@color,GREEN_,@ltype,"line")

<<[_DB]"%V$pwt_gl \n"

   extwo = calwo;

   ext_gl  = cGl(extwo,@TXY,DVEC,EXTV,@color,BLUE_,@ltype,"symbols",TRI_)

//<<[_DB]"%V$ext_gl \n"

  sGl(ext_gl,@symsize,3,@symhue,GREEN_)

 //wt_gl   = cGl(@wid,gwo,@TXY,DVEC,WTVEC,@color,RED_,@ltype,"symbols","diamond")
  wt_gl    = cGl(gwo,@TXY,DVEC,WTVEC,@color,RED_,@ltype,"symbols","diamond")

//<<[_DB]"%V$wt_gl \n"

  sGl(wt_gl,@symbol,"triangle",1.2, @fill_symbol,0,@symsize,0.75,@symhue,RED_)

  if ((wt_gl == -1)  || (ext_gl == -1)) {
    exit()
  }

// wtpm_gl = cGl(gwo,@type_XY,DVEC,WTPMV,@color,BLUE_,@ltype,"symbols","diamond")

 gw_gl   = cGl(gwo,@TXY,WDVEC,GVEC,@color,BLUE_)

 bp_gl   = cGl(swo,@TXY,DVEC,BPVEC,@color,RED_,@ltype,"symbols",@name,"benchpress")

//<<[_DB]"%(10,, ,\n)$BPVEC\n"

// carb_gl = cGl(@wid,carbwo,@type_XY,DFVEC,CARBV,@color,"brown",@ltype,"symbols","diamond",@symhue,"brown")


//<<[_DB]"%V$carb_gl \n"

 //if (wtpm_gl == -1 || gw_gl == -1 || bp_gl == -1) {
if ( gw_gl == -1 || bp_gl == -1) {
   exit_si()
 }

 calb_gl = cGl(calwo,@TXY,DVEC,CALBURN,@color,BLUE_,@ltype,"symbols",DIAMOND_)

// calc_gl = cGl(calwo,@TXY,DFVEC,CALCON,@color,RED_,@ltype,"symbols","triangle",@symhue, BLUE_)

 calc_gl = cGl(calwo,@TXY,CCDV,CALSCON,@color,RED_,@ltype,"symbols",STAR_,@symhue, RED_)

 carb_gl = cGl(carbwo,@TXY,CCDV,CARBSCON,@color,RED_,@ltype,"symbols",STAR_,@symhue, RED_)

 ave_ext_gl  = cGl(extwo,@TXY,DVEC,AVE_EXTV,@color,RED_,@ltype,"line")

 se_gl   = cGl(extwo,@TXY,DVEC,SEVEC,@color,"green",@ltype,"symbols","diamond")

//  int allgl[] = {wtpm_gl,wt_gl,gw_gl,bp_gl,ext_gl,se_gl,calb_gl, calc_gl, pwt_gl}

  int allgl[] = {wt_gl,gw_gl,bp_gl,ext_gl,se_gl,calb_gl, calc_gl, pwt_gl}

  int wedgl[] = {wt_gl,gw_gl, ext_gl, calb_gl, se_gl, calc_gl, pwt_gl}

//<<[_DB]"%V$allgl \n"

  sGl(allgl,@missing,0,@symbol,"diamond",5)

  symsz= 5;
  
  sGl(ext_gl,@symbol,TRI_,symsz, @symfill,FILL_)

  sGl(wt_gl,@symbol,TRI_,symsz, @symfill,FILL_,@symhue,RED_)
  sGl(se_gl,@symbol,DIAMOND_,symsz)

  sGl(calb_gl,@symbol,DIAMOND_,symsz,@symfill,FILL_,@symhue,BLUE_)
  sGl(calc_gl,@symbol,DIAMOND_,symsz,@symfill,FILL_,@symhue,RED_)
  sGl(carb_gl,@symbol,TRI_,symsz,@symfill,FILL_,@symhue,LILAC_)
  sGl(bp_gl,@symbol,ITRI_,symsz,@missing,0)



//  CURSORS

  lc_gl   = cGl(gwo,@type,"XY",@color,"orange",@ltype,"cursor")

  rc_gl   = cGl(gwo,@type,"XY",@color,BLUE_,@ltype,"cursor")


//[EM]===========================================//