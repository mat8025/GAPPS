/////////////////////////////////////////////////////////////
///  daytotal
///
///  looks for a day -- default current
///  and totals food entries
///
///   guesses wt gain/loss
///
setdebug(1)

record R[20];

int Rn = 0;

 ds=date(2)

// find the day --- current or supplied


na =argc()
if (na > 1) {

 ds = _clarg[1]
}



 ds=ssub(ds,"/","-",0)

 ok=fexist("dd_${ds}",0)

 found_day = 0;
 if (ok >0) {
// open file
 <<" found dd file $ds \n"
 B= ofile("dd_${ds}","r+")
 //fseek(B,0,2);
 found_day = 1;
 }
 else {
  <<"can't find dd file for the day $ds\n"
  <<"dates should be in mm-dd-yyyy format\n"
  exit()
 }

    res = readline(B)
    <<"$res\n"
   //svar res;
  // res = "";
// read each entry into Record
  if (found_day) {
     while (1) {
       res = readline(B)
    //   <<"$Rn $res\n"
        if (f_error(B) == EOF_ERROR_) {
	   break;
	}
        R[Rn] = Split(res,",");
        Rn++;
        if (Rn > 10) {
           break;
        }
     }
  }



//Rn =5;
     cal_tot = 0;
     carb_tot = 0;
     fat_tot = 0.0
     for (ir =0; ir < Rn; ir++) { 
    <<"[$ir ] $R[ir]\n";
      cal_tot += atoi(R[ir][3]);
      carb_tot += atoi(R[ir][4]);
      fat_tot += atof(R[ir][5]);            
     }
     <<"$(Rn+1) %V$cal_tot $carb_tot %6.2f$fat_tot\n"



//  do the totals


//  guess the wt gain/loss


//

