///
///
////////////   SIMPLE SPREAD SHEET  EXAMPLE /////////////


//  each  cell has an input text function
// 

// open a csv/tsv/rec file
// read contents and set up a spreadsheet
// gui controls direct  manipulation of the
// record data (asl side)
// and the sheet is update xgs sid
// user can enter text into cells via the gui interface

//
//  need a rapid and smart update changes only
//

// could have a number of sheets in different windows




#include "gevent.asl"




void SAVE()
{
         <<"saving sheet\n"
       //  for (i = 0; i < rows;i++) { 
       //    <<"[${i}] $R[i][::]\n"
       //  }
            B=ofw("gss.csv")
	    writeRecord(B,R);
	    cf(B)
          //sWo(cellwo,@sheetmod,1);
}
//======================

void READ()
{
      <<"reading $fname\n"
       // isok =sWo(cellwo,@sheetread,fname,2)
            A= ofr(fname)
            R= readRecord(A,@del,',')
           cf(A)
           sz = Caz(R);
          <<"num of records $sz\n"
          sWo(cellwo,@cellval,R);
}
//======================
void SORT()
{

  sortcol = swapcol_a;
  startrow = 1;
  alphasort = 0; // 0 auto alpha or number 1 alpha   2 number
  sortdir = 1;
  
  sortRows(R,sortcol,alphasort,sortdir,startrow)


     sWo(cellwo,@cellval,R);
     sWo(cellwo,@redraw);

}
//======================
void Stuff2Do()
{

	//	ans = query("new stuff:");

}

Graphic = CheckGwm()


     if (!Graphic) {
        X=spawngwm()
     }


#include "tbqrd"

    vp = cWi(@title,"Simple Spread Sheet")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.9,0.9)

  sWi(vp,@redraw)

    titleButtonsQRD(vp);

///    GSS  modfiy functions

      readwo = cWo(vp,@BN,@name,"READ",@color,"lightgreen");

      savewo = cWo(vp,@BN,@name,"SAVE",@color,LILAC_);

      sortwo = cWo(vp,@BN,@name,"SORT",@color,CYAN_);

      swprwo = cWo(vp,@BN,@name,"SWOPROWS",@color,GREEN_);

      swpcwo = cWo(vp,@BN,@name,"SWOPCOLS",@color,RED_);

      delrwo = cWo(vp,@BN,@name,"DELROW",@color,RED_);

      delcwo = cWo(vp,@BN,@name,"DELCOL",@color,ORANGE_,@bhue,YELLOW_);
      

      int ssmods[] = { readwo,savewo,sortwo,swprwo,swpcwo,delrwo, delcwo }


      wovtile(ssmods,0.05,0.1,0.1,0.7,0.05);




 cellwo=cWo(vp,"SHEET",@name,"Stuff2Do",@color,GREEN_,@resize,0.12,0.1,0.9,0.95)
 // does value remain or reset by menu?

 sWo(cellwo,@border,@drawon,@clipborder,@fonthue,RED_,@value,"SSWO",@func,"inputValue")

 sWo(cellwo,@bhue,CYAN_,@clipbhue,SKYBLUE_,@redraw)

 

 
 //sWo(cellwo,@sheetrow,0,0,"0,1,2,3,4,5,,7")
 //sWo(cellwo,@sheetcol,1,0,"A,B,C,D,E,F,G")



   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);






   gflush()



int cv = 0;



// setdebug(1,"step","pline");

  fname = "pp.rec"
  fname = "Stuff2Do.csv";
   fname = "gss.csv";

 //isok =sWo(cellwo,@sheetread,fname,2);
 //<<"%V$isok\n";

A= ofr(fname)
   R= readRecord(A,@del,',')
cf(A)
   sz = Caz(R);

<<"num of records $sz\n"

  rows = sz;
  cols = Caz(R[0])
   
 sWo(cellwo,@setrowscols,rows,cols);
 
<<"%V$rows $sz \n"

for (i = 0; i < rows;i++) {
<<"[${i}] $R[i]\n"
}



    for (i = 0; i< rows ; i++) {
     for (j = 0; j< cols ; j++) {
        if ((i%2)) {
sWo(cellwo,@cellbhue,i,j,LILAC_);         
	}
	else {
sWo(cellwo,@cellbhue,i,j,YELLOW_);

	 }
	 
//	 sWo(cellwo,@sheetcol,i,j,R[i][j]);
	 cv++;
       }
     }




     sWo(cellwo,@cellval,R);
 //  sWo(cellwo,@cellval,R,1,1,5,5,1,1);


  rows = sz + 3;
  //cols = Caz(R[0])
   
   sWo(cellwo,@setrowscols,rows,cols);

//   sWo(cellwo,@selectrowscols,0,rows-1,0,cols-1);

// sWo(cellwo,@cellbhue,1,-2,LILAC_); // row,col wr,-2 all cells in row
   sWi(vp,@redraw)

   sWo(ssmods,@redraw)

   sWo(cellwo,@redraw);

   swaprow_a = 1;
   swaprow_b = 2;

   swapcol_a = 1;
   swapcol_b = 2;
<<"%V $cellwo\n"





  while (1) {

         eventWait();

   <<" $_emsg %V $_eid $_ekeyw  $_ekeyw2 $_ewoname $_ewoval $_erow $_ecol $_ewoid \n"


         if (_erow > 0) {
            the_row = _erow;
         }

       if (_ewoid == cellwo) {
       
             if (_ekeyw @= "Stuff2Do") {
                r= _erow;
		c= _ecol;
		<<"%V$_erow $_ecol\n"
		ans = queryw("new val","new val:","xxx");
		<<"ans entered was $ans\n"
                R[r][c] = ans;
		
	//	<<"update cell val $r $c $_erow $_ecol $_ekeyw2 $R[_erow][_ecol] \n"
		<<"update cell val $r $c $_erow $_ecol $_ekeyw2 $R[r][c] \n"
		<<"updated row $R[r]\n"
            }


      }
         if (_ecol == 0  && (_erow >= 0) && (_ebutton == RIGHT_)) {
         swaprow_b = swaprow_a;
	 swaprow_a = _erow;
<<"%V $swaprow_a $swaprow_b\n"
         }

         if (_erow == 0 && (_ecol >= 0) && (_ebutton == RIGHT_)) {
         swapcol_b = swapcol_a;
	 swapcol_a = _ecol;
<<"%V $swapcol_a $swapcol_b\n"
         }

       if (_ewoid == swprwo) {
<<"swap rows $swaprow_a and $swaprow_b\n"
         sWo(cellwo,@swaprows,swaprow_a,swaprow_b);
	 R->SwapRows(swaprow_a,swaprow_b);
       }

       if (_ewoid == swpcwo) {
<<"swap cols $swapcol_a and $swapcol_b\n"
         sWo(cellwo,@swapcols,swapcol_a,swapcol_b);
	 	 R->SwapCols(swapcol_a,swapcol_b);
       }
       
       sWo(cellwo,@cellval,R);
        sWo(cellwo,@redraw);


       if (_ename @= "PRESS") {
        if (!(_ewoname @= "")) {
<<"calling function via $_ewoname !\n"
            $_ewoname()
        }
      }


/*
       if (_ewoid == savewo) {   //SAVE
         <<"saving sheet\n"
       //  for (i = 0; i < rows;i++) { 
       //    <<"[${i}] $R[i][::]\n"
       //  }
            B=ofw("gss.csv")
	    
	    writeRecord(B,R);
	    cf(B)
          //sWo(cellwo,@sheetmod,1);
	}
	
        if (_ewoid == readwo) {
         <<"reading $fname\n"
       // isok =sWo(cellwo,@sheetread,fname,2)
            A= ofr(fname)
            R= readRecord(A,@del,',')
           cf(A)
           sz = Caz(R);
          <<"num of records $sz\n"
          sWo(cellwo,@cellval,R);
       }
*/

}
<<"out of loop\n"

 exit()
   