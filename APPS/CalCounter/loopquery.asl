///

///
/// want this to total up
/// accept,reject or multiply quantity
/// for each query
/// write to a day entry
/// 

#define MAXFREC 50

//Record R[MAXFREC];

Record R[];

int Rn = 0;

float Cal_tot = 0;
Carb_tot = 0.0;
Fat_tot = 0.0;
Prt_tot = 0.0;
Chol_tot = 0.0;
SatF_tot = 0.0;     


proc showFitems()
{
    for (ir =0; ir < Rn; ir++) {
   //DBG record print --- default all or parse fields \n"
   
    <<"[$ir ] $R[ir][0] $R[ir][1] $R[ir][2] $R[ir][3] $R[ir][4]\n";
         }

     computeTotals();
     <<"Items\tCals\tCarbs(g)\tFat(g)\tPrt(g)\tChol(mg)\tSatFat(g)\n"
     <<"$(Rn+1) %4.1f\t$Cal_tot\t$Carb_tot\t\t$Fat_tot\t$Prt_tot\t$Chol_tot\t\t$SatF_tot\n"
}
//================================================



proc readDD( ddfn)
{
   //<<"Rsz $(Caz(R))\n"

  // R=ReadRecord(ddfn,@del,',',@comment,"",@pickstr,"@=",0,"must")
// found previous list
// read in lines and add to record
   R=ReadRecord(ddfn,@del,',') ; // reads as records all lines except those starting with #
   Rn = Caz(R);

   //<<"$Rn Rsz $(Caz(R))\n"

   R[15][0] = "more";

 //  <<"Rsz $(Caz(R))\n"
//
//  check for comment - else read and set food record item


/{/*
int maxlns = 100;
int k = 0;
     while (1) {
     k++;
     ddline = readline(ddfn,200);
     if (ferror(ddfn) == 6) {
<<" @ EOF   %v$Rn food items processsed\n"
       break;
     }

     if (scmp(ddline,"#",1)) {
<<"skip comment $ddline \n";
     }
     else {

     R[Rn] = Split(ddline,",");
<<"adding food record $Rn $ddline \n";
<<"adding food record $R[Rn] \n";     
     Rn++;
     }
     
     if (Rn >= MAXFREC) {
   <<" you should be fullup !\n"
       break;
     }
     if (k > maxlns) {
<<"file too long \n"
      break;
     }
     
    }

<<"%V $k $Rn\n"
/}*/

}
//==================================
proc writeDD()
{
  B= ofile(the_day,"w")
  <<[B]"# Food                  Amt Unit Cals Carbs Fat Protein Chol(mg) SatFat Wt\n"


<<"%(1,>>, || ,<<\n)$R[::]\n"
// replace this with writerecord
// writeRecord(B,R)
/{
 for (ir =0; ir < Rn; ir++) {
  if (!scmp(R[ir][0],"#",1)) {
  <<[B]"$R[ir][0], $R[ir][1], $R[ir][2], $R[ir][3], $R[ir][4],  $R[ir][5], $R[ir][6], $R[ir][7],$R[ir][8],$R[ir][9],\n";
  //<<[B]"$R[ir]\n";
  }
 }
 /}

//  NR = R[0:Rn];
//<<"$NR[0] $NR[::]\n"
//<<"%(1,>>, || ,<<\n)$NR[::]\n"



  writeRecord(B,R);

  computeTotals();
 <<[B]"# totals %4.1f$Cal_tot $Carb_tot $Fat_tot $Prt_tot $Chol_tot $SatF_tot\n"
  cf(B)
}
//==================================
proc computeTotals()
{
     Cal_tot = 0;
     Carb_tot = 0;
     Fat_tot = 0.0;
     Prt_tot = 0.0;
     Chol_tot = 0.0;
     SatF_tot = 0.0;               
   for (ir =0; ir < Rn; ir++) {
     ok=scmp(R[ir][0],"#",1);
    if (!scmp(R[ir][0],"#",1)) {
    //<<"adding rec $ir $ok\n"
      Cal_tot += atof(R[ir][3]);
      Carb_tot += atof(R[ir][4]);
      Fat_tot += atof(R[ir][5]);
      Prt_tot += atof(R[ir][6]);
      Chol_tot += atof(R[ir][7]);
      SatF_tot += atof(R[ir][8]);                        
      }
     }
}
//==================================

proc queryloop()
{
///
/// loopquery
/// 
int ret = 0;
int reck = -1;
str ans = "";

while (1) {

  <<" New Query\n"
   ans = "new_query"
   ans=i_read("[n]ew,[l]ist,[d]elete,[s]ave,[q]uit ? :: $ans ")

  if (scmp(ans,"save",1)) {
  
  // if (ret) {
     writeDD();  // update?
  // }

   continue;
  }

  if (scmp(ans,"delete",1)) {

      wrec = "-1";
      <<"%V$wrec $ans $Rn $(Rn-1)\n";
      //tans = i_read("?");
      //<<"%V$tans\n" ;
      
      //wrec=i_read("delete which record? 0 - $(Rn-1), :: $wrec");
      maxrecn = Rn -1;
     wrec=i_read( "delete a record 0 $maxrecn  :: number ? ");

      <<"%V$wrec $ans $Rn $(Rn-1)\n";      
      reck = atoi(wrec);
      <<"%V$wrec $ans $Rn $(Rn-1) $reck\n";
      <<" $(typeof(wrec)) $(typeof(reck))\n"

      if (reck >= 0 & reck <=Rn) {
      <<"comment out record $reck\n";
         R[reck][0] ="#";
      }
      ret = 1; // update
   continue;
  }

  if (scmp(ans,"qy",2)) {
       break;
  }

  if (scmp(ans,"quit",1)) {
     ans="no";
     ans=i_read("need to save changes first?! -really quit ? [y]es :: $ans ");
    if (scmp(ans,"yes",1)) {
     break;
    }
  }


  if (scmp(ans,"list",1)) {

      showFitems();
//       <<"$Rn Rsz $(Caz(R))\n"

     continue;
  }



//  ok=reload_src(1)
// <<"reload_src ? $ok \n"

  ans=i_read("food $myfood ? : ")

  if (scmp(ans,"quit",4)) {
    break;
  }

  if (! (ans @="") ) {
    myfood = ans;
  }


  cookans=i_read("cook method/extra description [f]ried, [b]oiled, [r]aw $cookans ? : ")
  x_desc = "raw";
  if (! (cookans @="") ) {
    if (cookans @="f"){
       x_desc = "fried";        
    }
    if (cookans @="b"){
       x_desc = "boiled";        
    }    
    else {
       x_desc = cookans
    }
      myfood = scat(myfood,",$x_desc");
  }


  uans = i_read("Unit [c]up,[t]spn,[b]tbsp,[p]iece,[o]z,[i]tem,[s]lice :: $f_unit ?: ")

  if (!(uans @="")) {
    if (uans @="c"){
       f_unit = "cup";        
    }
    else if (uans @="p"){
       f_unit = "piece";        
    }
    else if (uans @="i"){
       f_unit = "itm";        
    }
    else if (uans @="t"){
       f_unit = "tsp";        
    }
    else if (uans @="b"){
       f_unit = "tbsp";        
    }        
    else if (uans @="o"){
       f_unit = "oz";        
    }
    else if (uans @="s"){
       f_unit = "slice";        
    }            
    else {
      f_unit = uans;
    }
  }

    f_amt = 1.0;
/{
//  aans = i_read("amt %3.2f$f_amt ?: ")
if (!(aans @="") ) {
<<"should be scalar!! %V $f_amt $aans\n"    
    f_amt = atof(aans);
    <<"should be scalar!! %V $f_amt\n"    
  }
/}

<<"%V$f_amt \n"

   fnd= checkFood();

if (fnd) {

    float mf = 1.0;
    
    mf = f_amt;
//    <<"should be scalar!! %V $f_amt\n"
//    <<"should be scalar! %V $mf \n"
    
    Wans =  Fd[Wfi]->query(mf);

    ans = iread(" [a]ccept,[r]eject , [m]ultiply ?\n");
    if (ans @= "a") {

//<<[B]"$Wans \n"
       <<"adding @ $Rn Rsz $(Caz(R))\n"
     R[Rn] = Split(Wans,",");
     <<"added @ $Rn Rsz $(Caz(R))\n"
     Rn++;

     ret = 1;
  }

   if (ans @= "m") {
   
   ans =iread("adjust by ? factor\n")
   mf = atof(ans);
   <<"adjust by $mf $(typeof(mf)) $(Caz(mf)) \n"
   
   if (mf > 0) {
   Wans =  Fd[Wfi]->query(mf);
   <<"$Wans\n"
     ans = iread(" [a]ccept,[r]eject\n");
     if (ans @= "a") {
    // <<[B]"$Wans \n"
       <<"adding @ $Rn Rsz $(Caz(R))\n"
     R[Rn] = Split(Wans,",");
     Rn++;
     ret = 1;
   }
   }
   }   
   }
 }
 return ret;
}
