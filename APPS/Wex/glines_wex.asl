/* 
 *  @script glines_wex.asl                                                    
 * 
 *  @comment                                                                 
 *  @release Carbon                                                           
 *  @vers 1.4 Be Beryllium [asl 6.67 : C Ho]                                  
 *  @date 01/15/2026 09:20:02                                                 
 *  @cdate Sat Dec 29 09:04:43 2018                                          
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2026 -->                                     
 * 
 */ 

//----------------<v_&_v>-------------------------//                                                                                              

///////////////////// GLINES & SYMBOLS ///////////////////////////////
//<<[_DB]"\n%(10,, ,\n)$DVEC \n"
   //oknow = Ask ("que pasa? $_proc ",1)


// COUT(pwt_gl)


  int cardio_gl  = cGl(exer_wo)


  sGl(_GLID,cardio_gl,_GLXVEC, DVEC,_GLYVEC,CARDIO,_GLHUE,BLUE_,_GLSYMLINE,DIAMOND_);

//COUT(cardio_gl)

  int strength_gl  = cGl(carb_wo);


  sGl(_GLID,strength_gl,_GLXVEC,DVEC,_GLYVEC,STRENGTH,_GLHUE,RED_,_GLSYMLINE,STAR5_);

//COUT(strength_gl)



  wt_gl = cGl(wt_wo);

  sGl(_GLID,wt_gl, _GLHUE, RED_, _GLXVEC, DVEC, _GLYVEC, WTVEC,_GLSYMLINE, TRI_,_GLUSESCALES,0,_GLNAME,"weight")


  ext_gl  = cGl(exer_wo) 

  sGl(_GLID,ext_gl,_GLXVEC,DVEC,_GLYVEC,EXTV,_GLHUE,BLUE_,_GLSYMLINE, STAR_,_GLUSESCALES,0,_GLNAME,"exer_time")


  if ((wt_gl == -1)  || (ext_gl == -1)) {

   <<"Gline %V $wt_gl $ext_gl  ERROR\n"

  }


  bp_gl   = cGl(exer_wo);

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


  calx_gl = cGl(cal_wo);

  sGl(_GLID,calx_gl, _GLXVEC,DVEC,_GLYVEC,EXEBURN,_GLHUE,ORANGE_,_GLSYMBOL,CROSS_,_GLSYMHUE, GREEN_,GLNAME,"calorie exer burn")



  carb_gl = cGl(food_wo);

  sGl(_GLID,carb_gl,_GLXVEC,DVEC,_GLYVEC,CARBSCON,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, RED_,_GLUSESCALES,0,_GLNAME,"carbs consumed")



  fibre_gl = cGl(food_wo);

  sGl(_GLID,fibre_gl,_GLXVEC,DVEC,_GLYVEC,FIBRCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, PINK_,_GLNAME,"fibre")

  fat_gl = cGl(food_wo);

  sGl(_GLID,fat_gl,_GLXVEC,DVEC,_GLYVEC,FATCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLSYMHUE, GREEN_,_GLNAME,"fat")

  prot_gl = cGl(food_wo);

  sGl(_GLID,prot_gl,_GLXVEC,DVEC,_GLYVEC,PROTCON,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, LILAC_,_GLNAME,"protein")


  glu_gl = cGl(ket_wo);
  sGl(_GLID,glu_gl,_GLXVEC,DVEC,_GLYVEC,GLUCOSE,_GLHUE,GREEN_,_GLSYMBOL,CROSS_,_GLSYMHUE, GREEN_,_GLUSESCALES,0,_GLNAME,"glucose")

  ket_gl = cGl(ket_wo);
  sGl(_GLID,ket_gl,_GLXVEC,DVEC,_GLYVEC,KETONE,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, BLUE_,_GLUSESCALES,1,_GLNAME,"ketone")

  gki_gl = cGl(ket_wo);

  sGl(_GLID,gki_gl,_GLXVEC,DVEC,_GLYVEC,GKI,_GLHUE,ORANGE_,_GLSYMBOL,STAR_,_GLSYMHUE, ORANGE_, _GLUSESCALES,1,_GLNAME,"GKI")

 // se_gl   = cGl(exer_wo);

//  sGl(_GLID,se_gl,_GLXVEC,DVEC,_GLYVEC,SEVEC,_GLHUE,GREEN_,_GLSYMBOL,DIAMOND_);


// TRANS OK ?



  int wedgl[] = { ext_gl, calb_gl, bp_gl, calc_gl, cald_gl,calx_gl,carb_gl, fibre_gl,fat_gl,prot_gl, cardio_gl, wt_gl, glu_gl,ket_gl, gki_gl,-1};

  int exgls[] = {ext_gl, cardio_gl,bp_gl,-1};
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

  sGl(_GLID,ext_gl,_GLSYMBOL,TRI_, _GLSYMSIZE, Symsz,_GLSYMFILL,ON_);

  sGl(_GLID,ext_gl,_GLSYMBOL, STAR_, _GLSYMSIZE, Symsz, _GLSYMHUE,GREEN_,_GLNAME,"exer_time");

  sGl(_GLID,cardio_gl,_GLSYMBOL,DIAMOND_);

  //sGl(_GLID,se_gl,_GLSYMBOL, STAR5_);

  sGl(_GLID,wt_gl,_GLSYMBOL,DIAMOND_,_GLSYMSIZE, Symsz, _GLSYMHUE,BLUE_,_GLNAME,"weight");

  sGl(_GLID,bp_gl,_GLSYMBOL,DIAMOND_);

  sGl(_GLID,calb_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,RED_,_GLNAME,"cals_out");

  sGl(_GLID,calc_gl,_GLSYMBOL,TRI_,_GLSYMHUE,BLUE_,_GLNAME,"cals_in");

  sGl(_GLID,cald_gl,_GLSYMBOL,CROSS_,_GLSYMHUE,GREEN_,_GLNAME,"cal_deficit");

  sGl(_GLID,calx_gl,_GLSYMBOL,STAR_,_GLSYMHUE,RED_,_GLNAME,"cal_xburn");

  sGl(_GLID,carb_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,RED_,_GLNAME,"carb");



  sGl(_GLID,fibre_gl,_GLSYMBOL,ITRI_,_GLSYMHUE,BROWN_,_GLNAME,"fiber");

  sGl(_GLID,fat_gl,_GLSYMBOL,CROSS_,_GLSYMHUE,BLUE_,_GLNAME,"fat");

  sGl(_GLID,prot_gl,_GLSYMBOL,DIAMOND_,_GLSYMHUE,GREEN_,_GLNAME,"prot");

  
//  CURSORS
 // TBC cursor opt?

  lc_gl   = cGl(wt_wo);

  sGl(_GLID,lc_gl,_GLTYPE_CURS, ON_,_GLHUE,RED_,_GLDRAW,ON_);

  rc_gl   = cGl(wt_wo);

  sGl(_GLID,rc_gl,_GLTYPE_CURS, ON_,_GLHUE,BLUE_,_GLDRAW,ON_);

  int allgls[] = { wt_gl,  ext_gl, fibre_gl,  fat_gl,  prot_gl,  calc_gl,  cald_gl,calx_gl,calb_gl, glu_gl, ket_gl, gki_gl,carb_gl,bp_gl,-1};  // 

  int foodgls[] = { carb_gl, fibre_gl,fat_gl, prot_gl, -1 };

  int calgls[] = { calb_gl, calc_gl, cald_gl, calx_gl, -1 };


<<"glines setup %V $wt_gl $carb_gl\n";

//==============\_(^-^)_/==================//
