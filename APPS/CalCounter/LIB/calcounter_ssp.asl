//%*********************************************** 
//*  @script calcounter_ssp.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Fri Mar 13 09:39:02 2020 
//*  @cdate Fri Jan  4 09:27:43 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


str Mans = "";
Use_csv_fmt = 1;
Delc = 44;

int Curr_row = 3;  // for paging
int Page_rows = 15;
int Curr_page = 1;
int Npgs = 1;
int Nrows = 0;

int Ncols = 10;

str cvalue ="xx";




int NFV = 24;// last is Zn
int Bestpick[5][2];

int drows[10];
Page_rows = 10;  // was 6

FOODCOLSZ = 6;

//////////////////////   these records needed and used for any GSS /////////////////////

record R[>15];

Rn = 5;

record DF[>3];

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




proc SORT()
{

  static int sortdir = 1;
  sortcol = swapcol_a;
  startrow = 1;
  alphasort = 0; // 0 auto alpha or number 1 alpha   2 number

  <<"%V  $sortcol $alphasort $sortdir $startrow $(rows-2)\n"
  sortRows(R,sortcol,alphasort,sortdir,startrow, rows-2)
  sortdir *= -1;

     sWo(cellwo,@cellval,R);
     sWo(cellwo,@redraw);
}
//======================================================//

proc SORT_FF()
{

  static int sortdir = 1;
  sortcol = swapcol_a;
  startrow = 1;
  alphasort = 0; // 0 auto alpha or number 1 alpha   2 number

  <<"%V  $sortcol $alphasort $sortdir $startrow $(rows-2)\n"
  sortRows(FF,sortcol,alphasort,sortdir,startrow)
  sortdir *= -1;

     sWo(foodswo,@cellval,FF);
     sWo(foodswo,@redraw);
}
//======================================================//




proc setRowColSizes()
{
   sWo(cellwo,@setrowsize,2,0,1) ;
   sWo(cellwo,@setcolsize,FOODCOLSZ,0,1) ;   
   sWo(choicewo,@setcolsize,FOODCOLSZ+3,0,1) ;
   sWo(foodswo,@setcolsize,FOODCOLSZ+3,0,1) ;   
   sWo(totalswo,@setcolsize,FOODCOLSZ,0,1) ;
   sWo(totalswo,@setcolsize,2,3,1) ;
   sWo(cellwo,@setcolsize,2,3,1) ;     
       <<"%V$totalswo \n"
}
//=====================================//


proc foodSearch()
{
   int i;



  Bestpick = -1;		//clear the best pick choices
  bpick = -1;
  bpick = checkFood();
  <<"$_proc $bpick \n"

  j= Nbp-1;
  for (i=0; i<Nbp; i++) {
    fpick = Bestpick[j][1];
    if (fpick >0) {
     RC[i] = RF[fpick];
    <<"<$i> <$j> $fpick $RC[i][0]  $RC[i][1]  $RC[i][2]  $RC[i][3] \n"
    }
  else {
   //RC[i][::] = " "; 
  }
  j--;
 }


<<"best choice?: $RC[Nbp-1] \n"
<<"%V $cols\n"
//sWo(choicewo,@cellval,RC,0,0,2,cols);

<<"%V $choicewo $cellwo \n"

<<"%V $cols \n"

//testargs(1,choicewo,@selectrows,0,2); // startrow,endrow,startcol,endcol

  sWo(choicewo,@selectrows,0,Nchoice-1,1); // startrow,endrow,ON
  sWo(choicewo,@selectcols,0,Fcols-1,1); // startcol,endcol,ON
  setRowColSizes();
   
  sWo(choicewo, @cellval, RC,0,0,Nchoice,Fcols);  // startrow,startcol,nrows, ncols

  sWo(choicewo,@font,F_TINY_,@redraw);

 //debugON()
}

//======================================//
proc FoodSearch()
{
int i;
<<"what is myfood string? <|$_emsg|> $_ekeyw \n"
<<"<$_ewords[3]> <$_ewords[4]> <$_ewords[5]> \n"
  myfood = "$_ewords[1] $_ewords[2] $_ewords[3]"
  
  foodSearch()
}
//=======================================

proc FoodFavorites()
{
///  
///  call back via woname
///

<<"$_proc $_ecol $_ewoid\n"

svar wans;
   if (_ecol >= 0  && (_ewoid == foodswo)) {

      // add to daily log ? 
         yn=yesornomenu("Add to Daily Log?")
 yn->info(1)
         if (yn @="1") {
	 wans = FF[_erow]
<<"ADDDING %V$_erow  $wans \n"
//ans=iread("->?")
         addFoodItem(wans) ; // and save
         }
   }
}
//=========================
proc FoodChoice()
{
///  
///  call back via woname
///
svar wans;

   if (_ecol == 0) {

      // add to daily log ? 
         yn=yesornomenu("Add to Daily Log?")
	 if (yn@="1") {
	 
	 wans = RC[_erow]
	 <<"%V $_erow $wans \n"
	 //ans=iread(":->")
         if (!(wans[1] @= "")) {
         addFoodItem(wans) ; // and save
         }
        }
   }
}
//=========================

proc SAVE()
{
<<"IN $_proc saving sheet %V $day_name  $Ncols \n";
	 
            B=ofw(day_name);
            if ( B != -1) {
<<"%V $rows  \n"
            for (i= 0; i < rows ; i++) {
	    val = R[i][0];
<<"<$i> $val $R[i]\n"
            }

            nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);
<<[_DB]"%V $B $nrw  $Ncols \n"
           // nrw=writeRecord(B,Tot,@del,Delc,@ncols,Ncols);

writeRecord(B,Tot,@del,Delc,@ncols,Ncols);
          cf(B);
	    }
	    
    return 
}
//======================

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
         for (i = 1; i < nsz;i++) { 
<<[_DB]"[${i}] $R[i]\n"
         R[i][tags_col] = " ";
         }
        // clear deleted rows at end
	// reset rows
        rows = nsz;
        Nrows = nsz;
        totalRows();	
        sWo(cellwo,@cellval,nsz,0,sz,cols,"");
        sWo(cellwo,@cellval,R);

	sWo(cellwo,@redraw);
	}
     }
     	    return ;
}

//=====================================//
// this overwrites gss version
proc PGDWN()
{
   // need to unselect all

  cs_rows = Nfav;


  Npgs =   cs_rows/Page_rows;

  if (Curr_row < 0) {
      Curr_row = 0;
  }
  
<<"%V$foodswo $Curr_row $Page_rows $cs_rows $cols\n"

  sWo(foodswo,@selectrows,Curr_row,Curr_row+Page_rows-1,0);


   Curr_row += Page_rows/2;
   // need to select

  if ((Curr_row + Page_rows) >= (cs_rows-1)) {
        Curr_row = (cs_rows - Page_rows -1);
   }

<<"%V$Curr_row $Page_rows $cs_rows \n"
    if (Curr_row < 0) {
        Curr_row = 0;
    }
    
   sWo(foodswo,@selectcols,0,Fcols,1);
   sWo(foodswo,@selectrows,Curr_row,Curr_row+Page_rows-1,1);
   sWo(foodswo,@setcolsize,FOODCOLSZ,0,1) ;

   
   paintRows();
   Curr_page++;
   if (Curr_page > Npgs) {
     Curr_page = Npgs;
   }
   
   sWo(pgnwo,@value,Curr_page,@update);
     
   sWo(foodswo,@redraw);
   
}
//=====================================//

proc PGUP()
{

   cs_rows = Nfav;
   Npgs =   cs_rows/Page_rows;

<<"%V $foodswo  $Npgs $cs_rows $cols $Page_rows $Curr_row \n"

   if (current_row < 0) {
       current_rwo = 0;
   }
   
   sWo(foodswo,@selectrows,Curr_row,Curr_row+Page_rows-1,0);

   Curr_row -= Page_rows/2;

   if (Curr_row < 0) {
       Curr_row = 0;
   }
   
   sWo(foodswo,@selectcols,0,Fcols,1);
   sWo(foodswo,@selectrows,Curr_row,Curr_row+Page_rows-1,1);
   sWo(foodswo,@setcolsize,FOODCOLSZ,0,1) ;
  // setRowColSizes();
   paintRows();
  sWo(foodswo,@redraw);
  Curr_page--;
  if (Curr_page <1) {
      Curr_page =1;
  }
  sWo(pgnwo,@value,Curr_page,@update);
  return ;
}

//=====================================//

proc paintRows()
{

<<"$_proc \n"
     cs_rows = Nfav;
  
     endprow = Curr_row + Page_rows 

//<<"$endprow = $Curr_row + $Page_rows $cs_rows \n"

    if (endprow > cs_rows) {
       endprow = cs_rows-1;  // fix xgs for oob error
    }
    // do a row at a time
    
  <<"%V $cs_rows $cols $Curr_row $endprow \n"

    if (Curr_row < 0) {
        Curr_row = 0;
    }

   for (i = Curr_row; i < endprow ; i++) {

	  if ((i%2)) {
	       sWo(foodswo,@cellbhue,i,ALL_,CYAN_);
	     }
	  else {
               sWo(foodswo,@cellbhue,i,ALL_,LILAC_);
          }
   }

  sWo(foodswo,@cellbhue,endprow,ALL_,YELLOW_);

}
//======================================================//

proc color_foodlog()
{
    for (i = 0; i< rows ; i++) {
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
//======================================================//

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
