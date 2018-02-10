///
///
////////////    DDC  /////////////


setdebug(1);
filterDebug(0,"win_receive_msg")

proc Addrow()
{

    sz= Caz(R)
<<"in $_proc record $rows $sz\n"
    er = rows;

    R[er] = DF[0];
 //   R[er][4] = date(2);
 //   R[er][5] = date(2);
 //   R[er][6] =  julmdy(julian(date(2))+14)); // fortnight hence
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



proc FoodSearch()
{
int i;

 Bestpick = -1;		//clear the best pick choices

bpick = checkFood();
  <<"$bpick \n"
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
 sWo(choicewo,@selectrowscols,0,2,0,cols-1); // startrow,endrow,startcol,endcol
 sWo(choicewo, @cellval, RC,0,0,3,cols);  // startrow,nrows,startcol,ncols
 sWo(choicewo,@redraw);
}
//==================================
proc Search()
{
int i;
<<"what is myfood string? $_emsg $_ekeyw \n"
<<"<$_ewords[3]> <$_ewords[4]> <$_ewords[5]> \n"
 myfood = "$_ewords[3] $_ewords[4] $_ewords[5]"
  FoodSearch()
}
//=======================================

proc totalRows()
{
// last row contains totals
<<"$_proc \n"
  float cals = 0;
  float carbs = 0;
  float fat = 0;
  float prt = 0;
  float chol = 0;
  float sfat = 0;
  float twt = 0;  

  frows = rows-1;

<<"%V $frows  $R[frows][0]\n"

  if (R[frows][0] @= "totals") {
    //     frows--;
  }

  for (j = 1; j < frows ; j++) {

     cals += atof(R[j][3]);
     carbs += atof(R[j][4]);
     fat += atof(R[j][5]);
     prt += atof(R[j][6]);
     chol += atof(R[j][7]);
     sfat += atof(R[j][8]);
     twt += atof(R[j][9]);                              

  }
  
    j = frows;
<<"<$j>%V $cals $carbs $fat $prt \n"
   R[j][0] = "totals";
   R[j][1] = "$(j-1)";
   R[j][2] = "ITMS";   
   R[j][3] = "$cals";
   R[j][4] = "$carbs";
   R[j][5] = "$fat";
   R[j][6] = "$prt";
   R[j][7] = "$chol";
   R[j][8] = "$sfat";
   R[j][9] = "$twt";            

<<"$R[j][::]\n"

}
//=====================





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

int Bestpick[Nbp][2];

Record DF[10];

DF[0] = Split("?,?,?,?,?,?,?,?,?,?",',');

   
Record R[];

   R= readRecord(A,@del,',')
   cf(A);
   sz = Caz(R);

  Ncols = Caz(R[0]);
  rows = sz+1;
  
<<"num of records $sz  %V $rows $Ncols\n"

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


  Addrow();

  myfood = "pie apple"
  FoodSearch();    // intial search bug


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
   