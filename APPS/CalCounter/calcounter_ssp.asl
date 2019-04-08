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

proc setRowColSizes()
{
   sWo(cellwo,@setrowsize,2,0,1) ;
   sWo(cellwo,@setcolsize,3,0,1) ;   
   sWo(choicewo,@setcolsize,3,0,1) ;
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
   sWo(cellwo,@cellval,R,0,0,rows,cols);
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
  bpick = Bestpick[j][1];
  if (bpick >0) {
    RC[i] = RF[bpick];
  <<"<$i> <$j> $bpick $RC[i][0]  $RC[i][1]  $RC[i][2]  $RC[i][3] \n"
  }
  else {
   //RC[i][::] = " "; 
  }
  j--;
 }


<<"best choice?: $RC[0] \n"
<<"%V $cols\n"
//sWo(choicewo,@cellval,RC,0,0,2,cols);

<<"%V $choicewo $cellwo \n"

<<"%V $cols \n"

//testargs(1,choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

  sWo(choicewo,@selectrowscols,0,Nbp-1,0,cols-1,1); // startrow,endrow,startcol,endcol
  setRowColSizes();
   
sWo(choicewo, @cellval, RC,0,0,Nbp,cols);  // startrow,startcol,nrows, ncols

sWo(choicewo,@redraw);

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
  
  nr= Caz(R);
  
<<"%V $Nrows $rows $nr\n"
<<"R[0] $R[0] \n"
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


fc->info(1)

   for (j = 1; j < frows ; j++) {
     fi = 3;

  <<"R<$j> $R[j]\n"
  
   nc = Caz(R,j);
   if (nc >5) {
   for (kc = 0; kc < NFV  ; kc++) {
 //           wrs = R[j][fi];
	    fval = atof(R[j][fi]);
//wrs->info(1)
fval->info(1)
//<<" $wrs $fval \n"
//ans=iread(":")
         fc[kc] += fval;

<<"<$j> fc[${kc}] $fi $fval $R[j][fi] $fc[kc]\n"

	  fi++;
      }
    }


    }



  <<"R[0] $R[0] \n"

   j = frows;
<<"total row $j $frows \n"
   R[j][0] = "Totals";
   R[j][1] = "$(j-1)";
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
   R[j][1] = "$(j-1)";
   R[j][2] = "ITMS";

  <<"done totals \n"

}
//=====================
proc FoodChoice()
{


float mf = 2;
svar wans;
<<"$_proc  $_ecol $_erow \n"

   if (_ecol == 0) {
            addFoodItem()
   }

    fd= RC[_erow][0];
//<<"$fd \n"
    sWo(searchwo,@value,fd,@redraw);
   if (_ecol == 1) {



    mans = popamenu("HowMuch.m");
    mf = atof(mans);
    if (mf > 0.0) {
     wans = RC[_erow];
wans->info(1)
<<"%V $wans\n"
     adjustAmounts (wans, mf);
<<"%V $wans\n"
    RC[_erow] = wans;
     
<<"RC[_erow]  $RC[_erow] \n"
   sWo(choicewo,@cellval,RC,0,0,Nbp,Ncols); // RecordVar, startrow, startcol, nrows, ncols,
   sWo(choicewo,@redraw);
     }
   }
}
//=========================
proc addFoodItem()
{
svar wans;
     wans = RC[_erow];
     
    sz= Caz(R)
<<"in $_proc record $rows $sz\n"
    er = Nrows;

    R[er] = wans;

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

   totalRows();

   sWo(cellwo,@cellval,R,0,0,Nrows,cols);
   setRowColSizes()

//sWo(cellwo,@redraw);
// sWo(cellwo,@cellval,R,0,0,rows,cols);
// sWo(cellwo,@redraw);

}
//=======================


proc adjustAmounts (svar irs, f)
{
  float a;
  int i;
<<"$_proc  $f $irs \n"
irs->info(1)

<<"$irs[::]\n";

  a = atof (irs[1]) * f;
<<"%V$a\n";
// nfv
  irs[1] = dewhite("%6.2f$a");

 for (i = 3; i < (NFV+3); i++)     {
     a = atof (irs[i]) * f;
     val = "%6.2f$a"
     irs[i] = val;
//<<"<$i> $irs[i] $a $val\n"
//<<"wans $wans\n"
//<<"$irs[::] \n"
//irs->info(1)
    }

// for (i = 0; i < (NFV+3); i++)     {
//   <<"$irs[i] \n"
//  }
}
//==================================

