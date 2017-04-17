///

///
/// want this to total up
/// accept,reject or multiply quantity
/// for each query
/// write to a day entry
/// 

#define MAXFREC 50

Record R[MAXFREC];

int Rn = 0;

float Cal_tot = 0;
Carb_tot = 0.0;     

proc readDD( ddfn)
{

// found previous list
// read in lines and add to record
//
//  check for comment - else read and set food record item
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
}
//==================================
proc writeDD()
{
  B= ofile(the_day,"w")
  <<[B]"#Food                  Amt Unit Cals Carbs Fat Protein Chol(mg) SatFat Wt\n"
  
 for (ir =0; ir < Rn; ir++) {
  if (!scmp(R[ir][0],"#",1)) {
  <<[B]"$R[ir][0], $R[ir][1], $R[ir][2], $R[ir][3], $R[ir][4],  $R[ir][5], $R[ir][6], $R[ir][7], $R[ir][8], $R[ir][9],\n";
  //<<[B]"$R[ir]\n";
  }
 }
  computeTotals();
 <<[B]"#totals %V%4.1f$Cal_tot $Carb_tot\n"
  cf(B)
}
//==================================
proc computeTotals()
{
     Cal_tot = 0;
     Carb_tot = 0;     
   for (ir =0; ir < Rn; ir++) { 
      Cal_tot += atof(R[ir][3]);
      Carb_tot += atof(R[ir][4]);      
     }
}
//==================================

proc queryloop()
{
///
/// loopquery
/// 
int ret = 0;

str ans = "";

while (1) {

  <<" New Query\n"
   ans = "new_query"
   ans=i_read("[n]ew,[l]ist,[q]uit ? :: $ans ")

  if (scmp(ans,"quit",1)) {
  
   if (ret) {
     writeDD();  // update?
  
   }

   break;
  }

  if (scmp(ans,"list",1)) {
     Cal_tot = 0;
     Carb_tot = 0;     

   for (ir =0; ir < Rn; ir++) {
   //DBG record print --- default all or parse fields \n"
   
    <<"[$ir ] $R[ir][0] $R[ir][1] $R[ir][2] $R[ir][3] $R[ir][4]\n";
    
      Cal_tot += atof(R[ir][3]);
      Carb_tot += atof(R[ir][4]);      
     }
     <<"$(Rn+1) %V %4.1f$Cal_tot $Carb_tot\n"
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


  uans = i_read("Unit [c]up,[p]iece,[o]z,[i]tem,[s]lice :: $f_unit ?: ")

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
     R[Rn] = Split(Wans,",");
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
