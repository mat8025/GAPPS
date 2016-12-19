///

///
/// want this to total up
/// accept,reject or multiply quantity
/// for each query
/// write to a day entry
/// 

proc queryloop()
{
str ans = "";
  while (1) {

  <<" New Query\n"
   ans = "new_query"
   ans=i_read("[n]ew,[q]uit ? :: $ans ")

  if (scmp(ans,"quit",1)) {
    break;
  }

//  ok=reload_src(1)
// <<"reload_src ? $ok \n"

  ans=i_read("food $myfood ? : ")

  if (! (ans @="") ) {
    myfood = ans;
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

  aans = i_read("amt %3.2f$f_amt ?: ")


if (!(aans @="") ) {
    f_amt = atof(aans);
  }

<<"%V$f_amt \n"

   fnd= checkFood();

if (fnd) {

    mf = f_amt;
    
    Wans =  Fd[Wfi]->query(mf);



   ans = iread(" [a]ccept,[r]eject , [m]ultiply ?\n");
   if (ans @= "a") {
<<[B]"$Wans \n"
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
     <<[B]"$Wans \n"
    }
   }
   }   
   
   }
 }
}
