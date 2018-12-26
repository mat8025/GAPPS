///
///
///


setdebug(1,@keep,@trace)

proc xtotalRows()
{
//
// last row  should contain previous totals
//

<<"$_proc \n"

  float fc[10];  // cals,carbs,fat,prt,chol,sfat,txt
  int kc = 0;
  int fi = 3;
  float fval;
  nr= Caz(R);
  
<<"%V $Nrows $rows $nr\n"

  frows = Nrows-1;
<<"$R[0][::]\n"
<<"$R[1][::]\n"
<<"%V $frows  $R[frows][0]\n"

  tword = deWhite(R[frows][0]);
  
  if (!strcasecmp(tword, "totals")) {

   for (j = 1; j < frows ; j++) {
     fi = 3;
     for (kc = 0; kc <7  ; kc++) {

          //fc[kc] += atof(R[j][kc+3]);
          //fc[kc] += atof(R[j][fi]);
	    fval = atof(R[j][fi]);
        <<" $(Caz(fval)) \n"
         fc[kc] += fval;
	 nval = fc[kc];
        <<"%V $j $kc $fi $fval $nval $R[j][fi] $fc[kc]\n"
	  fi++;
      }
    }

   j = frows;

   R[j][0] = "Totals";
   R[j][1] = "$(j-1)";
   R[j][2] = "ITMS";

    for (kc = 0; kc < 7  ; kc++) {
        nval = fc[kc];
       // R[j][3+kc] = dewhite("%6.2f$fc[kc]");  // TBF
          R[j][3+kc]= "%6.2f$nval";
       <<"%V $kc $nval $fc[kc] \n"
    }
   // kc = 0;
  //  R[j][3] = dewhite("%6.2f$fc[0]");

   <<"$R[j][::]\n"

//     sWo(cellwo,@cellval,R,0,0,Nrows,cols);
//     sWo(cellwo,@redraw);
   }
}
//=====================


Record R[10];

proc totalRows()
{

  float fc[10];  // cals,carbs,fat,prt,chol,sfat,txt
  int kc = 0;
  float nval = 0;
  float fval = 34;
frows = 3;
 for (j = 1; j < frows ; j++) {
     fi = 3;
     for (kc = 0; kc <7  ; kc++) {
           frval = j * kc *0.5;
           R[j][fi] = "$frval";
          //fc[kc] += atof(R[j][kc+3]);
          //fc[kc] += atof(R[j][fi]);
            fval = atof(R[j][fi]);
    	    //fval = j * kc *0.5;
       <<" $(Caz(fval)) \n"
         fc[kc] += fval;
         
	 nval = fc[kc];
        <<"%V $j $kc $fi $frval $fval $nval  $fc[kc]\n"
	  fi++;
      }
    }
<<"%V $fc[::]\n"
}





  float mfc[10];  // cals,carbs,fat,prt,chol,sfat,txt
  int kc = 0;

mfrows = 3;
for (j = 1; j < mfrows ; j++) {
     fi = 3;
     for (kc = 0; kc <7  ; kc++) {
           frval = j * kc *0.5;
           R[j][fi] = "$frval";
          //fc[kc] += atof(R[j][kc+3]);
          //fc[kc] += atof(R[j][fi]);
            fval = atof(R[j][fi]);
    	    //fval = j * kc *0.5;
       <<" $(Caz(fval)) \n"
         mfc[kc] += fval;
	 nval = mfc[kc];
        <<"%V $j $kc $fi $frval $fval $nval  $mfc[kc]\n"
	  fi++;
      }
    }

<<"%V $mfc[::]\n"



//   totalRows()






 Record T[10];

  str W= Split("0,1,2,3,4,5,6,7,8,9",",")

 T[0] = W;

<<"%V$T[0] \n"

<<"%V$T[0][1] \n"

  V= T[0][1];
<<"%V$V\n"
  V14= T[0][1:4]
<<"%V$V14\n"


<<"%V$T[0][2] \n"

<<"%V$T[0][2:5] \n"




   T[1] = T[0];
<<"$T[1] \n"

   T[2:5] = W;  // TBF  should allow subscript setting of record



   //T[6][::] = W;

  T[6] = W[0:4:];


<<"$T[::] \n"

   S= W[0:4];

<<"$W[0:4] \n"

<<"%V $S\n"

<<"$T[0:1][0:4] \n"
//===========================//

<<"  INT VEC SET/GET \n"
 int IV[];

  IV = atoi(W); // TBF XIC

<<"%V$IV\n"

  IG = vgen(INT_,10,0,1);

  <<"%V$IG[3:7]\n"

  IV2 = IG[2:7]

<<"%V$IV2\n"

 IV2[0:2] = IG[7:9]

<<"%V$IV2\n"