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



 COUT(pwt_gl)

  ext_gl  = cGl(extwo);

  sGl(ext_gl,_GLTXY,&DVEC,&EXTV,_GLHUE,GREEN_,_GLSYMLINE,TRI_,_GLEO);

  COUT(ext_gl)

  int cardio_gl  = cGl(extwo);

  sGl(cardio_gl,_GLTXY,&DVEC,&CARDIO,_GLHUE,BLUE_,_GLSYMLINE,DIAMOND_,_GLEO);

COUT(cardio_gl)

  int strength_gl  = cGl(extwo);

  sGl(strength_gl,_GLTXY,&DVEC,&STRENGTH,_GLHUE,RED_,_GLSYMLINE,STAR5_,_GLEO);

COUT(strength_gl)

 // sGl(ext_gl,_GLSYMSIZE,3,_GLSYMHUE,GREEN_);

  wt_gl = cGl(wtwo);

 sGl(wt_gl,_GLTXY,&DVEC,&WTVEC,_GLHUE, RED_, _GLSYMLINE, TRI_,_GLEO);
  //sGl(wt_gl,_GLTXY,&DVEC,&WTVEC,_GLHUE,BLUE_,_GLEO);

COUT(wt_gl)


  if ((wt_gl == -1)  || (ext_gl == -1)) {

  exit(-1);

  }

//  gw_gl   = cGl(wtwo);

//  sGl(gw_gl,_GLTXY,&DVEC,&GVEC,_GLHUE,GREEN_,_GLEO);
// gw_gl   = cGl(wtwo,_GLTXY,WDVEC,GVEC,_GLHUE,RED_)
gw_gl = -1;
COUT(gw_gl)

  bp_gl   = cGl(swo);

  sGl(bp_gl,_GLTXY,&DVEC,&BPVEC,_GLHUE,RED_,_GLSYMBOL,TRI_,_GLNAME,"benchpress",_GLEO);

  if (  bp_gl == -1) {

  exit_si();

  }

  calb_gl = cGl(calwo);

  sGl(calb_gl,_GLTXY,&DVEC,&CALBURN,_GLHUE,RED_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, RED_,_GLEO);
// calc_gl = cGl(calwo,_GLTXY,DFVEC,CALCON,_GLHUE,RED_,_GLSYMBOL,"triangle",_GLSYMHUE, BLUE_,GLEO);

COUT(calb_gl)

  calc_gl = cGl(calwo);

  sGl(calc_gl, _GLTXY,&DVEC,&CALSCON,_GLHUE,RED_,_GLSYMBOL,STAR_,_GLSYMHUE, RED_,_GLEO);

  carb_gl = cGl(carbwo);

  sGl(carb_gl,_GLTXY,&DVEC,&CARBSCON,_GLHUE,BLUE_,_GLSYMBOL,TRI_,_GLSYMHUE, BROWN_,_GLEO);

COUT(carb_gl)

  fibre_gl = cGl(carbwo);

  sGl(fibre_gl,_GLTXY,&DVEC,&FIBRCON,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, PINK_,_GLEO);

  fat_gl = cGl(carbwo);

  sGl(fat_gl,_GLTXY,&DVEC,&FATCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_,_GLEO);

  prot_gl = cGl(carbwo);

  sGl(prot_gl,_GLTXY,&DVEC,&PROTCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_,_GLEO);
// ave_ext_gl  = cGl(extwo,_GLTXY,DVEC,AVE_EXTV,_GLHUE,RED_,LINE_)

  se_gl   = cGl(extwo);

  sGl(se_gl,_GLTXY,&DVEC,&SEVEC,_GLHUE,GREEN_,_GLSYMBOL,DIAMOND_,_GLEO);

COUT(se_gl)

  int allgl[] = {bp_gl,ext_gl, se_gl, calb_gl, calc_gl, carb_gl, cardio_gl, wt_gl, strength_gl,-1};  // remove gw_gl

  int wedgl[] = { ext_gl, calb_gl, se_gl, calc_gl, carb_gl, fibre_gl,fat_gl,prot_gl, cardio_gl, wt_gl, strength_gl,-1};

  int exgls[] = {ext_gl, cardio_gl,strength_gl,-1};
//<<[_DB]"%V$allgl \n"

  float missing_val = 0.0;
  sGl(wedgl,_GLMISSING,&missing_val,_GLEO);

   // sGl(wt_gl,_GLMISSING,&missing_val,_GLEO);

  cout<<"set symbols \n";

  sGl(ext_gl,_GLSYMBOL,TRI_, _GLSYMFILL,ON_,_GLEO);

COUT(ext_gl);

  sGl(cardio_gl,_GLSYMBOL,DIAMOND_, _GLEO);

COUT(cardio_gl);

  sGl(strength_gl,_GLSYMBOL, STAR5_, _GLEO);

 sGl(wt_gl,_GLSYMBOL,TRI_,_GLSYMSIZE, Symsz, _GLSYMHUE,BLUE_,_GLEO);



COUT(strength_gl);

 




  sGl(se_gl,_GLSYMBOL,DIAMOND_,_GLEO);

  sGl(calb_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,RED_,_GLEO);

  sGl(calc_gl,_GLSYMBOL,TRI_,_GLSYMHUE,BLUE_,_GLEO);
//  sGl(carb_gl,_GLSYMBOL,"circle",_GLSYMHUE,BLUE_)



  sGl(carb_gl,_GLSYMBOL,ITRI_,_GLSYMHUE,BROWN_,_GLEO);

COUT(carb_gl);

  sGl(fibre_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,PINK_,_GLEO);

  sGl(fat_gl,_GLSYMBOL,CROSS_,_GLSYMHUE,BLUE_,_GLEO);

  sGl(prot_gl,_GLSYMBOL,TRI_,_GLSYMHUE,RED_,_GLEO);

COUT(prot_gl);

  sGl(bp_gl,_GLSYMBOL,ITRI_,_GLEO);
//  CURSORS
 // TBC cursor opt?

  lc_gl   = cGl(wtwo);

  //sGl(lc_gl,_GLTXY,_GLHUE,RED_,_GLCURSOR,_GLEO);

  rc_gl   = cGl(wtwo);
  //sGl(rc_gl,_GLTXY,_GLHUE,WHITE_,_GLCURSOR,_GLEO);


cout<<"glines setup\n";
;//==============\_(^-^)_/==================//;
