//%*********************************************** 
//*  @script calcounter.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.28 Ni Nickel                                                  
//*  @date Sun Nov 17 12:36:39 2019 
//*  @cdate Fri Jan  1 08:00:00 2016 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%



////////////    DDC  /////////////

include "debug.asl"
include "gevent.asl"
include "gss.asl";
include "hv.asl"
include "calcounter_day.asl";
include "calcounter_ssp.asl";

debugOFF()


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
<<[A],"item 1/2 M_VALUE 0.5\n"
<<[A],"help half\n"
<<[A],"item 1/3 M_VALUE 0.333\n"
<<[A],"help third\n"
<<[A],"item 1/4 M_VALUE 0.25\n"
<<[A],"help quarter\n"
<<[A],"item 1/10 M_VALUE 0.1\n"
<<[A],"help  tenth\n"
<<[A],"factor ? C_INTER "?"\n"
<<[A],"help set mins\n"  
cf(A)

//==========================
Nbp = 4; // number of search results
Nchoice = 4;   // display choice row size
Nfav = 8;   // display choice row size

  A=  ofr("foodtable2019.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

  RF= readRecord(A,@del,',') ;   // RF record created
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


  nargs = argc();

  what_day = _clarg[1];

  day_name = getCCday( what_day);


  ok=fexist(day_name,0);

 <<"checking this day $day_name summary exists? $ok\n";

 found_day = 0;

 if (ok > 0) {
 
   A= ofr(day_name)
   if (A == -1) {
   exit(-1);
   }
   found_day =1;
  }


<<"%V$day_name $found_day\n"



  myfood = "pie apple";
  f_unit = "slice";
  f_amt = 1.0;

 int fnd = 0;
 int bpick;

// Record DF[10];

 DF[0] = Split("?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?",",");
   
// Record R[];

if (found_day ) {
   R= readRecord(A,@del,',')
   cf(A);
}
else {

 R[0]= Split("Food,Amt,Unit,Cals,Carbs(g),Fat,Prot,Choles(mg),SatFat(g),Wt(g),Choline(mg),vA(dv),vC,vB1Th,vB2Rb,vB3Ni,vB5Pa,vB6,vB9Fo,B12,vE,vK,Ca,Fe,Na,K,Zn,GMT,",",");
 //R[1] = Split("Totals,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0",",");
}

  sz = Caz(R);
  Nrows = sz;
  
  Ncols = Caz(R,0);
  
  rows = sz+1;
  cols = Ncols;


<<"num of records $sz  %V $rows $Ncols\n"
  totalRows();
  
  sz = Caz(R);
  Nrows = sz;
  
  Ncols = Caz(R,0);
  rows = sz;
  cols = Ncols;

<<"num of records $sz  %V $rows $Ncols\n"

<<"/////////// %v $rows\n"

  for (j=0; j<rows; j++) {
<<"$j  $R[j]\n"
  }


//=========================================================//
include "checkFood";
include "calcounter_fav";

Record RC[>10];



//======================================================//

include "graphic.asl"
include "calcounter_scrn";


int cv = 0;


  tags_col = cols;
 // rows += 2;
 
  sWo(cellwo,@setrowscols,rows+10,cols+1);
  sWo(cellwo,@cellval,R,0,0,rows,cols);  
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



 
  sWo(cellwo,@cellval,R,0,0,rows+1,cols);  
  sWo(cellwo,@selectrowscols,0,rows,0,cols);

  sWo(cellwo,@cellval,0,tags_col,"Tags")


    R[0][tags_col] = "Tags";

<<"%V $Nchoice \n"

   sWo(choicewo,@setrowscols,Nchoice+1,cols+1); // setup sheet rows&cols
   // before  setting cellvals!
   sWo(choicewo,@cellval,RC,0,0,Nchoice,cols);  
   sWo(choicewo,@selectrowscols,0,Nchoice,0,cols);
   sWo(choicewo,@setcolsize,3,0,1);

   <<"%V $choicewo \n"
  


  for (i = 0; i< Nchoice ; i++) {
     for (j = 0; j< cols ; j++) {
        if ((i%2)) {
           sWo(choicewo,@cellbhue,i,j,CYAN_);         
	}
	else {
           sWo(choicewo,@cellbhue,i,j,PINK_);
	 }
       }
     }

     favDisplay();
     

//============================


// sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
   sWi(vp,@redraw);

   sWo(ssmods,@redraw);

   setRowColSizes();


   sWo(choicewo,@cellval,RC,0,0,Nchoice,cols);
   // RecordVar, startrow, startcol, nrows, ncols,
 
   sWo(cellwo,@redraw);
   
   sWo(choicewo,@redraw);

<<"%V $choicewo $cellwo \n"
//testargs(1,choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

//  Addrow();

  myfood = "pie apple"
  FoodSearch();    // intial search bug

 str rcword ="xxx"

int mwr =0;
int mwc = 0;

  //  yn=yesornomenu("Edit Daily Log?")
//debugON()

while (1) {

         eventWait();

 //  <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ekeyw3 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"
 //       _erow->info(1);


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


//        sWo(cellwo,@redraw);

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

                         if (_ebutton == LEFT_ && mwr > 0  && mwc == 27) {
                             // get GMT
                            getLastGMTValue(mwr,mwc);
                          }


                          if (_ebutton == LEFT_ && mwr > 0  && mwc == 1) {
                            changeAmount(mwr)
                          }
     }

    if (_eloop > 0) {
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
     


    sWo(cellwo,@redraw);
    sWo(choicewo,@redraw);
    sWo(favorwo,@redraw);    
    sWo(ssmods,@redraw);
}


exit()



////////////// TBD ////////////////
/{/*

  totals == crash
  added yesterday dd-1, dd-2, dd-N
  improve search by checking food catergory { bread,meat,fish ...}

  save on each add
  add GMT to row end --- allow edit and use last time
  filter out of multiply entry

/}*/