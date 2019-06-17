//%*********************************************** 
//*  @script daytasker.asl 
//* 
//*  @comment  cosas que hacer hoy 
//*  @release CARBON 
//*  @vers 1.9 F Fluorine                                                  
//*  @date Sat Apr 20 10:02:23 2019 
//*  @cdate Wed Jan  9 10:54:35 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


 ////////////  DAYTASKER   /////////////
 
 
 //  each  cell has an input text function
 // 
 
 // open a csv/tsv/rec file
 // read contents and set up a spreadsheet
 // gui controls direct  manipulation of the
 // record data (asl side)
 // and the sheet is update xgs sid
 // user can enter text into cells via the gui interface
 
 //
 //  need a rapid and smart update changes only
 //
 
 // description pc_done category priority time_est %Done time_taken Score   ...
 
 
 include "debug.asl"
 
 scriptDBON();
 debugON();
  setdebug(1,@~keep,@~pline)
 include "gevent.asl"
 include "dayt_menus.asl"
 include "gss.asl"
 include "dayt_procs.asl" // has to come after gss to overload 

 include "hv.asl"
 //============== Variables =========================//

//setdebug(1,@trace)


 // add favorites :  L,G,X,C

 // Task,Priority,TimeEst,PCDone,TimeSpent,Difficulty,Attribute,Score,Tags,
   i =0;
   DF[i++] = Split("task?,4,30,0,0,3,?,0,,",',') ; // default for add additional task
   DF[i++] = Split("Exercise,9,70,0,1,7,X,0,,",',')
   DF[i++] = Split("Guitar,8,30,0,0,3,G,0,,",44)
   DF[i++] = Split("Piano,8,30,0,0,3,G,0,,",44)   
   DF[i++] = Split("Spanish,8,30,0,0,3,L,0,,",44)
   DF[i++] = Split("French,8,30,0,0,3,L,0,,",44)
   DF[i++] = Split("German,8,30,0,0,3,L,0,,",44)   
   DF[i++] = Split("PR/DSP,8,60,0,0,8,D,0,,",44)    

 

 
 int ok = 0;
 
 // make this an enum
 // actually want to read and assign these from
 // the read in csv file
 // so they can be arranged to suit
 // also additional other task attributes can be added
 //

 PriorityCol= 1;
 TimeEstCol= 2;
 PCDoneCol= 3;
 DurationCol= 4;
 DiffCol= 5;
 AttrCol= 6;
 ScoreCol= 7;
 
 
 //==============================================//
 
 
 //=============== CL Options ===================//
 //DebugON();

  fname = ""

   if (argc() >=1) {
    fname = _clarg[1];
  }
 //=============== Init =========================//


  today = date(2);

  jdayn = julian(today)

  yesterday = julmdy(jdayn-1);
 
  tomorrow = julmdy(jdayn+1);

<<"%V  $jdayn $yesterday $today  $tomorrow\n"

  read_the_day = 0;

   if (fname @= "") {
        fname = "today"
   }

  if (fname @= "today") {
 <<[_DB]"look/edit today \n"
   ds=ssub(today,"/","-",0)
   fname =  "DT/dt_$ds";
  }
  else  if (scmp(fname,"dt-",3)) {
  <<"looking for a past day $fname\n"
     adjust_day = 1;
     // find the number
     num = atoi(scut(fname,3));
     db4 = julmdy(jdayn-num);
     // compute the day
     ds=ssub(db4,"/","-",0); 
     the_day = "DT/dt_${ds}";
     fname = the_day;
<<"looking for  $fname\n"
  }
  else if (fname @= "yesterday") {
 <<[_DB]"look/edit yesterday \n"
   ds=ssub(yesterday,"/","-",0)
   fname =  "DT/dt_$ds";
   fsz=fexist(fname,0);
 <<[_DB]"$fname $fsz \n"
  }
  else if (fname @= "tomorrow") {
 <<[_DB]"look/edit tomorrow \n"
   ds=ssub(tomorrow,"/","-",0)
   fname =  "DT/dt_$ds";
  }

   fsz=fexist(fname,0);
 <<[_DB]"$fname $fsz \n"
   if (fsz > 0) {
       read_the_day = 1;
   }
   else {
    makeMyDay(fname);
    ok = 1;
   }



////////////////////////////////////////////////////////

  if (read_the_day) {
   if (!(fname @= "")) {
    
  <<[_DB]" using past day or setting up new/future day!\n";
 // TBD skip auto read below 
     ok=fexist(fname,0);
     if (ok) {
       ok = readTheDay(fname);
     }
 
     if (!ok) {
      <<" $fname not found - or bad day!\n"
          makeMyDay(fname);
	  ok = 1;
      }
    }
   }
 //====================================//
  
 
 ///////// dt_log_file ////////////

  if (!ok) {
 
  
<<[_DB]" reading today $today ! \n" 
 
   ds=ssub(today,"/","-",0)
   fname =  "DT/dt_${ds}";
 
   fsz=fexist(fname,0);
 
<<[_DB]"$fname $fsz \n"
 
    if (fsz > 0) {
    ok = readTheDay(fname);
    }
    
  }


    if (!ok) {
//  <<[_DB]" creating today $ds ! \n"
    
    fname =  "DT/dt_${ds}";
    makeMyDay(fname);
    }
 
 // format of daily activity/task
   
 
   sz = Caz(R);

   ncols = Caz(R,0);
   ncols1 = Caz(R,1);
   ncols2 = Caz(R,2);
<<[_DB]"num of records $sz  num cols $ncols $ncols1 $ncols2\n"


 //////////////////////////////////

<<[_DB]"$R \n"

/{
<<[_DB]"%V$R[1][1] \n"
<<[_DB]"%V$R[1][2] \n"
<<[_DB]"%V$R[1][3] \n"
<<[_DB]"%V$R[1][4] \n"
<<[_DB]"%V$R[1][5] \n"
<<" //////////\n"
<<[_DB]"%V$R[2][1] \n"
<<[_DB]"%V$R[2][2] \n"
<<[_DB]"%V$R[2][3] \n"
<<[_DB]"%V$R[2][4] \n"
<<[_DB]"%V$R[2][5] \n"
/}



<<"before Graphic \n"

Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

Graphic = CheckGwm()

if (! Graphic) {

<<"can't go graphic!! exiting\n"
   exit()
}

OpenDll("plot") ; //  should be automatic -- but for XIC launch best to use!

 
 pname="ADDTASK";
 
 
include "tbqrd.asl" 

include "dayt_scrn.asl"
 
 
   Ncols = ncols;  // task, Priority, %Done, Duration, Difficulty,Score
  
   gflush()
 
 
   sz= Caz(R);

   rows = sz;

   cols = Caz(R,0)
 
   tags_col = cols-1;
<<"%V $cellwo\n"   

//ans=iread(":>")

   sWo(cellwo,@setrowscols,rows+5,cols+1); 

use_incl_vers = 1;
use_main_vers = 0;


   if (use_incl_vers) {
      colorRows(rows,cols);
   }

/// rebuild arg list after proc ??

  // testargs(1,sz,rows,cols,tags_col,use_incl_vers);

 if (use_main_vers) {
     j = cols-1;
     for (i = 0; i < rows ; i++) {
        if ((i%2)) {
              sWo(cellwo,@cellbhue,i,1,i,j,LIGHTGREEN_);         
 	}
 	else {
	     sWo(cellwo,@cellbhue,i,1,i,j,LIGHTBLUE_);         
 	}
      }
   }
   



  
 <<[_DB]"%V$rows $sz \n"


   for (i = 0; i < rows;i++) {
<<[_DB]"[${i}] $R[i]\n"
   }
 
    sWo(cellwo,@cellval,R);
 
      //rows = sz;
    
    sWo(cellwo,@setrowscols,rows+10,cols+1);
    sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
 
 // sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
    sWi(vp,@redraw)
 
    sWo(ssmods,@redraw)
    sWo(cellwo,@setcolsize,3,0,1);
    sWo(cellwo,@redraw);

/{/*
    swaprow_a = 1;
    swaprow_b = 2;
    swapcol_a = 1;
    swapcol_b = 2;
/}*/
// <<[_DB]"%V $cellwo\n"



   ok=_ele_vers->info(1)
   <<"%V $ok\n"
   sWo(txtwo,@textr,"version $_ele_vers",0.1,0.2);

//   ok= abc->info(1)
//      <<"%V $ok\n"


   SCORE();
   sWi(vp,@redraw);


//ans=i_read("exit?");
//if (ans @="y") {
// exit()
//}


int mr =0;
int mc = 0;

   while (1) {
   //<<"%V $_erow\n"

          
          eventWait();
          //sWi(vp,@redraw);   
//   <<[_DB]" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"
 <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"
 
// colorRows(rows,cols);
          mr = _erow;
	  mc = _ecol;
	  
          if (mr > 0) {
             the_row = mr;
          }
 
        if (_ewoid == cellwo) {
        
 
 	               if (_ebutton == LEFT_ && mr > 0) {
                        //mc->info(1);
 	                //mr->info(1);
                          if (mc == PriorityCol) {
                              setPriority(mr,mc);
                          }
                          else if (mc == PCDoneCol) {
                              PCDONE(mr,PCDoneCol );
                          }			 
                          else if ((mc == TimeEstCol) \
 			      || (mc == DurationCol)) {
                              HowLong(mr,mc);
                          }
                          else if (mc == DiffCol) {
                              setDifficulty(mr,mc);
                          }
                          else if (mc == AttrCol) {
                              setAttribute(mr,mc);
                          }			 			  
                         else {
                              getCellValue(mr,mc);
                          }
			  SCORE();
                         }
             
          sWo(ssmods,@redraw);
       
 
         whue = YELLOW_;
 	
         if (mc == 0  && (mr >= 0) && (_ebutton == RIGHT_)) {
           if ((mr % 2)) {
            whue = LILAC_;
 	   }
 
          sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 
 
          swaprow_b = swaprow_a;
 	  swaprow_a = mr;
 	 
// <<[_DB]"%V $swaprow_a $swaprow_b\n"
 
          sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
          }
                
              
       if (mr == 0 && (mc >= 0) && (_ebutton == RIGHT_)) {
 
          sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);   
          swapcol_b = swapcol_a;
  	  swapcol_a = mc;
          sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 

<<[_DB]"%V $swapcol_a $swapcol_b\n"
          }
 
         sWo(cellwo,@redraw);
 
         if (mr == 0 && (mc == tags_col) && (_ebutton == RIGHT_)) {
               
                 clearTags();   
         }
 
         if (mr > 0 && (mc == tags_col) && (_ebutton == RIGHT_)) {
<<[_DB]"mark tags <|$R[mr][tags_col]|>\n"

                if (R[mr][tags_col] @= "x") {
		R[mr][tags_col] = " "
 		sWo(cellwo,@cellval,mr,tags_col," ")
		}
		else {
		R[mr][tags_col] = "x"
 		sWo(cellwo,@cellval,mr,tags_col,"x")
                }
 		sWo(cellwo,@celldraw,mr,tags_col)
         }
 
    }
    else {
         if (_ename @= "PRESS") {
<<[_DB]"PRESS $_ename  $_ewoname !\n"
 
          if (!(_ewoname @= "")) {
          
             $_ewoname();
 
<<[_DB]" after indirect callback\n"
 
            }
         }
       }
          sWo(cellwo,@setcolsize,3,0,1);
          sWi(vp,@redraw);
	  
 }
 //============================================//
 
 
  exit()
 
 
 
 
 
 /{/*
 
   add text edit window - for editing of task description -done
   menus for input/change of time_est,duration, scoring -done
   if mod %done > 0 --- a function should update score
 
 
   copy over tasks needing to be done from previous days
  
   maintenance tasks , Lang, Guitar,Piano Exercise  - PR  
   need scoring function  for the day -DONE
   
   daily message / ?email alert - midday/teatime / 9pm lastcall
   to prompt
 
 
 
   FIX -- if first operation is edit - subsequent row operations fail
 
 
  In order to use as XIC -- need to exit without any operations first
  then can use XIC version??
 
 
 /}*/
 