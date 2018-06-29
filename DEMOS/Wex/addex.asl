///
///
////////////   SPREAD SHEET  FOR adding daily EX /////////////



// open a tsv/rec file
// read contents and set up a spreadsheet

//  TBD  -- set up current page to this week
//  simple plot for selected col


include "gevent.asl"


setdebug(1,@keep,@~trace);
filterFuncDebug(ALLOWALL_,"proc");
filterFileDebug(ALLOWALL_,"ic_","array_subset");




//////   create MENUS here  /////
A=ofw("Howlong.m")
<<[A],"title HowLong\n"
<<[A],"item 1 M_VALUE 1\n"
<<[A],"help half-hour\n"
<<[A],"item 2 M_VALUE 2\n"
<<[A],"help 1 hour\n"
<<[A],"item 3 M_VALUE 3\n"
<<[A],"help hour and half\n"
<<[A],"item 4 M_VALUE 4\n"
<<[A],"help two hours\n"
<<[A],"item 5 M_VALUE 5\n"
<<[A],"help two and half hours\n"
<<[A],"item 6 M_VALUE 6\n"
<<[A],"help three hours\n"
<<[A],"item 7 M_VALUE 7\n"
<<[A],"help three and half hours\n"
<<[A],"item 8 M_VALUE 8\n"
<<[A],"help  four hours\n"
cf(A);


/////////////////////////
proc BOO()
{

<<"IN $_proc record $rows \n"


<<"OUT $_proc \n"
    return;
}
//=============================


include "gss.asl"  // import the main subroutines


// local functions
// add more
// or overload/rework

proc ADDWEX()
{
/// should go to last page
<<"IN $_proc \n"

    AddTask(0);
    return 
}


//====================================//




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

    cols = Caz(R[0]);

    Ncols = Caz(R[0]);

<<"1 %V num of records $sz  $rows $cols  $Ncols\n"

//////////////////////////////////

int cv = 0;

     Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }



include "tbqrd"

include "addex_screen"

//===============================

// setdebug(1,"step","pline");

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

   sWo(cellwo,@redraw);


<<"%V $cellwo\n"
<<"2 %V num of records $sz  $rows $cols  $Ncols\n"


//setdebug(1,@keep,@trace);



<<"3 %V num of records $sz  $rows $cols  $Ncols\n"


while (1) {

         resetDebug();
         eventWait();

//   <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"

         if (_erow > 0) {
            the_row = _erow;
         }

       if (_ewoid == cellwo) {
       
             if (_ekeyw @="CELLVAL") {
                r= _erow;
		c= Cev->col;
		<<"%V$Cev->row $Cev->col\n"
//R[Cev->row][Cev->col] = _ekeyw2;   // TBF
                R[r][c] = _evalue;
		<<"update cell val $r $c $_erow $_ecol $_ekeyw2 $R[r][c] \n"
		<<"updated row $R[r]\n"
            }

      

        whue = YELLOW_;
        if (_ecol == 0  && (_erow >= 0) && (_ebutton == RIGHT_)) {
        if ((_erow%2)) {
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
      }
   }
  }
  
}
<<"out of loop\n"


<<" DONE!\n"
<<"1 %V num of records $sz  $rows $cols  $Ncols\n"

exit()
   