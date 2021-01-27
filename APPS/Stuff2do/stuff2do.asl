/* 
 *  @script stuff2do.asl 
 * 
 *  @comment GSS of tasks to do 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.14 C-Li-Si] 
 *  @date Wed Jan 27 10:05:15 2021 
 *  @cdate Thu Mar 26 11:05:07 2018 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                     
////////////   TASK LIST  EXAMPLE /////////////


//  each  cell has an input text function
// 

// open a csv/tsv/rec file
// read contents and set up a spreadsheet
// gui controls direct  manipulation of the
// record data (asl side)
// and the sheet is update xgs sid
// user can enter text into cells via the gui interface

#include "debug"

allowErrors(-1);
//debugOFF()



include "gevent"
include "hv"
include "stuff2do_ssp"
//vers = "xxx";


CatCol= 1;
PriorityCol= 2;
DiffCol= 3;
TimeEstCol =4;
TimeSpentCol =5;
StartDateCol= 6;
UpdateDateCol= 7;
PCDoneCol= 8;

Str fname="xxx"

//chdir ("./TASKS")

//  fname = "pp.rec"
   in_fname = _clarg[1];
<<"%V fname\n"

  if (in_fname @= "")  {
   fname = "TASKS/stuff2do.csv";
  }
  else {

  fname = "TASKS/${in_fname}.csv"

  }

<<"%V $fname \n"


A= ofr(fname)
 if (A == -1) {
 <<"can't find file $fname \n";
    exit(-1);
 }



today = date(2);

// today + 7


  jdayn = julian(today)

  today2 = julmdy(jdayn);
  
<<"%V $today $jdayn $today2\n"

  nextwk = julmdy(jdayn+7);

//Task,Code,Priority,Difficulty,TimeEst,TimeSpent,Startdate,Update,%Done,Tags,
   TC = Split("?,?,3,3,1,0,$today,$today,0,x,",',');
   

   R= readRecord(A,@del,',')
   cf(A);
   sz = Caz(R);

  rows = sz;
  cols = Caz(R[0])
  Ncols = cols;
  Nrows = rows;
  Rn = Nrows;
   
  tags_col = cols-1;

<<"num of records $sz  num cols $Ncols\n"

<<"%V $tags_col \n"


//////////////////////////////////
<<"before Graphic \n"

<<"$R \n"




include "graphic"
include "stuff2do_screen"

titleVers()


//===============
//






int cv = 0;



  
 sWo(cellwo,@setrowscols,rows+1,cols+1);
 
<<"%V$rows $sz \n"

    <<"$R\n"
  

     colorRows(rows,cols);

     sWo(cellwo,@cellval,R);


   rows = sz;
   Nrows = sz;
  //cols = Caz(R[0])
   
   sWo(cellwo,@setrowscols,rows+2,cols+1);
   sWo(cellwo,@selectrows,0,rows+1);
   sWo(cellwo,@setcolsize,3,0,1);
   sWo(ssmods,@redraw)
   sWo(cellwo,@redraw);



   gotoLastPage()

   sWi(vp,@redraw);


int mwr = 0;
int mwc = 0;
symbol_num = 1;


   PGDWN();

	         sWo(cellwo,@setcolsize,3,0,1);
		 sWo(cellwo,@redraw);

  while (1) {

        // resetDebug();
         eventWait();

// <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"

   //_erow->info(1);  // detailed spec of _erow variable
   //_ecol->info(1);
           mwr = _erow; // BUG _erow still has PROC_ARG_REF set
	   mwc = _ecol;
			      
        if (_erow > 0) {
            the_row = _erow;
         }

       if (_ewoid == cellwo) {      

        whue = YELLOW_;

       if (mwc == 0  && (mwr >= 0) && (_ebutton == RIGHT_)) {
	
         if ((mwr %2)) {
           whue = LILAC_;
	 }

         sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 

         swaprow_b = swaprow_a;
	 swaprow_a = mwr;
	 
//<<"%V $swaprow_a $swaprow_b\n"

         sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
         }

        else if (mwr == 0 && (mwc == tags_col) && (_ebutton == RIGHT_)) {

               <<"Clear tags \n"
                clearTags();   
        }

        else if (mwr > 0 && (mwc == tags_col) ) {
	        if (_ebutton == RIGHT_) {
               <<"mark tag \n"
                R[mwr][tags_col] = "x";
		sWo(cellwo,@cellval,mwr,tags_col,"x");
		}
		else if (_ebutton == LEFT_) {
               <<"clear tag \n"
                R[mwr][tags_col] = "";
		sWo(cellwo,@cellval,mwr,tags_col,"");
                }

		sWo(cellwo,@celldraw,mwr,tags_col)
        }
        else if (mwr > 0 && (mwc == PCDoneCol)) {
                 PCDONE(mwr, PCDoneCol);
		 // update
		 setUpdate(mwr, UpdateDateCol);
        }
	else if (mwr > 0 && (mwc == DiffCol)) {
                 setDifficulty(mwr, DiffCol);
        }
        else if (mwr > 0 && (mwc == PriorityCol)) {
                 setPriority(mwr,PriorityCol);
        }
        else if (mwr > 0 && (mwc == UpdateDateCol )) {
    		 setUpdate(mwr, UpdateDateCol);
        }
        else if (mwr > 0 && ((mwc == TimeEstCol) \
 			      || (mwc == TimeSpentCol))) {
			      


                              //HowLong(_erow,_ecol);
			      <<"%V $mwr $mwc $_erow $_ecol\n"
			      HowLong(mwr,mwc);
        }	
        else if (mwr == 0 && (mwc >= 0) && (_ebutton == RIGHT_)) {
               pickTaskCol (mwc);

        }
        else {
          if (_ebutton == LEFT_) {
             _ecol->info(1);
	     _erow->info(1);
             getCellValue(mwr,mwc)
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
       // sWo(txtwo,@clear)
//sWo(txtwo,@scrollclip,UP_,16)
//sWo(txtwo,@print," calling script procedure  $_ewoname !\n")

           titleMsg("calling script procedure  $_ewoname ")
   
          $_ewoname()

        //  eventWait(); // consume stray event
       }
      else {
<<[_DB]"script procedure $_ewoname $ind does not exist!\n"
            }

       }
	         sWo(cellwo,@setcolsize,3,0,1);
		 sWo(cellwo,@redraw);
      }
           colorRows(rows,cols);
      sWo(ssmods,@redraw);
   //   SCORE();
       
}
<<"out of loop\n"

 exit()

//
//   TBD
//   Categories  -  different sheets 
//   option to move 100% to stuff-done.csv