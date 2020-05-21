//%*********************************************** 
//*  @script calcounter_totals.asl 
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



proc totalRows()
{
//
// last row  should contain previous totals
//
<<"running $_proc \n"

  float fc[26];  // cals,carbs,fat,prt,chol,sfat,txt
  int kc = 0;
  int fi = 3;
  float fval;
  float nval;
  int nfvals = 0;
  str wrs ="xx";
  nr= Caz(R);
  
//<<"%V $Nrows $rows $nr\n"
//<<"R[0] $R[0] \n"

frows = Nrows-1;   // Nrows title row + food itme rows
  

//<<"$R[0][::]\n"
//<<"$R[1][::]\n"
//<<"%V $frows  $R[frows][0]\n"
//fc->info(1)

   nrows_counted =0;

  for (j = 1; j <= frows ; j++) {

     fi = 3;

//  <<"R<$j> $R[j]\n"
  
   nc = Caz(R,j);
   if (nc >5) {
   nfvals++;

   for (kc = 0; kc < NFV  ; kc++) {
//<<"%V$kc $j $fi  $R[j][fi] \n"
           wrs = dewhite(R[j][fi]);
	   
	    if (wrs @= "") { 
//<<"$kc empty field\n"
//wrs->info(1)
                 break;
            }

	    fval = atof(wrs);
//wrs->info(1)
//fval->info(1)
//<<"%V $wrs $fval \n"
//ans=iread(":")

           fc[kc] += fval;

//<<"<$j> fc[${kc}] $fi $fval $R[j][fi] $fc[kc]\n"

	  fi++;
      }
      nrows_counted++;
    }
    }

   j = frows;
   
<<"total rows $nrows_counted $frows \n"

   Tot[1][0] = "#Totals";
   Tot[1][1] = "$nfvals";
   Tot[1][2] = "ITMS";
   Tot[1][27] = "0.0";

//   R->info(1)
tot_rows = Caz(Tot)
tot_cols = Caz(Tot,0)
//<<"%V $tot_rows $tot_cols \n"
   for (kc = 0; kc < NFV  ; kc++) {

          nval = fc[kc];
       // R[j][3+kc] = dewhite("%6.2f$fc[kc]");  // TBF

          Tot[1][3+kc] = "%-6.3f$nval";

//<<"$kc  $Tot[0][3+kc] $nval \n"	  

//	  rval = R[j][3+kc];
//       
    }


<<"done totals\n $Tot\n"
tot_rows = Caz(Tot)
tot_cols = Caz(Tot,1)
<<"%V $tot_rows $tot_cols \n"
//<<"$R\n"

}
//===================================


proc displayTotals()
{

  sWo(totalswo,@selectrowscols,0,1,0,29);
  sWo(totalswo,@setcolsize,FOODCOLSZ,0,1) ;
  sWo(totalswo,@setcolsize,2,3,1) ;  
  sWo(totalswo,@cellval,Tot);

<<"redrawing $totalswo %V$Tot\n"
  sWo(totalswo,@border,@clipborder,@redraw);  

}
//==================================
