/* 
 *  @script wex_glines.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.3 Li 6.3.78 C-Li-Pt 
 *  @date 01/31/2022 09:06:20          
 *  @cdate Sat Dec 29 09:04:43 2018 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                                                                                              


///////////////////// GLINES & SYMBOLS ///////////////////////////////


//<<[_DB]"\n%(10,, ,\n)$DVEC \n"

   pwt_gl = -1
//   pwt_gl  = cGl(gwo,@TXY,DVEC,PWTVEC,@color,GREEN_,@ltype,"line")



   ext_gl  = cGl(extwo,@TXY,DVEC,EXTV,@color,GREEN_,@ltype,SYMBOLS_,TRI_);
   cardio_gl  = cGl(extwo,@TXY,DVEC,CARDIO,@color,BLUE_,@ltype,SYMBOLS_,DIAMOND_);
   strength_gl  = cGl(extwo,@TXY,DVEC,STRENGTH,@color,RED_,@ltype,SYMBOLS_,STAR5_);
   


  sGl(ext_gl,@symsize,3,@symhue,GREEN_)

  wt_gl = cGl(gwo,@TXY,DVEC,WTVEC,@color,BLUE_,@ltype,SYMBOLS_,DIAMOND_)




  if ((wt_gl == -1)  || (ext_gl == -1)) {
    exit()
  }



 gw_gl   = cGl(gwo,@TXY,DVEC,GVEC,@color,GREEN_)


// gw_gl   = cGl(gwo,@TXY,WDVEC,GVEC,@color,RED_)

 bp_gl   = cGl(swo,@TXY,DVEC,BPVEC,@color,RED_,@ltype,SYMBOLS_,@name,"benchpress")



if ( gw_gl == -1 || bp_gl == -1) {
   exit_si()
 }

 calb_gl = cGl(calwo,@TXY,DVEC,CALBURN,@color,RED_,@ltype,SYMBOLS_,DIAMOND_,@symhue, RED_)

// calc_gl = cGl(calwo,@TXY,DFVEC,CALCON,@color,RED_,@ltype,SYMBOLS_,"triangle",@symhue, BLUE_)

 calc_gl = cGl(calwo,@TXY,DVEC,CALSCON,@color,RED_,@ltype,SYMBOLS_,STAR_,@symhue, RED_)

 carb_gl = cGl(carbwo,@TXY,DVEC,CARBSCON,@color,BLUE_,@ltype,SYMBOLS_,TRI_,@symhue, BROWN_)

 fibre_gl = cGl(carbwo,@TXY,DVEC,FIBRCON,@color,BLUE_,@ltype,SYMBOLS_,DIAMOND_,@symhue, PINK_)

 fat_gl = cGl(carbwo,@TXY,DVEC,FATCON,@color,BLUE_,@ltype,SYMBOLS_,CROSS_,@symhue, PINK_)

 prot_gl = cGl(carbwo,@TXY,DVEC,PROTCON,@color,BLUE_,@ltype,SYMBOLS_,CROSS_,@symhue, PINK_)

// ave_ext_gl  = cGl(extwo,@TXY,DVEC,AVE_EXTV,@color,RED_,@ltype,LINE_)

 se_gl   = cGl(extwo,@TXY,DVEC,SEVEC,@color,GREEN_,@ltype,SYMBOLS_,DIAMOND_)


  int allgl[] = {wt_gl, gw_gl,bp_gl,ext_gl, se_gl, calb_gl, calc_gl, carb_gl, pwt_gl, cardio_gl, strength_gl}

  int wedgl[] = {wt_gl, gw_gl, ext_gl, calb_gl, se_gl, calc_gl, carb_gl, fibre_gl,fat_gl,prot_gl, pwt_gl , cardio_gl, strength_gl}

  int exgls[] = {ext_gl, cardio_gl,strength_gl}

//<<[_DB]"%V$allgl \n"

  sGl(allgl,@missing,0,@symbol,"diamond",5)

  Symsz= 5.0;
  
  sGl(ext_gl,@symbol,TRI_,Symsz, @symfill,)
  sGl(cardio_gl,@symbol,DIAMOND_,Symsz, @symfill)
  sGl(strength_gl,@symbol,STAR5_,Symsz, @symfill)  
  sGl(wt_gl,@symbol,DIAMOND_,Symsz, @symfill,@symhue,BLUE_)
 

  sGl(se_gl,@symbol,DIAMOND_,Symsz)

  sGl(calb_gl,@symbol,DIAMOND_,Symsz,@symfill,@symhue,RED_)
  sGl(calc_gl,@symbol,TRI_,Symsz,@symfill,@symhue,BLUE_)
//  sGl(carb_gl,@symbol,"circle",Symsz,@symfill,@symhue,BLUE_)
  sGl(carb_gl,@symbol,ITRI_,Symsz,@symfill,@symhue,BROWN_)
  
  sGl(fibre_gl,@symbol,DIAMOND_,Symsz,@symfill,@symhue,PINK_)

  sGl(fat_gl,@symbol,CROSS_,Symsz,@symfill,@symhue,BLUE_)

  sGl(prot_gl,@symbol,TRI_,Symsz,@symfill,@symhue,RED_)
  
  sGl(bp_gl,@symbol,ITRI_,Symsz,@missing,0)



//  CURSORS
 // TBC cursor opt?
  lc_gl   = cGl(gwo,@type,XY_,@color,RED_,@ltype,"cursor")

  rc_gl   = cGl(gwo,@type,XY_,@color,WHITE_,@ltype,CURSOR_)


//===========================================//