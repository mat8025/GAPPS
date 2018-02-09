///
///
////////////    DDC  /////////////


setdebug(1)
filterDebug(0,"win_receive_msg")

proc Search()
{

<<"what is myfood string? $_emsg $_ekeyw \n"

<<"<$_ewords[3]> <$_ewords[4]> <$_ewords[5]> \n"
myfood = "$_ewords[3] $_ewords[4] $_ewords[5]"
  bpick = checkFood();
}
//


include "gevent.asl"


setdebug(1,"keep");

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


  A=  ofr("foodtable.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

   RF= readRecord(A,@del,',')
   cf(A);

  Nrecs = Caz(RF);
  Ncols = Caz(RF,0);

<<"num of records $Nrecs  num cols $Ncols\n";


   for (i= 0; i < 3; i++) {
       nc = Caz(RF,i);
<<"<$i> $nc $RF[i] \n";
    }

    for (i= Nrecs -5; i < Nrecs; i++) {
    nc = Caz(RF,i);
<<"<$i> $nc $RF[i] \n";
    }

//===========================================

//  fname = "pp.rec"

fname = _clarg[1];

<<"%V $fname \n"

A= ofr(fname)
 if (A == -1) {
 <<"can't find file $fname \n";
 A= ofr("today")
   if (A == -1) {
   exit(-1);
   }
 }


  myfood = "pie apple";
  f_unit = "slice";
  f_amt = 1.0;

int fnd = 0;
int bpick;
int Bestpick[5][2];



Record DF[10];

DF[0] = Split("?,?,6,10,22/1/18,xx,31/1/18,x,",',');

   

   R= readRecord(A,@del,',')
   cf(A);
   sz = Caz(R);

  ncols = Caz(R[0]);
  rows = sz;
<<"num of records $sz  num cols $ncols\n"

//////////////////////////////////





Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }


include "gss.asl";

include "tbqrd";

include "ddc_screen";

include "checkFood";

<<"%V swaprow_a $swaprow_b  $swapcol_a $swapcol_b \n";

int cv = 0;


  sz= Caz(R);
  rows = sz;
  cols = Caz(R[0])

  tags_col = cols-1;
  
 sWo(cellwo,@setrowscols,rows+10,cols+1);
 
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
   
   sWo(cellwo,@setrowscols,rows+10,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);

   sWo(choicewo,@setrowscols,6,cols+1);
   sWo(choicewo,@selectrowscols,0,5,0,cols);

   for (i = 0; i< 6 ; i++) {
     for (j = 0; j< cols ; j++) {
        if ((i%2)) {
   sWo(choicewo,@cellbhue,i,j,CYAN_);         
	}
	else {
   sWo(choicewo,@cellbhue,i,j,PINK_);
	 }
       }
     }
//============================


// sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
   sWi(vp,@redraw);

   sWo(ssmods,@redraw);

   sWo(cellwo,@redraw);
   
   sWo(choicewo,@redraw);

<<"%V $choicewo $cellwo \n"





  while (1) {

         eventWait();

   <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ekeyw3 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"

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
            $_ewoname();
        }
      }

}
<<"out of loop\n"

 exit()
   