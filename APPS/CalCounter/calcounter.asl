///
///
////////////    DDC  /////////////

include "debug.asl"


include "gss.asl";


int Bestpick[3][2];


proc Addrow()
{

    sz= Caz(R)
<<"in $_proc record $rows $sz\n"
    er = rows;

    R[er] = DF[0];

    rows++;
    sz = Caz(R);
 //   writeRecord(1,R,@del,Delc);

   <<"New size %V $rows $cols $sz\n";   // increase ??
  
   sWo(cellwo,@setrowscols,rows+1,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
   sWo(cellwo,@cellval,R,0,0,rows,cols);
   sWo(cellwo,@redraw);
}
//============================



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

sWo(choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

sWo(choicewo, @cellval, RC,0,0,3,cols);  // startrow,nrows,startcol,ncols

sWo(choicewo,@redraw);

}
//==================================
proc FoodSearch()
{
int i;
<<"what is myfood string? $_emsg $_ekeyw \n"
<<"<$_ewords[3]> <$_ewords[4]> <$_ewords[5]> \n"
  myfood = "$_ewords[3] $_ewords[4] $_ewords[5]"
  foodSearch()
}
//=======================================

proc totalRows()
{
//
// last row  should contain previous totals
//

<<"$_proc \n"

  float fc[10];  // cals,carbs,fat,prt,chol,sfat,txt
  int kc = 0;
  int fi = 3;
  float fval;
  float nval;
  nr= Caz(R);
  
<<"%V $Nrows $rows $nr\n"

  frows = Nrows-1;
<<"$R[0][::]\n"
<<"$R[1][::]\n"
<<"%V $frows  $R[frows][0]\n"

  tword = deWhite(R[frows][0]);
  
  if (!strcasecmp(tword, "totals")) {

   for (j = 1; j < frows ; j++) {
     fi = 3;
     for (kc = 0; kc <7  ; kc++) {

          //fc[kc] += atof(R[j][kc+3]);
          //fc[kc] += atof(R[j][fi]);
	    fval = atof(R[j][fi]);
       // <<" $(Caz(fval)) \n"
         fc[kc] += fval;
//	 nval = fc[kc];
        <<"%V $j $kc $fi $fval $R[j][fi] $fc[kc]\n"
	  fi++;
      }
    }

   j = frows;

   R[j][0] = "Totals";
   R[j][1] = "$(j-1)";
   R[j][2] = "ITMS";

    for (kc = 0; kc < 7  ; kc++) {
        nval = fc[kc];
       // R[j][3+kc] = dewhite("%6.2f$fc[kc]");  // TBF
          R[j][3+kc]= "%6.2f$nval";
       <<"%V $kc $nval $fc[kc] \n"
    }
   // kc = 0;
  //  R[j][3] = dewhite("%6.2f$fc[0]");

   <<"$R[j][::]\n"

//     sWo(cellwo,@cellval,R,0,0,Nrows,cols);
//     sWo(cellwo,@redraw);
   }
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
   
   if (_ecol == 1) {
    mans = popamenu("HowMuch.m");
    mf = atof(mans);
    if (mf > 0.0) {
     wans = RC[_erow];
     adjustAmounts (wans, mf);
     RC[_erow] = wans;
   sWo(choicewo,@cellval,RC,0,0,3,Ncols); // RecordVar, startrow, startcol, nrows, ncols,
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

   <<"New size %V $rows $cols $sz\n";   // increase ??
  
   sWo(cellwo,@setrowscols,rows+1,cols+1);
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);
    // swap prev last and this row
   swaprow_a = er;
   swaprow_b = er-1;
   
   SWOPROWS();

   totalRows();

sWo(cellwo,@cellval,R,0,0,Nrows,cols);
sWo(cellwo,@redraw);
// sWo(cellwo,@cellval,R,0,0,rows,cols);
// sWo(cellwo,@redraw);

}
//=======================


proc adjustAmounts (svar irs, f)
{
  float a;
  int i;
//<<"$irs[::]\n";

  a = atof (irs[1]) * f; //  <<"%V$a\n";

  irs[1] = dewhite("%6.2f$a");
  for (i = 3; i < 10; i++)
    {
      a = atof (irs[i]) * f;
      irs[i] = deWhite("%6.2f$a");
    }
}
//==================================

include "gevent.asl"




//////   create MENUS here  /////
A=ofw("HowMuch.m")
<<[A],"title HowMuchMore\n"
<<[A],"item 2x M_VALUE 2\n"
<<[A],"help twice\n"
<<[A],"item 3x M_VALUE 3\n"
<<[A],"help 3x \n"
<<[A],"item 4x M_VALUE 4\n"
<<[A],"help 4x\n"
<<[A],"item 10x M_VALUE 10\n"
<<[A],"help 10x\n"
<<[A],"item 1/2 M_VALUE 0.5n"
<<[A],"help half\n"
<<[A],"item 1/3 M_VALUE 0.333\n"
<<[A],"help third\n"
<<[A],"item 1/4 M_VALUE 0.25\n"
<<[A],"help quarter\n"
<<[A],"item 1/10 M_VALUE 0.1\n"
<<[A],"help  tenth\n"
cf(A)

//==========================
Nbp = 3;



  A=  ofr("foodtable.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }



   RF= readRecord(A,@del,',')
   cf(A);

  Nrecs = Caz(RF);
  Ncols = Caz(RF,1);

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
adjust_day = 0;
fname = _clarg[1];

nl = slen(fname);
<<"<|$fname|> \n"
 <<"%V <|$fname|> $nl\n"

//if ( !(fname @= "")) {
make_day = 0;
 if (nl != 0) {

  if (scmp(fname,"dd_",3)) {
     adjust_day = 1;
     the_day = fname;
   }
A= ofr(fname)
 if (A == -1) {
   <<"can't find file dd_ day $fname \n";
    adjust_day = 0;
    make_day = 1;
  }
}


//  make up today and check

if (!adjust_day && !make_day) {
 ds= date(2);
 ds=ssub(ds,"/","-",0);
 the_day = "dd_${ds}";
}


fname = the_day;

ok=fexist(the_day,0);

<<"checking this day $the_day summary exists? $ok\n";
 found_day = 0;

if (ok > 0) {
 
   A= ofr(fname)
   if (A == -1) {
   exit(-1);
   }
   found_day =1;
 }



  myfood = "pie apple";
  f_unit = "slice";
  f_amt = 1.0;

int fnd = 0;
int bpick;



Record DF[10];

DF[0] = Split("?,?,?,?,?,?,?,?,?,?",",");

   
Record R[];

if (found_day) {
   R= readRecord(A,@del,',')
   cf(A);
}
else {

R[0] = Split("Food,Amt,Unit,Cals,Carbs,Fat,Protein,Chol(mg),SatFat,Wt,",",");
R[1] = Split("Totals,?,?,?,?,?,?,?,?,?",",");

}

  sz = Caz(R);
  Nrows = sz;
  
  Ncols = Caz(R[0]);
  rows = sz+1;
  
<<"num of records $sz  %V $rows $Ncols\n"

//////////////////////////////////


   //totalRows();









Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }




include "tbqrd";


include "calcounter_scrn";


include "checkFood";

<<"%V swaprow_a $swaprow_b  $swapcol_a $swapcol_b \n";

int cv = 0;





  sz= Caz(R);
  rows = sz;
  cols = Caz(R[0])

  tags_col = cols;
  
 sWo(cellwo,@setrowscols,rows,cols+1);
 
<<"%V$rows $sz \n"

  for (i = 0; i < rows;i++) { 
    <<"[${i}] $R[i]\n";
   }

// color rows
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


   totalRows();
   //totalRows();

   sWo(cellwo,@cellval,R,0,0,rows,cols);  
   
   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);


  sWo(cellwo,@cellval,0,tags_col,"Tags")
  R[0][tags_col] = "Tags";

record RC[6];

 for (i=0; i < 3; i++) {
  RC[i] = RF[i+1];   // BUG xic fix
  <<"loop <$i> $RC[i][0] $RC[i][1] $RC[i][2]  $RC[i][3]\n"
 }

<<"$(Caz(RC,0)) \n";


   sWo(choicewo,@setrowscols,4,cols+1);
   sWo(choicewo,@selectrowscols,0,2,0,cols);
   sWo(choicewo,@cellval,RC,0,0,3,cols); // RecordVar, startrow, startcol, nrows, ncols,

  for (i = 0; i< 3 ; i++) {
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
//testargs(1,choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

//  Addrow();

  myfood = "pie apple"
  FoodSearch();    // intial search bug

 str rcword ="xxx"

 while (1) {

         eventWait();

   <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ekeyw3 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"

         if ( _erow > 0) {
            the_row = _erow;
         }

         if ( (_erow >= 0)  && (_ecol >= 0)) {
	 <<"get rcword $_erow  $_ecol \n"
           if (_erow < Nrows) {
           <<"$R[_erow][_ecol] \n"
            rcword= DeWhite(R[_erow][_ecol]);
           }
         }

         if (_ewoid == cellwo) {
       
             if (_ekeyw @="CELLVAL") {
                r= _erow;
		c= Cev->col;
		<<"%V$Cev->row $Cev->col\n"
                R[r][c] = _evalue;
		<<"update cell val $r $c $_erow $_ecol $_ekeyw2 $R[r][c] \n"
		<<"updated row $R[r]\n"
             }

          if (!strcasecmp(rcword,"totals")) {
               <<"compute totals\n"
                    totalRows();
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
              nc=slen(_ewoname);
    <<"calling script procedure $nc  <|${_ewoname}|> !\n"
            if (nc > 3) {
	      <<"calling script procedure  <$_ewoname> !\n"
              $_ewoname();
	      }
        }
      }

}

<<"out of loop\n"

 exit()



////////////// TBD ////////////////
/{/*

  totals == crash
  readin crash






/}*/