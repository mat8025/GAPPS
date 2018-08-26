///
///
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



//=============== MENUS=================//
A=ofw("Howlong.m")
<<[A],"title HowLong\n"
<<[A],"item 10m M_VALUE 10\n"
<<[A],"item 15m M_VALUE 15\n"
<<[A],"help half-hour\n"
<<[A],"item 1/2h M_VALUE 30\n"
<<[A],"help half-hour\n"
<<[A],"item 1hr M_VALUE 60\n"
<<[A],"help 1 hour\n"
<<[A],"item 90m M_VALUE 90\n"
<<[A],"help hour and half\n"
<<[A],"item 2hr M_VALUE 120\n"
<<[A],"help two hours\n"
<<[A],"item ? C_INTER "?"\n"
<<[A],"help set mins\n"
cf(A)
//=================================//

A=ofw("Favorites.m")
<<[A],"title Favorites\n"
<<[A],"item Guitar M_VALUE 1\n"
<<[A],"help play/practice\n"
<<[A],"item Language M_VALUE 2\n"
<<[A],"help converse\n"
<<[A],"item Exercise M_VALUE 3\n"
<<[A],"help burn fat\n"
<<[A],"item PR/DSP M_VALUE 4\n"
<<[A],"help learn/code\n"
cf(A)
//==============================//

A=ofw("PCdone.m")
<<[A],"title PCdone\n"
<<[A],"item 5% M_VALUE 5\n"
<<[A],"item 10% M_VALUE 10\n"
<<[A],"item 25% M_VALUE 25\n"
<<[A],"item 50% M_VALUE 50\n"
<<[A],"item 75% M_VALUE 75\n"
<<[A],"item 90% M_VALUE 90\n"
<<[A],"item 100% M_VALUE 100\n"
cf(A)
//==============================//
A=ofw("Priority.m")
<<[A],"title Priority 1-7\n"
<<[A],"item 1 M_VALUE 1\n"
<<[A],"item 2 M_VALUE 2\n"
<<[A],"item 3 M_VALUE 3\n"
<<[A],"item 4 M_VALUE 4\n"
<<[A],"item 5 M_VALUE 5\n"
<<[A],"item 6 M_VALUE 6\n"
<<[A],"item 7 M_VALUE 7\n"
cf(A)
//==============================//
A=ofw("Difficulty.m")
<<[A],"title Difficulty\n"
<<[A],"item 1 M_VALUE 1\n"
<<[A],"item 2 M_VALUE 2\n"
<<[A],"item 3 M_VALUE 3\n"
<<[A],"item 4 M_VALUE 4\n"
<<[A],"item 5 M_VALUE 5\n"
<<[A],"item 6 M_VALUE 6\n"
<<[A],"item 7 M_VALUE 7\n"
cf(A)

//============== PROCS =================//

proc readTheDay( fnm)
{
 int isOK = 0;
  
  B= ofile(fnm,"r+")

<<" $_proc $fnm $B\n" 
  if (B != -1) {

   fseek(B, 0,0);
 
   
     while (1) {
       res = readline(B)
    //   <<"$res\n"
        if (f_error(B) == EOF_ERROR_) {
	   break;
	}
       if ((slen(res)) > 1 && !scmp(res,"#",1)) {
 <<"$res\n"
        R[Rn] = Split(res,",");
        Rn++;
        if (Rn > 100) {
           break;
        }
	}
     }
      isOK = 1;
      cf(B);
   }
<<" $_proc returns $isOK \n";
  return isOK;
}
//=================================//

//============== Variables =========================//

// add favorites :  L,G,X,C
Record DF[10];
// Task,Priority,TimeEst,%Done,Duration,Difficulty,Score,Tags,

  DF[0] = Split("task?,3,30,0,0,1,0,?,",",")
  // use enum
  DF[1] = Split("Guitar,6,30,0,0,1,0,G,",",")
  DF[2] = Split("Spanish,6,30,0,0,1,0,L,",",")
  DF[3] = Split("Exercise,6,60,0,0,1,0,X,",",")
  DF[4] = Split("PR/DSP,6,60,0,0,1,0,D,",",")    

Record R[5+];
Rn = 0;

int ok = 0;

// make this an enum
PriorityCol= 1;
TimeEstCol= 2;
PCDoneCol= 3;
DurationCol= 4;
DiffCol= 5;


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
   R[0] = Split("Task,Priority,TimeEst,\%Done,Duration,Difficulty,Score,Attrb,Tags",",");
   <<"$R[0] \n"
   R[1] = DF[1];
   R[2] = DF[2];
   Rn = 3;
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

include "dayt_procs.asl"

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
                             setPriority(_erow);
                         }
                         else if (_ecol == PCDoneCol) {
                             PCDONE(_erow);
                         }			 
                         else if ((_ecol == TimeEstCol) \
			      || (_ecol == DurationCol)) {
                             HowLong(_erow,_ecol);
                         }
                         else if (_ecol == DiffCol) {
                             setDifficulty(_erow);
                         }			 
                        else {
                          getCellValue(_erow,_ecol);
                         }
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
               <<"mark tags \n"
                R[_erow][tags_col] = "x";
		sWo(cellwo,@cellval,_erow,tags_col,"x")
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
  how much was done - score for day
  
  daily message / ?email alert - midday/teatime / 9pm lastcall
  to prompt

  FIX -- if first operation is edit - subsequent row operations fail




/}*/
