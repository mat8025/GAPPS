/* 
 *  @script draw_showtask.asl 
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

void checkAnswer(Str& val)
{
    if (val == "q") {
        exit(-1);
    }

}

void zoomMap(int t1, int t2)
  {
  int t3,k;
      if (t2 < t1) {
       t3= t2;
       t2 = t1;
       t1 =t3;
     }

printf(" zoomMap %d %d \n",t1,t2);

//pra(t1 ,t2 );

//ans=query("?","ZOOM_MAP",__LINE__);
//  find min,max for lat and long

   float max_lat = IGCLAT[t1];
   float min_lat = max_lat;
   float max_lng = IGCLONG[t1];
   float min_lng = IGCLONG[t1];   
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

printf(" n %d min_lat %f max_lat %f min_lng %f max_lng %f\n",n,min_lat ,max_lat ,min_lng ,max_lng);

//pra(n ,min_lat ,max_lat ,min_lng ,max_lng,"\n");

   LongW = max_lng +0.1;
   LongE = min_lng -0.1;
   LatN = max_lat+0.1;
   LatS = min_lat- 0.1;

 adbprintf(-1," LongW %f LatS %f LongE %f LatN %f \n",LongW, LatS, LongE, LatN);

 sWo(_WOID,mapwo,_WSCALES,wbox(LongW,LatS,LongE,LatN));

adbprintf(-1,"ZOOM\n");


 }
//=================


  void DrawMap()
  {
  
// DBG"$_proc %V $wo\n"
// TBF include ?? code that we are running or  code that is calling?
//<<"%V $_proc  $_include \n"

  float msl;
  int k;
  float lat;
  float longi;
  float dang;

  Str mlab;

  int is_an_airport = 0;
    int is_a_strip = 0;
  int is_a_mtn = 0;
  int is_a_mtn_pass = 0;  
adbprintf(-1,"DrawMap in\n");

  Mapcoors= woGetPosition (mapwo);

//CDBP("MapCoors")

//  pra(Mapcoors);

//ans=query("?","Mapcoors",__LINE__);

  dMx = Mapcoors[5];
  dMy = Mapcoors[6];


  // adjust the  X  & Y to be  same angluar scale
  // fix the Y
  lat = LatN - LatS;
  dang = lat / (dMy*1.0);
  // adjust LongW
  lat = LongE + (dMx * dang);

  printf("dMx %d dMy %d LongW %f lat %f LongE %f\n",dMx,dMy,LongW,lat,LongE);  
 // LongW = lat;

//CDBP("Adjust Map X,Y axis")

//  sWo(_WOID,mapwo,_WSCALES,wbox(LongW,LatS,LongE,LatN));
  //<<"%V $LongW $LatS $LongE $LatN \n";

  sWo(_WOID,mapwo,_WCLEARPIXMAP,ON_,_WCLIPBORDER,BLACK_);

 // sWo(mapwo,_WDRAWON,_WSHOWPIXMAP,_WCLIPBORDER);
 
pra("mapwo ",mapwo);

  gg_gridLabel(mapwo);
  
//ans=query("?113","gg_gridLabel(mapwo); ",__LINE__);
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
    is_a_strip = Wtp[k].is_strip;
    is_a_mtn_pass = Wtp[k].is_mtn_pass;    

    mlab = Wtp[k].Place;

   //pra(k,is_an_airport,mlab);
   
  // ans=query("?","DrawMAP",__LINE__);
//<<"%V $k $mlab  $is_an_airport \n"


  if (!is_an_airport) {

     mlab.slower();  //TBF 5/3/22

  }

  msl = Wtp[k].Alt;

 // msl.pinfo();
  
 // <<"%V $k $msl  $Wtp[k].Alt \n"

  lat = Wtp[k].Ladeg;

//<<"%V $k $lat   $Wtp[k].Ladeg \n"

  longi = Wtp[k].Longdeg;

  //pra(k ,is_an_airport  ,mlab, msl ,lat ,longi);

  //pra(k,msl,lat,longi, mlab);

//<<"%V $k $longi  $Wtp[k].Longdeg \n"

//<<"%V $k $mlab $msl $lat $longi $Wtp[k].Ladeg   \n"

   Maphue = RED_;
       if (is_an_airport ) {
          Maphue = GREEN_;
       }

       if (is_a_strip ) {
          Maphue = LILAC_;
       }
     if (is_a_mtn_pass) {
            Maphue = BROWN_;
     }

     if (is_a_mtn) {
            Maphue = BLUE_;
     }


    
       Text(mapwo, mlab.cptr(), longi, lat,0,0,1,Maphue);

  }


  sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_,_WSAVEPIXMAP,ON_);

  gg_gridLabel(mapwo);

adbprintf(-1,"MAPWO\n");
//ans=query("DONE","drawMAP",__LINE__);
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
  int TF;
  
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

  //ans=query("$TF read $taskfile ? ");

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


       titleMessage("%V $LongW $LatS $LongE $Latn");

         sWo(_WOID,mapwo,_WSCALES, wbox(LongW, LatS, LongE, LatN) );

         sWo(_WOID,vvwo,_WCLEARPIXMAP,ON_);


         //pra(Ntpts);;
          //DrawMap(mapwo);
	  
  	 if (Ntpts > 0) {
	 

	    sWo(_WOID,vvwo, _WSCALES, wbox(0, Min_ele, Ntpts, 8000));
	
	      
	    sWo(_WOID,vvwo,_WCLEARPIXMAP,ON_);

    sGl(_GLID,igc_tgl,_GLDRAW,BLUE_);  // DrawGline;

    sGl(_GLID,igc_vgl,_GLDRAW,RED_);  // DrawGline;


            sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_);
            sWo(_WOID,vvwo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_);
//<<"%V $Ev_button $lc_gl $rc_gl  \n"
  CR_init = 1;
  CL_init = 1;

if (st_lc_gl != -1) {
	  sGl(_GLID,st_lc_gl,_GLCURSOR,rbox(zoom_begin,0,zoom_begin,20000, CL_init),_GLHUE,GREEN_); 
 //  dGl(lc_gl);
}

if (st_rc_gl != -1) {
	  sGl(_GLID,st_rc_gl,_GLCURSOR,rbox(zoom_end,0,zoom_end,20000, CR_init),_GLHUE,RED_);
 //  dGl(rc_gl);
}

 //<<"%V $zoom_begin $zoom_end\n"
	 }

      adbprintf(-1,"see TRACE\n");

//      ans=query("CPP"," see trace",__LINE__,__FILE__);
//      checkAnswer(ans);
      
//      if (ans == "q") {
//           exit(-1);
//      }

      CR_init = 0;
      CL_init = 0;
      }

}

//==================================================

void drawAlt()
{
     if (Have_igc) {
         
         sWo(_WOID,vvwo,_WCLEARPIXMAP,ON_);

	  
  	 if (Ntpts > 0) {
            sWo(_WOID,vvwo, _WSCALES, wbox(0, Min_ele, Ntpts, Max_ele + 500));
	    sWo(_WOID,vvwo,_WCLEARPIXMAP,ON_);
	      dGl(igc_vgl);
            sWo(_WOID,vvwo,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_);
//<<"%V $Ev_button $lc_gl $rc_gl  \n"
  CR_init = 1;
  CL_init = 1;

if (st_lc_gl != -1) {
	  sGl(_GLID,st_lc_gl,_GLCURSOR,rbox(zoom_begin,0,zoom_begin,20000, CL_init),_GLHUE,GREEN_); // use rbox
   //dGl(lc_gl);
}

if (st_rc_gl != -1) {
	  sGl(_GLID,st_rc_gl,_GLCURSOR,rbox(zoom_end,0,zoom_end,20000, CR_init),_GLHUE,RED_);
   //dGl(rc_gl);
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

  float rx= 0.4;

  float ry= 0.5;

  float rX;

  float rY;

  //pra(rx,ry);

  sWo(_WOID,wid,_WPENHUE,BLACK_);
  
//ans=query("?1","b4 wgetrscales",__LINE__);
//pra("wid ",wid,__LINE__);
ST_RS[1] = 4.5;
ST_RS[2] = 77.67;

ST_RS[3] = 48.67;
ST_RS[4] = 52.67;
//COUT(ST_RS);
//ST_RS.pinfo();

 adbprintf(-1,"gridlabel\n");
 
 ST_RS = wgetrscales(wid);

//ans=query("?2","after wgetrscales\n",__LINE__);

//printf("does ST_RS still exist?\n");
//ST_RS.pinfo();




  rx= ST_RS[1];

  ry= ST_RS[2];

//pra(rx,ry);

  rX= ST_RS[3];

  rY= ST_RS[4];

//pra(rx,ry,rX,rY);


  if (ry == -1.0) {
   //ans=query("bad ry\n");
  }

   //COUT(ST_RS);
#if 0   
//pra(wid,"RS ",ST_RS);

  //putMem("LongW","$rx",1);

  //putMem("LongE","$rX",1);

  //putMem("LatS","$ry",1);

 // putMem("LatN","$rY",1);
#endif
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
  sWo(_WOID,wid,_WAXNUM,AXIS_BOTTOM_);
#endif
  }

  else {
#if ASL
  axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f");
#else
sWo(_WOID,wid,_WAXNUM,AXIS_BOTTOM_);
#endif



  }

  if ( y_inc != 0.0) {
      //ticks(wid,2,ry,rY,y_inc,ts)
#if ASL
  axnum(wid,2,ry,rY,2*y_inc,-2.0,"2.1f");
#else
  sWo(_WOID,wid,_WAXNUM,AXIS_LEFT_);
#endif

 }

  


sWo(_WOID,wid,_WCLIPBORDER,RED_);

   printf("done gg");

  }
}
//==================================================
  void gg_zoomToTask(int w_num, int draw)
  {
 // this needs to find rectangle - just bigger than task
  // found via computetaskdistance
//<<"$_proc   $w_num \n";

  sWo(_WOID,w_num,_WSCALES,wbox(Max_W,Min_lat,Min_W,Max_lat));

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

  sWo(_WOID,tpwo[wt],_WREDRAW,ON_);

  mouseCursor(tpwo[9], "hand");

   eventWait();
   
  //eventWait();

  ntp = ClosestTP(Ev_rx,Ev_ry);
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

  mouseCursor(tpwo[9],"cross");

  //sWo(tpwo,_WREDRAW);
 woSetValue (tpwo[wt],nval);

  sWo(_WOID,tpwo[wt],_WREDRAW,ON_);
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
  sWo(_WOID,tpwo[i],_WREDRAW,ON_);
  kt = Taskpts[i-1];

  Taskpts[i] = kt;

  }

  }


  woSetValue (tpwo[wt],"XXX");

  sWo(_WOID,tpwo[wt],_WREDRAW,ON_);

 mouseCursor(tpwo[9],"hand");


    eventWait();
    

    //eventWait();

  ntp = ClosestTP(Ev_rx,Ev_ry);
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

  mouseCursor(tpwo[9], "cross");

  //sWo(tpwo,_WREDRAW);

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
  sWo(_WOID,tpwo[wt],_WREDRAW,ON_);

  nval = " ";

  nval=queryWindow("TurnPt","TP $Witp enter name:",nval);

 printargs("name sel: ",nval);

  ntp= PickTP(nval,Witp);

  nval = Wtp[ntp].GetPlace();

 // nval = RX[wtp][0];



  woSetValue (tpwo[wt],nval,0);
  sWo(_WOID,tpwo[wt],_WREDRAW,ON_);

  Task_update = 1;

  //sWo(tpwo,_WREDRAW);
  
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
//ans=query("?","QW",__LINE__);
  nval= queryWindow("TurnPt","TP $wt enter name:",nval);

//<<"name sel:  <|$nval|> $wt\n"

  wtp= PickTP(nval,wt);
//ans=query("?","QW",__LINE__);

  if (wtp >0) {
  aplace = Wtp[wtp].Place;

  nval = SRX.getRC(wtp,0); // double check nval == aplace 

  printargs("Found ",wt,wtp,nval,aplace);
  ok = 1;
  woSetValue (tpwo[wt],aplace,0);
  sWo(_WOID,tpwo[wt],_WREDRAW,ON_);
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

  //sWo(tpwo,_WREDRAW);


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

  index=SRX.findRecord(tval,0,0,0);
	  //<<"%V $k $WH\n"

  if (index >=0) {

  ttp = SRX[index];
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

  mouseCursor(mapwo,"left", rx, ry);  // TBC;

  Text(vptxt,"Pick a TP for the task ",0,0.05,1);

  //sWi(vp,_WTMSG,"Pick a TP for the task ");

  eventWait();


  sleep(0.2);

  ntp = ClosestTP(Ev_rx,Ev_ry);

 mouseCursor(mapwo,"hand");


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

#if ASL
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

#if ASL_DB
  j.pinfo();
  Taskpts.pinfo();

#endif  
//<<"$i %V $w  $Tasktp[i].Longdeg $Tasktp[i].Ladeg $Tasktp[i+1].Longdeg $Tasktp[i+1].Ladeg $col \n "

  index = Taskpts[idt];

  index1 = Taskpts[idt+1];
  //index1 = Taskpts[j];
  
//PXS"MT %V $idt $index $index1\n";

  

// plotLine(w,Wtp[index].Longdeg,Wtp[index].Ladeg,Wtp[index1].Longdeg,Wtp[index1].Ladeg,col);

  lat1 = Wtp[index].Ladeg;

  lon1 = Wtp[index].Longdeg;

  lat2 = Wtp[index1].Ladeg;

  lon2 = Wtp[index1].Longdeg;

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

  

 sWo(_WOID,w,_WSHOWPIXMAP,ON_,_WCLIPBORDER,BLACK_);
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

    srp = SRX.getRecord(index);

//  printf(" found  $index %d\n",index);
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

  pra(Ntaskpts);

//  ans = query("see taskpts");



  for (i = 0; i < Ntaskpts ; i++) {

  index = Taskpts[i];
//  pra(i, " index ", index);
  
 if ((index > 0)  && (index <= Ntp) ) {

   kmd = 0.0;

//<<"pass %V $i $index $Taskpts[i] \n";

  tpl = Wtp[index].Place;

//<<"%V  $tpl \n"

  la2 = Wtp[index].Ladeg;

  msl = Wtp[index].Alt;


//pra(i, index, tpl, la2, msl);


//ans = query("see taskpt");


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

//pra( "totalK ", totalK, " Coors ", LongW, LatS, LongE, LatN);
//<<"DONE $_proc  $totalK \n"

      woSetValue(tdwo,totalK);
      sWo(_WOID,tdwo,_WUPDATE,ON_);
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

  float saf;

  float longa;

  float lata;
  float msl;
  float mkm;
  float ght;
 //pra(__LINE__,longx, laty);

  longa = longx;

  lata = laty;

  for (k = 0 ; k < Ntp ; k++) {

  isairport = Wtp[k].GetTA();
  //pra(k,   isairport );
//DBG"$_proc %V $isairport \n"

  if (isairport) {

  msl = Wtp[k].Alt;

  mkm = HowFar(lata,longa, Wtp[k].Ladeg,Wtp[k].Longdeg);

  ght = (mkm * km_to_feet) / LoD;


//FIX_PARSE_ERROR                sa = Wtp[k].Alt + ght + 2000

  saf = msl + ght + 2000;
  //pra(mkm,ght,saf);



  if (saf < mintp) {

  mkey = k;

  mintp = saf;

  }

  }

  }

  if (mkey != -1) {
  
  //pra("found mkey" ,mkey);

  Wtp[mkey].Print();

  }

  return  mkey;

  }
//=============================================
void   showPosn(int pi)
  {

    
    	 sWo(_WOID,mapwo,_WSHOWPIXMAP,ON_);
         sWo(_WOID,mapwo,_WPIXMAP,OFF_,_WDRAW,ON_); // just draw but not to pixamp
//              <<"%V $pi $IGCELE[pi] $IGCLAT[pi] $IGCLONG[pi] \n";
         symx = IGCLONG[pi];
	 symy = IGCLAT[pi];
	 symem = IGCELE[pi] ;
	 syme = IGCELE[pi] *  3.280839;
         plotSymbol(mapwo,symx,symy,CROSS_,symsz,MAGENTA_,1);

          //sGl(lc_gl,_GLCURSOR,rbox(pi,0,pi,20000, CL_init));
	  //dGl(lc_gl);
	  //CL_init = 0;
	  	   zoom_begin = pi;
	  drawAlt();

         sWo(_WOID,mapwo,_WPIXMAP,ON_);
         sprintf(Gpos,"%f %f %f",symx,symy,syme);

	 sWo(_WOID,sawo,_WVALUE,Gpos,_WREDRAW,ON_);
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
   //   val = "%6.0f$lfga $dist ";
#if CPP   
      val = "%6.0f$dist $lfga ";
      val.strPrintf(" %6.0f %6.0f ",dist,lfga);
#else
      val = "%6.0f$lfga $dist ";
#endif
 //   <<"leg $i $lwo %6.1f $msl $dist  $lfga  \n"
//  <<"leg $i  <|$val|> \n"
     woSetValue (lwo,val,0);
     sWo(_WOID,lwo,_WREDRAW,ON_);
  }

   for (i = nlegs; i < MaxLegs ; i++) {
         lwo = legwo[i];
     woSetValue (lwo,"XX ",0);
     sWo(_WOID,lwo,_WREDRAW,ON_);
   }

}
//======================================//

