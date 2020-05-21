//%*********************************************** 
//*  @script calcounter_adjust.asl 
//* 
//*  @comment  adjust amounts for a row
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Fri Mar 13 09:39:02 2020 
//*  @cdate Fri Jan  4 09:27:43 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


proc adjustAmounts (svar irs, float f)
{
  float a;
  int i;
<<"$_proc  $f \n$irs \n"
//  irs->info(1)

<<"$irs[::]\n";

  a = atof (irs[1]) * f;
 // a= fround(a,4)
//<<"%V$a\n";
// nfv
 // irs[1] = dewhite("%6.2f$a");
    irs[1] = "%-6.1f$a "
   for (i = 3; i < (NFV+3); i++)     {
     a = atof (irs[i]) * f;
    // a= fround(a,4)
     val = "%-6.1f$a"   // left justify this
     irs[i] = val;
//<<"<$i> $irs[i] $a $val\n"
//<<"wans $wans\n"

//irs->info(1)
    }

<<"$irs[::] \n"



}
//==================================
proc changeAmount(the_row)
{
    mans = popamenu("HowMuch.m");
    mf = atof(mans);
    
    if (mf > 0.0) {
     //wans = RC[the_row];
       wans = R[the_row];     
//wans->info(1)
//<<"%V $wans\n"
<<"Before adjust $the_row by $mf  $wans\n"

     adjustAmounts (wans, mf);

<<"after adjust $the_row by $mf  $wans\n"

     R[the_row] = wans;
     
<<"row $R[the_row]\n"

     totalRows();
     
//     sWo(cellwo,@cellval,R,0,0,Nrows,cols);
     sWo(cellwo,@cellval,R);
     
     sWo(cellwo,@redraw);

<<"row $R[the_row]\n"

        displayTotals();

<<"$R\n"

   }
}

//=====================================//
