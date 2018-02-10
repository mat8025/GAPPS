///
///   gss  procs
///

<<"loading lib gss \n"

Use_csv_fmt = 1;
Delc = 44;
curr_row = 3;  // for paging
page_rows = 20;


swaprow_a = 1;
swaprow_b = 2;

swapcol_a = 1;
swapcol_b = 2;
   
proc SAVE()
{
         <<"saving sheet $fname  %V$Ncols \n"
            B=ofw(fname)
	    writeRecord(B,R,@del,Delc,@ncols,Ncols);
	    cf(B)
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
    writeRecord(1,R,@del,Delc);
  <<"New size %V $rows $cols $sz\n"  
   sWo(cellwo,@setrowscols,rows,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
   sWo(cellwo,@cellval,R);
   sWo(cellwo,@redraw);
}

//======================
proc PGDWN()
{
   // need to unselect all

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
   sWo(cellwo,@redraw);
}
//====================

proc PGUP()
{

   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);
   curr_row -= page_rows/2;

   if (curr_row <0) {
       curr_row = 0;
   }
   sWo(cellwo,@selectrowscols,0,2,0,cols,1);
   sWo(cellwo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,1);
  paintRows();
  sWo(cellwo,@redraw);

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
   
}
//============================

proc paintRows()
{
    for (i = curr_row; i< (curr_row+page_rows) ; i++) {
     for (j = 0; j< cols ; j++) {
        if ((i%2)) {
sWo(cellwo,@cellbhue,i,j,LILAC_);         
	}
	else {
sWo(cellwo,@cellbhue,i,j,YELLOW_);
	 }
       }
     }
}
//=============================

<<"%V $swaprow_a $swaprow_b  $swapcol_a $swapcol_b \n";
<<" done include gss \n"