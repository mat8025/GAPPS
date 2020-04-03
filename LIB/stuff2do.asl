///
///
////////////   SIMPLE SPREAD SHEET  EXAMPLE /////////////


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


include "gevent.asl"


setdebug(1,"keep");




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

DF[0] = Split("?,?,6,10,22/1/18,xx,31/1/18,x,",',');

   

   R= readRecord(A,@del,',')
   cf(A);
   sz = Caz(R);

  ncols = Caz(R[0]);
<<"num of records $sz  num cols $ncols\n"

//////////////////////////////////


proc SAVE()
{
         <<"saving sheet $fname\n"
            B=ofw(fname)
	    writeRecord(B,R);
	    cf(B)
}
//======================

proc READ()
{
      <<"reading $fname\n"
       // isok =sWo(cellwo,@sheetread,fname,2)
            A= ofr(fname)
            R= readRecord(A,@del,',')
           cf(A)
           sz = Caz(R);
          <<"num of records $sz\n"
          sWo(cellwo,@cellval,R);
}
//======================
proc SORT()
{
<<"in $_proc\n"
  sortcol = swapcol_a;
  startrow = 1;
  alphasort = 0; // 0 auto alpha or number 1 alpha   2 number
  sortdir = 1;
  
  sortRows(R,sortcol,alphasort,sortdir,startrow)


     sWo(cellwo,@cellval,R);
     sWo(cellwo,@redraw);

}
//======================
proc SWOPROWS()
{
<<"in $_proc\n"
<<"swap rows $swaprow_a and $swaprow_b\n"
         //sWo(cellwo,@swaprows,swaprow_a,swaprow_b);
//	SwapRows(R,swaprow_a,swaprow_b);
	R->SwapRows(swaprow_a,swaprow_b);	  // code vmf
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);
}
//======================

proc SWOPCOLS()
{     
<<"swap cols $swapcol_a and $swapcol_b\n"
       //  sWo(cellwo,@swapcols,swapcol_a,swapcol_b);
	SwapCols(R,swapcol_a,swapcol_b);
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);
}
//======================
proc DELROWS()
{
<<"in $_proc\n"
//int drows[]; // TBF
int drows[20+];
int n2d = 0;
        sz = Caz(R)
	ans = yesornomenu("Delete Tagged Rows?")

        if (ans == 1) {
	
        for (i = 0; i < sz; i++) {
            if (R[i][tags_col] @="x") {
                
		drows[n2d] = i;
		n2d++;
		<<"will delete row $i  $drows\n";
           }
        }
	
        if (n2d > 0) {
        //deleteRows(R,swaprow_a,swaprow_b);
	deleteRows(R,drows,n2d);
	nsz = Caz(R)
<<"deleted $drows  $sz $nsz\n"
         for (i = 0; i < nsz;i++) { 
           <<"[${i}] $R[i]\n"
         }
        // clear deleted rows at end
	// reset rows
        sWo(cellwo,@cellval,nsz,0,sz,cols,"");
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);
	}
     }
}
//======================
proc DELCOL()
{
<<"in $_proc\n"


}
//======================
proc ADDROW()
{

    sz= Caz(R)
<<"in $_proc record $rows $sz\n"
    er = rows;

    R[er] = DF[0];
    R[er][4] = date(2);
    R[er][5] = date(2);
    R[er][6] =  julmdy(julian(date(2))+14)); // fortnight hence
    rows++;
    sz = Caz(R);
    writeRecord(1,R);
  <<"New size %V $rows $cols $sz\n"  
   sWo(cellwo,@setrowscols,rows,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
   sWo(cellwo,@cellval,R);
   sWo(cellwo,@redraw);
	
}
//======================


proc clearTags()
{


//    R[::][7] = ""; // TBF
   ans= yesornomenu("ClearTags?")
   
   if (ans == 1) { // TBF

  for (i= 1;i< rows; i++) {
      R[i][tags_col] = " ";
   }
	    writeRecord(1,R);
   sWo(cellwo,@cellval,R);
   sWo(cellwo,@redraw);
   }
   
}
//============================

Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }


include "tbqrd"

    vp = cWi(@title,"S2D:$fname")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modfiy functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);

      swpcwo = cWo(vp,@BN,@name,"SWOPCOLS",@color,RED_);

      delrwo = cWo(vp,@BN,@name,"DELROWS",@color,RED_);

      delcwo = cWo(vp,@BN,@name,"DELCOL",@color,ORANGE_,@bhue,YELLOW_);

      arwo = cWo(vp,@BN,@name,"ADDROW",@color,ORANGE_,@bhue,"lightblue");
      

      int ssmods[] = { readwo,savewo,sortwo,swprwo,swpcwo,delrwo, delcwo, arwo }


      wovtile(ssmods,0.05,0.1,0.1,0.9,0.05);




 cellwo=cWo(vp,"SHEET",@name,"Stuff2Do",@color,GREEN_,@resize,0.12,0.1,0.9,0.95)
 // does value remain or reset by menu?

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO",@func,"inputValue")

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)

 

 
 //sWo(cellwo,@sheetrow,0,0,"0,1,2,3,4,5,,7")
 //sWo(cellwo,@sheetcol,1,0,"A,B,C,D,E,F,G")



   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);






   gflush()



int cv = 0;



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

  //cols = Caz(R[0])
   
   sWo(cellwo,@setrowscols,rows+10,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);

// sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);

   swaprow_a = 1;
   swaprow_b = 2;

   swapcol_a = 1;
   swapcol_b = 2;
<<"%V $cellwo\n"


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
<<"out of loop\n"

 exit()
   