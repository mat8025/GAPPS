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
//----------------<v_&_v>-------------------------//                                                                                              

///////////////////// GLINES & SYMBOLS ///////////////////////////////
//<<[_DB]"\n%(10,, ,\n)$DVEC \n"



 COUT(pwt_gl)

  ext_gl  = cGl(extwo); // extwo

// set as XYVECTOR

 sGl(_GLID,ext_gl,_GLXVEC,DVEC,_GLYVEC,EXTV,_GLHUE,BLACK_,_GLSYMLINE, DIAMOND_);

<<"%V $ext_gl \n"

  COUT(ext_gl)

  int cardio_gl  = cGl(extwo);


  sGl(_GLID,cardio_gl,_GLXVEC, DVEC,_GLYVEC,CARDIO,_GLHUE,BLUE_,_GLSYMLINE,DIAMOND_);

COUT(cardio_gl)

  int strength_gl  = cGl(extwo);


  sGl(_GLID,strength_gl,_GLXVEC,DVEC,_GLYVEC,STRENGTH,_GLHUE,RED_,_GLSYMLINE,STAR5_);

COUT(strength_gl)

 // sGl(ext_gl,_GLSYMSIZE,3,_GLSYMHUE,GREEN_);

  wt_gl = cGl(wtwo);




  sGl(_GLID,wt_gl, _GLHUE, RED_, _GLXVEC, DVEC, _GLYVEC, WTVEC,_GLSYMLINE, TRI_);
  
  pa(wt_gl);


  if ((wt_gl == -1)  || (ext_gl == -1)) {

  exit(-1);

  }

//  gw_gl   = cGl(wtwo);

//  sGl(gw_gl,_GLTXY,&DVEC,&GVEC,_GLHUE,GREEN_,_GLEO);
// gw_gl   = cGl(wtwo,_GLTXY,WDVEC,GVEC,_GLHUE,RED_)
gw_gl = -1;
COUT(gw_gl)

  bp_gl   = cGl(swo);

  sGl(_GLID,bp_gl,_GLXVEC,DVEC,_GLYVEC,BPVEC,_GLHUE,RED_,_GLSYMBOL,TRI_,_GLNAME,"benchpress");

  if (  bp_gl == -1) {

  exit_si();

  }

  calb_gl = cGl(calwo);

  sGl(_GLID,calb_gl,_GLXVEC,DVEC,_GLYVEC,CALBURN,_GLHUE,RED_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, RED_);
// calc_gl = cGl(calwo,_GLTXY,DFVEC,CALCON,_GLHUE,RED_,_GLSYMBOL,"triangle",_GLSYMHUE, BLUE_,GLEO);

COUT(calb_gl)

  calc_gl = cGl(calwo);

  sGl(_GLID,calc_gl, _GLXVEC,DVEC,_GLYVEC,CALSCON,_GLHUE,RED_,_GLSYMBOL,STAR_,_GLSYMHUE, RED_);

  carb_gl = cGl(carbwo);

  sGl(_GLID,carb_gl,_GLXVEC,DVEC,_GLYVEC,CARBSCON,_GLHUE,BLUE_,_GLSYMBOL,TRI_,_GLSYMHUE, BROWN_);

COUT(carb_gl)

  fibre_gl = cGl(carbwo);

  sGl(_GLID,fibre_gl,_GLXVEC,DVEC,_GLYVEC,FIBRCON,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, PINK_);

  fat_gl = cGl(carbwo);

  sGl(_GLID,fat_gl,_GLXVEC,DVEC,_GLYVEC,FATCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_);

  prot_gl = cGl(carbwo);

  sGl(_GLID,prot_gl,_GLXVEC,DVEC,_GLYVEC,PROTCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_);
// ave_ext_gl  = cGl(extwo,_GLXVEC,DVEC,AVE_EXTV,_GLHUE,RED_,LINE_)

  se_gl   = cGl(extwo);

  sGl(_GLID,se_gl,_GLXVEC,DVEC,_GLYVEC,SEVEC,_GLHUE,GREEN_,_GLSYMBOL,DIAMOND_);

COUT(se_gl)

  int allgl[] = {bp_gl, ext_gl, se_gl, calb_gl, calc_gl, carb_gl, cardio_gl, wt_gl, strength_gl,-1};  // remove gw_gl

  int wedgl[] = { ext_gl, calb_gl, se_gl, calc_gl, carb_gl, fibre_gl,fat_gl,prot_gl, cardio_gl, wt_gl, strength_gl,-1};

  int exgls[] = {ext_gl, cardio_gl,strength_gl,-1};
//<<[_DB]"%V$allgl \n"

  double missing_val = 0.0;
  //sGl(wedgl,_GLMISSING,&missing_val,_GLEO);

  int wgl = 0;
  int ki = 0;
  
  //while (wedgl[ki] > 0) {

  while (1) {
  
        sGl(_GLID,wedgl[ki],_GLMISSING,missing_val);
        ki++;
	if (wedgl[ki] <0) {
         break;
        }
 }

  cout<<"set symbols \n";

  //sGl(_GLID,ext_gl,_GLSYMBOL,TRI_, _GLSYMSIZE, Symsz,_GLSYMFILL,ON_);

sGl(_GLID,ext_gl,_GLSYMBOL, DIAMOND_, _GLSYMSIZE, Symsz, _GLSYMHUE,RED_);

  COUT(ext_gl);

  sGl(_GLID,cardio_gl,_GLSYMBOL,DIAMOND_);

  COUT(cardio_gl);

  sGl(_GLID,strength_gl,_GLSYMBOL, STAR5_);

  sGl(_GLID,wt_gl,_GLSYMBOL,TRI_,_GLSYMSIZE, Symsz, _GLSYMHUE,BLUE_);

  COUT(strength_gl);

 




  sGl(_GLID,se_gl,_GLSYMBOL,DIAMOND_);

  sGl(_GLID,calb_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,RED_);

  sGl(_GLID,calc_gl,_GLSYMBOL,TRI_,_GLSYMHUE,BLUE_);
//  sGl(carb_gl,_GLSYMBOL,"circle",_GLSYMHUE,BLUE_)



  sGl(_GLID,carb_gl,_GLSYMBOL,ITRI_,_GLSYMHUE,BROWN_);

COUT(carb_gl);

  sGl(_GLID,fibre_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,PINK_);

  sGl(_GLID,fat_gl,_GLSYMBOL,CROSS_,_GLSYMHUE,BLUE_);

  sGl(_GLID,prot_gl,_GLSYMBOL,TRI_,_GLSYMHUE,RED_);

COUT(prot_gl);

  sGl(_GLID,bp_gl,_GLSYMBOL,ITRI_);
//  CURSORS
 // TBC cursor opt?

  lc_gl   = cGl(wtwo);

  sGl(_GLID,lc_gl,_GLTYPE_CURS, ON_,_GLHUE,RED_,_GLDRAW,ON_);

  rc_gl   = cGl(wtwo);

  sGl(_GLID,rc_gl,_GLTYPE_CURS, ON_,_GLHUE,BLUE_,_GLDRAW,ON_);


cout<<"glines setup\n";

//==============\_(^-^)_/==================//
