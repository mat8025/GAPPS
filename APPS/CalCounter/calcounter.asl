//%*********************************************** 
//*  @script calcounter.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.29 Cu Copper                                                  
//*  @date Sun Mar 15 11:21:20 2020 
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
include "calcounter_day.asl"; // check in local LIB first
include "checkFood";
include "calcounter_foods";
include "calcounter_ssp.asl";
include "calcounter_addrow.asl";
include "calcounter_adjust.asl";
include "calcounter_totals.asl";



debugON()
filterFuncDebug(ALLOWALL_,"xxx");
filterFileDebug(ALLOW_,"wo_sheet_p");

setDebug(0,@~pline,@~trace)

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

Record Tot[2];
Tot[0]= Split("#FoodT,NF,ITM,Cals,Carbs,Fat,Prot,Choles,SatFat,Wt,Choline,vA,vC,vB1Th,vB2Rb,vB3Ni,vB5Pa,vB6,vB9Fo,B12,vE,vK,Ca,Fe,Na,K,Zn,",",");
tot_rows = Caz(Tot)
tot_cols = Caz(Tot,0)
<<"%V $tot_rows $tot_cols \n"

//==========================
int Fcols = 10;


Nbp = 4; // number of search results
Nchoice = 4;   // display choice row size
Nfav = 4;   // display choice row size  was 8

  A=  ofr("Foods/foodtable2020.csv");

 if (A == -1) {
  <<" can't open food table $ftfile \n";
    exit();
 }

  RF= readRecord(A,@del,',') ;   // RF record created
  cf(A);

  Nrecs = Caz(RF);
  Ncols = Caz(RF,1);

<<"num of records $Nrecs  num cols $Ncols\n";
/{/*
   for (i= 0; i < 3; i++) {
       nc = Caz(RF,i);
      <<"<$i> $nc $RF[i] \n";
      RF->info(1)
   }

    for (i= Nrecs -5; i < Nrecs; i++) {
     nc = Caz(RF,i);
  <<"<$i> $nc $RF[i] \n";
    }
/}*/
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



 DF[0] = Split("?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?",",");
 

 Tot[1] = Split("#Totals,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,",",");
  

if (found_day ) {
   R= readRecord(A,@del,',')
   cf(A);
}
else {
 R->info(1)
 R[0]= Split("Food,Amt,Unit,Cals,Carbs(g),Fat,Prot,Choles(mg),SatFat(g),Wt(g),Choline(mg),vA(dv),vC,vB1Th,vB2Rb,vB3Ni,vB5Pa,vB6,vB9Fo,B12,vE,vK,Ca,Fe,Na,K,Zn,GMT,Tags,",",");
}

  sz = Caz(R);
  Nrows = sz;
  Ncols = Caz(R,0);



  R->info()

  rows = sz+1;
  cols = Ncols;
  R->info(1)

<<"num of records $sz  %V $rows $Ncols\n"
<<"$R\n"

  
  sz = Caz(R);
  Nrows = sz;
  
  Ncols = Caz(R,0);
  rows = sz;
  cols = Ncols;

<<"num of records $sz  %V $rows $Ncols\n"


<<"/////////// %v $rows\n"
/{
  for (j=0; j<rows; j++) {
<<"$j  $R[j]\n"
  }

/}
R->info(1)


include "graphic.asl"
include "calcounter_scrn";

//totalRows();

//=========================================================//


Record RC[>10];



//======================================================//




int cv = 0;


  tags_col = cols-1;
<<"%V$tags_col\n"
// rows += 2;
 Tot[0][tags_col] = "xx"
  sWo(cellwo,@setrowscols,rows+1,cols+1);
  sWo(cellwo,@cellval,R,0,0,Nrows,cols+1);
<<"%V$Ncols \n"
  sWo(totalswo,@setrowscols,2,30);
  sWo(totalswo,@selectrowscols,0,1,0,29);
  sWo(totalswo,@cellval,Tot,0,1,0,Ncols);
  sWo(totalswo,@setcolsize,FOODCOLSZ,0,1) ;
  sWo(totalswo,@setcolsize,2,3,1) ;  
 // sWo(totalswo,@setcolsize,3,0,1);

<<"%V$rows $sz \n"

  for (i = 0; i < rows;i++) { 
    <<"[${i}] $R[i]\n";
   }

// color rows

   color_foodlog();

// sWo(foodswo,@cellbhue,i,ALL_,CYAN_);

    sWo(totalswo,@cellbhue,0,ALL_,LILAC_);
    sWo(totalswo,@cellbhue,1,ALL_,YELLOW_);             



 
  sWo(cellwo,@cellval,R,0,0,rows,cols);
  R->info(1)
  sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);

  sWo(cellwo,@cellval,0,tags_col,"Tags")

  sWo(totalswo,@cellval,Tot);

 // sWo(cellwo,@cellval,0,0,"Food")
 // sWo(cellwo,@cellval,0,1,"Amt")
 // sWo(cellwo,@cellval,0,2,"Unit")
 // sWo(cellwo,@cellval,0,3,"Cals")


   R[0][tags_col] = "Tags";
<<"$R\n"

<<"%V $Nchoice \n"

   sWo(choicewo,@setrowscols,Nchoice+1,Fcols+1); // setup sheet rows&cols
   // before  setting cellvals!
   sWo(choicewo,@cellval,RC,0,0,Nchoice,Fcols);  
   sWo(choicewo,@selectrowscols,0,Nchoice-1,0,Fcols-1);
   sWo(choicewo,@setcolsize,3,0,1);

   <<"%V $choicewo \n"
  


  for (i = 0; i< Nchoice ; i++) {
     for (j = 0; j<= tags_col ; j++) {
        if ((i%2)) {
           sWo(choicewo,@cellbhue,i,j,CYAN_);         
	}
	else {
           sWo(choicewo,@cellbhue,i,j,PINK_);
	 }
       }
     }

    foodsDisplay();
     

//============================




// sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
   sWi(vp,@redraw);

   sWo(ssmods,@redraw);

   setRowColSizes();


   //sWo(totalswo,@cellbhue,1,ALL_,CYAN_);
   sWo(choicewo,@cellval,RC,0,0,Nchoice,Fcols);
   // RecordVar, startrow, startcol, nrows, ncols,
 
   sWo(cellwo,@redraw);
   
   sWo(choicewo,@redraw);
   
   sWo(totalswo,@redraw);   

<<"%V $choicewo $cellwo \n"
//testargs(1,choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

//  Addrow();

  myfood = "pie apple"
  //FoodSearch();    // initial search bug

  foodSearch()

 str rcword ="xxx"

int mwr =0;
int mwc = 0;

  //  yn=yesornomenu("Edit Daily Log?")
//debugON()

sWo(cellwo,@cellval,R,0,0,rows,tags_col+1);
R->info(1)


    totalRows();  
    sWo(totalswo,@cellval,Tot);
    sWo(totalswo,@border,@clipborder,@redraw);  

while (1) {

         eventWait();

 //  <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ekeyw3 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"
 //       _erow->info(1);


         mwr = _erow;
	 mwc = _ecol;
<<"%V $mwr $mwc $tags_col\n"
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


        if (mwr == 0 && (mwc == tags_col) && (_ebutton == RIGHT_)) {
                clearTags();   
        }

        if (mwr > 0 && (mwc == 0) ) {
                fd= R[mwr][0];
                sWo(searchwo,@value,fd,@redraw);
        }
	
        if (mwr > 0 && (mwc == tags_col) ) {
	<<"tags action\n"
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
     
 //   totalRows();  
 //   sWo(totalswo,@cellval,Tot);
 //   sWo(totalswo,@border,@clipborder,@redraw);
    
    sWo(cellwo,@border,@clipborder,@redraw);  
    sWo(choicewo,@border,@clipborder,@redraw);  
    sWo(foodswo,@border,@clipborder,@redraw);  
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

  make totals-rows -- two rows  header plus the sum of selections GSS


  BUGS:
     totals - get number of selections wrong -- if empty rows -- sums look correct
     crash -- after many menu loads



/}*/