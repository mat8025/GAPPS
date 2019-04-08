//%*********************************************** 
//*  @script editfoods.asl 
//* 
//*  @comment add/edit a food entry 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Wed Jan 16 18:08:31 2019 
//*  @cdate Wed Jan 16 18:08:31 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%







////////////    DDC  /////////////

include "debug.asl"
include "gevent.asl"
include "gss.asl";
include "hv.asl"
include "calcounter_ssp.asl";



//////   create MENUS here  /////
A=ofw("HowMuch.m")
<<[A],"title HowMuchMore\n"
<<[A],"item 1.5x M_VALUE 1.5\n"
<<[A],"help 1.5x \n"
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
Nbp = 4; // number of search results



  A=  ofr("foodtableC.csv");

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

nargs = argc();

adjust_day = 0;

edit_foods = 1;

fname = _clarg[1];

nl = slen(fname);

<<"<|$fname|> \n"

<<"%V <|$fname|> $nl\n"

 if (edit_foods) {

    A= ofr(fname)
    if (A == -1) {
<<"can't find food file to edit \n";
    exit();
    }
 }


  myfood = "pie apple";
  f_unit = "slice";
  f_amt = 1.0;

 int fnd = 0;
 int bpick;

 Record DF[10];

 DF[0] = Split("?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?",",");
   
 Record R[];

if (found_day || edit_foods) {
   R= readRecord(A,@del,',')
   cf(A);
}
else {

//R[0] = Split("Food,Amt,Unit,Cals,Carbs,Fat,Protein,Chol(mg),SatFat,Wt,",",");
 R[0]= Split("Food,Amt,Unit,Cals,Carbs(g),Fat,Prot,Choles(mg),SatFat(g),Wt(g),Choline(mg),vA(dv),vC,vB1Th,vB2Rb,vB3Ni,vB5Pa,vB6,vB9Fo,B12,vE,vK,Ca,Fe,Na,K,Zn,",",");

 R[1] = Split("Totals,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?",",");

}

  sz = Caz(R);
  Nrows = sz;
  
  Ncols = Caz(R[0]);
  rows = sz+1;
  
<<"num of records $sz  %V $rows $Ncols\n"

//////////////////////////////////


Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }
     



include "tbqrd";
include "calcounter_scrn";
include "checkFood";

//<<"%V swaprow_a $swaprow_b  $swapcol_a $swapcol_b \n";

int cv = 0;

  sz= Caz(R);
  rows = sz;
  cols = Caz(R[0])

  tags_col = cols;
 // rows += 2;
  sWo(cellwo,@setrowscols,rows+10,cols+1);

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

Record RC[20];

 for (i=0; i < Nbp; i++) {
   RC[i] = RF[i+1];   // BUG xic fix
  <<"loop <$i> $RC[i][0] $RC[i][1] $RC[i][2]  $RC[i][3]\n"
 }

<<"$(Caz(RC,0)) \n";



   sWo(choicewo,@setrowscols,10,cols+1);
   sWo(choicewo,@selectrowscols,0,Nbp,0,cols);

   sWo(choicewo,@setcolsize,3,0,1);
   sWo(cellwo,@setcolsize,3,0,1) ;
   <<"%V $choicewo \n"
  


  for (i = 0; i< Nbp ; i++) {
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

   setRowColSizes();

   sWo(choicewo,@cellval,RC,0,0,Nbp,cols); // RecordVar, startrow, startcol, nrows, ncols,
 
   sWo(cellwo,@redraw);
   
   sWo(choicewo,@redraw);

<<"%V $choicewo $cellwo \n"
//testargs(1,choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

//  Addrow();

  myfood = "pie apple"
  FoodSearch();    // intial search bug

 str rcword ="xxx"

//ans=iread()
// prelim


   

// eventWait();
//  <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ekeyw3 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"
int mwr =0;
int mwc = 0;

  while (1) {

         eventWait();

   //<<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ekeyw3 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"
        _erow->info(1);

         mwr = _erow;
	 mwc = _ecol;

      if ( (mwr >= 0)  && (mwc >= 0)) {
	 <<"get rcword $mwr  $mwc \n"
           if (mwr < Nrows) {
           //<<"$R[mwr][mwc] \n"
            rcword= DeWhite(R[mwr][mwc]);
           }
         }

         if (_ewoid == cellwo) {
       
             if (_ekeyw @="CELLVAL") {
                r= mwr;
		c= mwc;
		
                R[r][c] = _evalue;
		<<"update cell val $r $c $mwr $mwc $_ekeyw2 $R[r][c] \n"
		<<"updated row $R[r]\n"
             }

          if (!strcasecmp(rcword,"totals")) {
               <<"compute totals\n"
                    totalRows();
          }


        whue = YELLOW_;
        if (mwc == 0  && (mwr >= 0) && (_ebutton == RIGHT_)) {
	
             if ((mwr%2)) {
              whue = LILAC_;
	    }

           sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 

           swaprow_b = swaprow_a;
  	   swaprow_a = mwr;
	 
<<"%V $swaprow_a $swaprow_b\n"

           sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
         }

               
             
      if (mwr == 0 && (mwc >= 0) && (_ebutton == RIGHT_)) {

         sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);         	 	 
         swapcol_b = swapcol_a;
 	 swapcol_a = mwc;

         sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 
<<"%V $swapcol_a $swapcol_b\n"
         }

        sWo(cellwo,@redraw);

        if (mwr == 0 && (mwc == tags_col) && (_ebutton == RIGHT_)) {
               <<"Clear tags \n"
                clearTags();   
        }

        if (mwr > 0 && (mwc == 0) ) {
                fd= R[mwr][0];
                sWo(searchwo,@value,fd,@redraw);

        }
	
        if (mwr > 0 && (mwc == tags_col) ) {
               <<"mark tags \n"
	        xms = "";
	        if (_ebutton == RIGHT_) {
	          xms = "x"
		}
                R[mwr][tags_col] = xms;
       
                fd= R[mwr][0];

                sWo(searchwo,@value,fd,@redraw);

		sWo(cellwo,@cellval,mwr,tags_col,xms)
		sWo(cellwo,@celldraw,mwr,tags_col)
        }

                         if (_ebutton == LEFT_ && mwr > 0) {
                           getCellValue(mwr,mwc);
                          }

     }

    if (_eloop > 1) {
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
     

//    sWo(cellwo,@setrowsize,2,0,1) ;
//    sWo(cellwo,@setcolsize,3,0,1) ;   
//    sWo(choicewo,@setcolsize,3,0,1) ;     
    sWo(cellwo,@redraw);
    sWo(choicewo,@redraw);
    sWo(ssmods,@redraw);
}


 exit()



////////////// TBD ////////////////
/{/*

  totals == crash
  readin crash

/}*/