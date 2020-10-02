//%*********************************************** 
//*  @script bugfix.asl 
//* 
//*  @comment report and schedule bug fix 
//*  @release CARBON 
//*  @vers 2.22 Ti Titanium                                               
//*  @date Thu Jan 17 09:03:30 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


////////////   BUGLIST /////////////


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

// could have a number of sheets in different windows
include "debug"

include "gevent"



include "hv"

include "gss"

include "bugfix_proc";



//////   create MENUS here  /////
 A=ofw("Priority.m")
 <<[A],"title Priority 1-7\n"
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
 A=ofw("Status.m")

 <<[A],"title Status \n"
 <<[A],"item PENDING M_VALUE PENDING\n"
 <<[A],"item IN_PROGRESS M_VALUE IN_PROGRESS\n"
 <<[A],"item FIX_25\% M_VALUE FIX_25\%\n"
 <<[A],"item FIX_50\% M_VALUE FIX_50\%\n"
 <<[A],"item FIX_75\% M_VALUE FIX_75\%\n"
 <<[A],"item FIX_90\% M_VALUE FIX_90\%\n"   
 <<[A],"item FIXED M_VALUE FIXED\n"
 <<[A],"item FEATURE M_VALUE FEATURE\n"
 <<[A],"item WAIT4NEWVERS M_VALUE WAIT4NEWVERS\n"
 cf(A)
 //==============================//


//  fname = "pp.rec"
/{
  fname = _clarg[1];


  if (fname @= "")  {
   fname = "buglist.csv";
  }
/}
 fname = "buglist.csv";
<<"%V $fname \n"
//isok =sWo(cellwo,@sheetread,fname,2);
 //<<"%V$isok\n";

A= ofr(fname)
 if (A == -1) {
 <<"can't find file $fname \n";
    exit(-1);
 }

//record R[20+];

//Record DF[10];
today = date(2);
DF[0] = Split("bug#,'desc',code,4,PENDING,$today,$today,",",");
<<"$DF[0] \n"



 
   Ncols = 8;

   R= readRecord(A,@del,',')
   cf(A);
   sz = Caz(R);

  ncols = Caz(R,0);
<<"num of records $sz  num cols $ncols\n"

// set DF[0] - to highest bug num read in plus 1
//

 BugN =atoi(R[sz-1][0])
 <<"next bug $BugN\n"
 BugN++; 
  DF[0][0] = "$BugN"

//////////////////////////////////

include "graphic"

//include "tbqrd"
include "bugfix_scrn"



   gflush()

//==============================

 DescCol= 1;
 CodeCol= 2;
 PriorityCol= 3;
 StatusCol= 4;
 ReportDateCol= 5;
 UpDateCol= 6;

//==============================



// setdebug(1,"step","pline");

  sz= Caz(R);
  rows = sz;
  cols = Caz(R,0)

  tags_col = cols-1;
  
  sWo(cellwo,@setrowscols,rows+5,cols+1);
 
<<"%V$rows $sz \n"

  for (i = 0; i < rows;i++) {
    <<"${i} $R[i]\n" ;  // bug first row only
  }


      curr_row = 0;

     
      
      curr_row = 1;

     sWo(cellwo,@cellval,R);
 //  sWo(cellwo,@cellval,R,1,1,5,5,1,1);

   sWo(cellwo,@setrowscols,rows+2,cols+1);
 //  sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
   sWo(cellwo,@selectrows,0,rows-1);
   sWo(cellwo,@setcolsize,3,1,1) 


use_incl = 1;

//debugON()
// redoing rows in colors is buggy

  if (use_incl) {
   // setdebug(1,@trace)
    colorRows()
   
   }
   else {

     j = cols-1;
     for (i = 0; i< rows ; i++) {
         if ((i%2)) {
              sWo(cellwo,@cellbhue,i,1,i,j,LIGHTGREEN_);         
 	}
 	else {
	     sWo(cellwo,@cellbhue,i,1,i,j,LIGHTBLUE_);         
 	}
      }

   }

   rows = sz; 
   
   //sWo(cellwo,@setrowscols,rows+2,cols+1);
   //sWo(cellwo,@setcolsize,3,1,1) 

   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);

   //paintRows();

int mwr = -1;
int mwc = -1;

  while (1) {

         eventWait();
         mwr= _erow;
	 mwc= _ecol;
	 
   <<[_DB]" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"

         if (mwr > 0) {
            the_row = mwr;
         }

       if (_ewoid == cellwo) {
       
             if (_ekeyw @="CELLVAL") {
                r= mwr;
		c= mwc;

                R[r][c] = _evalue;
		<<"update cell val $r $c $mwr $_ecol $_ekeyw2 $R[r][c] \n"
		<<"updated row $R[r]\n"
            }

      

        whue = YELLOW_;
        if (mwc == 0  && (mwr >= 0) && (_ebutton == RIGHT_)) {

         if ((mwr%2)) {
           whue = LILAC_;
	 }

         sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 

         swaprow_b = swaprow_a;
	 swaprow_a = mwr;
	 
<<"%V $swaprow_a $swaprow_b\n"

         sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
         }
             
      if (mwr == 0 && (mwc >= 0) && (_ebutton == RIGHT_)) {

         sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);         	 	 
         swapcol_b = swapcol_a;
 	 swapcol_a = mwc;

         sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 
<<"%V $swapcol_a $swapcol_b\n"
         }

        sWo(cellwo,@redraw);

        if (mwr == 0 && (mwc == tags_col) && (_ebutton == RIGHT_)) {
               //<<"Clear tags \n"
                clearTags();   
        }

        if (mwr > 0 && (mwc == tags_col) && (_ebutton == RIGHT_)) {
               <<"mark tags \n"
                R[mwr][tags_col] = "x";
		sWo(cellwo,@cellval,mwr,tags_col,"x")
		sWo(cellwo,@celldraw,mwr,tags_col)
        }

        if (_ebutton == LEFT_ && mwr > 0) {
                        //mwc->info(1);

            if (mwc == PriorityCol) {
               setPriority(mwr,mwc);
            }
	    else if (mwc == StatusCol) {
               setStatus(mwr,mwc);
	       setUpDate(mwr,UpDateCol,today);
            }
            else {
              getCellValue(mwr,mwc);
            }
        }

   }

      if (_ename @= "PRESS") {

       if (!(_ewoname @= "")) {
           <<"calling script procedure  $_ewoname !\n"
            $_ewoname()
        }
      }
 sWi(vp,@redraw); 

}


 exit()
//=========================================//
//
//   TBD :
//    add text wo - to show desc field completely
//    allow edit of description - without clearing contents on entery click
//    RB click to view - edit/paste
//    add this edit option to generic gss  apps
//
//
//
//
//
//
//
//
//
//
//=========================================//
