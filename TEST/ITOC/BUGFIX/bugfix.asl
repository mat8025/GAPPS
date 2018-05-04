///
///
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

include "gss.asl";
include "gevent.asl"


setdebug(1,@keep);

//////   create MENUS here  /////




//  fname = "pp.rec"
  fname = _clarg[1];


  if (fname @= "")  {
   fname = "buglist.csv";
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
DF[0] = Split("bug#,'desc',code,4,PENDING,$today,$today,$today,",",");
<<"$DF[0] \n"

   Ncols = 8;

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



include "tbqrd"

include "bugfix_scrn"



   gflush()


// setdebug(1,"step","pline");

  sz= Caz(R);
  rows = sz;
  cols = Caz(R[0])

  tags_col = cols-1;
  
 sWo(cellwo,@setrowscols,rows+5,cols+1);
 
<<"%V$rows $sz \n"

for (i = 0; i < rows;i++) {
<<"[${i}] $R[i]\n"
}


      curr_row = 0;
      paintRows();
      curr_row = 1;

     sWo(cellwo,@cellval,R);
 //  sWo(cellwo,@cellval,R,1,1,5,5,1,1);


  rows = sz;

   
   sWo(cellwo,@setrowscols,rows+20,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);


   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);



  while (1) {

         eventWait();

   <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"

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

      if (_ename @= "PRESS") {

       if (!(_ewoname @= "")) {
           <<"calling script procedure  $_ewoname !\n"
            $_ewoname()
        }
      }


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
