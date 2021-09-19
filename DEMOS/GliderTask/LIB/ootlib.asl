/* 
 *  @script ootlib.asl 
 * 
 *  @comment task-planner library 
 *  @release CARBON 
 *  @vers 4.2 He Helium [asl 6.3.46 C-Li-Pd] 
 *  @date 07/30/2021 14:48:36 
 *  @cdate 9/17/1997 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                           
///
///


str task_file = "XXX";

float totalD = 0;
float totalDur = 0.0

  int Ntaskpts = 0
  Min_lat = 90.0
  Max_lat = 0.0
  Min_W = 109.0
  Max_W = 105.0

# conversion routines
  km_to_feet = 3281.0
  km_to_nm = 3281.0/6080.0
  km_to_sm = 3281.0/5280.0
  nm_to_sm = 6080.0/5280.0
  nm_to_km = 6080.0/3281.0


DBG"%V $nm_to_km $km_to_sm  \n"

  Units = "KM"
  lat = "A"
  longit = "B"

  LegK =  0.5 * (7915.6 * 0.86838);
  DBG" %v $LegK \n"
  //  Main_init = 0

DBG" read in unit conversions \n"

int n_legs = 0
//float Leg[20];
float TC[>20];
float Dur[>20];



//============================================




//<<"$_include %V$Ntp_id\n"

proc nameMangle(str aname)
{
  // FIXIT --- bad return
  str fname;

 nname=aname
 //<<" %V $nname $aname \n"

  kc =slen(nname)

 if (kc >7) {
 nname=svowrm(nname)
 }

 scpy(fname,nname,7)

   // <<"%V$nname --> $fname \n"


 return fname
}
//======================================//


float totalK = 0;

void TaskDistance()
{
   // is there a start?
DBG"$_proc  $Ntaskpts \n"
   totalK = 0;
   float la1   = 1000.0;
   float lon1 = 1000.0;
   float la2   = 1000.0;
   float lon2 = 1000.0;
   float msl;
   float fga;
  Min_lat = 90.0
  Max_lat = 0.0
  Min_W = 109.0
  Max_W = 105.0

   int adjust = 0;

   // num of taskpts
   for (i = 0; i < Ntaskpts ; i++) {

     index = Taskpts[i]
     kmd = 0.0;
     
     tpl = Wtp[index]->Place;
     
     la2 = Wtp[index]->Ladeg;
     msl = Wtp[index]->Alt;

     if (la2 > Max_lat) {
         Max_lat = la2;
     }

     if (la2 < Min_lat) {
         Min_lat = la2;
     }

     lon2 = Wtp[index]->Longdeg;

     if (lon2 > Max_W) {
         Max_W = lon2;
     }

     if (lon2 < Min_W) {
         Min_W = lon2;
     }


     if (la1 != 1000.0) {
        kmd = computeGCD(la1,la2,lon1,lon2);
	
     }
//<<" tpt $tpl $i  $index <|$Wtp[index]->Place|>  $Wtp[index]->Ladeg  $Wtp[index]->Longdeg %6.0f $kmd\n"
     la1 = la2;
     lon1 = lon2;
     adjust++;
     totalK += kmd;
// add in the fga to reach this turnpt from previous
     Wleg->pinfo()
     Wleg[i]->msl = msl;
     Wleg[i]->Place = tpl;     
     if (i > 0) {
      Wleg[i-1]->dist = kmd;
      Wleg[i-1]->Tow = tpl;      
      ght = (kmd * km_to_feet) / LoD
      fga = ght + 1200.0 + msl;
      <<"%V$i $fga $msl\n"
      Wleg[i-1]->fga = fga;
     }

   }
   
  Wleg[Ntaskpts]->dist = 0.0;

<<"%V $Min_lat $Min_W $Max_lat $Max_W \n"
<<"%V $LongW $LatS $LongE $LatN   \n"
if (adjust >=2) {
 LongW= Max_W +1.0;
 LatS = Min_lat -1;
 LongE = Min_W -1;
 LatN = Max_lat +1;
}
<<"%V $totalK\n"
<<"%V $LongW $LatS $LongE $LatN   \n"
 Task_update = 1;
<<"DONE $_proc\n"

}
//==============================//


void TaskStats()
{

   for (i = 0; i < Ntaskpts ; i++) {

     <<"Stat $i $Wleg[i]->msl $Wleg[i]->dist   $Wleg[i]->agl\n"

  }
 
}


proc  computeHTD()
{

//  <<"$_proc $n_legs \n"

totalD = 0;
//totalD->info(1)


  for (nl = 0; nl < n_legs ; nl++) {

        tkm = ComputeTPD(nl, nl+1);

       Leg[nl] = tkm;
       //Leg[nl] = ComputeTPD(nl, nl+1)
       tcd =  ComputeTC(nl, nl+1)
       TC[nl] = tcd;
       
       Dur[nl] = Leg[nl]/ Cruise_speed;
       

//<<"$Leg[nl] $tkm \n"
       totalDur += Dur[nl];
       totalD += Leg[nl]
//<<"<$nl> $Leg[nl]  $tkm $tcd $Dur[nl] $TC[nl] $totalD $totalDur \n"
 }


}
//==============================//


proc getDeg (str the_ang)
    {
      str the_dir;
      float la;
      float y;
      str wd;

//DBG"in $_proc $the_ang \n"
	

    the_parts = Split(the_ang,",")

sz = Caz(the_parts);
//DBG"sz $sz $(typeof(the_parts))\n"

    //DBG"%V $the_parts[::] \n"


//FIX    float the_deg = atof(the_parts[0])

    wd = the_parts[0];
    the_deg = atof(wd);
        //DBG"%V $wd $the_deg \n"

//    float the_min = atof(the_parts[1])
    wd = the_parts[1];

    the_min = atof(wd);
        //DBG"%V $wd $the_min \n"
    //DBG"%V$the_deg $the_min \n"

      //  sz= Caz(the_min);

      //DBG" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

    the_dir = the_parts[2];

    y = the_min/60.0;

    la = the_deg + y;

      if ((the_dir == "E") || (the_dir == "S")) {
         la *= -1;
      }

//DBG"%V $la  $y  \n"
      
    return (la);
   }

//===============================//


proc get_word(str defword)
  {
  svar h

    //    DBG" %V $defword $via_keyb $via_cl \n"

      if (via_keyb) {
	// DBG"via keybd \n"
	// DBG"$defword "
        h = irs(Stat)
	  if ( h > 1) {
             sscan(Stat,&h);  
	  }
	else {
          h = defword
	    }
      }

      if (via_file) {
        h = r_file(TF)
          if ((h == "EOF") || si_error()) {
            h = "done"
          }
      }

      //          DBG" $_cproc exit with $h \n"

    return h
 }
//==================================================
proc get_wcoors(int sw,  float rx,  float ry,float  rX,float  rY)
{
  float rs[20];
  ww= get_w_rscales(sw,&rs[0]);
  rx= rs[0]
  ry = rs[1]
  rX= rs[2]
  rY = rs[3]
  return ww
}
//==================================================


proc compute_leg(int leg)
{
    float km;

    if (leg < 0) 
          return 0

    kk = leg + 1

	    // DBG" compute %V $leg $kk \n"

    L1 = LA[leg]
    L2 = LA[kk]

	    // DBG" %V $L1 $L2 \n"

    lo1 = LO[leg]
    lo2 = LO[kk]


	    //DBG" %V $lo1 $lo2 \n"
    km = computeGCD(L1,L2,lo1,lo2);
    
    return km
}
//==================================================
proc computeGCD(float la1,float la2,float lo1,float lo2)
{
///  input lat and long degrees - GCD in km

    rL1 = d2r(la1)

    rL2 = d2r(la2)

    rlo1 = d2r(lo1)
    rlo2 = d2r(lo2)

    D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2));

    N = LegK * D ;

    km = N * nm_to_km;

    return km;
}

//==================================================
void screen_print()
{
# make it monochrome
  ff=open_laser("st.ps")
  scr_laser(vp)
  nc = get_colors()
  set_colors(2);
  DrawMap(mapwo)
  drawTask(mapwo,"red")
  laser_scr(vp)  
  close_laser()
  set_colors(nc)
}
//==================================================



void read_task() 
{
int query = 1;
 svar wval;
 
    if (query) 
      task_file = navi_w("TASK_File","task file?",task_file,".tsk","TASKS")

     TF= ofr(task_file)


  <<"$task_file  $TF \n";

    if (TF != -1) {

      ti = 0

     seterrornum(0)

        for (k = 0 ; k < Maxtaskpts ; k++) {
	
          sWo(tpwo[k],@value,"")
          //sWo (ltpwo[k],@value,"0")
        }

     nwr = wval->ReadWords(TF)

         TT = wval[0];

        if ( !(TT @= ""))  sWo(TASK_wo,@value,TT)
        ti = 0;
        while (1) {

          nwr = wval->ReadWords(TF)
	  
          atpt = wval[0];
	  err = f_error(TF)
<<"$nwr <|$atpt|> $err\n"

            if ( nwr <= 0) {
	             break;
            }
//DBG"TP $atpt $ti \n"
        //  key[ti] = atpt
        //  wi = find_key(key[ti])
	  
        

          setWoValue (tpwo[ti], atpt)
          ti++;
	  if (ti > LastTP)
	     break;
        }
      c_file(TF)
    }
    
    <<"DONE $_proc\n"
}
//==================================================

void readTaskFile(str taskfile) 
{
svar wval;
     TF= ofr(taskfile)


  <<"%V $taskfile  $TF $SetWoT \n";
ans=query("$TF read $taskfile ? ");


    if (TF != -1) {

      ti = 0

     seterrornum(0)

        for (k = 0 ; k < Maxtaskpts ; k++) {
	
          sWo(tpwo[k],@value,"")
          //sWo (ltpwo[k],@value,"0")
        }

     nwr = wval->ReadWords(TF)

         TT = wval[0];

        if ( !(TT @= "")) {
	  sWo(TASK_wo,@value,TT)
        }
	
        ti = 0;
        while (1) {
      
          nwr = wval->ReadWords(TF)
	  
          atpt = wval[0];
	  err = f_error(TF)
<<"$nwr <|$atpt|> $err\n"

            if ( nwr <= 0) {
	             break;
            }
//DBG"TP $atpt $ti \n"
        //  key[ti] = atpt
        //  wi = find_key(key[ti])
	  
        

          setWoValue (tpwo[ti], atpt)
          ti++;
	  if (ti > LastTP)
	     break;
        }
      cf(TF)
    }
    
    <<"DONE $_proc\n"
}
//==================================================

void write_task()
{

  tsk_file = "K_1.tsk"

  tsk_file=query_w("DATA_FILE","write to file:",tsk_file)

    if (tsk_file == "")       return
    
     val = getWoValue(TASK_wo)

    tsk_file = scat("TASKS/",tsk_file,".tsk")
    
    WF=ofw(tsk_file)
    w_file(WF,"type $val  %6.3f $totalK \n")

    
    
        for (i = 0 ; i <  Ntaskpts; i++) {
          
        w_file(WF,"$Wleg[i]->Place  %6.0f $Wleg[i]->msl  $Wleg[i]->fga \n");
          
        }
      c_file(WF)
    
}
//==================================================


proc set_task()
{
  //chk_start_finish()
  //set_wo_task(tw)
  
  //total = taskDistance()

  drawTask(mapwo,"red")
 // tot_units = scat(total,Units)

}
//==================================================

proc grid_label(int wid)
{
  ts = 0.01

# incr should set format
  float rx;
  float ry;
  float rX;
  float rY;

  sWo(wid,@penhue,BLACK_)
  
  RS= wgetrscales(wid);

//DBG"%V$RS \n"

  rx= RS[1];
  ry= RS[2];
  rX= RS[3];
  rY= RS[4];
 // DBG"%V $rx $ry $rX$rY\n"


 putMem("LongW","$rx",1)
 putMem("LongE","$rX",1)
 putMem("LatS","$ry",1)
 putMem("LatN","$rY",1)

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
          axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f")
        }
        else {
          axnum(wid,1,rx,rX,2*x_inc,-1.5,"3.1f")
        }
    }

    if ( y_inc != 0.0) {
      //ticks(wid,2,ry,rY,y_inc,ts)
      axnum(wid,2,ry,rY,2*y_inc,-2.0,"2.1f")
    }

  sWo(wid,@clipborder);
}
//==================================================

proc magnify(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)


  drx = (rX - rx)/4.0
  dry = (rY - ry)/4.0

  R[0] = rx +drx
  R[1] = ry +dry
  R[2] = rX -drx
  R[3] = rY -dry

  ff=show_curs(1,-1,-1,"resize")
  aw=select_real(w_num,&R[0])
  ff=show_curs(1,-1,-1,"curs_font")

    if (aw != -1) {
      xr0 = R[0]
      xr1 = R[2]
      yr0 = R[1]
      yr1 = R[3]

      xr = xr1-xr0
      set_w_rs(w_num,xr0,yr0,xr1,yr1)
      w_clip_clear(w_num)
      ff=w_redraw_wo(w_num)
      x0 = 0
    }
    w_store(w_num)
}
//==================================================

proc new_units()
{
  Units = choice_menu("Units.m")
}
//==================================================

proc new_coors(int w_num)
{
#  par_menu = "cfi/tcoors.m"
  par_menu = "tcoors.m"
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)


  set_menu_value(par_menu,"x0",rx)
  set_menu_value(par_menu,"x1",rX)
  set_menu_value(par_menu,"y1",rY)
  set_menu_value(par_menu,"y0",ry)



  value = table_menu(par_menu)

    if ( value == 1 ) {

      xr0= get_menu_value(par_menu,"x0")
      xr1= get_menu_value(par_menu,"x1")
      yr1= get_menu_value(par_menu,"y1")
      yr0= get_menu_value(par_menu,"y0")

      xr = xr1-xr0
      ff=set_w_rs(w_num,xr0,yr0,xr1,yr1)
      ff=w_clip_clear(w_num)
      ff=w_redraw_wo(w_num)
      x0 = 0
      DrawMap(w_num)
    }
}
//==================================================

void zoom_to_task(int w_num, int draw)
{
 // this needs to find rectangle - just bigger than task
  // found via computetaskdistance



  ff=sWo(w_num,@scales,Max_W,Min_lat,Min_W,Max_lat)
  if (draw) {
  gflush()

  DrawMap(w_num)
  drawTask(w_num,"black")
//  sWo(w_num,@showpixmap)
  }
}
//==================================================

proc zoom_up(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dy = Fabs(ry-rY)/4
  ry += dy
  rY += dy
  ff=set_w_rs(w_num,rx,ry,rX,rY)
  ff=w_clip_clear(w_num)
#  ff=w_redraw_wo(w_num)
  DrawMap(w_num)
  drawTask(w_num,"red")
}
//==================================================

proc zoom_in(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rx -= dx
  rX += dx
  ry += dy
  rY -= dy

  ff=set_w_rs(w_num,rx,ry,rX,rY)
  ff=w_clip_clear(w_num)
  ff=w_redraw_wo(w_num)
  DrawMap(w_num)
  drawTask(w_num,"red")
}
//==================================================

proc  draw_the_task ()
{
  DrawMap(tw)
  drawTask(tw,"red")
}
//==================================================

proc zoom_out(int w_num,int draw)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rx += dx
  rX -= dx
  ry -= dy
  rY += dy

  ff=set_w_rs(w_num,rx,ry,rX,rY)

  if (draw) {
  draw_the_task()
  }
}
//==================================================

proc zoom_rt(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rX -= dx
  rx -= dx
  set_w_rs(w_num,rx,ry,rX,rY)
  w_clip_clear(w_num)
  ff=w_redraw_wo(w_num)
  DrawMap(w_num)
  drawTask(w_num,"red")
}
//======================================//


proc zoom_lt(int w_num)
{
  ww= get_wcoors(w_num,&rx,&ry,&rX,&rY)

  dx = Fabs(rx-rX)/4
  dy = Fabs(ry-rY)/4
  rX += dx
  rx += dx
  ff=set_w_rs(w_num,rx,ry,rX,rY)
  ff=w_clip_clear(w_num)
  ff=w_redraw_wo(w_num)
  DrawMap(w_num)
  drawTask(w_num,"red")
}

//======================================//
proc reset_map()
{
  sWo(mapwo,@scales,LongW,LatS,LongE,LatN)
  DrawMap(mapwo)
}
//======================================//

void insert_tp(int wt)
{
/// click on tpwo
//wt = Witp;


             if (wt < LastTP ) {

                for (i = LastTP ; i > wt ; i--) {
                  tval = getWoValue(tpwo[i-1])
                 <<"$i <|$tval|>  \n"
                  setWoValue (tpwo[i],tval)
		  kt = Taskpts[i-1]
		  Taskpts[i] = kt;
                }
              }

           setWoValue (tpwo[wt],"XXX")

           sWo(tpwo[wt],@redraw);
	    
	   MouseCursor("hand", tpwo[9], 0.5, 0.5);  

          eventWait();
          ntp = ClosestTP(_erx,_ery);

           if (ntp >= 0) {

             Wtp[ntp]->Print()

             nval = Wtp[ntp]->GetPlace()

<<" found %V $ntp $nval \n"

             //setWoValue (tpwo[wt],ntp,1)
	     setWoValue (tpwo[wt],nval,0)
                
             Taskpts[wt] = ntp;

          //  ret = ntp;
              Task_update = 1;
              MouseCursor("cross", tpwo[9], 0.5, 0.5);  
              sWo(tpwos,@redraw);
              }
             Ntaskpts++;
          
/// pick a tp
/// insert before

}
//======================================//
void delete_tp(int wt)
{
//int wt = Witp;
int kt = 0;
	          kt = Taskpts[wt];
//              <<"$_proc delete $_ewoname $wt $Wtp[kt]->Place \n"
              <<"$_proc delete $_ewoname $wt $kt \n"
               if (wt == LastTP) {
                    setWoValue (tpwo[LastTP],"")
		    Taskpts[LastTP] = 0;
               }
	       else {
	       j= wt+1;
               for (i = wt ; i < (Ntaskpts-1) ; i++) {
                 // tval = getWoValue(tpwo[i+1])
	          kt = Taskpts[i+1];

                  Taskpts[i] = kt;
		 
                  if (kt == 0) {
                      sWo (tpwo[j],@value," ",@redraw)
                     break;
		  }
                  plc = Wtp[kt]->Place;
        // <<"del $i $kt  $plc \n"
                  sWo (tpwo[i],@value,plc)
		  j++;
                }
		<<"last was $j $plc\n"
		  Taskpts[j-1] = 0;
		  sWo (tpwo[j-1],@value," ",@redraw)
              }
              sWo(tpwos,@redraw);
	      Ntaskpts--;
}
//======================================//
proc delete_alltps()
{
# get_tp
                for (i = 0 ; i <Ntaskpts ; i++) {
                  ff=setWoValue (tpwo[i],"")
                  setWoValue (ltpwo[i],"0",1)
                }

              Ntaskpts = 0;
}
//======================================//




igc_file = "dd.igc"

proc plot_igc(int w)
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
<<"$_proc $SetWoT\n"
phere = "$_proc";
  // taskpts are in tpwo[i] values  10 max
     Ntaskpts = 0;
     for (k = 0 ; k < Maxtaskpts ; k++) {

          tval = getWoValue(tpwo[k])
	  <<"<|$k|> <|$tval|> \n"
	  
          if (slen(tval) > 1) {
          WH=searchRecord(RF,tval,0,0)
	  <<"%V $k $WH\n"
	  
          index = WH[0][0]
          if (index >=0) {
          ttp = RF[index];
	  <<"<|$Ntaskpts|> $ttp \n" 
//          Tasktp[Ntaskpts]->TPset(RF[index])
          Taskpts[k] = index;
          Ntaskpts++;
	  }
          }
    }
   <<"%V $Ntaskpts\n"
    for (k = 0; k < Ntaskpts ; k++) {
       index= Taskpts[k]
       Wtp[index]->Print();
     }

<<"DONE $phere $_proc\n"

}
//============================

proc chk_start_finish()
{


  lval = ""
  val= "OB"
  val = getWoValue(TASK_wo)

<<"$_proc <|$val|> \n"

    put_mem("TT",val)

    if ((val == "TRI")) {
      val = getWoValue(start_wo)
      setWoValue (tpwo[3],val)
      setWoValue (tpwo[4],"")
      setWoValue (finish_wo,val)
      Ntaskpts = 3
    }

    if (val == "OB") {
      val = getWoValue(start_wo)
      setWoValue (tpwo[2],val)
      setWoValue (tpwo[3],"")
      setWoValue (finish_wo,val)
      Ntaskpts = 2
    }

    if ((val == "SO") ) {
      val = getWoValue(tpwo[1])
      setWoValue (finish_wo,val)
      Ntaskpts = 1
    }

    if ((val == "DL") ) {
      val = getWoValue(tpwo[2])
      setWoValue (finish_wo,val)
      Ntaskpts = 2
    }

    if ((val == "W") ) {
      val = getWoValue(tpwo[4])
      setWoValue (finish_wo,val)
      Ntaskpts = 5
    }

    if (val == "MT")  {
      Ntaskpts = 0
      mti = 1

        while (1) {
          val = getWoValue(tpwo[mti])
             <<"$val $mti \n"
            if ( (val == "") ) {
              break
            }
          mti++
          lval = val
          Ntaskpts++
	  if (mti > 9)
	     break;
        }
      <<"MT lval $lval $Ntaskpts $finish_wo \n")
      setWoValue (finish_wo,lval)
    }

}
//============================

proc task_menu(int w)
{
<<"$_proc   $w\n"

  ur_c=choicemenu("MENUS/task_opts.m")
  if (ur_c == "NULL_CHOICE") {
         return
  }
<<"chose $ur_c \n"

  if (ur_c == "zoom_to_task") {
            zoom_to_task(mapwo,1)
  }

   else  if (ur_c == "save_pic") {
       save_image(w,"task_pic")
    }
    
    else if (ur_c == "magnify") {
      magnify(w)
      DrawMap(w)
    }

    else if (ur_c == "plot_igc") {
       plot_igc(w)
    }

    else if (ur_c == "delete_all") {
      delete_alltps()
      DrawMap(w)
    }
    else if (ur_c == "coors") {
      new_coors(w)
    }
    
    else if (ur_c == "units") {
      new_units()
      set_task()
    }

    else if (ur_c == "set") {
      DrawMap(mapwo)
      drawTask(mapwo,"red")

    }

    else if (ur_c == "reset") {
      reset_map()
    }
    else if (ur_c == "read_task") {

      read_task()
      setWoTask()
     // zoom_to_task(mapwo,1)
      //zoom_out(tw,0)
      //zoom_out(tw,1)
      
    }

    else if (ur_c == "screen_print") {
      screen_print()
      }
      
    else if (ur_c == "write_task") {
      write_task()
    }
    
/*
    else if (ur_c == "get_finish") {
    //  ff=w_show_curs(tw,1,"left_arrow")
      PickaTP()
      set_task()
    }
*/


//for (i=0; i < Ntaskpts; i++) {
//<<"$i    $Taskpts[i]  Wtp[i]->Place\n"
// }



}


//=====================================//


proc compute_leg2(int t_1,int t_2)
{

  leg = t_1

  kk = t_2

  L1 = LA[leg]
  L2 = LA[kk]

  if (L1 < Min_lat)      Min_lat = L1
  if (L1 > Max_lat)      Max_lat = L1
  if (L2 > Max_lat)      Max_lat = L2
  if (L2 < Min_lat)      Min_lat = L2

    //  DBG"lats are $L1 $L2 \n"

  lo1 = LO[t_1]
  lo2 = LO[t_2]

  if (lo1 < Min_W)      Min_W = lo1
  if (lo1 > Max_W)      Max_W = lo1

    //  DBG"longs are $lo1 $lo2 \n"

  rL1 = d2r(L1)
  rL2 = d2r(L2)

  rlo1 = d2r(lo1)
  rlo2 = d2r(lo2)

  D= Sin(rL1) * Sin(rL2) + Cos(rL1) * Cos(rL2) * Cos(rlo1-rlo2)
			  //  DBG" $D $(typeof(D)) \n"
  D= Acos(D)

  dD= r2d(D)

			  //print(D," ",dD,"\n")

  N = 0.5 * (7915.6 * 0.86838) * D;

  print("dist = ",N," nm","\n")

  sm = N * nm_to_sm

  print("dist = ",sm," sm","\n")

  km = N * nm_to_km

    //DBG"dist = km $km \n"

  return (km)
}
//============================//
proc setup_legs()
{
<<"$_proc \n"
/{/*
    suk = 0
    print("setup_legs ",wox," ",woy," ",woX," ",woY)
    tp_name = scat("PKTPT_",suk)
    gtpwo[suk]=w_set_wo(tw,WBS,tp_name,1,wogx,woy,wogX,woY)

  for (suk = 1 ; suk <= Ntp ; suk++) {
    woY = woy - ysp
    woy = woY - ht
    tp_name = scat("TP:",suk)
    tpwo[suk] = w_set_wo(tw,WBV,tp_name,1,wox,woy,woX,woY)
    tp_name = scat("LEG_",suk)
    ltpwo[suk]=w_set_wo(tw,WSV,tp_name,1,wolx,woy,wolX,woY)
    tp_name = scat("PKTPT_",suk)
    gtpwo[suk]=w_set_wo(tw,WBS,tp_name,1,wogx,woy,wogX,woY)
  }
/}*/
}
//=====================================//

proc the_menu (str c)
{
<<"$_proc \n"
          if (c == "zoom_out") {
            zoom_out(tw,1)
            return
          }

          if (c == "zoom_to_task") {
            zoom_to_task(tw,1)
            return
          }

          if (c == "zoom_up") return  zoom_up(tw)
          if (c == "zoom_in") return  zoom_in(tw)
          if (c == "zoom_rt") return   zoom_rt(tw)
          if (c == "zoom_lt") return zoom_lt(tw)

          if (c == "TASK_MENU" ) {

           return  task_menu(tw)

          }
          if (c == "REDRAW" ) return


          if ( c == "TYPE" ) {
            val=""
           // l=sscan(&MS[5],&val)
            //chk_start_finish()
         //   set_wo_task(mapwo)
            total = taskDistance()
            DrawMap(mapwo)
            drawTask(mapwo,"blue")
            
            return
          }

   if ( (c == "Start:") || (strcmp(c,"TP",2) ==1) || (c == "Finish:") ) {
           // set_wo_task(tw)
            //chk_start_finish()
            total = taskDistance()
            DrawMap(mapwo)
            drawTask(mapwo,"red")

            return
          }


}
//=====================
proc conv_lng(str lng)
  {

  lngdeg = spat(lng,",",-1,1)

  lngmin = spat(lng,",",1,1)

  WE = spat(lngmin,",",1,-1)
  lngmin = spat(lngmin,",","<",">")
  lngmin = lngmin/60.00

  lngdec = lngdeg + lngmin + 0.00001

    if (WE == "W") {
         lngdec *= -1.0
	   }
  }
//=========================

proc conv_lat (str lat)
  {

 latdeg = spat(lat,",",-1,1)

 latmin = spat(lat,",",1,1)

 NS = spat(latmin,",",1,-1)

 latmin = spat(latmin,",","<",">")
 latmin = latmin/60.00
 latdec = latdeg + latmin

  }
//=========================

proc nearest (int tp)
{
  // compute distance from tp to others
  // if less than D
  // print

}
//====================//


proc spin()
{
 static int k = 0

 i = k % 4
  if (i == 0)
      DBG" \\ \r "
  else if (i == 1)
      DBG" | \r "
  else if (i == 2)
      DBG" -- \r "
  else
      DBG" / \r "
 k++
}
//===============================================



float IGCLONG[];
float IGCLAT[];
float IGCELE[];
float IGCTIM[];


proc IGC_Read(str igc_file)
{

DBG"%V $igc_file \n"

   T=fineTime();

   a=ofr(igc_file);

   if (a == -1) {
     DBG" can't open IGC file $igc_file\n"
     return 0;
   }

    ntps =ReadIGC(a,IGCTIM,IGCLAT,IGCLONG,IGCELE);

    IGCELE *= 3.280839 ;

  //  IGCLONG = -1 * IGCLONG;
DBG"read $ntps from $igc_file \n"

   dt=fineTimeSince(T);
<<[_DB]"$_proc took $(dt/1000000.0) secs \n"
    cf(a);
   return ntps;
}
//========================

int Ntp = 0;

proc DrawMap(int wo)
{
//DBG"$_proc %V $wo\n"

  int msl;
  float lat;
  float longi;
  str mlab;
  int is_an_airport = 0;

      sWo(wo,@clearpixmap,@clipborder);

//DBG"$mlab $(typeof(mlab))\n";
//DBG"%V $Ntp\n"
    for (k = 0 ; k < Ntp ; k++) {

       // is_an_airport = Wtp[k]->is_airport;

        mlab = Wtp[k]->Place;

//DBG"%V $k $mlab\n"

        if (!is_an_airport) {
         mlab = slower(mlab)
       }

//DBG"$k %V $is_an_airport  $mlab $(typeof(mlab))\n";
	
        msl = Wtp[k]->Alt;

        lat = Wtp[k]->Ladeg;

        longi = Wtp[k]->Longdeg;

//DBG"%V $k $mlab $msl $lat $longi $Wtp[k]->Ladeg\n"

        if ( msl > 7000) {
             Text(wo,mlab,longi,lat,0,0,1,RED_)
	     //DBG"above 7K $mlab\n"
        }
        else {
            if ( msl > 5000) {
             Text(wo,mlab,longi,lat,0,0,1,BLUE_)
	     	    // DBG"above 5K $mlab\n"
            }
            else {
	    	   //  DBG"below 5K $mlab\n"
              Text(wo,mlab,longi,lat,0,0,1,GREEN_)
            }
        }
    }

      sWo(wo,@showpixmap,@clipborder);
    
        grid_label(wo)

}
//====================================================
str TaskType = "MT";

proc DrawTask(int w,str col)
{

<<"$_proc   DrawTask $w $col\n"
   if ( Task_update) {
    TaskDistance();
  //  <<"$_proc  $TaskType $col $Nlegs \n"
    }
    if ( (TaskType == "OAR")   || (TaskType == "SO")) {

      index = Taskpts[0]
      index1 = Taskpts[1]
      plot(w,@line,Wtp[index]->Longdeg,Wtp[index]->Ladeg,Wtp[index1]->Longdeg,Wtp[index1]->Ladeg,col)

    }
    else {

    for (i = 0 ; i < (Ntaskpts-1) ; i++ ) { 

//   <<"$i %V $w, $Tasktp[i]->Longdeg $Tasktp[i]->Ladeg,$Tasktp[i+1]->Longdeg,$Tasktp[i+1]->Ladeg, $col \n "
      index = Taskpts[i]
      index1 = Taskpts[i+1]
      plot(w,@line,Wtp[index]->Longdeg,Wtp[index]->Ladeg,Wtp[index1]->Longdeg,Wtp[index1]->Ladeg,col)

    }

    }

 sWo(w,@showpixmap,@clipborder);
    

}
//=============================================

str Atarg="xxx";

int  PickTP(str atarg,  int wtp)

{
///
/// 
int ret = -1;
<<" looking for $atarg  $Atarg  $wtp\n"

       WH=searchRecord(RF,Atarg,0,0)
	  <<"%V $WH\n"
	  
          index = WH[0][0]
          if (index >=0) {
          ttp = RF[index];
<<" found $Atarg  $index\n"
<<"$ttp \n"
          Taskpts[wtp] = index;
          ret =index;
<<" found $Atarg $index $wtp $ttp\n"
         }

      return ret;
}
//=============================================


proc ClosestTP (float longx, float laty)
{
///
 T=fineTime();
 float mintp = 30;
 int mkey = -1;
 float ctp_lat;

int k = 3;
//DBG"%V $Wtp[0]->Ladeg \n"
//DBG"%V $Wtp[k]->Ladeg \n"
    ctp_lat = Wtp[k]->Ladeg;
//DBG"%V $ctp_lat \n"
    for (k = 0 ; k < Ntp ; k++) {

        ctp_lat =   Wtp[k]->Ladeg;

        longi = Wtp[k]->Longdeg;

        dx = Fabs(longx - longi);
        dy = Fabs(laty - ctp_lat);
        dxy = dx + dy;

        if (dxy < mintp) {
          mkey = k;
          mintp = dxy;
//DBG"%V $Wtp[k]->Ladeg $ctp_lat $longi $laty $longx  $dx $dy $Wtp[k]->Place \n"
      }

    }

   if (mkey != -1) {
DBG" found $mkey \n"
     Wtp[mkey]->Print()
   }

    dt=fineTimeSince(T);
DBG"$_proc took $(dt/1000000.0) secs \n"
     return  mkey;
}
//=============================================

proc ClosestLand(float longx,float laty)
{
 float mintp = 18000;
 int mkey = -1;
 int isairport = 0;
 float sa 
 float longa
 float lata
 float msl;
 float mkm;
 float ght;
 float sa;
 
  longa = longx;
  lata = laty;

    for (k = 0 ; k < Ntp ; k++) {

         isairport = Wtp[k]->GetTA();
//DBG"$_proc %V $isairport \n"
         if (isairport) { 
                msl = Wtp[k]->Alt;
                mkm = HowFar(lata,longa, Wtp[k]->Ladeg,Wtp[k]->Longdeg)
                ght = (mkm * km_to_feet) / LoD

//FIX_PARSE_ERROR                sa = Wtp[k]->Alt + ght + 2000


                sa = msl + ght + 2000

//DBG" $k $mkm $ght $sa \n"

          if (sa < mintp) {
          mkey = k
          mintp = sa
          }
      }

    }


   if (mkey != -1) {
DBG" found $mkey \n"
      Wtp[mkey]->Print()
   }
   return  mkey
}
//=============================================


int PickaTP(int itaskp)
{

// 
// use current lat,long to place curs
//
<<"$_proc $itaskp\n"
  int ret = -1;

  float rx;
  float ry;

  rx = MidLong;
  ry = MidLat;


    MouseCursor("left", mapwo, rx, ry);  // TBC

    Text(vptxt,"Pick a TP for the task ",0,0.05,1)

    sWi(vp,@tmsg,"Pick a TP for the task ")

          eventWait();

          gsync()

          sleep(0.2)

          ntp = ClosestTP(_erx,_ery);

        MouseCursor("hand");

        if (ntp >= 0) {

             Wtp[ntp]->Print()

             nval = Wtp[ntp]->GetPlace()

<<" found %V $ntp $nval  $itaskp\n"

            Taskpts[itaskp] = ntp;

            ret = ntp;
            Task_update = 1;
         }

   
 
      return ret;
}
//=============================================//



proc ComputeTC(int j, int k)
{
    float km = 0.0
    float tc = 0.0;
    L1 = Wtp[j]->Ladeg

    L2 = Wtp[k]->Ladeg

    lo1 = Wtp[j]->Longdeg

    lo2 = Wtp[k]->Longdeg

      tc = trueCourse(L1,lo1,L2,lo2)
      //DBG"%V$tc \n"
      return tc
}
//===========================//


float ComputeTPD(int j, int k)
{
<<" $_proc %V $j $k \n"
    float km = 0.0;

    L1 = Wtp[j]->Ladeg;

    L2 = Wtp[k]->Ladeg;

   DBG"%V $L1 $L2 \n"

    lo1 = Wtp[j]->Longdeg;

    lo2 = Wtp[k]->Longdeg;


   DBG"%V $lo1 $lo2 \n"
    rL2 = d2r(L2)
    rL1 = d2r(L1)

   DBG" %V $rL1 $rL2 \n"

    rlo1 = d2r(lo1);
    rlo2 = d2r(lo2);

    DBG" %V $rlo1 $rlo2 \n"

    D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2));

    DBG"%V $D\n"

    N = LegK * D

    km1 = N * nm_to_km


   // km2 = Gcd(L1,lo1 , L2, lo2 );
    km2 = Howfar(L1,lo1 , L2, lo2 );

    km = km2;
    //km->info(1)
  <<" %V   $LegK   $nm_to_km $km1 $km2\n" ;


    return km;
 }
//====================================//

void listTaskPts()
{
<<"%V $Ntaskpts\n"

               for (i = 0 ; i < Ntaskpts ; i++) {
	          if (Taskpts[i] == 0) 
		      break;
		      kt= Taskpts[i] \n"
                 <<"$i  $Taskpts[i]  $Wtp[kt]->Place \n"
                }
}	       
//====================================//
/*
proc ComputeTPD( j, k)
{

    float km = 0.0


//<<" $_proc %V $j $k \n"

    L1 = Wtp[j]->Ladeg

    L2 = Wtp[k]->Ladeg


    lo1 = Wtp[j]->Longdeg

    lo2 = Wtp[k]->Longdeg


    rL2 = d2r(L2)

    rL1 = d2r(L1)



    rlo1 = d2r(lo1)
    rlo2 = d2r(lo2)

    D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2))

    //          <<" %V $D  $LegK   $nm_to_km\n"

    N = LegK * D

    km = N * nm_to_km ;

    //       <<" %V  $N $km $(typeof(km))\n"
    ;

    return km
 }

*/
#
