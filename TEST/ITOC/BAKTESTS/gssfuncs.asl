//%*********************************************** 
//*  @script sheets.asl 
//* 
//*  @comment display csv as spreadsheet for edit ops 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Wed Mar 27 10:12:13 2019 
//*  @cdate 1/1/2016 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

include "debug.asl"
setdebug(1,@keep,@~pline,@~trace);
FilterFileDebug(REJECT_,"~storetype_e");
FilterFuncDebug(REJECT_,"~ArraySpecs",);
debugON();
  scriptDBON()

include "hv.asl"
include "gss.asl"
include "gevent.asl"



// what csv file to display/edit

    fname = "funcs.csv";
  //  csv present on command line use
  na = argc()

  if (na > 1) {
      fname = _clarg[1];
  }

<<"reading $fname  csv?\n"

Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }

include "tbqrd"
include "gss_screen"


  READ();


  sz= Caz(R);

   rows = sz;

   cols = Caz(R,0)
 
   tags_col = cols-1;
   

   sWo(cellwo,@setrowscols,rows+2*page_rows,cols+1); 

   sWo(cellwo,@selectrowscols,0,page_rows-1,0,cols-1);


   sWo(cellwo,@cellval,R); // too many cells?

int cv = 0;

page_rows = 20;

    for (i = 1; i< page_rows ; i++) {
     for (j = 0; j< cols ; j++) {
         sWo(cellwo,@cellbhue,i,j,YELLOW_);
	 sWo(cellwo,@sheetcol,i,j,"");
	 cv++;
       }
     }


  
 //  default


 //isok =sWo(cellwo,@sheetread,fname,2);
// <<"%V$isok\n";

   sWo(cellwo,@selectrowscols,0,page_rows-1,0,cols-1);

// sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);

 PGUP()
 PGN()
 PGDWN()
 PGDWN()
 
  while (1) {

         eventWait();
          mr = _erow;
	  mc = _ecol;
	  
         if (mr > 0) {
            the_row = mr;
         }

        if (_ewoid == cellwo) {
        
 
 	               if (_ebutton == LEFT_ && mr > 0) {
                        //mc->info(1);
 	                //mr->info(1);
                          if (mc == 2) {
                              getCellValue(mr,mc);
                          }

                         }
             
          sWo(ssmods,@redraw);
       
 
         whue = YELLOW_;
 	
         if (mc == 0  && (mr >= 0) && (_ebutton == RIGHT_)) {
           if ((mr % 2)) {
            whue = LILAC_;
 	   }
 
          sWo(cellwo,@cellbhue,swaprow_a,0,swaprow_a,cols,whue);         	 	 
 
          swaprow_b = swaprow_a;
 	  swaprow_a = mr;
 	 
// <<[_DB]"%V $swaprow_a $swaprow_b\n"
 
          sWo(cellwo,@cellbhue,swaprow_a,0,CYAN_);         
          }
                
              
       if (mr == 0 && (mc >= 0) && (_ebutton == RIGHT_)) {
 
          sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);   
          swapcol_b = swapcol_a;
  	  swapcol_a = mc;
          sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 

<<[_DB]"%V $swapcol_a $swapcol_b\n"
          }
 
         sWo(cellwo,@redraw);
 
         if (mr == 0 && (mc == tags_col) && (_ebutton == RIGHT_)) {
               
                 clearTags();   
         }
 
         if (mr > 0 && (mc == tags_col) && (_ebutton == RIGHT_)) {
<<[_DB]"mark tags <|$R[mr][tags_col]|>\n"

                if (R[mr][tags_col] @= "x") {
		R[mr][tags_col] = " "
 		sWo(cellwo,@cellval,mr,tags_col," ")
		}
		else {
		R[mr][tags_col] = "x"
 		sWo(cellwo,@cellval,mr,tags_col,"x")
                }
 		sWo(cellwo,@celldraw,mr,tags_col)
         }
 
    }
    else {
         if (_ename @= "PRESS") {
<<[_DB]"PRESS $_ename  $_ewoname !\n"
 
          if (!(_ewoname @= "")) {
          
             $_ewoname();
 
<<[_DB]" after indirect callback\n"
 
            }
         }
       }
          sWo(cellwo,@setcolsize,5,5,1);
          sWi(vp,@redraw);


 }



/{/*

//  each  cell has input text function
//  ability to sum cols and rows

/}*/