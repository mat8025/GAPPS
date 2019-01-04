//%*********************************************** 
//*  @script stuff2do.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.53 I Iodine                                                  
//*  @date Tue Jan  1 11:48:16 2019 
//*  @cdate Mon Jan  1 08:00:00 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


////////////   TASK LIST  EXAMPLE /////////////


//  each  cell has an input text function
// 

// open a csv/tsv/rec file
// read contents and set up a spreadsheet
// gui controls direct  manipulation of the
// record data (asl side)
// and the sheet is update xgs sid
// user can enter text into cells via the gui interface

include "debug.asl"
include "gevent.asl"

vers = "xxx";

debugOFF();




//////   create MENUS here  /////
A=ofw("Howlong.m")
<<[A],"title HowLong\n"
<<[A],"item 0.5 M_VALUE 0.5\n"
<<[A],"help half-hour\n"
<<[A],"item 1 M_VALUE 1\n"
<<[A],"help 1 hour\n"
<<[A],"item 2 M_VALUE 2\n"
<<[A],"help hour \n"
<<[A],"item 4 M_VALUE 4\n"
<<[A],"help 4 hours\n"
<<[A],"item 8 M_VALUE 8\n"
<<[A],"help 8 hours\n"
<<[A],"item 16 M_VALUE 16\n"
<<[A],"help 16 hours\n"
<<[A],"item 40 M_VALUE 40\n"
<<[A],"help 40 hours\n"
<<[A],"item ? C_INTER "?"\n"
<<[A],"help set pcdone\n"
cf(A)
//=============================
A=ofw("PCdone.m")
<<[A],"title PCdone\n"
<<[A],"item 5% M_VALUE 5\n"
<<[A],"item 10% M_VALUE 10\n"
<<[A],"item 25% M_VALUE 25\n"
<<[A],"item 50% M_VALUE 50\n"
<<[A],"item 75% M_VALUE 75\n"
<<[A],"item 90% M_VALUE 90\n"
<<[A],"item 100% M_VALUE 100\n"
<<[A],"item ? C_INTER "?"\n"
<<[A],"help set pcdone\n"
cf(A)
//==============================//
A=ofw("Priority.m")
<<[A],"title Priority 1-10\n"
<<[A],"item 1 M_VALUE 1\n"
<<[A],"item 2 M_VALUE 2\n"
<<[A],"item 3 M_VALUE 3\n"
<<[A],"item 4 M_VALUE 4\n"
<<[A],"item 5 M_VALUE 5\n"
<<[A],"item 6 M_VALUE 6\n"
<<[A],"item 7 M_VALUE 7\n"
<<[A],"item 8 M_VALUE 8\n"
<<[A],"item 9 M_VALUE 9\n"
<<[A],"item 10 M_VALUE 10\n"
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
<<[A],"item 8 M_VALUE 8\n"
<<[A],"item 9 M_VALUE 9\n"
<<[A],"item 10 M_VALUE 10\n"
cf(A)

//==============================//

CatCol= 1;
PriorityCol= 2;
DiffCol= 3;
TimeEstCol =4;
TimeSpentCol =5;
StartDateCol= 6;
UpdateDateCol= 7;
PCDoneCol= 8;


//  fname = "pp.rec"
  fname = _clarg[1];


  if (fname @= "")  {
   fname = "stuff2do.csv";
  }


<<"%V $fname \n"
//isok =sWo(cellwo,@sheetread,fname,2);
 //<<"%V$isok\n";

A= ofr(fname)
 if (A == -1) {
 <<"can't find file $fname \n";
    exit(-1);
 }

//record R[20+];

Record DF[10];


today = date(2);

// today + 7


  jdayn = julian(today)

  today2 = julmdy(jdayn);
  
<<"%V $today $jdayn $today2\n"

  nextwk = julmdy(jdayn+7);

//Task,Code,Priority,Difficulty,TimeEst,TimeSpent,Startdate,Update,%Done,Tags,
   DF[0] = Split("?,?,3,3,1,0,$today,$today,0, ,",',');
   

   R= readRecord(A,@del,',')
   cf(A);
   sz = Caz(R);

  ncols = Caz(R[0]);
<<"num of records $sz  num cols $ncols\n"

//////////////////////////////////


Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }


include "tbqrd.asl"

include "stuff2do_scrn.asl"

include "gss.asl"


//===============
//
include "stuff2do_ssp.asl"


gflush()

setdebug(0,@keep);

int cv = 0;

  sz= Caz(R);
  rows = sz;
  Nrows = rows;
  cols = Caz(R[0])

  tags_col = cols-1;

<<"%V $tags_col \n"

  
 sWo(cellwo,@setrowscols,rows+5,cols+1);
 
<<"%V$rows $sz \n"

for (i = 0; i < rows;i++) {
<<"[${i}] $R[i]\n"
}



    for (i = 0; i< rows ; i++) {
     for (j = 0; j< cols ; j++) {
        if ((i%2)) {
sWo(cellwo,@cellbhue,i,j,LILAC_);         
	}
	else {
sWo(cellwo,@cellbhue,i,j,YELLOW_);

	 }
	 cv++;
       }
     }




     sWo(cellwo,@cellval,R);
 //  sWo(cellwo,@cellval,R,1,1,5,5,1,1);


   rows = sz;
   Nrows = sz;
  //cols = Caz(R[0])
   
   sWo(cellwo,@setrowscols,rows+10,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
 sWo(cellwo,@setcolsize,3,0,1);
// sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);

   swaprow_a = 1;
   swaprow_b = 2;

   swapcol_a = 1;
   swapcol_b = 2;
<<"%V $cellwo\n"

   PGDWN();
   PGUP();



  while (1) {

        // resetDebug();
         eventWait();

// <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"

   //_erow->info(1);  // detailed spec of _erow variable
   //_ecol->info(1);
   
         if (_erow > 0) {
            the_row = _erow;
         }

       if (_ewoid == cellwo) {      

        whue = YELLOW_;

       if (_ecol == 0  && (_erow >= 0) && (_ebutton == RIGHT_)) {
	
         if ((_erow %2)) {
           whue = LILAC_;
	 }

         sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 

         swaprow_b = swaprow_a;
	 swaprow_a = _erow;
	 
//<<"%V $swaprow_a $swaprow_b\n"

         sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
         }

        else if (_erow == 0 && (_ecol == tags_col) && (_ebutton == RIGHT_)) {

               <<"Clear tags \n"
                clearTags();   
        }

        else if (_erow > 0 && (_ecol == tags_col) ) {
	        if (_ebutton == RIGHT_) {
               <<"mark tag \n"
                R[_erow][tags_col] = "x";
		sWo(cellwo,@cellval,_erow,tags_col,"x");
		}
		else if (_ebutton == LEFT_) {
               <<"clear tag \n"
                R[_erow][tags_col] = "";
		sWo(cellwo,@cellval,_erow,tags_col,"");
                }

		sWo(cellwo,@celldraw,_erow,tags_col)
        }
        else if (_erow > 0 && (_ecol == PCDoneCol)) {
                 PCDONE(_erow, PCDoneCol);
		 // update
		 setUpdate(_erow, UpdateDateCol);
        }
	else if (_erow > 0 && (_ecol == DiffCol)) {
                 setDifficulty(_erow, _ecol);
        }
        else if (_erow > 0 && (_ecol == PriorityCol)) {
                             setPriority(_erow);
        }
        else if (_erow > 0 && (_ecol == UpdateDateCol )) {
                 
		 // update
		 setUpdate(_erow, UpdateDateCol);
        }
        else if (_erow > 0 && ((_ecol == TimeEstCol) \
 			      || (_ecol == TimeSpentCol))) {
			      
                              HowLong(_erow,_ecol);
        }	
        else if (_erow == 0 && (_ecol >= 0) && (_ebutton == RIGHT_)) {
               pickTaskCol (_ecol);

        }
        else {
          if (_ebutton == LEFT_) {
             _ecol->info(1);
	     _erow->info(1);
             getCellValue(_erow,_ecol)
          }
	


        }
         sWo(cellwo,@setcolsize,3,0,1);
         sWo(cellwo,@redraw);

       }
      
       if ((_ewoid > 0) && (_ewoid != cellwo)  && (_ename @= "PRESS") ) {
        // check there a script procedure with this name ?
	
        if (!(_ewoname @= "")) {
	    ind = findProc(_ewoname) ;
            if (ind  != 0) {
<<[_DB]"calling script procedure $ind $_ewoid $cellwo $_ename $_ewoname !\n"
            $_ewoname()
	    }
	    else {
<<[_DB]"script procedure $_ewoname $ind does not exist!\n"
            }
        }
	         sWo(cellwo,@setcolsize,3,0,1);
		 sWo(cellwo,@redraw);
      }
      sWo(ssmods,@redraw);
 
}
<<"out of loop\n"

 exit()

//
//   TBD
//   Categories  -  different sheets 
//