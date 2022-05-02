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
//   pwt_gl  = cGl(wtwo,@TXY,DVEC,PWTVEC,@color,GREEN_,@ltype,"line")



   ext_gl  = cGl(extwo);

<<"%V$ext_gl\n"

   sGl(ext_gl,_GLTXY,DVEC,EXTV,_GLCOLOR,GREEN_,_GLSYMBOL,TRI_,_GLEO);

   cardio_gl  = cGl(extwo);

   sGl(cardio_gl,_GLTXY,DVEC,CARDIO,_GLCOLOR,BLUE_,_GLSYMBOL, DIAMOND_,_GLEO);

<<"%V$cardio_gl\n"

   xs_gl  = cGl(extwo);

<<"%V$xs_gl\n"

   sGl( xs_gl ,_GLTXY,DVEC,XSTRENGTH,_GLCOLOR,RED_,_GLSYMBOL,STAR5_,_GLEO);
   


  sGl(ext_gl,_GLsymsize,3,_GLsymhue,GREEN_)

  wt_gl = cGl(wtwo)

   sGl(wt_gl,_GLTXY,DVEC,WTVEC,_GLcolor,BLUE_,_GLSYMBOL,DIAMOND_,_GLEO);

<<"%V$wt_gl\n"

//ans=query("see GLS?");


  if ((wt_gl == -1)  || (ext_gl == -1)) {
    exit()
  }



 gw_gl   = cGl(wtwo,_GLTXY,DVEC,GVEC,_GLcolor,GREEN_)


// gw_gl   = cGl(wtwo,_GLTXY,WDVEC,GVEC,_GLcolor,RED_)

 bp_gl   = cGl(swo,_GLTXY,DVEC,BPVEC,_GLcolor,RED_,_GLSYMBOL,_GLname,"benchpress")

if ( gw_gl == -1 || bp_gl == -1) {
   exit_si()
 }


 calb_gl = cGl(calwo)
 sGl(calb_gl,_GLTXY,DVEC,CALBURN,_GLHUE,RED_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, RED_,_GLEO);
// sGl(calb_gl,_GLTXY,&DVEC,&CALBURN,_GLHUE,RED_,_GLSYMBOL,DIAMOND_,_GLSYMHUE, RED_,_GLEO);
// calc_gl = cGl(calwo,_GLTXY,DFVEC,CALCON,_GLHUE,RED_,_GSYMBOL,"triangle",_GLsymhue, BLUE_,_GLEO);

 calc_gl = cGl(calwo)
 sGl(calc_gl,_GLTXY,DVEC,CALSCON,_GLHUE,RED_,_GLSYMBOL,STAR_,_GLsymhue, RED_,_GLEO);

 carb_gl = cGl(carbwo,_GLTXY,DVEC,CARBSCON,_GLHUE,BLUE_,_GLSYMBOL,TRI_,_GLsymhue, BROWN_,_GLEO);

 fibre_gl = cGl(carbwo,_GLTXY,DVEC,FIBRCON,_GLHUE,BLUE_,_GLSYMBOL,DIAMOND_,_GLsymhue, PINK_,_GLEO);

 fat_gl = cGl(carbwo,_GLTXY,DVEC,FATCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLsymhue, PINK_,_GLEO);

 prot_gl = cGl(carbwo,_GLTXY,DVEC,PROTCON,_GLHUE,BLUE_,_GLSYMBOL,CROSS_,_GLsymhue, PINK_,_GLEO);

// ave_ext_gl  = cGl(extwo,_GLTXY,DVEC,AVE_EXTV,_GLHUE,RED_,_GLltype,LINE_)

 se_gl   = cGl(extwo,_GLTXY,DVEC,SEVEC,_GLHUE,GREEN_,_GLSYMBOL_,DIAMOND_,_GLEO);


  int allgl[] = {wt_gl, gw_gl,bp_gl,ext_gl, se_gl, calb_gl, calc_gl, carb_gl, pwt_gl, cardio_gl, xs_gl,-1}

  int wedgl[] = {wt_gl, gw_gl, ext_gl, calb_gl, se_gl, calc_gl, carb_gl, fibre_gl,fat_gl,prot_gl, pwt_gl , cardio_gl, xs_gl}

  int exgls[] = {ext_gl, cardio_gl,xs_gl}

//<<[_DB]"%V$allgl \n"

  sGl(allgl,_GLMISSING,0,_GLSYMBOL,DIAMOND_,_GLEO)

  Symsz= 5.0;
  
  sGl(ext_gl,_GLSYMBOL,TRI_, _GLsymfill,_GLEO)
  sGl(cardio_gl,_GLSYMBOL,DIAMOND_, _GLsymfill,_GLEO)
  sGl(xs_gl,_GLSYMBOL,STAR5_, _GLsymfill,_GLEO)  
  sGl(wt_gl,_GLsymbol,DIAMOND_, _GLsymfill,_GLsymhue,BLUE_,_GLEO)
 

  sGl(se_gl,_GLsymbol,DIAMOND_)

  sGl(calb_gl,_GLsymbol,DIAMOND_,_GLsymfill,_GLsymhue,RED_)
  sGl(calc_gl,_GLsymbol,TRI_,_GLsymfill,_GLsymhue,BLUE_)
//  sGl(carb_gl,_GLsymbol,"circle",Symsz,_GLsymfill,_GLsymhue,BLUE_)
  sGl(carb_gl,_GLsymbol,ITRI_,_GLsymfill,_GLsymhue,BROWN_)
  
  sGl(fibre_gl,_GLsymbol,DIAMOND_,_GLsymfill,_GLsymhue,PINK_)

  sGl(fat_gl,_GLsymbol,CROSS_,_GLsymfill,_GLsymhue,BLUE_)

  sGl(prot_gl,_GLsymbol,TRI_,_GLsymfill,_GLsymhue,RED_)
  
  sGl(bp_gl,_GLsymbol,ITRI_,_GLmissing,0)



//  CURSORS
 // TBC cursor opt?
  lc_gl   = cGl(wtwo,_GLtype,XY_,_GLHUE,RED_,_GLltype,CURSOR_)

  rc_gl   = cGl(wtwo,_GLtype,XY_,_GLHUE,WHITE_,_GLltype,CURSOR_)


//===========================================//