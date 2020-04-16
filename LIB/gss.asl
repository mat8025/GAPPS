//%*********************************************** 
//*  @script gss.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.14 Si Silicon                                                 
//*  @date Thu Mar 26 08:41:13 2020 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
///   gss  procs
///


//<<"loading lib gss \n"
str Mans = "";
Use_csv_fmt = 1;
Delc = 44;

int Curr_row = 3;  // for paging
int Page_rows = 15;
int Curr_page = 1;
int Npgs = 1;
int Nrows = 0;


swaprow_a = 1;
swaprow_b = 2;

swapcol_a = 1;
swapcol_b = 2;

int Ncols = 10;

str cvalue ="xx";

//////////////////////   these records needed and used for any GSS /////////////////////

Record R[>15];

Rn = 5;

Record DF[>3];

proc getCellValue(int r, int c)
{
 
     if (r >0 && c >= 0 ) {
 <<" %V $r $c \n";
           cvalue = R[r][c];
// <<" %V $cvalue \n";
           if ((c == 0) && (cvalue @= "")) {
             ADDTASK()
           }
           newcvalue = queryw("NewValue","xxx",cvalue,_ex,_ey);
           sWo(cellwo,@cellval,r,c,newcvalue);
           R[r][c] = newcvalue;
     }
}
//=====================

GMTvalue = "0:00";
proc getLastGMTValue(int r, int c)
{
 
     if (r >0 && c >= 0 ) {
 <<" %V $r $c \n";
           cvalue = GMTvalue;
// <<" %V $cvalue \n";
           newcvalue = queryw("NewValue","GMT? ",cvalue,_ex,_ey);
           sWo(cellwo,@cellval,r,c,newcvalue);
           R[r][c] = newcvalue;
	   GMTvalue = newcvalue;
     }
}
//=====================

proc setPriority(int wr,int wc)
{
   Mans = popamenu("Priority.m")
	
        if (!(Mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,Mans);
           R[wr][wc] = Mans;
        }
}
//===============================//
proc setUpdate(int wr,int wc)
{
   
	 Mans = date(2);
           sWo(cellwo,@cellval,wr,wc,Mans);
           R[wr][wc] = Mans;
        
}
//===============================//


proc setDifficulty(int wr,int wc)
{
   Mans = popamenu("Difficulty.m")
	
        if (!(Mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,Mans);
           R[wr][wc] = Mans;
        }
}
//===============================//
proc HowLong(int wr,int wc)
{
 <<"gss $_proc\n" 
   lMans = popamenu("Howlong.m")
	
        if (!(lMans @= "NULL_CHOICE")) {
	<<"%V $wr $wc\n"
           sWo(cellwo,@cellval,wr,wc,lMans);
           R[wr][wc] = lMans;
        }
}
//===============================//

proc pickTaskCol (int wcol)
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


proc SAVE()
{
<<"IN $_proc saving sheet %V $fname  $Ncols \n";
	 
            B=ofw(fname);
            if ( B != -1) {
<<"%V $rows  \n"
            for (i= 0; i < rows ; i++) {
	    val = R[i][0];
<<"<$i> $val $R[i]\n"
            }

            nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);
<<[_DB]"%V $B $nrw  $Ncols \n"
            cf(B);
	    }
	    
    return 
}
//======================

proc READ()
{
<<[_DB]"reading $fname\n"
       // isok =sWo(cellwo,@sheetread,fname,2)
            A= ofr(fname)
            R= readRecord(A,@del,Delc)
           cf(A)
           sz = Caz(R);
<<"num of records $sz\n"
<<[_DB]"num of records $sz\n"
//      do display update elsewhere
//     sWo(cellwo,@cellval,R);
//	  sWo(cellwo,@redraw);

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
//int drows[Page_rows+];

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

proc DELCOL(int wc)
{
<<" $_proc $wc\n"

<<"NOP\n"
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

    er = -1;
    for (i=1; i < Nrows; i++) {
     wval = R[i][0];
     <<"empty? $i <$wval>\n"
     if (wval @= "") {
        er = i;
	break;
     }
    }

   if (er == -1) {
    er = Nrows-1;
    rows++;
    Nrows++;
   }
   
   <<"first empty row $er\n"
   

    if (Curr_row < 0) {
        Curr_row = 0;
    }
    
    <<"%V selectrowscols $Curr_row $Page_rows $cols $Rn\n"

    sWo(cellwo,@selectrowscols,Curr_row,Curr_row+Page_rows,0,cols,0);
  
    Curr_row = rows- Page_rows +1;
    if (Curr_row < 0) {
        Curr_row = 0;
    }
    
  //  sWo(cellwo,@selectrowscols,0,2,0,cols,1);

    rows++;
    Nrows = rows;

<<"$wt $DF[wt]\n"

    ex = DF[wt];
<<"$wt $DF[wt] : $ex\n"

    R[er] = DF[wt];

<<"%V $er $R[er]\n"

// make sure expand record to at least one more
    Rn++;
    
    // 0  is the supplied default of this table
    // 1...nt  will be favorite/maintenance tasks
    // has to be written over to display version

    sWo(cellwo,@cellval,R);
    // increase rows/colls

    //sWo(cellwo,@selectrowscols,Curr_row,rows,0,cols,1);

sWo(cellwo,@selectrowscols,Curr_row,rows-1,0,cols,1);
    
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


  Npgs =   rows/Page_rows;

  if ((Npgs * Page_rows) < rows) {
       Npgs++;
  }

  if (Curr_row < 0) {
      Curr_row = 0;
  }
  
<<"%V$cellwo $Curr_row $Page_rows $rows $cols $Npgs\n"

  if ((Curr_row + Page_rows) >= (rows-1)) {
        Curr_row = (rows - Page_rows -1);
   }


  sWo(cellwo,@selectrowscols,Curr_row,Curr_row+Page_rows,0,cols,0);


   Curr_row += Page_rows/2;
   // need to select

  if ((Curr_row + Page_rows) >= (rows-1)) {
        Curr_row = (rows - Page_rows -1);
   }

<<"%V$Curr_row $Page_rows $rows \n"
    if (Curr_row < 0) {
        Curr_row = 0;
    }
    
   sWo(cellwo,@selectrowscols,0,0,0,cols,1);
   sWo(cellwo,@selectrowscols,Curr_row,Curr_row+Page_rows,0,cols,1);

  // setRowColSizes();
   
   paintRows();
   Curr_page++;
   
   if (Curr_page > Npgs) {
     Curr_page = Npgs;
   }
   
   sWo(pgnwo,@value,Curr_page,@update);
     
   sWo(cellwo,@redraw);
   
}
//====================

proc PGUP()
{
/// rework for fixed pages -- of size?

   Npgs =   rows/Page_rows;
   <<"%V $cellwo  $Npgs $rows $cols $Page_rows $Curr_row \n"

   //setdebug(1,@trace);
   if (current_row <0) {
       current_rwo = 0;
   }
   sWo(cellwo,@selectrowscols,Curr_row,Curr_row+Page_rows,0,cols,0);

   Curr_row -= Page_rows/2;

   if (Curr_row < 0) {
       Curr_row = 0;
   }
   
   sWo(cellwo,@selectrowscols,0,0,0,cols,1);
   sWo(cellwo,@selectrowscols,Curr_row,Curr_row+Page_rows,0,cols,1);
  // setRowColSizes();
   paintRows();
  sWo(cellwo,@redraw);
  Curr_page--;
  if (Curr_page <1) {
      Curr_page =1;
  }
  sWo(pgnwo,@value,Curr_page,@update);
  return ;
}
//====================

proc clearTags()
{
<<[_DB]" $_proc\n"
//    R[::][7] = ""; // TBF
   ans= yesornomenu("ClearTags?")
   int i = 0;
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

  Npgs =   rows/Page_rows;

  scrollPGN(Npgs+1);
}
//============================

proc scrollPGN (int pn)
{

    if (Curr_row < 0) {
        Curr_row = 0;
    }

  sWo(cellwo,@selectrowscols,Curr_row,Curr_row+Page_rows,0,cols,0); // unset current

  Npgs =   rows/Page_rows;

  wpg = pn;

  Curr_row =  (wpg - 1) * Page_rows ;

  if (Curr_row < 0) {
      Curr_row = 0;
  }


<<[_DB]"%V$Curr_row $Page_rows $rows \n"

  if ((Curr_row + Page_rows) >= (rows-1)) {
        Curr_row = (rows - Page_rows -1);
   }

  // Curr_row += Page_rows/2;
   // need to select

<<[_DB]"%V$Curr_row $Page_rows $rows \n"

   sWo(cellwo,@selectrowscols,0,2,0,cols,1);
   sWo(cellwo,@selectrowscols,Curr_row,Curr_row+Page_rows,0,cols,1);
   paintRows();
   Curr_page = wpg;
   sWo(cellwo,@redraw);
   sWo(pgnwo,@value,wpg,@update);

}
//=======================================================
proc PGN()
{
   // need to unselect all

   // how many pages
   
  Npgs =   rows/Page_rows;

  // ask for page 
  //wpg = menu(pages);

  int wpg = Npgs /2;

  if (wpg < 0) wpg = 0;
  if (wpg > Npgs) wpg = Npgs;
  

  wval = getWoValue(pgnwo);

<<[_DB]"%V$wval \n"
  wpg = atoi(getWoValue(pgnwo));

<<[_DB]"%V $Npgs $wpg\n"

   scrollPGN (wpg)

   return ;
}
//====================

proc paintRows()
{

    endprow = Curr_row + Page_rows 

<<"$endprow = $Curr_row + $Page_rows $rows \n"

    if (endprow > rows) {
       endprow = rows-1;  // fix xgs for oob error
    }
    // do a row at a time
    
  <<"%V $rows $cols $Curr_row $endprow \n"
//      sWo(cellwo,@cellbhue,Curr_row,ALL_,LILAC_);
//      sWo(cellwo,@cellbhue,Curr_row+1,ALL_,LILAC_);
    
//int i;

    if (Curr_row < 0) {
        Curr_row = 0;
    }

   for (i = Curr_row; i < endprow ; i++) {
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
proc gotoLastPage()
{

 int jj = 0;
 for (jj=0;jj<5;jj++) {
     PGDWN()
     gflush()
 }
        
 for (jj=0;jj<10;jj++) {
     //sleep(0.1)
     PGUP()
 //  <<"PGUP $jj $Curr_page\n"
         gflush()
    if (Curr_page == 0)
       break
 }
 int last_page =Curr_page;
 for (jj=0; jj<15; jj++) {
     PGDWN()
     gflush()
//     <<"PGDWN $jj $Curr_page\n"
    if (Curr_page == last_page)
        break
     last_page = Curr_page;
 }

}

//================================

proc HOO()
{

<<[_DB]"IN $_proc record $rows \n"


<<[_DB]"OUT $_proc \n"
	    return ;
}
//=============================
<<[_DB]"%V $swaprow_a $swaprow_b  $swapcol_a $swapcol_b \n";
<<[_DB]"%V $_include\n"


