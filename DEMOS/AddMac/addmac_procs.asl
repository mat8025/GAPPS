//%*********************************************** 
//*  @script addmac_procs.asl 
//* 
//*  @comment procs for addmac 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Thu Oct  3 05:03:10 2019 
//*  @cdate Thu Oct  3 05:03:10 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///
///
///

proc getAddMacValue( r, c)
{
 
     if (r >0 && c >= 0 ) {
 <<" %V $r $c \n";
           cvalue = R[r][c];
// <<" %V $cvalue \n";

           newcvalue = queryw("NewValue","xxx",cvalue,_ex,_ey);
<<"%V$newcvalue \n"
           sWo(cellwo,@cellval,r,c,newcvalue);
           R[r][c] = newcvalue;
     }
}
//=====================


proc addMacTotal()
{
 CheckTotal = 0.0
 for (k= 1; k < rows; k++) {

   cash = atof(R[k][1]);
   cash = Fround(cash,2);
   R[k][1] = "%7.2f$cash";
   CheckTotal += atof(R[k][1]);
  //  <<"$k  $cash $R[k]\n"
 }

 CheckTotal = Fround(CheckTotal,2);
<<" %V$CheckTotal\n"
 sWo(totalwo,@value,CheckTotal);
 
}

///////////////////////////////////////////////

proc AddItem()
{
<<"ADDITEM %V $rows $cols $(Caz(R))\n"
 
  
  R[rows][0] = "Item_$rows"
  R[rows][1] = "00.00"
  R[rows][2] = "?"
  
  <<" $R[rows] \n"
 
  sWo(cellwo,@setrowscols,rows+3,cols+1); 
  sWo(cellwo,@cellval,R,0,0,rows,cols);
  
  sWo(cellwo,@selectrowscols,0,rows,0,cols);
  sWo(cellwo,@cellval,rows,0,"Item_$rows");
  sWo(cellwo,@cellval,rows,1,"0.0");  
  sWo(cellwo,@redraw);
  rows++;
   Rn = rows;
}
