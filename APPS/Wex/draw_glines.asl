//
//  draw_glines.asl
//


void drawGlines()
{

   int gi=0;


/*
  dGl(wt_gl);

  dGl(calx_gl);
  
  dGl(ket_gl);

   dGl(glu_gl);

  dGl(glu_gl);

  dGl(calc_gl);

   dGl(carb_gl);

  dGl(ext_gl);
  dGl(prot_gl);
    dGl(fat_gl);
*/




  while ( 1) {
  
  gname = glineGetName(allgls[gi]);
  
  ok=ask("%V $gi $allgls[gi] $gname",0);

  sGl(_GLID,allgls[gi],_GLDRAW,ON_);
  
  gi++;

    if (allgls[gi] < 0)  {
             break;
    }

  }

//  sGl(_GLID,ext_gl,_GLUSESCALES,1,_GLDRAW,ON_);

  for (i = 0; i< 10; i++) {
        if (wedwos[i] <=0) {
         break;
	 }

   //  sWo(_woid,wedwos[i],_wclipborder,BLACK_,_wpixmap,ON_,_wsavepixmap,ON_);
   }
     dGl(ext_gl);
}
oknow = Ask (" $_include  ",0)