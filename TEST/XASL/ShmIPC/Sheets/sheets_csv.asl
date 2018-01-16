

////////////  CREATE SIMPLE SPREAD SHEET /////////////


// each  cell input text function

//  ability to sum cols and rows

include "gevent.asl"


setdebug(1,"keep");


Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }


include "tbqrd"

    vp = cWi(@title,"Simple Spread Sheet")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

  sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modfiy functions

      savewo = cWo(vp,@BN,@name,"SAVE",@color,BLUE_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);

      swpcwo = cWo(vp,@BN,@name,"SWOPCOLS",@color,RED_);

      delrwo = cWo(vp,@BN,@name,"DELROW",@color,RED_);

      delcwo = cWo(vp,@BN,@name,"DELCOL",@color,ORANGE_,@bhue,YELLOW_);
      

      int ssmods[] = { savewo,swprwo,swpcwo,delrwo, delcwo }


      wovtile(ssmods,0.05,0.1,0.1,0.7,0.05);




 cellwo=cWo(vp,"SHEET",@name,"Stuff2Do",@color,GREEN_,@resize,0.1,0.1,0.9,0.85)
 // does value remain or reset by menu?

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO",@func,"inputValue")

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_)

 rows = 16;
 cols = 8;

 sWo(cellwo,@setrowscols,rows,cols);
 sWo(cellwo,@sheetrow,0,0,"0,1,2,3,4,5,,7")
 sWo(cellwo,@sheetcol,1,0,"A,B,C,D,E,F,G")

 sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);

int cv = 0;


    for (i = 1; i< rows ; i++) {
     for (j = 0; j< cols ; j++) {
         sWo(cellwo,@cellbhue,i,j,YELLOW_);
	 sWo(cellwo,@sheetcol,i,j,"");
	 cv++;
       }
     }

// setdebug(1,"step","pline");

  fname = "pp.rec"
  fname = "Stuff2Do.csv";

 isok =sWo(cellwo,@sheetread,fname,2);
 <<"%V$isok\n";
 
sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);

// sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
  sWi(vp,@redraw)

  sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);

   swaprow_a = 1;
   swaprow_b = 2;

   swapcol_a = 1;
   swapcol_b = 2;

  while (1) {

         eventWait();

         if (_erow > 0) {
            the_row = _erow;
         }

         if (_ecol == 0  && (_erow >= 0) && (_ebutton == RIGHT_)) {
         swaprow_b = swaprow_a;
	 swaprow_a = _erow;
<<"%V $swaprow_a $swaprow_b\n"
         }

         if (_erow == 0) {
         swapcol_b = swapcol_a;
	 swapcol_a = _ecol;
<<"%V $swapcol_a $swapcol_b\n"
         }



   <<" $_emsg %V $_ekeyw  $_ewoname $_ewoval $_erow $_ecol\n"

       if (_ewoid == swprwo) {
<<"swap rows $swaprow_a & $swaprow_b\n"

         sWo(cellwo,@swaprows,swaprow_a,swaprow_b);
       }

        sWo(cellwo,@redraw);

       if (_ewoid == savewo) {
         <<"saving sheet\n"
	 sWo(cellwo,@sheetmod,1);
	 
	}
 }
<<"out of loop\n"
setdebug(2,"pline");
 exit()
   