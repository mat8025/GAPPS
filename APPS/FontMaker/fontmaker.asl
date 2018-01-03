///
///  Make a crude block font
///
/// 
///

//envdebug()
setDebug(1);
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
   
   LM=wossgetvalues(cellwo,0,0,rows-1,cols-1); //much faster

}


proc mat2wos()
{
/// set the wo ss cells to values in local matrix
/// need wosssetvalues(cellwo,0,0,rows-1,cols-1,LM); // much faster ?
	 sWo(cellwo,@cellval,0,0,rows-1,cols-1,LM);
	 sWo(cellwo,@cellbhue,0,0,rows-1,cols-1,LM);
}
//========================
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

int le;
int re;
int te;
int be;

   wos2mat();

// sum the rows
   Rsum=RowSum(LM)
   Rsum->redimn();
   
<<"Rsum %6.1f$Rsum \n"
// sum the cols

     Csum=ColSum(LM);
     Csum->redimn();

<<"Csum %6.1f$Csum\n"

// top edge

 ivec = Rsum->findVal(0,0,1,0,LT_)

<<"TE %V $ivec\n"
   te = ivec[0];
   if (te == -1) {
     te = 0;
   }


// btm edge
   ivec = Rsum->findVal(0,-1,-1,0,LT_)
   be = ivec[0];
   if (be == -1) {
     be = 0;
   }
   be = rows -be -1;

// move up/down by ?
      us = (te - be)/2;
      LM= cyclerow(LM,-us);
      mat2wos();

<<"%V$le $re $us\n"


// left edge


 ivec = Csum->findVal(0,0,1,0,LT_)

<<"LE %V $ivec\n"
   le = ivec[0];
   if (le == -1) {
     le = 0;
   }
// right edge

   ivec = Csum->findVal(0,-1,-1,0,LT_)
   //ivec = Csum->findVal(0,-1,-1,0,"<")
   //ivec = findVal(Csum,0,-1,-1,0,"<")
   
<<"RE %V $ivec\n"
   re = ivec[0];
   if (re == -1) {
     re = 0
   }
   re = cols -re -1;

// move left/right by ?

      ls = (re - le)/2;
      LM= cyclecol(LM,ls);
      mat2wos();

  <<"%V$le $re $us $ls\n"

}


/////////////////////////////////////////////////////////

 rows = 32; //
 cols =  20;

float LM[rows][cols];

 Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

//////////////////// WINDOW SETUP ////////////////////

 aw = cWi(@title,"FontMaker_$vers",@resize,0.05,0.02,0.97,0.99)

 sWi(aw,@pixmapon,@drawoff,@save,@bhue,LILAC_);

tbqwo=cWo(aw,@TB,@name,"tb_q",@color,RED_,@VALUE,"QUIT",@func,"window_term",@resize,0.95,0,0.97,1)
 sWo(tbqwo,@drawon,@pixmapon,@fonthue,RED_, @symbol,11,  @symsize, 3, @clip,0,0,1,1,@redraw)

   lbp = 0.1;
  
   cellwo=cWo(aw,"SHEET",@name,"P",@color,GREEN_,@resize,lbp,0.01,0.9,0.99);
   sWo(cellwo,@BORDER,@drawon,@clipborder,@fonthue,RED_,@VALUE,"SSWO")
   sWo(cellwo,@bhue,CYAN_,@clipbhue,"skyblue")


 rdwo=cWo(aw,@BN,@name,"READ",@value,"READ",@color,GREEN_)
 sWo(rdwo,@help," click to read image");

 nxtwo=cWo(aw,@BN,@name,"NEXT",@value,"NEXT",@color,BLUE_)
 sWo(nxtwo,@help," click to read next image");

 prvwo=cWo(aw,@BN,@name,"PREV",@value,"PREV",@color,BLUE_)
 sWo(prvwo,@help," click to read prev image");

 clearwo=cWo(aw,@BN,@name,"CLEAR",@value,"CLEAR",@color,GREEN_)
 sWo(clearwo,@help," click to clear sheet");

 refreshwo=cWo(aw,@BN,@name,"REFRESH",@value,"REFRESH",@color,GREEN_)
 sWo(refreshwo,@help," click to  redraw sheet");


 savewo=cWo(aw,@BN,@name,"SAVE",@value,"SAVE",@color,MAGENTA_)
 sWo(savewo,@help," click to save sheet")

 qwo=cWo(aw,@BN,@name,"QUIT?",@value,"QUIT",@color,"orange")
 sWo(qwo,@help," click to quit")


 int edwos[] = { rdwo, nxtwo, prvwo,  clearwo, refreshwo, savewo, qwo};

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


enum fmcase {
     SHEET = 80,
     READ = 0,
     NEXT,
     PREV,     
     CLEAR,
     REFRESH,
     SAVE,
     QUIT,
     UP,
     LEFT,
     RIGHT,
     DOWN,
     CENTER,
};


 int mwos[] = { mopuwo, moplwo, moprwo, mopdwo, mocenwo};

 wovtile ( mwos, 0.91,0.41,0.99,0.70);

 allwos = edwos @+ mwos;

<<"%V $allwos\n"
    
    sWi(aw,@redraw);

    char ce;

    na = argc();
    if (na > 1)
     fname = _clarg[1];
    else
     fname = "A";

<<"%V $na $fname\n"

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

//   ans= iread("go_forth\n")
   rloop =1;
   
   while (rloop) {
   
        eventWait();
 
   <<"%V$_eloop $_ewoid $_etype $_ename \n"
   //  <<"%V $ev_row $ev_col \n"

      sWo(cellwo,@cellhue,_erow,_ecol,RED_);

      if (_ewoid == cellwo) {
          skey = 80;
      }
      else {
      index = findVal(allwos,_ewoid);
      skey = index[0] ;
      }

      cname = fmcase->enumNameFromValue(skey);
<<"%V $index $_ewoid $skey $cname  \n"

      switch (skey) {

         case  SHEET:
          <<" @ $cellwo \n"
           if (_ebutton ==1) {
          sWo(cellwo,@cellbhue,_erow,_ecol,BLACK_);
	  sWo(cellwo,@cellval,_erow,_ecol,"1");
	  sWo(cellwo,@celldraw,_erow,_ecol);
          }
          else if (_ebutton ==3) {
           sWo(cellwo,@cellbhue,_erow,_ecol,WHITE_);
	   sWo(cellwo,@cellval,_erow,_ecol,"0");
	   sWo(cellwo,@celldraw,_erow,_ecol);
          }
           break;
    
      case SAVE:
          <<" @ %V $savewo \n"
         fname =  queryw("F_NAME","font name","$fname");
         sWo(cellwo,@name,fname);
	 sWo(cellwo,@sheetmod,1); // this instructs GM to write the SS
	 sWi(aw,@tmsg,"saving_the_font ");
         sWi(aw,@redraw)

       break;

      case CLEAR:
                   <<" @ $clearwo \n"
	 sWo(cellwo,@cellbhue,-2,-2,WHITE_); // row,col -2,-2 all cells
         sWo(cellwo,@cellval,-2,-2,"0");
	 sWi(aw,@tmsg,"clearing_the_font ");
	 sWo(cellwo,@redraw);
	 sWo(clearwo,@redraw);
       break;

       case REFRESH:
	   sWo(cellwo,@redraw);
	   sWo(refreshwo,@redraw);
       break;
	
      case  QUIT:
	 sWi(aw,@tmsg,"Quit");
	 <<" exit $(getscript()) \n"
          rloop = 0;
       break;

       case READ:
           <<" doing read  $rdwo\n";
	   
            fname =  queryw("F_NAME","font name","A");
            sWo(cellwo,@name,fname);
            sfname ="${fname}.sst"

            tfz = fexist(sfname);
	    <<"$sfname $tfz\n"
           if (tfz > 0) {
              isok =sWo(cellwo,@sheetread,sfname);
              sWi(aw,@tmsg,"reading_the_font $sfname $isok");
	      sWo(cellwo,@selectrowscols,0,9,0,9);
             }
           	
	         wos2mat();
		 mat2wos();
                sWi(aw,@redraw)
        break;
       case NEXT:
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
	      sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);
             }
	     wos2mat();
             mat2wos();
             sWi(aw,@redraw)
        
       break;
       case PREV:
	     ce = pickc(fname,0);
             ce--;
             fname = "%c$ce";
            sWo(cellwo,@name,fname);
            sfname ="${fname}.sst"

            tfz = fexist(sfname);
	    <<"$sfname $tfz\n"
           if (tfz > 0) {
              isok =sWo(cellwo,@sheetread,sfname);
              sWi(aw,@tmsg,"reading_the_font $sfname $isok");
	      sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);
             }
	     wos2mat();
             mat2wos();
             sWi(aw,@redraw)
       break;
     case  UP:

       wos2mat();
       LM= cyclerow(LM,-1)
        mat2wos();
	sWo(cellwo,@redraw);
        sWo(mopuwo,@redraw);
       break;
     case LEFT:
        wos2mat();
        LM= cyclecol(LM,-1)
        mat2wos();
	sWo(cellwo,@redraw);
        sWo(moplwo,@redraw);	
      break;
     case RIGHT:
        wos2mat();
        LM= cyclecol(LM,1)
        mat2wos();
	sWo(cellwo,@redraw);
        sWo(moprwo,@redraw);		
      break;
     case DOWN:
        wos2mat();
        LM= cyclerow(LM,1)
        mat2wos();
	sWo(cellwo,@redraw);
        sWo(mopdwo,@redraw);
       break;
     case CENTER:
         centerImage()
	sWo(cellwo,@redraw);
	sWo(mocenwo,@redraw);
       break;

    }

      fflush()
   }

exitgs();

///
/{/*

   ----------------TBD--------------
   
   read from WOSS into matrix (all or subset) with conversion to numeric

   internal struct of SS within asl and <-> transfer
   

   




/}*/
