///
///  Make a crude block font
///
/// 
///

envdebug()

vers = "1.2"

/////////////////////////////////////////////////////////

proc wos2mat()
{
 // read out the current ss cells into a matrix

/{/*
   for (i = 0; i< rows ; i++) {
     for (j = 0; j< cols ; j++) {
       LM[i][j] = atof(wogetvalue(cellwo,i,j))
     }
   }
/}*/

   // need version that reads subset or all to a matrix - assumming conversion to float/double

   LM=wossgetvalues(cellwo,0,0,15,15); //much faster

}


proc mat2wos()
{
/// set the wo ss cells to values in local matrix

   for (i = 0; i< rows ; i++) {
     for (j = 0; j< cols ; j++) {
        if (LM[i][j] == 1) {
         sWo(cellwo,@cellbhue,i,j,LILAC_);
	 sWo(cellwo,@sheetcol,i,j,"1");
	 }
	 else {
         sWo(cellwo,@cellbhue,i,j,WHITE_);
	 sWo(cellwo,@sheetcol,i,j,"0");
         }
       }
     }
}

/// move the shape around

proc cycleRow()
{
  // back - forth
    LM= cyclerow(LM,5)
}
//=============================


proc centerImage()
{
   
// balance surrounding white row/cols

   wos2mat();

// sum the rows


// sum the cols

// top edge

// btm edge

// move up/down by ?

// left edge

// right edge

// move left/right by ?



}


/////////////////////////////////////////////////////////

 rows = 16; //
 cols = 16;

float LM[rows][cols];

 Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

//////////////////// WINDOW SETUP ////////////////////

 aw = cWi(@title,"FontMaker_$vers",@resize,0.05,0.02,0.97,0.99)

 sWi(aw,@pixmapon,@drawoff,@save,@bhue,LILAC_);

   lbp = 0.1;
  
   cellwo=cWo(aw,"SHEET",@name,"P",@color,GREEN_,@resize,lbp,0.01,0.9,0.99);
   sWo(cellwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED_,@VALUE,"SSWO")
   sWo(cellwo,@bhue,CYAN_,@clipbhue,"skyblue")


 rdwo=cWo(aw,@BN,@name,"READ",@value,"READ",@color,GREEN_)
 sWo(rdwo,@help," click to read image");

 nxtwo=cWo(aw,@BN,@name,"NEXT",@value,"READ",@color,BLUE_)
 sWo(nxtwo,@help," click to read next image");

 clearwo=cWo(aw,@BN,@name,"CLEAR",@value,"SAVE",@color,GREEN_)
 sWo(clearwo,@help," click to save sheet");


 savewo=cWo(aw,@BN,@name,"SAVE",@value,"SAVE",@color,MAGENTA_)
 sWo(savewo,@help," click to save sheet")

 qwo=cWo(aw,@BN,@name,"QUIT?",@value,"QUIT",@color,"orange")
 sWo(qwo,@help," click to quit")


 int edwos[] = {rdwo,nxtwo, clearwo,savewo,qwo};

 sWo(edwos,@border,@drawon,@clipborder,@fonthue,BLACK_);
 sWo(nxtwo,@fonthue,WHITE_);
 wovtile ( edwos, 0.02,0.2,0.09,0.70);
 sWo(edwos,@redraw);

 



  //////////////////////////////
 mopuwo=cWo(aw,@BN,@name,"UP",@value,"SAVE",@color,MAGENTA_)
 sWo(mopuwo,@help," click to move image up");
 sWo(mopuwo,@border,@drawon,@clipborder,@fonthue,BLACK_)

 moplwo=cWo(aw,@BN,@name,"LEFT",@value,"LEFT",@color,MAGENTA_)
 sWo(moplwo,@help," click to move image left");
 sWo(moplwo,@border,@drawon,@clipborder,@fonthue,BLACK_);

 moprwo=cWo(aw,@BN,@name,"RIGHT",@value,"RIGHT",@color,MAGENTA_)
 sWo(moprwo,@help," click to move image right ");
 sWo(moprwo,@border,@drawon,@clipborder,@fonthue,BLACK_);


 mopdwo=cWo(aw,@BN,@name,"DOWN",@value,"DOWN",@color,MAGENTA_)
 sWo(mopdwo,@help," click to move image down ");
 sWo(mopdwo,@border,@drawon,@clipborder,@fonthue,BLACK_);

 mocenwo=cWo(aw,@BN,@name,"CENTER",@value,"CENTER",@color,MAGENTA_)
 sWo(mocenwo,@help," click to center image  ");
 sWo(mocenwo,@border,@drawon,@clipborder,@fonthue,BLACK_);



 int mwos[] = { mopuwo, moplwo, moprwo, mopdwo, mocenwo};

 wovtile ( mwos, 0.91,0.41,0.99,0.70);

    
    sWi(aw,@redraw);

    char ce;

    na = argc();
    if (na >= 1)
     fname = _clarg[1];
    else
     fname = "A";

    sfname ="${fname}.sst"


    tfz = fexist(sfname);
    if (tfz > 0) {
    isok =sWo(cellwo,@sheetread,sfname);
    }
    else {

<<" no initial font $sfname!\n"
    }
    
    sWo(cellwo,@setrowscols,rows,cols);
    sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);

//    sWo(cellwo,@selectrowscols,0,15,0,15);


   wos2mat();
   mat2wos();
    sWo(cellwo,@redraw);
    
include "gevent.asl";
     eventWait();

   while (1) {
   
        eventWait();


   //  <<"%V $ev_row $ev_col \n"
       // get current cell value
       // toggle 0 <-> 1
       // toggle BLUE_ <-> WHITE

       sWo(cellwo,@cellhue,ev_row,ev_col,RED_);
   if (ev_woid == cellwo) {
     if (ev_button ==1) {
         sWo(cellwo,@cellbhue,ev_row,ev_col,LILAC_);
//	 sWo(cellwo,@sheetcol,ev_row,ev_col,"1");
	 sWo(cellwo,@cellval,ev_row,ev_col,"1");
     }
     else {
        sWo(cellwo,@cellbhue,ev_row,ev_col,WHITE_);
       // sWo(cellwo,@sheetcol,ev_row,ev_col,"0");
	 sWo(cellwo,@cellval,ev_row,ev_col,"0");
    }
        // want update/redraw cell
         //sWo(cellwo,@redraw);
	 sWo(cellwo,@celldraw,ev_row,ev_col);
    }
    
       if (ev_woid == savewo) {
         fname =  queryw("F_NAME","font name","A");
         sWo(cellwo,@name,fname);
	 sWo(cellwo,@sheetmod,1); // this instructs GM to write the SS
	 sWi(aw,@tmsg,"saving_the_font ");
         sWi(aw,@redraw)
        }

      if (ev_woid == clearwo) {
	 sWo(cellwo,@cellbhue,-2,-2,WHITE_); // row,col -2,-2 all cells
         sWo(cellwo,@cellval,-2,-2,"0");
	 sWi(aw,@tmsg,"clearing_the_font ");
	 sWo(cellwo,@redraw);
	 sWo(clearwo,@redraw);
        }
	
       if (ev_woid == qwo) {
	 sWi(aw,@tmsg,"Quit");
	 <<" exit $(getscript()) \n"
         break;
        }

       if (ev_woid == rdwo) {
            fname =  queryw("F_NAME","font name","A");
            sWo(cellwo,@name,fname);
            sfname ="${fname}.sst"

            tfz = fexist(sfname);
	    <<"$sfname $tfz\n"
           if (tfz > 0) {
              isok =sWo(cellwo,@sheetread,sfname);
              sWi(aw,@tmsg,"reading_the_font $sfname $isok");
	    //  sWo(cellwo,@setrowscols,rows,cols);
	      sWo(cellwo,@selectrowscols,0,9,0,9);
             }
           	
	         wos2mat();
		 mat2wos();
         sWi(aw,@redraw)
        }


       if (ev_woid == nxtwo) {

            
	     ce = pickc(fname,0);
             ce++;
             fname = "%c$ce";
            sWo(cellwo,@name,fname);
            sfname ="${fname}.sst"

            tfz = fexist(sfname);
	    <<"$sfname $tfz\n"
           if (tfz > 0) {
              isok =sWo(cellwo,@sheetread,sfname);
              sWi(aw,@tmsg,"reading_the_font $sfname $isok");
	    //  sWo(cellwo,@setrowscols,rows,cols);
	      sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);
             }
           	
	         wos2mat();
		 mat2wos();
         sWi(aw,@redraw)
        }



     if (ev_woid == mopuwo) {

        wos2mat();
       LM= cyclerow(LM,-1)

// LM= reflectrow(LM,3);
// LM= reflectcol(LM,3);	   

        mat2wos();
	sWo(cellwo,@redraw);
		 sWo(mopuwo,@redraw);
     }
     else if (ev_woid == moplwo) {
        wos2mat();
        LM= cyclecol(LM,-1)
        mat2wos();
	sWo(cellwo,@redraw);
     }
     else if (ev_woid == moprwo) {
        wos2mat();
        LM= cyclecol(LM,1)
        mat2wos();
	sWo(cellwo,@redraw);
     }
     else if (ev_woid == mopdwo) {
        wos2mat();
        LM= cyclerow(LM,1)
        mat2wos();
	sWo(cellwo,@redraw);

        sWo(mopdwo,@redraw);
     }
     else if (ev_woid == mocenwo) {



     }
//    woid == save  then write values of sheet
//    to name value  as save matrix rows x cols

   }

exitgs();

///
/{/*

   ----------------TBD--------------
   
   read from WOSS into matrix (all or subset) with conversion to numeric

   internal struct of SS within asl and <-> transfer
   

   




/}*/
