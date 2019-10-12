//%*********************************************** 
//*  @script stuff2do_gss.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.12 Mg Magnesium                                              
//*  @date Wed Dec 26 08:45:16 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
///   gss  procs
///


//<<"loading lib gss \n"


//////   create MENUS here  /////
A=ofw("MENUS/Howlong.m")
<<[A],"title HowLong\n"
<<[A],"item 0.25 M_VALUE 0.25\n"
<<[A],"help 1/4-hour\n"
<<[A],"item 0.5 M_VALUE 0.5\n"
<<[A],"help half-hour\n"
<<[A],"item 0.75 M_VALUE 0.75\n"
<<[A],"help 3/4-hour\n"
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
<<[A],"item 24 M_VALUE 24\n"
<<[A],"help 24 hours\n"
<<[A],"item 40 M_VALUE 40\n"
<<[A],"help 40 hours\n"
<<[A],"item ? C_INTER ?\n"
<<[A],"help set pcdone\n"
cf(A)
//=============================
A=ofw("MENUS/PCdone.m")
<<[A],"title PCdone\n"
<<[A],"item 5% M_VALUE 5\n"
<<[A],"item 10% M_VALUE 10\n"
<<[A],"item 25% M_VALUE 25\n"
<<[A],"item 50% M_VALUE 50\n"
<<[A],"item 75% M_VALUE 75\n"
<<[A],"item 90% M_VALUE 90\n"
<<[A],"item 100% M_VALUE 100\n"
<<[A],"item ? C_INTER ?\n"
<<[A],"help set pcdone\n"
cf(A)
//==============================//
A=ofw("MENUS/Priority.m")
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
A=ofw("MENUS/Difficulty.m")
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


str mans = "";
Use_csv_fmt = 1;
Delc = 44;

int curr_row = 3;  // for paging
int page_rows = 15;
int curr_page = 1;
int npgs = 1;
int Nrows = 0;
swaprow_a = 1;
swaprow_b = 2;

swapcol_a = 1;
swapcol_b = 2;

int Ncols = 10;

str cvalue ="xx";

//////////////////////   these records needed and used for any GSS /////////////////////

Record R[>10];

Rn = 5;

Record DF[>3];

proc getCellValue( r, c)
{
 
     if (r >0 && c >= 0 ) {
 <<" %V $r $c \n";
           cvalue = R[r][c];
// <<" %V $cvalue \n";
           if ((c == 0) && (cvalue @= "")) {
             ADDTASK()
           }
           newcvalue = queryw("NewValue","xxx",cvalue,_ex,_ey);
<<[_DB]"%V$newcvalue \n"
           sWo(cellwo,@cellval,r,c,newcvalue);
           R[r][c] = newcvalue;
     }
}
//=====================
proc setPriority(wr,wc)
{
   mans = popamenu("MENUS/Priority.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//
proc setUpdate(wr,wc)
{
   
	 mans = date(2);
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        
}
//===============================//


proc setDifficulty(wr,wc)
{
   mans = popamenu("MENUS/Difficulty.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//
proc HowLong(wr, wc)
{
 <<"gss $_proc\n" 
   lmans = popamenu("MENUS/Howlong.m")
	
        if (!(lmans @= "NULL_CHOICE")) {
	<<"%V $wr $wc\n"
           sWo(cellwo,@cellval,wr,wc,lmans);
           R[wr][wc] = lmans;
        }
}
//===============================//

proc pickTaskCol ( wcol)
{	       
         sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);         	 	 

         swapcol_b = swapcol_a;
         swapcol_a = wcol;
	 wcol->info(1);
	 swapcol_a->info(1);
<<[_DB]"%V $wcol $swapcol_a $swapcol_b\n";
         sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 

}
//===========================================//



proc READ()
{
<<[_DB]"reading $fname\n"

<<"READING $fname\n"

       // isok =sWo(cellwo,@sheetread,fname,2)
            A= ofr(fname)
            R= readRecord(A,@del,Delc)
           cf(A)
           sz = Caz(R);
<<"num of records $sz\n"
<<[_DB]"num of records $sz\n"
//      do display update elsewhere
    sWo(cellwo,@cellval,R);
	  sWo(cellwo,@redraw);

           return 
}
//======================
proc SORT()
{

  static int sortdir = 1;
  sortcol = swapcol_a;
  startrow = 1;
  alphasort = 0; // 0 auto alpha or number 1 alpha   2 number

  
  sortRows(R,sortcol,alphasort,sortdir,startrow)
  sortdir *= -1;

     sWo(cellwo,@cellval,R);
     sWo(cellwo,@redraw);
}
//======================
proc SWOPROWS()
{

//<<[_DB]"in $_proc\n"
<<[_DB]"swap rows $swaprow_a and $swaprow_b\n"
         //sWo(cellwo,@swaprows,swaprow_a,swaprow_b);
//	SwapRows(R,swaprow_a,swaprow_b);
	R->SwapRows(swaprow_a,swaprow_b);	  // code vmf
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);
	return ;
}
//======================

proc SWOPCOLS()
{     
<<[_DB]"swap cols $swapcol_a and $swapcol_b\n"
       //  sWo(cellwo,@swapcols,swapcol_a,swapcol_b);
	SwapCols(R,swapcol_a,swapcol_b);
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);
	    return ;
}
//======================
//int drows[20+];

int drows[10];

proc DELROWS()
{
<<[_DB]"in $_proc\n"
//int drows[]; // TBF
//int drows[page_rows+];

//int drows[20+];
int n2d = 0;
        drows = -1;
<<[_DB]"%V $drows \n"
	
        sz = Caz(R)
	ans = yesornomenu("Delete Tagged Rows?")

        if (ans == 1) {
	
        for (i = 0; i < sz; i++) {
            if (R[i][tags_col] @="x") {
                
		drows[n2d] = i;
<<[_DB]"$n2d will delete row $i  $drows[n2d]\n";
                n2d++;
           }
        }
	
        if (n2d > 0) {
        //deleteRows(R,swaprow_a,swaprow_b);


	deleteRows(R,drows,n2d);
	nsz = Caz(R)
<<[_DB]"deleted $drows  $sz $nsz\n"
         for (i = 0; i < nsz;i++) { 
<<[_DB]"[${i}] $R[i]\n"
         }
        // clear deleted rows at end
	// reset rows
        rows = nsz;
        Nrows = nsz;
        // clear tags
        for (i= 1; i< rows; i++) {  
         R[i][tags_col] = " ";
        }
   

        sWo(cellwo,@cellval,nsz,0,sz,cols,"");
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);
	}
     }
     	    return ;
}
//======================
proc DELCOL()
{
<<[_DB]"in $_proc\n"


}
//======================

proc AddTask( wt)
{
///
/// wt is the index to DF list of tasks
/// should write to last active record in record R  size must be Rn+1 or greater
    sz= Caz(R);
    
<<"in $_proc R record %V $wt $rows $Rn $sz $Nrows\n"    

    if (sz <= Rn) {
<<"expand record R!!\n"
    R[Rn] = "";
    }

    if (sz > Rn) {
          Rn = sz;
    }

    er = Rn; // check this is correct for first call

    if (curr_row < 0) {
        curr_row = 0;
    }
    
    <<"%V $curr_row $page_rows $cols $Rn\n"

    sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);
  
    curr_row = rows- page_rows +1;
    if (curr_row < 0) {
        curr_row = 0;
    }
    
  //  sWo(cellwo,@selectrowscols,0,2,0,cols,1);

    rows++;
    Nrows = rows;

<<[_DB]"$wt $DF[wt]\n"

    ex = DF[wt];
<<[_DB]"$wt $DF[wt] : $ex\n"

    R[er] = DF[wt];

<<"%V $er $R[er]\n"

// make sure expand record to at least one more
    Rn++;
    
    // 0  is the supplied default of this table
    // 1...nt  will be favorite/maintenance tasks
    // has to be written over to display version

    sWo(cellwo,@cellval,R);
    // increase rows/colls

    sWo(cellwo,@selectrowscols,curr_row,rows,0,cols,1);
    
    paintRows();
    
    sWo(cellwo,@redraw);

    sz = Caz(R);

  <<[_DB]"New size %V $rows $cols $sz $Rn\n"  
}
//===============================//

proc ADDROW()
{
<<[_DB]" ADDROW $_proc\n"
/// should go to last page
<<"%V $rows $Nrows $Rn\n"
    AddTask(0);
    return 
}
//====================================


proc PGDWN()
{
   /// need to unselect all


  npgs =   rows/page_rows;

  if ((npgs * page_rows) < rows) {
       npgs++;
  }

  if (curr_row < 0) {
      curr_row = 0;
  }
  
<<"%V$cellwo $curr_row $page_rows $rows $cols $npgs\n"

  if ((curr_row + page_rows) >= (rows-1)) {
        curr_row = (rows - page_rows -1);
   }


  sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);


   curr_row += page_rows/2;
   // need to select

  if ((curr_row + page_rows) >= (rows-1)) {
        curr_row = (rows - page_rows -1);
   }

<<"%V$curr_row $page_rows $rows \n"
    if (curr_row < 0) {
        curr_row = 0;
    }
    
   sWo(cellwo,@selectrowscols,0,0,0,cols,1);
   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,1);

  // setRowColSizes();
   
   paintRows();
   curr_page++;
   
   if (curr_page > npgs) {
     curr_page = npgs;
   }
   
   sWo(pgnwo,@value,curr_page,@update);
     
   sWo(cellwo,@redraw);
   
}
//====================

proc PGUP()
{
/// rework for fixed pages -- of size?

   npgs =   rows/page_rows;
   <<"%V $cellwo  $npgs $rows $cols $page_rows $curr_row \n"

   //setdebug(1,@trace);
   if (current_row <0) {
       current_rwo = 0;
   }
   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);

   curr_row -= page_rows/2;

   if (curr_row < 0) {
       curr_row = 0;
   }
   
   sWo(cellwo,@selectrowscols,0,0,0,cols,1);
   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,1);
  // setRowColSizes();
   paintRows();
  sWo(cellwo,@redraw);
  curr_page--;
  if (curr_page <1) {
      curr_page =1;
  }
  sWo(pgnwo,@value,curr_page,@update);
  return ;
}
//====================

proc clearTags()
{
<<[_DB]" $_proc\n"
//    R[::][7] = ""; // TBF
   ans= yesornomenu("ClearTags?")
   
   if (ans == 1) { // TBF

   for (i= 1; i< rows; i++) {
      R[i][tags_col] = " ";
   }
   
   //writeRecord(1,R,@del,Delc);
   sWo(cellwo,@cellval,R);
   sWo(cellwo,@redraw);
   }
   return ;
}
//============================
proc lastPGN ()
{

  npgs =   rows/page_rows;

  scrollPGN(npgs+1);
}
//============================

proc scrollPGN (pn)
{

    if (curr_row < 0) {
        curr_row = 0;
    }

  sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0); // unset current

  npgs =   rows/page_rows;

  wpg = pn;

  curr_row =  (wpg - 1) * page_rows ;

  if (curr_row < 0) {
      curr_row = 0;
  }


<<[_DB]"%V$curr_row $page_rows $rows \n"

  if ((curr_row + page_rows) >= (rows-1)) {
        curr_row = (rows - page_rows -1);
   }

  // curr_row += page_rows/2;
   // need to select

<<[_DB]"%V$curr_row $page_rows $rows \n"

   sWo(cellwo,@selectrowscols,0,2,0,cols,1);
   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,1);
   paintRows();
   curr_page = wpg;
   sWo(cellwo,@redraw);
   sWo(pgnwo,@value,wpg,@update);

}
//=======================================================
proc PGN()
{
   // need to unselect all

   // how many pages
   
  npgs =   rows/page_rows;

  // ask for page 
  //wpg = menu(pages);

  int wpg = npgs /2;

  if (wpg < 0) wpg = 0;
  if (wpg > npgs) wpg = npgs;
  

  wval = getWoValue(pgnwo);

<<[_DB]"%V$wval \n"
  wpg = atoi(getWoValue(pgnwo));

<<[_DB]"%V $npgs $wpg\n"

   scrollPGN (wpg)

   return ;
}
//====================

proc paintRows()
{

    endprow = curr_row + page_rows 

<<"$endprow = $curr_row + $page_rows $rows \n"

    if (endprow > rows) {
       endprow = rows-1;  // fix xgs for oob error
    }
    // do a row at a time
    
  <<"%V $rows $cols $curr_row $endprow \n"
//      sWo(cellwo,@cellbhue,curr_row,ALL_,LILAC_);
//      sWo(cellwo,@cellbhue,curr_row+1,ALL_,LILAC_);
    
//int i;

    if (curr_row < 0) {
        curr_row = 0;
    }

   for (i = curr_row; i < endprow ; i++) {
   //<<[_DB]"<$i> $(typeof(i))\n"
	  if ((i%2)) {
	       sWo(cellwo,@cellbhue,i,ALL_,CYAN_);
	     }
	  else {
               sWo(cellwo,@cellbhue,i,ALL_,LILAC_);
          }
   }

  sWo(cellwo,@cellbhue,endprow,ALL_,YELLOW_);

}
//=============================


proc HOO()
{

<<[_DB]"IN $_proc record $rows \n"


<<[_DB]"OUT $_proc \n"
	    return ;
}
//=============================
<<[_DB]"%V $swaprow_a $swaprow_b  $swapcol_a $swapcol_b \n";
<<[_DB]"%V $_include\n"


