/*
 *  @script sheets.asl 
 * 
 *  @comment display csv as spreadsheet for edit ops 
 *  @release CARBON 
 *  @vers 1.3 Li Lithium                                                  
 *  @date Wed Mar 27 10:12:13 2019 
 *  @cdate 1/1/2016 
 *  @author Mark Terry 
 *  @Copyright  RootMeanSquare  2010,2019 --> 
 */

//----------------<v_&_v>-------------------------//                                                 

Str Use_= "  test the SpreadSheet";




//#include "debug"

   //debugON();
 // scriptDBON()

#include "hv.asl"
#include "gss.asl"


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

#include "tbqrd"

#include "gss_screen"


    READ();

<<"%V $R \n"

    sz= Caz(R);

   rows = sz;

   cols = Caz(R,0)
 
   tags_col = cols-1;
   

   sWo(_woid,cellwo,_wsetrowscols,tuple(rows+5,cols+1)); 

   sWo(_woid,cellwo,_wselectrowscols,tuple(0,rows-1,0,cols-1,ON_));

int cv = 0;

// cellsize ? - auto

    for (i = 1; i< rows ; i++) {
     for (j = 0; j< cols ; j++) {
         sWo(_woid,cellwo,_wcellbhue,tuple(i,j,YELLOW_));
	 sWo(_woid,cellwo,_wsheetcol,i,j,"");
	 cv++;
       }
     }

   sWo(_woid,cellwo,_Wcellval,R);
  
 //  default


  sWo(_woid,cellwo,_Wselectrowscols,tuple(0,rows-1,0,cols-1,ON_));

// sWo(_woid,cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
  sWi(_woid,vp,_Wredraw,ON_)


//sWo(_woid,ssmods,_Wredraw,ON) ; //need loop thru ssmods


   sWo(_woid,cellwo,_Wredraw,ON_);


 PGUP()
 PGN()
 
 PGDWN()
 
 PGDWN();
 

#include "gevent.asl"


int the_row;


   while (1) {

         eventWait() ; 
	 
          mr = erow;
	  mc = ecol;
	   <<"$ekeyw $ewoname $ebutton \n";



         if (mr > 0) {
            the_row = mr;
         }

        if (woid == cellwo) {
 	               if (button == LEFT_ && mr > 0) {
                        //mc->info(1);
 	                //mr->info(1);
                          if (mc == 2) {
                              getCellValue(mr,mc);
                          }
                         }
	}



          
         // sWo(_woid,ssmods,@redraw);
       
 
         whue = YELLOW_;
 	
         if (mc == 0  && (mr >= 0) && (ebutton == RIGHT_)) {
           if ((mr % 2)) {
            whue = LILAC_;
 	   }
 
          sWo(_woid,cellwo,_Wcellbhue,dectuple(swaprow_a,0,swaprow_a,cols,whue));         	 	 
 
          swaprow_b = swaprow_a;
 	  swaprow_a = mr;
 	 
// <<[_DB]"%V $swaprow_a $swaprow_b\n"
 
          sWo(_woid,cellwo,_Wcellbhue,dectuple(swaprow_a,0,CYAN_));         
          }
                
		
              
       if (mr == 0 && (mc >= 0) && (ebutton == RIGHT_)) {
 
          sWo(_woid,cellwo,_Wcellbhue,dectuple(0,swapcol_a,0,cols,YELLOW_));   
          swapcol_b = swapcol_a;
  	  swapcol_a = mc;
          sWo(_woid,cellwo,_Wcellbhue,dectuple(0,swapcol_a,CYAN_));         	 

<<[_DB]"%V $swapcol_a $swapcol_b\n"
          }
 
         sWo(_woid,cellwo,_Wredraw,ON_);
 
         if (mr == 0 && (mc == tags_col) && (ebutton == RIGHT_)) {
               
                 clearTags();   
         }
 
         if (mr > 0 && (mc == tags_col) && (ebutton == RIGHT_)) {
<<[_DB]"mark tags <|$R[mr][tags_col]|>\n"

                if (R[mr][tags_col] == "x") {
		R[mr][tags_col] = " "
 		sWo(_woid,cellwo,_Wcellval,mr,tags_col," ")
		}
		else {
		R[mr][tags_col] = "x"
 		sWo(_woid,cellwo,_Wcellval,mr,tags_col,"x")
                }
 		sWo(_woid,cellwo,_Wcelldraw,mr,tags_col)
         }
    
    else {

       if (ename == "PRESS") {
<<"PRESS $ename  callback func $ewoname !\n"
 
          if (!(ewoname == "")) {

             if (ewoname == "SORT") {
                       SORT();
             }
             else if (ewoname == "SWOPROWS") {
                  SWOPROWS()
            }
             else if (ewoname == "SWOPCOLS") {
                  SWOPCOLS()
            }	    
             else {
             $ewoname();
 
<<" after indirect callback\n"
             }
            }
         }
       }

          sWo(_woid,cellwo,_Wsetcolsize,3,3,1);
          sWi(_woid,vp,_Wredraw,_ON);
    }

//  ?? has to be a following statement after while



<<" killing xgm $Xgm_pid \n";

 exitgs();
 <<"kill xgs now exit!\n";
 exit();
 



//  each  cell has input text function
//  ability to sum cols and rows

