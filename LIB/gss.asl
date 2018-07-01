///
///   gss  procs
///

<<"loading lib gss \n"

Use_csv_fmt = 1;
Delc = 44;

int curr_row = 3;  // for paging
int page_rows = 20;
int curr_page = 1;
int npgs = 1;
swaprow_a = 1;
swaprow_b = 2;

swapcol_a = 1;
swapcol_b = 2;

int Ncols = 10;

proc getCellValue( r, c)
{
 c->info(1);

 
     if (r >0 && c >= 0 ) {
 <<" %V $r $c \n";
           cvalue = R[r][c];
 <<" %V $cvalue \n";	   
           newcvalue = queryw("NewValue","xxx",cvalue);
           <<"%V$newcvalue \n"
           sWo(cellwo,@cellval,r,c,newcvalue);
           R[r][c] = newcvalue;
     }
}
//=====================

proc pickTaskCol ( wcol)
{	       
         sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);         	 	 

         swapcol_b = swapcol_a;
         swapcol_a = wcol;
	 wcol->info(1);
	 swapcol_a->info(1);
         <<"%V $wcol $swapcol_a $swapcol_b\n";
         sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 

}
//===========================================//


proc SAVE()
{
         <<"IN $_proc saving sheet %V $fname  $Ncols \n";
	 
            B=ofw(fname)
            if ( B != -1) {
            nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);
<<"%V $B $nrw  $Ncols \n"
            cf(B);
	    }
	    
    return 
}
//======================

proc READ()
{
      <<"reading $fname\n"
       // isok =sWo(cellwo,@sheetread,fname,2)
            A= ofr(fname)
            R= readRecord(A,@del,Delc)
           cf(A)
           sz = Caz(R);
          <<"num of records $sz\n"
          sWo(cellwo,@cellval,R);
	  sWo(cellwo,@redraw);

           return 
}
//======================
proc SORT()
{
<<"in $_proc\n"
  static int sortdir = 1;
  sortcol = swapcol_a;
  startrow = 1;
  alphasort = 0; // 0 auto alpha or number 1 alpha   2 number

  
  sortRows(R,sortcol,alphasort,sortdir,startrow)
  sortdir *= -1;

     sWo(cellwo,@cellval,R);
     sWo(cellwo,@redraw);
    return ;
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
	return ;
}
//======================

proc SWOPCOLS()
{     
<<"swap cols $swapcol_a and $swapcol_b\n"
       //  sWo(cellwo,@swapcols,swapcol_a,swapcol_b);
	SwapCols(R,swapcol_a,swapcol_b);
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);
	    return ;
}
//======================
proc DELROWS()
{
<<"in $_proc\n"
//int drows[]; // TBF
int drows[page_rows+];
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
	Nrows = nsz;
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
<<"in $_proc\n"


}
//======================

proc AddTask( wt)
{

    sz= Caz(R);
    
<<"in $_proc record %V $wt $rows $sz\n"

    er = rows;

    sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);
  
    curr_row = rows- page_rows +1;
    if (curr_row < 0) {
        curr_row = 0;
    }
    sWo(cellwo,@selectrowscols,0,2,0,cols,1);

    rows++;

    <<"$wt $DF[wt]\n"
    ex = DF[wt];
    <<"$wt $DF[wt] : $ex\n"
    R[er] = DF[wt];
    // 0  is the supplied default tof this table
    // 1...nt  will be favorite/maintenance tasks

    // has to written over to display version
    sWo(cellwo,@cellval,R);
    // increase rows/colls

    sWo(cellwo,@selectrowscols,curr_row,rows,0,cols,1);
    
    paintRows();
    
    sWo(cellwo,@redraw);

    sz = Caz(R);

  <<"New size %V $rows $cols $sz\n"  
}
//===============================//

proc ADDROW()
{
/// should go to last page
    AddTask(0);
    return 
}
//====================================
<<"read in ADDROW\n";

proc PGDWN()
{
   // need to unselect all
   npgs =   rows/page_rows;
   
  sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);

<<"%V$curr_row $page_rows $rows \n"

   curr_row += page_rows/2;
   // need to select

  if ((curr_row + page_rows) >= (rows-1)) {
        curr_row = (rows - page_rows -1);
   }

<<"%V$curr_row $page_rows $rows \n"

   sWo(cellwo,@selectrowscols,0,2,0,cols,1);
   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,1);
   paintRows();
   curr_page++;
   if (curr_page > npgs) {
     curr_page = npgs;
   }
   sWo(pgnwo,@value,curr_page,@update);
     
   sWo(cellwo,@redraw);
   	    return ;
}
//====================

proc PGUP()
{

   npgs =   rows/page_rows;
    
   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);
   curr_row -= page_rows/2;

   if (curr_row <0) {
       curr_row = 0;
   }
   
   sWo(cellwo,@selectrowscols,0,2,0,cols,1);
   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,1);
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

  sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0); // unset current

  npgs =   rows/page_rows;


  wpg = pn;

  curr_row =  (wpg - 1) * page_rows ;

  if (curr_row < 0) {
      curr_row = 0;
  }


<<"%V$curr_row $page_rows $rows \n"

  if ((curr_row + page_rows) >= (rows-1)) {
        curr_row = (rows - page_rows -1);
   }

  // curr_row += page_rows/2;
   // need to select

<<"%V$curr_row $page_rows $rows \n"

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

<<"%V$wval \n"
  wpg = atoi(getWoValue(pgnwo));

<<"%V $npgs $wpg\n"

   scrollPGN (wpg)

   return ;
}
//====================

proc paintRows()
{

    endprow = curr_row + page_rows;
    if (endprow >= rows) {
       endprow = rows-2;  // fix xgs for oob error
    }
    // do a row at a time
    
  <<"%V $rows $cols $curr_row $endprow \n"
//      sWo(cellwo,@cellbhue,curr_row,ALL_,LILAC_);
//      sWo(cellwo,@cellbhue,curr_row+1,ALL_,LILAC_);
    
//int i;

   for (i = curr_row; i < endprow ; i++) {
   //<<"<$i> $(typeof(i))\n"
	  if ((i%2)) {
	      sWo(cellwo,@cellbhue,i,ALL_,CYAN_);
	     }
	  else {
               sWo(cellwo,@cellbhue,i,ALL_,LILAC_);
          }
   }
   sWo(cellwo,@cellbhue,endprow,ALL_,YELLOW_);
   	    return ;
}
//=============================


proc HOO()
{

<<"IN $_proc record $rows \n"


<<"OUT $_proc \n"
	    return ;
}
//=============================
<<"%V $swaprow_a $swaprow_b  $swapcol_a $swapcol_b \n";
<<" done include gss \n"