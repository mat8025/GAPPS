//%*********************************************** 
//*  @script stuff2do.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.56 Ba Barium                                                  
//*  @date Sat Oct 12 09:52:36 2019 
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

scriptDBON();
debugON();

include "gevent.asl"
include "hv.asl"
include "stuff2do_gss.asl"

//vers = "xxx";




setdebug(1,@keep,@pline)

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
   fname = "STUFF/stuff2do.csv";
  }


<<"%V $fname \n"
//isok =sWo(cellwo,@sheetread,fname,2);
 //<<"%V$isok\n";

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
   DF[0] = Split("?,?,3,3,1,0,$today,$today,0, ,",',');
   

   R= readRecord(A,@del,',')
   cf(A);
   sz = Caz(R);

  ncols = Caz(R[0]);
<<"num of records $sz  num cols $ncols\n"

//////////////////////////////////
<<"before Graphic \n"

include "stuff2do_ssp.asl"

include "graphic.asl"
 

include "stuff2do_scrn.asl"



//===============
//




//ans=iread(":>")


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



     colorRows(rows,cols);




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

/{
   swaprow_a = 1;
   swaprow_b = 2;

   swapcol_a = 1;
   swapcol_b = 2;
<<"%V $cellwo\n"
/}

  // PGDWN();
  // PGUP();
   //SCORE();
   sWi(vp,@redraw);
      //   eventWait();

int mwr = 0;
int mwc = 0;
symbol_num = 1
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
//Text(txtwo,"calling script procedure  $_ename $_ewoname !\n",0.2,0.2,1)

//plot(txtwo,@wosymbol,1,5,RED_)
//sWo(txtwo,@penhue,@symbolshape,symbol_num,@symsize,5,@redraw)
/{
   if (_ewoid == pguwo) {
    Plot(txtwo,@line,0,0,1,1,RED_)
  }
   else {
    Plot(txtwo,@line,0,0,1,1,BLUE_)
  }
/}
// sWo(txtwo,@savepixmap)
// sWo(txtwo,@scrollclip,UP_,16)

 sWo(txtwo,@print," calling script procedure  $_ename $_ewoname !\n")
 
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
//   option to move 100% to stuff-done.csv