//%*********************************************** 
//*  @script addex.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Sat Jan 19 10:03:29 2019 
//*  @cdate Sun Jan  6 20:45:40 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
////////////    adds daily WT & EX /////////////



// open a tsv/rec file
// read contents and set up a spreadsheet

//  TBD  -- set up current page to this week
//  simple plot for selected col


include "gevent.asl"


include "debug"



//=============== MENUS=================//
A=ofw("Howlong.m")
<<[A],"title HowLong\n"
<<[A],"item 10m M_VALUE 10\n"
<<[A],"item 15m M_VALUE 15\n"
<<[A],"help half-hour\n"
<<[A],"item 30m M_VALUE 30\n"
<<[A],"help half-hour\n"
<<[A],"item 45m M_VALUE 45\n"
<<[A],"help 3/4 hour\n"
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
A=ofw("WhatWt.m")
<<[A],"title Weight\n"
<<[A],"item 200 M_VALUE 200\n"
<<[A],"item 195 M_VALUE 195\n"
<<[A],"item 185 M_VALUE 185\n"
<<[A],"item 175 M_VALUE 175\n"
<<[A],"item ? C_INTER "?"\n"
<<[A],"help set weight\n"
cf(A)
//=================================//


include "gss.asl"  // import the main subroutines


// local functions
// add more
// or overload/rework
//============= local Procs ===========//
proc ADDWEX()
{
/// should go to last page
<<"IN $_proc \n"

    AddTask(0);
    return 
}


//====================================//
proc SAVEWEX()
{
	 
            B=ofw(fname)
  R[0]= Split("Date         ,Weight,Walk,Hike,Run,Bike,Swim,Yard,Gym,Bpress, Tags",",");
            if ( B != -1) {
  // <<[B]"#Date   Weight  Walk    Hike    Run     Bike    Swim      Yard    Gym     Bpress Tags\n"
   // the first row is the field heading - should be ignored in data comptation
   // can use # for comment - but then will not be read
             nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);
<<"%V $B $nrw  $Ncols \n"
            cf(B);
	    }
}
//====================================//
proc HowLong(wr, wc)
{
  
   mans = popamenu("Howlong.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//

proc WhatWt(wr)
{
  
   mans = popamenu("WhatWt.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,1,mans);
           R[wr][1] = mans;
        }
}
//===============================//




//  fname = "pp.rec"
  fname = _clarg[1];


  if (fname @= "")  {
   fname = "wex.tsv";
  }


<<"%V $fname \n"
//isok =sWo(cellwo,@sheetread,fname,2);
 //<<"%V$isok\n";

A= ofr(fname)
 if (A == -1) {
 <<"can't find file $fname \n";
    exit(-1);
 }

record R[10+];

//ncols = 0;
int rows = 5;
//int cols = 5;
//int nrows = 5;
int sz = 0;

do_record = 1;



Record DF[10];
today = date(2);
DF[0] = Split("$today,0,10,0,0,0,0,0,0,0",",");

//<<"$DF[0]\n"


  // R= readRecord(A,@del,',')

   Use_csv_fmt = 0;
   Delc = -1; // WS


    R= readRecord(A,@del,Delc)
    cf(A);

    sz = Caz(R);
    rows = sz;

    cols = Caz(R,0);

    Ncols = Caz(R,0);


    tags_col = cols-1;

<<"1 %V num of records $sz  $rows $cols  $Ncols $tags_col\n"

//////////////////////////////////



int cv = 0;

     Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }



include "tbqrd"

include "addex_screen"

//===============================


 sWo(cellwo,@setrowscols,rows+5,cols+1);
 

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
   
   sWo(cellwo,@setrowscols,rows+10,cols+1);
   sWo(cellwo,@selectrowscols,0,page_rows,0,cols);

   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   for (i= 1; i< rows; i++) {
      R[i][tags_col] = " ";
   }
   sWo(cellwo,@cellval,R);

   sWo(cellwo,@redraw);


<<"%V $cellwo\n"
<<"2 %V num of records $sz  $rows $cols  $Ncols\n"


//setdebug(1,@keep,@trace);



<<"3 %V num of records $sz  $rows $cols  $Ncols\n"

   lastPGN ();
   int mwr =0;
   int mwc =0;
   
while (1) {

         resetDebug();
         eventWait();
         // TBF --- need these -? PROC_ARG_REF not cleared??
         //_erow->info(1);
        // _ecol->info(1);
	 mwr = _erow;
	 mwc = _ecol;
	 
//   <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $mwr $mwc $_ewoid \n"

         if (mwr > 0) {
            the_row = mwr;
         }

       if (_ewoid == cellwo) {

        whue = YELLOW_;
	
        if (_ebutton == LEFT_) {
             //mwc->info(1);
	     //mwr->info(1);
           if (mwr == 0 && (mwc == tags_col) ) {
               <<"Clear tags \n"
                clearTags();   
           }
	   else if ((mwc == 1) ) {
              WhatWt(mwr);
           }
	   else if ((mwr > 0) && (mwc > 1) && (mwc <= 8)) {
              HowLong(mwr,mwc);
           }
	   else {
            getCellValue(mwr,mwc);
	   }
        }

       else  if (_ebutton == RIGHT_) {

         if (mwc == 0  && (mwr >= 0) ) {

           if ((mwr % 2)) {
             whue = LILAC_;
	   }

         sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 

          swaprow_b = swaprow_a;
	  swaprow_a = mwr;
	 
           <<"%V $swaprow_a $swaprow_b\n"

         sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
         }
            
        else if ((mwr == 0) && (mwc >= 0) && (mwc < tags_col)) {

           pickTaskCol (mwc);

         }
        else if ((mwr >= 0) && (mwc == tags_col)) {
	
                if (mwr == 0) {
               <<"Clear tags \n"
                clearTags();   
                }
		else {
                <<"Mark tags \n"
	       
                R[mwr][tags_col] = "x";
		sWo(cellwo,@cellval,mwr,tags_col,"x")
		sWo(cellwo,@celldraw,mwr,tags_col)
                }
          }
      }
      
   }
   else {

      if ((_ewoid > 0) && (_ename @= "PRESS")) {
             if (!(_ewoname @= "")) {
	       ind = findProc(_ewoname) ;
               if (ind  > 0) {
              <<"calling script procedure %V $ind $_ewoid $cellwo $_ename $_ewoname !\n"
               $_ewoname()
	    }
	    else {
<<"script procedure %V $_ewoname $ind  $_ewoid does not exist!\n"
            }
	  //   sWo(ssmods,@redraw);
        }
     }

        //sWo(cellwo,@redraw);
  }
  sWi(vp,@redraw)
}
<<"out of loop\n"


<<" DONE!\n"
<<"1 %V num of records $sz  $rows $cols  $Ncols\n"

exit()


///////////////////  TBD&F ////////////////////////
/{/*

  add menus for mins 
  add function/menu for +/- today - and date entry









/}*/

