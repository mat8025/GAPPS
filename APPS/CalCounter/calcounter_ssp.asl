//%*********************************************** 
//*  @script calcounter_ssp.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Mon Jan  7 17:55:58 2019 
//*  @cdate Fri Jan  4 09:27:43 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


int NFV = 24;// last is Zn
int Bestpick[5][2];

page_rows = 6;  // was 6

FOODCOLSZ = 6;

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
   sWo(choicewo,@setcolsize,FOODCOLSZ,0,1) ;
}
//=====================================//

proc Addrow()
{

    sz= Caz(R)
<<"in $_proc record $rows $sz\n"
    er = rows;

    R[er] = DF[0];

    rows++;
    sz = Caz(R);
 //   writeRecord(1,R,@del,Delc);

// <<"New size %V $rows $cols $sz\n";   // increase ??
  
   sWo(cellwo,@setrowscols,rows+1,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);

   setRowColSizes();
 //  sWo(cellwo,@cellval,R,0,0,rows,cols);
   sWo(cellwo,@cellval,R);
   sWo(cellwo,@redraw);
}
//======================================//


proc foodSearch()
{
   int i;

//sWo(choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol
//testargs(1,choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

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

//testargs(1,choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

  sWo(choicewo,@selectrowscols,0,Nchoice,0,cols-1,1); // startrow,endrow,startcol,endcol
  setRowColSizes();
   
  sWo(choicewo, @cellval, RC,0,0,Nchoice,cols);  // startrow,startcol,nrows, ncols

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

proc totalRows()
{
//
// last row  should contain previous totals
//
<<"running $_proc \n"

  float fc[25];  // cals,carbs,fat,prt,chol,sfat,txt
  int kc = 0;
  int fi = 3;
  float fval;
  float nval;
  int nfvals = 0;
  nr= Caz(R);
  
//<<"%V $Nrows $rows $nr\n"
//<<"R[0] $R[0] \n"
  frows = Nrows-1;
//<<"$R[0][::]\n"
//<<"$R[1][::]\n"
//<<"%V $frows  $R[frows][0]\n"
 
  tword = deWhite(R[frows][0]);


  if (strcasecmp(tword, "totals") != 0) {
  <<"creating totals \n"
   Nrows++;
   frows = Nrows-1;
   R[frows] = Split("Totals,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0",",");
   tword = deWhite(R[frows][0]);
  }


  //fc->info(1)

   for (j = 1; j < frows ; j++) {
     fi = 3;

  <<"R<$j> $R[j]\n"
  
   nc = Caz(R,j);
   if (nc >5) {
   nfvals++;
   for (kc = 0; kc < NFV  ; kc++) {
            wrs = R[j][fi];
	    fval = atof(R[j][fi]);
wrs->info(1)


fval->info(1)
<<"%V $wrs $fval \n"
//ans=iread(":")
         fc[kc] += fval;

//<<"<$j> fc[${kc}] $fi $fval $R[j][fi] $fc[kc]\n"

	  fi++;
      }
    }


    }



  <<"R[0] $R[0] \n"

   j = frows;
<<"total row $j $frows \n"
   R[j][0] = "Totals";
   R[j][1] = "$nfvals";
   R[j][2] = "ITMS";

  
  <<"$R[j][::] \n"
  <<"R[0] $R[0] \n"

   R->info(1)

  <<"R[0] $R[0] \n"
  <<"R[j] $R[j] \n"

   for (kc = 0; kc < NFV  ; kc++) {

          nval = fc[kc];
       // R[j][3+kc] = dewhite("%6.2f$fc[kc]");  // TBF

          R[j][3+kc] = "%6.2f$nval";
//	  rval = R[j][3+kc];
//       <<"%V $j $kc $nval $rval $R[j][3+kc] \n"
    }


   // kc = 0;
  //  R[j][3] = dewhite("%6.2f$fc[0]");
// R->info(1)
// <<"R[0] $R[0] \n"
// R->info(1)
 
   R[j][0] = "Totals";
   R[j][1] = "$nfvals";
   R[j][2] = "ITMS";

<<"done totals \n"

}
//=====================
proc FoodFavorites()
{
///  
///  call back via woname
///
svar wans;
   if (_ecol == 0) {

      // add to daily log ? 
         yn=yesornomenu("Add to Daily Log?")

         if (yn@="1") {
	 wans = FF[_erow]
<<"%V$_erow  $wans \n"
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

proc addFoodItem(svar wfd)
{

    sz= Caz(R)

    er = Nrows-1;
<<"in $_proc record $rows $sz $er\n"

    R[er] = wfd;

    rows++;
    Nrows++;
    sz = Caz(R);
    
  <<"%V $sz $rows $Nrows\n"

//   <<"New size %V $rows $cols $sz\n";   // increase ??
  
   sWo(cellwo,@setrowscols,rows+1,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
    // swap prev last and this row
   swaprow_a = er;
   swaprow_b = er-1;
   
   SWOPROWS();
   R->info(1)
   totalRows();
<<"$R\n"
//   sWo(cellwo,@cellval,R,0,0,Nrows,cols);
   setRowColSizes()

   sWo(cellwo,@cellval,R);

  sWo(cellwo,@redraw);	 

// ans= iread("::")
}
//=======================



proc adjustAmounts (svar irs, f)
{
  float a;
  int i;
<<"$_proc  $f $irs \n"
//  irs->info(1)

<<"$irs[::]\n";

  a = atof (irs[1]) * f;
  a= fround(a,4)
//<<"%V$a\n";
// nfv
 // irs[1] = dewhite("%6.2f$a");
  irs[1] = "%6.4f$a "
   for (i = 3; i < (NFV+3); i++)     {
     a = atof (irs[i]) * f;
     a= fround(a,4)
     val = "%6.4f$a"
     irs[i] = val;
//<<"<$i> $irs[i] $a $val\n"
//<<"wans $wans\n"

//irs->info(1)
    }

<<"$irs[::] \n"

}
//==================================
proc changeAmount(the_row)
{
    mans = popamenu("HowMuch.m");
    mf = atof(mans);
    
    if (mf > 0.0) {
     //wans = RC[the_row];
       wans = R[the_row];     
//wans->info(1)
//<<"%V $wans\n"
<<"before adjust by $mf %V $wans\n"

     adjustAmounts (wans, mf);

<<"after adjust by $mf %V $wans\n"

     R[the_row] = wans;
     totalRows();	
     sWo(cellwo,@cellval,R,0,0,Nrows,cols);
     sWo(cellwo,@redraw);
     }
}

//=====================================//

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
            cf(B);
	    }
	    
    return 
}
//======================
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

proc PGDWN()
{
   // need to unselect all

  cs_rows = Nfav;


  npgs =   cs_rows/page_rows;

  if (curr_row < 0) {
      curr_row = 0;
  }
  
<<"%V$foodswo $curr_row $page_rows $cs_rows $cols\n"

  sWo(foodswo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);


   curr_row += page_rows/2;
   // need to select

  if ((curr_row + page_rows) >= (cs_rows-1)) {
        curr_row = (cs_rows - page_rows -1);
   }

<<"%V$curr_row $page_rows $cs_rows \n"
    if (curr_row < 0) {
        curr_row = 0;
    }
    
   sWo(foodswo,@selectrowscols,0,0,0,cols,1);
   sWo(foodswo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,1);
   sWo(foodswo,@setcolsize,FOODCOLSZ,0,1) ;

   
   paintRows();
   curr_page++;
   if (curr_page > npgs) {
     curr_page = npgs;
   }
   
   sWo(pgnwo,@value,curr_page,@update);
     
   sWo(foodswo,@redraw);
   
}
//=====================================//

proc PGUP()
{

   cs_rows = Nfav;
   npgs =   cs_rows/page_rows;
   <<"%V $foodswo  $npgs $cs_rows $cols $page_rows $curr_row \n"

   //setdebug(1,@trace);
   if (current_row <0) {
       current_rwo = 0;
   }
   
   sWo(foodswo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,0);

   curr_row -= page_rows/2;

   if (curr_row < 0) {
       curr_row = 0;
   }
   
   sWo(foodswo,@selectrowscols,0,0,0,cols,1);
   sWo(foodswo,@selectrowscols,curr_row,curr_row+page_rows,0,cols,1);
    sWo(foodswo,@setcolsize,FOODCOLSZ,0,1) ;
  // setRowColSizes();
   paintRows();
  sWo(foodswo,@redraw);
  curr_page--;
  if (curr_page <1) {
      curr_page =1;
  }
  sWo(pgnwo,@value,curr_page,@update);
  return ;
}

//=====================================//

proc paintRows()
{
    cs_rows = Nfav;
  
     endprow = curr_row + page_rows 

<<"$endprow = $curr_row + $page_rows $cs_rows \n"

    if (endprow > cs_rows) {
       endprow = cs_rows-1;  // fix xgs for oob error
    }
    // do a row at a time
    
  <<"%V $cs_rows $cols $curr_row $endprow \n"


    if (curr_row < 0) {
        curr_row = 0;
    }

   for (i = curr_row; i < endprow ; i++) {

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


/{
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
/}