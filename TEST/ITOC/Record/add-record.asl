///
///
///

setmaxicerrors(-1)
setmaxcodeerrors(-1)

include "debug"
debugON()
sdb(2,@~pline)

proc totalRows()
{
//
// last row  should contain previous totals
//
<<"running $_proc \n"

  float fc[NFV];  // cals,carbs,fat,prt,chol,sfat,txt
  int kc = 0;
  int fi = 3;
  float fval;
  float nval;
  int nfvals = 0;
  str wrs ="xx";
  nr= Caz(R);
  
<<"%V $Nrows $rows $nr\n"
//<<"R[0] $R[0] \n"

  frows = Nrows-1;   // Nrows title row + food item rows
  

//<<"$R[0][::]\n"
//<<"$R[1][::]\n"
//<<"%V $frows  $R[frows][0]\n"
//fc->info(1)

   nrows_counted =0;
 // frows = 4;
  for (j = 1; j <= frows ; j++) {

     fi = 3;

    nc = Caz(R,j);

 // <<"R<$j> <$nc> $R[j]\n"
  
   
   
   if (nc >5) {

    nfvals++;

   for (kc = 0; kc < (nc-3)  ; kc++) {
           fval = 0.0;
           wrs = dewhite(R[j][fi]);

	    if (wrs @= "") { 
<<"$kc empty field\n"
//
                 break;
            }

//wrs->info(1)

	    fval = atof(wrs);
	    
//<<"$kc $j $fi  $R[j][fi] <|$wrs|> fval $fval\n"	   

//wrs->info(1)
//fval->info(1)
//<<"%V $wrs $fval \n"
//ans=iread(":")

           fc[kc] += fval;
           //cval = fc[kc]
          // fc[kc] =  cval + fval;

//<<"<$j> fc[${kc}] $fi $fval $R[j][fi] $fc[kc]\n"

	  fi++;
      }
      nrows_counted++;
    }
    }
    

   j = frows;
   
<<"total rows %V $nrows_counted $frows \n"

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


//    R->info(1)
<<"done total %V $tot_rows $tot_cols \n"    
//<<"$R\n"

}
//===================================


proc addFoodItem(svar wfd, int wr)
{

    sz= Caz(R)
// find first empty? row
//   R->info(1)

    er = -1;
   //er = wr;

  
    for (i=1; i < Nrows; i++) {
    wval = Dewhite(R[i][0]);
//<<"$i <$wval>\n"
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


//   wfd->info(1)
//   R->info(1)
<<"in $_proc record $rows row $er\n"
    // TBF wvd shoud not be PTR type! - but ARGPTR
    R[er] = wfd;
<<"%V $wfd\n"

<<"%V $R[er]\n"
//    R->info(1)
    sz = Caz(R);

<<"%V $sz $rows $Nrows\n"

//  for (k=0; k < Nrows ;k++) {
//<<"$k $R[k]\n"
//  }

<<"$R\n"
<<"after add row \n"
//<<"b4 setrowcols\n"


   //sWo(cellwo,@setrowscols,Nrows,cols+1);
   //sWo(cellwo,@selectrowscols,0,Nrows-1,0,cols-1);


//<<"b4 totalRows\n"


//   totalRows();

   //setRowColSizes()

<<"after adding %V $er $rows $Nrows $cols\n"

  //sWo(cellwo,@cellval,R,0,0,rows+1,cols);
//   R->info(1)
//<<"b4 cellval\n"

 // sWo(cellwo,@cellval,R);
 // sWo(cellwo,@redraw);
  
// <<"%V$totalswo \n"
// <<"%V $cols\n"
//   R->info(1)
//<<"b4 displayTotals\n"
//   displayTotals()
//<<"$Tot \n"
  // color_foodlog();
}
//=======================



int NFV = 24;// last is Zn

record FF[>10];

A=  ofr("foods-breakfast.csv");


  FF= readRecord(A,@del,',')
  cf(A);  

  Nfav =  Caz(FF);
  for (i=0;i<Nfav;i++) {
<<"$i $FF[i]\n"
 }

//~b  ; // break here

//exit()




record R[>10];
 R[0]= Split("Food,Amt,Unit,Cals,Carbs(g),Fat,Prot,Choles(mg),SatFat(g),Wt(g),Choline(mg),vA(dv),vC,vB1Th,vB2Rb,vB3Ni,vB5Pa,vB6,vB9Fo,B12,vE,vK,Ca,Fe,Na,K,Zn,GMT,Tags,",",");



  
  sz = Caz(R);
  Nrows = sz;
  
  Ncols = Caz(R,0);
  rows = sz;
  cols = Ncols;
<<"num of records $sz  %V $rows $Ncols\n"

<<"$R\n"
//  for (k=0; k < Nrows ;k++) {
//<<"$k $R[k]\n"
//  }

record Tot[2];

Tot[0]= Split("#FoodT,NF,ITM,Cals,Carbs,Fat,Prot,Choles,SatFat,Wt,Choline,vA,vC,vB1Th,vB2Rb,vB3Ni,vB5Pa,vB6,vB9Fo,B12,vE,vK,Ca,Fe,Na,K,Zn,",",");
tot_rows = Caz(Tot)
tot_cols = Caz(Tot,0)
<<"%V $tot_rows $tot_cols \n"


svar wans;

arow = 0;

	 wans = FF[arow]
<<"ADDDING %V$arow  $wans \n"
	 wans->info(1)
         R[1] = wans
<<"$R"
proc foodEaten()
{
 for (k= 0; k < 7 ; k++) {
  <<"$k $R[k][0] \n"
  <<"$k 1 $R[k][1] \n"
  <<"$k 1 $R[k][3] \n"
  }
}



    j= 1

//   foodEaten();

         wans = FF[j]
         addFoodItem(wans,j++) ; // and save

	 wans = FF[j]
	 addFoodItem(wans,j++) ; // and save
   //foodEaten();
      wans = FF[j]
      addFoodItem(wans,j++) ; // and save
   
	 wans = FF[j]
         addFoodItem(wans,j++) ; // and save

         wans = FF[j]
         addFoodItem(wans,j++) ; // and save

         wans = FF[j]
         addFoodItem(wans,j++) ; // and save

         wans = FF[j]
         addFoodItem(wans,j++) ; 

<<"$j foods added\n"

<<"$R"
 totalRows();
<<"$Tot \n"

<<"$R"
//foodEaten();

exit()
