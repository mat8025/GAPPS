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

  pwt_gl = -1;

COUT(pwt_gl)

  ext_gl  = cGl(extwo);

  sGl(ext_gl,_GLTXY,&DVEC,&EXTV,_WCOLOR,GREEN_,_GLSYMLINE,TRI_,_GLEO);

COUT(ext_gl)

  int cardio_gl  = cGl(extwo);

  sGl(cardio_gl,_GLTXY,&DVEC,&CARDIO,_WCOLOR,BLUE_,_GLSYMLINE,DIAMOND_,_GLEO);

COUT(cardio_gl)

  int strength_gl  = cGl(extwo);

  sGl(strength_gl,_GLTXY,&DVEC,&STRENGTH,_WCOLOR,RED_,_GLSYMLINE,STAR5_,_GLEO);

COUT(strength_gl)

 // sGl(ext_gl,_GLSYMSIZE,3,_GLSYMHUE,GREEN_);

  wt_gl = cGl(gwo);

  sGl(wt_gl,_GLTXY,&DVEC,&WTVEC,_WCOLOR,BLUE_, _GLSYMLINE,DIAMOND_,_GLEO);

COUT(wt_gl)

  if ((wt_gl == -1)  || (ext_gl == -1)) {

  exit(-1);

  }

  gw_gl   = cGl(gwo);

  sGl(gw_gl,_GLTXY,&DVEC,&GVEC,_WCOLOR,GREEN_,_GLEO);
// gw_gl   = cGl(gwo,_GLTXY,WDVEC,GVEC,_WCOLOR,RED_)

COUT(gw_gl)

  bp_gl   = cGl(swo);

  sGl(bp_gl,_GLTXY,&DVEC,&BPVEC,_WCOLOR,RED_,_GLSYMBOL,TRI_,_GLNAME,"benchpress",_GLEO);

  if ( gw_gl == -1 || bp_gl == -1) {

  exit_si();

  }

  calb_gl = cGl(calwo);

  sGl(calb_gl,_GLTXY,&DVEC,&CALBURN,_WCOLOR,RED_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, RED_,_GLEO);
// calc_gl = cGl(calwo,_GLTXY,DFVEC,CALCON,_WCOLOR,RED_,_GLSYMBOL,"triangle",_GLSYMHUE, BLUE_,GLEO);

COUT(calb_gl)

  calc_gl = cGl(calwo);

  sGl(calc_gl, _GLTXY,&DVEC,&CALSCON,_WCOLOR,RED_,_GLSYMBOL,STAR_,_GLSYMHUE, RED_,_GLEO);

  carb_gl = cGl(carbwo);

  sGl(carb_gl,_GLTXY,&DVEC,&CARBSCON,_WCOLOR,BLUE_,_GLSYMBOL,TRI_,_GLSYMHUE, BROWN_,_GLEO);

COUT(carb_gl)

  fibre_gl = cGl(carbwo);

  sGl(fibre_gl,_GLTXY,&DVEC,&FIBRCON,_WCOLOR,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, PINK_,_GLEO);

  fat_gl = cGl(carbwo);

  sGl(fat_gl,_GLTXY,&DVEC,&FATCON,_WCOLOR,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_,_GLEO);

  prot_gl = cGl(carbwo);

  sGl(prot_gl,_GLTXY,&DVEC,&PROTCON,_WCOLOR,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_,_GLEO);
// ave_ext_gl  = cGl(extwo,_GLTXY,DVEC,AVE_EXTV,_WCOLOR,RED_,LINE_)

  se_gl   = cGl(extwo);

  sGl(se_gl,_GLTXY,&DVEC,&SEVEC,_WCOLOR,GREEN_,_GLSYMBOL,DIAMOND_,_GLEO);

COUT(se_gl)

  int allgl[] = {wt_gl, gw_gl,bp_gl,ext_gl, se_gl, calb_gl, calc_gl, carb_gl, pwt_gl, cardio_gl, strength_gl,-1};

  int wedgl[] = {wt_gl, gw_gl, ext_gl, calb_gl, se_gl, calc_gl, carb_gl, fibre_gl,fat_gl,prot_gl, pwt_gl , cardio_gl, strength_gl,-1};

  int exgls[] = {ext_gl, cardio_gl,strength_gl,-1};
//<<[_DB]"%V$allgl \n"

  //sGl(allgl,@missing,0,@symbol,"diamond",5);

  cout<<"set symbols \n";

  sGl(ext_gl,_GLSYMBOL,TRI_, _GLSYMFILL,_GLEO);

COUT(ext_gl);

  sGl(cardio_gl,_GLSYMBOL,DIAMOND_, _GLSYMFILL,_GLEO);

COUT(cardio_gl);

  sGl(strength_gl,_GLSYMBOL, STAR5_, _GLSYMFILL,_GLEO);

  sGl(wt_gl,_GLSYMBOL,DIAMOND_,_GLSYMSIZE, Symsz, _GLSYMFILL,_GLSYMHUE,BLUE_,_GLEO);

COUT(strength_gl);

 sGl(wt_gl,_GLSYMBOL,DIAMOND_, _GLSYMFILL,_GLSYMHUE,BLUE_,_GLEO);


COUT(wt_gl);

  sGl(se_gl,_GLSYMBOL,DIAMOND_,_GLEO);

  sGl(calb_gl,_GLSYMBOL,DIAMOND_,_GLSYMFILL,_GLSYMHUE,RED_,_GLEO);

  sGl(calc_gl,_GLSYMBOL,TRI_,_GLSYMFILL,_GLSYMHUE,BLUE_,_GLEO);
//  sGl(carb_gl,_GLSYMBOL,"circle",_GLSYMFILL,_GLSYMHUE,BLUE_)



  sGl(carb_gl,_GLSYMBOL,ITRI_,_GLSYMFILL,_GLSYMHUE,BROWN_,_GLEO);

COUT(carb_gl);

  sGl(fibre_gl,_GLSYMBOL,DIAMOND_,_GLSYMFILL,_GLSYMHUE,PINK_,_GLEO);

  sGl(fat_gl,_GLSYMBOL,CROSS_,_GLSYMFILL,_GLSYMHUE,BLUE_,_GLEO);

  sGl(prot_gl,_GLSYMBOL,TRI_,_GLSYMFILL,_GLSYMHUE,RED_,_GLEO);

COUT(prot_gl);

  sGl(bp_gl,_GLSYMBOL,ITRI_,_GLEO);
//  CURSORS
 // TBC cursor opt?

  lc_gl   = cGl(gwo);

  //sGl(lc_gl,_GLTXY,_WCOLOR,RED_,_GLCURSOR,_GLEO);

  rc_gl   = cGl(gwo);
  //sGl(rc_gl,_GLTXY,_WCOLOR,WHITE_,_GLCURSOR,_GLEO);


cout<<"glines setup\n";
;//==============\_(^-^)_/==================//;
