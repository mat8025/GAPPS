///
///  Make a crude block font
///
/// 
///

envdebug()

vers = "1.0"

 Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }

 rows = 10; //
 cols = 9;


//////////////////// WINDOW SETUP ////////////////////

 aw = cWi(@title,"FontMaker_$vers",@resize,0.05,0.02,0.97,0.99)

 sWi(aw,@pixmapon,@drawoff,@save,@bhue,LILAC_);

   lbp = 0.09;
  
   cellwo=cWo(aw,"SHEET",@name,"font",@color,GREEN_,@resize,lbp,0.01,0.98,0.99);
   sWo(cellwo,@BORDER,@DRCELLWON,@CLIPBORDER,@FONTHUE,RED_,@VALUE,"SSWO")
   sWo(cellwo,@bhue,CYAN_,@clipbhue,"skyblue")



 fnwo=cWo(aw,"BV",@name,"FNAME",@value,"font",@color,GREEN_,@resize_fr,0.02,0.51,lbp,0.70);
 sWo(fnwo,@help," click to name sheet",@func,"inputValue",@style,"SVB");
 sWo(fnwo,@border,@drcellwon,@clipborder,@fonthue,BLACK_, @redraw);

 clearwo=cWo(aw,"BN",@name,"CLEAR",@value,"SAVE",@color,MAGENTA_,@resize_fr,0.02,0.31,lbp,0.50);
 sWo(clearwo,@help," click to clear sheet");
 sWo(clearwo,@border,@drcellwon,@clipborder,@fonthue,BLACK_, @redraw);

 savewo=cWo(aw,"BN",@name,"SAVE",@value,"SAVE",@color,MAGENTA_,@resize_fr,0.02,0.15,lbp,0.30)
 sWo(savewo,@help," click to save sheet")
 sWo(savewo,@border,@drcellwon,@clipborder,@fonthue,BLACK_, @redraw)


 qwo=cWo(aw,"BN",@name,"QUIT?",@value,"QUIT",@color,"orange",@resize_fr,0.02,0.01,lbp,0.14)
 sWo(qwo,@help," click to quit")
 sWo(qwo,@border,@drcellwon,@clipborder,@fonthue,BLACK_, @redraw)
 sWi(aw,@redraw)

    sfname ="font.txt"
    tfz = fexist(sfname);
    if (tfz > 0) {
    isok =sWo(cellwo,@sheetread,sfname);
    }
    sWo(cellwo,@setrowscols,rows,cols);
    sWo(cellwo,@selectrowscols,0,9,0,8);
    sWo(cellwo,@redraw);

include "gevent.asl";
eventWait();

   while (1) {
   
        eventWait();


     <<"%V $ev_row $ev_col \n"
       // get current cell value
       // toggle 0 <-> 1
       // toggle BLUE_ <-> WHITE

       sWo(cellwo,@cellhue,ev_row,ev_col,RED_);
   if (ev_woid == cellwo) {
   
     if (ev_button ==1) {
         sWo(cellwo,@cellbhue,ev_row,ev_col,LILAC_);
	 sWo(cellwo,@sheetcol,ev_row,ev_col,"1");
     }
     else {
        sWo(cellwo,@cellbhue,ev_row,ev_col,WHITE_);
        sWo(cellwo,@sheetcol,ev_row,ev_col,"0");
     }
       cval = wogetValue(cellwo,ev_row,ev_col);
       <<"cell val is $cval\n";
       sWo(cellwo,@redraw);
    }

       if (ev_woid == fnwo) {
	 fname = wogetValue(fnwo);
	 sWo(cellwo,@name,fname);
        }


       if (ev_woid == savewo) {
	 sWo(cellwo,@sheetmod,1);
	 sWi(aw,@tmsg,"saving_the_font ");
        }

      if (ev_woid == clearwo) {
	 sWo(cellwo,@cellbhue,-2,-2,WHITE_); // row,col -2,-2 all cells
         sWo(cellwo,@cellval,-2,-2,"0");
	 sWi(aw,@tmsg,"clearing_the_font ");
	 sWo(cellwo,@redraw);
        }
	
       if (ev_woid == qwo) {
	 sWi(aw,@tmsg,"Quit");
	 <<" exit maker \n"
         break;
        }
       
//    woid == save  then write values of sheet
//    to name value  as save matrix rows x cols

   }