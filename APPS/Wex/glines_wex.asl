/* 
 *  @script glines_wex.asl 
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
   //oknow = Ask ("que pasa? $_proc ",1)


// COUT(pwt_gl)



//<<"%V $ext_gl \n"

//  COUT(ext_gl)

  int cardio_gl  = cGl(carb_wo)


  sGl(_GLID,cardio_gl,_GLXVEC, DVEC,_GLYVEC,CARDIO,_GLHUE,BLUE_,_GLSYMLINE,DIAMOND_);

//COUT(cardio_gl)

  int strength_gl  = cGl(carb_wo);


  sGl(_GLID,strength_gl,_GLXVEC,DVEC,_GLYVEC,STRENGTH,_GLHUE,RED_,_GLSYMLINE,STAR5_);

//COUT(strength_gl)

 // sGl(ext_gl,_GLSYMSIZE,3,_GLSYMHUE,GREEN_);

  wt_gl = cGl(wt_wo);

  sGl(_GLID,wt_gl, _GLHUE, RED_, _GLXVEC, DVEC, _GLYVEC, WTVEC,_GLSYMLINE, TRI_,_GLNAME,"weight")

//  ext_gl  = cGl(carb_wo)
  ext_gl  = cGl(cal_wo) 

// set as XYVECTOR

 // sGl(_GLID,ext_gl,_GLXVEC,DVEC,_GLYVEC,EXTV,_GLHUE,BLUE_,_GLSYMLINE, STAR_,_GLUSESCALES,1,_GLNAME,"exer time")

  


  if ((wt_gl == -1)  || (ext_gl == -1)) {

   <<"Gline %V $wt_gl $ext_gl  ERROR\n"

  }

//  gw_gl   = cGl(wt_wo);

//  sGl(gw_gl,_GLTXY,&DVEC,&GVEC,_GLHUE,GREEN_,_GLEO);
// gw_gl   = cGl(wt_wo,_GLTXY,WDVEC,GVEC,_GLHUE,RED_)
gw_gl = -1;
//COUT(gw_gl)

  bp_gl   = cGl(swo);

  sGl(_GLID,bp_gl,_GLXVEC,DVEC,_GLYVEC,BPVEC,_GLHUE,RED_,_GLSYMBOL,TRI_,_GLNAME,"benchpress");

  if (  bp_gl == -1) {

<<"%V $bp_gl ERROR\n"

  }

  calb_gl = cGl(cal_wo);

  sGl(_GLID,calb_gl,_GLXVEC,DVEC,_GLYVEC,CALSBURN,_GLHUE,RED_,_GLSYMBOL,"diamond",_GLSYMHUE, RED_,_GLNAME,"cals burnt")

// calc_gl = cGl(cal_wo,_GLTXY,DFVEC,CALCON,_GLHUE,RED_,_GLSYMBOL,"triangle",_GLSYMHUE, BLUE_,GLEO);

//COUT(calb_gl)

  calc_gl = cGl(cal_wo);

  sGl(_GLID,calc_gl, _GLXVEC,DVEC,_GLYVEC,CALSCON,_GLHUE,RED_,_GLSYMBOL,"star",_GLSYMHUE, RED_,_GLNAME,"cals consumed")


  cald_gl = cGl(cal_wo);

  sGl(_GLID,cald_gl, _GLXVEC,DVEC,_GLYVEC,CALSDEF,_GLHUE,ORANGE_,_GLSYMBOL,CROSS_,_GLSYMHUE, GREEN_,GLNAME,"calorie deficit")

  carb_gl = cGl(carb_wo);

  sGl(_GLID,carb_gl,_GLXVEC,DVEC,_GLYVEC,CARBSCON,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, RED_,_GLNAME,"carbs consumed")

//COUT(carb_gl)

  fibre_gl = cGl(food_wo);

  sGl(_GLID,fibre_gl,_GLXVEC,DVEC,_GLYVEC,FIBRCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_,_GLNAME,"fibre")

  fat_gl = cGl(food_wo);

  sGl(_GLID,fat_gl,_GLXVEC,DVEC,_GLYVEC,FATCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, GREEN_,_GLNAME,"fat")

  prot_gl = cGl(food_wo);

  sGl(_GLID,prot_gl,_GLXVEC,DVEC,_GLYVEC,PROTCON,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, LILAC_,_GLNAME,"protein")
// ave_ext_gl  = cGl(carb_wo,_GLXVEC,DVEC,AVE_EXTV,_GLHUE,RED_,LINE_)

  se_gl   = cGl(carb_wo);

  sGl(_GLID,se_gl,_GLXVEC,DVEC,_GLYVEC,SEVEC,_GLHUE,GREEN_,_GLSYMBOL,DIAMOND_);


// TRANS OK ?

  int allgl[] = {bp_gl, ext_gl, se_gl, calb_gl, calc_gl, cald_gl, carb_gl, cardio_gl, wt_gl, strength_gl,-1};  // remove gw_gl

  int wedgl[] = { ext_gl, calb_gl, se_gl, calc_gl, cald_gl,carb_gl, fibre_gl,fat_gl,prot_gl, cardio_gl, wt_gl, strength_gl,-1};

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

  //cout<<"set symbols \n";

  //sGl(_GLID,ext_gl,_GLSYMBOL,TRI_, _GLSYMSIZE, Symsz,_GLSYMFILL,ON_);

  sGl(_GLID,ext_gl,_GLSYMBOL, STAR_, _GLSYMSIZE, Symsz, _GLSYMHUE,GREEN_,_GLNAME,"exer time");

  sGl(_GLID,cardio_gl,_GLSYMBOL,DIAMOND_);

  sGl(_GLID,strength_gl,_GLSYMBOL, STAR5_);

  sGl(_GLID,wt_gl,_GLSYMBOL,DIAMOND_,_GLSYMSIZE, Symsz, _GLSYMHUE,BLUE_,_GLNAME,"weight");

  sGl(_GLID,se_gl,_GLSYMBOL,DIAMOND_);

  sGl(_GLID,calb_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,RED_,_GLNAME,"cals_out");

  sGl(_GLID,calc_gl,_GLSYMBOL,TRI_,_GLSYMHUE,BLUE_,_GLNAME,"cals_in");

  sGl(_GLID,cald_gl,_GLSYMBOL,STAR_,_GLSYMHUE,GREEN_,_GLNAME,"cal_deficit");

  sGl(_GLID,carb_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,RED_,_GLNAME,"carb");

//COUT(carb_gl);

  sGl(_GLID,fibre_gl,_GLSYMBOL,ITRI_,_GLSYMHUE,BROWN_,_GLNAME,"fiber");

  sGl(_GLID,fat_gl,_GLSYMBOL,CROSS_,_GLSYMHUE,BLUE_,_GLNAME,"fat");

  sGl(_GLID,prot_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,GREEN_,_GLNAME,"prot");

  sGl(_GLID,bp_gl,_GLSYMBOL,ITRI_);
//  CURSORS
 // TBC cursor opt?

  lc_gl   = cGl(wt_wo);

  sGl(_GLID,lc_gl,_GLTYPE_CURS, ON_,_GLHUE,RED_,_GLDRAW,ON_);

  rc_gl   = cGl(wt_wo);

  sGl(_GLID,rc_gl,_GLTYPE_CURS, ON_,_GLHUE,BLUE_,_GLDRAW,ON_);

  int allgls[] = { wt_gl,  ext_gl, carb_gl,  fibre_gl,  fat_gl,  prot_gl,  calc_gl,  cald_gl,calb_gl,   -1};

  int foodgls[] = { carb_gl, fibre_gl,fat_gl, prot_gl, -1 };

  int calgls[] = { calb_gl, calc_gl, cald_gl, -1 };


<<"glines setup % $wt_gl $carb_gl\n";

//==============\_(^-^)_/==================//
