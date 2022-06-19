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
#if CPP
extern int tdwo,vvwo;
extern int mapwo;
//extern int tpwo[];
//extern int legwo[];
extern int TASK_wo;
extern int sawo;
extern int vptxt;
extern int Witp;
extern  int igc_tgl;
extern  int igc_vgl;
extern int Maxtaskpts;
extern float erx,ery;


extern Turnpt  Wtp[]; //
extern Tleg  Wleg[];
extern  void gg_gridLabel(int wid);

void drawTask(int w,int col);

int ClosestTP (float longx, float laty);
int ClosestLand(float longx,float laty);
int  PickTP(Str atarg,  int wtp);
void taskDist();
#endif


  void zoomMap(int t1, int t2)
  {
  int t3,k;
      if (t2 < t1) {
       t3= t2;
       t2 = t1;
       t1 =t3;
     }

//<<"$_proc  $t1 $t1\n";
//  find min,max for lat and long
   float min_lat,max_lat = IGCLAT[t1];
   float min_lng,max_lng = IGCLONG[t1];
   float val;
   int n =0;
   for (k = t1; k <= t2; k++)
   {
       val = IGCLAT[k];
       if (val > max_lat) max_lat = val;
       if (val < min_lat) min_lat = val;

       val = IGCLONG[k];
       if (val > max_lng) max_lng = val;
       if (val < min_lng) min_lng = val;       
       n++;
   }

//<<"%V $n $min_lat $max_lat $min_lng $max_lng \n"

   LongW = max_lng +0.1;
   LongE = min_lng -0.1;
   LatN = max_lat+0.1;
   LatS = min_lat- 0.1;

 }
//=================


  void DrawMap()
  {
  
//DBG"$_proc %V $wo\n"
// TBF include ?? code that we are running or  code that is calling?
//<<"%V $_proc  $_include \n"

  float msl;
  int k;
  float lat;

  float longi;

  Str mlab;

  int is_an_airport = 0;
  int is_a_mtn = 0;
  
  sWo(mapwo,_WSCALES,wbox(LongW,LatS,LongE,LatN),_WEO);
  //<<"%V $LongW $LatS $LongE $LatN \n";

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

     mlab.slower();  //TBF 5/3/22
     

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

  sWo(mapwo,_WSHOWPIXMAP,_WCLIPBORDER,_WSAVEPIXMAP,_WEO);

  gg_gridLabel(mapwo);

  }
//====================================================


  void screen_print()
  {
// make it monochrome

  
  openLaser("st.ps");

  screenToLaser(Vp);

  //nc = get_colors();

  //set_colors(2);

  DrawMap();

  drawTask(mapwo,RED_);

  laserToScreen(Vp);

  closeLaser();

 // set_colors(nc);

  }
//==================================================

  void read_task()
  {
  int query = 1;
  Svar wval;
  int k;
  int ti;
  int err;
  int nwr;
  Str TT;
  Str atpt;
  Str task_file;
  
  if (query)

  task_file = naviWindow("TASK_File","task file?",task_file,".tsk","TASKS");

  TF= ofr(task_file);
  //<<"$task_file  $TF \n";

  if (TF != -1) {

  ti = 0;

  setErrorNum(0);

  for (k = 0 ; k < Maxtaskpts ; k++) {

 // sWo(tpwo[k],_WVALUE,"");
          //sWo (ltpwo[k],_WVALUE,"0")
                 woSetValue(tpwo[k],"0");
  }

  nwr = wval.readWords(TF);

  TT = wval[0];

  if ( !(TT == "")) {
     woSetValue(TASK_wo,TT);
  }
  ti = 0;

  while (1) {

  nwr = wval.readWords(TF);

  atpt = wval[0];

  err = ferror(TF);
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

  closeFile(TF);

  }
    //<<"DONE $_proc\n"

  }
//==================================================

  void readTaskFile(Str taskfile)
  {
  Svar wval;
  int k,err,nwr,ti;
  int TF= ofr(taskfile);
  //<<"%V $taskfile  $TF $SetWoT \n";

  ans=query("$TF read $taskfile ? ");

  if (TF != -1) {

  ti = 0;

  setErrorNum(0);

  for (k = 0 ; k < Maxtaskpts ; k++) {

  //sWo(tpwo[k],_WVALUE,"");
          //sWo (ltpwo[k],_WVALUE,"0")
                 woSetValue(tpwo[k],"");
  }

  nwr = wval.readWords(TF);

  Str TT = wval[0];

  if ( !(TT == "")) {

  //sWo(TASK_wo,_WVALUE,TT);
                 woSetValue(TASK_wo,TT);
  }

  ti = 0;
  Str atpt;
  while (1) {

  nwr = wval.readWords(TF);

  atpt = wval[0];

  err = ferror(TF);
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
  Str val;
  Str tsk_file = "K_1.tsk";
  int i;
  tsk_file=queryWindow("DATA_FILE","write to file:",tsk_file);

  if (tsk_file == "")       return;

  val = getWoValue(TASK_wo);

  tsk_file = scat("TASKS/",tsk_file.cptr(),".tsk");

  int WF=ofw(tsk_file);

  wfile(WF,"type $val  %6.3f $totalK \n");

  for (i = 0 ; i <  Ntaskpts; i++) {

  wfile(WF,"$Wleg[i].Place  %6.0f $Wleg[i].msl  $Wleg[i].fga \n");

  }

  cf(WF);

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


         printargs(Ntpts);;
          //DrawMap(mapwo);
	  
  	 if (Ntpts > 0) {
            sWo(vvwo, _WSCALES, wbox(0, Min_ele, Ntpts, Max_ele + 500),_WEO );
              dGl(igc_tgl);
	    sWo(vvwo,_WCLEARPIXMAP);
	      dGl(igc_vgl);
            sWo(mapwo,_WSHOWPIXMAP,_WCLIPBORDER);
            sWo(vvwo,_WSHOWPIXMAP,_WCLIPBORDER);
//<<"%V $Ev_button $lc_gl $rc_gl  \n"
  CR_init = 1;
  CL_init = 1;

if (lc_gl != -1) {
	  sGl(_GLID,lc_gl,_GLCURSOR,rbox(zoom_begin,0,zoom_begin,20000, CL_init),_GLHUE,GREEN_); // use rbox
   dGl(lc_gl);
}

if (rc_gl != -1) {
	  sGl(_GLID,rc_gl,_GLCURSOR,rbox(zoom_end,0,zoom_end,20000, CR_init),_GLHUE,RED_);
   dGl(rc_gl);
}

 //<<"%V $zoom_begin $zoom_end\n"
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
            sWo(vvwo, _WSCALES, wbox(0, Min_ele, Ntpts, Max_ele + 500),_WEO );
	    sWo(vvwo,_WCLEARPIXMAP);
	      dGl(igc_vgl);
            sWo(vvwo,_WSHOWPIXMAP,_WCLIPBORDER);
//<<"%V $Ev_button $lc_gl $rc_gl  \n"
  CR_init = 1;
  CL_init = 1;

if (lc_gl != -1) {
	  sGl(_GLID,lc_gl,_GLCURSOR,rbox(zoom_begin,0,zoom_begin,20000, CL_init),_GLHUE,GREEN_); // use rbox
   dGl(lc_gl);
}

if (rc_gl != -1) {
	  sGl(_GLID,rc_gl,_GLCURSOR,rbox(zoom_end,0,zoom_end,20000, CR_init),_GLHUE,RED_);
   dGl(rc_gl);
}

// <<"%V $zoom_begin $zoom_end\n"
	 }
  CR_init = 0;
  CL_init = 0;
      }
}

//==================================================

  void gg_gridLabel(int wid)
  {

  float ts = 0.01;
  float dx,dy = 0.0;
  float x_inc,y_inc = 0.1;
//incr should set format

  float rx;

  float ry;

  float rX;

  float rY;

  sWo(wid,_WPENHUE,BLACK_);

  RS= wgetrscales(wid);

//<<"%V $wid $RS \n"

  rx= RS[1];

  ry= RS[2];

  rX= RS[3];

  rY= RS[4];

//<<"%V $rx $ry $rX $rY\n"
  if (ry == -1.0) {
   ans=query("bad ry\n");
  }
  
  //putMem("LongW","$rx",1);

  //putMem("LongE","$rX",1);

  //putMem("LatS","$ry",1);

 // putMem("LatN","$rY",1);

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
#if ASL
  axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f");
#else  
  sWo(wid,_WAXNUM,AXIS_BOTTOM_,_WEO);
#endif
  }

  else {
#if ASL
  axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f");
#else
sWo(wid,_WAXNUM,AXIS_BOTTOM_,_WEO);
#endif
  }

  }

  if ( y_inc != 0.0) {
      //ticks(wid,2,ry,rY,y_inc,ts)
#if ASL
  axnum(wid,2,ry,rY,2*y_inc,-2.0,"2.1f");
#else
sWo(wid,_WAXNUM,AXIS_LEFT_,_WEO);
#endif
}

  sWo(wid,_WCLIPBORDER);

  }
//==================================================
  void gg_zoomToTask(int w_num, int draw)
  {
 // this needs to find rectangle - just bigger than task
  // found via computetaskdistance
//<<"$_proc   $w_num \n";

  sWo(w_num,_WSCALES,wbox(Max_W,Min_lat,Min_W,Max_lat),_WEO);

  if (draw) {



  DrawMap();

  drawTask(w_num,BLACK_);
//  sWo(w_num,_Wshowpixmap)

  }

  }
//==================================================

  void reset_map()
  {

  

  DrawMap();
 drawTask(mapwo,GREEN_);

}
//======================================//

 void replace_tp(int wt)
  {
/// click on tpwo
//wt = Witp;
  Str tval;
  int ntp;
  Str nval;
  
    woSetValue (tpwo[wt],"XXX");

  sWo(tpwo[wt],_WREDRAW);

  mouseCursor("hand", tpwo[9], 0.5, 0.5);

    emsg =gev.eventWait();
    ekey = gev.getEventKey();
  
    gev.getEventRxy( &erx,&ery);
  //eventWait();

  ntp = ClosestTP(erx,ery);
//ans=query("%V$erx $ery $ntp\n");   
// <<"%V $erx $ery $ntp\n";

  if (ntp >= 0) {

  Wtp[ntp].Print();

  nval = Wtp[ntp].GetPlace();
//<<" found %V $ntp $nval \n"
             //woSetValue (tpwo[wt],ntp,1)

  woSetValue (tpwo[wt],nval,0);

  Taskpts[wt] = ntp;
          //  ret = ntp;

  Task_update = 1;

  mouseCursor("cross", tpwo[9], 0.5, 0.5);

  sWo(tpwo,_WREDRAW);

  }


  }
//======================================//
 void insert_tp(int wt)
  {
/// click on tpwo
//wt = Witp;
   Str tval;
   Str nval;
   int ntp;
   int kt,i;
  LastTP =Ntaskpts ;
  
  if (wt < LastTP ) {

  for (i = LastTP ; i > wt ; i--) {

  tval = getWoValue(tpwo[i-1]);
//  <<"$i <|$tval|>  \n"

  woSetValue (tpwo[i],tval);
  sWo(tpwo[i],_WREDRAW);
  kt = Taskpts[i-1];

  Taskpts[i] = kt;

  }

  }


  woSetValue (tpwo[wt],"XXX");

  sWo(tpwo[wt],_WREDRAW);

  mouseCursor("hand", tpwo[9], 0.5, 0.5);

    emsg =gev.eventWait();
    ekey = gev.getEventKey();
    gev.getEventRxy( &erx,&ery);

    //eventWait();

  ntp = ClosestTP(erx,ery);
//ans=query("%V$erx $ery $ntp\n");   
// <<"%V $erx $ery $ntp\n";
  if (ntp >= 0) {

  Wtp[ntp].Print();

  nval = Wtp[ntp].GetPlace();
//<<" found %V $ntp $nval \n"
             //woSetValue (tpwo[wt],ntp,1)

  woSetValue (tpwo[wt],nval,0);

  Taskpts[wt] = ntp;
          //  ret = ntp;

  Task_update = 1;

  mouseCursor("cross", tpwo[9], 0.5, 0.5);

  sWo(tpwo,_WREDRAW);

  }

  Ntaskpts++;

//<<"Found %V $wt $ntp <|$nval|> $Ntaskpts\n"

  }
//======================================//

  void insert_name_tp(int wt)
  {
/// pick a tp via name
/// insert before current selected

  Str nval;
  Str tval;
  int ntp;
  int kt,i;
//<<"$_proc  $wt\n";
 LastTP =Ntaskpts ;
  if (wt < LastTP ) {

  for (i = LastTP ; i > wt ; i--) {

  tval = getWoValue(tpwo[i-1]);
//  <<"$i <|$tval|>  \n"

  woSetValue (tpwo[i],tval);

  kt = Taskpts[i-1];

  Taskpts[i] = kt;

  }

  }

  woSetValue (tpwo[wt],"?");
  sWo(tpwo[wt],_WREDRAW);

  nval = " ";

  nval=queryWindow("TurnPt","TP $Witp enter name:",nval);

 printargs("name sel: ",nval);

  ntp= PickTP(nval,Witp);

  nval = Wtp[ntp].GetPlace();

 // nval = RX[wtp][0];



  woSetValue (tpwo[wt],nval,0);
  sWo(tpwo[wt],_WREDRAW);

  Task_update = 1;

  sWo(tpwo,_WREDRAW);
  
  Ntaskpts++;

  //<<"Found %V $wt $ntp <|$nval|> $Ntaskpts\n"


  }
//======================================//
int PickViaName(int wt)
{
//<<"ENTER $_proc  wt $wt \n";
  int wtp =0;
  int ok = 0;
  Str aplace;
  woSetValue (tpwo[wt],"??X");

  Str nval = " ";

  nval= queryWindow("TurnPt","TP $wt enter name:",nval);

//<<"name sel:  <|$nval|> $wt\n"



  wtp= PickTP(nval,wt);

  if (wtp >0) {
  aplace = Wtp[wtp].Place;

  nval = SRX.getRC(wtp,0); // double check nval == aplace 

  printargs("Found ",wt,wtp,nval,aplace);
  ok = 1;
  woSetValue (tpwo[wt],aplace,0);
  }

 //<<"Exit Done $_proc $ok \n";
   return ok;
}
//======================================

  void delete_tp(int wt)
  {

//<<"$_proc  wt $wt \n";

  int i,j;
  int kt = 0;
  Str plc;
  kt = Taskpts[wt];
//<<"$_proc %V $wt $kt $LastTP\n";  
//              <<"$_proc delete $_ewoname $wt $Wtp[kt].Place \n"



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

  //sWo (tpwo[j],_WVALUE," ",_WREDRAW);
                 woSetValue(tpwo[j]," ");
  break;

  }

  plc = Wtp[kt].Place;
//  <<"del $i $kt  $plc \n"

  //sWo (tpwo[i],_WVALUE,plc);
                 woSetValue(tpwo[i],plc);
  j++;

  }
//		<<"last was $j $plc\n"

  Taskpts[j-1] = 0;

  //sWo (tpwo[j-1],_WVALUE," ",_WREDRAW);
                 woSetValue(tpwo[j-1]," ");

  }

  sWo(tpwo,_WREDRAW);


  Ntaskpts--;

  // have to recompute legs


  }
//======================================//

  void delete_alltps()
  {
   int i;
//get_tp

  for (i = 0 ; i <Ntaskpts ; i++) {

  wfr=woSetValue (tpwo[i],"");

  woSetValue (legwo[i],"0",1);

  }

  Ntaskpts = 0;

  }
//======================================//




  int SetWoT = 0;

  void setWoTask()
  {
  int k,i;
#if ASL  
  SetWoT++;
//<<"$_proc $SetWoT\n"

  phere = "$_proc";
  // taskpts are in tpwo[i] values  10 max

  Ntaskpts = 0;

  for (k = 0 ; k < Maxtaskpts ; k++) {

  tval = getWoValue(tpwo[k]);

  <<"<|$k|> <|$tval|> \n"

  if (slen(tval) > 1) {

  index=RX.findRecord(tval,0,0,0);
	  //<<"%V $k $WH\n"

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
#endif
  }
//============================

  void chk_start_finish()
  {

  Str lval = "";

  Str val= "OB";
  int mti;
  val = getWoValue(TASK_wo);
//<<"$_proc <|$val|> \n"

 // put_mem("TT",val);

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

  if (val == "SO") {

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
#if 0
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


  else if (ur_c == "plot_igc") {

  plot_igc(w);

  }

  else if (ur_c == "delete_all") {

  delete_alltps();

  DrawMap();

  }

  else if (ur_c == "coors") {

  //new_coors(w);

  }

  else if (ur_c == "units") {

  new_units();

  set_task();

  }

  else if (ur_c == "set") {

  DrawMap();

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
    //  wfr=w_show_curs(tw,1,"left_arrow")
      PickaTP()
      set_task()
    }
*/

//for (i=0; i < Ntaskpts; i++) {
//<<"$i    $Taskpts[i]  Wtp[i].Place\n"
// }

  }
//=====================================//
#endif

  int PickaTP(int itaskp)
  {
// 
// use current lat,long to place curs
//
//<<"$_proc $itaskp\n"
  Str nval;
  int ret = -1;
  int ntp;
  float rx;

  float ry;

  rx = MidLong;

  ry = MidLat;

  mouseCursor("left", mapwo, rx, ry);  // TBC;

  Text(vptxt,"Pick a TP for the task ",0,0.05,1);

  //sWi(vp,_WTMSG,"Pick a TP for the task ");

  
  emsg =gev.eventWait();


  sleep(0.2);

  ntp = ClosestTP(erx,ery);

  mouseCursor("hand",mapwo,0.5,0.5);

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



  void drawTask(int w,int col)
  {
  
  //<<"$_proc    $w $col\n"


  float lat1 = 0.0;
  float lat2 = 1.0;
  float lon1 = 2.0;
  float lon2 = 3.0;
  int index = -7;
  int index1 = -8;
  int idt = -2;
  int j = -3;

#if ASL_DB
  idt.pinfo();
  j.pinfo();
  Taskpts.pinfo();
  PXS"%V $idt $j\n";
  PXS"MT %V  $index $index1\n";

#endif  



  int fast;
/*  
  if ( Task_update) {

  taskDist();
 // <<"$TaskType $col $Nlegs \n"

  }

//      index = Taskpts[0]
//      tpl = Wtp[index].Place;
//<<"%V$index $tpl \n"

//<<" %V $Ntaskpts \n";

  if ( (TaskType == "OAR")   || (TaskType == "SO")) {

  index = Taskpts[0];

  index1 = Taskpts[1];
//<<"OAR %V $index $index1\n"

  plotLine(w,Wtp[index].Longdeg,Wtp[index].Ladeg,Wtp[index1].Longdeg,Wtp[index1].Ladeg,col);

  }
*/


#if ASL
fast=fastxic(0);
  dbline(0);
#endif

#if ASL_DB
  idt.pinfo();
  j.pinfo();
  Taskpts.pinfo();
#endif  

  //sdb(2,"pline");

  for (idt = 0 ; idt < (Ntaskpts-1) ; idt++ ) {

  j = idt +1;
  PXS"%V $idt $j\n";
#if ASL_DB
  j.pinfo();
  Taskpts.pinfo();

#endif  
//<<"$i %V $w  $Tasktp[i].Longdeg $Tasktp[i].Ladeg $Tasktp[i+1].Longdeg $Tasktp[i+1].Ladeg $col \n "

  index = Taskpts[idt];

  index1 = Taskpts[idt+1];
  //index1 = Taskpts[j];
  
PXS"MT %V $idt $index $index1\n";

  

// plotLine(w,Wtp[index].Longdeg,Wtp[index].Ladeg,Wtp[index1].Longdeg,Wtp[index1].Ladeg,col);

  lat1 = Wtp[index].Ladeg;

  lon1 = Wtp[index].Longdeg;

  lat2 = Wtp[index1].Ladeg;

  lon2 = Wtp[index1].Longdeg;

  //lat1.pinfo();
  //lat2.pinfo();  

  //lon1.pinfo();
  //lon2.pinfo();
  

//  plotLine(w, lon1, lat1,lon2,lat2,col);


#if ASL_DB
 <<"%V $fast $w   \n"
<<"%V $lat1 $lon1  \n" 
 <<"%V $lat2 $lon2 \n"
#endif

   plotLine(w, lon1, lat1,lon2,lat2);


  }
  
  if (Init) {
    //MSE=getMouseEvent();
    Init = 0;  // make this once only
   }

  

 sWo(w,_WSHOWPIXMAP,_WCLIPBORDER);
//ans=query("see lines?");
#if ASL
fastxic(0);
  dbline(0);
//  sdb(1,"~pline");
#endif
}
//=============================================

  Str Atarg="xxx";

  

  int  PickTP(Str atarg,  int wtp)
  {
///
/// 
  Svar srp;
  int ret = -1;
  int index;
//<<" $_proc looking for <|$atarg|>  $Atarg  $wtp\n"


  index=SRX.findRecord(atarg,0,0,0);
//<<"$index \n"
  if (index >=0) {

    srp = SRX.getRow(index);

  printf(" found  $index %d\n",index);
//<<"$ttp \n"

  Taskpts[wtp] = index;

  ret =index;
  
//<<" found $atarg $index $wtp $ret $ttp\n"
//ans=query("$_proc ?");
  }

  return ret;

  }
//=============================================



  void listTaskPts()
  {
//<<"$_proc \n"

//<<"%V $Ntaskpts\n"
  float lat1;
  float lat2;
  float lon1;
  float lon2;
  int index;
  int index1;
  
   int kt,i;
  for (i = 0 ; i < Ntaskpts ; i++) {

  kt= Taskpts[i];
 // <<"taskpt $i  $kt $Taskpts[i]   \n"

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
//<<"$_proc \n"

//<<"%V $Ntaskpts\n"

 
   int kt,i;
  for (i = 0 ; i < Ntaskpts ; i++) {

  kt= Taskpts[i];
//   <<"taskpt $i  $kt $Taskpts[i]   \n"

  if (kt <= 0) { 
     break;
   }
  }

  }
//====================================//

 // void taskDist(Turnpt wtp[])
  void taskDist()
  {
   // is there a start?
 //  <<"$_proc  $Ntaskpts \n"
//<<"in taskDist  %V $_scope $_cmfnest $_proc $_pnest\n"	       
  int index;
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

  int i;
//<<"%V $Ntaskpts \n"

  



  for (i = 0; i < Ntaskpts ; i++) {

  index = Taskpts[i];
 // <<"%V $i $index \n";
 // index.pinfo();
  
 if ((index > 0)  && (index <= Ntp) ) {
  kmd = 0.0;

//<<"pass %V $i $index $Taskpts[i] \n";

  tpl = Wtp[index].Place;

//<<"%V  $tpl \n"

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

//<<"%V $i  $j $kmd  $tpl $fga\n";
  //dbline(1);
  Wleg[j].dist = kmd;
//<<"%V $Wleg[j].dist \n"
  Wleg[j].Tow = tpl;
  //ght.pinfo();
  ght = (kmd * km_to_feet) / LoD;

  fga = ght + 1200.0 + msl;

//PXS"%V$i $ght $fga $msl\n"


   Wleg[j].fga = fga;
 // dbline(0);
 }
 //  <<"%V $i $Min_lat $Max_lat\n" 
  }

  }

  Wleg[Ntaskpts].dist = 0.0;
//<<"%V $Min_lat $Min_W $Max_lat $Max_W \n"
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
  int i;
  for (i = 0; i < Ntaskpts ; i++) {

  amsl = Wleg[i].msl;
     //<<"Stat $i $amsl $Wleg[i].dist   $Wleg[i].fga\n"

  }

  }



  int ClosestTP (float longx, float laty)
  {
///
  float dx,dy,dxy;
  
  //T=fineTime();

  float mintp = 30;

  int mkey = -1;

  float ctp_lat,longi;

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

 // dt=fineTimeSince(T);
//DBG"$_proc took $(dt/1000000.0) secs \n"

  return  mkey;

  }
//=============================================

  int ClosestLand(float longx,float laty)
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
void   showPosn(int pi)
  {
    	 wfr=sWo(mapwo,_WSHOWPIXMAP,_WEO);
    wfr =sWo(mapwo,_WPIXMAPOFF,_WDRAWON,_WEO); // just draw but not to pixamp
//              <<"%V $pi $IGCELE[pi] $IGCLAT[pi] $IGCLONG[pi] \n";
         symx = IGCLONG[pi];
	 symy = IGCLAT[pi];
	 symem = IGCELE[pi] ;
	 syme = IGCELE[pi] *  3.280839;
         plotSymbol(mapwo,symx,symy,CROSS_,symsz,MAGENTA_,1);

          //sGl(lc_gl,_GLCURSOR,rbox(pi,0,pi,20000, CL_init),_GLEO);
	  //dGl(lc_gl);
	  //CL_init = 0;
	  	   zoom_begin = pi;
	  drawAlt();

   wfr = sWo(mapwo,_WPIXMAPON,_WEO);
	 sWo(sawo,_WVALUE,"$symx $symy $syme ",_WREDRAW);
  }

//==================================================


void updateLegs()
{

 Str val;
 float lfga;
 int lwo;
 int nlegs = Ntaskpts-1;
 float dist,msl;
// <<"$_proc TP's $Ntaskpts Legs $nlegs\n"
  int i;
  for (i = 0; i < nlegs ; i++) {

    lwo = legwo[i];
    lfga =  Wleg[i].fga;
    msl =  Wleg[i].msl;
    dist =  Wleg[i].dist;
//    val = "%6.0f$lfga"
      val = "%6.0f$lfga $dist ";
      val = "%6.0f$dist $lfga ";   
 //   <<"leg $i $lwo %6.1f $msl $dist  $lfga  \n"
//  <<"leg $i  <|$val|> \n"
     woSetValue (lwo,val,0);
     sWo(lwo,_WREDRAW,_WEO);
  }

   for (i = nlegs; i < MaxLegs ; i++) {
         lwo = legwo[i];
     woSetValue (lwo," ",0);
     sWo(lwo,_WREDRAW,_WEO);
   }

}
//======================================//
