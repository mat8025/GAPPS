//%*********************************************** 
//*  @script calcounter_addrow.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Fri Mar 13 09:39:02 2020 
//*  @cdate Fri Jan  4 09:27:43 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



proc addFoodItem(svar wfd)
{

    sz= Caz(R)
// find first empty? row

    er = -1;
    for (i=1; i < Nrows; i++) {
     wval = Dewhite(R[i][0]);
<<"$i <$wval>\n"
     if (wval @= "") {
     <<"found empty row! $i\n"
         er = i;
	break;
     }
    }
 //   R->info(1)


   if (er == -1) {
    rows++;
    Nrows++;
    er = Nrows-1;
<<"ADDING a row %V $rows $Nrows\n"
    }


<<"in $_proc record $rows row $er\n"
    // TBF wvd should not be PTR type! - but ARGPTR
    R[er] = wfd;
<<"%V $wfd\n"

<<"%V $R[er]\n"

    sz = Caz(R);

<<"%V $sz $rows $Nrows\n"

  for (k=0; k < Nrows ;k++) {
<<"$k $R[k]\n"
  }

<<"$R\n"
<<"after add row \n"
<<"b4 setrowcols\n"


   sWo(cellwo,@setrowscols,Nrows,cols+1);
   sWo(cellwo,@selectrows,0,Nrows-1);


<<"b4 totalRows\n"


   totalRows();

<<"%V $R\n"

   setRowColSizes()

<<"after adding %V $er $rows $Nrows $cols\n"

  //sWo(cellwo,@cellval,R,0,0,rows+1,cols);
//   R->info(1)
<<"b4 cellval\n"

  sWo(cellwo,@cellval,R);
  sWo(cellwo,@redraw);
  
 <<"%V$totalswo \n"
 <<"%V $cols\n"
//   R->info(1)
<<"b4 displayTotals\n"
   displayTotals()

   color_foodlog();
}
//=======================
