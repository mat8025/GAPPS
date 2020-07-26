//%*********************************************** 
//*  @script editfoods_ssp.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Tue Jun 18 08:50:55 2019 
//*  @cdate Fri Jan  4 09:27:43 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


int NFV = 24;// last is Zn
int Bestpick[5][2];

proc setRowColSizes()
{
   sWo(cellwo,@setrowsize,2,0,1) ;
   sWo(cellwo,@setcolsize,3,0,1) ;   
   sWo(choicewo,@setcolsize,3,0,1) ;
}
//=====================================//

proc Addrow()
{

    sz= Caz(R)
<<"in $_proc record $rows $sz\n"
    er = rows;

    R[er] = DF[0];

    rows++;
    sz = Caz(R);

// <<"New size %V $rows $cols $sz\n";   // increase ??
  
   sWo(cellwo,@setrowscols,rows+1,cols+1);
   sWo(cellwo,@selectrows,0,rows-1);

   setRowColSizes();
   sWo(cellwo,@cellval,R,0,0,rows,cols);
   sWo(cellwo,@redraw);
}
//======================================//




proc foodSearch()
{
int i;



  Bestpick = -1;		//clear the best pick choices
  bpick = -1;
  bpick = checkFood();
  <<"$_proc $bpick \n"

  j= Nbp-1;
  for (i=0; i<Nbp; i++) {
  bpick = Bestpick[j][1];
  if (bpick >0) {
    RC[i] = RF[bpick];
  <<"<$i> <$j> $bpick $RC[i][0]  $RC[i][1]  $RC[i][2]  $RC[i][3] \n"
  }
  else {
   //RC[i][::] = " "; 
  }
  j--;
 }


<<"best choice?: $RC[0] \n"
<<"%V $cols\n"
//sWo(choicewo,@cellval,RC,0,0,2,cols);

<<"%V $choicewo $cellwo \n"

<<"%V $cols \n"

//testargs(1,choicewo,@selectrowscols,0,2,0,cols-1,1); // startrow,endrow,startcol,endcol

  sWo(choicewo,@selectrows,0,Nbp-1,1); // startrow,endrow,startcol,endcol
  setRowColSizes();
   
sWo(choicewo, @cellval, RC,0,0,Nbp,cols);  // startrow,startcol,nrows, ncols

sWo(choicewo,@redraw);

 //debugON()
}

//======================================//
proc FoodSearch()
{
int i;
<<"what is myfood string? <|$_emsg|> $_ekeyw \n"
<<"<$_ewords[3]> <$_ewords[4]> <$_ewords[5]> \n"
  myfood = "$_ewords[1] $_ewords[2] $_ewords[3]"
  
  foodSearch()
}
//=======================================



proc FoodChoice()
{


float mf = 2;
svar wans;
<<"$_proc  $_ecol $_erow \n"

   if (_ecol == 0) {
            addFoodItem()
   }

    fd= RC[_erow][0];
//<<"$fd \n"
    sWo(searchwo,@value,fd,@redraw);
   if (_ecol == 1) {



    mans = popamenu("HowMuch.m");
    mf = atof(mans);
    if (mf > 0.0) {
     wans = RC[_erow];
wans->info(1)
<<"%V $wans\n"
     adjustAmounts (wans, mf);
<<"%V $wans\n"
    RC[_erow] = wans;
     
<<"RC[_erow]  $RC[_erow] \n"
   sWo(choicewo,@cellval,RC,0,0,Nbp,Ncols); // RecordVar, startrow, startcol, nrows, ncols,
   sWo(choicewo,@redraw);
     }
   }
}
//=========================
proc addFoodItem()
{
svar wans;
     wans = RC[_erow];
     
    sz= Caz(R)
<<"in $_proc record $rows $sz\n"
    er = Nrows;

    R[er] = wans;

    rows++;
    Nrows++;
    sz = Caz(R);
    
  <<"%V $sz $rows $Nrows\n"

//   <<"New size %V $rows $cols $sz\n";   // increase ??
  
   sWo(cellwo,@setrowscols,rows+1,cols+1);
   sWo(cellwo,@selectrows,0,rows-1);
    // swap prev last and this row
   swaprow_a = er;
   swaprow_b = er-1;
   
   SWOPROWS();

//   totalRows();

   sWo(cellwo,@cellval,R,0,0,Nrows,cols);
   setRowColSizes()

//sWo(cellwo,@redraw);
// sWo(cellwo,@cellval,R,0,0,rows,cols);
// sWo(cellwo,@redraw);

}
//=======================

proc HowMuch(int wr, int wc)
{
 <<"%V $wr $wc\n"
   mans = popamenu("Howlong.m")
        if (!(mans @= "NULL_CHOICE")) {
//	<<"%V $mans\n"
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//



proc getCellValue(int r, int c)
{
     if (r >0 && c >= 0 ) {
           cvalue = R[r][c];
       mans = popamenu("Quantity.m")
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,r,c,mans);
           R[r][c] = mans;
        }

     }
}
//=====================
proc setFoodName( int r, int c)
{
 
     if (r >0 && c == 0 ) {
           cvalue = R[r][c];
           newcvalue = queryw("NewFood","xxx",cvalue,_ex,_ey);
	   newcvalue = supper(newcvalue);
           sWo(cellwo,@cellval,r,c,newcvalue);
           R[r][c] = newcvalue;
     }
}
//=====================