//%*********************************************** 
//*  @script daytasker.asl 
//* 
//*  @comment cosas que hacer hoy 
//*  @release CARBON 
//*  @vers 1.7 N Nitrogen                                                 
//*  @date Tue Dec 25 08:06:37 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
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
 
 
 
 include "gevent.asl"
 include "debug.asl"

 include "dayt_menus.asl"
 include "dayt_procs.asl"
 
 
 //============== Variables =========================//
 
 // add favorites :  L,G,X,C
 Record DF[10];
 // Task,Priority,TimeEst,%Done,TimeSpent,Difficulty,Attribute,Score,Tags,
 
   DF[0] = Split("task?,3,30,0,0,1,?,0,",",")
   // use enum
   DF[1] = Split("Exercise,9,60,0,0,3,X,0,"",")
   DF[2] = Split("Guitar,8,30,0,0,3,G,0,"" ")
   DF[3] = Split("Spanish,8,30,0,0,3,L,0,"",")
   DF[4] = Split("PR/DSP,8,60,0,0,7,D,0,"",")    
 
 Record R[5+];
 Rn = 0;
 
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
   fname = _clarg[1];
 
 //=============== Init =========================//
 
 // if (! (fname @= "")) {
 
  if (fname @= "") {
 <<"fname  $fname null\n"
  }
 
  if (!(fname @= "")) {
    
    <<" using past day or setting up new/future day!\n";
 // TBD skip auto read below 
     ok=fexist(fname,0);
     if (ok) {
       ok = readTheDay(fname);
     }
 
     if (!ok) {
      <<" $fname not found - or bad day!\n"
      exit();
      }
   }
 //====================================//
 
 
 
 debugON()
 ///////// dt_log_file ////////////
 
  if (!ok) {
 
  ds= date(2);
  
 <<" reading today $ds ! \n" 
 
  ds=ssub(ds,"/","-",0)
  fname =  "dt_${ds}";
 
   fsz=fexist(fname,0);
 
 <<"$fname $fsz \n"
 
    if (fsz > 0) {
    ok = readTheDay(fname);
    }
    
  }
 
    if (!ok) {
  <<" creating today $ds ! \n"
    B= ofw("dt_${ds}")
    fname =  "dt_${ds}";
    R[0] = Split("Task,Priority,TimeEst,\%Done,TimeSpent,Difficulty,Attrb,Score,Tags",",");
    <<"$R[0] \n"
    R[1] = DF[1];
    R[2] = DF[2];
    R[3] = DF[3];
    R[4] = DF[4];    
    
    Rn = 5;
    writetable(B,R);
    cf(B);
    B= ofr("dt_${ds}")
    R= readRecord(B,@del,',');
    <<"$R \n"
    cf(B);
    }
 
 // format of daily activity/task
   
 
   sz = Caz(R);
 
   ncols = Caz(R[0]);
 
 <<"num of records $sz  num cols $ncols\n"
 
 //////////////////////////////////
 
 
 Graphic = CheckGwm()
 
 
      if (!Graphic) {
         X=spawngwm()
      }
 
 pname="ADDTASK";
 
 
 
 // dt_screen
 include "dayt_scrn.asl"
 
 include "gss.asl"
 

 
   Ncols = ncols;  // task, Priority, %Done, Duration, Difficulty,Score
 //  
 
 <<" back in main \n"
 
 gflush()
 
 
   sz= Caz(R);
   rows = sz;
   cols = Caz(R[0])
 
   tags_col = cols-1;
   
  sWo(cellwo,@setrowscols,rows+5,cols+1);
  
 <<"%V$rows $sz \n"
 
 
     for (i = 0; i< rows ; i++) {
      for (j = 0; j< cols ; j++) {
         if ((i%2)) {
              sWo(cellwo,@cellbhue,i,j,LILAC_);         
 	}
 	else {
               sWo(cellwo,@cellbhue,i,j,YELLOW_);
 	 }
        }
      }
 
 //    colorRows(rows,cols);
 
   for (i = 0; i < rows;i++) {
     <<"[${i}] $R[i]\n"
   }
 
     sWo(cellwo,@cellval,R);
 
      //rows = sz;
    
    sWo(cellwo,@setrowscols,rows+10,cols+1);
    sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
 
 // sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
    sWi(vp,@redraw)
 
    sWo(ssmods,@redraw)
 
    sWo(cellwo,@redraw);
 
    sWo(cellwo,@redraw);
 
    swaprow_a = 1;
    swaprow_b = 2;
 
    swapcol_a = 1;
    swapcol_b = 2;
 <<"%V $cellwo\n"

 
   while (1) {
 
          eventWait();
 
 //   <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"
 
        //colorRows(rows,cols);
 
          if (_erow > 0) {
             the_row = _erow;
          }
 
        if (_ewoid == cellwo) {
        
 
 	               if (_ebutton == LEFT_) {
                        _ecol->info(1);
 	                _erow->info(1);
                          if (_ecol == PriorityCol) {
                              setPriority(_erow,_ecol);
                          }
                          else if (_ecol == PCDoneCol) {
                              PCDONE(_erow);
                          }			 
                          else if ((_ecol == TimeEstCol) \
 			      || (_ecol == DurationCol)) {
                              HowLong(_erow,_ecol);
                          }
                          else if (_ecol == DiffCol) {
                              setDifficulty(_erow,_ecol);
                          }
                          else if (_ecol == AttrCol) {
                              setAttribute(_erow);
                          }			 			  
                         else {
                           getCellValue(_erow,_ecol);
                          }
			  SCORE();
                         }
             
          sWo(ssmods,@redraw);
       
 
         whue = YELLOW_;
 	
         if (_ecol == 0  && (_erow >= 0) && (_ebutton == RIGHT_)) {
           if ((_erow % 2)) {
            whue = LILAC_;
 	 }
 
          sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 
 
          swaprow_b = swaprow_a;
 	  swaprow_a = _erow;
 	 
 <<"%V $swaprow_a $swaprow_b\n"
 
          sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
          }
                
              
       if (_erow == 0 && (_ecol >= 0) && (_ebutton == RIGHT_)) {
 
          sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);         	 	 
          swapcol_b = swapcol_a;
  	 swapcol_a = _ecol;
          sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 
 <<"%V $swapcol_a $swapcol_b\n"
          }
 
         sWo(cellwo,@redraw);
 
         if (_erow == 0 && (_ecol == tags_col) && (_ebutton == RIGHT_)) {
                <<"Clear tags \n"
                 clearTags();   
         }
 
         if (_erow > 0 && (_ecol == tags_col) && (_ebutton == RIGHT_)) {
                <<"mark tags <|$R[_erow][tags_col]|>\n"

                if (R[_erow][tags_col] @= "x") {
		R[_erow][tags_col] = " "
 		sWo(cellwo,@cellval,_erow,tags_col," ")
		}
		else {
		R[_erow][tags_col] = "x"
 		sWo(cellwo,@cellval,_erow,tags_col,"x")
                }
 		sWo(cellwo,@celldraw,_erow,tags_col)
         }
 
    }
    else {
         if (_ename @= "PRESS") {
            <<"PRESS $_ename  $_ewoname !\n"
 
          if (!(_ewoname @= "")) {
          
             $_ewoname();
 
             <<" after indirect callback\n"
 
            }
         }
       }
          sWi(vp,@redraw);
 }
 
 
 
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
 
 
 
 
 /}*/
 