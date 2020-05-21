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
     <<"found empty row! \n"
        er = i;
	break;
     }
    }

   if (er == -1) {

    rows++;
    Nrows++;
    er = Nrows-1;
<<"ADDING a row %V $rows $Nrows\n"
}
   
<<"in $_proc record $rows  $er\n"

    R[er] = wfd;
    sz = Caz(R);
    
  <<"%V $sz $rows $Nrows\n"

//   <<"New size %V $rows $cols $sz\n";   // increase ??
  
//   sWo(cellwo,@setrowscols,rows+1,cols+1);
//   sWo(cellwo,@selectrowscols,0,rows-1,0,cols);


   sWo(cellwo,@setrowscols,Nrows,cols+1);
   sWo(cellwo,@selectrowscols,0,Nrows-1,0,cols-1);



// swap prev last and this row
//  swaprow_a = er;
// swaprow_b = er-1;
   
  // SWOPROWS();
   R->info(1)
   totalRows();
   
<<"AFTER adding \n"

<<"$R\n"

//  
   setRowColSizes()

<<"after adding %V $er $rows $Nrows $cols\n"
<<"$R[er]\n"
  //sWo(cellwo,@cellval,R,0,0,rows+1,cols);

  sWo(cellwo,@cellval,R);
  sWo(cellwo,@redraw);
  
 <<"%V$totalswo \n"
 <<"%V $cols\n"

 displayTotals()
 color_foodlog();
}
//=======================
