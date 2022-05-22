/* 
 *  @script graphic_glide.asl 
 * 
 *  @comment task-planner library 
 *  @release CARBON 
 *  @vers 4.3 Li 6.3.83 C-Li-Bi 
 *  @date 02/16/2022 09:34:44          
 *  @cdate 9/17/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                     


///
///  all the graphic interface  - xgs
///
//<<"including graphic_glide $_include\n"
  int Init = 1;
  float zoom_begin = 0;
  float zoom_end =  200;
  float MSE[32];

  void screen_print()
  {
// make it monochrome

  ff=open_laser("st.ps");

  scr_laser(vp);

  nc = get_colors();

  set_colors(2);

  DrawMap(mapwo);

  drawTask(mapwo,RED_);

  laser_scr(vp);

  close_laser();

  set_colors(nc);

  }
//==================================================

  void read_task()
  {
  int query = 1;
  Svar wval;

  if (query)

  task_file = navi_w("TASK_File","task file?",task_file,".tsk","TASKS");

  TF= ofr(task_file);
  //<<"$task_file  $TF \n";

  if (TF != -1) {

  ti = 0;

  seterrornum(0);

  for (k = 0 ; k < Maxtaskpts ; k++) {

  sWo(tpwo[k],_WVALUE,"");
          //sWo (ltpwo[k],_WVALUE,"0")

  }

  nwr = wval.ReadWords(TF);

  TT = wval[0];

  if ( !(TT == ""))  sWo(TASK_wo,_WVALUE,TT)

  ti = 0;

  while (1) {

  nwr = wval.ReadWords(TF);

  atpt = wval[0];

  err = f_error(TF);
//<<"$nwr <|$atpt|> $err\n"

  if ( nwr <= 0) {

  break;

  }
//DBG"TP $atpt $ti \n"
        //  key[ti] = atpt
        //  wi = find_key(key[ti])

  woSetValue (tpwo[ti], atpt);

  ti++;

  if (ti > LastTP)

  break;

  }

  c_file(TF);

  }
    //<<"DONE $_proc\n"

  }
//==================================================

  void readTaskFile(Str taskfile)
  {
  Svar wval;

  TF= ofr(taskfile);
  //<<"%V $taskfile  $TF $SetWoT \n";

  ans=query("$TF read $taskfile ? ");

  if (TF != -1) {

  ti = 0;

  seterrornum(0);

  for (k = 0 ; k < Maxtaskpts ; k++) {

  sWo(tpwo[k],_WVALUE,"");
          //sWo (ltpwo[k],_WVALUE,"0")

  }

  nwr = wval.ReadWords(TF);

  TT = wval[0];

  if ( !(TT == "")) {

  sWo(TASK_wo,_WVALUE,TT);

  }

  ti = 0;

  while (1) {

  nwr = wval.ReadWords(TF);

  atpt = wval[0];

  err = f_error(TF);
//<<"$nwr <|$atpt|> $err\n"

  if ( nwr <= 0) {

  break;

  }
//DBG"TP $atpt $ti \n"
        //  key[ti] = atpt
        //  wi = find_key(key[ti])

  woSetValue (tpwo[ti], atpt);

  ti++;

  if (ti > LastTP)

  break;

  }

  cf(TF);

  }
    //<<"DONE $_proc\n"

  }
//==================================================

  void write_task()
  {

  tsk_file = "K_1.tsk";

  tsk_file=query_w("DATA_FILE","write to file:",tsk_file);

  if (tsk_file == "")       return

  val = getWoValue(TASK_wo);

  tsk_file = scat("TASKS/",tsk_file,".tsk");

  WF=ofw(tsk_file);

  w_file(WF,"type $val  %6.3f $totalK \n");

  for (i = 0 ; i <  Ntaskpts; i++) {

  w_file(WF,"$Wleg[i].Place  %6.0f $Wleg[i].msl  $Wleg[i].fga \n");

  }

  c_file(WF);

  }
//==================================================

  void set_task()
  {
  //chk_start_finish()
  //set_wo_task(tw)
  //total = taskDist()

  drawTask(mapwo,RED_);
 // tot_units = scat(total,Units)

  }
//==================================================

void drawTrace()
{
     if (Have_igc) {
         sWo(mapwo,_WSCALES, wbox(LongW, LatS, LongE, LatN),_WEO );
	 
        // sWo(mapwo,_WCLEARPIXMAP);
         sWo(vvwo,_WCLEARPIXMAP);


         
          //DrawMap(mapwo);
	  
  	 if (Ntpts > 0) {
            sWo(vvwo, _WSCALES, wbox(0, Min_ele, Ntpts, Max_ele + 500),_WEO )
              dGl(igc_tgl);
	    sWo(vvwo,_WCLEARPIXMAP);
	      dGl(igc_vgl);
            sWo(mapwo,_WSHOWPIXMAP,_WCLIPBORDER);
            sWo(vvwo,_WSHOWPIXMAP,_WCLIPBORDER);
<<"%V $Ev_button $lc_gl $rc_gl  \n"
  CR_init = 1;
  CL_init = 1;

if (lc_gl != -1) {
	  sGl(lc_gl,_GLCURSOR,rbox(zoom_begin,0,zoom_begin,20000, CL_init),_GLHUE,GREEN_,_GLEO); // use rbox
   dGl(lc_gl);
}

if (rc_gl != -1) {
	  sGl(rc_gl,_GLCURSOR,rbox(zoom_end,0,zoom_end,20000, CR_init),_GLHUE,RED_,_GLEO);
   dGl(rc_gl);
}

 <<"%V $zoom_begin $zoom_end\n"
	 }
	sWo(mapwo,_WSHOWPIXMAP,_WCLIPBORDER);
  CR_init = 0;
  CL_init = 0;
      }
}

//==================================================

void drawAlt()
{
     if (Have_igc) {
         
         sWo(vvwo,_WCLEARPIXMAP);

	  
  	 if (Ntpts > 0) {
            sWo(vvwo, _WSCALES, wbox(0, Min_ele, Ntpts, Max_ele + 500),_WEO )
	    sWo(vvwo,_WCLEARPIXMAP);
	      dGl(igc_vgl);
            sWo(vvwo,_WSHOWPIXMAP,_WCLIPBORDER);
<<"%V $Ev_button $lc_gl $rc_gl  \n"
  CR_init = 1;
  CL_init = 1;

if (lc_gl != -1) {
	  sGl(lc_gl,_GLCURSOR,rbox(zoom_begin,0,zoom_begin,20000, CL_init),_GLHUE,GREEN_,_GLEO); // use rbox
   dGl(lc_gl);
}

if (rc_gl != -1) {
	  sGl(rc_gl,_GLCURSOR,rbox(zoom_end,0,zoom_end,20000, CR_init),_GLHUE,RED_,_GLEO);
   dGl(rc_gl);
}

 <<"%V $zoom_begin $zoom_end\n"
	 }
  CR_init = 0;
  CL_init = 0;
      }
}

//==================================================

  void gg_gridLabel(int wid)
  {

  ts = 0.01;
# incr should set format

  float rx;

  float ry;

  float rX;

  float rY;

  sWo(wid,_WPENHUE,BLACK_);

  RS= wgetrscales(wid);

<<"%V $wid $RS \n"

  rx= RS[1];

  ry= RS[2];

  rX= RS[3];

  rY= RS[4];

<<"%V $rx $ry $rX $rY\n"
if (ry == -1.0) {
ans=query("bad ry\n");
}
  putMem("LongW","$rx",1);

  putMem("LongE","$rX",1);

  putMem("LatS","$ry",1);

  putMem("LatN","$rY",1);

  dx = (rX - rx );

  dy = (rY - ry );
//DBG"%V $dx $dy\n"

  x_inc = getIncr ( dx);

  y_inc = getIncr ( dy);
//DBG"%V $x_inc $y_inc \n"  

  x_inc = 0.1;

  y_inc = 0.1;
//DBG"%V $x_inc $y_inc \n"

  if (x_inc != 0.0 ) {
     // ticks(wid,1,rx,rX,x_inc,ts)

  if (x_inc >= 0.01) {

  axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f");

  }

  else {

  axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f");

  }

  }

  if ( y_inc != 0.0) {
      //ticks(wid,2,ry,rY,y_inc,ts)

  axnum(wid,2,ry,rY,2*y_inc,-2.0,"2.1f");

  }

  sWo(wid,_WCLIPBORDER);

  }
//==================================================

  void magnify(int w_num)
  {

  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY);

  drx = (rX - rx)/4.0;

  dry = (rY - ry)/4.0;

  R[0] = rx +drx;

  R[1] = ry +dry;

  R[2] = rX -drx;

  R[3] = rY -dry;

  ff=show_curs(1,-1,-1,"resize");

  aw=select_real(w_num,&R[0]);

  ff=show_curs(1,-1,-1,"curs_font");

  if (aw != -1) {

  xr0 = R[0];

  xr1 = R[2];

  yr0 = R[1];

  yr1 = R[3];

  xr = xr1-xr0;

  set_w_rs(w_num,xr0,yr0,xr1,yr1);

  w_clip_clear(w_num);

  ff=w_redraw_wo(w_num);

  x0 = 0;

  }

  w_store(w_num);

  }
//==================================================

  void new_units()
  {

  Units = choice_menu("Units.m");
  }
//==================================================

  void new_coors(int w_num)
  {
#  par_menu = "cfi/tcoors.m"

  par_menu = "tcoors.m";

  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY);

  set_menu_value(par_menu,"x0",rx);

  set_menu_value(par_menu,"x1",rX);

  set_menu_value(par_menu,"y1",rY);

  set_menu_value(par_menu,"y0",ry);

  value = table_menu(par_menu);

  if ( value == 1 ) {

  xr0= get_menu_value(par_menu,"x0");

  xr1= get_menu_value(par_menu,"x1");

  yr1= get_menu_value(par_menu,"y1");

  yr0= get_menu_value(par_menu,"y0");

  xr = xr1-xr0;

  ff=set_w_rs(w_num,xr0,yr0,xr1,yr1);

  ff=w_clip_clear(w_num);

  ff=w_redraw_wo(w_num);

  x0 = 0;

  DrawMap(w_num);
   drawTask(w_num,BLACK_);
  }

  }
//==================================================

  void gg_zoomToTask(int w_num, int draw)
  {
 // this needs to find rectangle - just bigger than task
  // found via computetaskdistance
<<"$_proc   $w_num \n";

  ff=sWo(w_num,_WSCALES,wbox(Max_W,Min_lat,Min_W,Max_lat),_WEO);

  if (draw) {

  gflush();

  DrawMap(w_num);

  drawTask(w_num,BLACK_);
//  sWo(w_num,_Wshowpixmap)

  }

  }
//==================================================

  void zoom_up(int w_num)
  {

  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY);

  dy = Fabs(ry-rY)/4;

  ry += dy;

  rY += dy;

  ff=set_w_rs(w_num,rx,ry,rX,rY);

  ff=w_clip_clear(w_num);
#  ff=w_redraw_wo(w_num)

  DrawMap(w_num);

  drawTask(w_num,RED_);

  }
//==================================================

  void zoom_in(int w_num)
  {

  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY);

  dx = Fabs(rx-rX)/4;

  dy = Fabs(ry-rY)/4;

  rx -= dx;

  rX += dx;

  ry += dy;

  rY -= dy;

  ff=set_w_rs(w_num,rx,ry,rX,rY);

  ff=w_clip_clear(w_num);

  ff=w_redraw_wo(w_num);

  DrawMap(w_num);

  drawTask(w_num,RED_);

  }
//==================================================

  void  draw_the_task ()
  {

  DrawMap(tw);

 // drawTask(tw,RED_);
  }
//==================================================

  void zoom_out(int w_num,int draw)
  {

  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY);

  dx = Fabs(rx-rX)/4;

  dy = Fabs(ry-rY)/4;

  rx += dx;

  rX -= dx;

  ry -= dy;

  rY += dy;

  ff=set_w_rs(w_num,rx,ry,rX,rY);

  if (draw) {

  draw_the_task();

  }

  }
//==================================================

  void zoom_rt(int w_num)
  {

  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY);

  dx = Fabs(rx-rX)/4;

  dy = Fabs(ry-rY)/4;

  rX -= dx;

  rx -= dx;

  set_w_rs(w_num,rx,ry,rX,rY);

 w_clip_clear(w_num);

  ff=w_redraw_wo(w_num);

  DrawMap(w_num);

  drawTask(w_num,RED_);

  }
//======================================//

  void zoom_lt(int w_num)
  {

  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY);

  dx = Fabs(rx-rX)/4;

  dy = Fabs(ry-rY)/4;

  rX += dx;

  rx += dx;

  ff=set_w_rs(w_num,rx,ry,rX,rY);

  ff=w_clip_clear(w_num);

  ff=w_redraw_wo(w_num);

  DrawMap(w_num);

  drawTask(w_num,RED_);

  }
//======================================//

  void reset_map()
  {

  

  DrawMap(mapwo);
 drawTask(mapwo,GREEN_);

}
//======================================//

 void replace_tp(int wt)
  {
/// click on tpwo
//wt = Witp;
  Str tval;
  
    woSetValue (tpwo[wt],"XXX");

  sWo(tpwo[wt],_WREDRAW);

  MouseCursor("hand", tpwo[9], 0.5, 0.5);

    emsg =gev.eventWait();
    ekey = gev.getEventKey(
  
    gev.geteventrxy( &erx,&ery);
  //eventWait();

  ntp = ClosestTP(erx,ery);
//ans=query("%V$erx $ery $ntp\n");   
 <<"%V $erx $ery $ntp\n";

  if (ntp >= 0) {

  Wtp[ntp].Print();

  nval = Wtp[ntp].GetPlace();
//<<" found %V $ntp $nval \n"
             //woSetValue (tpwo[wt],ntp,1)

  woSetValue (tpwo[wt],nval,0);

  Taskpts[wt] = ntp;
          //  ret = ntp;

  Task_update = 1;

  MouseCursor("cross", tpwo[9], 0.5, 0.5);

  sWo(tpwos,_WREDRAW);

  }


  }
//======================================//
 void insert_tp(int wt)
  {
/// click on tpwo
//wt = Witp;
  Str tval;
   LastTP =Ntaskpts ;
  if (wt < LastTP ) {

  for (i = LastTP ; i > wt ; i--) {

  tval = getWoValue(tpwo[i-1]);
  <<"$i <|$tval|>  \n"

  woSetValue (tpwo[i],tval);
  sWo(tpwo[i],_WREDRAW);
  kt = Taskpts[i-1];

  Taskpts[i] = kt;

  }

  }

  woSetValue (tpwo[wt],"XXX");

  sWo(tpwo[wt],_WREDRAW);

  MouseCursor("hand", tpwo[9], 0.5, 0.5);

    emsg =gev.eventWait();
    ekey = gev.getEventKey(
  
           gev.geteventrxy( &erx,&ery);
  //eventWait();

  ntp = ClosestTP(erx,ery);
//ans=query("%V$erx $ery $ntp\n");   
 <<"%V $erx $ery $ntp\n";
  if (ntp >= 0) {

  Wtp[ntp].Print();

  nval = Wtp[ntp].GetPlace();
//<<" found %V $ntp $nval \n"
             //woSetValue (tpwo[wt],ntp,1)

  woSetValue (tpwo[wt],nval,0);

  Taskpts[wt] = ntp;
          //  ret = ntp;

  Task_update = 1;

  MouseCursor("cross", tpwo[9], 0.5, 0.5);

  sWo(tpwos,_WREDRAW);

  }

  Ntaskpts++;


  }
//======================================//

  void insert_name_tp(int wt)
  {
/// pick a tp via name
/// insert before current selected

  Str nval;
  Str tval;
<<"$_proc  $wt\n";
 LastTP =Ntaskpts ;
  if (wt < LastTP ) {

  for (i = LastTP ; i > wt ; i--) {

  tval = getWoValue(tpwo[i-1]);
  <<"$i <|$tval|>  \n"

  woSetValue (tpwo[i],tval);

  kt = Taskpts[i-1];

  Taskpts[i] = kt;

  }

  }

  woSetValue (tpwo[wt],"?");
  sWo(tpwo[wt],_WREDRAW);

  nval = " ";

  nval=query_w("TurnPt","TP $Witp enter name:",nval);

<<"name sel:  <|$nval|> \n"

  wtp= PickTP(nval,Witp);

  aplace = Wtp[wtp].GetPlace();

  nval = RX[wtp][0];

  <<"Found %V $wtp $nval $aplace\n"

  woSetValue (tpwo[wt],nval,0);
  sWo(tpwo[wt],_WREDRAW);
  Task_update = 1;

  sWo(tpwos,_WREDRAW);

  }
//======================================//
int PickViaName(int wt)
{
<<"$_proc $wt \n";
  int wtp;
  int ok = 0;
  woSetValue (tpwo[wt],"XXX");

  Str nval = " ";

  nval=query_w("TurnPt","TP $wt enter name:",nval);

<<"name sel:  <|$nval|> \n"

  wtp= PickTP(nval,wt);
  if (wtp >0) {
  aplace = Wtp[wtp].GetPlace();

  nval = RX[wtp][0];

  <<"Found %V $wt $wtp $nval $aplace\n"
  ok = 1;
  woSetValue (tpwo[wt],aplace,0);
  }
  return ok;
}


  void delete_tp(int wt)
  {
//int wt = Witp;

  int kt = 0;

  kt = Taskpts[wt];
//              <<"$_proc delete $_ewoname $wt $Wtp[kt].Place \n"
              //<<"$_proc delete $_ewoname $wt $kt \n"

  if (wt == LastTP) {

  woSetValue (tpwo[LastTP],"");

  Taskpts[LastTP] = 0;

  }

  else {

  j= wt+1;

  for (i = wt ; i < (Ntaskpts-1) ; i++) {
                 // tval = getWoValue(tpwo[i+1])

  kt = Taskpts[i+1];

  Taskpts[i] = kt;

  if (kt == 0) {

  sWo (tpwo[j],_WVALUE," ",_WREDRAW);

  break;

  }

  plc = Wtp[kt].Place;
        // <<"del $i $kt  $plc \n"

  sWo (tpwo[i],_WVALUE,plc);

  j++;

  }
		//<<"last was $j $plc\n"

  Taskpts[j-1] = 0;

  sWo (tpwo[j-1],_WVALUE," ",_WREDRAW);

  }

  sWo(tpwos,_WREDRAW);

  Ntaskpts--;

  }
//======================================//

  void delete_alltps()
  {
# get_tp

  for (i = 0 ; i <Ntaskpts ; i++) {

  ff=woSetValue (tpwo[i],"");

  woSetValue (ltpwo[i],"0",1);

  }

  Ntaskpts = 0;

  }
//======================================//

  igc_file = "dd.igc";

  void plot_igc(int w)
  {
  
//DBG" RECODE \n";
///  replace with
///  A=ofr(igc_file)
//   readIGG(A,latv,lngv,elev)
///  drawGline (igc)
///  cf(A)
/*
   a=ofr(igc_file)
   if (a == -1) {
     DBG" can't open IGC file \n"
     return
   }

      while (1) {

                         tword=r_file(a)
//DBG"$tword \n"
                         if (f_error(a) == 6) break

			 if (sele(tword,0) == "B") {
                          igclat = sele(tword,7,8)
                          igclong = sele(tword,15,9)
                          latnum = igc_dmsd(igclat)
                          lngnum = igc_longd(igclong)
#              DBG"$igclat $latnum $igclong $lngnum\n"
                          plot_line(w,lngnum,latnum ,"blue")
			 }
 
   }
 w_store(w); 
 cf(a);
*/


  }
//==================================

  int SetWoT = 0;

  void setWoTask()
  {
  SetWoT++;
//<<"$_proc $SetWoT\n"

  phere = "$_proc";
  // taskpts are in tpwo[i] values  10 max

  Ntaskpts = 0;

  for (k = 0 ; k < Maxtaskpts ; k++) {

  tval = getWoValue(tpwo[k]);

  <<"<|$k|> <|$tval|> \n"

  if (slen(tval) > 1) {

  WH=searchRecord(RX,tval,0,0);
	  //<<"%V $k $WH\n"

  index = WH[0][0];

  if (index >=0) {

  ttp = RX[index];
	  //<<"<|$Ntaskpts|> $ttp \n" 
//          Tasktp[Ntaskpts].TPset(RF[index])

  Taskpts[k] = index;

  Ntaskpts++;

  }

  }

  }
   //<<"%V $Ntaskpts\n"

  for (k = 0; k < Ntaskpts ; k++) {

  index= Taskpts[k];

  Wtp[index].Print();

  }
//<<"DONE $phere $_proc\n"

  }
//============================

  void chk_start_finish()
  {

  lval = "";

  val= "OB";

  val = getWoValue(TASK_wo);
//<<"$_proc <|$val|> \n"

  put_mem("TT",val);

  if ((val == "TRI")) {

  val = getWoValue(start_wo);

  woSetValue (tpwo[3],val);

  woSetValue (tpwo[4],"");

  woSetValue (finish_wo,val);

  Ntaskpts = 3;

  }

  if (val == "OB") {

  val = getWoValue(start_wo);

  woSetValue (tpwo[2],val);

  woSetValue (tpwo[3],"");

  woSetValue (finish_wo,val);

  Ntaskpts = 2;

  }

  if ((val == "SO") ) {

  val = getWoValue(tpwo[1]);

  woSetValue (finish_wo,val);

  Ntaskpts = 1;

  }

  if ((val == "DL") ) {

  val = getWoValue(tpwo[2]);

  woSetValue (finish_wo,val);

  Ntaskpts = 2;

  }

  if ((val == "W") ) {

  val = getWoValue(tpwo[4]);

  woSetValue (finish_wo,val);

  Ntaskpts = 5;

  }

  if (val == "MT")  {

  Ntaskpts = 0;

  mti = 1;

  while (1) {

  val = getWoValue(tpwo[mti]);
             //<<"$val $mti \n"

  if ( (val == "") ) {

  break;

  }

  mti++;

  lval = val;

  Ntaskpts++;

  if (mti > 9)

  break;

  }
      //<<"MT lval $lval $Ntaskpts $finish_wo \n")

  woSetValue (finish_wo,lval);

  }

  }
//============================

  void task_menu(int w)
  {
//<<"$_proc   $w\n"

  ur_c=choicemenu("MENUS/task_opts.m");

  if (ur_c == "NULL_CHOICE") {

  return;

  }
//<<"chose $ur_c \n"

  if (ur_c == "zoom_to_task") {

   gg_zoomToTask(mapwo,1);

  }
  

  else  if (ur_c == "save_pic") {

  save_image(w,"task_pic");

  }

  else if (ur_c == "magnify") {

  magnify(w);

  DrawMap(w);
   drawTask (mapwo,BLACK_);
  }

  else if (ur_c == "plot_igc") {

  plot_igc(w);

  }

  else if (ur_c == "delete_all") {

  delete_alltps();

  DrawMap(w);

  }

  else if (ur_c == "coors") {

  new_coors(w);

  }

  else if (ur_c == "units") {

  new_units();

  set_task();

  }

  else if (ur_c == "set") {

  DrawMap(mapwo);

  drawTask(mapwo,RED_);

  }

  else if (ur_c == "reset") {

  reset_map();

  }

  else if (ur_c == "read_task") {

  read_task();

  setWoTask();
     // zoom_to_task(mapwo,1)
      //zoom_out(tw,0)
      //zoom_out(tw,1)

  }

  else if (ur_c == "screen_print") {

  screen_print();

  }

  else if (ur_c == "write_task") {

  write_task();

  }
/*
    else if (ur_c == "get_finish") {
    //  ff=w_show_curs(tw,1,"left_arrow")
      PickaTP()
      set_task()
    }
*/

//for (i=0; i < Ntaskpts; i++) {
//<<"$i    $Taskpts[i]  Wtp[i].Place\n"
// }

  }
//=====================================//

  void setup_legs()
  {
//<<"$_proc \n"

  /{/*;

  suk = 0;

  print("setup_legs ",wox," ",woy," ",woX," ",woY);

  tp_name = scat("PKTPT_",suk);

  gtpwo[suk]=w_set_wo(tw,WBS,tp_name,1,wogx,woy,wogX,woY);

  for (suk = 1 ; suk <= Ntp ; suk++) {

  woY = woy - ysp;

  woy = woY - ht;

  tp_name = scat("TP:",suk);

  tpwo[suk] = w_set_wo(tw,WBV,tp_name,1,wox,woy,woX,woY);

  tp_name = scat("LEG_",suk);

  ltpwo[suk]=w_set_wo(tw,WSV,tp_name,1,wolx,woy,wolX,woY);

  tp_name = scat("PKTPT_",suk);

  gtpwo[suk]=w_set_wo(tw,WBS,tp_name,1,wogx,woy,wogX,woY);

  }

  /}*/

  }
//=====================================//

  void the_menu (Str c)
  {
//<<"$_proc \n"

  if (c == "zoom_out") {

  zoom_out(tw,1);

  return;

  }

  if (c == "zoom_to_task") {

  gg_zoomToTask(tw,1);

  return;

  }

  if (c == "zoom_up") return  zoom_up(tw)

  if (c == "zoom_in") return  zoom_in(tw)

  if (c == "zoom_rt") return   zoom_rt(tw)

  if (c == "zoom_lt") return zoom_lt(tw)

  if (c == "TASK_MENU" ) {

  return  task_menu(tw);

  }

  if (c == "REDRAW" ) return

  if ( c == "TYPE" ) {

  val="";
           // l=sscan(&MS[5],&val)
            //chk_start_finish()
         //   set_wo_task(mapwo)

  total = taskDist();

  DrawMap(mapwo);

  drawTask(mapwo,BLUE_);

  return;

  }

  if ( (c == "Start:") || (strcmp(c,"TP",2) ==1) || (c == "Finish:") ) {
           // set_wo_task(tw)
            //chk_start_finish()

  total = taskDist();

  DrawMap(mapwo);

  drawTask(mapwo,RED_);

  return;

  }

  }
//=====================

  int PickaTP(int itaskp)
  {
// 
// use current lat,long to place curs
//
//<<"$_proc $itaskp\n"

  int ret = -1;

  float rx;

  float ry;

  rx = MidLong;

  ry = MidLat;

  MouseCursor("left", mapwo, rx, ry);  // TBC;

  Text(vptxt,"Pick a TP for the task ",0,0.05,1);

  sWi(vp,_Wtmsg,"Pick a TP for the task ");

  eventWait();

  gsync();

  sleep(0.2);

  ntp = ClosestTP(erx,ery);

  MouseCursor("hand");

  if (ntp >= 0) {

  Wtp[ntp].Print();

  nval = Wtp[ntp].GetPlace();
//<<" found %V $ntp $nval  $itaskp\n"

  Taskpts[itaskp] = ntp;

  ret = ntp;

  Task_update = 1;

  }

  return ret;

  }
//=============================================//

  Str TaskType = "MT";

  void drawTask(int w,int col)
  {
  <<"$_proc    $w $col\n"
  float lat1;
  float lat2;
  float lon1;
  float lon2;
  int index;
  if ( Task_update) {

  TaskDist();
  <<"$TaskType $col $Nlegs \n"

  }

//      index = Taskpts[0]
//      tpl = Wtp[index].Place;
//<<"%V$index $tpl \n"

<<" %V $Ntaskpts \n";

  if ( (TaskType == "OAR")   || (TaskType == "SO")) {

  index = Taskpts[0];

  index1 = Taskpts[1];
<<"OAR %V $index $index1\n"

  plotLine(w,Wtp[index].Longdeg,Wtp[index].Ladeg,Wtp[index1].Longdeg,Wtp[index1].Ladeg,col);

  }

  else {
  //sdb(2,"pline");
  for (i = 0 ; i < (Ntaskpts-1) ; i++ ) {


//<<"$i %V $w  $Tasktp[i].Longdeg $Tasktp[i].Ladeg $Tasktp[i+1].Longdeg $Tasktp[i+1].Ladeg $col \n "

  index = Taskpts[i];

  index1 = Taskpts[i+1];
<<"MT %V $i $index $index1\n"


// plotLine(w,Wtp[index].Longdeg,Wtp[index].Ladeg,Wtp[index1].Longdeg,Wtp[index1].Ladeg,col);
  lat1 = Wtp[index].Ladeg;

  lon1 = Wtp[index].Longdeg;

  lat2 = Wtp[index1].Ladeg;

  lon2 = Wtp[index1].Longdeg;

 //<<"%V $w $lat1 $lon1 $lat2 $lon2 $col\n"

  <<"%V $lon1  $lon2  \n"
  <<"%V $lat1  $lat2  \n"

  plotLine(w, lon1, lat1,lon2,lat2,col,_WFLUSH,_WEO);

  gflush();

  }
  if (Init) {
    MSE=getMouseEvent(); Init = 0;  // make this once only
   }

  }
//ans=query("see lines?");
 sWo(w,_WSHOWPIXMAP,_WCLIPBORDER);
//ans=query("see lines?");
  }
//=============================================

  Str Atarg="xxx";

  

  int  PickTP(Str atarg,  int wtp)
  {
///
/// 

  int ret = -1;
<<" $_proc looking for <|$atarg|>  $Atarg  $wtp\n"


  WH=searchRecord(RX,atarg,0,0);

<<"%V $WH[0][0]\n"

  index = WH[0][0];

  if (index >=0) {

  ttp = RX[index];
<<" found  $index\n"
//<<"$ttp \n"

  Taskpts[wtp] = index;

  ret =index;
  
<<" found $atarg $index $wtp $ret $ttp\n"

  }

  return ret;

  }
//=============================================

  void get_wcoors(int sw,  float rx,  float ry,float  rX,float  rY)
  {
  float rs[20];
  ww= get_w_rscales(sw,&rs[0]);

  rx= rs[0];

  ry = rs[1];

  rX= rs[2];

  rY = rs[3];

  return ww;
  }
//==================================================



  void DrawMap(int wo)
  {
  
//DBG"$_proc %V $wo\n"
// TBF include ?? code that we are running or  code that is calling?
//<<"%V $_proc  $_include \n"

  int msl;

  float lat;

  float longi;

  Str mlab;

  int is_an_airport = 0;
  int is_a_mtn = 0;
  
  sWo(mapwo,_WSCALES,wbox(LongW,LatS,LongE,LatN),_WEO);
  <<"%V $LongW $LatS $LongE $LatN \n";

  sWo(mapwo,_WCLEARPIXMAP,_WCLIPBORDER,_WEO);

 // sWo(mapwo,_WDRAWON,_WSHOWPIXMAP,_WCLIPBORDER);

  gg_gridLabel(mapwo);

//DBG"$mlab $(typeof(mlab))\n";

//<<"%V $mapwo $LongW $LatS $LongE $LatN  \n"

  int np = Ntp;

  if (np <10) {

      np =10;

  }
    ///
    ///  Wtp ref has to be compiled before readin ??  FIX
    /// 

  for (k = 1 ; k <= np ; k++) {

    is_an_airport = Wtp[k].is_airport;
        is_a_mtn = Wtp[k].is_mtn;

  mlab = Wtp[k].Place;


//<<"%V $k $mlab  $is_an_airport \n"


  if (!is_an_airport) {

  mlab = slower(mlab);

  }

  msl = Wtp[k].Alt;

//<<"$k %V $is_an_airport  $mlab $msl \n";



 // msl.pinfo();
  
 // <<"%V $k $msl  $Wtp[k].Alt \n"

  lat = Wtp[k].Ladeg;

//<<"%V $k $lat   $Wtp[k].Ladeg \n"

  longi = Wtp[k].Longdeg;

//<<"%V $k $longi  $Wtp[k].Longdeg \n"

//<<"%V $k $mlab $msl $lat $longi $Wtp[k].Ladeg   \n"

  if ( msl > 7000) {
    if (is_an_airport || is_a_mtn) {
       Text(mapwo,mlab,longi,lat,0,0,1,RED_);
	    // <<"above 7K $msl $mlab $lat $longi\n"
     }
  }

  else {

  if ( msl > 5000) {
    if (is_an_airport) {
       Text(mapwo,mlab,longi,lat,0,0,1,BLUE_);
	       // <<"above 5K $msl $mlab $lat $longi\n"
   }



  }

  else {
	    //	 <<"below 5K $msl $mlab $lat $longi\n"
   if (is_an_airport) {
     Text(mapwo,mlab,longi,lat,0,0,1,GREEN_);
   }
  }

//sWo(wo,_WSHOWPIXMAP,_WCLIPBORDER);
  }

  }

  sWo(wo,_WSHOWPIXMAP,_WCLIPBORDER,_WSAVEPIXMAP,_WEO);

  gg_gridLabel(mapwo);

  }
//====================================================

  void listTaskPts()
  {
<<"$_proc \n"

<<"%V $Ntaskpts\n"
  float lat1;
  float lat2;
  float lon1;
  float lon2;
  int index;
  int index1;
  
   int kt;
  for (i = 0 ; i < Ntaskpts ; i++) {

  kt= Taskpts[i];
  <<"taskpt $i  $kt $Taskpts[i]   \n"

  index = Taskpts[i];
  index1 = Taskpts[i+1];
  lat1 = Wtp[index].Ladeg;
  
  lon1 = Wtp[index].Longdeg;

  lat2 = Wtp[index1].Ladeg;
  
  lon2 = Wtp[index1].Longdeg;

 //<<"%V $i $index $index1 $lat1  $lat2 $lon1 $lon2 \n"
 //<<"%V $lon1  $lon2  \n"
 // <<"%V $lat1  $lat2  \n"


  if (kt <= 0) { 
     break;
   }
  }

  }
//====================================//

  void showTaskPts()
  {
<<"$_proc \n"

<<"%V $Ntaskpts\n"


   int kt;
  for (i = 0 ; i < Ntaskpts ; i++) {

  kt= Taskpts[i];
   <<"taskpt $i  $kt $Taskpts[i]   \n"

  if (kt <= 0) { 
     break;
   }
  }

  }
//====================================//

  void TaskDist()
  {
   // is there a start?
//<<"$_proc  $Ntaskpts \n"
//<<"in TaskDist  %V $_scope $_cmfnest $_proc $_pnest\n"	       

  int tindex =0;
  float kmd = 0.0;
  float ght;
  int j=0;
  
  //Taskpts.pinfo();

  totalK = 0.0;
 //<<"%V $_scope $_cmfnest $_proc \n"
  int k = 0;
  for (k= 0; k < Ntaskpts; k++) {

  tindex = Taskpts[k];
//<<"%V $k $tindex $Taskpts[k] \n";

  }

  float la1   = 1000.0;

  float lon1 = 1000.0;

  float la2   = 1000.0;

  float lon2 = 1000.0;

  float msl;

  float fga;

  Min_lat = 90.0;

  Max_lat = 0.0;

  Min_W = 109.0;

  Max_W = 105.0;

  Str tpl;

  int adjust = 0;
   // num of taskpts


//<<"%V $Ntaskpts \n"

  



  for (i = 0; i < Ntaskpts ; i++) {

  index = Taskpts[i];
 // <<"%V $i $index \n";
  index.pinfo();
  
 if ((index > 0)  && (index <= Ntp) ) {
  kmd = 0.0;

<<"pass %V $i $index $Taskpts[i] \n";

  tpl = Wtp[index].Place;

<<"%V  $tpl \n"

  la2 = Wtp[index].Ladeg;

  msl = Wtp[index].Alt;

  if (la2 > Max_lat) {

  Max_lat = la2;

  }

  if (la2 < Min_lat) {

  Min_lat = la2;

  }

  lon2 = Wtp[index].Longdeg;

  if (lon2 > Max_W) {

  Max_W = lon2;

  }

  if (lon2 < Min_W) {

  Min_W = lon2;

  }

  if (la1 != 1000.0) {

  kmd = computeGCD(la1,la2,lon1,lon2);

  }

  la1 = la2;

  lon1 = lon2;

  adjust++;

  totalK += kmd;
// add in the fga to reach this turnpt from previous
 //    Wleg.pinfo()

  Wleg[i].msl = msl;

  Wleg[i].Place = tpl;
  j = i-1;
  if (i > 0) {

//<<"%V $i  $kmd  $tpl $fga\n";

  Wleg[j].dist = kmd;

  Wleg[j].Tow = tpl;

  ght = (kmd * km_to_feet) / LoD;

  fga = ght + 1200.0 + msl;
  <<"%V$i $ght $fga $msl\n"

  Wleg[j].fga = fga;

    }
   <<"%V $i $Min_lat $Max_lat\n" 
  }

  }

  Wleg[Ntaskpts].dist = 0.0;
<<"%V $Min_lat $Min_W $Max_lat $Max_W \n"
//<<"%V $LongW $LatS $LongE $LatN   \n"

  if (adjust >=2) {

  LongW= Max_W +1.0;

  LatS = Min_lat -1;

  LongE = Min_W -1;

  LatN = Max_lat +1;

  }
//<<"%V $totalK\n"
//<<"%V $LongW $LatS $LongE $LatN   \n"

  Task_update = 1;
//<<"DONE $_proc  $totalK \n"

  }
//==============================//

  void TaskStats()
  {
 //<<"%V $_scope $_cmfnest $_proc $_pnest\n"

  float amsl = 0.0;

  for (i = 0; i < Ntaskpts ; i++) {

  amsl = Wleg[i].msl;
     //<<"Stat $i $amsl $Wleg[i].dist   $Wleg[i].fga\n"

  }

  }



  void ClosestTP (float longx, float laty)
  {
///
  float dx,dy;
  T=fineTime();

  float mintp = 30;

  int mkey = -1;

  float ctp_lat;

  int k = 3;
//DBG"%V $Wtp[0].Ladeg \n"
//DBG"%V $Wtp[k].Ladeg \n"

  ctp_lat = Wtp[k].Ladeg;
//DBG"%V $ctp_lat \n"

  for (k = 0 ; k < Ntp ; k++) {

  ctp_lat =   Wtp[k].Ladeg;

  longi = Wtp[k].Longdeg;

  dx = fabs(longx - longi);

  dy = fabs(laty - ctp_lat);

  dxy = dx + dy;

  if (dxy < mintp) {

  mkey = k;

  mintp = dxy;
//DBG"%V $Wtp[k].Ladeg $ctp_lat $longi $laty $longx  $dx $dy $Wtp[k].Place \n"

  }

  }

  if (mkey != -1) {
//DBG" found $mkey \n"

  Wtp[mkey].Print();

  }

  dt=fineTimeSince(T);
//DBG"$_proc took $(dt/1000000.0) secs \n"

  return  mkey;

  }
//=============================================

  void ClosestLand(float longx,float laty)
  {
  int k;
  float mintp = 18000;
  int mkey = -1;
  int isairport = 0;

  float sa;

  float longa;

  float lata;
  float msl;
  float mkm;
  float ght;
  float sa;

  longa = longx;

  lata = laty;

  for (k = 0 ; k < Ntp ; k++) {

  isairport = Wtp[k].GetTA();
//DBG"$_proc %V $isairport \n"

  if (isairport) {

  msl = Wtp[k].Alt;

  mkm = HowFar(lata,longa, Wtp[k].Ladeg,Wtp[k].Longdeg);

  ght = (mkm * km_to_feet) / LoD;
//FIX_PARSE_ERROR                sa = Wtp[k].Alt + ght + 2000

  sa = msl + ght + 2000;
//DBG" $k $mkm $ght $sa \n"

  if (sa < mintp) {

  mkey = k;

  mintp = sa;

  }

  }

  }

  if (mkey != -1) {
//DBG" found $mkey \n"

  Wtp[mkey].Print();

  }

  return  mkey;

  }
//=============================================

  int compute_leg(int leg)
  {
  float km;

  if (leg < 0)
     return 0;

  int kk = leg + 1;
	    // DBG" compute %V $leg $kk \n"

  float L1 = LA[leg];

  float L2 = LA[kk];
	    // DBG" %V $L1 $L2 \n"

  float lo1 = LO[leg];

  float lo2 = LO[kk];
	    //DBG" %V $lo1 $lo2 \n"

  km = computeGCD(L1,L2,lo1,lo2);

  return km;

  }
//==================================================
