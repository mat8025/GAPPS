

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



gwo3=cWo(vp,"SHEET",@name,"DailyDiet",@color,"green",@resize,0.1,0.1,0.9,0.5)
 // does value remain or reset by menu?

 sWo(gwo3,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red",@VALUE,"SSWO",@FUNC,"inputValue")

 sWo(gwo3,@bhue,"cyan",@clipbhue,"skyblue")

 rows = 8
 cols = 10
 sWo(gwo3,@setrowscols,rows,cols);
 sWo(gwo3,@sheetrow,0,0,"0,1,2,3,4,5,,7")
 sWo(gwo3,@sheetcol,1,0,"A,B,C,D")

 sWi(vp,@redraw)
  sWo(gwo3,@redraw)

  while (1) {

         eventWait();
         ev_woval = Ev->getEventWoValue();
         ev_woname = Ev->getEventWoName();

         if (ev_row > 0) {
            the_row = ev_row;
         }

   <<" $ev_msg %V $ev_keyw  $ev_woname $ev_woval \n"


 }

   stop!