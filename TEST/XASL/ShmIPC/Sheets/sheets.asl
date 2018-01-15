

////////////  CREATE SIMPLE SPREAD SHEET /////////////


// each  cell input text function

//  ability to sum cols and rows

include "gevent.asl"

Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }



    vp = cWi(@title,"Simple Spread Sheet")

    sWi(vp,@pixmapon,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)



 cellwo=cWo(vp,"SHEET",@name,"DailyDiet",@color,GREEN_,@resize,0.1,0.1,0.9,0.5)
 // does value remain or reset by menu?

 sWo(cellwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,RED_,@VALUE,"SSWO",@FUNC,"inputValue")

 sWo(cellwo,@bhue,CYAN_,@clipbhue,"skyblue")

 rows = 8
 cols = 10

 sWo(cellwo,@setrowscols,rows,cols);
 sWo(cellwo,@sheetrow,0,0,"0,1,2,3,4,5,,7")
 sWo(cellwo,@sheetcol,1,0,"A,B,C,D,E,F,G")

 sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);

int cv = 0;


    for (i = 1; i< rows ; i++) {
     for (j = 1; j< cols ; j++) {
         sWo(cellwo,@cellbhue,i,j,LILAC_);
	 sWo(cellwo,@sheetcol,i,j,"$cv");
	 cv++;
       }
     }

  sWi(vp,@redraw)
  sWo(cellwo,@redraw)

  while (1) {

         eventWait();

         if (_erow > 0) {
            the_row = _erow;
         }

   <<" $_emsg %V $_ekeyw  $_ewoname $_ewoval \n"
           sWo(cellwo,@redraw);

 }

   exit()
   