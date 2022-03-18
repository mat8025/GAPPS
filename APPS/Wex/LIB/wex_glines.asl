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

   int pwt_gl = -1
//   pwt_gl  = cGl(gwo,@TXY,DVEC,PWTVEC,@color,GREEN_,@ltype,"line")



   int ext_gl  = cGl(extwo);
   sGl(ext_gl,_GLTXY,DVEC,EXTV,_WCOLOR,GREEN_,_GLSYMLINE,TRI_);

   int cardio_gl  = cGl(extwo);
   sGl(cardio_gl,_GLTXY,DVEC,CARDIO,_WCOLOR,BLUE_,_GLSYMLINE,DIAMOND_);

   int strength_gl  = cGl(extwo);
   sGl(strength_gl,_GLTXY,DVEC,STRENGTH,_WCOLOR,RED_,_GLSYMLINE,STAR5_);
   


  sGl(ext_gl,_GLSYMSIZE,3,_GLSYMHUE,GREEN_);

  wt_gl = cGl(gwo);

  sGl(wt_gl,_GLTXY,DVEC,WTVEC,_WCOLOR,BLUE_, _GLSYMLINE,DIAMOND_);




  if ((wt_gl == -1)  || (ext_gl == -1)) {
    exit();
  }



 gw_gl   = cGl(gwo);
 _GLTXY,DVEC,GVEC,@color,GREEN_)


// gw_gl   = cGl(gwo,_GLTXY,WDVEC,GVEC,@color,RED_)

 bp_gl   = cGl(swo);
 _GLTXY,DVEC,BPVEC,@color,RED_,SYMBOLS_,@name,"benchpress")



if ( gw_gl == -1 || bp_gl == -1) {
   exit_si()
 }


 calb_gl = cGl(calwo);
 _GLTXY,DVEC,CALBURN,@color,RED_,SYMBOLS_,DIAMOND_,@symhue, RED_)

// calc_gl = cGl(calwo,_GLTXY,DFVEC,CALCON,@color,RED_,SYMBOLS_,"triangle",@symhue, BLUE_)

 calc_gl = cGl(calwo);
 _GLTXY,DVEC,CALSCON,@color,RED_,SYMBOLS_,STAR_,@symhue, RED_)

 carb_gl = cGl(carbwo);
 _GLTXY,DVEC,CARBSCON,@color,BLUE_,SYMBOLS_,TRI_,@symhue, BROWN_)

 fibre_gl = cGl(carbwo);
 _GLTXY,DVEC,FIBRCON,@color,BLUE_,SYMBOLS_,DIAMOND_,@symhue, PINK_)

 fat_gl = cGl(carbwo);
 _GLTXY,DVEC,FATCON,@color,BLUE_,SYMBOLS_,CROSS_,@symhue, PINK_)

 prot_gl = cGl(carbwo);
 _GLTXY,DVEC,PROTCON,@color,BLUE_,SYMBOLS_,CROSS_,@symhue, PINK_)

// ave_ext_gl  = cGl(extwo,_GLTXY,DVEC,AVE_EXTV,@color,RED_,LINE_)

 se_gl   = cGl(extwo);
 _GLTXY,DVEC,SEVEC,@color,GREEN_,SYMBOLS_,DIAMOND_)


  int allgl[] = {wt_gl, gw_gl,bp_gl,ext_gl, se_gl, calb_gl, calc_gl, carb_gl, pwt_gl, cardio_gl, strength_gl,-1};

  int wedgl[] = {wt_gl, gw_gl, ext_gl, calb_gl, se_gl, calc_gl, carb_gl, fibre_gl,fat_gl,prot_gl, pwt_gl , cardio_gl, strength_gl,1};

  int exgls[] = {ext_gl, cardio_gl,strength_gl,-1};

//<<[_DB]"%V$allgl \n"

  sGl(allgl,@missing,0,@symbol,"diamond",5)

  Symsz= 5.0;
  
  sGl(ext_gl,_symbol,TRI_,Symsz, _symfill,)
  sGl(cardio_gl,_symbol,DIAMOND_,Symsz, _symfill)
  sGl(strength_gl,_symbol,STAR5_,Symsz, _symfill)  
  sGl(wt_gl,_symbol,DIAMOND_,Symsz, _symfill,_symhue,BLUE_)
 

  sGl(se_gl,_symbol,DIAMOND_,Symsz)

  sGl(calb_gl,_symbol,DIAMOND_,Symsz,_symfill,_symhue,RED_)
  sGl(calc_gl,_symbol,TRI_,Symsz,_symfill,_symhue,BLUE_)
//  sGl(carb_gl,_symbol,"circle",Symsz,_symfill,_symhue,BLUE_)
  sGl(carb_gl,_symbol,ITRI_,Symsz,_symfill,_symhue,BROWN_)
  
  sGl(fibre_gl,_symbol,DIAMOND_,Symsz,_symfill,_symhue,PINK_)

  sGl(fat_gl,_symbol,CROSS_,Symsz,_symfill,_symhue,BLUE_)

  sGl(prot_gl,_symbol,TRI_,Symsz,_symfill,_symhue,RED_)
  
  sGl(bp_gl,_symbol,ITRI_,Symsz,_missing,0)



//  CURSORS
 // TBC cursor opt?
  lc_gl   = cGl(gwo,_type,XY_,_color,RED_,_GLCURSOR)

  rc_gl   = cGl(gwo,_type,XY_,_color,WHITE_,_GLCURSOR)


//===========================================//