///////////////////////////////////<**|**>/////////////////////////////////// 
//                                 wo_set_p.cpp 
//    set wo attributes   
//     
//    @release   CARBON  
//    @vers 2.7 N Nitrogen                                               
//    @date Thu Jan  3 15:07:57 2019 
//    @cdate Fri Jan  1 08:00:00 2010    
//    @Copyright   RootMeanSquare - 1990,2019 --> 
//    @author: Mark Terry                                  
//  
// /. .\ 
// \ ' / 
//   - 
///////////////////////////////////<v_&_v>/////////////////////////////////// 


 
  #include "wo_set_p.h"
  
  extern "C" int Gwo_set_ele = 79;
  
  
  int plot_symbol (Svarg * s, Woid woid, int use_clip);
  int pw_hash (const char *name, int fw);
  int getwotype (Svarg * s);
  
  struct pwt pwob_table[MAX_PW];
  
  void 
  init_wo_table ()
  {
  
    for (int i = 0; i < MAX_PW; i++)
      {
        pwob_table[i].pw = -1;
        pwob_table[i].name[0] = '\0';
      }
  
    pw_hash ("AXNUM", GWM_AXNUM);
    pw_hash ("BELL", GWM_SWOBELL);
    pw_hash ("BHUE", GWM_SWOBHUE);
    pw_hash ("BORDER", GWM_WOBORDER);
    pw_hash ("CALLBACK", GWM_SWOCALLBACK);
    pw_hash ("CLEARCLIP", GWM_WOCLEARCLIP);
    pw_hash ("CLEAR", GWM_WOCLEAR);
    pw_hash ("CLEARPIXMAP", GWM_WOCLEARPIXMAP);
    pw_hash ("CLIPBHUE", GWM_SWOCBHUE);
    pw_hash ("CLIPBORDER", GWM_WOCLIPBORDER);
    pw_hash ("CLIPFHUE", GWM_SWOCFHUE);
    pw_hash ("CLIP", GWM_SWCLIP);
    pw_hash ("COLOR", GWM_SWOBHUE);
    pw_hash ("CSV", GWM_SWOCSV);
    pw_hash ("CXOR", GWM_WOXOR);
    pw_hash ("DRAWOFF", GWM_WDRAWOFF);
    pw_hash ("DRAWON", GWM_WDRAWON);
    pw_hash ("FHUE", GWM_SWOFHUE);
    pw_hash ("FONT", GWM_SWOFONT);
    pw_hash ("FONTHUE", GWM_SWOFONTHUE);
    pw_hash ("FUNC", GWM_SWOFUNC);
    pw_hash ("GRIDHUE", GWM_SWOGRIDHUE);
    pw_hash ("GRID", GWM_SWOGRID);
    pw_hash ("HELP", GWM_SWOHELP);
    pw_hash ("HIDE", GWM_WOHIDE);
    pw_hash ("HIGHLIGHT", GWM_SWOHILITE);
    pw_hash ("HMOVE", GWM_SWOHMOVE);
    pw_hash ("HVMOVE", GWM_SWOMOVE);  
    pw_hash ("HUE", GWM_SWOFHUE);
    pw_hash ("KEYGLINE", GWM_KEYGLINE);
    pw_hash ("LINE", GWM_WOLINE);
    pw_hash ("LIST", GWM_SWOLIST);
    pw_hash ("MENU", GWM_SWOMENU);
    pw_hash ("MESSAGE", GWM_SWOMSG);
    pw_hash ("MOVE", GWM_WOMOVE);
    pw_hash ("NAME", GWM_SWONAME);
    pw_hash ("PENHUE", GWM_SWOCFHUE);
    pw_hash ("PIXMAPOFF", GWM_WOPIXMAPOFF);
    pw_hash ("PIXMAPDRAWOFF", GWM_WOPIXMAPOFF);
    pw_hash ("PIXMAPON", GWM_WOPIXMAPON);
    pw_hash ("PIXMAPDRAWON", GWM_WOPIXMAPON);  
    pw_hash ("PRINT", GWM_WOPRINT);
    pw_hash ("REDRAW", GWM_WOREDRAW);
    pw_hash ("RESIZE_FR", GWM_SWORESIZE);
    pw_hash ("RESIZE", GWM_SWORESIZE);
    pw_hash ("RHTSCALES", GWM_RHTSCALES);
    pw_hash ("LHBSCALES", GWM_LHBSCALES);
    pw_hash ("SAVE", GWM_WOSAVE);
    pw_hash ("SAVEPIXMAP", GWM_WOSAVEPIXMAP);
    pw_hash ("SCALES", GWM_SWORS);
    pw_hash ("SAVESCALES", GWM_WSAVESCALES);
    pw_hash ("USESCALES", GWM_WUSESCALES);
    pw_hash ("SCROLLCLIP", GWM_WOSCROLLCLIP);
    pw_hash ("SETROWSCOLS", GWM_WOSETSHEETROWSCOLS);
    pw_hash ("SHEETROW", GWM_WOSHEETROW);
    pw_hash ("SHEETCOL", GWM_WOSHEETCOL);
    pw_hash ("DISPLAYCOLS", GWM_WOSHEETDISPCOL);  
    pw_hash ("SHEETREAD", GWM_WOSHEETREAD);
    pw_hash ("CELLHUE", GWM_WOCELLHUE);
    pw_hash ("CELLBHUE", GWM_WOCELLBHUE);
    pw_hash ("CELLVAL", GWM_WOCELLVAL);
    pw_hash ("CELLDRAW", GWM_WOCELLDRAW);  
    pw_hash ("SHEETMOD", GWM_WOSHEETMOD);
    pw_hash ("SHOW", GWM_WOVISIBLE);
    pw_hash ("SHOWPIXMAP", GWM_WOSHOWPIXMAP);
    pw_hash ("STORE", GWM_WOSAVE);
    pw_hash ("STYLE", GWM_SWOSTYLE);
    pw_hash ("SYMANG", GWM_SWOSYMANG);
    pw_hash ("SYMBOL", GWM_SYMBOL);
    pw_hash ("SYMBOLSHAPE", GWM_SWOSYMBOL);
    pw_hash ("SYMSIZE", GWM_SWOSYMSIZE);
    pw_hash ("TEXTF", GWM_SWOTEXTF);
    pw_hash ("TEXT", GWM_SWOTEXT);
    pw_hash ("TEXTHUE", GWM_SWOFONTHUE);
    pw_hash ("TEXTR", GWM_SWOTEXTR);
    pw_hash ("TITLE", GWM_SWONAME);
    pw_hash ("TYPE", GWM_SWOTYPE);
    pw_hash ("UPDATE", GWM_WOUPDATE);
    pw_hash ("VALUE", GWM_SWOVALUE);
    pw_hash ("VISIBLE", GWM_WOVISIBLE);
    pw_hash ("VMOVE", GWM_SWOVMOVE);
    pw_hash ("XSCALES", GWM_SWORXS);
    pw_hash ("YSCALES", GWM_SWORYS);
    pw_hash ("SELECTROWSCOLS", GWM_WOSELECTSHEETROWSCOLS);
    pw_hash ("SWAPROWS", GWM_WOSHEETSWAPROWS);
    pw_hash ("SWAPCOLS", GWM_WOSHEETSWAPCOLS);
    pw_hash ("SETCOLSIZE",GWM_WOSETSHEETCOLSIZE);
    pw_hash ("SETROWSIZE",GWM_WOSETSHEETCOLSIZE);     
    // TBD
    pw_hash ("ONOFF", 999);
    pw_hash ("BV", 999);
    pw_hash ("BN", 999);
    pw_hash ("BS", 999);  
    pw_hash ("GRAPH", 999);
    pw_hash ("TB", 999);
    pw_hash ("TB_MENU", 999);            
  
  }
  //[EF]===================================================//
  
  
  int Wopsf::wosettext (Svarg * s)
  {
    char *cp;
  
    if (!s->checkGwmArgCount (2))
      return 0;
  
    Woid wow (s->GetArgI ());
  
    /* next can be a string or array */
    cp = s->getArgStr ();
  
    // DBT("%d %d <%s> \n",wow.wid, wow.won, cp);
    GS_WOTEXT (wow.wid, wow.won, cp);
  
    return s->result->Store (1);
  
  }
  
  //[EF]===================================================//
  //////////////////////////  functions called by  SetWo ////////////////////////////////
  void
  wokeygline (Svarg * s, Woid iwoid)
  {
    /// get array of glines
    /// look up symbol and name
    /// default -- center vertical tile symbol -- name of gline
    //  DBT("iwoid.woid %d\n",iwoid.woid);
    Wgm wgm (iwoid.woid);
  
    Gline *gline;
  
    Siv *sivp = s->getArgSiv ();
    char gname[32];
    gname[31] = 0;
  
    if (sivp->isArray (INT))
      {
  
        int *gl = (int *) sivp->Memp ();
  
        int ngl = sivp->size;
  
        if (ngl > 0)
  	{
  	  float ys = 0.9;
  	  float ys_dy = 1.0 / ngl;
  
  	  for (int i = 0; i < ngl; i++)
  	    {
  
  	      gline = get_gline (gl[i]);
  
  	      if (gline != NULL)
  		{
  
  		  // plot the symbol --- then the text
  		  // plotWosymbol(key_wo,0.12,0.8,"triangle",15,ORANGE,1)
  		  // plotWosymbol(key_wo,0.12,0.6,"diamond",15,YELLOW,1)
  		  // Text(key_wo,"raw_top",0.22,0.8,1)
  		  // Text(key_wo,"sqshy_top",0.22,0.6,1)
  		  strncpy (gname, gline->getName (), 31);
  //DBT("ys %f symb %d symsize %f hue %d name %s %s\n",ys,gline->symbol,gline->symsize, gline->symhue,gline->GetName(),gname);
  
  
  		  wgm.woSymbol (0.2, ys, gline->symbol, gline->symsize,
  				gline->symhue, 0, 1, 0, 0, 1);
  
  		  // move by symbol width
  		  wgm.winText (0.35, ys - 0.05, 0, gname, 0, 0,
  			       CURRENT_COLOR);
  
  		  ys -= ys_dy;
  		}
  	    }
  	}
      }
  }
  
  
  //////////////////////////////////// WO SETTING /////////////////////////////
  
  void
  set_symbol (Woid woid, Svarg * s)
  {
  
    Wgm wgm (woid.woid);
    int symn = 1;
  
    if (s->checkArgStr ())
      symn = symbolShapeToNumber (s->getArgStr ());
    else
      symn = s->GetArgI ();
  
     wgm.setWpnum (symn, GWM_SWOSYMBOL);
  
  }
  
  //[EF]===================================================//
  void woSheetFuncs( Woid woid, Svarg * s,int wf);
  void woHueFuncs( Woid woid, Svarg * s,int wf);
  int
  SetWO (Woid woid, Svarg * s, int vi)
  {
    //  static int callg = 0;
  
    int ok = 0;
    char *tag = NULL;
    int isatag;
    int wo_option = -1;
  
    int onoff = ON;
  
    //DBT("woid.woid %d\n",woid.woid);
  
    Wgm wgm (woid.woid);
  
    DBPF("wgm %d %d\n",wgm.getWid(),wgm.getWon());
    int args_left= 0;
    try {
      
      while (1)
      {
        onoff = ON;
  
        wo_option = -1;
  
        args_left =s->AnotherArg ();
        
        isatag = s->checkArgTag ();
  
        // DBT("args_left %d isatag ? %d\n",args_left,isatag);
  
        //
        //if (args_left <=0 && !isatag) {
        //  break;
        //}
        
  // if we use convention setGwob(wo,@tag1,value,,,@tag2,value,,,)
  
        if (isatag) {
  	tag = s->getArgStr ();
          DBPF  (" tag <|%s|>  tagargsleft %d\n", tag,  s->tagArgsLeft ());
        }
        else {
  	tag = s->makeStrFromArg ();	// if we have a stray argument
        // like a numeric then tag checking 
        // causes a crash
        // test for arg type and skip if not a tag or a string
        }
        
        DBPF  ("tag %s\n", tag);
  
        if (tag != NULL)
  	{
  	  wo_option = findWoOption (tag);
  
  	  DBPF 
  		("isatag %d <|%s|> wo_option %d tagargs %d\n", isatag, tag,
  		 wo_option, s->tagArgsLeft ());
  
  	}
        else
  	{
  	  dberror ("NULL TAG \n");
  	}
  
        
        if (wo_option != -1)
  	{
  	  // we have tag,values action coded -
  	  // either for @tag,"value" or "tag","value"  forms
  	  ok = 1;
  
  	  if (wo_option >= GWM_WOSHEETCOL)
  	    {
  	      //dbp("doing sheet %d option %s\n", wo_option, gwm_code(wo_option));
  	      woSheetFuncs(woid, s,wo_option);
   	    }
  	  else if (wo_option >= GWM_SWOBHUE  && wo_option <= GWM_SWOGRIDHUE)
  	    {
  	      //dbp("doing hue %d option %s\n", wo_option, gwm_code(wo_option));
  	      woHueFuncs(woid, s,wo_option);
  	    }	  
  	  // sheet ops ?
            else {
  	    //	  DBT("doing main %d option %s\n", wo_option, gwm_code(wo_option));
  	  
  	  switch (wo_option)
  	    {
  
  	    case GWM_SWCLIP:
  	      {
  		if (s->tagArgsLeft () >= 4)
  		  {
  		    int clip_area_mode = 4;	// fractional coors of Wob area
  		    float RBV[4];
  		    if (getRect (s, RBV))
  		      {
  			if (s->tagArgsLeft () >= 1)
  			  clip_area_mode = s->getArgI ();	// 2 is llc offset and width and height
  			wgm.setWclip (clip_area_mode, RBV);
  		      }
  		  }
  
  	      }
  	      break;
  
  	    case GWM_SWOTYPE:
  	      {
  		int wtype = getwotype (s);
  		wgm.setWpnum (wtype, GWM_SWOTYPE);
  	      }
  
  	      break;
  	    case GWM_SWOFUNC:
  	      //DBT("SWOFUNC\n");
  	      wgm.setWOTxtField (s->getArgStr (), GWM_SWOFUNC);
  	      break;
  
  	    case GWM_SWOCALLBACK:
  	      wgm.setWOTxtField (s->getArgStr (), GWM_SWOCALLBACK);
  	      break;
  
  	    case GWM_SWOSTYLE:
  	      {
  		char style[32];
  		if (s->checkArgStr ()) {
  		 char *str = s->getArgStr();
  		 strncpy(style,str,20);
  		}
                  else {
  		  int a = s->getArgI();
  		  if (a== WO_SVL)
  		    strcpy(style,"SVL");
  		  else if (a== WO_SVR)
  		    strcpy(style,"SVR");
  		  else if (a== WO_SVB)
  		    strcpy(style,"SVB");
  		  else if (a== WO_SVT)
  		    strcpy(style,"SVT");		  
  		}
  		
  		 DBPF("style str %s\n",style);
  		 
  	         wgm.setWOTxtField (style, GWM_SWOSTYLE);
  	      }
  	      break;
  
  
  	    case GWM_SWOVALUE:
  	      {
  		// if the value arg is an array -- then we use the our vi as an index into the array
  		// to set value - so that an array of wo's  can be set to an array of vals 
  		// else if arg is not an array then use that value for all wos
  		// what type of arg? --- STRING,INT,FLOAT ...
  		if (s->isArgArray ())
  		  {
  		    wgm.setWOTxtField (s->makeStrFromArrayArg (vi), GWM_SWOVALUE);
  		  }
  		else
  		  {
  		    if (s->checkArgType (INT))
  		      {
  			int i = s->getArgI ();
  			wgm.woValue ((void *) &i, INT);
  		      }
  		    else if (s->checkArgType (FLOAT))
  		      {
  			float f = s->getArgF ();
  			wgm.woValue ((void *) &f, FLOAT);
  		      }
  		    else if (s->checkArgType (DOUBLE))
  		      {
  			double d = s->getArgD ();
  			wgm.woValue ((void *) &d, DOUBLE);
  		      }
  		    else
  		      wgm.setWOTxtField (s->makeStrFromArg (), GWM_SWOVALUE);
  
  		  }
  
  	      }
  	      break;
  
  
  	    case GWM_SWONAME:
  	      {
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    char *name = s->getArgStr ();
  
  		    if (name != NULL)
  		      {
  			wgm.setWOTxtField (name, GWM_SWONAME);
  		      }
  		    else
  		      dberror ("SWONAME null string \n");
  		  }
  	      }
  	      break;
  
  
  	    case GWM_SWOTEXTR:
  	      {
  		int hue = -1;
  		int rotate = 0;
  		int pos = 0;
  
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    char *txt = s->makeStrFromArg ();
  
  		    if (txt != NULL)
  		      {
  
  			float x = s->GetArgF ();
  			float y = s->GetArgF ();
  
  			//DBT("x %f y %f \n",x,y);
  			// tagargs left --- args left until next tag arg or if nomore tag args 
  
  			if (s->tagArgsLeft () >= 1)
  			  {
  			    pos = s->GetArgI ();
  			  }
  
  			if (s->tagArgsLeft () >= 1)
  			  {
  			    rotate = s->GetArgI ();
  			  }
  
  			if (s->tagArgsLeft () >= 1)
  			  {
  			    hue = s->getArgHue ();
  			    //DBT("textr hue %d\n",hue);
  			  }
  
  			//DBT("TextR <|%s|> %f %f %d %d hue %d\n",txt,x,y,pos,rotate,hue);
  
  			wgm.winText (x, y, pos, txt, -rotate, 0, hue);
  		      }
  		  }
  	      }
  
  	      break;
  
  	    case GWM_SWOTEXTF:
  	      {
  		int hue = -1;
  		int rotate = 0;
  		int pos = 0;
  
  		//DBT("wotextf\n");
  		if (s->tagArgsLeft () >= 1)
  		  {
  
  		    //char *txt = s->MakeStrFromArg ();
  		    char *txt = s->getArgStr ();
  
  
  		    if (txt != NULL)
  		      {
  
  			float x = s->GetArgF ();
  			float y = s->GetArgF ();
  
  			//DBT("%s x %f y %f \n",txt, x,y);
  			// tagargs left --- args left until next tag arg or if nomore tag args 
  
  			if (s->tagArgsLeft () >= 1)
  			  {
  			    pos = s->GetArgI ();
  			  }
  
  			if (s->tagArgsLeft () >= 1)
  			  {
  			    rotate = s->GetArgI ();
  			  }
  
  			if (s->tagArgsLeft () >= 1)
  			  {
  			    hue = s->getArgHue ();
  			    //                 DBT("textr hue %d\n",hue);
  			  }
  
  			//DBT("TextR <|%s|> %f %f %d %d hue %d\n",txt,x,y,pos,rotate,hue);
  
  			wgm.winText (x, y, pos, txt, rotate, TEXT_CF_CLIP_WA,
  				     hue);
  		      }
  		  }
  	      }
  
  	      break;
  
  
  	    case GWM_WOPRINT:
  	      {
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    char *txt = s->makeStrFromArg ();
  
  		    if (txt != NULL)
  		      {
  			GS_WOPRINT (woid.wid, woid.won, txt);
  		      }
  		  }
  	      }
  
  	      break;
  
  
  	    case GWM_SWOSYMANG:
  	      if (s->tagArgsLeft () >= 1)
  		{
  		  int ang = s->GetArgI ();
  		  wgm.setWpnum (ang, GWM_SWOSYMANG);
  		}
  	      break;
  
  
  	    case GWM_WOBORDER:
  	      {
  		int chue = -1;
  
  		//DBT("WOBORDER\n");
  
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    chue = s->getArgHue ();
  		    //              DBT("hue %d\n",chue);
  		  }
  
  		wgm.setWpnum (chue, GWM_WOBORDER);
  	      }
  
  	      break;
  
  	    case GWM_WOCLIPBORDER:
  
  	      {
  		int chue = BLACK;
  
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    chue = s->getArgHue ();
  		  }
  
  		wgm.setWpnum (chue, GWM_WOCLIPBORDER);
  	      }
  
  
  	      break;
  
  	    case GWM_WOSHOWPIXMAP:
  	      {
  		wgm.setWpnum (1, GWM_WOSHOWPIXMAP);
  	      }
  	      break;
  
  	    case GWM_WOPIXMAPON:
  	      wgm.setWoAttr (1, WO_PIXMAPDRAW);
  	      break;
  	    case GWM_WOPIXMAPOFF:
  	      wgm.setWoAttr (0, WO_PIXMAPDRAW);
  	      break;
  
  	      
  	    case GWM_WOCLEARPIXMAP:
  	      {
  		wgm.setWpnum (1, GWM_WOCLEARPIXMAP);
  	      }
  	      break;
  
  	    case GWM_WOCLEAR:
  	      {
  		int hue = -1;
  
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    hue = s->getArgHue ();
  		    //DBT("clearing %d with hue %d\n",woid.woid,hue);
  		  }
  		wgm.setWpnum (hue, GWM_WOCLEAR);
  	      }
  	      break;
  
  	    case GWM_WOCLEARCLIP:
  	      {
  		int hue = -1;
  		if (s->tagArgsLeft () >= 1)
  		  hue = s->getArgHue ();
  		wgm.setWpnum (hue, GWM_WOCLEARCLIP);
  	      }
  	      break;
  
  	    case GWM_WOSAVE:
  	      wgm.setWpnum (1, GWM_WOSAVE);
  	      break;
  
  	    case GWM_WOSAVEPIXMAP:
  	      {
  		//DBT("saving pixmap %d\n",woid.woid);
  		wgm.setWpnum (1, GWM_WOSAVEPIXMAP);
  	      }
  	      break;
  
  	    case GWM_SWORESIZE:
  	      {
  		int na;
  		int rfp = 0;	// fractional 0, pixel offset 1, real scales 2, grid pos 3
  
  		if ((na = s->tagArgsLeft ()) >= 4)
  		  {
  
  		    float Rx = s->GetArgF ();
  		    float Ry = s->GetArgF ();
  		    float RX = s->GetArgF ();
  		    float RY = s->GetArgF ();
  
  		    if (na == 5)
  		      rfp = s->getArgI ();	// fraction of window , area via scales of window, or pixel 
  		    //DBT("GWM_SWORESIZE\n");
  		    wgm.setWOP (GWM_SWORESIZE, rfp, Rx, Ry, RX, RY);
  
  		  }
  	      }
  	      break;
  
  	    case GWM_SWOSYMBOL:
  	      {
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    set_symbol (woid, s);
  		  }
  	      }
  	      break;
  
  	    case GWM_SWOSYMSIZE:
  
  	      if (s->tagArgsLeft () >= 1)
  		{
  		  int size = s->GetArgI ();
  		  wgm.setWpnum (size, GWM_SWOSYMSIZE);
  		}
  
  	      break;
  
  
  
  	    case GWM_SWOGRID:
  	      {
  		int nr = 10;
                  int nc = 10;
  
  		if (s->tagArgsLeft () >= 1) {
  		   nr = s->getArgI();
                     nr = (nr < 1) ? 1:nr;
                  }
  	        if (s->tagArgsLeft () >= 1) {
  		   nc =  s->getArgI();
                     nc = (nc < 1) ? 1:nc;
                  }
                  //DBT("option %d nr %d nc %d \n",wo_option,nr,nc);
  
                  wgm.setIvec(nr,nc);  // grid as num rows, num cols within the wo CR
                  wgm.setWOP(wo_option,0,0,2);
                }
  	      break;
  
  
  
  	    case GWM_SWOHELP:
  	      if (s->tagArgsLeft () >= 1)
  		wgm.setWOTxtField (s->getArgStr (), GWM_SWOHELP);
  	      break;
  
  
  	    case GWM_SWOFONT:
  	      if (s->tagArgsLeft () >= 1)
  		{
  		  int font = 2;
  		  if (s->checkArgStr ())
  		    {
  		      char *fontname = s->getArgStr ();
  		      font = FontNameToNumber (fontname);
                        //DBT("picked %s %d\n",fontname,font);
  		    }
  		  else {
  		    font = s->GetArgI ();
                    }
  		  
  		  wgm.setWpnum (font, GWM_SWOFONT);
  		}
  	      break;
  
  	    case GWM_SWOCSV:
  	      {
  		int wa = 0;
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    char *csv = s->makeStrFromArg ();
  		    if (csv != NULL)
  		      {
  			if (s->tagArgsLeft () >= 1)
  			  wa = s->getArgI ();
  
  			GS_SWOCsv (woid.wid, woid.won, csv, wa);
  		      }
  		  }
  	      }
  	      break;
  	    case GWM_SWOLIST:
  
  	      if (s->tagArgsLeft () >= 1)
  		{
  		  wgm.setWOTxtField (s->makeStrFromArg (), GWM_SWOLIST);
  		}
  	      break;
  
  	    case GWM_SWOMSG:
  	      {
  		if (s->tagArgsLeft () >= 1)
  		  onoff = s->GetArgI ();
  		  wgm.setWoAttr (onoff, WO_MSG);
  	      }
  	      break;
  
  	    case GWM_SWOTEXT:
  	      if (s->tagArgsLeft () >= 1) {
  		wgm.setWOTxtField (s->getArgStr (), GWM_SWOTEXT);
                }
  	      break;
  
  	    case GWM_SWOMENU:
  	      if (s->tagArgsLeft () >= 1)
  		wgm.setWOTxtField (s->getArgStr (), GWM_SWOMENU);
  	      break;
  
  	    case GWM_WOREDRAW:
  	      
  	      wgm.sendGWMcmd (GWM_WOREDRAW);
  	      break;
  
  
  	    case GWM_WOXOR:
  	      GS_woxor (woid.wid, woid.won, -1);
  	      break;
  	    case GWM_WDRAWON:
  	      wgm.setWoAttr (ON, WO_DRAW);
  	      break;
  	    case GWM_WDRAWOFF:
  	      wgm.setWoAttr (OFF, WO_DRAW);
  	      break;
  
  	    case GWM_WOLINE:
  	      {
  		int phue = -1;	// use existing 
  
  		if (s->tagArgsLeft () >= 4)
  		  {
  
  		    float x = s->GetArgF ();
  		    float y = s->GetArgF ();
  		    float X = s->GetArgF ();
  		    float Y = s->GetArgF ();
  
  		    if (s->AnotherArgVal ()) {
  		      phue = s->getArgHue ();
                      }
  		    
  		    GS_woline (woid.wid, woid.won, phue, x, y, X, Y);
  		  }
  	      }
  	      break;
  
  
  	    case GWM_SWORS:
  	      {
  		if (s->tagArgsLeft () >= 4)
  		  {
  		    float RBV[4];
  		    if (getRect (s, RBV))
  		      {
  			// DBT("setscales wid %d won %d %f %f %f %f \n",wgm.getWid(), wgm.getWon(), RBV[0], RBV[1], RBV[2], RBV[3]);
  			wgm.setWRS (SET_LHB_SCALES, RBV[0], RBV[1], RBV[2],
  				    RBV[3]);
  		      }
  		  }
  
  	      }
  	      break;
  
  	    case GWM_WSAVESCALES:
  	      if (s->tagArgsLeft () >= 1)
  		wgm.setWOP (GWM_WSAVESCALES, s->GetArgI ());
  	      break;
  	    case GWM_WUSESCALES:
  	      if (s->tagArgsLeft () >= 1)
  		wgm.setWOP (GWM_WUSESCALES, s->GetArgI ());
  
  	      break;
  
  	    case GWM_RHTSCALES:
  	      {
  		if (s->ArgsLeft () >= 4)
  		  {
  		    float Rx = s->GetArgF ();
  		    float Ry = s->GetArgF ();
  		    float RX = s->GetArgF ();
  		    float RY = s->GetArgF ();
  		    //DBT("  RHTscales %f %f %f %f  \n", Rx, Ry, RX, RY);
  
  		    wgm.setWRS (SET_RHT_SCALES, Rx, Ry, RX, RY);
  		  }
  	      }
  	      break;
  
  	    case GWM_LHBSCALES:
  	      {
  		if (s->ArgsLeft () >= 4)
  		  {
  		    float Rx = s->GetArgF ();
  		    float Ry = s->GetArgF ();
  		    float RX = s->GetArgF ();
  		    float RY = s->GetArgF ();
  		    //DBT("  RHTscales %f %f %f %f  \n", Rx, Ry, RX, RY);
  
  		    wgm.setWRS (SET_LHB_SCALES, Rx, Ry, RX, RY);
  		  }
  	      }
  	      break;
  
  	    case GWM_SWORXS:
  	      {
  		if (s->ArgsLeft () >= 2)
  		  {
  		    float Rx = s->GetArgF ();
  		    float RX = s->GetArgF ();
  		    //DBT("  RHTscales %f %f %f %f  \n", Rx, Ry, RX, RY);
  
  		    wgm.setWRS (SET_XB_SCALES, Rx, 0, RX, 0);
  		  }
  	      }
  	      break;
  	    case GWM_SWORYS:
  	      {
  		if (s->ArgsLeft () >= 2)
  		  {
  		    float Ry = s->GetArgF ();
  		    float RY = s->GetArgF ();
  
  		    wgm.setWRS (SET_LY_SCALES, 0, Ry, 0, RY);
  		  }
  	      }
  	      break;
  
  	    case GWM_AXNUM:
  	      {
  		// want a default option for this -- let ASL/GWM work out best format
  
  		float axp = 0.0;
  		int set_axp = -1;
  		float x = 0.0;
  		float X = 0.0;
  		float dx = 1.0;
  		float minor_dx = 0.5;
  		float pw = 0.5;
  		char *fmt = "g";
  
  		if (s->tagArgsLeft () >= 1)
  		  {
  		    int axis = s->GetArgI ();
  		    if (s->tagArgsLeft () >= 1)
  		      {
  			x = s->GetArgF ();
  			axp = x;	// short form
  			set_axp++;	// mode now 0 -- we have supplied some parameters beside which axis
  		      }
  
  		    if (s->tagArgsLeft () >= 1)
  		      {
  			X = s->GetArgF ();
  			set_axp++;
  		      }
  
  		    if (s->tagArgsLeft () >= 1)
  		      {
  			dx = s->GetArgF ();
  			minor_dx = dx;
  			set_axp++;
  		      }
  
  		    if (s->tagArgsLeft () >= 1)
  		      {
  			pw = s->GetArgF ();
  			set_axp++;
  		      }
  
  		    if (s->tagArgsLeft () >= 1)
  		      {
  			fmt = s->getArgStr ();
  			set_axp++;
  		      }
  
  		    if (s->tagArgsLeft () >= 1)
  		      {
  
  			minor_dx = s->GetArgF ();
  			set_axp++;
  		      }
  
  		    if (s->tagArgsLeft () >= 1)
  		      {
  
  			axp = s->GetArgF ();
  			set_axp = 10;
  		      }
  
  		    GS_axnum (woid.woid, axis, x, X, dx, minor_dx, pw, fmt,
  			      set_axp, axp);
  		  }
  	      }
  	      break;
  
  	    case GWM_WOMOVE:
  	      {
  		
  		if (s->tagArgsLeft () >= 2)
  		  {
  		    int rmove = 0;
  		    int parent_woid = 0;
  		    float rx = s->GetArgF ();
  		    float ry = s->GetArgF ();
  		    // rel_or_abs
  
  		    if (s->tagArgsLeft () >= 1)
  		      parent_woid = s->getArgI ();
  		    
  		    if (s->tagArgsLeft () >= 1)
  		      rmove = s->getArgI ();
  		    // dbp("p_woid %d rmove %d\n",parent_woid,rmove);
  		    GS_WOMOVE (woid.wid, woid.won, rx, ry, rmove, parent_woid);
  		  }
  	      }
  	      break;
  	    case GWM_SWOMOVE:
  	      if (s->tagArgsLeft () >= 1) {
  		dbp("move atrr set \n");
  		wgm.setWoAttr (s->GetArgI (), WO_MOVE);
  	      }
  	      break;
  	    case GWM_SWOVMOVE:
  	      if (s->tagArgsLeft () >= 1)
  		wgm.setWoAttr (s->GetArgI (), WO_VMOVE);
  	      break;	      
  
  	    case GWM_SWOHMOVE:
  	      if (s->tagArgsLeft () >= 1)
  		wgm.setWoAttr (s->GetArgI (), WO_HMOVE);
  	      break;
  		    
  	    case GWM_WOVISIBLE:
  	      wgm.sendGWMcmd (GWM_WOVISIBLE);
  	      break;
  
  	    case GWM_WOHIDE:
  	      wgm.sendGWMcmd (GWM_WOHIDE);
  	      break;
  
  	    case GWM_WOUPDATE:
  	      wgm.sendGWMcmd (GWM_WOUPDATE);
  	      break;
  
  	    case GWM_WOSCROLLCLIP:
  	      if (s->tagArgsLeft () >= 2)
  		{
  		  int dir = s->GetArgI ();
  		  int npixs = s->GetArgI ();
  		  GS_woscrollclip (woid.wid, woid.won, dir, npixs);
  		}
  	      break;
  	    case GWM_SYMBOL:
  	      {
  		if (s->tagArgsLeft () >= 3)
  		  {
  		    plot_symbol (s, woid, 1);
  		  }
  		else if (s->tagArgsLeft () == 1)
  		  set_symbol (woid, s);
  	      }
  	      break;
  	    case GWM_KEYGLINE:
  	      if (s->tagArgsLeft () >= 1)
  		wokeygline (s, woid);
  
  	      break;
  	    case GWM_SWOHILITE:
  	      {
  		int onoff = 1;
  		if (s->tagArgsLeft () >= 1)
  		  onoff = s->GetArgI ();
  		wgm.setWoAttr (onoff, WO_HILITE);
  	      }
  	      break;
  	    case GWM_SWOBELL:
  	      {
  		// this should ring bell - a transient event (spec in msec?)
  		wgm.setWoAttr (1, WO_BELL);
  		// then off
  	      }
  
  	      break;
  	    default:
  	      break;
  
  	    }
  	}
  	}
        else if ((!isatag || (isatag && wo_option == -1)) && tag != NULL)
  	{
  	  // not tag-value -- or tag not coded yet
  	  // DBT("old_style tag %s  args_left %d\n",tag, s->tagArgsLeft ());
  	  // OLD STYLE --- "tag","value",0,1,... series of values
  
  	  if (strcasecmp (tag, "setmovelimits") == 0)
  	    {
  	      // should fraction of whole window -- can't go into TITLE
  	      // out side borders
  
  	      if (s->tagArgsLeft () >= 4)
  		{
  
  		  float Px = s->GetArgF ();
  		  float Py = s->GetArgF ();
  		  float PX = s->GetArgF ();
  		  float PY = s->GetArgF ();
  
  		  GS_SWOML (woid.wid, woid.won, 4, Px, Py, PX, PY);
  
  		}
  	    }
  
  	  else if (strncasecmp (tag, "setkeyact", 9) == 0)
  	    {
  	      if (s->tagArgsLeft () >= 1)
  		onoff = s->GetArgI ();
  	      wgm.setWoAttr (onoff, WO_KEYACT);
  
  	    }
  	  else if (strncasecmp (tag, "setmsg", 6) == 0)
  	    {
  	      if (s->tagArgsLeft () >= 1)
  		onoff = s->GetArgI ();
  	      wgm.setWoAttr (onoff, WO_MSG);
  
  	    }
  	  else if (strncasecmp (tag, "setmod", 6) == 0)
  	    {
  	      if (s->tagArgsLeft () >= 1)
  		onoff = s->GetArgI ();
  	      wgm.setWoAttr (onoff, WO_MOD);
  
  	    }
  
  	  else if (strncasecmp (tag, "onoff", 5) == 0)
  	    {
  	      if (s->tagArgsLeft () >= 1)
  		onoff = s->GetArgI ();
  	      wgm.setWoAttr (onoff, WO_BUTTON_ONOFF);
  	    }
  
  	  else if (strcasecmp (tag, "scroll") == 0)
  	    {
  	      if (s->tagArgsLeft () >= 2)
  		{
  		  int x = s->GetArgI ();
  		  int y = s->GetArgI ();
  		  GS_woscroll (woid.wid, woid.won, x, y);
  		}
  	    }
  
  	  else if (strncasecmp (tag, "refresh", 6) == 0)
  	    {
  	        WinUpdate (woid.woid);	//-- want this if GUI change
  	    }
  	  else if (strncasecmp (tag, "plotpoint", 9) == 0)
  	    {
  	      if (s->tagArgsLeft () >= 3)
  		{
  		  float x = s->GetArgF ();
  		  float y = s->GetArgF ();
  		  int hue = s->getArgHue ();
  		  wgm.woPoint (hue, x, y, 1);
  		}
  	    }
  
  	  else if (strncasecmp (tag, "plotipoint", 10) == 0)
  	    {
  	      if (s->tagArgsLeft () >= 3)
  		{
  		  int x = s->GetArgI ();
  		  int y = s->GetArgI ();
  		  int hue = s->getArgHue ();
  		  wgm.woPoint (hue, (float) x, (float) y, 0);
  		}
  	    }
  	  else if (strncasecmp (tag, "plotilines", 10) == 0)
  	    {
  	      if (s->tagArgsLeft () >= 1)
  		{
  		  Siv *sivp = s->getArrayArg (SHORT);
  		  if (sivp != NULL)
  		    {
  		      short *xyv = (short *) sivp->Memp ();
  		      GS_vxylt (woid.wid, woid.won, xyv, sivp->size / 2);
  		    }
  		}
  	    }
  	  else if (strncasecmp (tag, "plotlines", 9) == 0)
  	    {
  	      if (s->tagArgsLeft () >= 1)
  		{
  		  Siv *sivp = s->getArrayArg (FLOAT);
  		  if (sivp != NULL)
  		    {
  		      float *xyv = (float *) sivp->Memp ();
  		      wgm.setWOP (GWM_VXYRLT, 0, xyv, sivp->size, wgm.ivec,
  				  0);
  		    }
  		}
  	    }
  	}
        
        args_left =s->AnotherArg ();
        if (args_left == 0) {
  
  	break;
        }
      }
    }
  
    catch (asl_error_codes ball) {
  
    }
    
    gflush ();
    return ok;
  }
  
  //[EF]===================================================//
  
  int Wopsf::woset(Svarg * s)
  {
    if (!checkAslOption(ASL_USE_GWM)) 
      return s->result->Store (0);
  
    Woid woid (0);
  
    int i = 0;
    Siv *sivp = s->getArgSiv ();
  
    if (sivp != NULL)
      {
        DBPF(" sivp %s type %d \n",sivp->getName(), sivp->getType());
  
        if (sivp->isArray (INT))
  	{
  	  int *ip = (int *) sivp->Memp ();
  
  	  for (int j = 0; j < sivp->getSize (); j++)
  	    {
  	      // work out woid and call
  	      woid.setWid (ip[j]);
  
  	      DBPF 
  		    ("%d %d wid %d won %d\n", j, ip[j], woid.wid, woid.won);
  
  	      i = SetWO (woid, s, j);
  
  	      s->SetArgIndex (1);	// reset args
  
  	    }
  	}
        else
  	{
  	  s->StepBackArg ();
  
  	  int j = s->GetArgI ();
  
  	  woid.setWid (j);
  
  	  i = SetWO (woid, s, 0);
  
  	}
      }
  
    gflush ();
  
    return s->result->Store (i);
  }
  //[EF]===================================================//
  
  int zoompan (int wo_id, int wd, float pc )
  {
    Swin *swin;
  
    int i = -1;
  
     pc /= 100.0;
  
     Wgm wgm(wo_id);
  
        WinUpdate (wo_id);
  
        DBPF("wd %d pc %f wo_id %d\n",wd,pc,wo_id);
  
  	  if ((swin = GetRP (wo_id)) != NULL)
  	    {
  	      float rx = swin->rp[WRx];
  	      float ry = swin->rp[WRy];
  	      float rX= swin->rp[WRX];
  	      float rY = swin->rp[WRY];
                float xrange = fabs(rX - rx);
                float drx = pc * xrange;
  	      float yrange = fabs(rY - ry);
  	      float dry = pc * yrange;
  
  	      DBPF("IN rx %f ry %f Rx %f RY %f\n",rx,ry,rX,rY);
  
  
              switch (wd) {
  
              case PANLEFT:
  	      rx -= drx;
  	      rX -= drx;
  	      break;
              case PANRIGHT:
  	      rx += drx;
  	      rX += drx;
                break;
              case PANUP:
  	      ry += dry;
  	      rY += dry;
                break;
              case PANDOWN:
  	      ry -= dry;
  	      rY -= dry;
                break;
              case ZOOMOUTX:
  	      rx -= drx;
  	      rX += drx;
                break;
              case ZOOMOUTY:
  	      ry -= dry;
  	      rY += dry;
                break;
              case ZOOMOUT:
  	      ry -= dry;
  	      rY += dry;
  	      rx -= drx;
  	      rX += drx;
                break;
  
              case ZOOMINX:
  	      rx += drx;
  	      rX -= drx;
                break;
              case ZOOMINY:
  	      ry += dry;
  	      rY -= dry;
                break;
              case ZOOMIN:
  	      rx += drx;
  	      rX -= drx;
  	      ry += dry;
  	      rY -= dry;
                break;
              }
  
    	    i = GS_SWRS (wo_id, 4, rx, ry, rX, rY);
  
  	    if (wd == PANLEFT || wd == PANRIGHT
                  || wd == ZOOMOUTX
                  || wd == ZOOMINX)
                wgm.setWOP(GWM_WSAVEXSCALES, -1);
  	    if (wd == PANUP || wd == PANDOWN
                  || wd == ZOOMOUTY
                  || wd == ZOOMINY)
  
                wgm.setWOP(GWM_WSAVEYSCALES, -2);
  
  	      DBPF("OUT rx %f ry %f Rx %f RY %f\n",rx,ry,rX,rY);
  	    }
  
    return i;
  
  }
  //[EF]===================================================//
  
  int
  Wopsf::panwo (Svarg * s)
  {
    int ret = 0;
    int wo_id = -1;
  
    if (s->checkGwmArgCount (3)) {
      
    if (s->checkArgType(INT)) {
  
      Siv *sivp = s->GetArgSiv ();
  
      int dir = s->getArgDir();
      float pc = s->OptionalArg((float)10.0);     
      int n = 1;
      
      if (sivp->isArray()) {
          n = sivp->getSize ();
      }
      
      // DBT("%s dir %d pc %f n %d\n",sivp->getName(),dir,pc,n);
  
            int *ip = (int *) sivp->Memp ();
  
  	  for (int j = 0; j < n; j++)
  	    {
  	      wo_id = ip[j];
  	      //        DBT("j %d wo_id %d\n",j,wo_id);
           if (dir == PANLEFT || dir == PANRIGHT || dir == PANUP || dir == PANDOWN) {
                         zoompan(wo_id,dir,pc);
  	      ret = 1;
  	      }
      
  	    }
           }
    }
    
  
    return s->result->Store(ret);
  }
  //[EF]===================================================//
  
  int
  Wopsf::zoomwo (Svarg * s)
  {
    int ret = 0;
    int wo_id = -1;
  
    
    if (s->checkGwmArgCount (3)) {
      
    if (s->checkArgType(INT)) {
  
      Siv *sivp = s->GetArgSiv ();
  
      int dir = s->getArgDir();
      float pc = s->OptionalArg((float)10.0);     
      int n = 1;
      
      if (sivp->isArray()) {
          n = sivp->getSize ();
      }
  
      int *ip = (int *) sivp->Memp ();
  
  	  for (int j = 0; j < n; j++)
  	    {
  	      wo_id = ip[j];
                if (dir == ZOOMIN || dir == ZOOMOUT) {
                zoompan(wo_id,dir,pc);
  	      ret = 1;
  	      }
      
  	    }
       }
    }
    
    return s->result->Store(ret);
  }
  //[EF]===================================================//
  
  
  int
  Wopsf::wosetrs (Svarg * s)
  {
    int i;
    int  nu = 0;
    float val;
    float Rx, Ry, RX, RY;
    i = 0;
  
    if (!s->checkGwmArgCount (3)) 
        return s->result->Store(0);
  
  
    Rx = Ry = RX = RY = 0.0;
  
    //Woid wow (s->GetArgI ());
    Wgm wgm(s->GetArgI ());
  
    if (s->sarg.argc == 3)
      {
        nu = s->GetArgI ();
        val = s->GetArgF ();
  
        switch (nu)
  	{
  	case 0:
  	  Rx = val;
  	  break;
  	case 1:
  	  Ry = val;
  	  break;
  	case 2:
  	  RX = val;
  	  break;
  	case 3:
  	  RY = val;
  	  break;
  	}
      }
    else if (s->sarg.argc >= 5)
      {
        nu = 4;
        Rx = s->GetArgF ();
        Ry = s->GetArgF ();
        RX = s->GetArgF ();
        RY = s->GetArgF ();
      }
  
    wgm.setWRS(nu, Rx, Ry, RX, RY);
  
    return s->result->Store( 1);
  }
  //[EF]===================================================//
  
  
  int
  pw_hash (const char *name, int fw)
  {
    int hash, hash1, hash2;
    int step = 13;
    //   int   max = MAXNAMELEN;
    char *ptr;
    char vname[MAXNAMELEN];
    //int klooks = 0;
    int k = 0;
  
    hash = hash1 = hash2 = 0;
    
    checkscpy (vname, name, MAXNAMELEN - 1);
  
    eat_white_tail (vname);
  
    ptr = vname;
  
    for (; *ptr != '\0';)
      {
        hash1 += *ptr++;
      }
  
    ptr = vname;
    k = 0;
    for (; *ptr != '\0';)
      {
        hash2 ^= (*ptr << k++);
        ptr++;
        if (k > 8)
  	k = 0;
      }
  
    hash = ((hash1 + hash2) % MAX_PW);
  
    while (1)
      {
  
        if (!strncmp (name, pwob_table[hash].name, MAXPWNAME)
  	  || pwob_table[hash].pw == -1)
  	{
  
  	  if (fw > -1)
  	    {
  	      checkscpy (pwob_table[hash].name, name, MAXPWNAME);
  	      pwob_table[hash].pw = fw;
  	    }
  	  break;
  	}
  
        hash += step;
        if (hash > MAX_PW - 1)
  	hash -= (MAX_PW - 1);
      }
  
    return (pwob_table[hash].pw);
  }
  //[EF]===================================================//
  
  int
  findWoOption (char *tag)
  {
    char pwname[MAXNAMELEN];
    
    StrNCopy (pwname, tag, MAXNAMELEN);
    eat_white_tail(pwname);   // remove any trailing WS
    //  char *ptr = pwname;
    gs_toupper (pwname);    // UC it
    int woc = pw_hash (pwname, -1);   // look up option
    if (woc == -1) {
      dbwarning (" tag not valid Wo option <|%s|>\n",tag);
    }
    return woc;
  }
  //[EF]===================================================//
  
  
 
