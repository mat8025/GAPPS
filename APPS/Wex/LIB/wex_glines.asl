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

  int pwt_gl = -1;

  int ext_gl  = cGl(extwo);

  sGl(ext_gl,_GLTXY,DVEC,EXTV,_WCOLOR,GREEN_,_GLSYMLINE,TRI_,_GLEO);

  int cardio_gl  = cGl(extwo);

  sGl(cardio_gl,_GLTXY,DVEC,CARDIO,_WCOLOR,BLUE_,_GLSYMLINE,DIAMOND_,_GLEO);

  int strength_gl  = cGl(extwo);

  sGl(strength_gl,_GLTXY,DVEC,STRENGTH,_WCOLOR,RED_,_GLSYMLINE,STAR5_,_GLEO);

  sGl(ext_gl,_GLSYMSIZE,3,_GLSYMHUE,GREEN_);

  wt_gl = cGl(gwo);

  sGl(wt_gl,_GLTXY,DVEC,WTVEC,_WCOLOR,BLUE_, _GLSYMLINE,DIAMOND_,GLEO);

  if ((wt_gl == -1)  || (ext_gl == -1)) {

  exit();

  }

  gw_gl   = cGl(gwo);

  sGl(gw_gl,_GLTXY,DVEC,GVEC,_WCOLOR,GREEN_,GLEO);
// gw_gl   = cGl(gwo,_GLTXY,WDVEC,GVEC,_WCOLOR,RED_)

  bp_gl   = cGl(swo);

  sGl(bp_gl,_GLTXY,DVEC,BPVEC,_WCOLOR,RED_,_GLSYMBOL,TRI_,_GLNAME,"benchpress",_GLEO);

  if ( gw_gl == -1 || bp_gl == -1) {

  exitsi();

  }

  calb_gl = cGl(calwo);

  sGl(calb_gl,_GLTXY,DVEC,CALBURN,_WCOLOR,RED_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, RED_,GLEO);
// calc_gl = cGl(calwo,_GLTXY,DFVEC,CALCON,_WCOLOR,RED_,_GLSYMBOL,"triangle",_GLSYMHUE, BLUE_,GLEO);

  calc_gl = cGl(calwo);

  sGl(calc_gl, _GLTXY,DVEC,CALSCON,_WCOLOR,RED_,_GLSYMBOL,STAR_,_GLSYMHUE, RED_,GLEO);

  carb_gl = cGl(carbwo);

  sGl(carb_gl,_GLTXY,DVEC,CARBSCON,_WCOLOR,BLUE_,_GLSYMBOL,TRI_,_GLSYMHUE, BROWN_,GLEO);

  fibre_gl = cGl(carbwo);

  sGl(fibre_gl,_GLTXY,DVEC,FIBRCON,_WCOLOR,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, PINK_,GLEO);

  fat_gl = cGl(carbwo);

  sGl(fat_gl,_GLTXY,DVEC,FATCON,_WCOLOR,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_,GLEO);

  prot_gl = cGl(carbwo);

  sGl(prot_gl,_GLTXY,DVEC,PROTCON,_WCOLOR,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_,GLEO);
// ave_ext_gl  = cGl(extwo,_GLTXY,DVEC,AVE_EXTV,_WCOLOR,RED_,LINE_)

  se_gl   = cGl(extwo);

  sGl(se_gl,_GLTXY,DVEC,SEVEC,_WCOLOR,GREEN_,_GLSYMBOL,DIAMOND_,GLEO);

  int allgl[] = {wt_gl, gw_gl,bp_gl,ext_gl, se_gl, calb_gl, calc_gl, carb_gl, pwt_gl, cardio_gl, strength_gl,-1};

  int wedgl[] = {wt_gl, gw_gl, ext_gl, calb_gl, se_gl, calc_gl, carb_gl, fibre_gl,fat_gl,prot_gl, pwt_gl , cardio_gl, strength_gl,-1};

  int exgls[] = {ext_gl, cardio_gl,strength_gl,-1};
//<<[_DB]"%V$allgl \n"

  //sGl(allgl,@missing,0,@symbol,"diamond",5);

  Symsz= 5.0;

  sGl(ext_gl,_GLSYMBOL,TRI_,Symsz, _GLSYMFILL,_GLEO);

  sGl(cardio_gl,_GLSYMBOL,DIAMOND_,Symsz, _GLSYMFILL,_GLEO);

  sGl(strength_gl,_GLSYMBOL,STAR5_,Symsz, _GLSYMFILL,_GLEO);

  sGl(wt_gl,_GLSYMBOL,DIAMOND_,Symsz, _GLSYMFILL,_GLSYMHUE,BLUE_,GLEO);

  sGl(se_gl,_GLSYMBOL,DIAMOND_,Symsz_GLEO);

  sGl(calb_gl,_GLSYMBOL,DIAMOND_,Symsz,_GLSYMFILL,_GLSYMHUE,RED_);

  sGl(calc_gl,_GLSYMBOL,TRI_,Symsz,_GLSYMFILL,_GLSYMHUE,BLUE_,GLEO);
//  sGl(carb_gl,_GLSYMBOL,"circle",Symsz,_GLSYMFILL,_GLSYMHUE,BLUE_)

  sGl(carb_gl,_GLSYMBOL,ITRI_,Symsz,_GLSYMFILL,_GLSYMHUE,BROWN_,GLEO);

  sGl(fibre_gl,_GLSYMBOL,DIAMOND_,Symsz,_GLSYMFILL,_GLSYMHUE,PINK_,GLEO);

  sGl(fat_gl,_GLSYMBOL,CROSS_,Symsz,_GLSYMFILL,_GLSYMHUE,BLUE_,GLEO);

  sGl(prot_gl,_GLSYMBOL,TRI_,Symsz,_GLSYMFILL,_GLSYMHUE,RED_,GLEO);

  sGl(bp_gl,_GLSYMBOL,ITRI_,Symsz_GLEO);
//  CURSORS
 // TBC cursor opt?

  lc_gl   = cGl(gwo,_type,XY_,_color,RED_,_GLCURSOR,_GLEO);

  rc_gl   = cGl(gwo,_type,XY_,_color,WHITE_,_GLCURSOR,_GLEO);


;//==============\_(^-^)_/==================//;
