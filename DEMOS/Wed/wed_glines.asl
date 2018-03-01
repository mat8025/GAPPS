

///////////////////// GLINES & SYMBOLS ///////////////////////////////


DBPR"\n%(10,, ,\n)$DVEC \n"
//DBPR"\n%V$PWTVEC[0:20] \n"

   pwt_gl = -1
   pwt_gl  = cGl(@wid,gwo,@TXY,DVEC,PWTVEC,@color,GREEN_,@ltype,"line")

DBPR"%V$pwt_gl \n"

   extwo = calwo;

   ext_gl  = cGl(extwo,@TXY,DVEC,EXTV,@color,BLUE_,@ltype,"symbols",TRI_)

//DBPR"%V$ext_gl \n"

  sGl(ext_gl,@symsize,3,@symhue,GREEN_)

 //wt_gl   = cGl(@wid,gwo,@TXY,DVEC,WTVEC,@color,RED_,@ltype,"symbols","diamond")
  wt_gl    = cGl(gwo,@TXY,DVEC,WTVEC,@color,RED_,@ltype,"symbols","diamond")

//DBPR"%V$wt_gl \n"

  sGl(wt_gl,@symbol,"triangle",1.2, @fill_symbol,0,@symsize,0.75,@symhue,RED_)

  if ((wt_gl == -1)  || (ext_gl == -1)) {
    exit()
  }

// wtpm_gl = cGl(gwo,@type_XY,DVEC,WTPMV,@color,BLUE_,@ltype,"symbols","diamond")

 gw_gl   = cGl(gwo,@TXY,WDVEC,GVEC,@color,BLUE_)

 bp_gl   = cGl(swo,@TXY,DVEC,BPVEC,@color,RED_,@ltype,"symbols",@name,"benchpress")

//DBPR"%(10,, ,\n)$BPVEC\n"

// carb_gl = cGl(@wid,carbwo,@type_XY,DFVEC,CARBV,@color,"brown",@ltype,"symbols","diamond",@symhue,"brown")


//DBPR"%V$carb_gl \n"

 //if (wtpm_gl == -1 || gw_gl == -1 || bp_gl == -1) {
if ( gw_gl == -1 || bp_gl == -1) {
   exit_si()
 }

 calb_gl = cGl(calwo,@TXY,DVEC,CALBURN,@color,BLUE_,@ltype,"symbols",DIAMOND_)

 calc_gl = cGl(calwo,@TXY,DFVEC,CALCON,@color,RED_,@ltype,"symbols","triangle",@symhue, BLUE_)

 ave_ext_gl  = cGl(extwo,@TXY,DVEC,AVE_EXTV,@color,RED_,@ltype,"line")

 se_gl   = cGl(extwo,@TXY,DVEC,SEVEC,@color,"green",@ltype,"symbols","diamond")

//  int allgl[] = {wtpm_gl,wt_gl,gw_gl,bp_gl,ext_gl,se_gl,calb_gl, calc_gl, pwt_gl}

  int allgl[] = {wt_gl,gw_gl,bp_gl,ext_gl,se_gl,calb_gl, calc_gl, pwt_gl}

  int wedgl[] = {wt_gl,gw_gl, ext_gl, calb_gl, se_gl, calc_gl, pwt_gl}

//DBPR"%V$allgl \n"

  sGl(allgl,@missing,0,@symbol,"diamond",5)

  symsz= 5;
  
  sGl(ext_gl,@symbol,TRI_,symsz, @symfill,FILL_)

  sGl(wt_gl,@symbol,TRI_,symsz, @symfill,FILL_,@symhue,RED_)
  sGl(se_gl,@symbol,DIAMOND_,symsz)

  sGl(calb_gl,@symbol,DIAMOND_,symsz,@symfill,FILL_,@symhue,BLUE_)
  sGl(calc_gl,@symbol,TRI_,@symsize,symsz,@symhue,BLUE_)
  sGl(bp_gl,@symbol,ITRI_,symsz,@missing,0)



//  CURSORS

  lc_gl   = cGl(gwo,@type,"XY",@color,"orange",@ltype,"cursor")

 rc_gl   = cGl(gwo,@type,"XY",@color,BLUE_,@ltype,"cursor")


