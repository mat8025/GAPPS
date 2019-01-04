//%*********************************************** 
//*  @script seefoods.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Thu Jan  3 21:36:05 2019 
//*  @cdate Tue Jan  1 10:16:01 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
////////////    SPREAD SHEET  for FOODS /////////////


include "debug.asl"
include "gevent.asl"


setdebug(1,@keep,@filter,0);


//scriptDBON();

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
cf(A)


include "gss.asl"

//  fname = "pp.rec"
  fname = _clarg[1];


  if (fname @= "")  {
   fname = "foodtableM.csv";
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

DF[0] = Split("fooddesc,1,TBSP,100,10,0,0,0,0,0",",");

   

   R= readRecord(A,@del,',')
   cf(A);
   sz = Caz(R);
   Ncols = Caz(R,0);
<<[_DB]"num of records $sz  num cols $Ncols\n"

//////////////////////////////////




Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }


include "tbqrd"

include "seefoods_scrn"

gflush()

//////////////  local SS functions  - overide classic ////




int cv = 0;



// setdebug(1,"step","pline");

  sz= Caz(R);
  rows = sz;
  cols = Caz(R,0);

  tags_col = cols-1;
  
 sWo(cellwo,@setrowscols,rows+5,cols+1);
  sWo(cellwo,@setcolsize,3,0,1);
<<[_DB]"%V$rows $sz \n"

for (i = 0; i < rows;i++) {
<<[_DB]"[${i}] $R[i]\n"
}

//




     sWo(cellwo,@cellval,R);
 //  sWo(cellwo,@cellval,R,1,1,5,5,1,1);


  rows = sz;
   
   sWo(cellwo,@setrowscols,rows+3,cols+2);

   //sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
   sWo(cellwo,@selectrowscols,0,2,0,cols);
//   curr_row = 3;
   sWo(cellwo,@selectrowscols,curr_row,curr_row+20,0,cols);
   sWo(cellwo,@setcolsize,5,0,1);

   curr_row = 0
   paintRows();
   curr_row = 1;

//=================================

   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);



  while (1) {

         eventWait();

<<[_DB]" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"

         if (_erow > 0) {
            the_row = _erow;
         }

       if (_ewoid == cellwo) {
       
        if (_erow > 0 && (_ecol == 0) ) {
                fd= R[_erow][0];
		//<<"%V$fd\n"
                sWo(searchwo,@value,fd,@redraw);

        }
	
             if (_ekeyw @="CELLVAL") {
                r= _erow;
	//	c= Cev->col;
	        c= _ecol;
		//<<"%V$Cev->row $Cev->col\n"
//R[Cev->row][Cev->col] = _ekeyw2;   // TBF
                R[r][c] = _evalue;
	//	<<"update cell val $r $c $_erow $_ecol $_ekeyw2 $R[r][c] \n"
	//	<<"updated row $R[r]\n"
            }

      

        whue = YELLOW_;
        if (_ecol == 0  && (_erow >= 0) && (_ebutton == RIGHT_)) {
        if ((_erow %2)) {
          whue = LILAC_;
	}

        sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 

         swaprow_b = swaprow_a;
	 swaprow_a = _erow;
	 
<<[_DB]"%V $swaprow_a $swaprow_b\n"

         sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
         }

               
             
      if (_erow == 0 && (_ecol >= 0) && (_ebutton == RIGHT_)) {

         sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);         	 	 
         swapcol_b = swapcol_a;
 	 swapcol_a = _ecol;

        sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 
<<[_DB]"%V $swapcol_a $swapcol_b\n"
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
           <<[_DB]"calling script procedure  $_ewoname !\n"
            $_ewoname()
        }
      }

   sWo(cellwo,@setcolsize,7,0,1);
   sWo(cellwo,@redraw);
}


 exit()
