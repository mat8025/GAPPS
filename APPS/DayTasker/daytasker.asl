/////////////////////////////////////////////////////////////
///  daytasker
///
///
///  add tasks to Record structure
///  description pc_done time_taken  tstart1 tstop1 tstart2 tstop2 ...

setdebug(1) ;


Record R[100];

int Rn = 0;


proc addtask()
{

  tans=i_read("task description :: ")
  ans ="a";
  ans = i_read("$tans :: [a]ccept,[r]eject ? $ans ")
  if (scmp(ans,"a",1)) {
  R[Rn][0] = tans;
  R[Rn][1] = "0";
  
  Rn++;
 }


}


proc listtasks()
{

<<"current tasks\n"
   svar S
   for (ir =0; ir < Rn; ir++) { 
//    <<"[$ir ] $R[ir]\n";
    S= R[ir];
      <<"[$ir ] $S\n";
   }

}

//=========================

proc edit_tasks()
{

<<"edit tasks\n"
  wted=i_read("edit task $Rn ? :: ")
  tn = atoi(wted);
  <<"[$tn ] $R[tn] \n"
  pced=i_read("pc done? 0-100  :: ")
  pcd = atof(pced)
  R[tn][1] = "%4.2f$pcd"
  <<"[$tn ] $R[tn] \n"

}

//======================

proc quit()
{

<<"$_proc   --- saving!\n"

 fseek(B,0,0)
 <<[B]"# task desc, pc done, time-taken, tstart1, tstop1, tstart2, tstop2, ...\n"
 <<[B]"#\n"
   svar S;
  // str s;
   for (ir =0; ir < Rn; ir++) {
   // <<"$R[ir][0],$R[ir][1]\n"
   // s= R[ir];
   // <<"s: $s\n"
    S= R[ir]
    <<"S: $S\n"
   //<<[B]"$R[ir]\n";  // should be comma del
 //  <<[B]"%(20,,\,,\n)$S\n"
   <<[B]"%(10, ,\,,\n)$S"
   }
 
 cf(B);

 exit();
}

//======================

/// main loop


///////// dt_log_file ////////////

 ds= date(2)
 ds=ssub(ds,"/","-",0)

 ok=fexist("dt_${ds}",0);
<<"$ok dt_${ds}\n"

 if (ok >0) {
 
 B= ofile("dt_${ds}","r+")
 

 res = readline(B)
    <<"$res\n"
   //svar res;
  // res = "";
// read each entry into Record
 
     while (1) {
       res = readline(B)
    //   <<"$res\n"
        if (f_error(B) == EOF_ERROR_) {
	   break;
	}
       if ((slen(res)) > 1 && !scmp(res,"#",1)) {
 <<"$res\n"
        R[Rn] = Split(res,",");
        Rn++;
        if (Rn > 100) {
           break;
        }
	}
     }
 }
 else {

   B= ofw("dt_${ds}")
 }

  if (Rn > 0) {
      listtasks()
  }


   while (1) {

     ans = i_read("[a]add, [l]ist, [e]dit , [q]uit? ")

     if (scmp(ans,"a",1)) {
          addtask()
     }
     else if (scmp(ans,"l",1)) {
          listtasks()
     }
     else if (scmp(ans,"e",1)) {
          edit_tasks()
     }
     else if (scmp(ans,"q",1)) {
          quit()
     }          


   }