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
//setdebug(1,@keep,@pline,@~trace);
//FilterFileDebug(REJECT_,"~storetype_e");
//FilterFuncDebug(REJECT_,"~ArraySpecs",);

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

//#include "tbqrd"

#include "gss_screen"





    READ();

<<"%V $R \n"

    sz= Caz(R);

   rows = sz;

   cols = Caz(R,0)
 
   tags_col = cols-1;
   

   sWo(_WOID,cellwo,_Wsetrowscols,tuple(rows+5,cols+1)); 

   sWo(_WOID,cellwo,_Wselectrowscols,tuple(0,rows-1,0,cols-1,ON_));

int cv = 0;

// cellsize ? - auto

    for (i = 1; i< rows ; i++) {
     for (j = 0; j< cols ; j++) {
         sWo(_WOID,cellwo,_Wcellbhue,tuple(i,j,YELLOW_));
	 sWo(_WOID,cellwo,_Wsheetcol,i,j,"");
	 cv++;
       }
     }

   sWo(_WOID,cellwo,_Wcellval,R);
  
 //  default


  sWo(_WOID,cellwo,_Wselectrowscols,tuple(0,rows-1,0,cols-1,ON_));

// sWo(_WOID,cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
  sWi(_WOID,vp,_Wredraw,ON_)


//sWo(_WOID,ssmods,_Wredraw,ON) ; //need loop thru ssmods


   sWo(_WOID,cellwo,_Wredraw,ON_);


 PGUP()
 PGN()
 
 PGDWN()
 
 PGDWN();
 

#include "gevent.asl"
int the_row;

   while (1) {



         eventWait();
          mr = _GEV_row;
	  mc = _GEV_col;
	   <<"$_GEV_keyw $_GEV_woname $_GEV_button \n";



         if (mr > 0) {
            the_row = mr;
         }

        if (_GEV_ewoid == cellwo) {
 	               if (_GEV_ebutton == LEFT_ && mr > 0) {
                        //mc->info(1);
 	                //mr->info(1);
                          if (mc == 2) {
                              getCellValue(mr,mc);
                          }
                         }
	}



          
         // sWo(_WOID,ssmods,@redraw);
       
 
         whue = YELLOW_;
 	
         if (mc == 0  && (mr >= 0) && (_GEV_button == RIGHT_)) {
           if ((mr % 2)) {
            whue = LILAC_;
 	   }
 
          sWo(_WOID,cellwo,_Wcellbhue,tuple(swaprow_a,0,swaprow_a,cols,whue));         	 	 
 
          swaprow_b = swaprow_a;
 	  swaprow_a = mr;
 	 
// <<[_DB]"%V $swaprow_a $swaprow_b\n"
 
          sWo(_WOID,cellwo,_Wcellbhue,tuple(swaprow_a,0,CYAN_));         
          }
                
              
       if (mr == 0 && (mc >= 0) && (_GEV_button == RIGHT_)) {
 
          sWo(_WOID,cellwo,_Wcellbhue,tuple(0,swapcol_a,0,cols,YELLOW_));   
          swapcol_b = swapcol_a;
  	  swapcol_a = mc;
          sWo(_WOID,cellwo,_Wcellbhue,tuple(0,swapcol_a,CYAN_));         	 

<<[_DB]"%V $swapcol_a $swapcol_b\n"
          }
 
         sWo(_WOID,cellwo,_Wredraw,ON_);
 
         if (mr == 0 && (mc == tags_col) && (_GEV_button == RIGHT_)) {
               
                 clearTags();   
         }
 
         if (mr > 0 && (mc == tags_col) && (_GEV_button == RIGHT_)) {
<<[_DB]"mark tags <|$R[mr][tags_col]|>\n"

                if (R[mr][tags_col] == "x") {
		R[mr][tags_col] = " "
 		sWo(_WOID,cellwo,_Wcellval,mr,tags_col," ")
		}
		else {
		R[mr][tags_col] = "x"
 		sWo(_WOID,cellwo,_Wcellval,mr,tags_col,"x")
                }
 		sWo(_WOID,cellwo,_Wcelldraw,mr,tags_col)
         }
    
    else {

       if (_GEV_name == "PRESS") {
<<"PRESS $_GEV_name  callback func $_GEV_woname !\n"
 
          if (!(_GEV_woname == "")) {

             if (_GEV_woname == "SORT") {
                       SORT();
             }
             else if (_GEV_woname == "SWOPROWS") {
                  SWOPROWS()
            }
             else if (_GEV_woname == "SWOPCOLS") {
                  SWOPCOLS()
            }	    
             else {
             $_GEV_woname();
 
<<" after indirect callback\n"
             }
            }
         }
       }

          sWo(_WOID,cellwo,_Wsetcolsize,3,3,1);
          sWi(_WOID,vp,_Wredraw,_ON);
    }

//  ?? has to be a following statement after while



<<" killing xgm $Xgm_pid \n";

 exitgs();
 <<"kill xgs now exit!\n";
 exit();
 



//  each  cell has input text function
//  ability to sum cols and rows

